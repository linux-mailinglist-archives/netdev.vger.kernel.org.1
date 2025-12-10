Return-Path: <netdev+bounces-244268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B87CB366D
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 16:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A16343031BBD
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 15:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8E02DF146;
	Wed, 10 Dec 2025 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5tKt/aQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZA/4W+QI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AEE2D5A14
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765382389; cv=none; b=iJcej8+RZz71iPfBpYyYtk6fOyGeZuBeBjWacISCiwiRhafbnnsfmiVhZxkCal6kDpXJaSdEvldoZjE4g46DFn2VDe3RmsCt70KJkUmpX7Ak3vDivQ9fW/WeSbbDdsKYuKgCmevd3xhUQ2yM8pPvXIr/L5uAQkoQfZdf4uDgoVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765382389; c=relaxed/simple;
	bh=Nb4TiPAxX+U5W5UX58qk2wmqgLpyYsUYBYrbnMHaxrc=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brFvpoFIQyLXZEHDP6bYEBFBbAszxduMIMcJAS6jL5SPu/CpYZicUrQgv2HHiKGrL9Yic2v6e9PsEpohQhISLmGolCbcjX64CxSCKDQP/Hh9lxBzwMtQYkpzQKChUfJpz+MtSyEMzQBUPSnrhCR0J77bilzQ1FQZ+HzMKkNyaPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X5tKt/aQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZA/4W+QI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765382370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6BCxIgtS+P0LVmAgfuJ5zo3t7v0eJqX9T1YVoa8u/NE=;
	b=X5tKt/aQWhR2Z6R9l3u0IbtNq3RFOGSCTE/iryajX7028c269aOQQEqHJbS8Qm8JvfHkpm
	jVCOKCa1NtsEwlLphwkGMIwXHphAz94dINxSKwXLc7PFvn+kjYxtwCNiYmF7p3rytb3TyO
	L9PKbFcC+s6daKus7uC8tYtT3CxlLLQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-EqTAVKuVPZuKMDoTZsAEFw-1; Wed, 10 Dec 2025 10:59:28 -0500
X-MC-Unique: EqTAVKuVPZuKMDoTZsAEFw-1
X-Mimecast-MFC-AGG-ID: EqTAVKuVPZuKMDoTZsAEFw_1765382368
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b7a7049e202so7917966b.1
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 07:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765382367; x=1765987167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BCxIgtS+P0LVmAgfuJ5zo3t7v0eJqX9T1YVoa8u/NE=;
        b=ZA/4W+QIImTsqY03ON+CfohJlFNhYyzH4JUZZBJdjNvOa0MDuHrpnSPBSpnGcNHWzh
         BAs4excr/ek1TzaKpKHFYNhkJYhVNT9kcJP8EAVwYekEd/hg8F8309q+I9g3f/qJ4bP7
         viO0cvfb31R2HO8QJ78sDwX8M5kqCZ6cWFDZlbTf7gd7tzWaBKiT4T2AiuJEe8p9RC/D
         pqcjlUuniVqNOT/pT8NLs8j9kW0gLvS0pd2EcqBTq7+ilFeG3m09jA7jp6dwB0hVUhN0
         6MTNm6UVrnX5M2Ze8FKntfzFsBW4gS7ZH/0wPJPzE2x814S0dLMlUQqqXKgKf7vBIdw/
         99qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765382367; x=1765987167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BCxIgtS+P0LVmAgfuJ5zo3t7v0eJqX9T1YVoa8u/NE=;
        b=da9PUKyJM29WhzyjRhv6bfum0988lR1cr/s3eX8ZY+8NivWcUaBzXO/Dpy+4dhLvMo
         7xuaJnOPYBvVh0SCNO11uFvCWset+tOFxefHG3fTfWbPGzwyIdJWVmmQPcXycbywGgK1
         15sdkJX0GKR7AZt6+ajUokPMreVrlHv+3VLEbf3SybWNPp8c96ekjmj7hNO8nrvB+DaF
         Mp5UwHpcGpF5XdZukpZ/fwLSVXcd6prMhdgBqGKmPLEOnMOZofsnl7nRW09EJPIfFCtb
         IJzKWDW5IsA788rhbjiQfryTpZzhG0/jPbXgLKmVAAqMBop015X1QW+gwSYvf9I3HEKT
         Mzsw==
X-Forwarded-Encrypted: i=1; AJvYcCVk9fxEIxImlIo0qtgjBsgaGvr+hfQcFlqywyYwN0Dop/9LPjzzCHu2ZBnrqGI654QEz6nV6nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRLyBalY0deMniqP37jo/Xfe4KnCh2CRCeMNAxNIjDv9AoM99k
	klOS0wabdm8BuwRrLcBLIVsiA/zkjtCzVhN1Cty92aUcwRpsaJ92xXQ/Th/fMihxmrrRdK1A4oY
	3GkjwMh4XhFKmvLdQhWbmYYCWEntLBFDS7sH4dx8uNXJWF0dlaZCzlsg44HJ/2yJeZNb8E6xCWS
	WMd/rQu5PRkLa/QBKnKe8asi+4FbfByN48
X-Gm-Gg: AY/fxX5ANu5Wu5PgrxMGOHce7uj6Li9p1h6+olXinmjdb1IIkRI5buDK5fLLxaYXhGf
	jj8X8ZOCYHQbsc/L3PiiEEN+bQo6GhQjwM+cHx2//abfG0CTYU1mOqit9yFXvRtOJPNiUrh85j1
	tjgkYGldbpyuBNuePAxzd7ovX2E1GeT5z7WsTu4qrp+KN04ljsVGnFistHdYyAQlV1hSiq
X-Received: by 2002:a17:907:608c:b0:b76:f090:777b with SMTP id a640c23a62f3a-b7ce82dd99dmr300265466b.22.1765382367410;
        Wed, 10 Dec 2025 07:59:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbdwwqPY0QY1I4OqhrJNwYkIZOnVU3uY1ia28mbhf5UH85NQ4Wbu+FEVlxJp/VMJQHfc0fBwngvMblGAjwl+U=
X-Received: by 2002:a17:907:608c:b0:b76:f090:777b with SMTP id
 a640c23a62f3a-b7ce82dd99dmr300261166b.22.1765382366874; Wed, 10 Dec 2025
 07:59:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Dec 2025 16:59:25 +0100
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Dec 2025 16:59:25 +0100
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20251210125945.211350-1-toke@redhat.com> <B299AD16-8511-41B7-A36A-25B911AEEBF4@redhat.com>
 <CAG=2xmOib02j-fwoKtCYgrovdE3FZkW__hiE=v0PuGkGzJvvBQ@mail.gmail.com> <7C74F561-F12F-4683-9D99-0A086D098938@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7C74F561-F12F-4683-9D99-0A086D098938@redhat.com>
Date: Wed, 10 Dec 2025 16:59:25 +0100
X-Gm-Features: AQt7F2ry1935K9WjGBRHskzyBNuqTuDYSt2gHeDs29LVhAX0Uu3ZZyceNO_uz1g
Message-ID: <CAG=2xmPCYdYBk9zc9EHt2dmGUBuXJHqnMLByac17UHOqSt2CFw@mail.gmail.com>
Subject: Re: [PATCH net] net: openvswitch: Avoid needlessly taking the RTNL on
 vport destroy
To: Eelco Chaudron <echaudro@redhat.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Aaron Conole <aconole@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	Alexei Starovoitov <ast@kernel.org>, Jesse Gross <jesse@nicira.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, dev@openvswitch.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 04:30:13PM +0100, Eelco Chaudron wrote:
>
>
> On 10 Dec 2025, at 16:12, Adri=C3=A1n Moreno wrote:
>
> > On Wed, Dec 10, 2025 at 02:28:36PM +0100, Eelco Chaudron wrote:
> >>
> >>
> >> On 10 Dec 2025, at 13:59, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >>
> >>> The openvswitch teardown code will immediately call
> >>> ovs_netdev_detach_dev() in response to a NETDEV_UNREGISTER notificati=
on.
> >>> It will then start the dp_notify_work workqueue, which will later end=
 up
> >>> calling the vport destroy() callback. This callback takes the RTNL to=
 do
> >>> another ovs_netdev_detach_port(), which in this case is unnecessary.
> >>> This causes extra pressure on the RTNL, in some cases leading to
> >>> "unregister_netdevice: waiting for XX to become free" warnings on
> >>> teardown.
> >>>
> >>> We can straight-forwardly avoid the extra RTNL lock acquisition by
> >>> checking the device flags before taking the lock, and skip the lockin=
g
> >>> altogether if the IFF_OVS_DATAPATH flag has already been unset.
> >>>
> >>> Fixes: b07c26511e94 ("openvswitch: fix vport-netdev unregister")
> >>> Tested-by: Adrian Moreno <amorenoz@redhat.com>
> >>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> >>> ---
> >>>  net/openvswitch/vport-netdev.c | 11 +++++++----
> >>>  1 file changed, 7 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-n=
etdev.c
> >>> index 91a11067e458..519f038526f9 100644
> >>> --- a/net/openvswitch/vport-netdev.c
> >>> +++ b/net/openvswitch/vport-netdev.c
> >>> @@ -160,10 +160,13 @@ void ovs_netdev_detach_dev(struct vport *vport)
> >>>
> >>>  static void netdev_destroy(struct vport *vport)
> >>>  {
> >>> -	rtnl_lock();
> >>> -	if (netif_is_ovs_port(vport->dev))
> >>> -		ovs_netdev_detach_dev(vport);
> >>> -	rtnl_unlock();
> >>> +	if (netif_is_ovs_port(vport->dev)) {
> >>
> >> Hi Toke,
> >>
> >> Thanks for digging into this!
> >>
> >> The patch looks technically correct to me, but maybe we should add a c=
omment here explaining why we can do it this way, i.e., why we can call net=
if_is_ovs_port() without the lock.
> >> For example:
> >>
> >> /* We can avoid taking the rtnl lock as the IFF_OVS_DATAPATH flag is s=
et/cleared in either netdev_create()/netdev_destroy(), which are both calle=
d under the global ovs_lock(). */
> >>
> >> Additionally, I think the second netif_is_ovs_port() under the rtnl lo=
ck is not required due to the above.
> >
> > In the case of netdevs being unregistered outside of OVS, the
> > ovs_dp_device_notifier gets called which then runs
> > "ovs_netdev_detach_dev" only under RTNL. Locking ovs_lock() in that
> > callback would be problematic since the rest of the OVS code assumes
> > ovs_lock is nested outside of RTNL.
> >
> > So this could race with a ovs_vport_cmd_del AFAICS.
>
> Not fully sure I understand the code path you are referring to, but if it=
=E2=80=99s through ovs_dp_notify_wq()->dp_detach_port_notify()->ovs_dp_deta=
ch_port(), it takes the ovs_lock().

The codepath described by Toke is:
(netdev gets unregistered outside of OVS) ->
dp_device_event (under RTNL) -> ovs_netdev_detach_dev()
(IFF_OVS_DATAPATH is cleared)

Then dp_notify_work is scheduled and it does what you mention:
ovs_dp_notify_wq (lock ovs_mutex) -> dp_detach_port_notify -> ovs_dp_detach=
_port
    -> ovs_vport_del -> netdev_destroy (at this point
netif_is_ovs_port is false)

The first part of this codepath (NETDEV_UNREGISTER notification) happens
under RTNL, not under ovs_mutex and it manipulates vport->dev->priv_flags.

So in theory we could receive the netdev notification while we process a
ovs_vport_cmd_del() command from userspace, which also ends up calling
netdev_destroy.

>
> By the way: in your testing, did you see the expected improvement, i.e., =
no more =E2=80=9Cunregister=E2=80=9D delays?

I did see a reduction in the use of RTNL, which is obvious. I have not
been able to reproduce the "unregister_netdevice: waiting ..." spat yet.

In such a high RTNL-contented scenario, I still don't know how much that
extra rtnl_lock is slowing things up or whether the optimization will be
enough to reduce the spat in all cases, I guess not.

I will try simulating the contention with delay-kfunc.

What I have tried is some manual concurrent manipulation of netdevs and
also ran the OVS kernel unit tests.

Thanks.
Adri=C3=A1n

>
> //Eelco
>
> >>
> >>> +		rtnl_lock();
> >>> +		/* check again while holding the lock */
> >>> +		if (netif_is_ovs_port(vport->dev))
> >>> +			ovs_netdev_detach_dev(vport);
> >>> +		rtnl_unlock();
> >>> +	}
> >>>
> >>>  	call_rcu(&vport->rcu, vport_netdev_free);
> >>>  }
> >>> --
> >>> 2.52.0
> >>
>


