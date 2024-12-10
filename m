Return-Path: <netdev+bounces-150598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 318769EAD92
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 11:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0811885B01
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 10:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F57723DEA9;
	Tue, 10 Dec 2024 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fwr3lptP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2323235942
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733825093; cv=none; b=t8N79Ym9JtFNJaM4q56U3ViMLlvOnTFypMJrSQQfbVSm52ZICnrSk428GJcB/E2i8y+mblkDcN3p8+NUG5VlRVFwjVzqHhTiVMdmrNZZ0/3DWyhIyV4k7Fm0jKsF5ukMokYh2eJZFMDDnrRGyasYakcYBjEv0wXLrT3R1G8x05A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733825093; c=relaxed/simple;
	bh=a5KgHKLMnniNQJEqnBxLJOnIy94meK1NEByqFcZ540c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PRzE/6RWEND0TT+vqvyISJaMBGe0UgkxlyxteUBYE4X8vtTrbAfxDuvXeHKxmIid/UkVu/fRiOwq2UEVbDsXGekbymxqU7kgcGSCWw3oZ0KaO+9UnsYdAigIL7HrU2RQJyPpCkTQpRxCvgIkSngjh2vjTNYE07gGoz1ARY0dnsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fwr3lptP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733825091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3ae6vLLG81Oaz3MLDj9aqdH9v+tZLHlGocELrgXjjk=;
	b=Fwr3lptPzm6lOXEDKFGBroyAKyg3EhWZecVNgONoeVXG6YBhdvlbgH7uIMUopfCB0BRpDH
	pXTRkPB4iLNvepvKmmmLEsDZb6u0COCUhLGIVH6Z/Is2+mVbv894ZeExJhpr6al2pDr4Qs
	T3NMxY8vvQR3JC8Mm6/vzef8RLn4c24=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-Jzk868hzNTW54iHPpOpNsg-1; Tue, 10 Dec 2024 05:04:47 -0500
X-MC-Unique: Jzk868hzNTW54iHPpOpNsg-1
X-Mimecast-MFC-AGG-ID: Jzk868hzNTW54iHPpOpNsg
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d8eb5ea994so49128536d6.1
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 02:04:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733825087; x=1734429887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3ae6vLLG81Oaz3MLDj9aqdH9v+tZLHlGocELrgXjjk=;
        b=OaqdyJtV/cZFBZMGBI2dgOmHZ4EP8RN4QjAxVHtMEsFm/MUwbVojgEhoRlXNF/7CZx
         X8oSsc3f5BcPR99dJ3Mn/ZyglEG3v+q3ufId3a4GxzyGlweJyZPn1hBHqatfEqa0uVhb
         eFO1nfm754zDi+WKWVUjerrNtbE//VH6/xVUx5kkVQa9+4x1GKAgOkDSdwy/OcVzxodf
         z1fYbGPvawJKWALbmPCjrMaclJSJ5XtP6cSQDMVS5owgo1e2HzULgO6XPHaQfpQ1C97u
         6EkeP3FNhLUa699WwCs5XBxBM+iLwXWyJhtw6w8uAbaz3A7z1KEBSfSlGV6W4BtaCO9O
         IeJg==
X-Forwarded-Encrypted: i=1; AJvYcCXRDrNG1UFwndUCF9Uzq1D8Uy9tj870hFxtUkiNRCc/GDaegUymuAqb/G3YBWY5pdh1+xQpVIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGdaGGODVUBF+t6WeoAml0zsejvT0glSEtb+Aaux7ruPoh7qJA
	kWKipPUZKRJzlrAZThuMqToJQfzABoJCxED87xPuplkqtqpA5azy9Ik0O0luAL1uM/CfXnsCbYF
	HazGW/+dwRKSkzDkjqjHgYz1/yk3K+xQhV9gjy2UNZSB1e9nGN0JbGA==
X-Gm-Gg: ASbGncs+IWERYBk5oOaQIETvU+Z8wE3bmokN8T9kHZy9/NvfEkm6fJF3S/Nhf/KJ1yC
	Ozdvkv+4UwmSpiUvEwV0w3ytieTOPNpoJlZPpQtqfTViDwYVfKkuIAvTiI6rbYZEWS7my8Z8SCD
	JczIelQR20kI6fYmtOCVmdwhXnVpdrV38LXQswv49kXeUkqkx9g6BdtjJHnIRdqToOunfdlkjSU
	f/uDEdJp4kZutLyXPsyKv0z4IxdbkPQP94fkC6Hzcgmtuv6ueVSK4CEkg7cT8zDXWzrILjV8vPt
	1IqgD4ul0VZhk8a3TIy5Pw58AQ==
X-Received: by 2002:ad4:5ae3:0:b0:6d8:9d28:ff07 with SMTP id 6a1803df08f44-6d8e71e56cbmr314385666d6.45.1733825087276;
        Tue, 10 Dec 2024 02:04:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrxGRcxXDwUSXmz7uZszQCh1ZzPVfr9/e6EVos7EDDqHcHI7i3fZ5CrTM5Iwp2JEM2PYxVrA==
X-Received: by 2002:ad4:5ae3:0:b0:6d8:9d28:ff07 with SMTP id 6a1803df08f44-6d8e71e56cbmr314385306d6.45.1733825086975;
        Tue, 10 Dec 2024 02:04:46 -0800 (PST)
Received: from [192.168.1.14] (host-82-49-164-239.retail.telecomitalia.it. [82.49.164.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d9005f17b7sm31606926d6.5.2024.12.10.02.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 02:04:46 -0800 (PST)
Message-ID: <c67e10cf-ae33-4974-93c6-aaa111171635@redhat.com>
Date: Tue, 10 Dec 2024 11:04:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] Do not invoke addrconf_verify_rtnl
 unnecessarily
To: Gilad Naaman <gnaaman@drivenets.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20241205171248.3958156-1-gnaaman@drivenets.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241205171248.3958156-1-gnaaman@drivenets.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 18:12, Gilad Naaman wrote:
> Do not invoke costly `addrconf_verify_rtnl` if the added address
> wouldn't need it, or affect the delayed_work timer.
> 
> For new/modified addresses, call "verify" only if added address has an
> expiration, or if any temporary address was created.
> 
> This is done to account for a case where the new expiration time might
> be sooner than the current delayed_work's expiration.
> 
> For deleted addresses, avoid calling verify at all:
> 
> If the address being deleted is not perishable, and thus does not affect
> the delayed_work expiration, there is not point in going over the entire
> table.
> 
> If the address IS perishable, but is not the soonest-to-be-expired
> address, calling "verify" would not change the expiration, and would be
> a very expensive nop.
> 
> If the address IS perishable, and IS the soonest-to-be-expired address,
> calling or not-calling "verify" for a single address deletion is
> equivalent in cost.

This last statement is not obvious to me, could you please expand the
reasoning?

> 
> But calling "verify" immediately will result in a performance hit when
> deleting many addresses.

Since this is about (control plane) performances, please include the
relevant test details (or even better, please add a small/fast self-test
covering the use-case).

> 
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
> ---
>  net/ipv6/addrconf.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index c489a1e6aec9..893502787554 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -310,6 +310,16 @@ static inline bool addrconf_link_ready(const struct net_device *dev)
>  	return netif_oper_up(dev) && !qdisc_tx_is_noop(dev);
>  }
>  
> +static inline bool addrconf_perishable(int ifa_flags, u32 prefered_lft)

Please, do not use 'inline' in c files.

> +{
> +	/* When setting preferred_lft to a value not zero or
> +	 * infinity, while valid_lft is infinity
> +	 * IFA_F_PERMANENT has a non-infinity life time.
> +	 */
> +	return !((ifa_flags & IFA_F_PERMANENT) &&
> +		(prefered_lft == INFINITY_LIFE_TIME));

Minor nit: the intentation is wrong should be:
		
	return !((ifa_flags & IFA_F_PERMANENT) &&
		 (prefered_lft == INFINITY_LIFE_TIME));
> +}
> +
>  static void addrconf_del_rs_timer(struct inet6_dev *idev)
>  {
>  	if (del_timer(&idev->rs_timer))
> @@ -3090,8 +3100,7 @@ static int inet6_addr_add(struct net *net, int ifindex,
>  		 */
>  		if (!(ifp->flags & (IFA_F_OPTIMISTIC | IFA_F_NODAD)))
>  			ipv6_ifa_notify(0, ifp);
> -		/*
> -		 * Note that section 3.1 of RFC 4429 indicates
> +		/* Note that section 3.1 of RFC 4429 indicates
>  		 * that the Optimistic flag should not be set for
>  		 * manually configured addresses
>  		 */
> @@ -3100,7 +3109,14 @@ static int inet6_addr_add(struct net *net, int ifindex,
>  			manage_tempaddrs(idev, ifp, cfg->valid_lft,
>  					 cfg->preferred_lft, true, jiffies);
>  		in6_ifa_put(ifp);
> -		addrconf_verify_rtnl(net);
> +
> +		/* Verify only if it's possible that adding this address
> +		 * may modify the worker expiration time.
> +		 */
> +		if ((cfg->ifa_flags & IFA_F_MANAGETEMPADDR) ||
> +		    addrconf_perishable(cfg->ifa_flags, cfg->preferred_lft))
> +			addrconf_verify_rtnl(net);
> +
>  		return 0;
>  	} else if (cfg->ifa_flags & IFA_F_MCAUTOJOIN) {
>  		ipv6_mc_config(net->ipv6.mc_autojoin_sk, false,
> @@ -3148,7 +3164,6 @@ static int inet6_addr_del(struct net *net, int ifindex, u32 ifa_flags,
>  			    (ifp->flags & IFA_F_MANAGETEMPADDR))
>  				delete_tempaddrs(idev, ifp);
>  
> -			addrconf_verify_rtnl(net);

With an additional 'addrconf_perishable' check here protecting the (here
removed) addrconf_verify_rtnl(), the patch will be IMHO much less prone
to unintended side-effects.

Thanks,

Paolo


