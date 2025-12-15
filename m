Return-Path: <netdev+bounces-244699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5C8CBD0EA
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 09:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5842D3021F30
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 08:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6517C3314DF;
	Mon, 15 Dec 2025 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YuR3P3qB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ncLZa0YG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1119C331235
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788460; cv=none; b=nqWvTWp0oHRE6Eu4a9QU4gFatwwbpzt12PqmKFiZInlj4QM0LiFTE5U9FcDo9cUWJ6EdvGMVEEFiIEfWqrwxmqpJgzakOTOo9ZEIuT1EohpKWy/MdZqM+VbdlsbrskOk+2JSZlj2VjAOEDa4Hj35nZcBy4RJDeAhumq+vckW7P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788460; c=relaxed/simple;
	bh=QQj71iTpNQbUjBt4wJHOULftg+2TgRbezKFnuGqjqEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXGfOs/5ITkXVrnhehWQI2ZIvmdX6SfJOORFpghR9g5L9DRtR8G3G950M9MN8l5xJ2zqX4tmnGpO33Q3fmVP1W1sNM0G4BO24RsV52J/fSk/ye7FkbQXvGRE/LRln1XHu7lO2mTSqxdR0l6IsC2lGCHmfEAc3DihQEIs0Oo/umo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YuR3P3qB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ncLZa0YG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765788456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y8c1bSyPyB+D2oaZrmhZupMOh1hpTpUHotjWVq9ffFw=;
	b=YuR3P3qB7TNmfMueplHIzwufINVYsdRImPLokt7FiKlFfJUSJoP0a45Wid3/IVcTDvYYcl
	do8hkc4cM8zG96t17AZmU9BuzOw75jPP7zwPgI2aol1xUKQMvv2Dqa18RoAFOQDAyTv+FO
	LryoRXXycmoxoT2DR37KVfOj5gzjyLc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-t2JCriCRNi2OfLbJnY9sjA-1; Mon, 15 Dec 2025 03:41:16 -0500
X-MC-Unique: t2JCriCRNi2OfLbJnY9sjA-1
X-Mimecast-MFC-AGG-ID: t2JCriCRNi2OfLbJnY9sjA_1765788075
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b763b24f223so450204566b.0
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 00:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765788075; x=1766392875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8c1bSyPyB+D2oaZrmhZupMOh1hpTpUHotjWVq9ffFw=;
        b=ncLZa0YGc2U0kBfqvfiyC2DoucsZ5GIfeVX9QXPIPeIlEYUoT8LzsrBzwtKXyaZD71
         S5zp34iLoaeDlnsLjccgDQIagRUkeD9vZAT+3BWyCeNYbCuWAGjnUSZETT2XSI2h77FQ
         wph8vlaCImaQSninW2nL35hfaDNa3l+o4ar4sxJemmgoJvdZvuDdGczGJvzQJiu43Kxa
         NL61UJpvzGys96GQsntueIwhcGnMJhUXunEwZppxWyiZCYn49egcQL0zB6GG0UmYMMXc
         T0Z7unl2aunjtJ40Rb9SJ9z/KsN8zyVVNnuF0sbCqvTdBCHRzeybgpS1OQG0d6lnLVdy
         O2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765788075; x=1766392875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y8c1bSyPyB+D2oaZrmhZupMOh1hpTpUHotjWVq9ffFw=;
        b=LY96FSpnooo/fyh/jpT87x26cSRQ5BaRyxLKO+mrQ9Xq3ugrHxFA76O2NLA1ptvv57
         NDwSyIdUsdhJNnNaVvpmoQN2B9mh8hLmBjHrlPwsXrQjs9jRoIymiLYwlSwB+qdYrXu/
         9VDaY4zR7saIlZNm7I4XGg4YFQ7qZ27N1PXtUxneUVjFXANOFk6FfsJyucX5Wfg0dOQw
         M86pkVR4e0K5DojUlPOnSeCY/GmiiuOnaSZmbJ9wshg2VByd0qCTiUYh+cc/Dq03QXCq
         sL5SsvAiqL6tZFPQrdqHlSMtv0uYLVR1xI+trZwnpzYOLQ+bRY1cdemGdcuPNBxmcd+W
         JLjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGIzTFkZ1SeDQgZxcxBwR5JfJl2RzUaj6f3e5R2Fs+JtkNaaEbNGKXCTb0wAOvgwV0VHcwz6c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxypa2reN6GYjJl17tUdNalLX6WfPBcV69biup5mCQ1bt40CTyv
	V3F9foX4lEbY3WZWd5/+odbulDRjpf/0MkB0ywG5jxOBZvlqq3oLVtKiVhjsp7QICOxX1iqRmos
	CAXLwQFJ7DhPhQfp7ecSatx0FXavc4eKRC3bmolQN5ARtB9XkJRPzTae0zw==
X-Gm-Gg: AY/fxX6K9q+kHC/NlR0lr7/uewZ1Dx/FNLRC91ce/GOg02igKsNOmG0zZhgNg5w40wb
	RZNqnD/U/MsUoY+cUFv0g9tXZtKSKpDuAUMJlGj8jPZN5uHpoEA7gWvbdsyBaXmwydwTWGF3PzY
	oU/i9reG/sjIa44SusWrQRkr0nCJuGZPXYUzrj2mqAoVbdKbEajdb00BTYLVmEBnCpK8hqhjtAu
	jMkXXbPDGo9k7zK0uYY58/UWtl4Osi/zO/GQHddlDCMVOu3x0HPtBhWjI7gegHCl/r/g6ARO3vC
	fvbohkHJIsFZw5vl9ENYItRUK/xhhC+4PlC9G2YRVKT4ztmodA2HtW26LfM5i1544BIHpVsaZkd
	tyXbpd+tyDHDfFoPpDwt2CHCtINFmCNINrk+YnYZSB8XDmF3qII1eXbpOmAY=
X-Received: by 2002:a17:907:7ea5:b0:b4a:d0cf:873f with SMTP id a640c23a62f3a-b7d238ee6d3mr1074416766b.2.1765788074815;
        Mon, 15 Dec 2025 00:41:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUJCdJPkbdk7ETRQHk0AufNeEfUYKcddsx15YhRCzuzK/7+nngNinUXBb2Fkh50O/qFbVg1A==
X-Received: by 2002:a17:907:7ea5:b0:b4a:d0cf:873f with SMTP id a640c23a62f3a-b7d238ee6d3mr1074414966b.2.1765788074405;
        Mon, 15 Dec 2025 00:41:14 -0800 (PST)
Received: from [10.44.33.154] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7fd04e5ba3sm255365566b.24.2025.12.15.00.41.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Dec 2025 00:41:13 -0800 (PST)
From: Eelco Chaudron <echaudro@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
 Adrian Moreno <amorenoz@redhat.com>
Cc: Aaron Conole <aconole@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 Alexei Starovoitov <ast@kernel.org>, Jesse Gross <jesse@nicira.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, dev@openvswitch.org
Subject: Re: [PATCH v2] net: openvswitch: Avoid needlessly taking the RTNL on
 vport destroy
Date: Mon, 15 Dec 2025 09:41:10 +0100
X-Mailer: MailMate (2.0r6290)
Message-ID: <198C2570-F384-4385-8A6B-84DCC38BB5F5@redhat.com>
In-Reply-To: <20251211115006.228876-1-toke@redhat.com>
References: <20251211115006.228876-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11 Dec 2025, at 12:50, Toke H=C3=B8iland-J=C3=B8rgensen wrote:

> The openvswitch teardown code will immediately call
> ovs_netdev_detach_dev() in response to a NETDEV_UNREGISTER notification=
=2E
> It will then start the dp_notify_work workqueue, which will later end u=
p
> calling the vport destroy() callback. This callback takes the RTNL to d=
o
> another ovs_netdev_detach_port(), which in this case is unnecessary.
> This causes extra pressure on the RTNL, in some cases leading to
> "unregister_netdevice: waiting for XX to become free" warnings on
> teardown.
>
> We can straight-forwardly avoid the extra RTNL lock acquisition by
> checking the device flags before taking the lock, and skip the locking
> altogether if the IFF_OVS_DATAPATH flag has already been unset.
>
> Fixes: b07c26511e94 ("openvswitch: fix vport-netdev unregister")
> Tested-by: Adrian Moreno <amorenoz@redhat.com>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Guess the change looks good, but I=E2=80=99m waiting for some feedback fr=
om Adrian to see if this change makes sense.
Any luck reproducing the issue it=E2=80=99s supposed to fix?

Cheers,

Eelco

> ---
> v2:
> - Expand comments explaining the logic
>
>  net/openvswitch/vport-netdev.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-net=
dev.c
> index 91a11067e458..6574f9bcdc02 100644
> --- a/net/openvswitch/vport-netdev.c
> +++ b/net/openvswitch/vport-netdev.c
> @@ -160,10 +160,19 @@ void ovs_netdev_detach_dev(struct vport *vport)
>
>  static void netdev_destroy(struct vport *vport)
>  {
> -	rtnl_lock();
> -	if (netif_is_ovs_port(vport->dev))
> -		ovs_netdev_detach_dev(vport);
> -	rtnl_unlock();
> +	/* When called from ovs_db_notify_wq() after a dp_device_event(), the=

> +	 * port has already been detached, so we can avoid taking the RTNL by=

> +	 * checking this first.
> +	 */
> +	if (netif_is_ovs_port(vport->dev)) {
> +		rtnl_lock();
> +		/* Check again while holding the lock to ensure we don't race
> +		 * with the netdev notifier and detach twice.
> +		 */
> +		if (netif_is_ovs_port(vport->dev))
> +			ovs_netdev_detach_dev(vport);
> +		rtnl_unlock();
> +	}
>
>  	call_rcu(&vport->rcu, vport_netdev_free);
>  }
> -- =

> 2.52.0


