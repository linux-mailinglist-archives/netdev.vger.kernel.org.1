Return-Path: <netdev+bounces-218929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72313B3F067
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 23:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0256E1A80A16
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 21:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1571A42049;
	Mon,  1 Sep 2025 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxhglIue"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BA5B67F;
	Mon,  1 Sep 2025 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756761326; cv=none; b=G0o3GB8Bj6BtJsWrWo/s1BeF9v1og1bgbhAf3sfCd26DK+qGtgdLf9HTDMn7cD/defEpJo7Ep1t6uMpqZWcF6PvmsrNv5gRC9pzNgigYiAA0c6ctRSqJflDpX5v4FXMPS8nZdiHIwLrqsMdNJLvukHN/3BJ+EVxP/zjWIuoYeck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756761326; c=relaxed/simple;
	bh=8zUoEQvrtlfwOr9NXnt/0+aoO/B3EsanyptdA/qacNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6Z95q80hsOGsyDV9WqE2o0HEtLhCvRGIvq9mNleXFA2DPm42qSCJhuSdLGsQnhenIaaQE82979cfdxAdXXd+3tijMRnY9PnMYod5//LVH1Ky0hvtff1+M+oVjo9C1cLU1auLk0rd9SCWa5CEHTrbcu7owmu8pDoGG1mjv4PnL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxhglIue; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b873a2092so19022155e9.1;
        Mon, 01 Sep 2025 14:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756761323; x=1757366123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SEiJAaXmFIGciLe42hjKncbNPOpoGkguWziBkuSpJJs=;
        b=RxhglIue4c0aay9LoUK/IA033L2WbATghQ9Fk2XvVkx9XAJi1q4huznW8LPjALJlk4
         qagnoTSh3Mbq1KjGh8W2LCOitrKpCZEFD0fdXKCT9xGB1t+L8La0cnQ4v1JKdHNeWfIa
         DO2PupIRxOT7TkM2hxXNK1ycIFMnz6U0h2heg2yvBQ33IrDJl3bVJr4AT7JX6JWkbxDP
         nNiDeU86n+vePLaKn8QL4C1sbzqmtJ+0ClEL4RoiUNuHOcw0hoFoHZg/CkAURDiqIfhn
         dCxpLjoeLCxVTuY1+F+8PNGF83wRBb3Yg2kuC5sGdE5703nGZ0THessa+lh8c+MjzpLV
         q9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756761323; x=1757366123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SEiJAaXmFIGciLe42hjKncbNPOpoGkguWziBkuSpJJs=;
        b=Dp3xccuQw+tbeNjI1NYV/qpBxXa8FFBxREO9dqdvurVhTBJOQ6ppw1aOcTaDmrAvGs
         wU/ROx2BgVqWetn14ALTsRwMMwEIgeQA3LzTHPHFo+SkMwFaRVclfnnoqXi8iS8TEo11
         PwoABXwxjzmFYaGUSMiK9E1IWQu81HaKZePCMofJG+B6jx0+vzJj+J5pA6yrCGBZ6+Zr
         nssrLDFqny5z76lvCt2q3erWAiCU68bv4WOkB2dcAYrUwiR1Az9AIZdYRn/zZDWJ5YP2
         lZ+49XbJyDidDmufuvkPM4T1/yi5RapQoBjXTkXtYlcidTjThn2VpmZh6MRzIFKTM5Rd
         j4Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWrHkrjhjgwKeH+b6cqT8fEOTBJIlPOjUKEmySzlGOtJKk1uCHfs/YBmPb0ZPnDof3Ey92SRmTZgZNCzCU=@vger.kernel.org, AJvYcCWxLRjLNCjLV9ZZ1BZNzfWJk29l1/+FwCbGiW7kY4p3s22k3wncu1+pxol3YUO2CGz2di/4/mMr@vger.kernel.org
X-Gm-Message-State: AOJu0YwVpAgtNBXlTwiy5sBz5Lr1VSoZlr3oZ2/j41MgVwCcYAErrAru
	bXF70Pruoz84HvrYNT/kQ5XUWuln3zPXgKD7sot1GbC74n/4fJcSaM/U
X-Gm-Gg: ASbGncuHJRUBCrc1xLfalobFcdLvJqA7sHw1wjuy2X28n9aWmXQgjnh6OVBawg2mOJ9
	05u8PZUY0y1Lbyvr4RQI7jBbgxkzfx9VB9U8iVxABk3sLJEBBeSH40xG0VKTVvsxTVWEioEITDb
	byIrvCd8c2eRpdZBhUpFlpmnTQ5hFT8xX/K9yRrR///cL5IV1O7JcOiT3T4qd+Kt+0nVGQyVByJ
	/5gulnbxJf/sDdVfjwVOJMex7YrK9RPUEif+mkFdHdE3731ee4r78lDHKXDoXaQlM0hODOkylMH
	ZEAMFe4zuWqiggzJIaHYm72Nx4XxgX6jgYE1cCNTYwWmYGc0NzIXVIEwpNflrPqND8KUAqtNipZ
	H6xBrbkW5wy9AB8dupcDqrm1Gjmiz5gcKb3R+kD0rw0NbXrBVmVGappfbr3/OgE8rHvJRU7Cmqp
	ol2ePMCm2vWA==
X-Google-Smtp-Source: AGHT+IFzWGRag9fzC9zDs8pjFqgAO9+NbXGM7L6GV0YKnQ6dDbcYiEmW/cMGhlaH1cSXcAHPMa/qTA==
X-Received: by 2002:a5d:5888:0:b0:3ca:ca52:adb8 with SMTP id ffacd0b85a97d-3d1dfcfb9a8mr7763445f8f.36.1756761322432;
        Mon, 01 Sep 2025 14:15:22 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d53fda847dsm7717499f8f.0.2025.09.01.14.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 14:15:21 -0700 (PDT)
Message-ID: <27e61dda-c76f-4c8a-bf08-6fa6761e638d@gmail.com>
Date: Mon, 1 Sep 2025 22:15:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/5] net: gso: restore ids of outer ip headers
 correctly
To: Richard Gobert <richardbgobert@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org, dsahern@kernel.org,
 ncardwell@google.com, kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me,
 aleksander.lobakin@intel.com, florian.fainelli@broadcom.com,
 willemdebruijn.kernel@gmail.com, alexander.duyck@gmail.com,
 linux-kernel@vger.kernel.org, linux-net-drivers@amd.com
References: <20250901113826.6508-1-richardbgobert@gmail.com>
 <20250901113826.6508-4-richardbgobert@gmail.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250901113826.6508-4-richardbgobert@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/09/2025 12:38, Richard Gobert wrote:
> Currently, NETIF_F_TSO_MANGLEID indicates that the inner-most ID can
> be mangled. Outer IDs can always be mangled.
> 
> Make GSO preserve outer IDs by default, with NETIF_F_TSO_MANGLEID allowing
> both inner and outer IDs to be mangled.
> 
> This commit also modifies a few drivers that use SKB_GSO_FIXEDID directly.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
> diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
> index e6b6be549581..24971346df00 100644
> --- a/drivers/net/ethernet/sfc/ef100_tx.c
> +++ b/drivers/net/ethernet/sfc/ef100_tx.c
> @@ -190,6 +190,7 @@ static void ef100_make_tso_desc(struct efx_nic *efx,
>  	bool gso_partial = skb_shinfo(skb)->gso_type & SKB_GSO_PARTIAL;
>  	unsigned int len, ip_offset, tcp_offset, payload_segs;
>  	u32 mangleid = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
> +	u32 mangleid_outer = ESE_GZ_TX_DESC_IP4_ID_INC_MOD16;
>  	unsigned int outer_ip_offset, outer_l4_offset;
>  	u16 vlan_tci = skb_vlan_tag_get(skb);
>  	u32 mss = skb_shinfo(skb)->gso_size;

Reverse xmas tree.
With that fixed you can add my Reviewed-by: Edward Cree <ecree.xilinx@gmail.com> # for sfc

