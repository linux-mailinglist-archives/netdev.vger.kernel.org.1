Return-Path: <netdev+bounces-151893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41A59F1794
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 21:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E2D188703E
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECACC18D649;
	Fri, 13 Dec 2024 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hninDEb6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE4B189BAC
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734122941; cv=none; b=UzyL5Vu/P7fsKBTlp0C4BV3+zCrBCnU4pPfk6gFpxRW2yDQ5JJNL3bvnW6z/0FcDaWzqv4lB9nOgab/BCui/BTLXvoY5rQaSegVGtuG3dOUTtD5xVN0Av5IUgixnL+BJ1gD+N+hIRcKqkASnSMKUJBSoVdTbsI3keTGvxvGKfBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734122941; c=relaxed/simple;
	bh=h84w4eJYdKl8umuChjOIfJrEe98yr8jKNoEwzxvnibM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=M3wPdI8qysAN/W8qNIdzM6hU/IjjszE8fWK3JO0UZVECVwc6K0FrE8KMQg40McBTG5nVHU5SfFfmV1CV7GXHIGqbqIcomhhRAbh0y9MYCdGJEMv8IK75ZfUSA7NGWzPrH/y07dkFShszGaCGlXXXHMYifmeE/F6FPlaFv332xJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hninDEb6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa66ead88b3so402146066b.0
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 12:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734122937; x=1734727737; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s6nyhrK1PwEvljraydkFoHfOJI8D15rx54zdqll0bjs=;
        b=hninDEb6k84e5ulqIbCC4tCJnevddYt6ma1h9+dRj4wydmooV79uisRL28xpnTkBrM
         /KLow9LCN3eSpK1rWcPg6KS9R4UwzKltSVDyEo9lE0/urafPJi1FyjJstmTgBO+B1TkO
         IFGzMgQVsOpFSTf3ZdTtvnfXsPLIIGU5jIv2qP3MYUFKIgjEJSagDe8kKLaO0XAT8yZy
         4il5nnJpVQjQTOoUWfz+OBn9X6DpoAU1uf4nIo0bghlE6pxV3nMC+aCWdVWsMvv3rPDq
         U+sZsgUfmCsVk3Y/fFDJM4UkQOJmViT4K1Zvxp769DHtv/6HJ2eqf48w4eCE08R/24Jh
         DS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734122937; x=1734727737;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s6nyhrK1PwEvljraydkFoHfOJI8D15rx54zdqll0bjs=;
        b=ZXyFXEIQ2ZbrSpWYwJfTG59xKYuUXL8lEmEpSTwpJLIpwGRMqturlKQSYrjxy5L4pQ
         QxNnFczxV8PETGVWwyhpgEYnYICJFUXoOLcJeexmuDi4AUKoxUYKyr8VEkDaK8ENSYhH
         v0ImUF2QkJyS4010ms6T/DjLEl7hNDWK35IlFWrSt4B0TVguSYGm4OpbqrovcmAAiqik
         F1XK2g+J43CHa9cpifWq63NIx6acp8G8HaCY3V9myINutQQSOfwlPLA9FmEdFcC6lOKS
         7fIySiS1MxbcfsIP/0PZTqnPPNxDpfycko16cYQ05KNAAef3Co4rhzMcHKu8Dv4OXAr5
         Vokg==
X-Gm-Message-State: AOJu0YwPMISalOsoGprVO6xwzMzcNaY+ttF98Cw80RCJc1eFkdSqEUsT
	S5bSiM+ERrMmHhxQ9SlvVIgboVYvOQlkJ+47mrQ6f3ENsu9guO9Z78Kk5w==
X-Gm-Gg: ASbGncsWpHUkCsjaXXwO1V/0tX8BAQBSX2kAAg8aYQ5f6L+st3fHTmcFtgf1j2Xuqop
	hl+uSPjUOyWS2R0EGSK87x4wutUZgt9rXFfzzHxQ0yNQwRBbhrFLWfyFTFU+tdjO+kj1antHsRz
	hI/a1lMqtlRS6aumPIdi/QCfXsAKV5zRM0argroWCoPeiHhavZdVkJBkgEpqOvPUfygKOwT3Cdo
	D8s34yhTVOBDVr8M0fkLz7Mq0BwuP6+sh+kUT2IT1WysuQig8cUq2Y8nFBIb/O+jBqTOn0wog5U
	MX8osbIVe1LFIzD3D+C3beCH3ND51r+tkRDV5ENMhEIvvQ6ToJz5Arn1UyaO8XAyW6c1BIblAIE
	i6bq46KILpb9/SN6kLbqwIl9nHQNiCMagk/pk0fNs/WgcXg==
X-Google-Smtp-Source: AGHT+IFoOJME/VAMzvGMmQNw33+W4Tud96xNonAHwtivAswTeHpu+scESh9H78xq59SiTXiMDiuR6A==
X-Received: by 2002:a17:907:7211:b0:aa6:8ce6:1928 with SMTP id a640c23a62f3a-aab77e7b934mr409147466b.48.1734116386000;
        Fri, 13 Dec 2024 10:59:46 -0800 (PST)
Received: from ?IPV6:2a02:3100:adc3:fd00:9eb:6163:d514:e25d? (dynamic-2a02-3100-adc3-fd00-09eb-6163-d514-e25d.310.pool.telefonica.de. [2a02:3100:adc3:fd00:9eb:6163:d514:e25d])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aab96087424sm4036966b.83.2024.12.13.10.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 10:59:44 -0800 (PST)
Message-ID: <15c4a9fd-a653-4b09-825d-751964832a7a@gmail.com>
Date: Fri, 13 Dec 2024 19:59:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/2] r8169: add support for RTL8125D rev.b
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Chun-Hao Lin <hau@realtek.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add support for RTL8125D rev.b. Its XID is 0x689. It is basically
based on the one with XID 0x688, but with different firmware file.
To avoid a mess with the version numbering, adjust it first.

ChunHao Lin (1):
  r8169: add support for RTL8125D rev.b

Heiner Kallweit (1):
  r8169: adjust version numbering for RTL8126

 drivers/net/ethernet/realtek/r8169.h          |  3 +-
 drivers/net/ethernet/realtek/r8169_main.c     | 68 ++++++++++---------
 .../net/ethernet/realtek/r8169_phy_config.c   |  5 +-
 3 files changed, 42 insertions(+), 34 deletions(-)

-- 
2.47.1




