Return-Path: <netdev+bounces-222956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E625DB57417
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 11:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1C167B0D54
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 09:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E734C2F60CE;
	Mon, 15 Sep 2025 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNJ5ldvH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2862F5461
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926978; cv=none; b=RkDL380eLFRtpFeSmxnNcwdz+0spvYqGSx1E51YGP6YNug2AnSGVnCFb4NrzxPzPlYsFTZv0eDYv3wSpzXTXJNEBRCRsPN6JLNEsDgG5raDjt0ztQ8PmOi6VTDUXorOg9x+SEN1VfKEb10XJBSdnkXsQqgzf7IrlgtCJ1rDCg54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926978; c=relaxed/simple;
	bh=PYZKo+rCitTpiISI3UjC7Kd//MO5rMAibWsRtwNw1po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfBr/L7yqz5ktzDEzl/C1OdndQUESL9DYedp+ZCKBWbnm3sILm2H85/Qi+YUTgo2MizQu88OIMsQlb0xf2gh2dm0+O3/YFhz0T7LycSJFed5xRqS/f5/73Ye3ipeLOqUFsxsBCg7pWxoE5fJ7ChAikGfM6HxlgHbHavoee4HtKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNJ5ldvH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45decc9e83eso42247695e9.3
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 02:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757926975; x=1758531775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xs2E9vQWD4SmDzJAUkFpGMVwSvgRwbZdjC5NZHbVZv4=;
        b=TNJ5ldvHHuCz6HPpx6IND3MTRdKrNYWHJVM2oHyTQDK/ZnrONbWi/DiovZVTxBNYTp
         d6Dx0ysu6EML8v68ERKDpFbQl5EYiLGAgX0t32GK5SVFh4Z6V3FiX9ZztJqrFumWEFYw
         ToKBtcuf6KHb2b3xEove5amUlbOIaOivEIE0388ux/U64oNtjLJbTJtTiwrbcEyivnSi
         rOjvHgYDcIkt/3Cswq5lec9EeVNT7Rayddjp1ijLdlW+7d73rJkBDDfckzc0P5Oh4uFN
         2FMtZTiI+pPDnvwF8TXGuYWbVLtS6MOFIQ+mRWsUbXfmdK4218KfyKvdvD5EqnhL4QDy
         QbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757926975; x=1758531775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xs2E9vQWD4SmDzJAUkFpGMVwSvgRwbZdjC5NZHbVZv4=;
        b=lj6HGg5YbhhLbSf2DrgRIXp0AXaYPAExOYHL4K963lL1w3+uV/Wi19lm8wELsNbl7w
         M7iqPmnSuU1PkKLSzzWT+tkUMNxBhM5CiSndHVW0hib0fQCIEhxtVkE8fkBOD7BvLmjT
         evNL3jIOfyR/bX8FgTyc0wWyOlN5VTB6IYqIPxpOeZTgFSOgz6F5bxe1WofrCndo2eLg
         QtYWaXatO7pbaNcFeUy+yIjLZkAwGT+jO/7IvupZlVqYOgurVgK6UQXtUTiJkjP5i1qR
         0c2c537X8kr+o8sW1zOZKvwmOw5EMdrfPfOxq/Rwa2mV6gwCb5ALYMCvRheBJNhrJrpi
         ciLw==
X-Forwarded-Encrypted: i=1; AJvYcCUd18WUlhZFMEMX+sU2Hw16gflirCWxTViUDaowvkqdvP9Zh/7ECZCxXd8bHPnEHVtQjTY+t2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyInYMRSYj5fo1JEzlO8Ufiv87yufHDNwM4o7+evkutXbPD3UDB
	ksPBzxUAdaxEV0MdQruh5uK1Yr1+W2ZU8GHWTE9Lc9hB8AMqZijNfjus
X-Gm-Gg: ASbGncuKdfJzO0uBoZ7QQAGbPJ2XODA10cj784ZgOVyFBleQu6jZoWC03x6bmFw+QAK
	xSxEKkl+EBEqLSh/K0Zu+MQleB6v+ARmeu9fsUa9iRvNCO75rm5joU/L6ENVY3f91HQqltT04Uq
	zke2sf1Yx7bx428/mz4SBHI8nLC52I3NxhN6bqwUwbNwwRQmhNi/fDjlGCPdmZf0qTXgKk+svhr
	RvSHzdfK4Tm9scNjGqR70Qxy5T7ipXg712gGx9qVLskCgJTTNobQAYi38NEQ7Nat6qrrzVTOCDy
	EuNkjsqrHBJlIJWLVFc4k/EjJKFmZ5VVXKPD0SAp+4PxeA2EStbzNfs/oSAwa+fr6RzRzfhg7eJ
	72SbVQBRPLKGQGth8kpyfQwoMrWPTcGvYHw==
X-Google-Smtp-Source: AGHT+IGpdfmovFHY6tExCap0sZmtXJPGt0p/16CCvFEBx3+Mp/0EmNG2s/n091zea+g8iry091Paag==
X-Received: by 2002:a05:6000:2c07:b0:3d3:494b:4e5d with SMTP id ffacd0b85a97d-3e765532afdmr8789385f8f.0.1757926974586;
        Mon, 15 Sep 2025 02:02:54 -0700 (PDT)
Received: from localhost ([45.10.155.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e774a3fb5bsm12740007f8f.58.2025.09.15.02.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 02:02:54 -0700 (PDT)
Message-ID: <614d456e-13d9-439d-9520-ad22c8be0327@gmail.com>
Date: Mon, 15 Sep 2025 11:02:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 3/5] net: gso: restore ids of outer ip headers
 correctly
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
 ecree.xilinx@gmail.com, dsahern@kernel.org, ncardwell@google.com,
 kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me,
 aleksander.lobakin@intel.com, florian.fainelli@broadcom.com,
 alexander.duyck@gmail.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250901113826.6508-1-richardbgobert@gmail.com>
 <20250901113826.6508-4-richardbgobert@gmail.com>
 <willemdebruijn.kernel.2f9db40362380@gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <willemdebruijn.kernel.2f9db40362380@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> Currently, NETIF_F_TSO_MANGLEID indicates that the inner-most ID can
>> be mangled. Outer IDs can always be mangled.
>>
>> Make GSO preserve outer IDs by default, with NETIF_F_TSO_MANGLEID allowing
>> both inner and outer IDs to be mangled.
>>
>> This commit also modifies a few drivers that use SKB_GSO_FIXEDID directly.
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>> ---
>>  .../networking/segmentation-offloads.rst        |  9 ++++-----
>>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c |  8 ++++++--
>>  drivers/net/ethernet/sfc/ef100_tx.c             | 17 +++++++++++++----
>>  include/linux/netdevice.h                       |  9 +++++++--
>>  include/linux/skbuff.h                          |  6 +++++-
>>  net/core/dev.c                                  |  4 +++-
>>  net/ipv4/af_inet.c                              | 13 ++++++-------
>>  net/ipv4/tcp_offload.c                          |  5 +----
>>  8 files changed, 45 insertions(+), 26 deletions(-)
>>
>> diff --git a/Documentation/networking/segmentation-offloads.rst b/Documentation/networking/segmentation-offloads.rst
>> index 085e8fab03fd..d5dccfc6b82b 100644
>> --- a/Documentation/networking/segmentation-offloads.rst
>> +++ b/Documentation/networking/segmentation-offloads.rst
>> @@ -46,7 +46,9 @@ GSO type SKB_GSO_TCP_FIXEDID is specified then we will not increment the IP
>>  ID and all segments will use the same IP ID.  If a device has
>>  NETIF_F_TSO_MANGLEID set then the IP ID can be ignored when performing TSO
>>  and we will either increment the IP ID for all frames, or leave it at a
>> -static value based on driver preference.
>> +static value based on driver preference. For outer headers of encapsulated
>> +packets, the device drivers must guarantee that the IPv4 ID field is
>> +incremented in the case that a given header does not have the DF bit set.
> 
> Please split this into three paragraphs on FIXEDID, FIXED_INNER and
> MANGLEID.
> 
> Specifically the use of FIXEDID to mean uncapped or outer should be
> explicitly mentioned (as discussed previously).
> 
> Also, I understood that MANGLEID now means that both inner and outer
> IP ID can be mangled. But this comment appears to say otherwise.
> Maybe it helps to be more explicit also about behavior without DF.
> 

Sure, I'll elaborate more on these features.

>>  Partial Generic Segmentation Offload
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>> index b8c609d91d11..505c4ce7cef8 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> 
>> diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
>> index e6b6be549581..24971346df00 100644
>> --- a/drivers/net/ethernet/sfc/ef100_tx.c
>> +++ b/drivers/net/ethernet/sfc/ef100_tx.c
> 
> Not sure whether these driver changes need to be separate patches.
> 

I updated the drivers in the same patch to keep the kernel in a
stable state after this patch.

>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index f3a3b761abfb..3d19c888b839 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -5290,13 +5290,18 @@ void skb_warn_bad_offload(const struct sk_buff *skb);
>>  
>>  static inline bool net_gso_ok(netdev_features_t features, int gso_type)
>>  {
>> -	netdev_features_t feature = (netdev_features_t)gso_type << NETIF_F_GSO_SHIFT;
>> +	netdev_features_t feature;
>> +
>> +	if (gso_type & (SKB_GSO_TCP_FIXEDID | SKB_GSO_TCP_FIXEDID_INNER))
>> +		gso_type |= __SKB_GSO_TCP_FIXEDID;
>> +
>> +	feature = ((netdev_features_t)gso_type << NETIF_F_GSO_SHIFT) & NETIF_F_GSO_MASK;
>>  
>>  	/* check flags correspondence */
>>  	BUILD_BUG_ON(SKB_GSO_TCPV4   != (NETIF_F_TSO >> NETIF_F_GSO_SHIFT));
>>  	BUILD_BUG_ON(SKB_GSO_DODGY   != (NETIF_F_GSO_ROBUST >> NETIF_F_GSO_SHIFT));
>>  	BUILD_BUG_ON(SKB_GSO_TCP_ECN != (NETIF_F_TSO_ECN >> NETIF_F_GSO_SHIFT));
>> -	BUILD_BUG_ON(SKB_GSO_TCP_FIXEDID != (NETIF_F_TSO_MANGLEID >> NETIF_F_GSO_SHIFT));
>> +	BUILD_BUG_ON(__SKB_GSO_TCP_FIXEDID != (NETIF_F_TSO_MANGLEID >> NETIF_F_GSO_SHIFT));
>>  	BUILD_BUG_ON(SKB_GSO_TCPV6   != (NETIF_F_TSO6 >> NETIF_F_GSO_SHIFT));
>>  	BUILD_BUG_ON(SKB_GSO_FCOE    != (NETIF_F_FSO >> NETIF_F_GSO_SHIFT));
>>  	BUILD_BUG_ON(SKB_GSO_GRE     != (NETIF_F_GSO_GRE >> NETIF_F_GSO_SHIFT));
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index ca8be45dd8be..cf95b325f9b4 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -674,7 +674,7 @@ enum {
>>  	/* This indicates the tcp segment has CWR set. */
>>  	SKB_GSO_TCP_ECN = 1 << 2,
>>  
>> -	SKB_GSO_TCP_FIXEDID = 1 << 3,
>> +	__SKB_GSO_TCP_FIXEDID = 1 << 3,
>>  
>>  	SKB_GSO_TCPV6 = 1 << 4,
>>  
>> @@ -707,6 +707,10 @@ enum {
>>  	SKB_GSO_FRAGLIST = 1 << 18,
>>  
>>  	SKB_GSO_TCP_ACCECN = 1 << 19,
>> +
>> +	/* These don't correspond with netdev features. */
> 
> Can use clarification. Something like
> 
>     /* These indirectly together map onto the same netdev feature:
>      * If NETIF_F_TSO_MANGLE is set it may mangle both inner and outer.
>      */

NP. I'll use something like the comment you suggested.

>> +	SKB_GSO_TCP_FIXEDID = 1 << 30,
>> +	SKB_GSO_TCP_FIXEDID_INNER = 1 << 31,
>>  };
>>  
>>  #if BITS_PER_LONG > 32
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 93a25d87b86b..f57c8dbf307f 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -3769,7 +3769,9 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>>  		features &= ~dev->gso_partial_features;
>>  
>>  	/* Make sure to clear the IPv4 ID mangling feature if the
>> -	 * IPv4 header has the potential to be fragmented.
>> +	 * IPv4 header has the potential to be fragmented. For
>> +	 * encapsulated packets, the outer headers are guaranteed to
>> +	 * have incrementing IDs if DF is not set.
> 
> This is saying that if !DF then both inner and outer must be
> incrementing?
> 
> Maybe the outer headers are [also] garuanteed to have incrementing IDs.
> 

You mean the inner headers? What I'm saying is that there is no need to clear
the MANGLEID feature if the outer header doesn't have the DF-bit set, since the
driver is guaranteed to generate incrementing IDs for the outer header in that case.
I also stated this in the documentation. See my previous discussion with Paolo.
I'll change this comment so that it is a bit clearer.

Discussion with Paolo: https://lore.kernel.org/netdev/a88ee88c-707f-4266-b514-d0390166dedb@gmail.com/

>>  	 */
>>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
>>  		struct iphdr *iph = skb->encapsulation ?
>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>> index 76e38092cd8a..fc7a6955fa0a 100644
>> --- a/net/ipv4/af_inet.c
>> +++ b/net/ipv4/af_inet.c
>> @@ -1393,14 +1393,13 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
>>  
>>  	segs = ERR_PTR(-EPROTONOSUPPORT);
>>  
>> -	if (!skb->encapsulation || encap) {
>> -		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
>> -		fixedid = !!(skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID);
>> +	/* fixed ID is invalid if DF bit is not set */
>> +	fixedid = !!(skb_shinfo(skb)->gso_type & (SKB_GSO_TCP_FIXEDID << encap));
>> +	if (fixedid && !(ip_hdr(skb)->frag_off & htons(IP_DF)))
>> +		goto out;
>>  
>> -		/* fixed ID is invalid if DF bit is not set */
>> -		if (fixedid && !(ip_hdr(skb)->frag_off & htons(IP_DF)))
>> -			goto out;
>> -	}
>> +	if (!skb->encapsulation || encap)
>> +		udpfrag = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP);
>>  
>>  	ops = rcu_dereference(inet_offloads[proto]);
>>  	if (likely(ops && ops->callbacks.gso_segment)) {
>> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
>> index 1949eede9ec9..e6612bd84d09 100644
>> --- a/net/ipv4/tcp_offload.c
>> +++ b/net/ipv4/tcp_offload.c
>> @@ -471,7 +471,6 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>>  	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
>>  	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
>>  	struct tcphdr *th = tcp_hdr(skb);
>> -	bool is_fixedid;
>>  
>>  	if (unlikely(NAPI_GRO_CB(skb)->is_flist)) {
>>  		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;
>> @@ -485,10 +484,8 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>>  	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
>>  				  iph->daddr, 0);
>>  
>> -	is_fixedid = (NAPI_GRO_CB(skb)->ip_fixedid >> skb->encapsulation) & 1;
>> -
>>  	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
>> -			(is_fixedid * SKB_GSO_TCP_FIXEDID);
>> +			(NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXEDID);
> 
> This was only just introduced. And is still needed?
> 

This was only introduced so that the previous patch doesn't affect GSO, to make each
patch more independent. Now that GSO is fixed, it is not needed.


