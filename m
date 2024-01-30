Return-Path: <netdev+bounces-67079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE96D84203B
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 10:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B445282929
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 09:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF655A796;
	Tue, 30 Jan 2024 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cUkUYOqx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7158605C1
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608449; cv=none; b=QI842MUtk47oAsgCGktEvm2bSl4YVssMUrpyp/FWhRZAGwBy1KpbHA3Tn7Zf20Ph1Dn2KZYNla4SnlCpb5A05ZWuaYCbJZcLdKuDqJK0gf09QoyiOw1UnVioSJKiNc89aJeIHL9L+kJLNa24jcKKyY0/xzgXG0wNFzn0P6zLZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608449; c=relaxed/simple;
	bh=hwI2ZWZgkvGzaexE4fkvvbrOXWE0vAXefsNH/QUwntY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohD0p/TN/2AjAOsaTgPbKag7y6+9VKmxtcSHro183kf+2YAJUP1RWZiQALf/dSxEGt/6AyxgCOCKHg5/79zY9yISeGQCePAYxiI4eOgmZHV2YEo6RqJL7dJ/UlJIQbT+Eu5UET0Ax41Uht7k7y6M8mUL2giBJitXR/IDyFL1I20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cUkUYOqx; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706608448; x=1738144448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JJoBmlH0AvhnSW7vfN9FLg9+HheVqQYYl6lYm9zQ6Kg=;
  b=cUkUYOqxSObm1d6B7Vygam80RHfz3yOCOVZPep7gIjRf42yQUzYAVN7k
   NhSlSNkM0m4/6iMoom+LYl2E3wDo3fm4FctnHikm8snojVK5eabFLwuSR
   kRHkCy2YWgwAjJ0MkBd69BdXzPV1tCOv4vtYLe3jjUKEf/mYtB2QX/SdG
   s=;
X-IronPort-AV: E=Sophos;i="6.05,707,1701129600"; 
   d="scan'208";a="393461609"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 09:54:02 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com (Postfix) with ESMTPS id DBC0A40AD4;
	Tue, 30 Jan 2024 09:54:01 +0000 (UTC)
Received: from EX19MTAUEC001.ant.amazon.com [10.0.0.204:37548]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.32.35:2525] with esmtp (Farcaster)
 id d88157b0-33f2-4483-bd90-fd91ed87e422; Tue, 30 Jan 2024 09:54:01 +0000 (UTC)
X-Farcaster-Flow-ID: d88157b0-33f2-4483-bd90-fd91ed87e422
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:54:00 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 30 Jan 2024 09:54:00 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Tue, 30 Jan 2024 09:53:58
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
Subject: [PATCH v2 net-next 01/11] net: ena: Remove an unused field
Date: Tue, 30 Jan 2024 09:53:43 +0000
Message-ID: <20240130095353.2881-2-darinzon@amazon.com>
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

Remove io_sq->header_addr field because it is no longer
in use.
LLQ was updated to support a bounce buffer so there is
no need in saving the header address of the sq.

Signed-off-by: Nati Koler <nkoler@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 3 ---
 drivers/net/ethernet/amazon/ena/ena_com.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 633b321..9a8a43b 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -1284,9 +1284,6 @@ static int ena_com_create_io_sq(struct ena_com_dev *ena_dev,
 		(uintptr_t)cmd_completion.sq_doorbell_offset);
 
 	if (io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_DEV) {
-		io_sq->header_addr = (u8 __iomem *)((uintptr_t)ena_dev->mem_bar
-				+ cmd_completion.llq_headers_offset);
-
 		io_sq->desc_addr.pbuf_dev_addr =
 			(u8 __iomem *)((uintptr_t)ena_dev->mem_bar +
 			cmd_completion.llq_descriptors_offset);
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.h b/drivers/net/ethernet/amazon/ena/ena_com.h
index 3c5081d..f3176fc 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_com.h
@@ -158,7 +158,6 @@ struct ena_com_io_sq {
 	struct ena_com_io_desc_addr desc_addr;
 
 	u32 __iomem *db_addr;
-	u8 __iomem *header_addr;
 
 	enum queue_direction direction;
 	enum ena_admin_placement_policy_type mem_queue_type;
-- 
2.40.1


