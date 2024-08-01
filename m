Return-Path: <netdev+bounces-115102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1920B9452AA
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 20:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0781C2196B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AE7143733;
	Thu,  1 Aug 2024 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZRaOxEa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF441182D8;
	Thu,  1 Aug 2024 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722536526; cv=none; b=GqZ+np1vCsz8aYIpVh0uklPmoC5ttnNrFrVXXmXAkID1LB5bS7rNW5oouKwR01yGbpLK9r6z8gkPzv+ZGXujTYPqCCqli12ex5/ABqqKaaKo8qjGw4RU903/TVPgmS1CCz7Q1najOLazG2K8l4JwMrbRRlz4tJp4gQpptwmijk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722536526; c=relaxed/simple;
	bh=bNlCR7DSZhONr3TWCZv/y1f2BAAwo8Lg/w8yh/SUKPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3W0ickhmCwxXO7YrVZODga3Ia3PyAPK6+7aJRLjFqaryNM057FABNwL3h+YVA3XEcMOqPxC+c01N0BaA0jNtqLT4qXtj4mjvaaAyJtSCzVl/JRbW7w8o3esMcfiK04HU+qlvefUb7ciTSUHWpU24rG73571Z3B3AFt8VMc5ATw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZRaOxEa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ff3d5c6e9eso27399545ad.1;
        Thu, 01 Aug 2024 11:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722536524; x=1723141324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2cI0IRI5OGY+h9fYtpnfrfm65dWiFQL1xXhvgjuX7h0=;
        b=RZRaOxEaK9Bn3WClbI//HuEGlHKAaPt3zLWv2zxQCeS3kBRleXfKxtOEQBE6f/c1Ww
         E/OkNb5kTdug0u/aczqrgrZ+dQ3aEb7OWgE+vKoFrlTRcq4UKiBKL2eqczo0qdpuyPwy
         ZH6nowQHI8DjYllv6AuVNzipxUeDIsUAZQdoswGbLi3R8O9PS+NIYZh8Hl/uBKmdpp6A
         PyINFAm9I4iP8E2fEyM1wTFytCouQOAj5RaBLKr++l8u8zfH+5ppehH8F+q205Leaier
         XFerQiIRaYgCe+zyLhh0rdLz/GbewmKGFNbXndD38LeOxewVgHt+yMS7mzwlXXMnfckU
         OY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722536524; x=1723141324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2cI0IRI5OGY+h9fYtpnfrfm65dWiFQL1xXhvgjuX7h0=;
        b=sls2w9f0n2Rvvl9yWikIZYSF5semnoh/HGnpzjLsKtJobS3tNFhuFJCQg68leEBhcp
         hM5ma4gCkZgLuqmR+n5V0s7bs1k6IObR1dCQExayezFn2fCVhftLCDQcEpQYL0XRfI3F
         Vj+RvYEoYjCv9POb62PBrcRO4f58CDS0b4Z56N3VtUJyN7DwDk9xa0ny6WyyXXOB4kOp
         bN3L0vVl8FcfGsm/bwPXsEH4c2aXiJQzAYXwKx+qWOQ58ENSbcgLXqDUqM/WffwBpKWF
         Cc4iXnlfU2eEKyOPiKbhP194t+89Sd/ZdLRTsidRVXHkAtKSG+NfccATT4GrvyXO4P7G
         rbZg==
X-Forwarded-Encrypted: i=1; AJvYcCUBhkZUbnTAJKcb4nCsjVztG2wdCwCJ4HefcoofXmnTccCevPPWjbjezE9DIzOYbX435Vd95AaqIwfCEZcAVIv/qNTTCSLOwmp4bjSIly4fqI+2xXiOh1o+iunWMo/wnk9qwQ==
X-Gm-Message-State: AOJu0Yz4ND/bXA+W1YM3oCtJf9nAaB5Ol7l+803hmYSvyjZp2RAmbMq5
	wk17j/8/z/7yeuDJmoEBiKziFoTY/qONx6zNkZJptolFXgENdtGr
X-Google-Smtp-Source: AGHT+IHPdcLQgJqPAa2E5MFEcxR8W+bsd27wDrycSJcZ/aF9f5pWPqenwUKiYiGAMiS/xP62uWP3pA==
X-Received: by 2002:a17:902:f9c7:b0:1fb:6a96:fc6b with SMTP id d9443c01a7336-1ff5748d0dcmr9205075ad.44.1722536524110;
        Thu, 01 Aug 2024 11:22:04 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ff5928ff1esm1822205ad.237.2024.08.01.11.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 11:22:03 -0700 (PDT)
Message-ID: <72bea681-b2a5-4246-b2e4-d431a63338dc@gmail.com>
Date: Thu, 1 Aug 2024 11:21:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/2] net: dsa: mt7530: Add EN7581 support
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: arinc.unal@arinc9.com, daniel@makrotopia.org, dqfext@gmail.com,
 sean.wang@mediatek.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 lorenzo.bianconi83@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, upstream@airoha.com
References: <cover.1722496682.git.lorenzo@kernel.org>
 <a34c8e7f58927ac09f08d781e23edc06380a63a2.1722496682.git.lorenzo@kernel.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <a34c8e7f58927ac09f08d781e23edc06380a63a2.1722496682.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/24 00:35, Lorenzo Bianconi wrote:
> Introduce support for the DSA built-in switch available on the EN7581
> development board. EN7581 support is similar to MT7988 one except
> it requires to set MT7530_FORCE_MODE bit in MT753X_PMCR_P register
> for on cpu port.
> 
> Tested-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


