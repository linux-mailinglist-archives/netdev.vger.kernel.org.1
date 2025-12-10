Return-Path: <netdev+bounces-244262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B15CB3446
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 16:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBC68307016B
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 15:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AC33112DC;
	Wed, 10 Dec 2025 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlmW24uN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6j4ZOiv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6619C30E82B
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765379545; cv=none; b=snmMcjcvYyRaVxglhNKj2JbPrrRxd48GVGIy9Z8qWJY2Qv20D5gRjOipNh5GyndG8otdKgg4PzUHbjk8wUausZbQn7FlKpdb/M6p/CSoPC6GJTRg6CeUKCuT0YsnF83DIgGUazGnVr3iTogoQy7P3dllYG1+HKSPYKUM2i/oxFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765379545; c=relaxed/simple;
	bh=nQlvFRMtH/ZaTduVrLZld6dgjJFbeHRc244UysOhWo8=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdtIEVkeq3lCanGFI9/xZ4XRrHNG7jChrVTxQ/8heroOiUV6N8DJUJdsWwyGfkwjHxXiyXrqLuT9wB131zeyn6GXhJF8wv6yN2U6aS0Er0uaI3jmLjizllyjFEJaxOq96efmFkbNB27wnyQX/n7Q56j2tO3lYcTbIBKavUJxBsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IlmW24uN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T6j4ZOiv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765379542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V//4HIY0Gx0fBATV2wTGOO3Eee5QDSKBU7upagd4R3c=;
	b=IlmW24uNhAoqdoYGsByXZp5uxfNO47alUBKfeUKyiSVqtrVitNqxprbEOrHuD1WHzb8gDY
	fPLPMO1Qh2dBv4b76EEAc+YElOAv/kTHV4/a2bnGQHseIv6sdPA2bvp0nE7xaQGA080ExE
	MGgwyUYrp46JmgVUQOjBD8dCdrY4oqg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-mHAlzTukOTqRdEwh1XPDlQ-1; Wed, 10 Dec 2025 10:12:19 -0500
X-MC-Unique: mHAlzTukOTqRdEwh1XPDlQ-1
X-Mimecast-MFC-AGG-ID: mHAlzTukOTqRdEwh1XPDlQ_1765379539
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b7ce2f26824so118765566b.1
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 07:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765379538; x=1765984338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V//4HIY0Gx0fBATV2wTGOO3Eee5QDSKBU7upagd4R3c=;
        b=T6j4ZOiv2grI2J8Mm2ekNBG1oWxNeRvKHQBSYtAr3o+U6Bhr9fzcLelmmteoEKz8Zj
         ujxe5INMOfYLwI3Mn3LL6BLM0rSO9x2nR7vzJVwHCAwVwMC6eimSPlUuo28KcTxm5MXa
         2/kUq+GxWDkRmpvV6Mq4pWM2PAuK3F0kyAHHVVJhGzNBg4KLKcwbBTVmdJE7ZaG/MKbq
         +dSXOsk79mJFhSTyyRqt3Pjo5gSgP14osaVxBkqwLZ8/kD7m/aDmK1LLqEdvZ0HhL3XF
         MsOQyyOli/SUWqBiBJP43CEI/1GcJAZ1V9Zq/wWIN83ZqlnqDfSQHIsMzRmj0X9WAmvz
         7dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765379538; x=1765984338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V//4HIY0Gx0fBATV2wTGOO3Eee5QDSKBU7upagd4R3c=;
        b=p9216QMhx4VzGnRhUBAYU9iW18clBb/Fhj3SZP62yeHcR3/io1nRzmFmySpRuq7qjF
         gLn51BNgwMm9iP2Iykgsg7K+obMxSSAENIfqsaJ/6bxKoLI36wxFEM+UK2/qWhrjehJp
         1j5E0kuaCz+Z6rsHtux6oieZ4qri9t3CTFTboYa0xarHzVv0tnLSD/MJdtSVwuDaLa8f
         kHG7tcxWeBEaoi8PAIpJwJP2RR8cDCMpGNtz15tZflNv0opA/qUat3WztXTW2cASzGc1
         /NQXVr/iITQ7/3rak8bq3+mu/M8OgGX/uf0NIjnC7Mzf+/VnQNCk98Ukkcw3Z28nuKZo
         zyTw==
X-Forwarded-Encrypted: i=1; AJvYcCVhGLU6zKAslzO+m3x0axjgmP9/TwQBHYYzczm5C1XRlIy1E0GHSXtduVfxVQJPEzzdQsGbsQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTJIwTe5ezkcqxBP0sxEymoExs7qYTxbmvBxQpeLT5Ygp8f4ly
	Dwpw1lVE7D2OBUoB5bY8RAxaemyaIcIkdPMIJdmKoa2Ht78PbkHhZeK/nw32H1BuXVGinm9d1DL
	0vCt8AbLJsN79DrlzqJsRUe56RpSHccg7iKyv/AzDJWD26WpShXK7rQRUj96lGtY+jW1lHBLt8E
	+uXr9RJhCjsSjlFCrK7ChQXQA1uVpe7Jk7
X-Gm-Gg: AY/fxX4L5JBtrlUcjyZVnnrFn4nPe6jUhTUGX96w5bhOyG+m5jP5agLiHJSLfL0yyNz
	cEJX8UNZKA1uM+6Eun9wkgQhG2RuOQfr/aZ89lbyRWTi+CbjAOd8rPKTLXfMcila5RMn8FqUvk8
	cqPIb+auwzFlYPYmYM1PeUX9DoKPxRKmL1GHE1P3aVhHQONWqrCJ41tIykDx/Z3otd07Xw
X-Received: by 2002:a17:906:b84e:b0:b79:ff8c:d9a6 with SMTP id a640c23a62f3a-b7ce84d62b7mr204723866b.33.1765379538545;
        Wed, 10 Dec 2025 07:12:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHirWYMUItYAB9w6fJsxd9XsW6FGdZCrAyV9M3x9etBeSN3OQXoRz6oQ8Aakv4yw2erUWEKD3pjF+EN+Q26Bu0=
X-Received: by 2002:a17:906:b84e:b0:b79:ff8c:d9a6 with SMTP id
 a640c23a62f3a-b7ce84d62b7mr204720766b.33.1765379538150; Wed, 10 Dec 2025
 07:12:18 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Dec 2025 07:12:16 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Dec 2025 07:12:16 -0800
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20251210125945.211350-1-toke@redhat.com> <B299AD16-8511-41B7-A36A-25B911AEEBF4@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <B299AD16-8511-41B7-A36A-25B911AEEBF4@redhat.com>
Date: Wed, 10 Dec 2025 07:12:16 -0800
X-Gm-Features: AQt7F2rRPFg-m8eTFOdkwSHDxpzztWLyhNxY74F3E9ozQhAXcXt_96A_l1PN97E
Message-ID: <CAG=2xmOib02j-fwoKtCYgrovdE3FZkW__hiE=v0PuGkGzJvvBQ@mail.gmail.com>
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

On Wed, Dec 10, 2025 at 02:28:36PM +0100, Eelco Chaudron wrote:
>
>
> On 10 Dec 2025, at 13:59, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
> > The openvswitch teardown code will immediately call
> > ovs_netdev_detach_dev() in response to a NETDEV_UNREGISTER notification=
.
> > It will then start the dp_notify_work workqueue, which will later end u=
p
> > calling the vport destroy() callback. This callback takes the RTNL to d=
o
> > another ovs_netdev_detach_port(), which in this case is unnecessary.
> > This causes extra pressure on the RTNL, in some cases leading to
> > "unregister_netdevice: waiting for XX to become free" warnings on
> > teardown.
> >
> > We can straight-forwardly avoid the extra RTNL lock acquisition by
> > checking the device flags before taking the lock, and skip the locking
> > altogether if the IFF_OVS_DATAPATH flag has already been unset.
> >
> > Fixes: b07c26511e94 ("openvswitch: fix vport-netdev unregister")
> > Tested-by: Adrian Moreno <amorenoz@redhat.com>
> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > ---
> >  net/openvswitch/vport-netdev.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-net=
dev.c
> > index 91a11067e458..519f038526f9 100644
> > --- a/net/openvswitch/vport-netdev.c
> > +++ b/net/openvswitch/vport-netdev.c
> > @@ -160,10 +160,13 @@ void ovs_netdev_detach_dev(struct vport *vport)
> >
> >  static void netdev_destroy(struct vport *vport)
> >  {
> > -	rtnl_lock();
> > -	if (netif_is_ovs_port(vport->dev))
> > -		ovs_netdev_detach_dev(vport);
> > -	rtnl_unlock();
> > +	if (netif_is_ovs_port(vport->dev)) {
>
> Hi Toke,
>
> Thanks for digging into this!
>
> The patch looks technically correct to me, but maybe we should add a comm=
ent here explaining why we can do it this way, i.e., why we can call netif_=
is_ovs_port() without the lock.
> For example:
>
> /* We can avoid taking the rtnl lock as the IFF_OVS_DATAPATH flag is set/=
cleared in either netdev_create()/netdev_destroy(), which are both called u=
nder the global ovs_lock(). */
>
> Additionally, I think the second netif_is_ovs_port() under the rtnl lock =
is not required due to the above.

In the case of netdevs being unregistered outside of OVS, the
ovs_dp_device_notifier gets called which then runs
"ovs_netdev_detach_dev" only under RTNL. Locking ovs_lock() in that
callback would be problematic since the rest of the OVS code assumes
ovs_lock is nested outside of RTNL.

So this could race with a ovs_vport_cmd_del AFAICS.

Adri=C3=A1n

>
> > +		rtnl_lock();
> > +		/* check again while holding the lock */
> > +		if (netif_is_ovs_port(vport->dev))
> > +			ovs_netdev_detach_dev(vport);
> > +		rtnl_unlock();
> > +	}
> >
> >  	call_rcu(&vport->rcu, vport_netdev_free);
> >  }
> > --
> > 2.52.0
>


