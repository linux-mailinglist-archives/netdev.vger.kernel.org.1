Return-Path: <netdev+bounces-181989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 197C9A87405
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 23:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF7C1708B6
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 21:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9671A1F2B88;
	Sun, 13 Apr 2025 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEpy1/VU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C781F1931
	for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744579354; cv=none; b=ekRHYKMDvGscMfJTri8J2O8mJaHQsPlXUsG5SnCwR5x7gI/HUN3twYlQ3Mwg97J7EtJR7PpTiguqWPzWmgHPgor//jVlVszCsvJw8mjCjQ2LYb4nOyPc467bcEz/TL7TofbEWFOjNgOQ/mvVDk++VI9rFSk50RBd1b/0Ij07n2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744579354; c=relaxed/simple;
	bh=ogCdg/PCG+hWRlJihkja8r4kjguAaXNKxU8l3aoGDOA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=JaWSolrt29aDPOw13ytT9ob9XnEWjUp3fUo8JsGSw3dFzYVQFj3DBSJIgAYA8K4PcH1+ax+EMC3Kt9YvOWdEInYiv7opw749G4gsQfWWhxWzcUiGOuaZPMVSLeeaOuABzST2M0n8jrMj9OaiJvDcjElcSzMGQiIlmPKxPLKsYe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEpy1/VU; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abbb12bea54so733086966b.0
        for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 14:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744579351; x=1745184151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5kYb1c8wtLaA7P8jZfnvl4y6hb4mGCoF9SlUTQ4pa8=;
        b=bEpy1/VUqUJosm+Cnz9wjwjtr5C6oDvAtIm7CsIoQdUdhR5jT8CrILY49edZelIL7e
         A8Hm8hahBG0BDoH6esgq61X12olV7GZpalj4cfTigtht9P9QZL4JBNkYdGsSWGsfA5Ae
         1Q2ZXkL5LdyiW6Z6E3E32Ll9ZF621hqt79/5iFBilo/C50yPdw5Mr9hoyBCuDcztvRdB
         oMwGhT8pvZ8LUuPr791AkrVkCg6KFgty4Ttfb3ZYQQv6MepklTepumjNKmvuvA3s/TXr
         niQItRJ49CyJJjJ1RBZ7UmRpsu7Bs0oLSqYQtAbB7rPgfCinXgjlGaNjqBndFbE890ql
         okNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744579351; x=1745184151;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5kYb1c8wtLaA7P8jZfnvl4y6hb4mGCoF9SlUTQ4pa8=;
        b=peR/oVc0HFUv0GBMnIx1UdYMkU/L1bIw+z4CBQqw27WXZYDpIEm4tsA8hgqCgswa5/
         nQtAZCHQgVQv4tDMhZI/BNwKsyr3ZnsZkPPCyUGn4ixu5FUaWCR/NsiDxVpw12G0YD7T
         ltQ7N9dQuUV3JBO3j4D4Uw+5Y25ZVfkJ7y2trfBh1RdGgGhW6gE3/dnwpAI4vI5/+4ta
         /pp+VwHCT82+HZ8Vy7qKpwCN3bdDTILXoWXvdZy0i6LGrJ9Kmjr9LuSWcZw0xAVjEP5B
         HvkfoXOfIaiAE5LLkLDQlsseheKdylO5WPB7zehyZ22QLfqA8EXgxK1mAvaiUxqzbGbV
         3ovg==
X-Gm-Message-State: AOJu0Yxb1QiQ7gbwAzhG5miqmiuipOiiqVtH7wXOUSNDjFXjhQVj5I5C
	BQPprKc33/PKVaeYlcuWpvsyXpq4XfWf4n5FsK+1g/BJMMbzzZFY
X-Gm-Gg: ASbGncutO+4HgEw2muVIFzuidMHQnftjfeBTzu9KtpwkCVmKnMvk3lQzs5Ae1mzA/GR
	swn+T7e2eWgDE1NggEMKEadwRjR5dERvHRW8V5Nv2yiiBog1/witoKQqdnLRZDL+oDSDAQyN8ya
	rdRDa2r+mKI3u2aYNzWkHPOFb07EGeq4IwrloTt/oBUnpE7Yx3kofJtJ1M+TRpzT7rbpXyunzGX
	Z67+MbrLykRlCE2mBtTeTX+hr/2CKA9l9+hDqfvJaWML3IQL6TcmObet3bwoxJeD3TIqcRn2jcF
	KLcfjkTtGe3gq1NhVyAJJWaG8iI10ZIApuuw34KVNlZ1XsuI3aupUxXoB9hmxmtgfhPIBTKhpXr
	6Oy86AF+xmJGsyrxJjCSVGYeDjAs04sLlEQwtOn1TdXobUYROqJp7N/op4SqVkAa6AU2w086Dmp
	O3PdIVHiRJ6S8ICChl7RlMJKYqBjNsrA==
X-Google-Smtp-Source: AGHT+IH7mrNJuE32mjK2TEepcmWPqMyqTtSxmpw7rQHhtagRfF1tpd0nbmUsZmZbhPgTnMN4J6ch+Q==
X-Received: by 2002:a17:907:76b7:b0:aca:e338:9959 with SMTP id a640c23a62f3a-acae3389abamr445954366b.61.1744579350746;
        Sun, 13 Apr 2025 14:22:30 -0700 (PDT)
Received: from ?IPV6:2a02:3100:af2b:bc00:419e:9df:ec7f:c3f4? (dynamic-2a02-3100-af2b-bc00-419e-09df-ec7f-c3f4.310.pool.telefonica.de. [2a02:3100:af2b:bc00:419e:9df:ec7f:c3f4])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-acaa1bb2e15sm807361666b.17.2025.04.13.14.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 14:22:30 -0700 (PDT)
Message-ID: <085892cd-aa11-4c22-bf8a-574a5c6dcd7c@gmail.com>
Date: Sun, 13 Apr 2025 23:23:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: remove redundant dependency on NETDEVICES
 for PHYLINK and PHYLIB
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

drivers/net/phy/Kconfig is included from drivers/net/Kconfig in an
"if NETDEVICES" section. Therefore we don't have to duplicate the
dependency here. And if e.g. PHYLINK is selected somewhere, then the
dependency is ignored anyway (see note in Kconfig help).

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index d29f9f7fd..0b8cc325e 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -5,7 +5,6 @@
 
 config PHYLINK
 	tristate
-	depends on NETDEVICES
 	select PHYLIB
 	select SWPHY
 	help
@@ -15,7 +14,6 @@ config PHYLINK
 
 menuconfig PHYLIB
 	tristate "PHY Device support and infrastructure"
-	depends on NETDEVICES
 	select MDIO_DEVICE
 	select MDIO_DEVRES
 	help
-- 
2.49.0


