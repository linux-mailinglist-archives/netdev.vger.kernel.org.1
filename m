Return-Path: <netdev+bounces-189890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D2EAB4565
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 22:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD69819E6CA7
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 20:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA25F257432;
	Mon, 12 May 2025 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ll/C4K90"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3160F254B10
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747081243; cv=none; b=oSG4qLoSqu1ieJyLRo4LY1tdVyU47wtcJIwVJVDehvl7dZbMBF4c2/P+ebDUPuwBMfduy8i9VA3b30pluldvxLHoMNlQl7DA+tHVuCl5hlPyLugjQHYI2+s6df/oCtUVFMR3InaV7G3TK6MwqHw30v274oaxb15Ig4pQ0mInZXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747081243; c=relaxed/simple;
	bh=74pCFdxbzG91hiXN7IT1fPG/fWLRuGAuRRUSndz/P48=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JQc7k2iAqcR96VEGVQcs1k5bHKNX+9gY9a2A4G2rPQBIrpfvCsnjLB0dXOS6N1HxjB0is/32pNBl9Mo9ovygqBqW0lnrtifBg5MXge9vLwSLCKGc9Nx7UTquScOfwgqnNbTy6CsYwR8jzmrfEAnzv5Hng0e27h5C95NC9OPJL6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ll/C4K90; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a0ac853894so4239578f8f.3
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 13:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747081239; x=1747686039; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eoVciZvjEXweIiR2OLFtNkC5aLgYb+q5H8UeMfYZ0Q=;
        b=Ll/C4K908tBtzjY9UNc9E4nLRV91Kz0Jkcgx7+cv1bXR1UKB3/jDO4Fhex48I7wJiV
         9odoagdbwZbLJ0Laow4hPW+Upt588fYvt6Wy67l6nd/61HG9fKMtERl3kZalYxiRo6Qw
         4fdV/xEbgKW9ffcN+Dt8fc7TsEvBwZAf1DAYfexo3ff7NXQADNxtgwgWOBALIohT8ihp
         U4DtDE/AukRW+RBat7ExVsgziZzNqNlAeFwHywm+QuXydwc1dxUSe6yQcosTUWx9bDCR
         jrRqYguif6TVwQAx2sF52kXTNfUt2VVspG0FFH8RNe4K5XCpv8cDEs/Y01/qHnwvsSZr
         lAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747081239; x=1747686039;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1eoVciZvjEXweIiR2OLFtNkC5aLgYb+q5H8UeMfYZ0Q=;
        b=KG0zvklXgraFK+3rhryGNP0HZuv9J0d3ZODn7du548kCyAOo1lnEKaWG/0AkxnasKH
         a3Y/s9ZC2ZLrGw9Yw0rwK9D4G91ZequlAVTy1RPECZPEaC1Orto3wK3WvXYk/btuApd5
         gILfYuDpK/fLoKI8F8fLldFYHyUvNWOv1jFThov6WgB25/rghsICqNu05pcXb2ddl13t
         Tq7AP+by7BjaAqAPnsKS25+nau+u0n2rmUaFOalggwHstgEyJIUu4aZ3u/awFKQNSnAT
         +QZ/ORHNFxC/c50SPkH1rgu7Hu/bwH25TWeOZ7sdyAMmbszw5eOW9OeroZWfg5lDsjRL
         eOqw==
X-Gm-Message-State: AOJu0YwEHZ0qkm9cbfZ4yl1F2GddOsQ5Wm5VZdRZRkygzjWXdr+/wW8w
	2vPl5i8w4l7f1tOg0DiNcYqg1BRB0b+9XAsUjCc5LBe0mM2N1BwK
X-Gm-Gg: ASbGncskbTTNIomENZAZY2nsSFg9rnf72SPLWoVvP+zbv4Qs3pRnR4Tgh+gIwRE1wZ4
	e2TzCmrlhRHrav2eomvlgHWa12/0aMdDgncggT/LgCnYfPNHSBARh4x/tPZquB6+ciTeJOp3csK
	/rs3Uyzxyy+bknXdGLcXpTf5/ouP1cEv5Mi1EZevrWIm2/SZf7X6hNoLHOgDQvUxUAqLWzBeGts
	78dgT4A9xFyTDacxHpyEBEZQX3gyoEQBmujiMPGjtvKU47mNNDhfRCOvrjfuY6ITT51uVBbsPK1
	VqE0Xy0fNTdFNqcNzZrmeMW7zQr7WWhy0lmJpgY5BV3hHGIui6/Rh7HAc4JYh325KRj7gCo+iNu
	OynMWppab5iOTi6Q39FpcRukqWzi3VSeN2XigpWhnj0M38c6JoaqQm4/ymLdOA1EE0cUsMDQsRK
	EmaplQibm0uA==
X-Google-Smtp-Source: AGHT+IETkr5dxF4479p/EP53V1qfXD2gKQVMszhanzkeD0hFslwTfa3SKlNkgf4WH06om6HnGyHPoQ==
X-Received: by 2002:a05:6000:4285:b0:39c:12ce:6a0 with SMTP id ffacd0b85a97d-3a1f6437e79mr10700931f8f.21.1747081239212;
        Mon, 12 May 2025 13:20:39 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f15:f100:68c2:94:4a90:de4e? (p200300ea8f15f10068c200944a90de4e.dip0.t-ipconnect.de. [2003:ea:8f15:f100:68c2:94:4a90:de4e])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c5e1sm13365892f8f.89.2025.05.12.13.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 13:20:38 -0700 (PDT)
Message-ID: <410a2222-c4e8-45b0-9091-d49674caeb00@gmail.com>
Date: Mon, 12 May 2025 22:20:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: remove stub for
 mdiobus_register_board_info
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The functionality of mdiobus_register_board_info() typically isn't
optional for the caller. Therefore remove the stub.

Note: Currently we have only one caller of mdiobus_register_board_info(),
in a DSA/PHYLINK context. Therefore CONFIG_MDIO_DEVICE is selected anyway.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/phy.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index d62d29202..7c29d346d 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2071,17 +2071,8 @@ struct mdio_board_info {
 	const void	*platform_data;
 };
 
-#if IS_ENABLED(CONFIG_MDIO_DEVICE)
 int mdiobus_register_board_info(const struct mdio_board_info *info,
 				unsigned int n);
-#else
-static inline int mdiobus_register_board_info(const struct mdio_board_info *i,
-					      unsigned int n)
-{
-	return 0;
-}
-#endif
-
 
 /**
  * phy_module_driver() - Helper macro for registering PHY drivers
-- 
2.49.0


