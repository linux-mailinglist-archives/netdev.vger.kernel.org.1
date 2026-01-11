Return-Path: <netdev+bounces-248805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 507C0D0EE2B
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 13:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 346BB3003499
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 12:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A5D31814C;
	Sun, 11 Jan 2026 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3FM1feW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A761DFDE
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768135236; cv=none; b=tIhuSixeRs6nCyyR2ong1IZHZ+SPFflc2PSrlrNthugZtgEZHsJDPdntWImHbS7L/yUHjqCQfPMmWamlC+ztDUaGPltmQBwEho5p67Q2a+SKjj6zTN1N2ncRVjqgCTJwvxly4Pdk9KUKvUZn8OoGgbm+zEl1Itn0E/v/96pE6y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768135236; c=relaxed/simple;
	bh=AdQnV4f0bdYM2JN9Sf/lbpLo2mHVlvj8g0UziPpw2+A=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=R28DFp5bHubC8hnzlrl+1B1oLAeaKhmVNh6mOeUhJO4Az6Vyg22LHyCtdgr6Unn3+8J5lAiZmh+1J4hXGNxnMFPKHIReg4iOJTU3i0clPtNZryFBI5Zgkm9K18IvILq1AYG0kPgk32kc5AjNBndyqSANsE/Ja5Ln4Uj2mIbGINc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3FM1feW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-430f9ffd4e8so2022888f8f.0
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 04:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768135233; x=1768740033; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuyokbiG904zjSkz+NFnCKQWs1v3HQcZ0GvGh9QSbrY=;
        b=G3FM1feWCOZpePOEtGJ1/hoX6oufiWBB/aNUO733n/zHLIM/LvWvECpf/EtlzQ9ey1
         8D0KDXOXACzMZOUekKuttjZIk79bBHSl0paOCQsT+1a2YXZVuC4Ik402/eVH3XEE80RH
         WMCgsnh31a8/KUmfRZeibEzGnc1JBjQbgvr2InXesCk4go/lnig1/AxAVoRW1bxHuzYx
         uwCp1lHex7yWLhOtQTsaPcBHfem3vs261rt/FjRXu3HEMDI9QHVNFQxs73Hmkjo5xSrU
         io+mtXPjcaim4liEtLG20YG6oCKDOUH0mtU4IZeCTtXR/NPu5uvTt0ujE0UXpHY/wUEP
         TAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768135233; x=1768740033;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XuyokbiG904zjSkz+NFnCKQWs1v3HQcZ0GvGh9QSbrY=;
        b=TKQBgJ9f19J6zme0npZAhcPw61ePq2f/zPsYJHgTp0bdPSKIOnqvBghBUkbCEgSMcv
         XGygfvT3Geb5PVpiy4MrV07RW6piWoOLZ6XDTYlqkdXmmCrKem4mmsAYd2A0jsk6wbks
         6acE1f6kiMqlKaKot8ST8FG4J7QR8YPsZc4AmBGi6om8jAnY4H+ZUJyn+X+zGU59HfzI
         buJcr1+Qo0LkVl6xO72L/dPqezOeTERcKZ9wrwGKe9LXBmgrhKXOosEo+OHEpa8Onfct
         y/AIzoB1Risi8fyC5zD8yh51kJd6kAYuXGmEWKC6QBN+zP/dVBJrV2H+ui/c+je3ZUA6
         T4TA==
X-Gm-Message-State: AOJu0Yz9BkS+UgAogUbzIQzltoaU6DYZpe8LRaGyfnbZw4CRACv8NR1B
	CfTKAB4XAKnUJDfKmWVi6rIpIAXGAZCtb2QbV0WJTfevRckylFDRVsBH
X-Gm-Gg: AY/fxX59AwEIZ7qb1tQysG2sLriIj89gq8UN49SPIw/inz520OCmlRIlTCoPAExtnnt
	svhRs9/pfUpwbs4Z2GMX/noPjcMkohtyCYBcTC5tDVOoRpXEwzOl+/EMssgQDC7egIdz9wJWMQi
	UO8M8sbee/7Vo3uSZ27z/wQHk+KxVO7De7d4/Uxyet8O++um3DnEIHHGeap2c4ewKm/eUrRBQii
	4PaT5oi9TSzUa5yeoJu2pAgMO7rspSKZYHpO9cQud4qZnxM4PoeRLtl2Ve1s/BPyi/CWLqDtEQ/
	lTPSDNpEl7LHTFKIvAQu6fMQJl8TVS3vVuWIq+T5+yoUx4gGurHMZyRcMAhYQaUPkMjlBKrjRmZ
	zbBHMHH15otBsoE3SbseLvNNB2pWuR62jMr711ybCnkwyNBtLvEIYIgLUhWsrfNEtDq+L+l6zpR
	G5y3ucDEiaTpNzr3UAd3ZzQAt8RHzPHpJLXPZST+uQezrAhEtlN5AMqqQ9h78ZEk9p0sgNscXPO
	t2p0yrVceVfKtJA3OL6YjbwLqH+yVIuITsBV4uo8zqzdDsgCZnKdw==
X-Google-Smtp-Source: AGHT+IFJYDHFeeDV6ZUblZIChBF4JrTxrX0TTzg9Ohrp4+IipOLwcD5/emonb+21HB6HjVx2dx3N3g==
X-Received: by 2002:a5d:5887:0:b0:42f:b555:5274 with SMTP id ffacd0b85a97d-432bcfde7efmr21553726f8f.20.1768135232857;
        Sun, 11 Jan 2026 04:40:32 -0800 (PST)
Received: from ?IPV6:2003:ea:8f47:8300:6996:b28c:496c:1292? (p200300ea8f4783006996b28c496c1292.dip0.t-ipconnect.de. [2003:ea:8f47:8300:6996:b28c:496c:1292])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df939sm32503475f8f.21.2026.01.11.04.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 04:40:32 -0800 (PST)
Message-ID: <110f676d-727c-4575-abe4-e383f98fc38f@gmail.com>
Date: Sun, 11 Jan 2026 13:40:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next v2 0/2] net: phy: fixed_phy: replace list of fixed
 PHYs with static array
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Due to max 32 PHY addresses being available per mii bus, using a list
can't support more fixed PHY's. And there's no known use case for as
much as 32 fixed PHY's on a system. 8 should be plenty of fixed PHY's,
so use an array of that size instead of a list. This allows to
significantly reduce the code size and complexity.
In addition replace heavy-weight IDA with a simple bitmap.

Heiner Kallweit (2):
  net: phy: fixed_phy: replace list of fixed PHYs with static array
  net: phy: fixed_phy: replace IDA with a bitmap

 drivers/net/phy/fixed_phy.c | 83 +++++++++++++------------------------
 1 file changed, 29 insertions(+), 54 deletions(-)

-- 
2.52.0


