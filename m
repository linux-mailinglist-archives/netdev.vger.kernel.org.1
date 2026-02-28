Return-Path: <netdev+bounces-262262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PECDgN5o2lvEAUAu9opvQ
	(envelope-from <netdev+bounces-262262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 00:23:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE0B1C9AB5
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 00:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D33FC3025E54
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9B43B3C14;
	Sat, 28 Feb 2026 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCbiGF9U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75243E0C58
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 23:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772320990; cv=none; b=sJkyxhMevXoNfDNRHiFwk3RLWQPjqVUIwFDoDNTbQbalek1W/kEIHmyYpbxHZFKp7g+htd/D5azeARyKf7ckrR00nslWQP5tBLhdl5Jc4Y2Y7SBObO1tD2oZgT1eqXrrPLZeV8BXc//EIW+H3veNAgniAIzqh4Ia52Cvc5MMHe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772320990; c=relaxed/simple;
	bh=VLHiua2iLbiZ7Hk6ZHDZpitnvizx9Nykr+jwd3W0HG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcjSDwImoO4eyL1a2XI5lC8pBNCv3sjFugry+oozTld1pl6GAPv9iNkbyaBn0sDahbLzdHX0TNxxx5NeeufpjpHqLNjCS+7VnGzQonqZAqT1OpNkI9X+ZvENRmRFhbRo7wb/nEOaVdc4ZjKj0svAoKqjux+rNc2B3Kr4s8p2iEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCbiGF9U; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4398d9a12c6so2485296f8f.2
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 15:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772320987; x=1772925787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtSinzVGJkzPvF9jByekTq6nORuTGb+Z3JsuJnZZQ7c=;
        b=SCbiGF9UIEOLCF+7xUb01le0+fKVUf/0ywWyTDAGn2Zi0JErN6Qfw0AnblUTXOT5hC
         p68qGrZcttEWOf1dQvpUzxchOfIpIczkBts0gJQ4KE0DMHgRbEYoI63D2mwHdLp3dUsN
         4gZ2pooOhnIvPfy6S9Z/rnojfx9aH3pdogLZ/XydaotNGo8jw6bS2KpCXSH8He8Rfgcj
         Y3+qOiYtLAgqUUUC3fxgx3ZgZJk8AGYkM+c5pAJI0Gr3wT5LQYQIgW3itAVte6GiYIJd
         mchAPuwsDAbrsbfzgSkYwrHrxFljjUozdu7Jh723epdYEocQ6AONZxspMNKiSq4w33eW
         iJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772320987; x=1772925787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TtSinzVGJkzPvF9jByekTq6nORuTGb+Z3JsuJnZZQ7c=;
        b=vhZDJOWyEeRG6BRcsnvakF6AbkzumpjhA0PPzLs+OK7KXXqcOVIul6gMd1NR5Pv7CW
         cZ/R387+q8qty23f9oLExoW21/oZ7wRVE4yGejGfDY9qlU+6x+0tVn4XqmPBWqcRF3/L
         IoJLSyTa6IecP61PKiU9Y9pbMyj0MyFdBcLKRmZlUzZiIPiATzCa6jj0yhUjJdKAfy2S
         gojnU8V2zoFTSxmXUFM6QIip748o8pFsyJtzVS4Hgne5ZB+jQZyCXUVNUh9TRLHuvL5/
         teC0egrutpbWv/S21/F/Z/QrmhkeOTm12TZ/wSNnB9uq8B7GpkRz7CtH4cR0DfBDo0jy
         uxhg==
X-Forwarded-Encrypted: i=1; AJvYcCWqWQHbYYJQimEmQ9woJ7nOnwBIMtOaNqkTRAv9/owidzFM3OKd6xDTSf04eYmp4LSVB3LAi1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXcUnYavIA6J0N+xsm4Xyp5P5lZS/231rn5uf/lD2WFnlx7Vnp
	dA3IL5rGGwJolzY13xCQCnxkwoGT9CksX91NtXCEHt6QLzjmWj0mUHxv
X-Gm-Gg: ATEYQzxKUBwuVHlVfZKZyqOAF36KiWTG6Ok98UlRgJdbt43HO8AB4nJ5ZnB9UgfayUa
	7pkfkTb5hpYF+beIIeV5Mr9Y1IHjXGWnQMxjayNnzgqn1K3Ee/gcCAowJGGo4mkyTLK155LfXFA
	seBoPS9Ool6OLXzHkwAxf2EpvHnNqFqapcNONVuDj11JPlUJtkObVodYEs+CK69s/zUJeERzR0C
	twXiw8DshdCbkn1+D0cyo9L4a2kMucDl32YUwd4aE6FhJym0A/sWqBPArE0S6kMRooqwEPn3NA8
	cL5rJM44QB7lRWMQPSHlUAx6/Ev0S7G2LVJ4h+jvpy6e3NfNEQlHxhy4SW2iZwgXqgEC9C6OkrH
	pL5H7AORkyNrs+E+JV8rCcpsQR0gB0rXVcddGDeApkqb6gCmXApGxUu5DhUPoEmaPyItWXhxi8p
	L7X6FUl+19Agc0wFEC7jPWiKqwmaTqvRHpIXBLoscwkz0EtCcg4HH5tBJJ5Z+SEmu7kgfBE5WBS
	4RCWLI=
X-Received: by 2002:a05:6000:2007:b0:437:6625:d0d7 with SMTP id ffacd0b85a97d-4399de3694fmr12066071f8f.42.1772320987140;
        Sat, 28 Feb 2026 15:23:07 -0800 (PST)
Received: from pc-kuba-l13.. (snat-2.cgn.sat-an.net. [176.222.226.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c70ed47sm18515680f8f.11.2026.02.28.15.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 15:23:06 -0800 (PST)
From: =?UTF-8?q?Jakub=20Van=C4=9Bk?= <linuxtardis@gmail.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Daniel Golle <daniel@makrotopia.org>,
	=?UTF-8?q?Jakub=20Van=C4=9Bk?= <linuxtardis@gmail.com>
Subject: [PATCH net-next v2 4/5] net: phy: Add infrastructure for PHY address 0 fixups
Date: Sun,  1 Mar 2026 00:22:40 +0100
Message-ID: <20260228232241.1274236-5-linuxtardis@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228232241.1274236-1-linuxtardis@gmail.com>
References: <20260228232241.1274236-1-linuxtardis@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262262-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,motor-comm.com,marvell.com,makrotopia.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxtardis@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EDE0B1C9AB5
X-Rspamd-Action: no action

Certain PHYs incorrectly treat MDIO address 0 as a broadcast address and
therefore respond both at address 0 and at their assigned address.
As outlined in the code, this is problematic. Provide a way to
disable this behaviour via a PHY fixup.

It would be ideal to have these collisions prevented early
by the bootloader, but there may be hardware (e.g. WiFi routers)
out there where the bootloader doesn't do this and cannot be easily
replaced.

Signed-off-by: Jakub Vaněk <linuxtardis@gmail.com>
---
 drivers/net/phy/Makefile            |  3 ++-
 drivers/net/phy/phy_common_fixups.c | 26 ++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c        |  4 ++++
 drivers/net/phy/phylib-internal.h   |  2 ++
 4 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/phy_common_fixups.c

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 3a34917adea7..3bf9ba208b90 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -3,7 +3,8 @@
 
 libphy-y			:= phy.o phy-c45.o phy-core.o phy_device.o \
 				   linkmode.o phy_link_topology.o \
-				   phy_caps.o mdio_bus_provider.o phy_port.o
+				   phy_caps.o mdio_bus_provider.o phy_port.o \
+				   phy_common_fixups.o
 mdio-bus-y			+= mdio_bus.o mdio_device.o
 
 ifdef CONFIG_PHYLIB
diff --git a/drivers/net/phy/phy_common_fixups.c b/drivers/net/phy/phy_common_fixups.c
new file mode 100644
index 000000000000..fa51c6d7b25f
--- /dev/null
+++ b/drivers/net/phy/phy_common_fixups.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/phy.h>
+
+#include "phylib-internal.h"
+
+/**
+ * phy_register_address_0_fixups - Register fixups for disabling MDIO
+ * broadcast address 0
+ *
+ * Some vendors interpret MDIO address 0 as a broadcast address and so their
+ * PHYs initially respond both at address 0 as well as at their normal
+ * address. This is problematic:
+ *  - Linux may create two struct phy_device for a single device.
+ *  - MDIO address collision may occur if there is another PHY
+ *    legitimately listening on address 0.
+ *
+ * The broadcast address can often be disabled through some internal
+ * PHY register. These fixups are designed to do just that --
+ * they shall stop these PHYs from responding at address 0 before
+ * the MDIO address 0 is scanned for devices.
+ */
+int phy_register_address_0_fixups(void)
+{
+	return 0;
+}
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index db187d370eaa..2d4f119b45b4 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3969,6 +3969,10 @@ static int __init phy_init(void)
 	if (rc)
 		goto err_ethtool_phy_ops;
 
+	rc = phy_register_address_0_fixups();
+	if (rc)
+		goto err_ethtool_phy_ops;
+
 	features_init();
 
 	rc = phy_driver_register(&genphy_c45_driver, THIS_MODULE);
diff --git a/drivers/net/phy/phylib-internal.h b/drivers/net/phy/phylib-internal.h
index dc9592c6bb8e..1e6ff8f2d721 100644
--- a/drivers/net/phy/phylib-internal.h
+++ b/drivers/net/phy/phylib-internal.h
@@ -22,4 +22,6 @@ void phy_check_downshift(struct phy_device *phydev);
 
 int genphy_c45_read_eee_adv(struct phy_device *phydev, unsigned long *adv);
 
+int phy_register_address_0_fixups(void);
+
 #endif /* __PHYLIB_INTERNAL_H */
-- 
2.43.0


