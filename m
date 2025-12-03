Return-Path: <netdev+bounces-243362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD4DC9DF00
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 07:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 345744E123B
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 06:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E796B2882B6;
	Wed,  3 Dec 2025 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgFAF7So";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvN64lw4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EAC2798EA
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 06:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764743871; cv=none; b=o/Tq2bq/t1U+cmRcwD5P13DHhrotunBv49HD3wOl002tJeRqCImnta1UsCu5P0pLDF7H4RdKmXjVnXRaCyOoF8qRPw6d91Eeb67AG8a1cybRKQdINdHqcSfid/S+cz0Ln9FlXykaLgV2H32XRVfERqsvJHqsqAX/k/eAeaZOr8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764743871; c=relaxed/simple;
	bh=O4Mqyo+EasSGEMJDDUtsnmU6xTLK8lObIMr5IEY+sT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZK89IMx8mbgDpEc0ZCp22bbTsFo9PGIrGovdIuLmkwo8Yfm2SGCVizTrpeayf/JcHUSdSYy2hd6PosbtwSTbYshWpgJcDuK6s2UzjGQ/1w4s2sedIEN4eJYD2scSDda7YepzQsqPeBBI2OWk0LHteK2zqctsQOn4NCTb0NkEfCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AgFAF7So; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GvN64lw4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764743869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4Mqyo+EasSGEMJDDUtsnmU6xTLK8lObIMr5IEY+sT4=;
	b=AgFAF7So7OYQNLkkFCIAIdXlRcxQMkNgoXMbGx1Oz3mXmusfCMhU1xB03SiiwLca9Jv54v
	sbT2POMpez9xiPnHWqOMboS816o26Iw/qhJtirBc4mN8IAyog9aP2HB8sy5l8Xwra+JUI2
	A2TJPa4P6AU5Ymh5wvICG/ThNtSbjAw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-MFnLH2ATOvy-JVtyiiYwkg-1; Wed, 03 Dec 2025 01:37:47 -0500
X-MC-Unique: MFnLH2ATOvy-JVtyiiYwkg-1
X-Mimecast-MFC-AGG-ID: MFnLH2ATOvy-JVtyiiYwkg_1764743866
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34377900dbcso12649357a91.2
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 22:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764743866; x=1765348666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4Mqyo+EasSGEMJDDUtsnmU6xTLK8lObIMr5IEY+sT4=;
        b=GvN64lw42wcvTz/IBZ5nsdJePJzqRAa7j4b9Hp5Cu2zUpptdYCD3Y+lCN7qYqQZU5V
         YtVSrFTKCJd5pHpmujn3xnXtU37tPEgPyBovSQeig0ELUCsWtI1gphLI0lxm2A65wF1+
         VFHVLl4mJ6PKFaBlqzzWGq+TPm30t8E4MqXTiMURFfqCqDr5c8J/+LTRO9+24MEfJLOL
         nG4ORIETqoCbzpzriuLcnoXE4E7C2ywBQUIziC48mpVzK4qlZx5/GtduDcwbqcxbBag1
         0wgn6K8Ol7vejeP0negtx/7kPh6hibpDgKcq81JLYmW4zDZOFivNYsYqEfROEtZXeqvL
         pUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764743866; x=1765348666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O4Mqyo+EasSGEMJDDUtsnmU6xTLK8lObIMr5IEY+sT4=;
        b=XbyH9J+QDU6TI10jeIf7BA+HQvA4WSao26LFymchODX54ymyyfzFxx0+1MbMs2Fiid
         KTiN4JkzLLitjJY7T5+xozFuymfKfdMSresGIDBKKfqWHCcYUx+Bgkv9A1CBUg6RQuau
         3quz4SsRi9phXiFFbNCVDh3QYq9sVgvXMKHm6HtyiPgWFQNYXXracwx6SG7F+1fFfbH3
         hmJUq8gDajujj3DJU64Q78F0KYIC2Vj8vJc/LP6P4u5gEAggXf5yalzSuwq90WnFxy0C
         qxMBO4tf7sU7evHF028mRrD5XCTqYqQGBJEGE3xMT3l6Hzfi7wDJ+tXS0pImPspTarra
         JAbA==
X-Forwarded-Encrypted: i=1; AJvYcCXPQM9GnDrhEMj7vroKtl6/ejYSTWIkhPl4BjJ1eTIUT+TEcMiGGWIJ+HQ058p130F4O9ddyh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNLrz/H5tA3RtrSVwBa+KLc1m+PGiZAG/EWsYGe12SdeQ7fVKl
	Z40sjjK9wEuBkB/IzFl4m/mpel60fgOL9WL6ZeFALDIPcN9HPv9Q4+gzghyQMKcGpQ4KcUWpJOo
	fQrsMappE9c3Gjzqt76LgpD1DX2+4sL6jTWGWjhojeFraIuYNPD3kfswXDTtd1k8xWjn/Gyd4b8
	Vkwpl91VWH/2sxKDLB/wWy1UGPnBPa8fkP
X-Gm-Gg: ASbGncurx7jR2ZOEJYEW7Z2Pf9Jy/4nRsTXe0iJGBBluAaK0lf5gZbvRf8DAm2JqTCf
	bGzdYkPYahP9Ms9XNboR+F1YHnaPbplLGQbuA7ujuBqdaClHB6ZnKguPpkYo2/m1/cM/VER9whD
	jZ93ngDxNl6v0Ci2287tORoZx1DJSKONDoHc5Ffqh1CuNvzmYJ/i9irZc8xsEeSfaiTJE=
X-Received: by 2002:a17:90b:5650:b0:340:6f9c:b25b with SMTP id 98e67ed59e1d1-349125d6593mr1635391a91.11.1764743866517;
        Tue, 02 Dec 2025 22:37:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+xdt7PEyPzuHNnBwBChvY24bFyfsmyuXp5lNaySKumRxifcPTyltl0/liDbmTgaHwv0MK02doUKCGnc4tojs=
X-Received: by 2002:a17:90b:5650:b0:340:6f9c:b25b with SMTP id
 98e67ed59e1d1-349125d6593mr1635376a91.11.1764743866137; Tue, 02 Dec 2025
 22:37:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <40af2b73239850e7bf1a81abb71ee99f1b563b9c.1764226734.git.mst@redhat.com>
 <a61dc7ee-d00b-41b4-b6fd-8a5152c3eae3@gmail.com> <CACGkMEuJFVUDQ7SKt93mCVkbDHxK+A74Bs9URpdGR+0mtjxmAg@mail.gmail.com>
 <a9718b11-76d5-4228-9256-6a4dee90c302@gmail.com> <CACGkMEvFzYiRNxMdJ9xNPcZmotY-9pD+bfF4BD5z+HnaAt1zug@mail.gmail.com>
 <faad67c7-8b25-4516-ab37-3b154ee4d0cf@gmail.com>
In-Reply-To: <faad67c7-8b25-4516-ab37-3b154ee4d0cf@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 3 Dec 2025 14:37:35 +0800
X-Gm-Features: AWmQ_bkVgLsNrOAEQYTB19WsdD8Rk9oPWDewEzxRUfPjehmGqau5KEy4xD62Gok
Message-ID: <CACGkMEtpARauj6GSZu+iY3Lx=c+rq_C019r4E-eisx2mujB6=A@mail.gmail.com>
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

On Tue, Dec 2, 2025 at 11:29=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> On 12/2/25 13:03, Jason Wang wrote:
> > On Mon, Dec 1, 2025 at 11:04=E2=80=AFPM Bui Quang Minh <minhquangbui99@=
gmail.com> wrote:
> >> On 11/28/25 09:20, Jason Wang wrote:
> >>> On Fri, Nov 28, 2025 at 1:47=E2=80=AFAM Bui Quang Minh <minhquangbui9=
9@gmail.com> wrote:
> >>>> I think the the requeue in refill_work is not the problem here. In
> >>>> virtnet_rx_pause[_all](), we use cancel_work_sync() which is safe to
> >>>> use "even if the work re-queues itself". AFAICS, cancel_work_sync()
> >>>> will disable work -> flush work -> enable again. So if the work requ=
eue
> >>>> itself in flush work, the requeue will fail because the work is alre=
ady
> >>>> disabled.
> >>> Right.
> >>>
> >>>> I think what triggers the deadlock here is a bug in
> >>>> virtnet_rx_resume_all(). virtnet_rx_resume_all() calls to
> >>>> __virtnet_rx_resume() which calls napi_enable() and may schedule
> >>>> refill. It schedules the refill work right after napi_enable the fir=
st
> >>>> receive queue. The correct way must be napi_enable all receive queue=
s
> >>>> before scheduling refill work.
> >>> So what you meant is that the napi_disable() is called for a queue
> >>> whose NAPI has been disabled?
> >>>
> >>> cpu0] enable_delayed_refill()
> >>> cpu0] napi_enable(queue0)
> >>> cpu0] schedule_delayed_work(&vi->refill)
> >>> cpu1] napi_disable(queue0)
> >>> cpu1] napi_enable(queue0)
> >>> cpu1] napi_disable(queue1)
> >>>
> >>> In this case cpu1 waits forever while holding the netdev lock. This
> >>> looks like a bug since the netdev_lock 413f0271f3966 ("net: protect
> >>> NAPI enablement with netdev_lock()")?
> >> Yes, I've tried to fix it in 4bc12818b363 ("virtio-net: disable delaye=
d
> >> refill when pausing rx"), but it has flaws.
> > I wonder if a simplified version is just restoring the behaviour
> > before 413f0271f3966 by using napi_enable_locked() but maybe I miss
> > something.
>
> As far as I understand, before 413f0271f3966 ("net: protect NAPI
> enablement with netdev_lock()"), the napi is protected by the

I guess you meant napi enable/disable actually.

> rtnl_lock(). But in the refill_work, we don't acquire the rtnl_lock(),

Any reason we need to hold rtnl_lock() there?

> so it seems like we will have race condition before 413f0271f3966 ("net:
> protect NAPI enablement with netdev_lock()").
>
> Thanks,
> Quang Minh.
>

Thanks


