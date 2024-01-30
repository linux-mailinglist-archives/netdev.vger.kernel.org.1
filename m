Return-Path: <netdev+bounces-67080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EBF84203C
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 10:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3889F282C67
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31BA679F7;
	Tue, 30 Jan 2024 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iHQEOhVP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7FC66B3D
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608449; cv=none; b=rsKDga1QRkHlhfPIYLgirAKTZV7U121bSU2F8lgDR1Zcuash4xVpybb/XMcGx+D5asmENTN4iu4MndurGD+lSjAEKvDJ0TW22cHgCGed4qcfaI8YjfZU2jkpZgrSudCLPxzi7uL55R/bjADm5q8ASKe1GDBFGLo/pYl0ksP5wH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608449; c=relaxed/simple;
	bh=7Xwfv8f5n/0roylanI2AVhmecF4+uBhkRLmVXINAn2I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ffhQNpHv77OPohSzOUKrd6TPS61hOkXvhcEDtveUAVV9ZcKsW1BRanMJX/XxvqQbuxGH+9hlBPqCMdcy2fAZcd5/+B+2LoCIwnGkvaBctl7xX4TtSeMQoKNya71cD0o0brD07fS29eEuis8gvTT8vY+BcjXsoM+OjyZJGX9Lq0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iHQEOhVP; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706608448; x=1738144448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xJQrjmv5kbwgbrIGiSJEihUFrFIZVx3WNc1vVpc4CYA=;
  b=iHQEOhVPNfKFaImFPp80svlZPX80xqhAQAaqves5czMcV+5ifMb7LX4v
   jx4MONdm53FnGLhHxrploxV6WdrUq+em3GIMhPRrhJYPELIwjaFYqL0TO
   /v5RMVhQteLGQzRgkrqb1HusmL8jb1z36oI3clPje4t09FH/o5PDuYOxT
   w=;
X-IronPort-AV: E=Sophos;i="6.05,707,1701129600"; 
   d="scan'208";a="634450311"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:54:05 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id 476954B0F3;
	Tue, 30 Jan 2024 09:54:05 +0000 (UTC)
Received: from EX19MTAUEC001.ant.amazon.com [10.0.0.204:19843]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.14.32:2525] with esmtp (Farcaster)
 id cd8a33d1-8d13-4e78-bb20-57eedcc8f9ea; Tue, 30 Jan 2024 09:54:04 +0000 (UTC)
X-Farcaster-Flow-ID: cd8a33d1-8d13-4e78-bb20-57eedcc8f9ea
Received: from EX19D008UEA002.ant.amazon.com (10.252.134.125) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:54:03 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA002.ant.amazon.com (10.252.134.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:54:03 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Tue, 30 Jan 2024 09:54:01
 +0000
From: <darinzon@amazon.com>
To: "Nelson, Shannon" <shannon.nelson@amd.com>, David Miller
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
	<alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky, Evgeny"
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, "Koler, Nati"
	<nkoler@amazon.com>
Subject: [PATCH v2 net-next 02/11] net: ena: Add more documentation for RX copybreak
Date: Tue, 30 Jan 2024 09:53:44 +0000
Message-ID: <20240130095353.2881-3-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240130095353.2881-1-darinzon@amazon.com>
References: <20240130095353.2881-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: Bulk

From: David Arinzon <darinzon@amazon.com>

This patch contains more details about the functionality
of RX copybreak.

Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 .../networking/device_drivers/ethernet/amazon/ena.rst       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
index b842bcb..a4c7d0c 100644
--- a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
+++ b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
@@ -211,10 +211,16 @@ Documentation/networking/net_dim.rst
 
 RX copybreak
 ============
+
 The rx_copybreak is initialized by default to ENA_DEFAULT_RX_COPYBREAK
 and can be configured by the ETHTOOL_STUNABLE command of the
 SIOCETHTOOL ioctl.
 
+This option controls the maximum packet length for which the RX
+descriptor it was received on would be recycled. When a packet smaller
+than RX copybreak bytes is received, it is copied into a new memory
+buffer and the RX descriptor is returned to HW.
+
 Statistics
 ==========
 
-- 
2.40.1


