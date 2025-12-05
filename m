Return-Path: <netdev+bounces-243681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E106CA5D54
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 02:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE056302EA35
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 01:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FCA191F84;
	Fri,  5 Dec 2025 01:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXbHxIwB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkMaMkPo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115301DA23
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764898332; cv=none; b=L4+vqoHQM2Hkxh0RzuMOUqDjUXNTEeA1zVuYej8lzfuS+nDuz2lPVY239V1e/m0dO5r/eJ3ymNDJFVa+Mz42EsDm4dgkkOVIf41WsXZJZNeaMRZMhujdQYW6dL/TxFJkYvB9gIqFOiSVXw7k0DQYnFCUEUgVjnQAmeKBapu1UZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764898332; c=relaxed/simple;
	bh=b3Ez8+yWMkGA5gpAkQt7RdpyK0iRnQzdGVgQTEK2Zmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljodgXhrCfJXLNwFQDwhrctgBs6t8efgXsREdaT9mLCVAPh6A1/r5EPOg04uDWi3DG7iHVZ241IB5J/xq6Uhw+DLVH+0+tUPZDfKIScTCJcJmoghryrALnnEPhB8nRjzYBzfiNMSdfrbAowOwGT6piGzhLvaU3jo8+l5alJwm5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VXbHxIwB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HkMaMkPo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764898330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0dsq8oFQa/VCPAZZwGy/bUQxA/2aYZc+HS65+giLRpM=;
	b=VXbHxIwBqp8RD8SIsXJG9oPQoMJs365uogzwSRXQVCZH3EVopYLAEZw/h4+p6dV8sNSZVm
	pOwS/2d4LR61iyAosXRE+MPOedtaGb6MCxNtPqknr/VuMWvbAk5N+6pLotlBMBSV56uoUO
	pHH2uIAS5xSSjS8vnVHXyBe3hqHDRNU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-i3vrtcdQN1aPoBaLdfyWsg-1; Thu, 04 Dec 2025 20:32:08 -0500
X-MC-Unique: i3vrtcdQN1aPoBaLdfyWsg-1
X-Mimecast-MFC-AGG-ID: i3vrtcdQN1aPoBaLdfyWsg_1764898327
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34188ba5990so3711667a91.0
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 17:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764898327; x=1765503127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dsq8oFQa/VCPAZZwGy/bUQxA/2aYZc+HS65+giLRpM=;
        b=HkMaMkPo6Y3tivdLLcw5ndraendKoHwAzZ00TauOmCKCR3Yc6bWYQ7l9D+pjSH7A4D
         HtepKZxCHbjwoIWS5bmT+Ebj55Ym+T3BXMXmE/w5XWH3pOulrs6NLHpoE4dc4w0vkm+y
         NpQ+fWS6CIdxrokmEPT/IxWEWlrS8DC8qg9pKnseWcQEjXFRKZbA6XTUW25o8FGD1C3+
         cgGWACswGgCtgiQ9cYZuyuJ4DOMoCoE6KSW284Oui3XiCEYnbxkn4HcN66c4euDWjtOT
         PEx0PwFcIAv4dde2i1YEKrj5ezWJfNYRrZBf9vSB/yg28e1jU8U31LwQ07qicKNfG5wv
         NGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764898327; x=1765503127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0dsq8oFQa/VCPAZZwGy/bUQxA/2aYZc+HS65+giLRpM=;
        b=Gh48UjnAK4Mq8BbtJ2zxrNDwg8S1VHU10lPrTdXS4+9qkn6Fizv2N5VZNmJN/sw56P
         Prrsd6hlO3k/mambUxj6F0B3kHvoSwYPkL9wcLuXku27kqtXNclh4dvjWUyRnxHEHbv4
         +Jy4ZkcmaDWM4kq1x0wJqwOzIVZbDjA0iESt/ArbR8aiab8CToDDSDQ6HR0KyqrQ5mk4
         9uEsc5WTAkcqhS66PyIEQLBY8qZZwur5uJi3PYb8ZPBYN+3DcBLltugr8vHofQxjOnII
         xuJZFODv12JcfUawt74W0Y2r7RUaoUgKbOKEez97syxKn0irW8T9m2f4RH4RxrwNS20x
         eJJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQpiNcImUHvAx9iBBv5iKPaDXOOorVU5CExXZ5BiujTTbxQ6dW+9rEQ69DjXdqFOhP4yW+uHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTeG+2rmyDYFN55eDguy7VSrEd+DHmuvvWLjtRZB5+V+Dtisn5
	gSe2bilh8n474BGUqJhMayz4ykVMXcrg8jl8AlaYrrrYe3HDD3zVNBxR5wn7hT7V9Mq5mYpOw4p
	S0Yin8c6pv4jtXt2bk9m2OTCHiFc+gDoxAc404p+jreR0pnv3A4EqqGIJxXEw0UWnwlVB8DHTA/
	4tDm4WfgUfPZPM+bn6VbnEnZ3+EYNzg/HD
X-Gm-Gg: ASbGncueGJnBKvFZLdPLAjvtCk8PGWWFwbRzl8WVl2A9i+S3WcU3x1tDvdYVRd8io62
	9kaSN3hlQ9+vJku1+s9mW8pYhh5xqisnOoluRZLpw+WhJQdS1Bkod1RTZRgTb5oXC6yIjbb+IRi
	9PKb4uokOH5aqbagElMpOU2IYqC4fCtueLcg+V4ibvIilVU2muO2FvO2J72rK8UenZCg==
X-Received: by 2002:a17:90b:2784:b0:340:dd2c:a3f5 with SMTP id 98e67ed59e1d1-34947b5ffbfmr5314767a91.3.1764898327392;
        Thu, 04 Dec 2025 17:32:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZVUUVrZNrU9zy5VVS63ijjPseuKARttg+oAzFaelLxvIi3gh6iAM+h+okddgsxpg98PrIp9rap3jAvrqXnNY=
X-Received: by 2002:a17:90b:2784:b0:340:dd2c:a3f5 with SMTP id
 98e67ed59e1d1-34947b5ffbfmr5314736a91.3.1764898326948; Thu, 04 Dec 2025
 17:32:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <40af2b73239850e7bf1a81abb71ee99f1b563b9c.1764226734.git.mst@redhat.com>
 <a61dc7ee-d00b-41b4-b6fd-8a5152c3eae3@gmail.com> <CACGkMEuJFVUDQ7SKt93mCVkbDHxK+A74Bs9URpdGR+0mtjxmAg@mail.gmail.com>
 <a9718b11-76d5-4228-9256-6a4dee90c302@gmail.com> <CACGkMEvFzYiRNxMdJ9xNPcZmotY-9pD+bfF4BD5z+HnaAt1zug@mail.gmail.com>
 <faad67c7-8b25-4516-ab37-3b154ee4d0cf@gmail.com> <CACGkMEtpARauj6GSZu+iY3Lx=c+rq_C019r4E-eisx2mujB6=A@mail.gmail.com>
 <eabd665c-b14d-4281-9307-2348791d3a77@gmail.com>
In-Reply-To: <eabd665c-b14d-4281-9307-2348791d3a77@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 5 Dec 2025 09:31:55 +0800
X-Gm-Features: AWmQ_blh1owa4VZkxcTchqi8uqZ8bw7WQqwN7uDSrgQCemeKCLZrFSD0qqwYA5A
Message-ID: <CACGkMEtJ-jErjFQgBcEPVeUo4rHejTZ0cuCCVzHSjzk8S80W5A@mail.gmail.com>
Subject: Re: [PATCH RFC] virtio_net: gate delayed refill scheduling
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 11:08=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> On 12/3/25 13:37, Jason Wang wrote:
> > On Tue, Dec 2, 2025 at 11:29=E2=80=AFPM Bui Quang Minh <minhquangbui99@=
gmail.com> wrote:
> >> On 12/2/25 13:03, Jason Wang wrote:
> >>> On Mon, Dec 1, 2025 at 11:04=E2=80=AFPM Bui Quang Minh <minhquangbui9=
9@gmail.com> wrote:
> >>>> On 11/28/25 09:20, Jason Wang wrote:
> >>>>> On Fri, Nov 28, 2025 at 1:47=E2=80=AFAM Bui Quang Minh <minhquangbu=
i99@gmail.com> wrote:
> >>>>>> I think the the requeue in refill_work is not the problem here. In
> >>>>>> virtnet_rx_pause[_all](), we use cancel_work_sync() which is safe =
to
> >>>>>> use "even if the work re-queues itself". AFAICS, cancel_work_sync(=
)
> >>>>>> will disable work -> flush work -> enable again. So if the work re=
queue
> >>>>>> itself in flush work, the requeue will fail because the work is al=
ready
> >>>>>> disabled.
> >>>>> Right.
> >>>>>
> >>>>>> I think what triggers the deadlock here is a bug in
> >>>>>> virtnet_rx_resume_all(). virtnet_rx_resume_all() calls to
> >>>>>> __virtnet_rx_resume() which calls napi_enable() and may schedule
> >>>>>> refill. It schedules the refill work right after napi_enable the f=
irst
> >>>>>> receive queue. The correct way must be napi_enable all receive que=
ues
> >>>>>> before scheduling refill work.
> >>>>> So what you meant is that the napi_disable() is called for a queue
> >>>>> whose NAPI has been disabled?
> >>>>>
> >>>>> cpu0] enable_delayed_refill()
> >>>>> cpu0] napi_enable(queue0)
> >>>>> cpu0] schedule_delayed_work(&vi->refill)
> >>>>> cpu1] napi_disable(queue0)
> >>>>> cpu1] napi_enable(queue0)
> >>>>> cpu1] napi_disable(queue1)
> >>>>>
> >>>>> In this case cpu1 waits forever while holding the netdev lock. This
> >>>>> looks like a bug since the netdev_lock 413f0271f3966 ("net: protect
> >>>>> NAPI enablement with netdev_lock()")?
> >>>> Yes, I've tried to fix it in 4bc12818b363 ("virtio-net: disable dela=
yed
> >>>> refill when pausing rx"), but it has flaws.
> >>> I wonder if a simplified version is just restoring the behaviour
> >>> before 413f0271f3966 by using napi_enable_locked() but maybe I miss
> >>> something.
> >> As far as I understand, before 413f0271f3966 ("net: protect NAPI
> >> enablement with netdev_lock()"), the napi is protected by the
> > I guess you meant napi enable/disable actually.
> >
> >> rtnl_lock(). But in the refill_work, we don't acquire the rtnl_lock(),
> > Any reason we need to hold rtnl_lock() there?
>
> Correct me if I'm wrong here. Before 413f0271f3966 ("net: protect NAPI
> enablement with netdev_lock()"), napi_disable and napi_enable are not
> safe to be called concurrently.
>
> The example race is
>
> napi_disable -> napi_save_config -> write to n->config->defer_hard_irqs
> napi_enable -> napi_restore_config -> read n->config->defer_hard_irqs
>
> In refill_work, we don't hold any locks so the race scenario can happen.

Ok, I get you, so it occurs after we introduced the NAPI config to virtio-n=
et.

>
> Maybe I misunderstand what you mean by restoring the behavior before
> 413f0271f3966. Do you mean that we use this pattern
>
>      In virtnet_xdp_se;
>
>      netdev_lock(dev);
>      virtnet_rx_pause_all()
>          -> napi_disable_locked
>
>      virtnet_rx_resume_all()
>          -> napi_disable_locked
>      netdev_unlock(dev);
>
> And in other places where we pause the rx too. It will hold the
> netdev_lock during the time napi is disabled so that even when
> refill_work happens concurrently, napi_disable cannot acquire the
> netdev_lock and gets stuck inside.

It might work but I think it would be easy to either

1) use locked version everywhere

or

2) use the unlocked version everywhere

Mix using locked and unlocked may cause the code hard to be maintained

Thanks

>
>
> >
> >> so it seems like we will have race condition before 413f0271f3966 ("ne=
t:
> >> protect NAPI enablement with netdev_lock()").
> >>
> >> Thanks,
> >> Quang Minh.
> >>
> > Thanks
> >
>
> Thanks,
> Quang Minh.
>


