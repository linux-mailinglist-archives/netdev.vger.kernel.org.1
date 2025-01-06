Return-Path: <netdev+bounces-155464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCA6A02660
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0753A41E6
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3201D90C5;
	Mon,  6 Jan 2025 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX+sO8Of"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9B31C69D
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169643; cv=none; b=hOrYf7jTibAnrwOggbR/4VXVHiB61KYVBw1Hr35m7nhk68ctQLQ/mTC6U5B+QcaNshy4zn992P/WTvvIc6hRATrXyPXOuNWAuzyyOK9Vw9EGDnF/gevuBopwsIxxETpObLY2t3kY8FjOor47SB24fO+zCKSwfeUUSwL4jp++v7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169643; c=relaxed/simple;
	bh=l3pzccZMwkWFixV8q6QWV0uI8N2lJsqCWi2CEFmFrTw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=U1WeVVZI2euSmy2xkk4Wt5aEHs1ZRV3o+MlPvFIEu6rcYRF2d2jQN47uDYS+yxi0e5BuB1KhgE9Au/lNSJjdjmN2z3XliBu8+5jXVZ0Uu80Hw2rHnd2ik5K9Tz4G1TrG5H2NPwbzRii2w07dI9gjXyEMCbNxCUfn+YFmZcnyfWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PX+sO8Of; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d4e2aa7ea9so27166557a12.2
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 05:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736169640; x=1736774440; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8whYgyCtNkjKoDhznDPQbhwcWFFC5vJfnc+iaGqSUeQ=;
        b=PX+sO8Ofdj01CpILdM/uuSac/viFdhHqOeGZEtsbpEbO/gbUDcxWp0Chkp6HL4lXhJ
         K6ce6irGI7x1xHVcM4OSGj91KywbYlP9kyxgZm+tjk0dfLRdYI8NuUro8brc/XdACggf
         zKVjpbzsMZJexx+vs/jwEDuDqlUoFJYt9+NxR+FXnUWrR3U4DiH8lGOQqXQ1EHENYG44
         WgM+d8SozLgwSncYPBR2ZK7K7FE2Yt8s9HMeMVSufbvdbnZXiprpBffTe4J6BrmpYt2B
         X1LmnBM64eUuHuECbtT44EN5r2sDsu4l1rplN1LtA2cLuSneDeHQrP7Pb3Lq21vKnXda
         mkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736169640; x=1736774440;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8whYgyCtNkjKoDhznDPQbhwcWFFC5vJfnc+iaGqSUeQ=;
        b=croA1N8EWm89J1eefkODcgkgbzyCWu4flm+q4uSlYskF5fjZ/38HWm3G/AplEOZijh
         vyjqiNBd1VZijQ03Udp7yHk8rOYy5fq2r5nX4nTL1MsJw5NdFwoKHXB/Oqvz2SXsvvxH
         woQOAgu+Elif+BHMXEPHTrNjd/JFdZIILkthbf1LL+9dXZm6PNcWSfw/OkZb7JKjR4sl
         mU7yNK0ohYNKVWLuRaO+TdouEhxfU2VlpKjvi3sUTTpURio2jUjxKn6QKHpkG1cMpdEx
         652iCCPvrzgy+uGTibLG+NSlttXjrkpV2/zZ8lfNSlJNpiKZ5qwvREhio7Feb6WdsGjL
         CNdA==
X-Gm-Message-State: AOJu0YyySvLZX+R9wbrDbIpAxyJryHZEgML3reLDpV9o+cPAGs+ihWYf
	P1sScIfi5IqfOwQf3BlNZ436DTcnhjuK3srmtbFZOuFEBIYJ+6It
X-Gm-Gg: ASbGncuw3kXMb3ImYzsj4Z15jfHsLgaxoeOMe90sQBdKSh4EMgst+j9i8tX6elhNjzU
	1ZwEO8hR4+kRaF8SW8nOdd47RNJwj6/qGxDHOH/PuKyiRZ+2xUZMFEqzhjIY6/kvGXslzOCNlWx
	X1PGx4H9xJeWYCaJiQKwEQ+AN+Mih6MwI2/JsiGcuTF91UXhiRfSKFPot/omh1T6SaoBDjHESP1
	UVxrlr1E6eB3GQiv3MJX93ZZzlA+OCRPVnKrgxZQbHN3+wuX32VpBmm0KCnQVeW0BD59TpKBtO4
	oM6pndz+/Y/HSr863Fpz915pDN1h4AYG8G0Letu9tegaFrWE6T0k3pgQk7Sk3hiHZcmLu1w3BV6
	B0qxZN1SkkEK+Xa+EU9rxk1LnVw9ma4ak/2VE0I8v
X-Google-Smtp-Source: AGHT+IHvGgmJgA45lr4/cVTCUkETHwERRaGfvptnI9YC7G66Qnt7T6W1G2BxweZiDvxHq357B2FRow==
X-Received: by 2002:a17:907:6d19:b0:aa6:8a1b:8b7c with SMTP id a640c23a62f3a-aac2d44727fmr5517262966b.2.1736169639855;
        Mon, 06 Jan 2025 05:20:39 -0800 (PST)
Received: from ?IPV6:2a02:3100:ad97:900:c87:b717:6cf:e370? (dynamic-2a02-3100-ad97-0900-0c87-b717-06cf-e370.310.pool.telefonica.de. [2a02:3100:ad97:900:c87:b717:6cf:e370])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aac0e89598csm2240986866b.56.2025.01.06.05.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 05:20:38 -0800 (PST)
Message-ID: <79f347c6-ac14-475a-8c93-f1a4efc3e15b@gmail.com>
Date: Mon, 6 Jan 2025 14:20:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Woojung Huh <Woojung.Huh@microchip.com>,
 Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
 Tim Harvey <tharvey@gateworks.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next v2 0/2] microchip/micrel switch: replace
 MICREL_NO_EEE workaround
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On several supported switches the integrated PHY's have buggy EEE.
On the GBit-capable ones it's always the same type of PHY with PHY ID
0x00221631, so I think we can assume that all PHY's with this id
have this EEE issue. Let's simplify erratum handling by calling
phy_disable_eee() for this PHY type.

v2:
- Use phy_disable_eee() instead of clearing supported_eee in patch 1

Heiner Kallweit (2):
  net: phy: micrel: disable EEE on KSZ9477-type PHY
  net: dsa: microchip: remove MICREL_NO_EEE workaround

 drivers/net/dsa/microchip/ksz_common.c | 25 -------------------------
 drivers/net/phy/micrel.c               | 12 ++++++------
 include/linux/micrel_phy.h             |  1 -
 3 files changed, 6 insertions(+), 32 deletions(-)

-- 
2.47.1


