Return-Path: <netdev+bounces-192274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4426CABF338
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 13:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 610EB170D8E
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6122236431;
	Wed, 21 May 2025 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZMa14F6e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D53C1B4121
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747827948; cv=none; b=IGBQI/Mf9PTK+ClejNhkoXAZOl2566IVpnqdNwBb8SZIybqaR7IAvMXVhXi4/0t0ERStdXt3G4inY6cRaj6PWtYCwJi7uG+mtAaWw60r+/NsY4wYZLI1YOzFFOn+bA2VRwhxos1KJ1/PLmTU3U96+DTRAxh9JS9QQyaUCDqU+dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747827948; c=relaxed/simple;
	bh=+B0cm1z7+VBO1FW2h6d+w1Ym3K7ZfK1VSqRLl7SscVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hlxdesg1mXcWGZdvCgH5VqBA3/R/VLsZ9MIk4+oHQiuYx/AHhF34hhjRmC96MHQf2J4579RZHaAjFLhpLREh4Na49IUJl6lRVlO+kysj7HPaXX0hFLlyVRLC36s9mAADpKhTma/NwFopnDZYkNMrTD6H2qzKsHyZb12A+7OQGO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZMa14F6e; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747827948; x=1779363948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xSxX5/iP8F2HaLjmtH7cAftV6tUgFxuuS6OQ8yogM3g=;
  b=ZMa14F6efIGJnIQWjUpoA+rvgTzuXKljef7BNP09AYJlBVMx7Cl+Tgjr
   /UArBVfNIK26uWAskLGaZjIUOQVXiNgAa5BFHm7zPUtGScpNuBrowUOsb
   X/lksH5PTqCvkqTDS9YzaS9F2B7WrKb9uiHAc28T3jFlMSD+ETAJsPdV9
   PibQVVcvY9rgJC7a84HkATanjjW+Q6RRTuB8/vPiUfOq8i8UUSLoENZit
   E7pw+MmM1IDB5g1jnzZTNf2sRMPrYnqiHxTVad+xWtECaLmEuTj3TE5D1
   D5P2b9g0jYqEbGkP6we+Kw2f91sjxWGXe52w8m/OBihGklCAi67i3UIzI
   A==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; 
   d="scan'208";a="52368823"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 11:45:47 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:57843]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.22.206:2525] with esmtp (Farcaster)
 id 8a0e3cef-8aff-415c-882d-4893528bb9aa; Wed, 21 May 2025 11:45:45 +0000 (UTC)
X-Farcaster-Flow-ID: 8a0e3cef-8aff-415c-882d-4893528bb9aa
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 11:45:43 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.172) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 11:45:32 +0000
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
Subject: [PATCH v9 net-next 8/8] net: ena: Add a DEVLINK readme
Date: Wed, 21 May 2025 14:42:54 +0300
Message-ID: <20250521114254.369-9-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521114254.369-1-darinzon@amazon.com>
References: <20250521114254.369-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
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


