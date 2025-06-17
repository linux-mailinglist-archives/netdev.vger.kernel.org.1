Return-Path: <netdev+bounces-198767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF57ADDB33
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 20:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719CF4A19B4
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218152EBBBA;
	Tue, 17 Jun 2025 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIirQAwP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8EA2EBB81
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750184406; cv=none; b=kw9UmpyCJi3ehBn+ELU7vVQDdE1z9aVsNxG6KVoCd5g49yZwAaOhdrYaRlRPLFfEdKETVptVC6sMhBWx6aYgGtB5EfvFpdPHdOo2pdS6wUcTZfewU8M6Q+IIdAeR7caFXZSmXmm5IZKIjfJZvKVIw/g2KBcvl5AbDz+HXvbODUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750184406; c=relaxed/simple;
	bh=zsuj48oEhMSpMjl4wfFrZCJr3/lQqZQDS/tkFwHyCH8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=PhzBdr/7uXcWSemTfcNe0A6BNg/xmujG1qxLwHZguAj2FgvfaC+qg3PmGA9/SX/PC8skN/MvWpevbqE3b61FSXC/tPyY2Rq/YoudQolZi/3V7LEI71kn9ZEgTJwzXouJx5Yd9PlNeBlK+eRX/m/vxcpZnEev3lZ1C+uY2DJpSCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIirQAwP; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-607c2b96b29so11911822a12.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 11:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750184403; x=1750789203; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OBnkQFYBIf8SAaIRtdd4YtxmuKvDJZMAlsjfLB0rFWU=;
        b=HIirQAwP/bkHxSY36Yt6c+vc3a6bfdgAiqn4S9jxPiPMs+s9p8PSeN7vbBFNwRp+za
         6vYxhxsl93vzP1FYGOJdQcItbl71jwSnjo0a4hcn3Q6CjW2IlMxO9Nr8d9jrcJFR99yb
         CIJL2/HWzePP9pmCb9qKppLZBoRDrU7xBtcsIN8bLPb+MhSJHmP0rjTv98gVG8Q5mx6n
         WpoaLMjIgQ6EFKtvPTMLgmf1YDJKWqMQ+npFwNHg1VzUEUaeSzSLggcjCZS5k8gWgFX8
         mLspAlRJwj3/X0H+1CVNEadAB80T4Ua9OUusNl9W/bUEep1yXTM2UnzEBCABcG45cJ+y
         Pyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750184403; x=1750789203;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OBnkQFYBIf8SAaIRtdd4YtxmuKvDJZMAlsjfLB0rFWU=;
        b=j9eFEpiT3/3IoHcPv1hfOu2eufCJDgFEmQ9dpSAlUuaAK/VZ0BGlptY7UPMDFwrhdI
         A+cp7rbiA5eSFZYLXWJXfiGSEDPExKXMMVw83//9DvdP3NBYL+wGoNkNCzj7h1/I+hNk
         wUQ596HwARyWz/gDI0tzuwv/9dYt+pFvQ6uTjKUeano8KMfFZ6a5UIODOGgCv/ZTra6M
         EOhRiNyvp4NvO42KQ8Xkeqr1Yi2wMBk83Izs0HNFa27qS18evXqjDiHXQ2TGSKVazpbv
         TD89VEBo6CW7K/hsaVdDZ/ImehLjrUIqy5GJhS5Tjqir6vAvg4dSOqRwgZXRXiN1FIzl
         7DRg==
X-Gm-Message-State: AOJu0Yw1eCvBWzIMie3wtweRk9I7L2c+IHltT/58xPmOjwJTH7L8jVBz
	g0ehZaECEFu2gnsbszZiqbs9UV+4eZoUmspbwFApRMxC7EgfWmp+D1X6
X-Gm-Gg: ASbGnctsIiukU1TgnMzo+3yDWCwPaqnsG3BUIDHF/7e6/ygjMxbv2h/RaaXo2cnBcRC
	TH8/QxvO9oCiARDPI0n2HS/jNr9ruRBdB06bMMxREont4nxKkakhG1UNZjkbLkRw40qGhZL+vNG
	0RqxovFpvbgxL5CCzZK/TSR2rc2z7yL7Wdte8u5tkdNeow5ukqV25MCyRuWSpoD011WSaoWlQdJ
	TnLLKIOQFkv/bKObpmeYcnQTrbB9vkJJLqPUS9R8cC2cZe/yncxm3b8D6iILKxvZBvTMmcyKmFE
	ORj3Gnb8Q1/WgbshqUMVTJzw6JQ/DTWaHg6vE9XfBHnAKShU4LX4dU7+zauBsURY09VPhvITYWr
	Dup71MOlMMuftP3kW2Z5L7Q0d03cuMqra3ZQJm/ZrLOudWsuaACTpQcho6wp/+5BS1rHs2t5Rp8
	OqTqwtgx+WeAprnSPmE0fYWE1oEQ==
X-Google-Smtp-Source: AGHT+IEP+yuogx3Q+T0BwTrGDJ9P+6NXwkPNl+kxar3wRiUWiysQTi/Yla21meeMV2m99p3fexGw/w==
X-Received: by 2002:a17:907:1c0d:b0:ad8:af1f:938d with SMTP id a640c23a62f3a-adfad54b0f7mr1049649066b.37.1750184402428;
        Tue, 17 Jun 2025 11:20:02 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f28:f900:8891:cf5b:7d2c:9892? (p200300ea8f28f9008891cf5b7d2c9892.dip0.t-ipconnect.de. [2003:ea:8f28:f900:8891:cf5b:7d2c:9892])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-adec892b0f3sm897052566b.126.2025.06.17.11.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 11:20:02 -0700 (PDT)
Message-ID: <476bb33b-5584-40f0-826a-7294980f2895@gmail.com>
Date: Tue, 17 Jun 2025 20:20:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH RESUBMIT net] net: ftgmac100: select FIXED_PHY
To: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Simon Horman <horms@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 rentao.bupt@gmail.com
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Depending on e.g. DT configuration this driver uses a fixed link.
So we shouldn't rely on the user to enable FIXED_PHY, select it in
Kconfig instead. We may end up with a non-functional driver otherwise.

Fixes: 38561ded50d0 ("net: ftgmac100: support fixed link")
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/faraday/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/faraday/Kconfig b/drivers/net/ethernet/faraday/Kconfig
index c699bd6bc..474073c7f 100644
--- a/drivers/net/ethernet/faraday/Kconfig
+++ b/drivers/net/ethernet/faraday/Kconfig
@@ -31,6 +31,7 @@ config FTGMAC100
 	depends on ARM || COMPILE_TEST
 	depends on !64BIT || BROKEN
 	select PHYLIB
+	select FIXED_PHY
 	select MDIO_ASPEED if MACH_ASPEED_G6
 	select CRC32
 	help
-- 
2.49.0




