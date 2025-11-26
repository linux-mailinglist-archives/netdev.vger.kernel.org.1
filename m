Return-Path: <netdev+bounces-242020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF73C8BB39
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A25FF4E751C
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D666934253B;
	Wed, 26 Nov 2025 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QxLyMBqy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AABF340DA6
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186623; cv=none; b=l/gLrEmYb9u8/4CJGARCxCJkgtuhFz06SWvUPPcs9zs4RauHI+8NJGt+H/0FYyoeLFGDwet3Dn7H+bG2cg23t9NsoyNGL/Kz2dwrvYANq8gZjMB3kIXwQ0M7HwstgjvHNHzU6MK2Fye4x1HPvs9SByIkzIpIzKDNEuOBuoIBrEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186623; c=relaxed/simple;
	bh=fjEmRoB9hUx/yTwurdRWTC5wYfnnnQ1F55aOcDeaZLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcklK8EaZCj8bbSGITgunvw33TO87f5HZQdShFfO82RcbeVeCMV0uUwcun4sDnvMm7yAryFnByglq/xrRgsTCpTqc5dyTYKxCzUW6Ghv4/MMb/RcMGvg67UvZsY+g5apoIWO0a0IyXgl0Mo4Dq3McCFw0gsmqM3O2YBb1qdW5KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QxLyMBqy; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-299d40b0845so1955025ad.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186621; x=1764791421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j/O6TymoVT0YLWv0CCYV9EkHA+o+pWNxKmyURfVFr0c=;
        b=QhCNhYOVQtfykyO992CbqmFvJdwRFDqmU5o7JqI7yMigv/c87lgLF91UEgm/pZAkRy
         SwsBPNN1+SqTZaxGnb6EW3LTWWjQOp5etsU5CfQT5UFcFzaMGeRQcw02znHjO5MB8y8L
         m/PLJkFpZaOsLn2LTQRKV5CcjpwBqrGHCIKpUHp8uLSWMJnUKYZA65FN6QWCRx2kizC0
         3WAXXxJjl77jSB08TGHZ1FWkriWGmrXSYfFeJNkfzy6ZR/ArHqfLCXYRUng22IDwXdvs
         JIHj4lat1+3vCsUQvgOOWciDHjiPDHvrKnfgYcgcP5e4ungyIL1yXC7/ldQmxAM9T9g/
         chzg==
X-Gm-Message-State: AOJu0YyfWfdCXeI16wZU+mlydh1fDCU7pytQmWQP5uutnbGLhsaqzPgh
	np38KSD5gkWSUA09pUNhVMpPiOAM1IhXB1EHp8oD5852i/C7qp2jyl31YfPvRFJ4FfYiuBpmCNV
	HgGaujOSIPqkX8ufhC/NVXhL1Eu2W9CnAjg33HJ41ljda/kFNdQ+Uzln0PuVKLjTNbUT+yh8ZC4
	kZw0FDl8SjoC6CUdQWUMkeHnqNdBDatUn59UgBwqcjTIKeRC50/vNtIFkTaPIJMxy2up6Ar0QNl
	B6IRvF9ZyXXFpnqawlL
X-Gm-Gg: ASbGncvzPweDJDmobyZzb8DFmyy09gYYFeKkX2thWheiKYlEu7TGAJcdAo4CIAfePdG
	C81ThgrJbolNKoNuIyI+h7J/G5rvnnsAjvUxrcJF5YVsfxW8VYjel7rBDyTQ9BKsVbnfENNuUMJ
	9M+qCRRnKnHYWU0lZhN9V7/TPQfZlpemkBSTs7Y9nWOG+AVHSVFBfxuq5OdLS0q5dW5Sg57bFCB
	IQ/y69bdfV018gtGda+2pvHcLcT8qFZQJu8z1GRq/oazlL/jIevRzrQVn1seUqGQUfRANk+ofa6
	RbRh6BLmnXWAlo0OkB+HxbiE4HU4qPJXIEZ/gBk/YJHIlnJ8nnuVfCTG0BGW3wX8i6+Xpj7kVr+
	spl0Z3u8zQ/d/w9hkf1BUlqoMMKkNaVxSr1oqXN6o+EB5FQKoiLL2gJzey/a7PkWrROm16OYq/D
	z4JDTkHXh83i3yxZwQygNM4X1331ioI3wdyZGCoTSjvuJGQ5U1YYw=
X-Google-Smtp-Source: AGHT+IFvn/vn8U30NEEIuGTej/iXUggy3aLL8z3m8IeXg5RbvQ/7webosvEms/VzQQg6fSdBi+h0yfOaIg+p
X-Received: by 2002:a17:902:ef10:b0:24c:da3b:7376 with SMTP id d9443c01a7336-29baafb7f4fmr87572575ad.26.1764186621497;
        Wed, 26 Nov 2025 11:50:21 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3476a85e55csm271206a91.5.2025.11.26.11.50.21
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2025 11:50:21 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297d50cd8c4so4723415ad.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764186620; x=1764791420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/O6TymoVT0YLWv0CCYV9EkHA+o+pWNxKmyURfVFr0c=;
        b=QxLyMBqyHYHo6fnFL8Re4JuZPo+G+i4mbooIMTp2xD2S4CRQTW2RR6kJO0vQTGbISM
         mDfybrlZdzjsvnNgMhHukfsxArc1j1pCaNji7za5tgvUOdncqtpCihYY+RfmrH7bNlDq
         JWMcHpRa4xXOsrzUiNIdQr72yx0yEZHFhxORU=
X-Received: by 2002:a17:903:2f07:b0:298:2cdf:56c8 with SMTP id d9443c01a7336-29bab300f4dmr79404255ad.60.1764186619733;
        Wed, 26 Nov 2025 11:50:19 -0800 (PST)
X-Received: by 2002:a17:903:2f07:b0:298:2cdf:56c8 with SMTP id d9443c01a7336-29bab300f4dmr79404015ad.60.1764186619349;
        Wed, 26 Nov 2025 11:50:19 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25e638sm206782375ad.58.2025.11.26.11.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:50:18 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v3, net-next 04/12] bng_en: Handle an HWRM completion request
Date: Thu, 27 Nov 2025 01:19:23 +0530
Message-ID: <20251126194931.455830-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
References: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Since the HWRM completion for a sent request lands on the NQ,
add functions to handle the HWRM completion event.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  4 +-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  1 +
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 44 ++++++++++++++++++-
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index c43b729e23c..bb9223a00b5 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -18,6 +18,7 @@
 #include <net/page_pool/helpers.h>
 
 #include "bnge.h"
+#include "bnge_hwrm.h"
 #include "bnge_hwrm_lib.h"
 #include "bnge_ethtool.h"
 #include "bnge_rmem.h"
@@ -2315,8 +2316,7 @@ static int bnge_open(struct net_device *dev)
 
 static int bnge_shutdown_nic(struct bnge_net *bn)
 {
-	/* TODO: close_path = 0 until we make NAPI functional */
-	bnge_hwrm_resource_free(bn, 0);
+	bnge_hwrm_resource_free(bn, 1);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 41af5827a25..3c8fffb5e2d 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -78,6 +78,7 @@ struct tx_cmp {
 	#define CMPL_BASE_TYPE_HWRM_FWD_REQ			0x22UL
 	#define CMPL_BASE_TYPE_HWRM_FWD_RESP			0x24UL
 	#define CMPL_BASE_TYPE_HWRM_ASYNC_EVENT			0x2eUL
+	#define CMPL_BA_TY_HWRM_ASY_EVT	CMPL_BASE_TYPE_HWRM_ASYNC_EVENT
 	#define TX_CMP_FLAGS_ERROR				(1 << 6)
 	#define TX_CMP_FLAGS_PUSH				(1 << 7)
 	u32 tx_cmp_opaque;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index f4168729c7d..c8e9b96aa1c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -397,6 +397,43 @@ static void __bnge_poll_work_done(struct bnge_net *bn, struct bnge_napi *bnapi,
 	}
 }
 
+static void
+bnge_hwrm_update_token(struct bnge_dev *bd, u16 seq_id,
+		       enum bnge_hwrm_wait_state state)
+{
+	struct bnge_hwrm_wait_token *token;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(token, &bd->hwrm_pending_list, node) {
+		if (token->seq_id == seq_id) {
+			WRITE_ONCE(token->state, state);
+			rcu_read_unlock();
+			return;
+		}
+	}
+	rcu_read_unlock();
+	dev_err(bd->dev, "Invalid hwrm seq id %d\n", seq_id);
+}
+
+static int bnge_hwrm_handler(struct bnge_dev *bd, struct tx_cmp *txcmp)
+{
+	struct hwrm_cmpl *h_cmpl = (struct hwrm_cmpl *)txcmp;
+	u16 cmpl_type = TX_CMP_TYPE(txcmp), seq_id;
+
+	switch (cmpl_type) {
+	case CMPL_BASE_TYPE_HWRM_DONE:
+		seq_id = le16_to_cpu(h_cmpl->sequence_id);
+		bnge_hwrm_update_token(bd, seq_id, BNGE_HWRM_COMPLETE);
+		break;
+
+	case CMPL_BASE_TYPE_HWRM_ASYNC_EVENT:
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int __bnge_poll_work(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 			    int budget)
 {
@@ -447,8 +484,11 @@ static int __bnge_poll_work(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
 				rx_pkts++;
 			else if (rc == -EBUSY)	/* partial completion */
 				break;
+		} else if (unlikely(cmp_type == CMPL_BASE_TYPE_HWRM_DONE ||
+				    cmp_type == CMPL_BASE_TYPE_HWRM_FWD_REQ ||
+				    cmp_type == CMPL_BA_TY_HWRM_ASY_EVT)) {
+			bnge_hwrm_handler(bn->bd, txcmp);
 		}
-
 		raw_cons = NEXT_RAW_CMP(raw_cons);
 
 		if (rx_pkts && rx_pkts == budget) {
@@ -565,6 +605,8 @@ int bnge_napi_poll(struct napi_struct *napi, int budget)
 			work_done += __bnge_poll_work(bn, cpr,
 						      budget - work_done);
 			nqr->has_more_work |= cpr->has_more_work;
+		} else {
+			bnge_hwrm_handler(bn->bd, (struct tx_cmp *)nqcmp);
 		}
 		raw_cons = NEXT_RAW_CMP(raw_cons);
 	}
-- 
2.47.3


