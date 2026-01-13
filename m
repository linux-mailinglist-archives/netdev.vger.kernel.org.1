Return-Path: <netdev+bounces-249343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EACCD16FCE
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 08:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 516B1302EAE4
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 07:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95FB369962;
	Tue, 13 Jan 2026 07:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPfBOJIg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EAA1BC08F
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768289002; cv=none; b=A0kHMGufLLZRCAyOtRLqvbzZ1Oh7xdnzqhjLgh+n5+92TjcBbVtkt6C4mdXNxGI1NA8KPmg5ll006rzt/d7U4xjwxpstxNqFEyjswVtQ0dYPJmG1XViZSQYi0e1dm1u9oD+SHMroBfVCyc0VxeZHcTT2x1nZM9qYbh4RiqkRRYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768289002; c=relaxed/simple;
	bh=jCZOTQ0S4zPGrVewV7zNDwWTEanfwMTrGpGoODy9ROY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=plSB04IywF16nsdR7WUDhisJTnkDzyf9qBmAHjStd7X9fsfQ5S24F/ZtY+NFQa9SUuCx9S8uONa72pSC4WdurbcIATWGnPrF0geiNA64g62ajhhFG25QK3rsia4JWRNwzM9tl6W7f0Zh8zfPkf3eA7bD37A8m4xoSz4Cp6iqQlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPfBOJIg; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fb5810d39so3732345f8f.2
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 23:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768288999; x=1768893799; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEbfMOGmFF3KnEiYpptf/1+FNigGAulyjnzCIqxEBOU=;
        b=TPfBOJIgrjKwtS0hbpOa+YFYudKlrR0CPcUtTfdEvzeeGkf75XE8p5OdMCp+xgNSUr
         Em3jDJO4Lsxe5HJ/s68EtWjooy9yuBpYMojRsUEtrcnqb0GlX2/yWNCILSWys35oaI0+
         BY+PokINPAVyhaz73SHbevjePMu4Z0Qc0nHDfHKdF/sscQwpjtciIxVlN3F7njfU7S0z
         BH//oazgL9BxiOsuzX771XeAgdNqgurTA7TGX9AT+BqNK2MYiY+AvAtiliY6YJQiNLSP
         SUNnG3Up14dd+6EQuGcl58SVYqS6LrdLuRdS0wiJ0m2Jk7OsdkAz5H0fimFeyn7gsqgQ
         bodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768288999; x=1768893799;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YEbfMOGmFF3KnEiYpptf/1+FNigGAulyjnzCIqxEBOU=;
        b=tR6CJe1QOqJZWkzccR7rYFNROXHNJotFWspfq7MmNKoOLjxbf85KO+/khiW8TV+LPP
         tXVJpkSOg3Ym+LRiPttGY6rgPyKgtmqp2E3wHbfxXicbpO3+t+o2ANG9JtjaYaz71v8A
         5dxKrckysxfjwHigOtB5mFH3imDFm6Nf78oWz7rStDa2j2iSOdXwdujX/UHd1+u6HMfV
         KQmlbA5ZHfayA2kKG02CmvbvrFIGF6VGZ2ZtOUmF7nlbFu/G6dq5YgwFOYwQqnMA3LqU
         tNW1Jt8GOoDGvgnDOj2YPDilgvF+PY0JjzJTVw9kfi5baa1gThsDt4yTjyQJHdwWkZBN
         yf2A==
X-Gm-Message-State: AOJu0YzQZw5mJjVH4BzVtuA5lOROJC9gdDbfKbBS9nz8Ez0erbkrNBWA
	iv44F6vsXrGLZeOj87i4ezQqlPGyFHJYqot+4fe2Et6i5047v62udpPO
X-Gm-Gg: AY/fxX7Lr81eZAcYRhBnTv56YNogUfJ1RcgW/RZ8wSfFI0BgiSJlcUmBXKPWBi6qCOL
	QQhnDKx0EC6iUX4wSbq7sW7W6GaOnUBaj5d5NowK9FRpEmhhpLBB/LUg//zZuUlGRtKhdveIl6K
	EYppr0pt1YYLFFO5CfG6xFGE2HCJXFFL0AwJSU+OE2ZnHce2fON/dei6V4kw2z8c4zhtnowXVrv
	LQOiy1oFsRe22lPvP8t03SmrvkLKlLkIiF5NBtuWy3f38ww7feJNXOQvCXZCTkULqYGly3GXhfD
	uzFMRoGj4GiB3Ya+Y5GVY4uFbx8oHy4IMkeP9JXr/t1IHCoSEYE+2GcNIDlb40ZG1PPcpvDNhRQ
	4SX69+ApGMR4sN4imgqLgYR84fCJQLW75ZPj8CT7Bo7HWpMPaHa1Mdoaxpb/4eQuywzmhHTxBy0
	a8OPH7m9iiR+DjrHMq46EcOY6t8UXiVUVkEWEV8BoZLmP9xdM4ZKcUFp0yIwEWA8xyKaOM2jjzU
	nky3dhKTmqx6c+9vUJqSPjiPAer3OV64E0wP3uLxUe6KodIxDP2BA==
X-Google-Smtp-Source: AGHT+IFV42pk/BOqaBnb9I6uBmKsbIDQ/GvcmLOlMRG74oAZupSAMqRvBe/YcWOX7gd+PN5uttt4Jw==
X-Received: by 2002:a05:6000:1448:b0:431:a0:7dea with SMTP id ffacd0b85a97d-432c374ff61mr26596396f8f.40.1768288999226;
        Mon, 12 Jan 2026 23:23:19 -0800 (PST)
Received: from ?IPV6:2003:ea:8f03:3800:3cc9:69c1:1a2a:f175? (p200300ea8f0338003cc969c11a2af175.dip0.t-ipconnect.de. [2003:ea:8f03:3800:3cc9:69c1:1a2a:f175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e199bsm42227535f8f.16.2026.01.12.23.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 23:23:18 -0800 (PST)
Message-ID: <ff8ac321-435c-48d0-b376-fbca80c0c22e@gmail.com>
Date: Tue, 13 Jan 2026 08:23:17 +0100
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
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Jonathan Corbet <corbet@lwn.net>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linux-doc@vger.kernel.org
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net-next] net: phy: remove unused fixup unregistering
 functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

No user of PHY fixups unregisters these. IOW: The fixup unregistering
functions are unused and can be removed. Remove also documentation
for these functions. Whilst at it, remove also mentioning of
phy_register_fixup() from the Documentation, as this function has been
static since ea47e70e476f ("net: phy: remove fixup-related definitions
from phy.h which are not used outside phylib").

Fixup unregistering functions were added with f38e7a32ee4f
("phy: add phy fixup unregister functions") in 2016, and last user
was removed with 6782d06a47ad ("net: usb: lan78xx: Remove KSZ9031 PHY
fixup") in 2024.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- improve commit message
- remove related documentation
- remove also phy_register_fixup from documentation
---
 Documentation/networking/phy.rst | 22 +--------------
 drivers/net/phy/phy_device.c     | 46 --------------------------------
 include/linux/phy.h              |  4 ---
 3 files changed, 1 insertion(+), 71 deletions(-)

diff --git a/Documentation/networking/phy.rst b/Documentation/networking/phy.rst
index b0f2ef83735..0170c9d4dc5 100644
--- a/Documentation/networking/phy.rst
+++ b/Documentation/networking/phy.rst
@@ -524,33 +524,13 @@ When a match is found, the PHY layer will invoke the run function associated
 with the fixup.  This function is passed a pointer to the phy_device of
 interest.  It should therefore only operate on that PHY.
 
-The platform code can either register the fixup using phy_register_fixup()::
-
-	int phy_register_fixup(const char *phy_id,
-		u32 phy_uid, u32 phy_uid_mask,
-		int (*run)(struct phy_device *));
-
-Or using one of the two stubs, phy_register_fixup_for_uid() and
-phy_register_fixup_for_id()::
+The platform code can register the fixup using one of::
 
  int phy_register_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask,
 		int (*run)(struct phy_device *));
  int phy_register_fixup_for_id(const char *phy_id,
 		int (*run)(struct phy_device *));
 
-The stubs set one of the two matching criteria, and set the other one to
-match anything.
-
-When phy_register_fixup() or \*_for_uid()/\*_for_id() is called at module load
-time, the module needs to unregister the fixup and free allocated memory when
-it's unloaded.
-
-Call one of following function before unloading module::
-
- int phy_unregister_fixup(const char *phy_id, u32 phy_uid, u32 phy_uid_mask);
- int phy_unregister_fixup_for_uid(u32 phy_uid, u32 phy_uid_mask);
- int phy_register_fixup_for_id(const char *phy_id);
-
 Standards
 =========
 
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


