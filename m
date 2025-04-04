Return-Path: <netdev+bounces-179270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA412A7BACF
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 12:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35728189E839
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC0A1E571A;
	Fri,  4 Apr 2025 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="qPPXEGtH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89A21B21B4
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 10:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743762580; cv=none; b=uKrudeSRu1pBuz2bs2A/MVX6Js162+tvHEiBGidoaUKjLXN2S1OQfhv1R1xWgJXMgNdmpoCUI6d95ADw873aCBvobTJiNx+2FCO7ae9JWGcPhv0B/5uqToMJG9E05hiTeTWs85y0mxNocftff6k5i2w5p8MJQ2GouMmkZdaXVko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743762580; c=relaxed/simple;
	bh=mLcDru8eInjU0uOo91bIFQt4AIpvVW2OtKNAkdmIfV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGCxAUNIFBM14ggdHhXnMmHcUcD+OommENFsPe3Pbz4af7Rqae48qIpKhE2ptLQYPWTvrqjp7k0m0ZANgeu+6mKhbGVIsUKVf6i71AogOikvcNv7OfKBy9ZNzo5/Ujc9+TGL3mYe5an0ShkL33tyKa+cSVZHLExul+jFE8kMGfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=qPPXEGtH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43948021a45so17425475e9.1
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 03:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1743762577; x=1744367377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4D5zlP7j1AtzmdD+fdYHZGrIA+c23RJYKMOt2bRJjqs=;
        b=qPPXEGtHxrTS76JuycV1G2jNK4SiFQ+ocBJbfgVpdOGp3gAiIEb5mvVJQ6IPyBTuTt
         hXZHMB2NXCXqeKmH6k20SVcXLyGDE3KdosWpnbAj8TWbudnesnLKK2qWZZ0Cn29zIO43
         uYQ1nAp4IVKXyDK2x5KWZJrxW1xLF5jmto3ETasN0bGbliTLjZ4dxxFvMCNP4cZBYeK8
         TGxEMhPlVn93W2hKHsdorKITagDbIQYFQUjCTmUjfw25TVplvju+YMtbXOC/ycr+c9YS
         R/OogwrDyb9fbbFnbCd9blqXGeXCWS+ZCwrkngYavXBmTncuWCdYdmpbypqfmFZpFCxX
         c3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743762577; x=1744367377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4D5zlP7j1AtzmdD+fdYHZGrIA+c23RJYKMOt2bRJjqs=;
        b=jO1tSZ5cxKwkwRx0Vm1V2Pwn58/B32fy9gAeuaQsedV2omJFhGpbpArvTOBmDlYOCp
         GSDkOrLyoSeMcN1IyF6aSJw1EA1X2ZFDZiTcWwBtG79z91V4nSEZrabTRbxaZI2YUlZs
         8ehbsYKr0+jRruWt7Y/nOPF4WG688a67YA/aCGxUZhcUuwf4celroRaG/ZYqnlcANByj
         AdCzVHlj57ex8zODbD7A2aj8qKTJcfwr+6ukkTLJKAplld6yQks+MOkKsLAr53nN/9Vc
         juDttxAjEMO+fdi36q9DjUOu9qXlMos+kNkSD8l905I197zlCDHoGNovTUV0XU+6wga1
         g8bg==
X-Forwarded-Encrypted: i=1; AJvYcCXGSuRpPc84zNIKl8SyG7jmr/p8jfdAtUUWPm1xWPnnGN18xJrHaClhJHE+GV7TiRHeEoDeofA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIJvMTg2HiLhJ37kXzYEvylbrY/W13jho4RAmf6liyU7GP9u5Z
	sT+abGGuxnkCk/jlaGvv6lg+kDACRz672qRZ7k4evJpBoBfRUvqLr3ukzy9La7Q=
X-Gm-Gg: ASbGncu9ikLD0mmmP6dyc9ih1dDGS8f0FHl01GUv/xxD5WkNui2SM8aCOfPKDaXr+fW
	oa3li54zwFeTZCbkr3qdgyf6uGag8w0hoQe3wvAFJWcLI2BIImAhI5Lfc2yzTpvOs7PVX9EX84y
	QJYiUCmxZUgL/qm9cNJB1rQXRq9WwpGk8fef0CJmeR893RABOIrU6Nuoe+sUFjqHvFv5QvK/9dy
	SgqdFUm2VZZpSOTWoyTbU7SyemHQUUNLYGKxdZPYrDVKp/0i/HA6QkstWclL9EG+4D1grdIB+eE
	qAi4Yjy+gDm2cL63M0hHfV19CNw3mOcmgScV3non/1IuZwROJYKumxomsZX4depXmZWppmiXCdm
	B
X-Google-Smtp-Source: AGHT+IEZYWLp5+FLqhn6UpFvGJp4isiBgQ145JbwTaagvs7RNoWX3qphA42f4gPmOqeyRlDNvtcuXQ==
X-Received: by 2002:a05:600c:1994:b0:43c:ebc4:36a5 with SMTP id 5b1f17b1804b1-43ed0b4816dmr14529555e9.7.1743762576664;
        Fri, 04 Apr 2025 03:29:36 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34a895fsm42197425e9.13.2025.04.04.03.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 03:29:36 -0700 (PDT)
Message-ID: <36c7286d-b410-4695-b069-f79605feade4@blackwall.org>
Date: Fri, 4 Apr 2025 13:29:35 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 net-next 3/3] net: bridge: mcast: Notify on mdb offload
 failure
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Joseph Huang <joseph.huang.2024@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250403234412.1531714-1-Joseph.Huang@garmin.com>
 <20250403234412.1531714-4-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250403234412.1531714-4-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/25 02:44, Joseph Huang wrote:
> Notify user space on mdb offload failure if mdb_offload_fail_notification
> is set.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  net/bridge/br_mdb.c       | 26 +++++++++++++++++++++-----
>  net/bridge/br_private.h   |  9 +++++++++
>  net/bridge/br_switchdev.c |  4 ++++
>  3 files changed, 34 insertions(+), 5 deletions(-)
> 

The patch looks good, but one question - it seems we'll mark mdb entries with
"offload failed" when we get -EOPNOTSUPP as an error as well. Is that intended?

That is, if the option is enabled and we have mixed bridge ports, we'll mark mdbs
to the non-switch ports as offload failed, but it is not due to a switch offload
error.

> diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
> index 0639691cd19b..5f53f387d251 100644
> --- a/net/bridge/br_mdb.c
> +++ b/net/bridge/br_mdb.c
> @@ -519,16 +519,17 @@ static size_t rtnl_mdb_nlmsg_size(const struct net_bridge_port_group *pg)
>  	       rtnl_mdb_nlmsg_pg_size(pg);
>  }
>  
> -void br_mdb_notify(struct net_device *dev,
> -		   struct net_bridge_mdb_entry *mp,
> -		   struct net_bridge_port_group *pg,
> -		   int type)
> +static void __br_mdb_notify(struct net_device *dev,
> +			    struct net_bridge_mdb_entry *mp,
> +			    struct net_bridge_port_group *pg,
> +			    int type, bool notify_switchdev)
>  {
>  	struct net *net = dev_net(dev);
>  	struct sk_buff *skb;
>  	int err = -ENOBUFS;
>  
> -	br_switchdev_mdb_notify(dev, mp, pg, type);
> +	if (notify_switchdev)
> +		br_switchdev_mdb_notify(dev, mp, pg, type);
>  
>  	skb = nlmsg_new(rtnl_mdb_nlmsg_size(pg), GFP_ATOMIC);
>  	if (!skb)
> @@ -546,6 +547,21 @@ void br_mdb_notify(struct net_device *dev,
>  	rtnl_set_sk_err(net, RTNLGRP_MDB, err);
>  }
>  
> +void br_mdb_notify(struct net_device *dev,
> +		   struct net_bridge_mdb_entry *mp,
> +		   struct net_bridge_port_group *pg,
> +		   int type)
> +{
> +	__br_mdb_notify(dev, mp, pg, type, true);
> +}
> +
> +void br_mdb_flag_change_notify(struct net_device *dev,
> +			       struct net_bridge_mdb_entry *mp,
> +			       struct net_bridge_port_group *pg)
> +{
> +	__br_mdb_notify(dev, mp, pg, RTM_NEWMDB, false);
> +}
> +
>  static int nlmsg_populate_rtr_fill(struct sk_buff *skb,
>  				   struct net_device *dev,
>  				   int ifindex, u16 vid, u32 pid,
> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
> index 02188b7ff8e6..fc43ccc06ccb 100644
> --- a/net/bridge/br_private.h
> +++ b/net/bridge/br_private.h
> @@ -1005,6 +1005,8 @@ int br_mdb_hash_init(struct net_bridge *br);
>  void br_mdb_hash_fini(struct net_bridge *br);
>  void br_mdb_notify(struct net_device *dev, struct net_bridge_mdb_entry *mp,
>  		   struct net_bridge_port_group *pg, int type);
> +void br_mdb_flag_change_notify(struct net_device *dev, struct net_bridge_mdb_entry *mp,
> +			       struct net_bridge_port_group *pg);
>  void br_rtr_notify(struct net_device *dev, struct net_bridge_mcast_port *pmctx,
>  		   int type);
>  void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
> @@ -1354,6 +1356,13 @@ br_multicast_set_pg_offload_flags(struct net_bridge_port_group *p,
>  	p->flags |= (offloaded ? MDB_PG_FLAGS_OFFLOAD :
>  		MDB_PG_FLAGS_OFFLOAD_FAILED);
>  }
> +
> +static inline bool
> +br_mdb_should_notify(const struct net_bridge *br, u8 changed_flags)
> +{
> +	return br_opt_get(br, BROPT_MDB_OFFLOAD_FAIL_NOTIFICATION) &&
> +		(changed_flags & MDB_PG_FLAGS_OFFLOAD_FAILED);
> +}
>  #else
>  static inline int br_multicast_rcv(struct net_bridge_mcast **brmctx,
>  				   struct net_bridge_mcast_port **pmctx,
> diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
> index 40f0b16e4df8..9b5005d0742a 100644
> --- a/net/bridge/br_switchdev.c
> +++ b/net/bridge/br_switchdev.c
> @@ -504,6 +504,7 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>  	struct net_bridge_mdb_entry *mp;
>  	struct net_bridge_port *port = data->port;
>  	struct net_bridge *br = port->br;
> +	u8 old_flags;
>  
>  	spin_lock_bh(&br->multicast_lock);
>  	mp = br_mdb_ip_get(br, &data->ip);
> @@ -514,7 +515,10 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
>  		if (p->key.port != port)
>  			continue;
>  
> +		old_flags = p->flags;
>  		br_multicast_set_pg_offload_flags(p, !err);
> +		if (br_mdb_should_notify(br, old_flags ^ p->flags))
> +			br_mdb_flag_change_notify(br->dev, mp, p);
>  	}
>  out:
>  	spin_unlock_bh(&br->multicast_lock);


