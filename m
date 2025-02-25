Return-Path: <netdev+bounces-169421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D617FA43D19
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 12:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9C13BD887
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854FC2686AD;
	Tue, 25 Feb 2025 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="GhDBSjHS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72423207E03
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481532; cv=none; b=S9jo8nNJzn/ghFQu1tQ0EAh4Al0hii+hAE9FGSYevYbf6CsGGoaJbM+tEd/OhC74ZjPCiHwAkwtzQBc0sq3nq8ApvGY3utGjlR93ZukXCbWRAW1tNKOAsH9L1mtFrqHgzjujj3abQnI6DseMdxYrU3bpYOFDwYazR+hE19m62aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481532; c=relaxed/simple;
	bh=aEXBdctr5lNL6y49esuCSJvaeiXkXyVBBu5rr2gf1mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lohzXJmei0Dd94ApaGu1wWbSTB8rBt+zE0SywUrCHoInKOzQ/6RtYrLd0N6gBcVpmMzm5m6CRc07yhVtNKbhU4cbTTTojGzF8bYj19lQFdswKp7zPAxWdSdJ9KWRxJBVUWuy7nXt9D2EcyrImcv7zoiQq+Xn+7Ws6EDryYPDxAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=GhDBSjHS; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f504f087eso4287684f8f.1
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 03:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740481528; x=1741086328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oijdNUsjFcALDUXEJZ3Jn2gl36QQtJ0DV7NEsfpNP/g=;
        b=GhDBSjHSCNCvn8PhfCXLlDQ+odAZA6EQrlW/wyslfhO1BhEIYRi95Q0pJM24xtU8Gr
         oKxu6k+wd+pLiUAagGoICEy0HMvf/1zXUOJgaPDfPD4oU8NRa72/2UMwGjPQz7lgIbON
         sN9BwFehjZRyqrQ7BOwPxHt5Ihdi6vFFySZ3TfkcDztcxWEpVqdznov39sSNa9boeDYy
         FwUUTf8XKdKGKkSEKe3HIU13hDeG3oB48r32R+WA/ujtwNJ9EPelDDHhxjvOIo5h1/2R
         8/mM8CUjHRE5pLRnD5KqxhZhxSUvN52PQAXrauMXHwaIP0lOszW78BeGQg14hY/TblWE
         Hufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481528; x=1741086328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oijdNUsjFcALDUXEJZ3Jn2gl36QQtJ0DV7NEsfpNP/g=;
        b=hDPvlOPczRCTI6TZqw7rpVLE4Ur0ztr16G/7Qp4UdcH+0KzaR5F/HnR54w4McjWsUM
         4kAg2RP4ymPDI7gmlEgdQrUuqRwdJ2sUSaQ0yYbKzSVWGnwz2PvZlAoxEQHOZ+iphAvu
         fvZxp4+qIZYx9gQ1kqR0Gm7H7YxuIdfOL4zi1QGqAwuhYmSfw+X86WOVrikL4ksy53yY
         jsBBzTydVxqk8oXEtl+bE8ZIPqeHVjk/zpkqFLAT6ZauwKJdDRd0XZvq58p4mWVmMR9o
         Rd/1azDnG6TC2dHHmlLRPMxw/qH48YmX+3kd14sneoa4tXEO85hto8sX9oww0ZFoDsGo
         KJXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQptckbjgcnqSbFFGJIbY4NFzVr7TuvCOGmWs30fzuw+GWdmS9WaUJ4efGQtQrbFevkklJ/jI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoYnbRCVm5m4L0xyVNbgViWF3Gk9P6jsWMMbGUZ01539baxVtA
	8ETovtJU+Tev49Ur5fGWG1gSLDREtibNC5o27L1Q/mEaWabj8+OtKSByd8E6YxU=
X-Gm-Gg: ASbGncsq0drwoW4rCtOzVdY0T4qejROdf1swlPyyJcph5sXMpqh8S98Hlybtj2pVEyz
	D9+Sb/+sy8b1J+lCX6Q4zcTEKfdBeIL0j6zniCo+esM9PFCnxnPW0sczXFsgXXRoVFLFYY8oUxR
	IIzvx4ZzmGNb9sfq/eHMZYU1+02yES+E8DoA7tgPVmHbtVPrkPATNPC9mR2FvrkhMBmjWUUiXWS
	FpzocezYbb9p2H/sPgbpx+TaJS6sTX9c45GZX1UvMQnEgCiOTIm4CMjcYmQd9SSNB8p8CQ2KCDO
	RCCa7QTzZIeqVKfcuMCx/XXBloHgLu+5q2cQwur1y5eDW6bJTe186NRRwQ==
X-Google-Smtp-Source: AGHT+IG2xH9B5u1dDk4QWKBV/GBsT+RYSX6ctwfXsQLP5EsocYKyv24QKv5mom87WEbHTozESZO4yg==
X-Received: by 2002:a5d:6daa:0:b0:38a:87cc:fb42 with SMTP id ffacd0b85a97d-38f6e95d5famr14803550f8f.21.1740481527619;
        Tue, 25 Feb 2025 03:05:27 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8fc1f9sm1840718f8f.88.2025.02.25.03.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 03:05:27 -0800 (PST)
Message-ID: <a658145a-df99-4c79-92a2-0f67dd5c157b@blackwall.org>
Date: Tue, 25 Feb 2025 13:05:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net 1/3] bonding: move mutex lock to a work queue for
 XFRM GC tasks
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Jarod Wilson <jarod@redhat.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250225094049.20142-1-liuhangbin@gmail.com>
 <20250225094049.20142-2-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250225094049.20142-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 11:40, Hangbin Liu wrote:
> The fixed commit placed mutex_lock() inside spin_lock_bh(), which triggers
> a warning like:
> 
> BUG: sleeping function called from invalid context at...
> 
> Fix this by moving the mutex_lock() operation to a work queue.
> 
> Fixes: 2aeeef906d5a ("bonding: change ipsec_lock from spin lock to mutex")
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20241212062734.182a0164@kernel.org
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 41 +++++++++++++++++++++++++--------
>  include/net/bonding.h           |  6 +++++
>  2 files changed, 37 insertions(+), 10 deletions(-)
> 

Hi,
I think there are a few issues with this solution, comments below.

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index e45bba240cbc..cc7064aa4b35 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -551,6 +551,25 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>  	mutex_unlock(&bond->ipsec_lock);
>  }
>  
> +static void bond_xfrm_state_gc_work(struct work_struct *work)
> +{
> +	struct bond_xfrm_work *xfrm_work = container_of(work, struct bond_xfrm_work, work);
> +	struct bonding *bond = xfrm_work->bond;
> +	struct xfrm_state *xs = xfrm_work->xs;
> +	struct bond_ipsec *ipsec;
> +
> +	mutex_lock(&bond->ipsec_lock);
> +	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> +		if (ipsec->xs == xs) {
> +			list_del(&ipsec->list);
> +			kfree(ipsec);
> +			xfrm_state_put(xs);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&bond->ipsec_lock);
> +}
> +
>  /**
>   * bond_ipsec_del_sa - clear out this specific SA
>   * @xs: pointer to transformer state struct
> @@ -558,9 +577,9 @@ static void bond_ipsec_add_sa_all(struct bonding *bond)
>  static void bond_ipsec_del_sa(struct xfrm_state *xs)
>  {
>  	struct net_device *bond_dev = xs->xso.dev;
> +	struct bond_xfrm_work *xfrm_work;
>  	struct net_device *real_dev;
>  	netdevice_tracker tracker;
> -	struct bond_ipsec *ipsec;
>  	struct bonding *bond;
>  	struct slave *slave;
>  
> @@ -592,15 +611,17 @@ static void bond_ipsec_del_sa(struct xfrm_state *xs)
>  	real_dev->xfrmdev_ops->xdo_dev_state_delete(xs);
>  out:
>  	netdev_put(real_dev, &tracker);
> -	mutex_lock(&bond->ipsec_lock);
> -	list_for_each_entry(ipsec, &bond->ipsec_list, list) {
> -		if (ipsec->xs == xs) {
> -			list_del(&ipsec->list);
> -			kfree(ipsec);
> -			break;
> -		}
> -	}
> -	mutex_unlock(&bond->ipsec_lock);
> +
> +	xfrm_work = kmalloc(sizeof(*xfrm_work), GFP_ATOMIC);
> +	if (!xfrm_work)
> +		return;
> +

What happens if this allocation fails? I think you'll leak memory and
potentially call the xdo_dev callbacks for this xs again because it's
still in the list. Also this xfrm_work memory doesn't get freed anywhere, so
you're leaking it as well.

Perhaps you can do this allocation in add_sa, it seems you can sleep
there and potentially return an error if it fails, so this can never
fail later. You'll have to be careful with the freeing dance though.
Alternatively, make the work a part of struct bond so it doesn't need
memory management, but then you need a mechanism to queue these items (e.g.
a separate list with a spinlock) and would have more complexity with freeing
in parallel.

> +	INIT_WORK(&xfrm_work->work, bond_xfrm_state_gc_work);
> +	xfrm_work->bond = bond;
> +	xfrm_work->xs = xs;
> +	xfrm_state_hold(xs);
> +
> +	queue_work(bond->wq, &xfrm_work->work);

Note that nothing waits for this work anywhere and .ndo_uninit runs before
bond's .priv_destructor which means ipsec_lock will be destroyed and will be
used afterwards when destroying bond->wq from the destructor if there were
any queued works.

[snip]

Cheers,
 Nik


