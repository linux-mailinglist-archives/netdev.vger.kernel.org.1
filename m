Return-Path: <netdev+bounces-93810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 930BC8BD41F
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 19:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9051F223DA
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 17:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712161581FD;
	Mon,  6 May 2024 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UzMle71a"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2618157E7A;
	Mon,  6 May 2024 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017853; cv=none; b=fmR8z2Jub+W4/nOf4TpBa7VlnEBqFFsFKu2oVHnScQRZZo+ArvOKskV8U97WAwP6AwnqeZ2YX0AFk5qM8nWoe3GUsA+eMWuPVfQJmwlLjVNs160dqbUTenOseEe0yvNFCOGbYVR6VhJANC3v1dlO7+2iRwiwEATwD5SPOKwaokI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017853; c=relaxed/simple;
	bh=v6pEqBJ5mDe9Geb1lnQ6KB6h8NCGbjd9XTgNlYMumZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c6Dd3/35lLOoKNfBixFpR99tE+fM2opdPrp34LuZTuz43rjoFftjoEkTEmcU8FGB2DCD8Ydx7SGjpLq4gQxNwC08JjhQEfvO83ZtCS9Ur6rztmeiknogaoZrCVPiQ/bxnBsCbD1rJ1pWzkUoXW4fV8QSMxEL0WrDZHxjSHRxdyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UzMle71a; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B460DC0000F1;
	Mon,  6 May 2024 10:50:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B460DC0000F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1715017844;
	bh=v6pEqBJ5mDe9Geb1lnQ6KB6h8NCGbjd9XTgNlYMumZA=;
	h=From:To:Cc:Subject:Date:From;
	b=UzMle71aRbs+gStauk6DVeYL6Te6an9ndMV4wnUqU8LlLEvtK38go+/N0lkkhR5KN
	 kC6DC0iTQaAV3o8R15wfrO0CxMgwW7FWgkK3zrJtbt/XWrQ9N3CzccQvboq4Evo/IH
	 Rv9141/2/8nZBOFfHbjgCFcgTLlj9Ct3UVKTDWTE=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id B530718041CAC4;
	Mon,  6 May 2024 10:50:42 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	jgg@nvidia.com,
	leonro@nvidia.com,
	horms@kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tal Gilboa <talgi@nvidia.com>,
	linux-kernel@vger.kernel.org (open list:LIBRARY CODE)
Subject: [PATCH net-next v2] lib: Allow for the DIM library to be modular
Date: Mon,  6 May 2024 10:50:40 -0700
Message-Id: <20240506175040.410446-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the Dynamic Interrupt Moderation (DIM) library to be built as a
module. This is particularly useful in an Android GKI (Google Kernel
Image) configuration where everything is built as a module, including
Ethernet controller drivers. Having to build DIMLIB into the kernel
image with potentially no user is wasteful.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
Changes in v2:

- Added MODULE_DESCRIPTION()

 lib/Kconfig      | 2 +-
 lib/dim/Makefile | 4 ++--
 lib/dim/dim.c    | 3 +++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 4557bb8a5256..d33a268bc256 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -628,7 +628,7 @@ config SIGNATURE
 	  Implementation is done using GnuPG MPI library
 
 config DIMLIB
-	bool
+	tristate
 	help
 	  Dynamic Interrupt Moderation library.
 	  Implements an algorithm for dynamically changing CQ moderation values
diff --git a/lib/dim/Makefile b/lib/dim/Makefile
index 1d6858a108cb..c4cc4026c451 100644
--- a/lib/dim/Makefile
+++ b/lib/dim/Makefile
@@ -2,6 +2,6 @@
 # DIM Dynamic Interrupt Moderation library
 #
 
-obj-$(CONFIG_DIMLIB) += dim.o
+obj-$(CONFIG_DIMLIB) += dimlib.o
 
-dim-y := dim.o net_dim.o rdma_dim.o
+dimlib-objs := dim.o net_dim.o rdma_dim.o
diff --git a/lib/dim/dim.c b/lib/dim/dim.c
index e89aaf07bde5..83b65ac74d73 100644
--- a/lib/dim/dim.c
+++ b/lib/dim/dim.c
@@ -82,3 +82,6 @@ bool dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
 	return true;
 }
 EXPORT_SYMBOL(dim_calc_stats);
+
+MODULE_DESCRIPTION("Dynamic Interrupt Moderation (DIM) library");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.34.1


