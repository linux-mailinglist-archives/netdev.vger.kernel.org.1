Return-Path: <netdev+bounces-192693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E95C7AC0D4D
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E8B1BC558E
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B1F28C02D;
	Thu, 22 May 2025 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="igE8VsQw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB0D2882BC
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921897; cv=none; b=YCyPVfT8DXHaKsPnehmb1pP+89b54FL+cp3TNGQqN8rX/tviWzvavjUR2+BnqbIO/PozYWyQLSN0yt1V2yIzdVhqf+iOt1+tEEiuvRq3W1nB+fmYn/pgZDvXQv6DWEi7h8N5CLSj67axLKQFYBOlc3VesHoIKkm6bwSTvvBtb0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921897; c=relaxed/simple;
	bh=+B0cm1z7+VBO1FW2h6d+w1Ym3K7ZfK1VSqRLl7SscVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnKFG3YlqP/OwcQxycrnux6m2wWMHpYGFnQN3FaCjG8qo4VuIKh2CNAx4yKbCEUDYTY9NkgMyKOhNn6pN0E1dUIVa2PbrMueuz0WVRsm1Qfo0v2O5xKc0ztKnGlY5wiqN9WSMMcsX2nBIn6r0cbKIzMulH+CF8vR7UZAlXYAz54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=igE8VsQw; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747921896; x=1779457896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xSxX5/iP8F2HaLjmtH7cAftV6tUgFxuuS6OQ8yogM3g=;
  b=igE8VsQwlygMOHsZmpkM1SoxSzu1cQW6Z7WRHJ3zeQE7qPpNx1BS3qDF
   bWd6GhNtLAT4xlQpfCJz3DXnURLNqWRw4Ye208usZonNqPzglVv+VKW9Q
   +GlNcidJyOXROhtVI/OGqYGi0N+qi/MSXCRc9iEBEH+vqtKG2XDfCiODW
   v7rCSHnCVFSMbgnnnZ3a9ZB26i71QarTRZKW1qZzzMto33LZe/M0EwPuQ
   Q22pfAvWDtaBnEsf0HpkBgwp8BPUn0nwEe9Nd6toFctZ11+kmi+PUZ6WP
   3/j/OsJnYN2DuNz0qDoQbTL0XG30UpvGS2xCc17cPPM8juiP3dyeOz4Pp
   w==;
X-IronPort-AV: E=Sophos;i="6.15,306,1739836800"; 
   d="scan'208";a="96244654"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:51:35 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.10.100:60269]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.53:2525] with esmtp (Farcaster)
 id 592b4880-2df5-4890-826a-4ed5dcdc5c2f; Thu, 22 May 2025 13:51:33 +0000 (UTC)
X-Farcaster-Flow-ID: 592b4880-2df5-4890-826a-4ed5dcdc5c2f
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:51:33 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.172) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 22 May 2025 13:51:21 +0000
From: David Arinzon <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Richard
 Cochran" <richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Leon Romanovsky
	<leon@kernel.org>
Subject: [PATCH v10 net-next 8/8] net: ena: Add a DEVLINK readme
Date: Thu, 22 May 2025 16:48:39 +0300
Message-ID: <20250522134839.1336-9-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522134839.1336-1-darinzon@amazon.com>
References: <20250522134839.1336-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D005EUA002.ant.amazon.com (10.252.50.11)

Adding a standard devlink readme which outlines the parameters
that are supported by the ena driver.

Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 Documentation/networking/devlink/ena.rst   | 25 ++++++++++++++++++++++
 Documentation/networking/devlink/index.rst |  1 +
 2 files changed, 26 insertions(+)
 create mode 100644 Documentation/networking/devlink/ena.rst

diff --git a/Documentation/networking/devlink/ena.rst b/Documentation/networking/devlink/ena.rst
new file mode 100644
index 00000000..0c66aec2
--- /dev/null
+++ b/Documentation/networking/devlink/ena.rst
@@ -0,0 +1,25 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================
+ena devlink support
+===================
+
+This document describes the devlink features implemented by the ``ena``
+device driver.
+
+Parameters
+==========
+
+The ``ena`` driver implements the following driver-specific parameters.
+
+.. list-table:: Driver-specific parameters implemented
+   :widths: 5 5 5 85
+
+   * - Name
+     - Type
+     - Mode
+     - Description
+   * - ``phc_enable``
+     - Boolean
+     - driverinit
+     - Enables/disables the PHC feature
diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 8319f43b..53d00934 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -98,3 +98,4 @@ parameters, info versions, and other features it supports.
    iosm
    octeontx2
    sfc
+   ena
-- 
2.47.1


