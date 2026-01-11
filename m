Return-Path: <netdev+bounces-248843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33916D0F8C2
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 19:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F1AF3047662
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 18:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17122853EE;
	Sun, 11 Jan 2026 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBIaVu64"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD81400C
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768154529; cv=none; b=qIaTSIbDL0XN/n39mZjoh5mTU4ZoJe9ko8CZfE76B3mdcFzfNfqylt7f0emcGmvSYfSF87h2IuphkuvKjy+MH3pDVcGNudhEnyf4spO7MErOzVOqSrVw2ifY1g5YadIZTjUnPwTqQJRzIQfdoyzpwVRr9wk4BC0iqHwuZ98VXRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768154529; c=relaxed/simple;
	bh=YKfvSvgKluw0/nKtERiEs30GlVjnC+1wpVS50IHSmik=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qLFxaJk+7gwsphID37RDzyIac7lK3PeY3Umr3zsWcmtb/6kkqJ31uy4L5mbPrmqY+BkZCkQ4q1Z8ABxGSc7N2Sf2qhkVbte0Fn2ZXNxAK58/YCo7uZqonwfXwZmT60EOamwJwYy4tGLyPVBXj/lhKMWHsvNoRjWgcVAqsVnYErI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBIaVu64; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so47382745e9.2
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 10:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768154527; x=1768759327; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9sRG+38sg6p5JcOpppnux0wCKesiYI2+xQSPmch0ms=;
        b=aBIaVu6451McCN+MoK8nL/z5eegP2jpMdr7+Y19Q/5DDLFCzYUx44eIA7p9ibnaMu0
         OP+XUzS/Fl+f6H9mCquomcErzxRb7TZ54ZI2EDmMWfjGUfIj3do0yFn3FokyJx108GBE
         jsCsiwinauNo7qE2oq2xb2O6TPwaJ28e/81ySMHzwyu1H0/Ft5RhVlxnmUwBu4ZFb+j+
         2cxWqJY0+KRYN9NEVLb03Xx8l4x7D350VNOjkLzp1BlUKAV+k6S3FzcjHgYkV5INnWE7
         NDCPb7PV7fT71M7pdlbuEqBe892wCBqWsMdIIpqSv3dSJ/27/4TuB0okPT+XHaTnGOce
         uqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768154527; x=1768759327;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9sRG+38sg6p5JcOpppnux0wCKesiYI2+xQSPmch0ms=;
        b=PKsMmUNVCJNcM/q19ldJP1jG67NwhEaaMCYK4AtThyKBM+p4kweOk4QUQ/2Bu5Yj0D
         RmQN1TqyrpxTYtXpQTVoLDA5tOwyOycF9x0drUy04YUDvx62I8MdHxT+r2UF/OR+LBoy
         i5b75x0V9tHFiNZDb4XWZXKinZjGvHZLVQuPNfFjlQhIf02gJRNwJnRnaZqhVA0/4DPq
         Nlkwbka1Lncmz4qlh0uhABKEz3eXTFGhVJr83Mi5cErnWgyO8IB3ultbcT9ZZhJlB9hg
         /G+WAR5vIv/iP6bhuEwxXDzz4PiiLkF6Sx+GWfEVgDxtrvC/9hhC/km0cSFx2ulRFCsm
         wPwQ==
X-Gm-Message-State: AOJu0Yz37kvo0qHOpXj6qRV+k0reIBFT32MEQMuFuv+vGAjzH79/ZsuX
	o404mjBk1UFFXGxOOxO+DWf5SXCv6lID+WJciJya032PZgx2W2pkz62I
X-Gm-Gg: AY/fxX6EvKrKxefGyUv52nJc/cBXgwU6uLcUL6FtTpE8bRcWyXK8CYqjQ27g15dFitS
	HANATMv+mSpJTmBfpTSyWz/mmiGkDHWCtgLMGL+TgeObB1RI/3ttJijBJMekhDxI6KOggZuo8lL
	Q1aJQQ2tTYPZ5B9gzfAU9yrWqDY5duJz5aLZewhv6PX40ZyP2VetxmM2KwkpyKTKOTy8HE6/Cx1
	PlvpAX85VuCGnpevavJxY8Qt4knCIWzAxUTTiU7BfxcgL8IPGUnKJTVsrQFBZVEw090PbYU3SIK
	HO0caDTG8C2ExVCAoXWOpvNkab5QWxJjwru0XyQiLJBv7osja5JMUl02WvdA3F7RYP57AsLVAW4
	eouXe7xIv+kJrltVjcdO3sUo0SKeNg3BqWgsdZ6Spa09xOL/XI6lUnyY2w/MDhF4+Yf0YVIhjrd
	D7V3cDWflU8PswSDOhix9bog3cOke42f4Yavyp8FCK8ljNS31oOXVbA3rCTvV8eJg4NaixXSOmz
	PzAoOQzAH8jDIpiubl1rfzFkSrNXaFTgn4YExLo4KQNHXvASyjsYQ==
X-Google-Smtp-Source: AGHT+IEGLG0ZHUzGqkWECWHCcWU+mUN3wKlRRIM5M5sM6kL6Gzx+9b4n6AhbFdlobpQsTkMjcJqhHg==
X-Received: by 2002:a05:600c:4692:b0:47d:3ead:7439 with SMTP id 5b1f17b1804b1-47d84b5403dmr173001035e9.37.1768154526516;
        Sun, 11 Jan 2026 10:02:06 -0800 (PST)
Received: from ?IPV6:2003:ea:8f47:8300:6996:b28c:496c:1292? (p200300ea8f4783006996b28c496c1292.dip0.t-ipconnect.de. [2003:ea:8f47:8300:6996:b28c:496c:1292])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f653c61sm319329715e9.10.2026.01.11.10.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 10:02:06 -0800 (PST)
Message-ID: <03339a9d-121b-40ce-bc6f-a3000cab6925@gmail.com>
Date: Sun, 11 Jan 2026 19:02:06 +0100
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
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: remove unused fixup unregistering
 functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

No user of PHY fixups unregisters these. IOW: The fixup unregistering
functions are unused and can be removed.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy_device.c | 46 ------------------------------------
 include/linux/phy.h          |  4 ----
 2 files changed, 50 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 81984d4ebb7..95f5bb3ab59 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -474,52 +474,6 @@ int phy_register_fixup_for_id(const char *bus_id,
 }
 EXPORT_SYMBOL(phy_register_fixup_for_id);
 
-/**
- * phy_unregister_fixup - remove a phy_fixup from the list
- * @bus_id: A string matches fixup->bus_id (or PHY_ANY_ID) in phy_fixup_list
- * @phy_uid: A phy id matches fixup->phy_id (or PHY_ANY_UID) in phy_fixup_list
- * @phy_uid_mask: Applied to phy_uid and fixup->phy_uid before comparison
- */
-int phy_unregister_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask)
-{
-	struct list_head *pos, *n;
-	struct phy_fixup *fixup;
-	int ret;
-
-	ret = -ENODEV;
-
-	mutex_lock(&phy_fixup_lock);
-	list_for_each_safe(pos, n, &phy_fixup_list) {
-		fixup = list_entry(pos, struct phy_fixup, list);
-
-		if ((!strcmp(fixup->bus_id, bus_id)) &&
-		    phy_id_compare(fixup->phy_uid, phy_uid, phy_uid_mask)) {
-			list_del(&fixup->list);
-			kfree(fixup);
-			ret = 0;
-			break;
-		}
-	}
-	mutex_unlock(&phy_fixup_lock);
-
-	return ret;
-}
-EXPORT_SYMBOL(phy_unregister_fixup);
-
-/* Unregisters a fixup of any PHY with the UID in phy_uid */
-int phy_unregister_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask)
-{
-	return phy_unregister_fixup(PHY_ANY_ID, phy_uid, phy_uid_mask);
-}
-EXPORT_SYMBOL(phy_unregister_fixup_for_uid);
-
-/* Unregisters a fixup of the PHY with id string bus_id */
-int phy_unregister_fixup_for_id(const char *bus_id)
-{
-	return phy_unregister_fixup(bus_id, PHY_ANY_UID, 0xffffffff);
-}
-EXPORT_SYMBOL(phy_unregister_fixup_for_id);
-
 /* Returns 1 if fixup matches phydev in bus_id and phy_uid.
  * Fixups can be set to match any in one or more fields.
  */
diff --git a/include/linux/phy.h b/include/linux/phy.h
index fbbe028cc4b..082612ee954 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2356,10 +2356,6 @@ int phy_register_fixup_for_id(const char *bus_id,
 int phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
 			       int (*run)(struct phy_device *));
 
-int phy_unregister_fixup(const char *bus_id, u32 phy_uid, u32 phy_uid_mask);
-int phy_unregister_fixup_for_id(const char *bus_id);
-int phy_unregister_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask);
-
 int phy_eee_tx_clock_stop_capable(struct phy_device *phydev);
 int phy_eee_rx_clock_stop(struct phy_device *phydev, bool clk_stop_enable);
 int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable);
-- 
2.52.0


