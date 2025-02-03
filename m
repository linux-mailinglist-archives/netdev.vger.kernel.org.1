Return-Path: <netdev+bounces-162234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A281DA26508
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287C6163CC6
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 20:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B15211498;
	Mon,  3 Feb 2025 20:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHv0aRVk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE57211296
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 20:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738615285; cv=none; b=FW8T0Ifjfb8TvP+NwBl00lIubC5sNgCAiWVudXI+/iEGiS3co3e7e99bLqRvGgnF7KvzlzW1q8ivt4tmR7MFOSu8GBg1vRI0CGhx2GGb9SiZvXiPrQOU7GRZYg/B3ZL4POOunl5e+njEteTXZZtCJXEEJrpC6fQF0KCBz5E8HcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738615285; c=relaxed/simple;
	bh=AM7okpuZaqR35imVzVh9Zg9dE6UdzrjHf4NQEfgiC9I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=NKtWphgDU5tioOWF9OHCrj1Chx0v/rzXOyd9C+ACsWvRKDU7+oAjY69GYSZAMErLxq520TEs4FtXZd7M+uthPub7JmXlDVVcQjXOVfAww/eyD+nfI71FhrcofLv/7coPtfY/prsu3nHfC0OIhLBl7NtBKY/lPY15LQK0qaZoseM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHv0aRVk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so11640419a12.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 12:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738615282; x=1739220082; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UngWFGRdANluuqZOoURKTBjILJKhFH8Iga6NKZ0OVIo=;
        b=NHv0aRVktfnpVPBL0dUI7dXN8gFXhMBhkdYJDvLWQaLdpbBEqAZ6P7eA/CySWST6ls
         M0Ey9zizTMH/5RgSF3A+9+vWDkZqzkEmSjWKZIC/zATJaM3tez6q5PM77dOsdGHChPb5
         onIzpI9KU3o2LGXhgqqb1wNnMNBE64olLYKxWPhMZmB1eMLitvYUt/ZzjLR/xXg2ERPe
         wQXW65I6nPoYPg59iYzDhmk2NTO0TXFPll2s5r7wNkPyrMbOa8ETiM93NCQeIAu0uymU
         WIvwjar4kUJjfb/9QDkqa1wHUqNha8L+WE65nTcV58HiXmhFGnoDXkOxqTF/Q1BiYwZk
         JYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738615282; x=1739220082;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UngWFGRdANluuqZOoURKTBjILJKhFH8Iga6NKZ0OVIo=;
        b=V1W8hcYa+IcfQe2901edPu/akO7dlFEKDfogW9SUJqEz2+Htw00tmral7OMwHI0ueO
         RpBWOS6vVEgtOGGe19ZPnByTWPQSWlqjDHx5GDcpGRWbMyhtKjal5nOKiaLs52OsIk1f
         t6x4cG0RprEwe5LrvI/TLR8Qpu66FRQG9AWUvxeRawUmL6ikF6uP1g2rpsywPUrUzNlr
         gE94I3WOghwifWJsQAD/wvajqLnF4Q+obi/db6s4SlF1NaBreeosDlq5u+4j6/XjnC4g
         hrn44TufZEybvbCIbwnnAAMeNDcoG+EX0ebtbsDZJiYZhkBq7n6QK3BhAKxgVC5hmIKw
         Pd1w==
X-Gm-Message-State: AOJu0Yxs232qztPzA+loxsMA5+A3NRby8x0oiz/gTGpcvVi+BLzSDZpY
	griYO437x6iU625kY5zVQXjTvAx9+fd8ZazLT6dWA14+uhY/UIkv
X-Gm-Gg: ASbGncsEcL9kI3ggUZavDCkMsfM6ISok8hlHq+PiOd9ZFaVDgGsK8TLXSVPKIMYwUPT
	54fTb0NNpJ96yhVPUM0gjvMI3gPmzt+urUjASTJPOgvIDp7vZrZiW1m6DE0gCCym0VZlXnvpwkn
	9lKxGd/p38eDmtbWIWbI4ao0HGKMIQ7/x0jWSjEzVnMFHiielu983d0JIJlDs2uC/X0dAZ7fNDw
	IH1GeIjlv44zz1GrZjGBjy5rboSQN8pN4U/nxVncPBMCZBX8BkBmFWgW4A8tBgE/oHErRyd80DT
	WGrQtZKA7usoAsGg8hmjG/CP6haPFnsf5Cob7o0ZST3k7pOM1qoSKT0kR8gQ0pNWTjbsJEl/4wE
	FirSBMMfHlvsAjMEQhEt7LjmZ1sMlZQHugMA6Rpu9VYUD427S4oyO5eBbkDHaQgAPoAf4IVZ4n+
	HJ8BxXSQk=
X-Google-Smtp-Source: AGHT+IGaPfwqzfWP2Ift1peqvEGTzClEndhzZDCn861UhxFmBlGpuvDRhMwSdBALqCVjD4p2Hs2j2w==
X-Received: by 2002:a17:907:7255:b0:aab:a02c:764e with SMTP id a640c23a62f3a-ab748435278mr80534466b.14.1738615281383;
        Mon, 03 Feb 2025 12:41:21 -0800 (PST)
Received: from ?IPV6:2a02:3100:ac6d:8e00:811e:2e8d:e68f:ec04? (dynamic-2a02-3100-ac6d-8e00-811e-2e8d-e68f-ec04.310.pool.telefonica.de. [2a02:3100:ac6d:8e00:811e:2e8d:e68f:ec04])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab6e4a59862sm814805066b.178.2025.02.03.12.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 12:41:20 -0800 (PST)
Message-ID: <d01c4b60-7218-4c40-875e-c0cace910943@gmail.com>
Date: Mon, 3 Feb 2025 21:41:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: realtek: use string choices helpers
To: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use string choices helpers to simplify the code.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501190707.qQS8PGHW-lkp@intel.com/
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/realtek/realtek_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 572a93363..210fefac4 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/string_choices.h>
 
 #include "realtek.h"
 
@@ -422,11 +423,11 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 	} else if (ret) {
 		dev_dbg(dev,
 			"%s 2ns TX delay (and changing the value from pin-strapping RXD1 or the bootloader)\n",
-			val_txdly ? "Enabling" : "Disabling");
+			str_enable_disable(val_txdly));
 	} else {
 		dev_dbg(dev,
 			"2ns TX delay was already %s (by pin-strapping RXD1 or bootloader configuration)\n",
-			val_txdly ? "enabled" : "disabled");
+			str_enabled_disabled(val_txdly));
 	}
 
 	ret = phy_modify_paged_changed(phydev, 0xd08, 0x15, RTL8211F_RX_DELAY,
@@ -437,11 +438,11 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 	} else if (ret) {
 		dev_dbg(dev,
 			"%s 2ns RX delay (and changing the value from pin-strapping RXD0 or the bootloader)\n",
-			val_rxdly ? "Enabling" : "Disabling");
+			str_enable_disable(val_rxdly));
 	} else {
 		dev_dbg(dev,
 			"2ns RX delay was already %s (by pin-strapping RXD0 or bootloader configuration)\n",
-			val_rxdly ? "enabled" : "disabled");
+			str_enabled_disabled(val_rxdly));
 	}
 
 	if (priv->has_phycr2) {
-- 
2.48.1


