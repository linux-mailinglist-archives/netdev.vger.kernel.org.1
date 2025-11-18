Return-Path: <netdev+bounces-239460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDFFC68888
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DB754F1F6A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A318B326D51;
	Tue, 18 Nov 2025 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ZE+4OhO0"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95032311C2D
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457988; cv=none; b=hIjw6/JH7k8HLmbkFDD4rbKFqRK9fQQ3XqI5ctwrHJZogcA5HmIbHgoeDLDRnsLs9uEmJSpqSN7UAehNYjDctQ41hCklVvbNYZSzRKvK0vStoyQjFHinWdrAAoev6q57geaz8M7rreivbRWiUTy7R9YKKD5ymI1j0REcFPqC484=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457988; c=relaxed/simple;
	bh=NDpwKwRrG7wJiV6rTZ0qMo5St7tQ+ljo1Xik3KVnrBI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsAGmI7NVjaQE3Z/5lUam1ejNTkshUtq3DLrCKxtEEAI4BH3QQFN58MTuPQxGjq58R/Hxd6AQOTRwfJFcKr8p6xu8+jaA7Oq6Wj5UFawrYCqe7AqfaF7DuspKdSmEb4yEoMxeksa5wOxsTqfTujDv8MESeVyb0eIuYOdjrduS2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ZE+4OhO0; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id EB957207D1;
	Tue, 18 Nov 2025 10:26:23 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CWDzCOM4U1q4; Tue, 18 Nov 2025 10:26:23 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4F2CD2089F;
	Tue, 18 Nov 2025 10:26:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4F2CD2089F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1763457983;
	bh=CAg8Sd7366LWvhinpUbYtoANEKVXsnRP4kHW5TaU1so=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=ZE+4OhO04DGZIoNu1cqM+bBinXvKgbhXpI3R4AP5sp9Igdn/qYuKf78xM+mDRk3We
	 nzos4gesb2pVhQELCICgFH5ELQaSjlTtPsBTSZY7vyfe2kGam80DEXZIciH/vcLIug
	 r2d4WBGZxhMCNIxnvN9+CiT69G9FHTcZvumde0JoVsVYYWdKV7b4ehJl79rRW3x3mi
	 cn4LvG9JtZ1KhcUHfH84p+I+eKlKAVAvFle3xpzZ18Mq+vDnTvgaQvdYkDX6/SDp28
	 7KOjGJGpZTePtfePKQRu21ym+hGZXMVcICDbx3JAhdx9y6DYUVII3ylLDZtGR74PLZ
	 POE5DJJBfsYEg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 18 Nov
 2025 10:26:22 +0100
Received: (nullmailer pid 2223994 invoked by uid 1000);
	Tue, 18 Nov 2025 09:26:12 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 11/12] net: Move XFRM documentation into its own subdirectory
Date: Tue, 18 Nov 2025 10:25:48 +0100
Message-ID: <20251118092610.2223552-12-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118092610.2223552-1-steffen.klassert@secunet.com>
References: <20251118092610.2223552-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

From: Bagas Sanjaya <bagasdotme@gmail.com>

XFRM docs are currently reside in Documentation/networking directory,
yet these are distinctive as a group of their own. Move them into xfrm
subdirectory.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 Documentation/networking/index.rst                  |  5 +----
 Documentation/networking/xfrm/index.rst             | 13 +++++++++++++
 Documentation/networking/{ => xfrm}/xfrm_device.rst |  0
 Documentation/networking/{ => xfrm}/xfrm_proc.rst   |  0
 Documentation/networking/{ => xfrm}/xfrm_sync.rst   |  6 +++---
 Documentation/networking/{ => xfrm}/xfrm_sysctl.rst |  0
 6 files changed, 17 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/networking/xfrm/index.rst
 rename Documentation/networking/{ => xfrm}/xfrm_device.rst (100%)
 rename Documentation/networking/{ => xfrm}/xfrm_proc.rst (100%)
 rename Documentation/networking/{ => xfrm}/xfrm_sync.rst (99%)
 rename Documentation/networking/{ => xfrm}/xfrm_sysctl.rst (100%)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index c775cababc8c..75db2251649b 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -131,10 +131,7 @@ Contents:
    vxlan
    x25
    x25-iface
-   xfrm_device
-   xfrm_proc
-   xfrm_sync
-   xfrm_sysctl
+   xfrm/index
    xdp-rx-metadata
    xsk-tx-metadata
 
diff --git a/Documentation/networking/xfrm/index.rst b/Documentation/networking/xfrm/index.rst
new file mode 100644
index 000000000000..7d866da836fe
--- /dev/null
+++ b/Documentation/networking/xfrm/index.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+XFRM Framework
+==============
+
+.. toctree::
+   :maxdepth: 2
+
+   xfrm_device
+   xfrm_proc
+   xfrm_sync
+   xfrm_sysctl
diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm/xfrm_device.rst
similarity index 100%
rename from Documentation/networking/xfrm_device.rst
rename to Documentation/networking/xfrm/xfrm_device.rst
diff --git a/Documentation/networking/xfrm_proc.rst b/Documentation/networking/xfrm/xfrm_proc.rst
similarity index 100%
rename from Documentation/networking/xfrm_proc.rst
rename to Documentation/networking/xfrm/xfrm_proc.rst
diff --git a/Documentation/networking/xfrm_sync.rst b/Documentation/networking/xfrm/xfrm_sync.rst
similarity index 99%
rename from Documentation/networking/xfrm_sync.rst
rename to Documentation/networking/xfrm/xfrm_sync.rst
index 112f7c102ad0..dfc2ec0df380 100644
--- a/Documentation/networking/xfrm_sync.rst
+++ b/Documentation/networking/xfrm/xfrm_sync.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-====
-XFRM
-====
+=========
+XFRM sync
+=========
 
 The sync patches work is based on initial patches from
 Krisztian <hidden@balabit.hu> and others and additional patches
diff --git a/Documentation/networking/xfrm_sysctl.rst b/Documentation/networking/xfrm/xfrm_sysctl.rst
similarity index 100%
rename from Documentation/networking/xfrm_sysctl.rst
rename to Documentation/networking/xfrm/xfrm_sysctl.rst
-- 
2.43.0


