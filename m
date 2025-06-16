Return-Path: <netdev+bounces-198255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CF5ADBB1D
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08F418871FD
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1521F099C;
	Mon, 16 Jun 2025 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDq9aDHl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118C3BA42
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105615; cv=none; b=Zli3Cj2bHgcpcmL44A8mWWEITKD6OxNRlK9vTSpDX7dCqr/jQBowg+iHIEgwqiJX6uvW1LTonftE1DowoFDVSKLyU6zQOTp6XNSWMhz/ul7aLzTg9D9P30iMUhcohnQF0rXV6D1vPFNLqLjqg3yqUo+QJqDei4PLvhrD/BNsl/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105615; c=relaxed/simple;
	bh=zsuj48oEhMSpMjl4wfFrZCJr3/lQqZQDS/tkFwHyCH8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ofn+CV1a7cKPx+BXK2V58Px71k3VoEO8NXxvLWAxeg5Dv7Jo+dfsKuryDEAouOH+zzjPxUf53rPdbwOEKxsxCp9mcTsLgeQnd7cuJQucSVMadx3zZvPFV39fMGJLLLRsjLKQ+GG/SileYqZLmHdfQLTDZquE3Z38J/PWMCZWrWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDq9aDHl; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4f71831abso4497481f8f.3
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 13:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750105612; x=1750710412; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OBnkQFYBIf8SAaIRtdd4YtxmuKvDJZMAlsjfLB0rFWU=;
        b=CDq9aDHl/HpQ7CWl5dRJID3SxXYmFUwhnmB/+mzA2ElWUM8QkRP7FUROJQklY4dKVL
         sNK/d7L+QeW5lrgiUPmlKyR6Z9NnZoazSOrkGOcI88kVrEKZeLk0kaNOHW4QeGx2VzIK
         +XtDJSDz/WpP27j+thzmzrvVuWcj/Kh3A+bN1MyAzOAOFZoVC+jSQY8cTIGlfDi9HVdW
         jveJs1IXfXrRk9ADzajC8r+NMZw46m4hQT2F0HVg1aHzsD4h1+gL+MfTTiq8Iw+Cq4ur
         2tHZdiTgUyhUOrjeRnPyXK9rWtUjyq0L1bj0jVBwiQGU9gDoh09kfu0CJ/3Px9VWCwfO
         F/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750105612; x=1750710412;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OBnkQFYBIf8SAaIRtdd4YtxmuKvDJZMAlsjfLB0rFWU=;
        b=HweD3f/aL5Y6yWRovZ6VBAPke3iIBsSGOpad/S+PWZfWtXPQime+shPfTY+zvuPsB6
         nvpCuhxUHGHyMrFrA7IUVZxKmuyXmqq+3LJIay3IBRop7S4zX2+2WqkAiR06Qg2YeZjd
         LPDUWBatcvQov4tWDl1cfiwx0KIaMyZgmslZgXYNU1Egp/7W+2kLfxnBrMZ0TWCvhRb6
         B4OmthG9UBt2yKlAIWOk3kz/hfRoSyBXumUfInjglzua2vRnrmtTySjYjMRef8jKPcdD
         0jxqq/gjpUWF8gusWf8E7A+zwdj4kK5ZK1CPJqgBX4XSrAEsx+7Iw8nQAYrBQMpxmVUf
         Xr0g==
X-Gm-Message-State: AOJu0YxMLG7Rhgg7WAEE5tSOf7BC8HIA1DRNxNaWhx4InhSwSc6gNJA7
	Nhi6geSw2A5UhS/R4XIOtEWIuiVW0N/V/bytnKm4mTq1V+5xwTL4mES8
X-Gm-Gg: ASbGncsJK6THkd7uU9BJy4XChmpYJHfhtQ/h8V02wryPiUQyk5rStYsipKyinTaOWmZ
	syZyEP3HQES6LrxEiG5pstdsG63FmYxVNQ/6+iYJukFEQWnEjC7cmrM1JY72dyiGRz2K/SHlOlg
	h2K1oEo5c3h36QaK0Ql3OspLdAc8CYpmsxwrQEEf4RYYlnlYpba0X3VxrlsYIE46eo3LKQCUKew
	uyDuF68CJ/AKlvaFw0i0br3yvPujacpMufkO0T1QuOgWRGndi3ZDOBfdEx87ERliql6t4KitkE/
	CsVL71UzI2irCgETdDMb3Oyl+zzhZpS6rFiOJFEpr49wYTseV1jaW/oJB4Vz1g4aej2YHyxVKA/
	G/RwA82lsogMqtXnEETaI6xbCuH4p3zSr2oxIAFKKp4LdefZKDdMaxJ2kBhjFjxOjTg1z9NlGSy
	OOex/1GulJtFhgXPqwd0bu10I=
X-Google-Smtp-Source: AGHT+IGygK47d6oiPRMXO/00ih3LRbjzedTFCUAHrDxk5flpEw/Cch4NDMp0F22gpUK3PR+EUjAwWQ==
X-Received: by 2002:a5d:64ee:0:b0:3a4:e75f:53f5 with SMTP id ffacd0b85a97d-3a5723a26f8mr8990109f8f.35.1750105611939;
        Mon, 16 Jun 2025 13:26:51 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4e:1600:59de:3cc:3fa9:3c6b? (p200300ea8f4e160059de03cc3fa93c6b.dip0.t-ipconnect.de. [2003:ea:8f4e:1600:59de:3cc:3fa9:3c6b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a568b4ba58sm11870984f8f.84.2025.06.16.13.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 13:26:51 -0700 (PDT)
Message-ID: <077a3b63-60a6-4c99-98fe-46252f102a71@gmail.com>
Date: Mon, 16 Jun 2025 22:27:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net] net: ftgmac100: select FIXED_PHY
To: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
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



