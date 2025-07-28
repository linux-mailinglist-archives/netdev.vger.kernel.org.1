Return-Path: <netdev+bounces-210513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 930A9B13B5D
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09EE189B898
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 13:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFE9256C61;
	Mon, 28 Jul 2025 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhdyKEvC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F6B24678A;
	Mon, 28 Jul 2025 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708786; cv=none; b=EvujIYrRYpCB/ekHlJ9cN5sJHjSxf6WSNxkOaaSXGHAUVJ6Bd4ZZ4ZJSQ0rBwuho1/iCiiJgNsx5XwkkjA7AwLcoJPe02p0aBKx0IO8HJmKctLTAEK5phBM1JnA6Wff55LecBTPb9tNdd7R7NIiQHJI0/aSnHxvil98kLKTQuM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708786; c=relaxed/simple;
	bh=J1lkMDI/BRDa7tWiFtEJ9itXbbeI08A0BYzHRlb95Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqQ7Bb2lZ31CuifVw16n5/uDHZtmnMnNFh0eGHMKcw8AF5BYYjrQkNDzNVRbflZ8s1DP507DYGwXzNsl9F1IveqNXUhNgmF83dfI9G1waT+L4+6imagFqXzvIsyos0bf2Kp9ZZOCpZ/cFI3chdLakWqaBCNCsed4SmL0sYoALnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhdyKEvC; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b78bca0890so303466f8f.3;
        Mon, 28 Jul 2025 06:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753708783; x=1754313583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fh8ivYdxvZqAr4NAtGDvGF5i11OMSJKfBEXYWVw7xKc=;
        b=KhdyKEvC/jJZQPvu2MTkvbM/xNWFlqupDNGyq/P4mfpwM6tQnDCHJ9TP2F05X9ZmDt
         8d7cqGqm0K15X+X0z28QIAGcaZkbSXSf98dUZA6Mw8X4qwXsPLRYdRZ7dg62RpjfU4Rj
         TuRZSS3DGlCS3LtwhYX52kCdqNJkHQnMxADiOWvJAovczGKfHV+0vHLEBaAo4S2wfF2k
         TJbQrch4NKB5BW2XoAVOXTEgyBEOX7v8rGXgn173I4GGMIXSyYwiO5knlGtuKuyaUCnI
         lS9Jub2QfHfsinDp1+lm8rupiIKv5yrZrw2CDLvfw/vyUOvNVGocrMzlqWsBHLemr16Z
         LFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753708783; x=1754313583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh8ivYdxvZqAr4NAtGDvGF5i11OMSJKfBEXYWVw7xKc=;
        b=ixOTOr7qY9fI1HJrAc7xH377qtiP/fqtaq0nzvIo+h45sAwMwkNYH80GDXTP+MT+h3
         nGIkY4SUvBiD5HpOde7dMersX1wtDzTshc36suJ8TZooUOisGK8aA8MTl1Oh6Vvo18Ve
         IWlohCHLEc837NSLvRpDFTwrpe9zk7KXGNY8APye+NngnQQGaNywx0x1HtmqR1+S5VZ5
         AMYE+vvzjvdNRxOzXcrIgDhbVRE2g6UXNdcfKwKY5F2TT7U+i+zeD5FI6hMJsR6Nt31y
         DZlNXjqiESh4LI+NW64Ol6Gtg+EAI0pD36QD2AVLW9BRRtGFje9LdeUWseZMPhYRgFYM
         TO6A==
X-Forwarded-Encrypted: i=1; AJvYcCXTgF8EExghtX3fQlNEZUo+knzzXZDMjf4r8h9Tffo/+GjrlAce1sHkWeRYYdrHAGDKoDpuGESOF+6OE3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv6iMNL1vl7XhtZfj1kn423WTJlBMkbxzPAS36YM/iq/5Vkh8g
	nnYMLCcekeG5zFkDN3qRarF9vlPU257/rV4oCk52A7OBtaAHTUNIFRUCWGcLdA==
X-Gm-Gg: ASbGnct/g9ZcfazWGCKfp9sB2SkLSseqcYZYmgtjxR0kDuUQghVMetIIgb0z9/sSIAr
	7Cz1H3054IJLZ8kVmYB1IMwonYl+3u+ELlpmXiRFeJdCgtjXMWe863HQn3u2jpy5SweZ33/RFyG
	F2zF9GrTsnwfF/WhotekDVpzf7PdIIynGwKLtkn8syfFni17V4gLHnLRhnEulywAxLWPbhqLLHv
	vBnBsbVrwGiN9s1M+BMFoFPV/LEI4kLlcVuRhl9tnoO/ZjaStadoV8Fx6e/yKV3F2V6ER0sMRlx
	srjGysATp262dZZjZ8YvXw1i1bPudvuCmzC+yQR3i4ZuA95RHQtjarSWaBj/LxIRP28Cj2Irovy
	eD649EcdWwSyxRAUzrBmmijTaW8jfj0koQvKnJ9ZBax1LGlrLf+5no1HRGKte1n/PUok5eTs6O9
	eq64acHCYolA==
X-Google-Smtp-Source: AGHT+IHdYC2ElDuPYayKBgjf57H/wSso+U6gI155XMCYMadu8KVC/igHxS0oKul7GVyBUiaceuDviw==
X-Received: by 2002:a05:6000:290c:b0:3b7:8525:e9cc with SMTP id ffacd0b85a97d-3b78525edb8mr3914527f8f.18.1753708782629;
        Mon, 28 Jul 2025 06:19:42 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587abe7d47sm99942535e9.10.2025.07.28.06.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 06:19:42 -0700 (PDT)
Message-ID: <08deec62-e20a-4a54-a655-38a0335a74cd@gmail.com>
Date: Mon, 28 Jul 2025 14:19:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Fix typos
To: Bjorn Helgaas <helgaas@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20250723201528.2908218-1-helgaas@kernel.org>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250723201528.2908218-1-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/07/2025 21:15, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos in comments and error messages.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Sorry I wasn't able to get to this in time (had email issues last week).

> diff --git a/drivers/net/ethernet/sfc/mcdi_pcol.h b/drivers/net/ethernet/sfc/mcdi_pcol.h
> index 9cb339c461fb..b9866e389e6d 100644
> --- a/drivers/net/ethernet/sfc/mcdi_pcol.h
> +++ b/drivers/net/ethernet/sfc/mcdi_pcol.h

mcdi_pcol.h is automatically generated from an external source (it comes
 from the firmware development team), these fixes will likely be
 overwritten next time we pull in updates.  I will try to get them fed
 back into the upstream sources.

> diff --git a/drivers/net/ethernet/sfc/tc_encap_actions.c b/drivers/net/ethernet/sfc/tc_encap_actions.c
> index 87443f9dfd22..2258f854e5be 100644
> --- a/drivers/net/ethernet/sfc/tc_encap_actions.c
> +++ b/drivers/net/ethernet/sfc/tc_encap_actions.c
> @@ -442,7 +442,7 @@ static void efx_tc_update_encap(struct efx_nic *efx,
>  			rule = container_of(acts, struct efx_tc_flow_rule, acts);
>  			if (rule->fallback)
>  				fallback = rule->fallback;
> -			else /* fallback fallback: deliver to PF */
> +			else /* fallback: deliver to PF */
>  				fallback = &efx->tc->facts.pf;
>  			rc = efx_mae_update_rule(efx, fallback->fw_id,
>  						 rule->fw_id);

This wording was intentional, not a type: delivery to the PF is the
 second-layer fallback when there is no fallback action, which makes it
 the fallback to the fallback.
I will post a partial revert to change this line back.

