Return-Path: <netdev+bounces-74893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A77E867336
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 12:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C721F25294
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 11:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E311DA3F;
	Mon, 26 Feb 2024 11:34:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7213E493
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947255; cv=none; b=b9aZKMTqswBzKWYb3ALL8bjxSYEn1Cv2uO0EL7R0S/+QxHtjFYVBPqtKdZO5xmDz4sOKJyY0kntgaIUJ4qAbWB3NM6UKkOgpOgDDbiunfEuoRibOKf2swMx5YijSkXfm1QFhJsNh7FAhKtX5yjW106fWIR5+6qQ7wZHM+Up0Oyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947255; c=relaxed/simple;
	bh=Qom1sOW1x6FH+wyLyTtS2FzE5P6I90UBvT5m1DOm+wo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dJ6LKEPdGQ9QNNOkAMRxiPFN+dujarVGn3zOKGZfIdCShgJQnjNGRpB/ESwgA8SAtsfoFMhiaLgces6u0xVyqnoQcD4w4Q8v2DNi1t+N/0v25MKyB7tb09aobPocURbrU3FKccj47P+0WCJSTi2ERYF4ies+Ztba8P2Pfa+S/hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:7662:e968:947d:f3d0])
	by michel.telenet-ops.be with bizsmtp
	id rna42B0025Kh3Z506na4Cm; Mon, 26 Feb 2024 12:34:06 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1reZF4-001laX-E8;
	Mon, 26 Feb 2024 12:34:04 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1reZFD-004PAR-Tq;
	Mon, 26 Feb 2024 12:34:03 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Randy Dunlap <rdunlap@infradead.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH net] ethernet: adi: Move select PHYLIB from NET_VENDOR_ADI to ADIN1110
Date: Mon, 26 Feb 2024 12:34:02 +0100
Message-Id: <99d4d711acfc020c8987e96145f2f1f323cbaa3b.1708947112.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NET_VENDOR_* Kconfig options are used as gatekeepers.  Merely
enabling such an option must not enable any other extra code.

Fixes: a9f80df4f5144030 ("net: ethernet: adi: requires PHYLIB support")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/net/ethernet/adi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/adi/Kconfig b/drivers/net/ethernet/adi/Kconfig
index c91b4dcef4ec2f5f..760a9a60bc15c184 100644
--- a/drivers/net/ethernet/adi/Kconfig
+++ b/drivers/net/ethernet/adi/Kconfig
@@ -7,7 +7,6 @@ config NET_VENDOR_ADI
 	bool "Analog Devices devices"
 	default y
 	depends on SPI
-	select PHYLIB
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 
@@ -22,6 +21,7 @@ config ADIN1110
 	tristate "Analog Devices ADIN1110 MAC-PHY"
 	depends on SPI && NET_SWITCHDEV
 	select CRC8
+	select PHYLIB
 	help
 	  Say yes here to build support for Analog Devices ADIN1110
 	  Low Power 10BASE-T1L Ethernet MAC-PHY.
-- 
2.34.1


