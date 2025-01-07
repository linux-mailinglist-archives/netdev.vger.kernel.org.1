Return-Path: <netdev+bounces-155969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FFFA04686
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5291887CF4
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F711F193C;
	Tue,  7 Jan 2025 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkKVOJVh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13541E570D;
	Tue,  7 Jan 2025 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267883; cv=none; b=Yv6d0sQUzcwrVnt2v3u50IFmIRXv6xfe3JVxDYV8fV7edDn0GNh5tmzMvMc0NjtPUxcrlrArSp54ihjywtgjSu7GQH6ZqS3IfP+3HN5ytMwVjeUn7kFIRQgl+dCIOLLrWe6ORyWfQLpYIuOoc5Ix1PI1V5mDzwi6CDJfOin9CWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267883; c=relaxed/simple;
	bh=GbPmEFa+SepKxyiUWYwP+hNTRZZxXX7NRN5vmYHinUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWV3jZ1mESZeM0rmgkg8oTNrseEwEdvTZJnohnc1KeJOQjgJobkmqj25zmTf1hWulASmkg4pjX6/OkjP6sdfxrG64PS86u+VyuFl9CyVFMNbSe5avU/u80YP6PpLC3tqH0idsdq88l0gUv2nqbLmCtotAUvG4vvvbrbybWhmRaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkKVOJVh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa689a37dd4so347983666b.3;
        Tue, 07 Jan 2025 08:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736267878; x=1736872678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R1HtqGc1Nz10gHJkOm9rEyjNa2oAzOlB1/8f1j7y20I=;
        b=EkKVOJVhl2Hj17T44igTXgX++NwBejuZO/2lRiMXM8DTg9sxnw8ouKa0PAEDNbvV7O
         2XK9jFVe3X0AXsNE2nwlIwToRkZ4m0GGyjl2vpdqgPDIm/RWorC31qgZGaSskBn2sPC0
         Oh/d5BE4UZaFIAthNCCIR6MBO/w+ta/qDAkp4aFKvbvHTUtWc6i8hVhyfILP2eKCZwTi
         mVb6pgdxiVWfsI6dTgqpVS5BbX4K+gohDl4WBqz5lZT5jlvXk+8LZF5mzZYvmgoeTd0x
         /fvstK0a6L+2xUOmI7svpFskxCggmDNpIRamcPBH+rxLVKTIX4rtFCAydSGZ/DTKuxmI
         GTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736267878; x=1736872678;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1HtqGc1Nz10gHJkOm9rEyjNa2oAzOlB1/8f1j7y20I=;
        b=ERiGUaox9anyDpxfPyjmUBZ437vz0KDimHr2WVZbqANPR/KOvY7UjtPsB/hANgmiFc
         mWikyS+/k6QEIeAdF7VOPfr50oFmkOfM8uRgWn1hbTIyQlB+Gq6T78bbCuy9nHM6XQPK
         aq5yuidTJ7iOCrfljB8hOW3itDpTet7eFOI3DuVhDZ8vV+QZxI4HtJ5vkR6zw+zxgiSq
         mW80mG0tEXWtludfMC508G7J/vxg8D0AkMx+3SX+klU8GOqe4UUR53V4dM6CnExPleyA
         KpIQl2krM7piRTIvCVf8VcLF30A6kSBnJ+e45kpLH63Tk/tCKkQSbvIK3hLrZH+fXjSG
         6xVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcTfYhMTwv73f4AHhXjPMLHUOjUH657t7QtpoKcTN5A64j9f/QcxLkujQf5FCKnXfA/UGSheE0rahLYW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9vLQN1cwHY372DGf7+pcsOBeuMoVQrR3rls07pL6lhl5JTAUB
	mkWJ6XYC8iAI9fs0YAz864lmr4mpDhrQ3gCopE7brln4v9tRH9Ar
X-Gm-Gg: ASbGncs/4Y4fo9afnWgua6ZxACKwCStxtqSQVoQOCCKcGdQowIFaoN4CpfBWE8rPVWz
	3iP09JUZshZBm6IMtuGqoPbs5buvbEkSQF4AG1tXBO26bQ2zZXzO4WB1d6+v3R3bklYSFIG0VU5
	3R0qyi79FJ1YOSa8P+HTYq2X+jSSctM+3kPjFo+ta5fIapT9LIWolacsrmsMHgeLBAX8YsNaFVD
	2oBkUuYe9CNixuEbL8C/EP+sdBYaZh9XkSQmNr9FwWbF3rsJ3bxVKdCH6Gzrd3X7ghBjPcMnsMm
	GZ9+Ks8S/aBDgB+mjfeGVenJGVdojSGr3zmUu6FVpnn8lbnSqzSABWaq8ilGZcfzv4DeZ+aPq/j
	a7QpmB8MXltGJ+Q0gA9zC6euTBHKq+qWkKBezUC5zuf1qaEVH
X-Google-Smtp-Source: AGHT+IHTr+Ov3lGRV0rQVosaymmyn+1+MKfuV+/CCEfLIUC49RRZTB7F2LTPB4j+uhTr693ZTrJ1HA==
X-Received: by 2002:a17:907:2cc5:b0:aa6:96be:2bed with SMTP id a640c23a62f3a-aac3378cbd9mr4957230566b.59.1736267877856;
        Tue, 07 Jan 2025 08:37:57 -0800 (PST)
Received: from ?IPV6:2a02:3100:a00f:1000:a57d:a6cf:6f93:badf? (dynamic-2a02-3100-a00f-1000-a57d-a6cf-6f93-badf.310.pool.telefonica.de. [2a02:3100:a00f:1000:a57d:a6cf:6f93:badf])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0e830b2dsm2392488666b.8.2025.01.07.08.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 08:37:56 -0800 (PST)
Message-ID: <37dd2be4-be94-4b91-99e8-28392cc9bb3a@gmail.com>
Date: Tue, 7 Jan 2025 17:37:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] r8169: add support for RTL8125BP rev.b
To: ChunHao Lin <hau@realtek.com>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250107064355.104711-1-hau@realtek.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250107064355.104711-1-hau@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.01.2025 07:43, ChunHao Lin wrote:
> Add support for RTL8125BP rev.b. Its XID is 0x689. This chip supports
> DASH and its dash type is "RTL_DASH_25_BP".
> 
> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
> v2:
> - under rtl_hw_config(), add new entry for rtl8125bp
> v3:
> - under rtl_hw_config(), change rtl8125bp entry to rtl_hw_start_8125d()
> - add MODULE_FIRMWARE() entry for rtl8125bp's firmware file
> ---
>  drivers/net/ethernet/realtek/r8169.h          |  1 +
>  drivers/net/ethernet/realtek/r8169_main.c     | 30 +++++++++++++++++++
>  .../net/ethernet/realtek/r8169_phy_config.c   | 23 ++++++++++++++
>  3 files changed, 54 insertions(+)
> 
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>


