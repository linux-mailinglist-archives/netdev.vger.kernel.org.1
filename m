Return-Path: <netdev+bounces-66630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2BC8400A7
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 09:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7801728264F
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 08:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7D854BCF;
	Mon, 29 Jan 2024 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Vl3CtWJL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4870954BCB
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518547; cv=none; b=r6tGgwCISyQhoa3RHQ9Gt5GkiwaOOo4i86FmecU7xTg4JSz2k+HXdZn/Eo1CgWTP+NCFBTxGA310vdE8swvqBKsYdBpOireCDN0+OmQyVwTmApvvgc2apAnUNfYqLunGNk5U7qSe+AggBdm4E+0zi5BG/2E9YawtACrNadV/zBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518547; c=relaxed/simple;
	bh=hwI2ZWZgkvGzaexE4fkvvbrOXWE0vAXefsNH/QUwntY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKJhUo7wfKlk2dj70ViOmpUqn6WwMUEe1TmweV587o5S5NKMm1nLek0FiNMCeAPcjohMjBcjuszsowShN2cbciA+kSMpgU7HAyywMxwLa7LP0xtDmf0N3SNSFzLV96Cv+HqfcKr3zVgFOHrHx/ILqJxnKzt36olTO1f2P41sJTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Vl3CtWJL; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706518547; x=1738054547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JJoBmlH0AvhnSW7vfN9FLg9+HheVqQYYl6lYm9zQ6Kg=;
  b=Vl3CtWJLXo+UaEVOeBWbE69iIHr5QSNahDheGXpkkCj5oz/4P5UOHban
   bSGi1s8kqZpylGfTemBfToa42G5aU5cxQXFNDnLBAMPS89VtnzVO4gBkO
   t16MvPJ/z4L7/psxeHbKtHPoPSjyCZ4YHGOod8+fyIIFk8lQHywAhvzdj
   A=;
X-IronPort-AV: E=Sophos;i="6.05,226,1701129600"; 
   d="scan'208";a="269341885"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 08:55:45 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-26a610d2.us-west-2.amazon.com (Postfix) with ESMTPS id C1E2D40A69;
	Mon, 29 Jan 2024 08:55:43 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:35086]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.136:2525] with esmtp (Farcaster)
 id b817aa89-0416-4e0c-a1df-b5e757af53b5; Mon, 29 Jan 2024 08:55:43 +0000 (UTC)
X-Farcaster-Flow-ID: b817aa89-0416-4e0c-a1df-b5e757af53b5
Received: from EX19D010UWB003.ant.amazon.com (10.13.138.81) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:55:43 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D010UWB003.ant.amazon.com (10.13.138.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 08:55:42 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 08:55:39
 +0000
From: <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
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
	<nkolder@amazon.com>, Nati Koler <nkoler@amazon.com>
Subject: [PATCH v1 net-next 01/11] net: ena: Remove an unused field
Date: Mon, 29 Jan 2024 08:55:21 +0000
Message-ID: <20240129085531.15608-2-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240129085531.15608-1-darinzon@amazon.com>
References: <20240129085531.15608-1-darinzon@amazon.com>
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


