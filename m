Return-Path: <netdev+bounces-169165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A63A3A42C57
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 20:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E953A8BE0
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27C81FCFCA;
	Mon, 24 Feb 2025 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SzUMdczp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EBF1FC0F1
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424019; cv=none; b=TBwKgN0A4VbXoRcy6ttQ7qFRnYdQz2kyKjKjv6GkF41mpu4t/wogrt6Bu+ZIuzoBmyF7nkxuNg441iBHcofjbOjUnj1bbuvanvcj3DYJ6Y/V4Rrc5d4Pe1RG0hNdrnpeKTtVaSyKq/RJJDSVl/zb3MexghMT7AMNMPPth67ML6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424019; c=relaxed/simple;
	bh=zCdwYvNSOb0TUw/feMD/Q//2+RlqrrePrcFwiU55D/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9Jvt0psJv+6nkghhiYNfq7Jj6EyhEI7rUmx1P0TXWvFFqxh1MNqOYHb38xhjQRIZ7d1k7voGO0WENp6I+2CurGsCbgK0b/ep6TVB3B/4ZR6YZ34CqShK0kphue860elMcOkipwCFponANZO8zpo4Vw40MvC338X73WYZurMX0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SzUMdczp; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740424018; x=1771960018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zCdwYvNSOb0TUw/feMD/Q//2+RlqrrePrcFwiU55D/o=;
  b=SzUMdczpvNElGYpfPoH7cGvG4Xf9CcH8pzKfUO+u7jzGcqnHTsWPG6r0
   WxP1xpPvnmk6cgcwdHL9WXPEQW0+QmmgH9xESR6ro5B1GiM86J9Dm4Eyc
   eTEcUKTShdIBmPjmS+7LSOJQu/fXbwcbFhEm/8xoxDR5jbBURQ3mTPGNd
   wvTb01kyv5Z8NcyXyZ61mBFKH/53kj0upkBCY3Ch26kv8+jsQnHAkiiNx
   +vQDsL2ayuknRqz70oHjaby9XInX7halbT3vGilqDvV1xFMswDuDEoQdl
   98Ym5lw0xSWxEo1m0o6GwaZ5RnTR+njuxlptZkULusGEPOEs7RyzjIeAO
   Q==;
X-CSE-ConnectionGUID: HZ1DmZn9TZyx072+XpajDg==
X-CSE-MsgGUID: DMdnvOAmTCaFopX5fFOBbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58614201"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="58614201"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 11:06:55 -0800
X-CSE-ConnectionGUID: WzCjF33eRnG1mN+ONGXb8A==
X-CSE-MsgGUID: JvpgXMikTLqkv49NgfE0tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="153358462"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 24 Feb 2025 11:06:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Ahmed Zaki <ahmed.zaki@intel.com>,
	anthony.l.nguyen@intel.com,
	willemb@google.com,
	Madhu Chittim <madhu.chittim@intel.com>,
	Simon Horman <horms@kernel.org>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 3/5] idpf: synchronize pending IRQs after disable
Date: Mon, 24 Feb 2025 11:06:43 -0800
Message-ID: <20250224190647.3601930-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250224190647.3601930-1-anthony.l.nguyen@intel.com>
References: <20250224190647.3601930-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ahmed Zaki <ahmed.zaki@intel.com>

Wait for pending IRQ handler after it is disabled. This will ensure the IRQ
is cleanly freed afterwards.

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Suggested-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 9be6a6b59c4e..8006bd9a95f6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3592,10 +3592,15 @@ static void idpf_vport_intr_rel_irq(struct idpf_vport *vport)
 static void idpf_vport_intr_dis_irq_all(struct idpf_vport *vport)
 {
 	struct idpf_q_vector *q_vector = vport->q_vectors;
-	int q_idx;
+	int q_idx, vidx, irq_num;
+
+	for (q_idx = 0; q_idx < vport->num_q_vectors; q_idx++) {
+		vidx = vport->q_vector_idxs[q_idx];
+		irq_num = vport->adapter->msix_entries[vidx].vector;
 
-	for (q_idx = 0; q_idx < vport->num_q_vectors; q_idx++)
 		writel(0, q_vector[q_idx].intr_reg.dyn_ctl);
+		synchronize_irq(irq_num);
+	}
 }
 
 /**
-- 
2.47.1


