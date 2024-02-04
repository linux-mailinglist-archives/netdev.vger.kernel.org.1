Return-Path: <netdev+bounces-68934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EBE848E53
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 15:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60DF1F21361
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 14:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2E0224D6;
	Sun,  4 Feb 2024 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2kref20"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C66225A9
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707056211; cv=none; b=nt78w1n1vIQjMTm95nsizPyBRjrOU9kAoV44i886V3cC9tpHeKOugDscwiQhd0jrePahUkGBgCGweXtqudkfavOOZoO7b3in22KRctFzlSmakxNODk7DiMnuXPemjw7kFIbinLuqwdezCckYURz0QnD72QuH9p6GeHvS6UyGJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707056211; c=relaxed/simple;
	bh=p3Mtb9zjonnokPrw/KLTAIrbtWFbNUbdHyp6YJmXVEw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZjsGY2GercKfLArfzQFalj+GuHsTBilwRroiU2Kmil7lOqPHIVOLeL0TRA7Nnjjbvf9Nlel+VupKUa5sZ3CRHoi2XHf8Y/50tHCi4aoB3LHPRlrMyKD0S8sK1hNhj8ionGwdZFiEGttCF63tnnevetwpqbXtrEoRoI7TlOmy7Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2kref20; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a36126ee41eso456122166b.2
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 06:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707056208; x=1707661008; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3tDaxCCxAh0e+LVm1FVSRMkvfD/aLm4JvqFjDtEcK8M=;
        b=M2kref20E8t94S92ozXG/dK7zv+PJOnrf+o84mhgz0s6PcXw7Ci7ws3td7vg8+XaTz
         s+QIqfy30fDfs/sAO0CHRpHVjXmGmrS8z3tUBUlmHxXL8TZf5d3VKCT146WjOOYU3lJU
         jGdC9vO5BLrgIb+B3WSK3W8GdBpZqbtc3JCj8T515Lz01ilRM9cae/Loe2Ol7vi5hBMR
         Obum8M97sfz2ENCms5CwK4Eez+RdSHm/Ndl220xj36Wjm+G848qQf6uDE1isa+8sU7dR
         j1fY7uE276Ys4nnHlLdAyis9EbeyRazi/EIC7tteQB5r0xquK7zBA9Zh6jX6UkliCfNr
         gT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707056208; x=1707661008;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tDaxCCxAh0e+LVm1FVSRMkvfD/aLm4JvqFjDtEcK8M=;
        b=CXhhrt1JMvPKplCLgdPS+sIgrb/2tVcWvpyChmGcosqjdCWh+UgeHeiwFKKG0aSudU
         pF5/7MUK7yN5O1oHhxy7tkd+C9Gvy0wCGvgdVQIEc1kbVNXcIkHuBzF9jUWuFJ897isk
         9GGbs5TcAEcZFvBlM7eV2nX5S5f0f7SRQX5LzdYwlQMADi+vnPrjt3nrtJYkxMTxNAPD
         cIhKgv2pUD5tx+dlQARoFYNbYDStplhUWssqe0Nj0KpECD7IEraW0c7tLty7Ul+5TVox
         cbj17HtUvu3bw7o6FOL+QDE0u77YeavPzAavtMNIa8fQITsSbKEn5kJHRKemMNHmGPH1
         1Adg==
X-Gm-Message-State: AOJu0Yxsgxdw+ws/jr8uj/9IxxQcZDdnd05HYMjkXe1NUwkIHzD1BvER
	I4tg7ukkOVvOaICURKniZz0CTa+AVI8z8A8Ifs43Gn1rG/oCk2jo
X-Google-Smtp-Source: AGHT+IEdL0rfE2ngVLis98sz2Et2bc1ZWQFy35+vjRi6eMfzG7owZmSV8St5jB1MyvBtzTCCuSqP7g==
X-Received: by 2002:a17:906:45:b0:a36:ff9f:4256 with SMTP id 5-20020a170906004500b00a36ff9f4256mr5171081ejg.54.1707056207394;
        Sun, 04 Feb 2024 06:16:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWt29i7RWA3YhWUG+h/HUITswl/msvm8UTu4KLG7+vB1kuM2E4mY8LKRdFf2K7slVVh6B455NulOX1Au3D+te5tjH2zRKIR1zyKzioS+WsbmJhpINykCBE7/f0zVqiFLrzv3pNa4o2ypy6FVVjif9FWmhFMc3QOwd6YowvMk8oqxU7TiU0z6zGXO7xrqsqAhfo57so/tb54do8ETEHa4YIzs5cZ
Received: from ?IPV6:2a01:c22:732c:d400:1402:4c43:8a0e:1a33? (dynamic-2a01-0c22-732c-d400-1402-4c43-8a0e-1a33.c22.pool.telefonica.de. [2a01:c22:732c:d400:1402:4c43:8a0e:1a33])
        by smtp.googlemail.com with ESMTPSA id p4-20020a17090628c400b00a360239f006sm3169169ejd.37.2024.02.04.06.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 06:16:47 -0800 (PST)
Message-ID: <98e15038-d96c-442f-93e4-410100d27866@gmail.com>
Date: Sun, 4 Feb 2024 15:16:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/3] net: mdio: add 2.5g and 5g related PMA speed
 constants
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <31a83fd9-90ce-402a-84c7-d5c20540b730@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <31a83fd9-90ce-402a-84c7-d5c20540b730@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Marek Behún <kabel@kernel.org>

Add constants indicating 2.5g and 5g ability in the MMD PMA speed
register.

Signed-off-by: Marek Behún <kabel@kernel.org>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/uapi/linux/mdio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index d03863da1..3c9097502 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -138,6 +138,8 @@
 #define MDIO_PMA_SPEED_1000		0x0010	/* 1000M capable */
 #define MDIO_PMA_SPEED_100		0x0020	/* 100M capable */
 #define MDIO_PMA_SPEED_10		0x0040	/* 10M capable */
+#define MDIO_PMA_SPEED_2_5G		0x2000	/* 2.5G capable */
+#define MDIO_PMA_SPEED_5G		0x4000	/* 5G capable */
 #define MDIO_PCS_SPEED_10P2B		0x0002	/* 10PASS-TS/2BASE-TL capable */
 #define MDIO_PCS_SPEED_2_5G		0x0040	/* 2.5G capable */
 #define MDIO_PCS_SPEED_5G		0x0080	/* 5G capable */
-- 
2.43.0



