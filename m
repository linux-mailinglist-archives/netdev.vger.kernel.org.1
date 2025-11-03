Return-Path: <netdev+bounces-235188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F8BC2D40C
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 17:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A96189AFD0
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 16:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BE53195EC;
	Mon,  3 Nov 2025 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeUb1BK1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6962E27FB0E
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 16:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188606; cv=none; b=cHZaNF8Yx4qASEeBLZ/MzdJn5CjNUNkkhnbLmvmaPvLPqcm2sRiG/FH4HmKwrDjSDZ9l7PQsY102aSAyRHAJNufj/F6LssrWyE/wOWGkbHVOgCVHq3IXkSD4aOfzRw69A09xc8RkiN26b99l/yldRTPahMYLNCIF7u0VB7r0QHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188606; c=relaxed/simple;
	bh=ko7lB3r9pVr9dkY2BmFRFzraWZf018hcoS0HId+I4M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NacKEinOrDPYcrySETca3vWKR2p6oMjbB78LwEnp8TIqCkXzr6C9EEz/aYGVne/OVzGZdljGNhtXX9h3m6X6+cqjU/3jSXApzl6b0RzMYvcrVfGosA4y3IvoRbPpng8wHC6PyRzXD62Ln358UYa+toux+whlvwDkNjIWhPjIHAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeUb1BK1; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88057f5d041so12297486d6.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 08:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762188603; x=1762793403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zJCa++upS3Lwr+ZLn+k/k89isaF3M2n4b8YOGE+2huU=;
        b=UeUb1BK1WAnhvzAKtkI7B4IPTqQrNNExqAL9jJcWgda822sALW7i59fyVKRZubNluB
         3I4csk150vyMZ0OQnpZksrNsQAKgZyon0u3Wevr4mVxveb8nm8qJeIkJd4fA2p+ov3jv
         P5fncmTjhHVGeiL7dYpH9SA/TVJ2z6R4GSbeYYbt9RdFNtG0NQQWfPIkVgCT9lm5t8Ud
         sds4bfGzAJYVUolHkK6QK7Q33NbnyjHy+O3LV/jAfJFgI1Ivn8AzLY8ZV5YhIq07moLV
         HLYisbwbl/n9Ys2UOzLwsdYlliBW9LUUTzCzEIiKf29OWtcVe4NpIH4CW3zz+4Vql5Q0
         PKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188603; x=1762793403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJCa++upS3Lwr+ZLn+k/k89isaF3M2n4b8YOGE+2huU=;
        b=MTOTFEB1V9m/ks8Qc7lTEXEEH9AhF1CU5NokawH+IBk3GcUig7UjAeSIiUkjRS3lYn
         rdyzVtF6p2oChYL8z75fpC5zOmSVnu1ZDn6eEr7/KZXq29JmE1vkKQC0RBlAcEfbDbsK
         vuKJgtsfPKjQqO1TnA+uGzVXoloLZJ2f92s0LTHVrpybQC/IoUovgQmhV0cWOwMXkvCi
         iIrKFwU/8xEn+biqSY/6NWxV1XzKG1gvR9AJxnR3XfhbpDXqQbsBSUCfawPXyFcWZtib
         7OfzePOlHUnwO6ZnwDDBA5uFgVKDyMQK2P4SX1SLvplu+wxEOPqgnW1ju4fhHpLtE0Cv
         P10Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/OqBxbB7dd3ywvRjt98dbx7TXvZlEsVXqdVP/1Wfh3biV4AXm3qTjC49BAC2gNc3sIDonuUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVp4XM+11ZGs3SARt3s2ipkwunqlcnvgHjtJ91OYEwxbGNCwMr
	EmcHhZ4XtctzlAK7yXl8M+1QLZpB1SGveZ9Bs0XRfNMs4X5idBtxIA6z
X-Gm-Gg: ASbGncsspcZXhn/veejVQSypURfxpzldqaeoppL8fglRTiA1fPnwRFX8mziU7JxiwvG
	wmHp/YI/+KZdZWXAUh9RJXD0z7lOIO/gSKzKQoWvRpz/o6yn78aatyyzcKU+ycD0BoqfnCBGdGi
	4i5EUlGCLvxsSHS811evLQ/blDtY8sFLORGIudY5Zkbo5+lyo4iwxOPX6Deb4lBFkeafPxWyqJ2
	qcvmGk8yLjD1MuXk5P65tL4JLNyf0MDt2GWlBKUTwgUJVCx7cNdepal0g4YptpbzrF2Wo9cY8Ft
	dmo9L/pQW5qmBg5IrcY0UOO85LPJN97gL5DmQvGeMHxvvE+DJPXwxD9WRZLyGDuvev7F0x+084+
	0UtUCU4xrWFooyDp3Bow9q9RjQA7suH0Ns7mpiKfmPtVuxrXYqyNRQaHUl4rLJlpMOwtvDEj1HJ
	bupdykBFxTY4KRCuXiuqWgHWCBzr8=
X-Google-Smtp-Source: AGHT+IFni8jZUvZP39hkL45Jl+M1HXL8vO6F1udbgLnU65rMefyg3UKyqfPWUZEunlxBVuwBiSpv6w==
X-Received: by 2002:ad4:5944:0:b0:7d2:e1e6:f79f with SMTP id 6a1803df08f44-8802f4c82e8mr219322526d6.47.1762188603195;
        Mon, 03 Nov 2025 08:50:03 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88060ded862sm4878056d6.25.2025.11.03.08.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:49:59 -0800 (PST)
Message-ID: <6edb4435-e641-454a-9722-70b25c775151@gmail.com>
Date: Mon, 3 Nov 2025 08:49:56 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] dt-bindings: net: ethernet-phy: clarify when
 compatible must specify PHY ID
To: Buday Csaba <buday.csaba@prolan.hu>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <b8613028fb2f7f69e2fa5e658bd2840c790935d4.1761898321.git.buday.csaba@prolan.hu>
 <64c52d1a726944a68a308355433e8ef0f82c4240.1762157515.git.buday.csaba@prolan.hu>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <64c52d1a726944a68a308355433e8ef0f82c4240.1762157515.git.buday.csaba@prolan.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 00:13, Buday Csaba wrote:
> Change PHY ID description in ethernet-phy.yaml to clarify that a
> PHY ID is required (may -> must) when the PHY requires special
> initialization sequence.
> 
> Link: https://lore.kernel.org/netdev/20251026212026.GA2959311-robh@kernel.org/
> Link: https://lore.kernel.org/netdev/aQIZvDt5gooZSTcp@debianbuilder/
> 
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

