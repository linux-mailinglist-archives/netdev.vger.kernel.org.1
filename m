Return-Path: <netdev+bounces-90335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F0B8ADC78
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 05:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD8E1C21471
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 03:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6251D52D;
	Tue, 23 Apr 2024 03:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="i7rqQYtk"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF0F1CA9E
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 03:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713844467; cv=none; b=glDhAC6VbMynQBz0fIWuQZi8JdrfavAuJ3hI2lO0gECJzmaTPfXsXFrq5VB5gd9Od0wlrevc3FN8RqQ5hUETrlrhBpd5zo8JwqWHYCvYDiXqwAp8oxChteih5oZZcnaxt7kelgBihkTK/ysU30hgmzYHHFxR3cLJt6i1wIMBm18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713844467; c=relaxed/simple;
	bh=L87tZT5fsVXQ2VoPOx5NZIXgP8+qRung2jsm5yS1FSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kvy0S/eIfOsrF2KnUWfiR6kFkBraDdLwtBL1waLo3VlBG14caThW6YVECkNDK2+I/noh3xwVyKT7CRoJbA4gBrESuHB8SEU9DpEn8Cz/o3ksVKrXg1LIgRvra6NEuIEaIt3sKe9UzXPtGRE2PX/8EIUdZFa9RwYfBEYV3aoc8fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=i7rqQYtk; arc=none smtp.client-ip=173.37.142.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2445; q=dns/txt; s=iport;
  t=1713844466; x=1715054066;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DFGBfXNTwvlXoCuKnqOlo+8Kjzxy6pnrK1OpXY/70Lk=;
  b=i7rqQYtkZgcRi4OAySvtwPYKKuV/KF2OVdmgPQnL1PVXIGMMQYCETEWN
   2p7B9By2jPRy2S4leXL8zfKeESx0tTBc1Y3cP/0NQCpfYQXkKEHU6IzdA
   5pFmIZXDlwNKi/41Opc4GIsezok8gk2yPooWPU7bnC3GPSlC+jJRqZcJp
   A=;
X-CSE-ConnectionGUID: wBEV4OgRSOSuoJoepyrZww==
X-CSE-MsgGUID: ix0TH5CIQ5Cy5gM7/6vPIA==
X-IronPort-AV: E=Sophos;i="6.07,222,1708387200"; 
   d="scan'208";a="256654479"
Received: from alln-core-12.cisco.com ([173.36.13.134])
  by alln-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 03:53:18 +0000
Received: from satish-f17-ru1.cisco.com (satish-f17-ru1.cisco.com [10.193.163.97])
	(authenticated bits=0)
	by alln-core-12.cisco.com (8.15.2/8.15.2) with ESMTPSA id 43N3rC13022413
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 23 Apr 2024 03:53:18 GMT
From: Satish Kharat <satishkh@cisco.com>
To: netdev@vger.kernel.org
Cc: Satish Kharat <satishkh@cisco.com>
Subject: [PATCH net-next] enic: Replace hardcoded values for vnic descriptor by defines
Date: Mon, 22 Apr 2024 20:53:05 -0700
Message-ID: <20240423035305.6858-1-satishkh@cisco.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: satishkh@cisco.com
X-Outbound-SMTP-Client: 10.193.163.97, satish-f17-ru1.cisco.com
X-Outbound-Node: alln-core-12.cisco.com

Replace the hardcoded values used in the calculations for
vnic descriptors and rings with defines. Minor code cleanup.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/vnic_dev.c | 20 ++++++++------------
 drivers/net/ethernet/cisco/enic/vnic_dev.h |  5 +++++
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/vnic_dev.c b/drivers/net/ethernet/cisco/enic/vnic_dev.c
index 12a83fa1302d..9f6089e81608 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_dev.c
+++ b/drivers/net/ethernet/cisco/enic/vnic_dev.c
@@ -146,23 +146,19 @@ EXPORT_SYMBOL(vnic_dev_get_res);
 static unsigned int vnic_dev_desc_ring_size(struct vnic_dev_ring *ring,
 	unsigned int desc_count, unsigned int desc_size)
 {
-	/* The base address of the desc rings must be 512 byte aligned.
-	 * Descriptor count is aligned to groups of 32 descriptors.  A
-	 * count of 0 means the maximum 4096 descriptors.  Descriptor
-	 * size is aligned to 16 bytes.
-	 */
-
-	unsigned int count_align = 32;
-	unsigned int desc_align = 16;
 
-	ring->base_align = 512;
+	/* Descriptor ring base address alignment in bytes*/
+	ring->base_align = VNIC_DESC_BASE_ALIGN;
 
+	/* A count of 0 means the maximum descriptors */
 	if (desc_count == 0)
-		desc_count = 4096;
+		desc_count = VNIC_DESC_MAX_COUNT;
 
-	ring->desc_count = ALIGN(desc_count, count_align);
+	/* Descriptor count aligned in groups of VNIC_DESC_COUNT_ALIGN descriptors */
+	ring->desc_count = ALIGN(desc_count, VNIC_DESC_COUNT_ALIGN);
 
-	ring->desc_size = ALIGN(desc_size, desc_align);
+	/* Descriptor size alignment in bytes */
+	ring->desc_size = ALIGN(desc_size, VNIC_DESC_SIZE_ALIGN);
 
 	ring->size = ring->desc_count * ring->desc_size;
 	ring->size_unaligned = ring->size + ring->base_align;
diff --git a/drivers/net/ethernet/cisco/enic/vnic_dev.h b/drivers/net/ethernet/cisco/enic/vnic_dev.h
index 6273794b923b..7fdd8c661c99 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_dev.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_dev.h
@@ -31,6 +31,11 @@ static inline void writeq(u64 val, void __iomem *reg)
 #undef pr_fmt
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#define VNIC_DESC_SIZE_ALIGN	16
+#define VNIC_DESC_COUNT_ALIGN	32
+#define VNIC_DESC_BASE_ALIGN	512
+#define VNIC_DESC_MAX_COUNT	4096
+
 enum vnic_dev_intr_mode {
 	VNIC_DEV_INTR_MODE_UNKNOWN,
 	VNIC_DEV_INTR_MODE_INTX,
-- 
2.44.0


