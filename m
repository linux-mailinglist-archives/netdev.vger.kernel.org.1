Return-Path: <netdev+bounces-215717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC21B2FFF7
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 18:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28694AA719B
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397FB2DCF5C;
	Thu, 21 Aug 2025 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScTQ41bp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9BE2DCF64;
	Thu, 21 Aug 2025 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793230; cv=none; b=EWFpfWL6QCRm50c2OxY2/jHI9QQaE5GS3xndhPbZQHO7LOzaEjrBSfOLqZCTyPE+oOB7FgJuhjIGDDVuxosrgIdsD68MO7rLlQTVA1jUJugOQyL3U+Db2F+hFWvrCXOnd6/f2v1hd6pX5tc1M6+F+VcQWBeLWdq1jgpWG0MTFI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793230; c=relaxed/simple;
	bh=sMZvPRmxIzLZOBsAaxdk8g3K8/DQ1bF2jN04/GYPUYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OTQejEqrWfjWKar6IMN8nDd1g7z4mQR7SAQMMl9/nHilCRComNBPi59tR1hzAf1mBfn1t8UG+rXxwQf1+UFAz44v3UgtH+QOrjG2sACs7FviU2q816gEZK4YVppddr5EyZ4rkXoGGr+qcEmq1ODGpDKmCfL2dWD26NuyXtMpZHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScTQ41bp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a15fd04d9so15449745e9.1;
        Thu, 21 Aug 2025 09:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755793227; x=1756398027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C1DDXfK0JQI8YQ8TIQurDiZk7xuap/EpVtq0nF7fNZQ=;
        b=ScTQ41bpYPEhyjHr0iRr71KZR4FTrrYeAWjaeYZBqfpvSMlIH/IT8yZF4O2Z9yUwYP
         q9xAyNE1cMZEiIV+OSf/RmdNLKI+CiV7nUuzDuwBLSZbqSTr0FJF/fIOOqkazI1gRX3Z
         yqaD3z33+CcnJ/QmbzxFdMNyEDxhUM5RW7PSVRY3qtOnenio++UCmWBKMdl6ocUaqq0P
         Vfy4oRaIhLpfV/2b2R78ls2roHj5LqfRGjvnqGOnDPpL0/V89K54QbGid8JGNxOT1yZt
         XFjXD+GHsJ/ql45tvolyZvaS5RvXQoatbtcqr2MvKpi9G/NQ0sF4wCGzouMYluNijG1H
         ktbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755793227; x=1756398027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1DDXfK0JQI8YQ8TIQurDiZk7xuap/EpVtq0nF7fNZQ=;
        b=QHo/X0NHjxRlZsx5EmAcsK046COQjyjTPq850K0J9EfhMFTFiS/vtaHk8eUwf9jOkg
         VM36/KYAr+hwlPNnhgx1ypl75KK3YkWpDydYULxkmr6+OXw8r7vd2AbQd0xron823Ldf
         ckRSFBYscnxxtU/FdiSOqOGA57cCSqlqbTHTL6/VU6woe6800k9oBBW1OLqgTzkNdtMi
         CSadbp/1d63L8iUlFCb1rAyJcsI5RMvY/nQTZdK2OGCcDDzSfGEFNpJgjlfaVqjzDeUO
         b1xPgXhQqH5837tKxbYG3h1rACPqEt/9LLlbRllZxIAl0DbwKK6eor9e/ZonhQ5NjRyo
         3fLA==
X-Forwarded-Encrypted: i=1; AJvYcCVd+vLsCqV9n7kBhJVpEJuy45kezMcko/hMw68PzgjHmsODV3znKoJ2dPy+p224PPEvBx85hgif@vger.kernel.org, AJvYcCX0Raj7jwQIdJI26Sk5qfsVSJBPLqbFhiDUqTmINO4UQX+zOI4pyV1j97zUK7RX8tM8qNa2/RzHd1Hn6K0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3JF1OoXQ76QLiviyC9naEEzl6swEH9ikONYplZ8buZnhbh+V+
	/D0R5ISzJ3VhikOYd3og+B8+a23ci9TxkAAaglu8gGuFRkVqdBPB0020
X-Gm-Gg: ASbGncuTVE3q78P8Jgj96PzQKf6ZNj/WPBmr3OPaThmYEQLkj6hSV8SUnbpMk//l1pA
	xDvm8kgtpSbMHmJrQATpFusX9geqcSQ3aOS1x1oW02S7tIHCxOP5JxOFWyWETLiH6ZBYWwekl1N
	sBTb1LLyNfw+EH7afVbFBmyoGTAVfdu3QeBUY1YsT6g7/2SFJiF/xKX/Fv8PgOr/uk0R2Ut+cmE
	5jAorBNF3pqqKTAhJ+hb3Ozf6GNohCsF2ZN6UlkHu+pXgoX+1ulPJbZmgBsvMOHckuMXVKTi3t8
	NYfgSQSHM/RQ9cbnWAs+P/uWSSkPj7wR7+OYr81rqv4MIBjfDD6ACEGSMTq16PVsheqwv2l5YPz
	pGUujqubMklKd1nG/JvbkyLJTnluOvdLv8FkUIfDicFX0ZlG4ASJUsClDGiDyp+EzqxgijzaSOw
	SFEZ/qNQcno5+M9J2qWtYg
X-Google-Smtp-Source: AGHT+IE775LkVT8louURxsf2Sd7VsARCIMMo7L27xzQM2BghtfUSr5azScgz3G+lycxEHM+X9kOuyg==
X-Received: by 2002:a05:600c:5249:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-45b4d8de696mr30103365e9.3.1755793226461;
        Thu, 21 Aug 2025 09:20:26 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1a97sm12123415f8f.31.2025.08.21.09.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 09:20:25 -0700 (PDT)
Message-ID: <73927f0c-f6aa-464b-ab20-559196e015a8@gmail.com>
Date: Thu, 21 Aug 2025 17:20:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/5] net: gso: restore ids of outer ip headers
 correctly
To: Richard Gobert <richardbgobert@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org, dsahern@kernel.org,
 ncardwell@google.com, kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me,
 aleksander.lobakin@intel.com, florian.fainelli@broadcom.com,
 willemdebruijn.kernel@gmail.com, alexander.duyck@gmail.com,
 linux-kernel@vger.kernel.org, linux-net-drivers@amd.com
References: <20250821073047.2091-1-richardbgobert@gmail.com>
 <20250821073047.2091-4-richardbgobert@gmail.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250821073047.2091-4-richardbgobert@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/08/2025 08:30, Richard Gobert wrote:
> Currently, NETIF_F_TSO_MANGLEID indicates that the inner-most ID can
> be mangled. Outer IDs can always be mangled.
> 
> Make GSO preserve outer IDs by default, with NETIF_F_TSO_MANGLEID allowing
> both inner and outer IDs to be mangled. In the future, we could add
> NETIF_F_TSO_MANGLEID_INNER to provide more granular control to
> drivers.
> 
> This commit also modifies a few drivers that use SKB_GSO_FIXEDID directly.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
...
> diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
> index e6b6be549581..4efd22b44986 100644
> --- a/drivers/net/ethernet/sfc/ef100_tx.c
> +++ b/drivers/net/ethernet/sfc/ef100_tx.c
> @@ -189,7 +189,8 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>  {
>  	bool gso_partial = skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL;
>  	unsigned int len, ip_offset, tcp_offset, payload_segs;
> -	u32 mangleid = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
> +	u32 mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
> +	u32 mangleid_inner = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
>  	unsigned int outer_ip_offset, outer_l4_offset;
>  	u16 vlan_tci = skb_vlan_tag_get(skb);
>  	u32 mss = skb_shinfo(skb)->gso_size;
> @@ -201,7 +202,9 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>  	u32 paylen;
>  
>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
> -		mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
> +		mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
> +	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_INNER)
> +		mangleid_inner = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
>  	if (efx->net_dev->features & NETIF_F_HW_VLAN_CTAG_TX)
>  		vlan_enable = skb_vlan_tag_present(skb);
>  
> @@ -239,14 +242,13 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>  			      ESF_GZ_TX_TSO_CSO_INNER_L4, 1,
>  			      ESF_GZ_TX_TSO_INNER_L3_OFF_W, ip_offset >> 1,
>  			      ESF_GZ_TX_TSO_INNER_L4_OFF_W, tcp_offset >> 1,
> -			      ESF_GZ_TX_TSO_ED_INNER_IP4_ID, mangleid,
> +			      ESF_GZ_TX_TSO_ED_INNER_IP4_ID, mangleid_inner,
>  			      ESF_GZ_TX_TSO_ED_INNER_IP_LEN, 1,
>  			      ESF_GZ_TX_TSO_OUTER_L3_OFF_W, outer_ip_offset >> 1,
>  			      ESF_GZ_TX_TSO_OUTER_L4_OFF_W, outer_l4_offset >> 1,
>  			      ESF_GZ_TX_TSO_ED_OUTER_UDP_LEN, udp_encap && !gso_partial,
>  			      ESF_GZ_TX_TSO_ED_OUTER_IP_LEN, encap && !gso_partial,
> -			      ESF_GZ_TX_TSO_ED_OUTER_IP4_ID, encap ? mangleid :
> -								     ESE_GZ_TX_DESC_IP4_ID_NO_OP,
> +			      ESF_GZ_TX_TSO_ED_OUTER_IP4_ID, mangleid_outer,
>  			      ESF_GZ_TX_TSO_VLAN_INSERT_EN, vlan_enable,
>  			      ESF_GZ_TX_TSO_VLAN_INSERT_TCI, vlan_tci
>  		);

AFAICT this will now, in the case when FIXEDID isn't set, set
 ESF_GZ_TX_TSO_ED_OUTER_IP4_ID on non-encapsulated frames, for which
 ESF_GZ_TX_TSO_OUTER_L3_OFF_W has been set to 0.  I'm not 100% sure,
 but I think that will cause the NIC to do an INC_MOD16 on octets 4
 and 5 of the packet, corrupting the Ethernet header.
Please retain the existing logic whereby ED_OUTER_IP4_ID is set to
 NO_OP in the !encap case.
Note that the EF100 host interface's semantics take the view that an
 unencapsulated packet has an INNER and no OUTER header, which AIUI
 is the opposite to how your new gso_type flags are defined, so I
 think for !encap you also need to set mangleid_inner based on
 SKB_GSO_TCP_FIXEDID, rather than SKB_GSO_TCP_FIXEDID_INNER.

My apologies for not spotting this in earlier versions.

