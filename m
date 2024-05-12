Return-Path: <netdev+bounces-95783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B988C36C0
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 15:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F5B1F21ED2
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 13:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3210125634;
	Sun, 12 May 2024 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Mnf+9LSR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE82323749
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715521630; cv=none; b=tqq4KvisjukIQQehcokIRiX20iUkpa3gxueHJal71d8ruzYx6Rc+zu8v1ExrQhiLO2cux1JgHmsnL9E8wNI3TamoCGQPyfrnF3ZtNh4McKxQaUlYvxPcGTqTZhYLL5x+Aso+zU7cFZSEN1dt27os2ITlnEzA1W/XggrKZb6FC2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715521630; c=relaxed/simple;
	bh=v1SW2LD1kKZnEBcIlJ8oI3sqvyUjqR2fDIZIkhd7Xzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jf0bZ3GqV1xZG1XbGuDNR5l+FkxCC4wrXZOI5tFX4WJoPTmrixA5wSTqx2L6HAbsOFVw0ZiNavqtZL2ak+maPdkGDXYnd8xVj/TpSSGlhIcQG/b1odD3sFolrwCnuF+nEsAGxigbJPIzI2DEscK2/ewOh1N02Ee8uBYSxGzj1hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Mnf+9LSR; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715521628; x=1747057628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w+ZtxqWVAmNISxxyTCRftYBBDFRc+t3aZY2luzMzLXM=;
  b=Mnf+9LSRDFGyBgc6+bohgXL0aPw84F/Zwq0LqqePd7CDnMVGa5F5jgTQ
   qyRG1TVl0dppyVjsiTYYa2qNpECKFUS2iawIShyJtrUxyZ9MdURAaJ+oK
   EeFXD405KXEtD/1qOEUE8/P/Vj2VaisoCpF98HqdAhFs5yYBsIWtj16vq
   0=;
X-IronPort-AV: E=Sophos;i="6.08,155,1712620800"; 
   d="scan'208";a="88588578"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 13:47:08 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.44.209:51174]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.61.78:2525] with esmtp (Farcaster)
 id 30de5ed3-1963-44e4-9c93-85b84c4523fc; Sun, 12 May 2024 13:47:07 +0000 (UTC)
X-Farcaster-Flow-ID: 30de5ed3-1963-44e4-9c93-85b84c4523fc
Received: from EX19D008UEC004.ant.amazon.com (10.252.135.170) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sun, 12 May 2024 13:47:06 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEC004.ant.amazon.com (10.252.135.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sun, 12 May 2024 13:47:06 +0000
Received: from dev-dsk-darinzon-1c-05962a8d.eu-west-1.amazon.com
 (172.19.80.187) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Sun, 12 May 2024 13:47:04
 +0000
From: <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
	<alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky, Evgeny"
	<evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>
Subject: [PATCH v2 net-next 5/5] net: ena: Change initial rx_usec interval
Date: Sun, 12 May 2024 13:46:37 +0000
Message-ID: <20240512134637.25299-6-darinzon@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240512134637.25299-1-darinzon@amazon.com>
References: <20240512134637.25299-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: David Arinzon <darinzon@amazon.com>

For the purpose of obtaining better CPU utilization,
minimum rx moderation interval is set to 20 usec.

Signed-off-by: Osama Abboud <osamaabb@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.h b/drivers/net/ethernet/amazon/ena/ena_com.h
index fdae0cc9..924f03f5 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_com.h
@@ -47,7 +47,7 @@
 /* ENA adaptive interrupt moderation settings */
 
 #define ENA_INTR_INITIAL_TX_INTERVAL_USECS 64
-#define ENA_INTR_INITIAL_RX_INTERVAL_USECS 0
+#define ENA_INTR_INITIAL_RX_INTERVAL_USECS 20
 #define ENA_DEFAULT_INTR_DELAY_RESOLUTION 1
 
 #define ENA_HASH_KEY_SIZE 40
-- 
2.40.1


