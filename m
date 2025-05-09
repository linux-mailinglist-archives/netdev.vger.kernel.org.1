Return-Path: <netdev+bounces-189168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E92B0AB0E54
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 11:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA37F4C6FF7
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 09:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8265E277800;
	Fri,  9 May 2025 09:10:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEE7274FD6
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746781849; cv=none; b=JpGZtgCmMUz8G73RUcj1ctdJp1nvvNRTCjq10q6DtX7zCV1QOG5/+ACj54XJpwJQx8SWNsqPXXwov9Yu2q7gtN33lZn9aj15ekwe8Kavv/qLDXmMhIFtXWqJDYXPQ3AKUEBirGVJ8+4FGQGwsqbPUGcYgRBdiHM5dTTEDMwvzIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746781849; c=relaxed/simple;
	bh=Oam1hkxjn151krgrhKNG+6Wsw8wZVHoEK9W7HibzUa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g+Y8/gHGB1HXMuwLZF2EfqkfTeld7hSt4LTC3ijVrv8C++YwNLYdSk+cafu7gI6evvpIcD8OcgyCTbOuczjATEvRvbruaCGoKlJNfaAVX71f8ZgjT7aCkiTmpDcDjLlNqnNYMya1zqURTV4RRcvpbDVT0BMdj3eIMTQuV26d50E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c59736c7D829705d90AB67A755.dip0.t-ipconnect.de [IPv6:2003:c5:9736:c7d8:2970:5d90:ab67:a755])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id A4846FA373;
	Fri,  9 May 2025 11:10:45 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 4/5] batman-adv: Switch to crc32 header for crc32c
Date: Fri,  9 May 2025 11:10:40 +0200
Message-Id: <20250509091041.108416-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250509091041.108416-1-sw@simonwunderlich.de>
References: <20250509091041.108416-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The crc32c() function was moved in commit 8df36829045a ("lib/crc32:
standardize on crc32c() name for Castagnoli CRC32") from linux/crc32c.h to
linux/crc32.h. The former is just an include file which redirects to the
latter.

Avoid the indirection by directly including the correct header file.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c              | 2 +-
 net/batman-adv/translation-table.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index e41f816f0887..c0bc75513355 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -11,7 +11,7 @@
 #include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/container_of.h>
-#include <linux/crc32c.h>
+#include <linux/crc32.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/gfp.h>
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 4a3165920de1..8d0e04e770cb 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -14,7 +14,7 @@
 #include <linux/cache.h>
 #include <linux/compiler.h>
 #include <linux/container_of.h>
-#include <linux/crc32c.h>
+#include <linux/crc32.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
-- 
2.39.5


