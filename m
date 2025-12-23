Return-Path: <netdev+bounces-245830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E7DCD8BE8
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 11:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 066D7300A8E7
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 10:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18712DEA90;
	Tue, 23 Dec 2025 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILkLnG1R";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3S3HkuO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95F32D838C
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766484844; cv=none; b=lridiC03eVZhRYlBMLNdZJW+RLUYFp/HabyG6KM1e5yl1OhPvQ0cooH6HVW56FgQEraIB8lBzifO53CEc6/dN16XN6KtXqemM0FuQwq3Yc3tmchbph6ON5EbWCBmXGq2oXOOJvO2JC+608bs/TNFILh516H4+BO88MVOo6tIGh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766484844; c=relaxed/simple;
	bh=d4tt4MzuujQIcwinJfE/H+S9mMdM1lQY1ynSYHlPwfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PAVVO52TmbK6FoNI6cWbwtpjCv9z+1X0T9Xm/KKcwO6mNs3P48NVySilU0d1kXiSWswIHbinYCDY12dVMygnHyGzjp+L47m1PcJbKd73TyP+T135vBZfqcohnnbpoMOgtFvB8QkZWK6BIHOLT9WD1gyHRsvo1M/z2T9ZISTRDh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ILkLnG1R; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3S3HkuO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766484841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oFR3UankU/ZXumu63drTFEhhEbrQvsrwe1Tofny6yYE=;
	b=ILkLnG1RVoUpea077M244B/L4RR2fFzfB0oZ4F6QRqkVDZTNNpoDsM0rhV8DQjxmEIA3pa
	+4SbpQLi8LW38v15OIPFJM2yezP1+hjVJ049jHaQX0G8QQVFuF9KaJRxy1ntcskOarXyzD
	yOSxS5tJUBrKfv043RfekiPVUycya60=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-eiznvxFGNb-2B_XZi2u5Ow-1; Tue, 23 Dec 2025 05:14:00 -0500
X-MC-Unique: eiznvxFGNb-2B_XZi2u5Ow-1
X-Mimecast-MFC-AGG-ID: eiznvxFGNb-2B_XZi2u5Ow_1766484839
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477964c22e0so34311275e9.0
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 02:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766484839; x=1767089639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oFR3UankU/ZXumu63drTFEhhEbrQvsrwe1Tofny6yYE=;
        b=V3S3HkuOWFNwugiSOr8Gw9mQQ7v8618ZpOMsCLeRQERd77rPS0QYWD9SvpKIXmHaZ8
         BT5nMYZK07JisKbwPNU4Jl2itZd1ARpu86iNZ6NfmwZEtGsIjgMo8KKS3Qc2SAl2z3g2
         hohv004x21jyuGS1Rsd7V4tHXL9lqT4Ju/Nl7j90jByvPCOQquurjl44ZP9V/y0UMJ+S
         Y+mRPwvEIamIp5S6U+HzWndjGIlJAwotxu8vmiiG3rfcQaEtcqvwhUjBKFb/ZIeSVJfn
         OfEYa09Py0e+pGw9CCkiL3d3IGTxdk77RPk8mJlHijctJBQGuuPICrVCalNoooSa0OvR
         XVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766484839; x=1767089639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFR3UankU/ZXumu63drTFEhhEbrQvsrwe1Tofny6yYE=;
        b=IPR3c4lFp2jz5VhdCM4VeL8l1teCrk2q01jzlP28BNXtlBdAZz0xcYbErbUfThXK3S
         GhtQIZ710LruEL1rVLlT2KdaAAhe2gB9yGtFbPH69XdeElIiWsf3B/uKrbbkZE+F79Cc
         vAfGzBd/vkcTh/9IzA+Kw/8/2aHWqSSRvuCtWIUlkedOmqaXuvacsYs7j6HC0ppjJihl
         Dbfj/lX+S9kE53umEfGY78tkV4t/lYFf746ouHkdTa28Fww4kXOYvwMnDsVZ23VRWN3+
         eJwMIQzx+uKH/K7XKzSYaPSHrMaDOyLETUZxB4XB5Vy8RR/ghRX/Y5k2SbvRdYnzLDDG
         FncQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2yc4EG9sEqORGg32LIfeiqg1mTWWMUMV0PvqlESPw7gTUR4nYzLu3SycGsy11Qv4oH+kWV3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYs4nXfkuSlWTKif5lbOhBOpDzEqfIDz5Cajemqt1EvTE2yuq8
	BgdtWRPlnQVmk/Adiihb7uNgYpLBFSYGckzFpUkpGK3ZGljmhhs4q99Aq74/r5JtFnQGcdZOMwD
	myv1Pu4D08uqUvCdd76Kt/aRGnhq9E8J+dwlIMXJTSy/Yy35hSWpstK6FWA==
X-Gm-Gg: AY/fxX7o5lmCCrz4+KzjXjsyEZlEOKpQwsIkLQWtecUZQM0yM2JMATUCrhqUO2nhJQw
	Jv+uMjbwjtMioJBMeUC6JbFRbiPt0q+Cdft++MXEUyvARz2LvXFSGGT3950FCDF8RGdFoLWPU6h
	fJwP+61Xx0sAP/GlDrJKuCuuF6jXCWkXdC5HL1txOjkx70uL41APKFbRtmK3Lbw+WJl/YwxdE3y
	GRV6r6PpUpFYGLRTSV7v6WKKfVHR8dcIHTJ5wlfSNxo9WzmDgjN7WOyvS1K6MJU2XSal23CUjn8
	QqpLyp/fstPlvvUUkA/4irKCIcBaA6aoFk+gI16rW8dhRfSzikmCGxRhcSZpFn64dV465RPxqPN
	X8Qx+a1uYp0A1
X-Received: by 2002:a05:600c:4746:b0:477:9fa0:7495 with SMTP id 5b1f17b1804b1-47d18be144fmr125217275e9.14.1766484838842;
        Tue, 23 Dec 2025 02:13:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBVFBFV8JQghn5DbnVX+mIgO0xj1voHIdhg+zVPbfA8QA2nep/Xwt/TcDBUPc1v4/lT/IkiQ==
X-Received: by 2002:a05:600c:4746:b0:477:9fa0:7495 with SMTP id 5b1f17b1804b1-47d18be144fmr125217095e9.14.1766484838326;
        Tue, 23 Dec 2025 02:13:58 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3964226sm124149365e9.0.2025.12.23.02.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 02:13:57 -0800 (PST)
Message-ID: <dab5d779-8ea4-4653-a320-d805d08b2547@redhat.com>
Date: Tue, 23 Dec 2025 11:13:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipvlan: Make the addrs_lock be per port
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>, netdev@vger.kernel.org,
 Xiao Liang <shaw.leon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Guillaume Nault <gnault@redhat.com>,
 Julian Vetter <julian@outer-limits.org>, Eric Dumazet <edumazet@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Etienne Champetier <champetier.etienne@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
References: <20251215165457.752634-1-skorodumov.dmitry@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251215165457.752634-1-skorodumov.dmitry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/25 5:54 PM, Dmitry Skorodumov wrote:
> Make the addrs_lock be per port, not per ipvlan dev.
> 
> Initial code seems to be written in the assumption,
> that any address change must occur under RTNL.
> But it is not so for the case of IPv6. So
> 
> 1) Introduce per-port addrs_lock.
> 
> 2) It was needed to fix places where it was forgotten
> to take lock (ipvlan_open/ipvlan_close)
> 
> 3) Fix places, where list_for_each_entry_rcu()
> was used to iterate the list while holding a lock
> 
> This appears to be a very minor problem though.
> Since it's highly unlikely that ipvlan_add_addr() will
> be called on 2 CPU simultaneously. But nevertheless,
> this could cause:
> 
> 1) False-negative of ipvlan_addr_busy(): one interface
> iterated through all port->ipvlans + ipvlan->addrs
> under some ipvlan spinlock, and another added IP
> under its own lock. Though this is only possible
> for IPv6, since looks like only ipvlan_addr6_event() can be
> called without rtnl_lock.
> 
> 2) Race since ipvlan_ht_addr_add(port) is called under
> different ipvlan->addrs_lock locks
> 
> This should not affect performance, since add/remove IP
> is a rare situation and spinlock is not taken on fast
> paths.
> 
> Fixes: 8230819494b3 ("ipvlan: use per device spinlock to protect addrs list updates")
> Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
> CC: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>

Duplicate signature: drop one.

Side note: you should have included a revision number in the subj prefix
(v2) and a summary of changes since v1 after the '---' separator

> ---
>  drivers/net/ipvlan/ipvlan.h      |  2 +-
>  drivers/net/ipvlan/ipvlan_core.c | 12 ++++----
>  drivers/net/ipvlan/ipvlan_main.c | 52 ++++++++++++++++++--------------
>  3 files changed, 37 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/net/ipvlan/ipvlan.h b/drivers/net/ipvlan/ipvlan.h
> index 50de3ee204db..80f84fc87008 100644
> --- a/drivers/net/ipvlan/ipvlan.h
> +++ b/drivers/net/ipvlan/ipvlan.h
> @@ -69,7 +69,6 @@ struct ipvl_dev {
>  	DECLARE_BITMAP(mac_filters, IPVLAN_MAC_FILTER_SIZE);
>  	netdev_features_t	sfeatures;
>  	u32			msg_enable;
> -	spinlock_t		addrs_lock;
>  };
>  
>  struct ipvl_addr {
> @@ -90,6 +89,7 @@ struct ipvl_port {
>  	struct net_device	*dev;
>  	possible_net_t		pnet;
>  	struct hlist_head	hlhead[IPVLAN_HASH_SIZE];
> +	spinlock_t		addrs_lock; /* guards hash-table and addrs */
>  	struct list_head	ipvlans;
>  	u16			mode;
>  	u16			flags;
> diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
> index 2efa3ba148aa..22cb5ee7a231 100644
> --- a/drivers/net/ipvlan/ipvlan_core.c
> +++ b/drivers/net/ipvlan/ipvlan_core.c
> @@ -109,14 +109,14 @@ struct ipvl_addr *ipvlan_find_addr(const struct ipvl_dev *ipvlan,
>  {
>  	struct ipvl_addr *addr, *ret = NULL;
>  
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(addr, &ipvlan->addrs, anode) {
> +	assert_spin_locked(&ipvlan->port->addrs_lock);
> +
> +	list_for_each_entry(addr, &ipvlan->addrs, anode) {
>  		if (addr_equal(is_v6, addr, iaddr)) {
>  			ret = addr;
>  			break;

You could just return `addr`, and remove the `ret` variable

>  		}
>  	}
> -	rcu_read_unlock();
>  	return ret;
>  }
>  
> @@ -125,14 +125,14 @@ bool ipvlan_addr_busy(struct ipvl_port *port, void *iaddr, bool is_v6)
>  	struct ipvl_dev *ipvlan;
>  	bool ret = false;
>  
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(ipvlan, &port->ipvlans, pnode) {
> +	assert_spin_locked(&port->addrs_lock);
> +
> +	list_for_each_entry(ipvlan, &port->ipvlans, pnode) {

What protects the `ipvlans` list here? I think the RCU lock is still needed.

>  		if (ipvlan_find_addr(ipvlan, iaddr, is_v6)) {
>  			ret = true;
>  			break;
>  		}
>  	}
> -	rcu_read_unlock();
>  	return ret;
>  }
>  
> diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
> index 660f3db11766..b0b4f747f162 100644
> --- a/drivers/net/ipvlan/ipvlan_main.c
> +++ b/drivers/net/ipvlan/ipvlan_main.c
> @@ -75,6 +75,7 @@ static int ipvlan_port_create(struct net_device *dev)
>  	for (idx = 0; idx < IPVLAN_HASH_SIZE; idx++)
>  		INIT_HLIST_HEAD(&port->hlhead[idx]);
>  
> +	spin_lock_init(&port->addrs_lock);
>  	skb_queue_head_init(&port->backlog);
>  	INIT_WORK(&port->wq, ipvlan_process_multicast);
>  	ida_init(&port->ida);
> @@ -181,18 +182,18 @@ static void ipvlan_uninit(struct net_device *dev)
>  static int ipvlan_open(struct net_device *dev)
>  {
>  	struct ipvl_dev *ipvlan = netdev_priv(dev);
> +	struct ipvl_port *port = ipvlan->port;
>  	struct ipvl_addr *addr;
>  
> -	if (ipvlan->port->mode == IPVLAN_MODE_L3 ||
> -	    ipvlan->port->mode == IPVLAN_MODE_L3S)
> +	if (port->mode == IPVLAN_MODE_L3 || port->mode == IPVLAN_MODE_L3S)
>  		dev->flags |= IFF_NOARP;
>  	else
>  		dev->flags &= ~IFF_NOARP;

Please omit unrelated formatting changes, this fix is already quite big
as is.

Please include the paired self-test in the next iteration (as noted by
Simon self-test can be included into 'net' series, too), thanks!

Paolo


