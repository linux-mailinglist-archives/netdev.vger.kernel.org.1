Return-Path: <netdev+bounces-105407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB2C911005
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 20:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED361C2128E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 18:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054AB1C8FAC;
	Thu, 20 Jun 2024 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMLvHFWs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA531C68BF;
	Thu, 20 Jun 2024 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906290; cv=none; b=NkG6ahXI7qdXlnafBDMWBquDhfBbKoVZl8gfC0o1lB/NVTWGIxuPceYByF5VYlmxPPy+PW3nlYA2FaqBlhD3p/yRy94IEf0qXiW78DoxCAKq/UF1MIzk455GNgezjQBCumZ7t2yVIb3bjpeAOHTBc4NVdUyxC7ZaMjj8++w1qXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906290; c=relaxed/simple;
	bh=ScoEmgZi6HPVHvIh/FX/S5wdvye/fu3oKSGTZiZ4FUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIU8vCE3Lh3K7ntOpBjbCxNv0mcdt0i1ABuQ0VbyLIc3pZIiHGFJWFz9s10VBj1nXgpb5vq/FGfm098rK2UuRy76JuNWHm1icDRY9bW1qdOPPgeD1x78eMCBpLsox0+Wv2Yjd3d6IU/K/6fspLQuWwBaSU+Ec9juUa+OU3u3mMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMLvHFWs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f65a3abd01so9825955ad.3;
        Thu, 20 Jun 2024 10:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906289; x=1719511089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aM5r6drJAolG+e7iKS0TLJF6ZMjGSQBElC3QUFVYkk4=;
        b=mMLvHFWssZem5d0HFmhbgpMfzJUBZrcE7ha8z7HkCcgAZARCbQYYXPyGrL1DwT+f1Q
         ewR2CK8Ibc4PptJCYpeK6YqoBSnqVla7yG4mzIeg+8R2d8N+5bicC4Dx5FdO5abSRRNT
         SPSlbMLVgpDUrW+BW2yUW6voaqpPGRNp97DQ8rXFj6XOCPWVBofJvdOTn1Ra0Cj7qBS7
         cQTAKhF1pva7UMcFofDPofBahbk6DEmBusTIONl0ykSdGGLkyvWuDHNOsqzAIwkeTu80
         T7F6hJGI1Ge79x+nfBUkzdAwkUIyed/zSIOtBa3GUhHTo1JPcfzC/PJiSH5NVPEwLpjY
         vHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906289; x=1719511089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aM5r6drJAolG+e7iKS0TLJF6ZMjGSQBElC3QUFVYkk4=;
        b=kS/eH4dKv24G2TsSJpgPWJ2bqxWwBqGqr4lsXRrKgJ39+GpSM0vpyo0jFj6aBzUVL3
         7QrvoFJzKcNCZ4ZYVUcW6J/vy6dgZjUfrQIm0w8//LtlD09ulVs3fcUs57prbLII6a1s
         NWHyJ9c8QTKij0UOSFkcozv91+uuIw1WbA0gCRr6EPvlgmkwbaq6vtOHnGa0QW/2lY7v
         wdd6/NBKJ64SaKbA8vOhvIv2kUvgBVPg3lCm8B7nQrWoNAQ6/gK+2gekp0qmpwvCy0MG
         Y06MLXd5lfJo0JlwCbZzGR/mkkneXy7b4wwCsVYm8FM0lTCikj7R37pOoSxDgBLUu2OR
         UZ4w==
X-Forwarded-Encrypted: i=1; AJvYcCXIe6kGrcpG9O7Jppf3NI1toOXwR6TXaLovyNPw6hFDVafOwtKDutkNrPVS9X370qXVlEYit/hzGOVwJgFeePGJ83G2aarn
X-Gm-Message-State: AOJu0YxTt9JUIG40ATzSvgK1tabTEgEJgPrDUAcpGiQCoIDzQ5pcvnA5
	BRz9v9J2JOljFD0H9MCA8Ow3G2YnippB5HXaRxsLZemfRo0q8Aa+pck6le9JxtM=
X-Google-Smtp-Source: AGHT+IGTpIdO1uV11a9fnQTFo6rZEqj4PAGNZxvz9A2Y8Nk1O+96gr6SMXGZm1d2oyKBSv0djR+7OA==
X-Received: by 2002:a17:903:2349:b0:1f8:69ed:cfd5 with SMTP id d9443c01a7336-1f9aa3b09ebmr73525515ad.10.1718906288971;
        Thu, 20 Jun 2024 10:58:08 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9c20c7e30sm24175035ad.221.2024.06.20.10.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:58:08 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Edward Cree <ecree.xilinx@gmail.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-net-drivers@amd.com
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 21/40] sfc: optimize the driver by using atomic find_bit() API
Date: Thu, 20 Jun 2024 10:56:44 -0700
Message-ID: <20240620175703.605111-22-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SFC code traverses rps_slot_map and rxq_retry_mask bit by bit. Simplify
it by using dedicated atomic find_bit() functions, as they skip already
clear bits.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/rx_common.c         |  5 ++---
 drivers/net/ethernet/sfc/siena/rx_common.c   |  5 ++---
 drivers/net/ethernet/sfc/siena/siena_sriov.c | 15 +++++++--------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
index dcd901eccfc8..370a2d20ccfb 100644
--- a/drivers/net/ethernet/sfc/rx_common.c
+++ b/drivers/net/ethernet/sfc/rx_common.c
@@ -9,6 +9,7 @@
  */
 
 #include "net_driver.h"
+#include <linux/find_atomic.h>
 #include <linux/module.h>
 #include <linux/iommu.h>
 #include <net/rps.h>
@@ -953,9 +954,7 @@ int efx_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
 	int rc;
 
 	/* find a free slot */
-	for (slot_idx = 0; slot_idx < EFX_RPS_MAX_IN_FLIGHT; slot_idx++)
-		if (!test_and_set_bit(slot_idx, &efx->rps_slot_map))
-			break;
+	slot_idx = find_and_set_bit(&efx->rps_slot_map, EFX_RPS_MAX_IN_FLIGHT);
 	if (slot_idx >= EFX_RPS_MAX_IN_FLIGHT)
 		return -EBUSY;
 
diff --git a/drivers/net/ethernet/sfc/siena/rx_common.c b/drivers/net/ethernet/sfc/siena/rx_common.c
index 219fb358a646..fc1d4d02beb6 100644
--- a/drivers/net/ethernet/sfc/siena/rx_common.c
+++ b/drivers/net/ethernet/sfc/siena/rx_common.c
@@ -9,6 +9,7 @@
  */
 
 #include "net_driver.h"
+#include <linux/find_atomic.h>
 #include <linux/module.h>
 #include <linux/iommu.h>
 #include <net/rps.h>
@@ -959,9 +960,7 @@ int efx_siena_filter_rfs(struct net_device *net_dev, const struct sk_buff *skb,
 	int rc;
 
 	/* find a free slot */
-	for (slot_idx = 0; slot_idx < EFX_RPS_MAX_IN_FLIGHT; slot_idx++)
-		if (!test_and_set_bit(slot_idx, &efx->rps_slot_map))
-			break;
+	slot_idx = find_and_set_bit(&efx->rps_slot_map, EFX_RPS_MAX_IN_FLIGHT);
 	if (slot_idx >= EFX_RPS_MAX_IN_FLIGHT)
 		return -EBUSY;
 
diff --git a/drivers/net/ethernet/sfc/siena/siena_sriov.c b/drivers/net/ethernet/sfc/siena/siena_sriov.c
index 8353c15dc233..f643413f9c20 100644
--- a/drivers/net/ethernet/sfc/siena/siena_sriov.c
+++ b/drivers/net/ethernet/sfc/siena/siena_sriov.c
@@ -3,6 +3,7 @@
  * Driver for Solarflare network controllers and boards
  * Copyright 2010-2012 Solarflare Communications Inc.
  */
+#include <linux/find_atomic.h>
 #include <linux/pci.h>
 #include <linux/module.h>
 #include "net_driver.h"
@@ -722,14 +723,12 @@ static int efx_vfdi_fini_all_queues(struct siena_vf *vf)
 					     efx_vfdi_flush_wake(vf),
 					     timeout);
 		rxqs_count = 0;
-		for (index = 0; index < count; ++index) {
-			if (test_and_clear_bit(index, vf->rxq_retry_mask)) {
-				atomic_dec(&vf->rxq_retry_count);
-				MCDI_SET_ARRAY_DWORD(
-					inbuf, FLUSH_RX_QUEUES_IN_QID_OFST,
-					rxqs_count, vf_offset + index);
-				rxqs_count++;
-			}
+		for_each_test_and_clear_bit(index, vf->rxq_retry_mask, count) {
+			atomic_dec(&vf->rxq_retry_count);
+			MCDI_SET_ARRAY_DWORD(
+				inbuf, FLUSH_RX_QUEUES_IN_QID_OFST,
+				rxqs_count, vf_offset + index);
+			rxqs_count++;
 		}
 	}
 
-- 
2.43.0


