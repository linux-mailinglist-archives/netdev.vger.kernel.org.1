Return-Path: <netdev+bounces-69779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F93A84C8DF
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 11:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9380A1C25B11
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 10:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E689A14A8E;
	Wed,  7 Feb 2024 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sho7CCq8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400D317BB4
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302622; cv=none; b=c1LitAFIuaEApiHcTqTCxD0iPz0AtfT4nYBHn/ZHIe4eIHyD1NU7Qg+yM+iFkruN/EQ15EM3GVCE6lwsOJk7E09f2uty5ckn0TFTat6e7+iwHwUibSI9o1dn1HwNbt7o/TbaeadvcjG9VBDtyX/AY6R8P96aVmmlgDRvaRiphKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302622; c=relaxed/simple;
	bh=unFxLcUXvkEyqg+PHhI6c3eTCgesX3SV39thtqHobDM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pZZ6V9QKyJeWJ+a8W5xi73vIgvyPDeprcaf/lOsryolkjQBgyPEFydWoGuVY+VOefDJ/HNzZX9hmrQ66uqGEQVkg5lh1lu2sehBVvA+56Xd8hR4gae7poEwuSvkvUjNGavyZgzVnxhmn2PKH5/vggQHRhItlewnMUuJQE8QLK2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sho7CCq8; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so63574066b.0
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 02:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707302619; x=1707907419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7eKaWnglRHjjsTw3tFVYiwWSWVfZ/v6V6VU8BAoYlUk=;
        b=Sho7CCq8RvdiVOg6tWB80suPZV1C+PoyCSPhtnKD8Uz7+5E3WnzkOcYgQ3K7IW8oTI
         cMaye9TMsBnMG3Bq1cM9GBjQ+qR/87ieBU2XGBNenW510zT2TcW2YjO5E22PNT5H2KDq
         6+ioLsqNgIxiBUCnOVMmcZxk67Q7a7Vf8rFMQ63e8pi4EotRN5YS46NCeKsGlKyZ7vK1
         bQrlJ/rOY7MNmlmCF5X4PPr666EOC9hK1E7aV+QgEB2+mHMvnfi/81xU8uGGy09YEole
         Cy/YrnM6wsifF1WUE5iAzl0nFxLVUuP7T4bH3HWbJ55dUsjYtCuFbu+YC/fawYbzX0L2
         5sGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707302619; x=1707907419;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7eKaWnglRHjjsTw3tFVYiwWSWVfZ/v6V6VU8BAoYlUk=;
        b=J9FD4rshxHb4xLkksfjdTNpZeAP/4Ri25y0LUyDv8YGl4Ss/hszU2L+6JHEGzBoYjO
         JJ6tXdXBWQOf1tQ9u50WdzoAeX0AVvEMx5XvIkra5QefcC3gFjZKPKbMv+MCyAeM54wX
         HfN0U6H+GZag/KhssaETn1V+QjkKLMXvkWOGYEdubBFLI4IT8tL1oJ3qY3rA32VCuaD2
         0RGpLjOF78TtjkNyngkfE66glAz+87u2dxnGfhnebe7xmIWvjHtRhHOcD8U/ci0gq7UC
         Pc4tzcdLvb3TasljgEo9I6hpRWKSRs+JEZYXV5QoXyAPk0csSI61s1oIgkuHPqGhXJR/
         W9TA==
X-Gm-Message-State: AOJu0YyPia7vEqSLWGH7DIJRc8n5bY/yWgxmTAgzE29sKcFEON3gfVYG
	pd/K3RefPkVK2cFFenVLwUAmpA8te0/m7nzHw9sA4d9DCsqeXWjL
X-Google-Smtp-Source: AGHT+IFTAc+Gqosi1XRhottNQ+eU4GYlHieXDczO6IJu1B43FYoV3xAepJhAFlrUyKiJfHjH5eAm+g==
X-Received: by 2002:a17:906:30c7:b0:a38:215c:89b with SMTP id b7-20020a17090630c700b00a38215c089bmr2677037ejb.73.1707302619188;
        Wed, 07 Feb 2024 02:43:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVYjtLa53QkcX74VKnBWLR6KOcAgGm7oDJal00EM1movXbwlS7gRC3g29Sb/16Yh6oVC1Lk2seSVs+LDQzuwUCvN8abcmaPQ9noKKuo1UGQSj6QN2Mp98F3fLYm9DJ/zYlKRUqwKeO0fwwn9uPjfDftTXUKJZ9KH1UU4bZalgIt4S81Sf/5LA6wDrykQ8941D3NeevJ2AE+vJESCzax3yGmmaGrPX2cJVY+8saOxQ==
Received: from ?IPV6:2a01:c22:76b1:9500:754d:f584:769d:10e? (dynamic-2a01-0c22-76b1-9500-754d-f584-769d-010e.c22.pool.telefonica.de. [2a01:c22:76b1:9500:754d:f584:769d:10e])
        by smtp.googlemail.com with ESMTPSA id vk7-20020a170907cbc700b00a388ca1f83esm213119ejc.160.2024.02.07.02.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 02:43:38 -0800 (PST)
Message-ID: <a52c2a77-4d0c-48a9-88ea-3ec301212b31@gmail.com>
Date: Wed, 7 Feb 2024 11:43:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] bnxt: convert EEE handling to use linkmode
 bitmaps
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>
References: <37792c4f-6ad9-4af0-bb7b-ca9888a7339f@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <37792c4f-6ad9-4af0-bb7b-ca9888a7339f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04.02.2024 00:09, Heiner Kallweit wrote:
> Convert EEE handling to use linkmode bitmaps. This prepares for removing
> the legacy bitmaps from struct ethtool_keee. No functional change
> intended. When replacing _bnxt_fw_to_ethtool_adv_spds() with
> _bnxt_fw_to_linkmode(), remove the fw_pause argument because it's
> always passed as 0.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - add missing conversions
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 21 +++---
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 65 ++++++++-----------
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.h |  4 +-
>  3 files changed, 40 insertions(+), 50 deletions(-)
> 
This patch has been set to "Not applicable" in patchwork. Why that?

The follow-up discussion with Michael on how exactly certain EEE
aspects are handled in the driver is independent of the mechanical
conversion in this patch. As stated in the commit message this patch
doesn't change functionality.


