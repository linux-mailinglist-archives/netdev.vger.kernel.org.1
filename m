Return-Path: <netdev+bounces-171764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B65A4E815
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C52107A129C
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4D5298CB0;
	Tue,  4 Mar 2025 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="UKXAJCR1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C189C298CA1
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107008; cv=none; b=lIfdnbGhpnrmSxCngmvC4L15BlZXQMnNO26cvgYAHST5u/bNuyxJOwzQSfqIST4xl+SaDzfwz86kuL9IrAnB/d+HEFxyUODDC08aG/GqC1MRg/T2BfVu4N3cT05qckVfK3mVimiEBLGUez0dIDmazGn2acnRocvGNsAALXiBqqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107008; c=relaxed/simple;
	bh=L8HHTMU8DmC+6N2WJp3kjc3+BlXX6m9YnXOf1KwXSx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOP8OXb/ED6zGvuKrfRGo8QRyFedE6pjL0lT6vOaBas0mptqBnTxXWUuaOHF+c7Z1c1hROr08MVXXWHYFkH/3yzKtmc1/K057uFVEi633H/hpWMWyqBMS58l5gDrfdA+d0XBgvKr/sEM5/3vXq7X9Uy0gVDOebOI+jfFCSSSxRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=UKXAJCR1; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-60010601291so445385eaf.3
        for <netdev@vger.kernel.org>; Tue, 04 Mar 2025 08:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1741107006; x=1741711806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FFC/0VaDOfAur/tgnlAkpmmS5lpWwryf/b8rBN6y4bk=;
        b=UKXAJCR1/tTwsmoZ4x9nqIHt3iJiOx3wg33jD7tZPm4GLZj0FXhiwRnDlQRI/UFsRM
         tHKZcH9BJP8yWCXszhuuYxWjUZOvTT6tVJxqCkm4gBKbN+ayHH9Q9A14mcBlJfzYH6PC
         8PToCT73Xt0d8SlldeLUsM5g/ZQBOPRrDY1dsJBF3XQJs9Nev83VvY/mB4RaklGM2N0E
         0SSdfPRgLIwVPAFR0kEDKq8cSUXXMgV/5m3hRWmcxM//NO5gfr9sld21ztQXusoRUeMf
         AaFS1gA5FrXeKYYzznxCqHaquThoDbNg6ESjB/hsD8NmTsb0E0iWBLdj89MfdQZRrNKU
         D/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107006; x=1741711806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFC/0VaDOfAur/tgnlAkpmmS5lpWwryf/b8rBN6y4bk=;
        b=NdlkpliKas+WTMNBk+ETC2o+pd7pq44WFgekGWOTgoA/+e5cHr/VBvvuztWURPcvCM
         2JYiUpQFFa+KaQQ+cqoJTTI7v2IvSrCBDTy1eb0+4fZaEPPXgyVkNyOeArXQ5ZjnzmRe
         FmhBuUPg24QoShUXuqf1J7qZIMAfGlCPuHXD0cDmpXscrh1GUHW1wGEMgaIU1bvVlB2t
         OF+AiKuo79bnQZYxL1faVXLR6sC/D4ZK4zd7rQ53W3Sy6pAQEhgVA19gSlzwZQj7MUPL
         ySUvQazDPk8OShbWQnLSDpk4FvsNNa822kptnslKwfjQP6CV8QYZSmIeB6rrFtpT1EnE
         GHiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWojUMmm8XfzKAa+PXDJskyi/yaLQG6i2o4O8lvi1/2XzjvDtl8zDwVRkKzTCop7j091Hs9upo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxepNEpx7H/MG0HCBLna0kWstjTPWuYpRJcPaoVvJZVpyYcPMuU
	FVGP7JHqMDCX+ZWYEUtKkx25W1QOnMowU2NdilEbIXg03Hcg6txVNwViA2TTtHk=
X-Gm-Gg: ASbGnctWYOPS6dbictVm8Ga6DrIZ8vqfQCAHEk9f7tRiTV7Y4F5wtvDLKoBzJI8x+mJ
	B72cl7BbqoJy40T5qwJf7edBeNk7rNkT0OSKV0Su/3wDnvZgH9QWjWntNCYadrkMpu6QugFHtlt
	P8MvzRmgX+npCJnzicZbrlGRjciRlmsjrwuNr8yf8VWuknS0b+3Z1nyMMqdphN3mm0x9PeQrRIw
	9vQAZ/8oLbEnCtzfq1OVYaw15mBUixet8okeyUmRaaX/lX0a0i2jM4DeobECGhV2WhY6+QyScbl
	l41DyjPyXv0YEgdOIYmmoJrxcKS69Lvw/hb7qrqKEDkqns+clYyLo5Q914NjYfqxSUqlnO6ux1/
	/GzCbqV3o
X-Google-Smtp-Source: AGHT+IENf5TzZy2paUOp2+yHiImyvpIf605z0YIuqY3weTYHuWBj9XQYDXLVtnPEtkn/E/5Jk+cT9w==
X-Received: by 2002:a05:6871:53c9:b0:29d:c5e8:e41f with SMTP id 586e51a60fabf-2c1782c5bb3mr11456642fac.5.1741107005688;
        Tue, 04 Mar 2025 08:50:05 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c15c45e81bsm2333459fac.50.2025.03.04.08.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 08:50:05 -0800 (PST)
Message-ID: <f8a6aea3-fa69-4c59-bccc-ae6e5021d5f3@riscstar.com>
Date: Tue, 4 Mar 2025 10:50:03 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] net: ipa: Fix v4.7 resource group names
To: Luca Weiss <luca.weiss@fairphone.com>, Alex Elder <elder@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227-ipa-v4-7-fixes-v1-0-a88dd8249d8a@fairphone.com>
 <20250227-ipa-v4-7-fixes-v1-1-a88dd8249d8a@fairphone.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250227-ipa-v4-7-fixes-v1-1-a88dd8249d8a@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/25 4:33 AM, Luca Weiss wrote:
> In the downstream IPA driver there's only one group defined for source
> and destination, and the destination group doesn't have a _DPL suffix.
> 
> Fixes: b310de784bac ("net: ipa: add IPA v4.7 support")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

FYI, I used this to check what you're saying:
  
https://git.codelinaro.org/clo/la/platform/vendor/opensource/dataipa/-/blob/clo/main/drivers/platform/msm/ipa/ipa_v3/ipa_utils.c

This looks good, thanks a lot for the patch.

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
>   drivers/net/ipa/data/ipa_data-v4.7.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ipa/data/ipa_data-v4.7.c b/drivers/net/ipa/data/ipa_data-v4.7.c
> index c8c23d9be961b1b818e8a1592a7f7dd76cdd5468..7e315779e66480c2a3f2473a068278ab5e513a3d 100644
> --- a/drivers/net/ipa/data/ipa_data-v4.7.c
> +++ b/drivers/net/ipa/data/ipa_data-v4.7.c
> @@ -28,12 +28,10 @@ enum ipa_resource_type {
>   enum ipa_rsrc_group_id {
>   	/* Source resource group identifiers */
>   	IPA_RSRC_GROUP_SRC_UL_DL			= 0,
> -	IPA_RSRC_GROUP_SRC_UC_RX_Q,
>   	IPA_RSRC_GROUP_SRC_COUNT,	/* Last in set; not a source group */
>   
>   	/* Destination resource group identifiers */
> -	IPA_RSRC_GROUP_DST_UL_DL_DPL			= 0,
> -	IPA_RSRC_GROUP_DST_UNUSED_1,
> +	IPA_RSRC_GROUP_DST_UL_DL			= 0,
>   	IPA_RSRC_GROUP_DST_COUNT,	/* Last; not a destination group */
>   };
>   
> @@ -81,7 +79,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
>   		},
>   		.endpoint = {
>   			.config = {
> -				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL_DPL,
> +				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL,
>   				.aggregation	= true,
>   				.status_enable	= true,
>   				.rx = {
> @@ -128,7 +126,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
>   		},
>   		.endpoint = {
>   			.config = {
> -				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL_DPL,
> +				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL,
>   				.qmap		= true,
>   				.aggregation	= true,
>   				.rx = {
> @@ -197,12 +195,12 @@ static const struct ipa_resource ipa_resource_src[] = {
>   /* Destination resource configuration data for an SoC having IPA v4.7 */
>   static const struct ipa_resource ipa_resource_dst[] = {
>   	[IPA_RESOURCE_TYPE_DST_DATA_SECTORS] = {
> -		.limits[IPA_RSRC_GROUP_DST_UL_DL_DPL] = {
> +		.limits[IPA_RSRC_GROUP_DST_UL_DL] = {
>   			.min = 7,	.max = 7,
>   		},
>   	},
>   	[IPA_RESOURCE_TYPE_DST_DPS_DMARS] = {
> -		.limits[IPA_RSRC_GROUP_DST_UL_DL_DPL] = {
> +		.limits[IPA_RSRC_GROUP_DST_UL_DL] = {
>   			.min = 2,	.max = 2,
>   		},
>   	},
> 


