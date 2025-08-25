Return-Path: <netdev+bounces-216488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3082B34092
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 15:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B62207744
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 13:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5109727144B;
	Mon, 25 Aug 2025 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIgPp/Ef"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D02F1D63C7;
	Mon, 25 Aug 2025 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128178; cv=none; b=TcXGo2X4Yvcjwgnj5qfqFBydEhSIrBtxBUL2K3jBPvJaQW+PqdUX5afo54l45/0U3SYv5YdgL6e8ezf8M2ZSL/inyn5nAR3vMNiEvGygZUiMhXzapkGqY84/tBBK5WsJIgZUBDTwNtVdTfyvFV+whSPLOd84qrIwtcKoV5QHsbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128178; c=relaxed/simple;
	bh=6FfxdEbCuKta8gZj6/Erh3FDz950PqObbLnWmsUDw7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2SXI/xH06sQFqKc31zKWU8hoxJyt0hi4tkIGqiDLcmGLwPvOdP4Q2s7LH7drN+toPloadpIg3Dasd+TbVfgIPfe3Ehsc4u+G49c4KioPN8eafUFCiSJQVAUR6MfG7Mc+ZuPDNxxFitx0a+LGigw+Z8r0G+5Oo8GGEKxpZOaIGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIgPp/Ef; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3c6ae25978bso1845779f8f.0;
        Mon, 25 Aug 2025 06:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756128175; x=1756732975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wYIFidEoXC+Ixi9otmXqbeMpQhiKh7SAOAePd+mSueg=;
        b=kIgPp/EfP4GhDcpXpCNh9hLJC/u0QqhaqRtw6al13sUkTtnIAGzMTFzUKZh3GTfPfv
         v2rPzawMsDNFcvuP9XRgpAOLI7m66cGz+Ftry7LmLBb/Jgag3IF1jqYzX56LXReKn445
         xYsdNSfoEEyCVx6ccDALw/e49qfmo4E4eQu7razqnw4yRJTXJtc02cSvVSnG+vlc+EVW
         uDx1HVs3dILf7z8MU8Cc8O0pvxspiAN2oMQ1bN/kpGVkGIW7nD3uN1Sw/IWEQ9rE2li0
         o7dGaLC14vs7aVJ1BTvPrS/9ZB9y/RSp15C6InS1OQDGhQmZuHGMvO1xib1jhtPoYzZi
         bCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756128175; x=1756732975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wYIFidEoXC+Ixi9otmXqbeMpQhiKh7SAOAePd+mSueg=;
        b=KifUu15HaRGflEeFuGSoTunS0NrJBaosXC5EQ1qe6eIMHCge7qc5SRrLq8JXeDn5XK
         5oim9cUIlTHT/duSvu1OVpXB18ko2Nw/HBWRK2ABReviiqGoohrpbarMxg+RmNXZWJ05
         5AzcgGXmlP0AcPRvG7WWOS1FGUQaB3Y0Jzmf06An83CxNbrb+7qnWEJea3zOWTX8q8iF
         KKZJC5HKaBiNg6nuis1bepETPPgdQZ8ArcwcUYXtG5+rwhY6sq68nbKEahlLpyBHJa9T
         evsl/GK+6OWrLBxzlBAF1ks17DnnPEzeCTEiGAp4XOJkyqiNbjNzyEwWC3e1yeuCQM25
         x6LQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAtNy+3xNDjLQh8x9/x1EwX5/eMphTRk6F8joaYAprYBhOCKLmQt+fqnWoJNltC3uc37QC6jaMxJrGYVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzazkfxOpRTxc5WY/Jjy9BGo52ueGZb5pQdvbqsjwFFTrATk6os
	/Z5ZWxCbVG4ToogPXJ0Qz/fOniuIqf+ZN4jI3ffYUm4V6SVu8xBEvR4D
X-Gm-Gg: ASbGncvXsJxYSkaOa59Rng1mLaSsuC7ywghzPtCDfPuHYbFzf7V7zeTRztAJxEdgiXR
	A/NFbuKp3ULrFK5KImLvmjA1QkrcRGmALUBMNT3gTMOr8D4nJTZhNf4gEFh2tEoNMzP/wYEhpin
	/swo6vHeP7nnWMKQYyIZwE8QXd9IbieZoepon2pbm8bSYkPMi7mxviyjOqUWP0kn4ZjPdUy+QYI
	A5Rq7g6oQoRb/AvXFfIA+th4Bb70M6nUAvtVNsklrwplT1BfEpyn4fkQinv7wRv6nMEg/ubg09A
	JWV7QV3TTIvmZ60IMGU+e424PU9/teIGFlGv8LTRkLPjlS/mWvVo4DqLtNm1u8541voWHCFqAFJ
	SDkt60MqXwi+S8J4k2B0iQ06Xhd752ikGe/73Tw==
X-Google-Smtp-Source: AGHT+IEiZwpsH8RlRJd9lX7sTYiok9dlJApxE+JlFELSx2EQCEATekfgUs08jD6+9bn7XwBe7q/B5Q==
X-Received: by 2002:a05:6000:2505:b0:3c9:fc3c:3aa3 with SMTP id ffacd0b85a97d-3c9fc3c3e07mr2375042f8f.40.1756128174281;
        Mon, 25 Aug 2025 06:22:54 -0700 (PDT)
Received: from localhost ([45.10.155.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5749286dsm110651285e9.20.2025.08.25.06.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 06:22:54 -0700 (PDT)
Message-ID: <491aac69-e138-4863-8d42-01b1011fa347@gmail.com>
Date: Mon, 25 Aug 2025 15:22:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 3/5] net: gso: restore ids of outer ip headers
 correctly
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
 dsahern@kernel.org, ncardwell@google.com, kuniyu@google.com,
 shuah@kernel.org, sdf@fomichev.me, aleksander.lobakin@intel.com,
 florian.fainelli@broadcom.com, willemdebruijn.kernel@gmail.com,
 alexander.duyck@gmail.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250821073047.2091-1-richardbgobert@gmail.com>
 <20250821073047.2091-4-richardbgobert@gmail.com>
 <73927f0c-f6aa-464b-ab20-559196e015a8@gmail.com>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <73927f0c-f6aa-464b-ab20-559196e015a8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Edward Cree wrote:
> On 21/08/2025 08:30, Richard Gobert wrote:
>> Currently, NETIF_F_TSO_MANGLEID indicates that the inner-most ID can
>> be mangled. Outer IDs can always be mangled.
>>
>> Make GSO preserve outer IDs by default, with NETIF_F_TSO_MANGLEID allowing
>> both inner and outer IDs to be mangled. In the future, we could add
>> NETIF_F_TSO_MANGLEID_INNER to provide more granular control to
>> drivers.
>>
>> This commit also modifies a few drivers that use SKB_GSO_FIXEDID directly.
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ...
>> diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
>> index e6b6be549581..4efd22b44986 100644
>> --- a/drivers/net/ethernet/sfc/ef100_tx.c
>> +++ b/drivers/net/ethernet/sfc/ef100_tx.c
>> @@ -189,7 +189,8 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>>  {
>>  	bool gso_partial = skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL;
>>  	unsigned int len, ip_offset, tcp_offset, payload_segs;
>> -	u32 mangleid = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
>> +	u32 mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
>> +	u32 mangleid_inner = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
>>  	unsigned int outer_ip_offset, outer_l4_offset;
>>  	u16 vlan_tci = skb_vlan_tag_get(skb);
>>  	u32 mss = skb_shinfo(skb)->gso_size;
>> @@ -201,7 +202,9 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>>  	u32 paylen;
>>  
>>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID)
>> -		mangleid = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
>> +		mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
>> +	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_FIXEDID_INNER)
>> +		mangleid_inner = ESE_GZ_TX_DESC_IP4_ID_NO_OP;
>>  	if (efx->net_dev->features & NETIF_F_HW_VLAN_CTAG_TX)
>>  		vlan_enable = skb_vlan_tag_present(skb);
>>  
>> @@ -239,14 +242,13 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>>  			      ESF_GZ_TX_TSO_CSO_INNER_L4, 1,
>>  			      ESF_GZ_TX_TSO_INNER_L3_OFF_W, ip_offset >> 1,
>>  			      ESF_GZ_TX_TSO_INNER_L4_OFF_W, tcp_offset >> 1,
>> -			      ESF_GZ_TX_TSO_ED_INNER_IP4_ID, mangleid,
>> +			      ESF_GZ_TX_TSO_ED_INNER_IP4_ID, mangleid_inner,
>>  			      ESF_GZ_TX_TSO_ED_INNER_IP_LEN, 1,
>>  			      ESF_GZ_TX_TSO_OUTER_L3_OFF_W, outer_ip_offset >> 1,
>>  			      ESF_GZ_TX_TSO_OUTER_L4_OFF_W, outer_l4_offset >> 1,
>>  			      ESF_GZ_TX_TSO_ED_OUTER_UDP_LEN, udp_encap && !gso_partial,
>>  			      ESF_GZ_TX_TSO_ED_OUTER_IP_LEN, encap && !gso_partial,
>> -			      ESF_GZ_TX_TSO_ED_OUTER_IP4_ID, encap ? mangleid :
>> -								     ESE_GZ_TX_DESC_IP4_ID_NO_OP,
>> +			      ESF_GZ_TX_TSO_ED_OUTER_IP4_ID, mangleid_outer,
>>  			      ESF_GZ_TX_TSO_VLAN_INSERT_EN, vlan_enable,
>>  			      ESF_GZ_TX_TSO_VLAN_INSERT_TCI, vlan_tci
>>  		);
> 
> AFAICT this will now, in the case when FIXEDID isn't set, set
>  ESF_GZ_TX_TSO_ED_OUTER_IP4_ID on non-encapsulated frames, for which
>  ESF_GZ_TX_TSO_OUTER_L3_OFF_W has been set to 0.  I'm not 100% sure,
>  but I think that will cause the NIC to do an INC_MOD16 on octets 4
>  and 5 of the packet, corrupting the Ethernet header.
> Please retain the existing logic whereby ED_OUTER_IP4_ID is set to
>  NO_OP in the !encap case.
> Note that the EF100 host interface's semantics take the view that an
>  unencapsulated packet has an INNER and no OUTER header, which AIUI
>  is the opposite to how your new gso_type flags are defined, so I
>  think for !encap you also need to set mangleid_inner based on
>  SKB_GSO_TCP_FIXEDID, rather than SKB_GSO_TCP_FIXEDID_INNER.
> 
> My apologies for not spotting this in earlier versions.

Will fix this in v4. Thanks!


