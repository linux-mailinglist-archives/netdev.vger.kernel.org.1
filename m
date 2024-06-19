Return-Path: <netdev+bounces-104866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC8290EB6B
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B0D1F2444F
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80298142E7C;
	Wed, 19 Jun 2024 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="Gh0OwPJM"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24973FC1F;
	Wed, 19 Jun 2024 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801329; cv=none; b=UyridsYFogE+NW7xRxoLLyGvowMN/MHeNs1ezpN6luUpOFcOgj+FyYkvVhvsHvjzvfgpMu3gwUTyR1iEzduZiAGnCzNpF353ceQIIAJdrkbbcsEVIdjkl+J2RLq30cAb5b69Jhg9BCsUe+UOPcBx2fu1r5ZZo2M3Cor+oqy+OnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801329; c=relaxed/simple;
	bh=ovpb/tpNJbAa81KRkPrAKIb9Ld9ugP9wa01kYPaOrGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRO0Lxzk5qp7M00SgFQEkLVkO7wAwfcwJLcyzutax2l281u1MxPKyNsBFr0hiCtajVL1AG9LawlXQBXo3EHTzM9m56Y4kpCYHD6LJrnyktTQXxWqJT8zHA16yVBZCK/i08qFxymdxSlQAaRwg8hd7LNL5DhLtkwRnvMHJ+PzhU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=Gh0OwPJM; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 79126A0A2C;
	Wed, 19 Jun 2024 14:48:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=Wt13p/w7csHf7ALJ1ZJU
	ngCivWwVWkS3QaMhdYijnps=; b=Gh0OwPJMsl6lZQdD17NcXhxqKIJWMf2unh/Z
	tG226dRXNfgHTCVBxvNglBKsTbWe4Fw/zHfL2yuCkJPnhFSbH3jh+iEIUinnvpVb
	MidjDfajqI6vt1UgIorJjEavhj1bHgAfz5B80qh5PGN9lcecfxaJ0XUaUtbk/7EE
	wQ891tsmTV2y9E0O3LekeGeY1s1UuwlwUdCxW2DA5f6qZ0VcR6dE3f8nA1bZJWGs
	DunKJ119fwDg2C2if5GDr+Sk3YBo60oLQJipOAq7ekpIMsxx0DYVfq4O+4IZqhEq
	v/hy3GDg/O5dckC9rDpDAgAlVlAnRGn3jtvbudEQ5cHQ/aTTxtI/Q0Rr/ngeSY3j
	OSwjl2ULTnyN3u7D2JhV4tzoxzPNkJLQDLFMV30IKSnJ3V3oJrNZY4pO3zSoXoSK
	DqCiDn7oeBWJLEWMv63UnxZhASgQVPSBzGop8Tv+vajunyfsIlk/r8vJg2P5lSfB
	MXbIWWEP6FiIlLOYeI6Q7iw3GXfSNCJJQf+urn2AQjGo1YLaW1b/W1PN0TeVKTwA
	HGPYz0uMa56zq5mHvsStV/qZzU0kLZK1ifQxqZi8q9+OsqYAEfaDUMmzuNVu+5ZG
	CV2fHPTGapp4ZEo6KB9B73ZHwxjOJbdejhVrklPPT3TjESBVdj2tbIXGHqR+O9uY
	H6Ci27A=
From: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	"Vladimir Oltean" <olteanv@gmail.com>, <trivial@kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>
Subject: [PATCH v2 resub 2/2] net: include: mii: Refactor: Use bit ops for ADVERTISE_* bits
Date: Wed, 19 Jun 2024 14:46:24 +0200
Message-ID: <20240619124622.2798613-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619124622.2798613-1-csokas.bence@prolan.hu>
References: <20240619124622.2798613-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1718801324;VERSION=7972;MC=3127536313;ID=564844;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2945A129576D7D61

Replace hex values with bit shift and __GENMASK() for readability

Cc: trivial@kernel.org

Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
---

Notes:
    Changes since v2:
    * Replace BIT() with bit shift, as the macro is not exported to userspace
    * Use __GENMASK(), exported into userspace in 3c7a8e190bc5
    
    (yesterday I accidentally sent v1 again, this is the correct v2)

 include/uapi/linux/mii.h | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/mii.h b/include/uapi/linux/mii.h
index 33e1b0c717e4..3fbc113a0f70 100644
--- a/include/uapi/linux/mii.h
+++ b/include/uapi/linux/mii.h
@@ -9,6 +9,7 @@
 #ifndef _UAPI__LINUX_MII_H__
 #define _UAPI__LINUX_MII_H__
 
+#include <linux/bits.h>
 #include <linux/types.h>
 #include <linux/ethtool.h>
 
@@ -69,23 +70,23 @@
 #define BMSR_100BASE4		0x8000	/* Can do 100mbps, 4k packets  */
 
 /* Advertisement control register. */
-#define ADVERTISE_SLCT		0x001f	/* Selector bits               */
-#define ADVERTISE_CSMA		0x0001	/* Only selector supported     */
-#define ADVERTISE_10HALF	0x0020	/* Try for 10mbps half-duplex  */
-#define ADVERTISE_1000XFULL	0x0020	/* Try for 1000BASE-X full-duplex */
-#define ADVERTISE_10FULL	0x0040	/* Try for 10mbps full-duplex  */
-#define ADVERTISE_1000XHALF	0x0040	/* Try for 1000BASE-X half-duplex */
-#define ADVERTISE_100HALF	0x0080	/* Try for 100mbps half-duplex */
-#define ADVERTISE_1000XPAUSE	0x0080	/* Try for 1000BASE-X pause    */
-#define ADVERTISE_100FULL	0x0100	/* Try for 100mbps full-duplex */
-#define ADVERTISE_1000XPSE_ASYM	0x0100	/* Try for 1000BASE-X asym pause */
-#define ADVERTISE_100BASE4	0x0200	/* Try for 100mbps 4k packets  */
-#define ADVERTISE_PAUSE_CAP	0x0400	/* Try for pause               */
-#define ADVERTISE_PAUSE_ASYM	0x0800	/* Try for asymetric pause     */
-#define ADVERTISE_RESV		0x1000	/* Unused...                   */
-#define ADVERTISE_RFAULT	0x2000	/* Say we can detect faults    */
-#define ADVERTISE_LPACK		0x4000	/* Ack link partners response  */
-#define ADVERTISE_NPAGE		0x8000	/* Next page bit               */
+#define ADVERTISE_SLCT		__GENMASK(4, 0)	/* Selector bits               */
+#define ADVERTISE_CSMA		(1 << 0)	/* Only selector supported     */
+#define ADVERTISE_10HALF	(1 << 5)	/* Try for 10mbps half-duplex  */
+#define ADVERTISE_1000XFULL	(1 << 5)	/* Try for 1000BASE-X full-duplex */
+#define ADVERTISE_10FULL	(1 << 6)	/* Try for 10mbps full-duplex  */
+#define ADVERTISE_1000XHALF	(1 << 6)	/* Try for 1000BASE-X half-duplex */
+#define ADVERTISE_100HALF	(1 << 7)	/* Try for 100mbps half-duplex */
+#define ADVERTISE_1000XPAUSE	(1 << 7)	/* Try for 1000BASE-X pause    */
+#define ADVERTISE_100FULL	(1 << 8)	/* Try for 100mbps full-duplex */
+#define ADVERTISE_1000XPSE_ASYM	(1 << 8)	/* Try for 1000BASE-X asym pause */
+#define ADVERTISE_100BASE4	(1 << 9)	/* Try for 100mbps 4k packets  */
+#define ADVERTISE_PAUSE_CAP	(1 << 10)	/* Try for pause               */
+#define ADVERTISE_PAUSE_ASYM	(1 << 11)	/* Try for asymmetric pause     */
+#define ADVERTISE_RESV		(1 << 12)	/* Unused...                   */
+#define ADVERTISE_RFAULT	(1 << 13)	/* Say we can detect faults    */
+#define ADVERTISE_LPACK		(1 << 14)	/* Ack link partners response  */
+#define ADVERTISE_NPAGE		(1 << 15)	/* Next page bit               */
 
 #define ADVERTISE_FULL		(ADVERTISE_100FULL | ADVERTISE_10FULL | \
 				  ADVERTISE_CSMA)
-- 
2.34.1



