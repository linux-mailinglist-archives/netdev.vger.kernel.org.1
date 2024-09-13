Return-Path: <netdev+bounces-128197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B285978717
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00D228603A
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778771C2BF;
	Fri, 13 Sep 2024 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkcxq8JE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64835811A;
	Fri, 13 Sep 2024 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249572; cv=none; b=oigsVJdZy8Dog8IMU9yKXsoyCLZZmPJA2s9D9pG15L5sAJ6CWOOFapwTn2qKd+JyVgNO0tIfQXqAL3mr1XrW6DTNkZpg5o+rj6PsszxFlt9CHvMsDvAswS7GtmiU9ugRoEfd360hEFo+xk96+Oi5kzhMKnFCGnaIGu5L+dNT198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249572; c=relaxed/simple;
	bh=EqDTf25tVQHytGA/j1AruP8PuwrhbqXCnhGs5KOfnDA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GoMVp2VHfKIy/7f1H/e+DjDfsTiXxu3TrFNtOr1guOY5xBYS/seRcfdZTgN0Iv9ZBdlkDdxUz74h+2x8Ndvp0+SOF9hhoNkqOIRgXr7sKtUrW5g1uwfo20fEJiwPiL99V/b+mOMjAU8LwYFvgLdm8hrz/9l6DIfCtitWRA6XT8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkcxq8JE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so16082665e9.0;
        Fri, 13 Sep 2024 10:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726249569; x=1726854369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cB61eU+csOz+DkZvTTtin0oBCG2woMkjOJn7Xp4505M=;
        b=hkcxq8JE5537IylBnJ3hj02X6BwvVnS0NDB4+Yb3c5eO38yKJKy2m+tB1+T1YU2q9i
         xp55ggDPFckqthifd5obLOErw6Qslp7ap4Ux1cFrpZcRLvL6qmqT6dP4ovRsIj/sNGOJ
         nHER+GjF5o5Oy33o+BTemZejFTUz1uLvn3+LJD7upHm0l165wTMC3po4bChchtSdAMGM
         MUXI+O5WdIbvsuStlgS7alzxhIjzYpNd4rTZo6ukm10f+B9gpunU/Lw8bQlXcqPYOg6e
         +f3QUPXzbnSpQ+Z0ykbkMA8jfUsR2WYXw/JXhyIuYGWROpvAGt0Hz/ISgUd7uDKdSXXg
         M63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726249569; x=1726854369;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cB61eU+csOz+DkZvTTtin0oBCG2woMkjOJn7Xp4505M=;
        b=Aw7cf8QrXhmU/i9lMjve8IEvCVATOpxMQDtTMIqwIXtmEO57S0l5K4ItvnyEHZfkFE
         0PXcysJ+tKyTjCx7zZQkNDCMJPIOLtZxBIbypMbNxZfE72HrGtHm3FD5tTQPq1hxslr7
         Iexn79Fnb0hRF5isBNv2b2pqfvHJuBpvnJ4he3lyKl3hrATY2p6WXp/kHgvVYgoXvZuZ
         vtNQJ+xsexn0sb9KyNpl9WbzPY2vJJ4yI+cgV9r0m4Pzt/S2KtDlaQgnHUUAgrLASoAA
         nlNlsTGJYP/1OGrhbtCurUJF5YZYqDAS5unTkpMWxndE8uqIk8caySmRPakr0VyR0UGn
         xYbA==
X-Forwarded-Encrypted: i=1; AJvYcCVJtIUYeASfjuHhdSATQkthTNfuq2ZA3rrM/TE5/jHb7NPdf8HR88jkzzqB5cju5YcxDD+n6eBQ@vger.kernel.org, AJvYcCVyjT+jA+WTS35erPX23OyRc1Dyt0Ew+y5FWz9k9yjcpBzojGkeDGSS9Kdm08n4dVNuV8PTTKN4PMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDnKpeIdNkxqu9l+jISw2orm/2dNK0nnxtQvAu8KJCkjBHM6mH
	ef8i1svPuU83K3Q1avTy+fjhmboyJr4OHXwCjg7odBuk/aDAxUVI
X-Google-Smtp-Source: AGHT+IFt02t9929MMyOlswt484Vh4GBmg2KPFPnExF9nZK03aT+FKUPClu0LQlmT3MZBbbrqvIFWIQ==
X-Received: by 2002:a05:600c:5102:b0:42c:b9a5:bd95 with SMTP id 5b1f17b1804b1-42d86cdb06cmr34774445e9.0.1726249568686;
        Fri, 13 Sep 2024 10:46:08 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b054fc0sm33545055e9.7.2024.09.13.10.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 10:45:59 -0700 (PDT)
Subject: Re: [PATCH v3 20/20] efx: support pio mapping based on cxl
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-21-alejandro.lucero-palau@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <08b7b4f8-01d6-20d0-10a7-ade4ed69ebcc@gmail.com>
Date: Fri, 13 Sep 2024 18:45:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240907081836.5801-21-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 07/09/2024 09:18, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> With a device supporting CXL and successfully initialised, use the cxl
> region to map the memory range and use this mapping for PIO buffers.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
<snip>> diff --git a/drivers/net/ethernet/sfc/mcdi_pcol.h b/drivers/net/ethernet/sfc/mcdi_pcol.h
> index cd297e19cddc..c158a1e8d01b 100644
> --- a/drivers/net/ethernet/sfc/mcdi_pcol.h
> +++ b/drivers/net/ethernet/sfc/mcdi_pcol.h
> @@ -16799,6 +16799,9 @@
>  #define        MC_CMD_GET_CAPABILITIES_V7_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
>  #define        MC_CMD_GET_CAPABILITIES_V7_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
>  #define        MC_CMD_GET_CAPABILITIES_V7_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
> +#define        MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_OFST 148
> +#define        MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN 17
> +#define        MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_WIDTH 1
>  
>  /* MC_CMD_GET_CAPABILITIES_V8_OUT msgresponse */
>  #define    MC_CMD_GET_CAPABILITIES_V8_OUT_LEN 160
> @@ -17303,6 +17306,9 @@
>  #define        MC_CMD_GET_CAPABILITIES_V8_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
>  #define        MC_CMD_GET_CAPABILITIES_V8_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
>  #define        MC_CMD_GET_CAPABILITIES_V8_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
> +#define        MC_CMD_GET_CAPABILITIES_V8_OUT_CXL_CONFIG_ENABLE_OFST 148
> +#define        MC_CMD_GET_CAPABILITIES_V8_OUT_CXL_CONFIG_ENABLE_LBN 17
> +#define        MC_CMD_GET_CAPABILITIES_V8_OUT_CXL_CONFIG_ENABLE_WIDTH 1
>  /* These bits are reserved for communicating test-specific capabilities to
>   * host-side test software. All production drivers should treat this field as
>   * opaque.
> @@ -17821,6 +17827,9 @@
>  #define        MC_CMD_GET_CAPABILITIES_V9_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
>  #define        MC_CMD_GET_CAPABILITIES_V9_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
>  #define        MC_CMD_GET_CAPABILITIES_V9_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
> +#define        MC_CMD_GET_CAPABILITIES_V9_OUT_CXL_CONFIG_ENABLE_OFST 148
> +#define        MC_CMD_GET_CAPABILITIES_V9_OUT_CXL_CONFIG_ENABLE_LBN 17
> +#define        MC_CMD_GET_CAPABILITIES_V9_OUT_CXL_CONFIG_ENABLE_WIDTH 1
>  /* These bits are reserved for communicating test-specific capabilities to
>   * host-side test software. All production drivers should treat this field as
>   * opaque.
> @@ -18374,6 +18383,9 @@
>  #define        MC_CMD_GET_CAPABILITIES_V10_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
>  #define        MC_CMD_GET_CAPABILITIES_V10_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
>  #define        MC_CMD_GET_CAPABILITIES_V10_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
> +#define        MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_OFST 148
> +#define        MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_LBN 17
> +#define        MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_WIDTH 1
>  /* These bits are reserved for communicating test-specific capabilities to
>   * host-side test software. All production drivers should treat this field as
>   * opaque.

Please, do not make targeted edits to mcdi_pcol.h.  Our standard
 process for this file is to regenerate the whole thing from
 smartnic_registry whenever we want to pick up new additions;
 this helps us have certainty and traceability that the driver
 and firmware-side definitions of the MCDI protocol are consistent
 and limit the risk of copy/paste errors etc. introducing
 differences that could cause backwards-compatibility headaches
 later.  Ideally the MCDI update should also be a separate commit.
See previous commits to this file, such as
    1f17708b47a9 ("sfc: update MCDI protocol headers")
 for examples of how this should look.

-ed

