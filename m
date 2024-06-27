Return-Path: <netdev+bounces-107088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823DB919BDE
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 02:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70D91C21A8C
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 00:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7CE2139BC;
	Thu, 27 Jun 2024 00:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhayioMV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019E85223;
	Thu, 27 Jun 2024 00:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719448920; cv=none; b=C6pEIGgFPtbVKiJ1yWvk9W6d4DpPeuslmn7nxQ4B+aiZx1+DBSmssEfVpC0JPnnxGI8nQqQvoL8/qjd6kgr7h/CH5YJxnc8UUzr2I5wws84wG6Fw/3Ff5enYJ5BsETuECidH9mQaT8bqWkoGmgzssjC/u/uVqtNCm1hHd7sl/vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719448920; c=relaxed/simple;
	bh=HKd+U5CDCJq1sAkohvaBdQJfgDvEMWTiR6NKfKP+qm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kq+/L7/M/k2wZJaKbeELZ/NwJyV5GPynRrHRDkcvIYNxjIXGue3verN3MkUQHUY6kGBdv6XVh5G5rLkspEev3IPaBp1GMoHdPCVvdS1EbDMPKuYBistm9MUpePEtafbycV7FC3UXrePHvXNKKEoUVxLBiWjtU87/vXoOu3xMqKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhayioMV; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ce9ba0cedso5078310e87.2;
        Wed, 26 Jun 2024 17:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719448917; x=1720053717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riZO9gpWg+72DwRvoZciAprxyAK6Sq4iImVOkfuj2k8=;
        b=NhayioMVp971nXJlU92dP6rTex0rYJnUQUQBKfKRI6juuI7bTQ0EWfedim41v9clmi
         TBEomK8/qwEGORmphuz1AedLBX8xDYDCCk6iQItbxWCRbONYsdp3jhdXw4y8ZXdwsT+T
         aNGMlmur3IFEIt9EsUOK00pqQZIKs0R0HHvVmmU7N3fwDxZCBK1PQfsZGtJBCDS+24sI
         s5dKoD980oJrKdW27T7tZXVybugFHt99rV4Lx5bV+uesKXhDVXUmrhEXTgQN5orC+vRI
         vW4yhcaRlGS1bF0qaZFU21SoP+GMubUnLASe/dDaoMYOyuAcrSmCZNSdoueRh0IBUTPY
         WDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719448917; x=1720053717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riZO9gpWg+72DwRvoZciAprxyAK6Sq4iImVOkfuj2k8=;
        b=pyqmwa2nmdtDC70GwT4647aFL9i34x+8rlnuNQJqm0BZvIp7RVZBJLPziqxxoS1nj0
         JHAMzX42tTJYCiF+H8lU6fYSoKhdAhwMpRU7wMImdmvb+4FZiJix88XMLGmRjzs6QO56
         wmWbPg39oe1X6nyDIrKUoL7hiVCClnkKYF6G/kX6vamYVAHPLbTa/zAcbCpMw2N2L/zI
         z8q9FJj9JYBi5fmXNhODtutvL/sAfhxh1dbYbEtYTEbhztMqWupqX0hLgVi91Fl8rJaD
         bYh6mE3bH/I0KhHiw4MYK3sJkBb/APzP7MgKoZ3fQE/7O8qaZvMrdFRFAy7aP2WHUCNq
         yAPA==
X-Forwarded-Encrypted: i=1; AJvYcCUPdm138sTiPqRunBHktRZZDUROxM9tNt/Ey7Zu2QNtcz2QJJY7gPgX0NlyRMYWnOpwU0aeuz0K000Un4KYRV0U+B57XLTuNvtdo8ExZ+/X+ExN8rUU03wzY6RPYGuHE98DivzRgtfNXMJE74+8/qyXVr1zCeCHZLsltbFuRqguLw==
X-Gm-Message-State: AOJu0Yy6re1QGi3rnUMAheHPfnYVoS3My3YJDOI3O943f/2VavxWOfTr
	eUbP1xL8tyk88Pune6OkctK9INHc/0mzzy4g3w/uWryTuIQ7GPXh
X-Google-Smtp-Source: AGHT+IG9xWPw91sL+7geI8Yw5mhFbwzbfnCv10lu3eKdnkF87T5urspemd32cPB+C/RlkO+fzeL6Bw==
X-Received: by 2002:a05:6512:39ca:b0:521:cc8a:46dd with SMTP id 2adb3069b0e04-52ce182bcd5mr11611361e87.11.1719448915879;
        Wed, 26 Jun 2024 17:41:55 -0700 (PDT)
Received: from localhost ([89.113.147.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e712a7ba7sm20161e87.56.2024.06.26.17.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 17:41:55 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 01/10] net: pcs: xpcs: Move native device ID macro to linux/pcs/pcs-xpcs.h
Date: Thu, 27 Jun 2024 03:41:21 +0300
Message-ID: <20240627004142.8106-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627004142.8106-1-fancer.lancer@gmail.com>
References: <20240627004142.8106-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of the next commits will alter the DW XPCS driver to support setting a
custom device ID for the particular MDIO-device detected on the platform.
The generic DW XPCS ID can be used as a custom ID as well in case if the
DW XPCS-device was erroneously synthesized with no or some undefined ID.
In addition to that having all supported DW XPCS device IDs defined in a
single place will improve the code maintainability and readability.

Note while at it rename the macros to being shorter and looking alike to
the already defined NXP XPCS ID macro.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- Alter the commit log so one would refer to the DW XPCS driver change and
  would describe the change clearer. (@Russell)
- s/sinle/single (@Vladimir)
---
 drivers/net/pcs/pcs-xpcs.c   | 8 ++++----
 drivers/net/pcs/pcs-xpcs.h   | 3 ---
 include/linux/pcs/pcs-xpcs.h | 2 ++
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 31525fe9c32e..99adbf15ab36 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1343,16 +1343,16 @@ static const struct xpcs_compat nxp_sja1110_xpcs_compat[DW_XPCS_INTERFACE_MAX] =
 
 static const struct xpcs_id xpcs_id_list[] = {
 	{
-		.id = SYNOPSYS_XPCS_ID,
-		.mask = SYNOPSYS_XPCS_MASK,
+		.id = DW_XPCS_ID,
+		.mask = DW_XPCS_ID_MASK,
 		.compat = synopsys_xpcs_compat,
 	}, {
 		.id = NXP_SJA1105_XPCS_ID,
-		.mask = SYNOPSYS_XPCS_MASK,
+		.mask = DW_XPCS_ID_MASK,
 		.compat = nxp_sja1105_xpcs_compat,
 	}, {
 		.id = NXP_SJA1110_XPCS_ID,
-		.mask = SYNOPSYS_XPCS_MASK,
+		.mask = DW_XPCS_ID_MASK,
 		.compat = nxp_sja1110_xpcs_compat,
 	},
 };
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 96c36b32ca99..369e9196f45a 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -6,9 +6,6 @@
  * Author: Jose Abreu <Jose.Abreu@synopsys.com>
  */
 
-#define SYNOPSYS_XPCS_ID		0x7996ced0
-#define SYNOPSYS_XPCS_MASK		0xffffffff
-
 /* Vendor regs access */
 #define DW_VENDOR			BIT(15)
 
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index da3a6c30f6d2..8dfe90295f12 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -12,6 +12,8 @@
 
 #define NXP_SJA1105_XPCS_ID		0x00000010
 #define NXP_SJA1110_XPCS_ID		0x00000020
+#define DW_XPCS_ID			0x7996ced0
+#define DW_XPCS_ID_MASK			0xffffffff
 
 /* AN mode */
 #define DW_AN_C73			1
-- 
2.43.0


