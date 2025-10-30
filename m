Return-Path: <netdev+bounces-234516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D275BC22742
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 22:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 767194EE8D7
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 21:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86792330B1E;
	Thu, 30 Oct 2025 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAZrYR+I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F0A524D1
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860728; cv=none; b=cLn6o2PJkqXr4rr40tvUIMnhRMVrKH3nrjCDoOjMKqRKsIBorkzOm9DZa87V5LDixXxOoE/qaYHWO5fveyGdhTSU2s5Nqw63FIVGn6z4kQ0otPPJrysIcDX3helLd1AWDzUZ3x35ML3hVMo8K5OBVypfOGggcICs8NQxx0U43sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860728; c=relaxed/simple;
	bh=uBkk+tHHrc1rrXHOAF46QAp6kvFsvo1lCdXV+dIoOAg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eJM2Dm3hpU1EbZW/51lsJ75lxwIbh+/6qOdvwGCpYZWKz4Gx24X1Z0xz+fN8SGlpYovrGpqPl6aU+3YcANl4cj+HB0H3WBOb3dMSBSUbiD1RvtSggXcD5ZmHcfVBZhjddNpCqAjTvltN2q08RdLXZbud2LNk+myO8N7ZAQ1mZvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAZrYR+I; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c45c11be7so2616921a12.3
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 14:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761860725; x=1762465525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/ooLXFnCj1JQf5bLHzgDLlFMnUZG9dG8krO6XUPVWSM=;
        b=DAZrYR+IMuO1lQYDLx4LNoaTG30vyivrj55tFVmcSv/838PFWgWH8+avNGlM6A0xRc
         bZYFhPKfsViq1zibX801smRQ0Jb8yJzCkKPUWp0vXJgHFd6SJiTPg/nnXSTV/u2GrHva
         cOc5h4XzCjruxcZ95H3iM6T5sAGf/UFv79hDhU6ohIdzZtXjo9QNsaP4tPLA07j1W2qr
         Q1PKPrTl/3sL2b4ruvqUD37z7DAojeVM4NL3pJ1uTwKtJ+RMJmpBVwvS2P6hjYY6BT5Q
         YAsfh9bDbllGyhAGN51MzLsL7bLAEM9BYGDP3ho+x+Ru6JF7R4PkaxrfxdQNo7rpuwdf
         8Iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761860725; x=1762465525;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ooLXFnCj1JQf5bLHzgDLlFMnUZG9dG8krO6XUPVWSM=;
        b=GFqwNBaP5e8p3GO2mvW2SpiZMzGL7nnrRaRfB9WspAXsfjx91EjJpzzh0Xva3uiNRV
         1WDvPydfSGZL73CI1GLm2NiEZ4wSZthJ8FD8G3jSy0lz2D3CC3ed6qK++hlDEqJCnGsa
         SzCgzDZiJ8gZ2BP11E1eeg9fqHOdGUD6X0+yVM2Y1ndlkwvHrqWXa3L2PaxtzonxqWGr
         j1pYbeQRCExdzkDsvc7/n5pDS1anHCt7b9Z3W+s0rzcWPWmw7/rQOh5aehrsp2iFbRik
         a3XcBN3qK3W8QtziCypEj/4BZ6ajTG8CUOa70dtItZ57HwapOY3PYx0RGg6BCaPrQXBE
         4KfA==
X-Forwarded-Encrypted: i=1; AJvYcCUv4Vr+s8LNndtIeseaWMWan5S0WcNcLZd9j9xwxuPsaqdzavqDC1OKNwtEoQ/CL/8oadKNo2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxij4xTRTYlm5yQm1B0zkLJiqZrpkMWzqVEtQmhg73T7VI3Q9E5
	gfdm9BesJS0H+EgBBtw5VHRRK58FHAHT9d3eeXjxml18J4voz2jTK66W
X-Gm-Gg: ASbGncuk9bFRnt5wNio/oroHjo8pON4vhX5/5/FMM7vUbMgI1Skj7x6s9bVQFZfPNWb
	TfiDvaTrltXtXpG9O4buKKlRLIavBT1sn3SbYvZ8UlOjpcza0zwsIbHcRx0bHiid5ApHdDa8otM
	FpDF89hAKp3+DEtUSQwDVZl+uMBF+rEla1/bdoLmwREYLyNW0K6/vLg6Ba4xMgMVQgeCIdWHBNm
	7rS9lwpF+Oqo2+Q4mBW8fVQWVq/osEqOlAJ54WAjnrnQQ2+AKfrAxyh0qW0RdyooALMALx7qwSO
	i5wW/Wv7IBgioqkeBo8qdumP1dtnYtpQQe1wovrqLxSIP32QR6QwEbQbRX1DtsZlAQVS1CZLqaD
	H0QjoZ5E7HGXBviRhGpd4+49RuK5/89JFycyxUbdQm/R86vBj0Kh2SP9S+vVz9USZUI+yXQgd1l
	gBW0iOAxMqUu4Q9Z134CnLAQI7r/07nAviwx91TOiv+vkSlcRb6GdtubphHUVl5D8+qHQ7nAj0N
	ywNhpDQ0TP+FGUHBeVczHdq6lVTzIRQMy5lLdIewhk=
X-Google-Smtp-Source: AGHT+IGhyymQfHr5msGL4ysnrrXsuX5kI/Bs7xqXWjhPsbZ1HNwDrWmnY+RRZo06Z6Ip4+Ixlwd6Nw==
X-Received: by 2002:a05:6402:20d3:10b0:640:6e1e:40a with SMTP id 4fb4d7f45d1cf-64077020c84mr772375a12.25.1761860724741;
        Thu, 30 Oct 2025 14:45:24 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f48:be00:f474:dcfc:be2f:4938? (p200300ea8f48be00f474dcfcbe2f4938.dip0.t-ipconnect.de. [2003:ea:8f48:be00:f474:dcfc:be2f:4938])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b34a735sm17978a12.1.2025.10.30.14.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 14:45:24 -0700 (PDT)
Message-ID: <8983b705-6bca-4728-9283-7aa60f49340f@gmail.com>
Date: Thu, 30 Oct 2025 22:45:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 5/6] MIPS: BCM47XX: remove creating a fixed phy
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Greg Ungerer <gerg@linux-m68k.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Hauke Mehrtens
 <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Michael Chan <michael.chan@broadcom.com>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 imx@lists.linux.dev, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <0285fcb0-0fb5-4f6f-823c-7b6e85e28ba3@gmail.com>
Content-Language: en-US
In-Reply-To: <0285fcb0-0fb5-4f6f-823c-7b6e85e28ba3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Now that b44 ethernet driver creates a fixed phy if needed, we can
remove this here.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/mips/bcm47xx/setup.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index a93a4266d..38ed61b4b 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -256,12 +256,6 @@ static int __init bcm47xx_cpu_fixes(void)
 }
 arch_initcall(bcm47xx_cpu_fixes);
 
-static const struct fixed_phy_status bcm47xx_fixed_phy_status __initconst = {
-	.link	= 1,
-	.speed	= SPEED_100,
-	.duplex	= DUPLEX_FULL,
-};
-
 static int __init bcm47xx_register_bus_complete(void)
 {
 	switch (bcm47xx_bus_type) {
@@ -282,7 +276,6 @@ static int __init bcm47xx_register_bus_complete(void)
 	bcm47xx_leds_register();
 	bcm47xx_workarounds();
 
-	fixed_phy_add(&bcm47xx_fixed_phy_status);
 	return 0;
 }
 device_initcall(bcm47xx_register_bus_complete);
-- 
2.51.1



