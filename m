Return-Path: <netdev+bounces-238757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E375C5F1D2
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 20:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 881744EC026
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 19:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2C4313544;
	Fri, 14 Nov 2025 19:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UBV7XeMS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EB1342CBA
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 19:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763150048; cv=none; b=NI/89c8VllnZ0bfztrXhJ5y5+QTNFOHa+UJOPeX3gVbjNMG/Lt3/VOcQTO4o+cY5TBNPO04BJRCk9Jj6WiuA4MuxNI11tI4QKEImawQ/cA6vM+mS6tErtkjyiyy6pbWgqAqvauBAjb0a8WhQwHd9Wsvz2W+IbYGaY5+dDlKRpIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763150048; c=relaxed/simple;
	bh=OwvR/dPLZK37K1BmREFFi1Wrd2L+JHV93zFie6DXuO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6hGKmj3B5Ii/nwpbPT+eoIszMYIZ7W6d6EECKuAHsgfRcmt5eWBewx8Qdmb1N0qGJRGMHjAdqGix/s1JpEcVEs2xdygAPdlrbArKrrO8pdrA3HvWr1Hwc3Y5ZhclgwbvZBvWREYkjAotWCEKQoUMbdjOY6BzT5OP4BF9OP2MPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UBV7XeMS; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7c6d699610cso723447a34.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 11:54:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763150045; x=1763754845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=arzdhcB0zbOBVOiM/6hbOwxYhTE0CSizIk0DE7KRy3g=;
        b=QOJcCCWOFt+JnQA/eSCq9hd4VsJEbQZn7huO8NTIYVxnnbKT+xr/Est//4glkZz7gi
         9BxsaPpa5+KY1VR0qCX7MriJ66RhLrJvTJ0uYMyj78wrgIcDDoOvgRs/WkaZDt9FD5Xk
         iv3QJViTjQZ32kRGXLNe3szw/DSuGMORdFzdMnuVrL7ath34LqTYfs5Mplgh+yC2hrb+
         AiDzmBH1v4CHbvlJ/5nfP9i1XFvb8sE98voYl2FzMe1yP0EOl2hLr3cc3NJviVlT14hJ
         6wP/0hns3MQeI50BAr0N9XTHAGMX4/ak33XfGJSiBScNrxF40M00V6k0l53kPNao27pL
         CxjQ==
X-Gm-Message-State: AOJu0Yy9PSr2w/dxyUtV5AFhhUR34p6Jwh+3IbAkmAVjgC/QhV0T9mkU
	6y18B9rlUrzGfu9l+liIgPuse6w8mpda+wMZfzp/4bZOJIX+mHmIR11P3JHQETDIAS0n0cxInOr
	UbU/+dLI8AtDWOPDi9LWxq9PUmsLg9QETtuPqoCZ8USDAN/6ztN/wdgL2u9ePCElsNH+zeYAWP+
	pofQLpYk/uut7at2/Xk8nCFDBXR3gbt+E8+hTi/mJCFOsFITbw/sp2SUx3UzIVqNli3VPprxBJX
	Mvx9dabM5F+wLYfMw==
X-Gm-Gg: ASbGncs8/FqSzMdrq002rkQORVSdRdBI+emZ3TZ9dSHNgV+RathBGkroU315KiWMe+s
	G1dFbOROMiLQTbzFfQJek4tOPgUatwxXzGpU1m+1LNTfuF27o3PwgNxhdvcCBcRsH8OltvusECH
	JAB5KqNBCYwD4FyNlvYxHIN/hMwc5l8TjW9JCRp9Lii5Tubu5ve6hQfdPE6pHjSeIV+iqy+Jb/e
	nDjw1O2mJeKbqJRuMtTw0K66MX5NEd1sU+HnXBtIhvtrTnO9Tkqg1HTjmyHa9msXqotT5M78KWR
	c1z6Unin2uIoVEyFsjUbgM+X88xnEhdxFgrrbRTU91W3us9nWrjIla8qOLKNQj8M/RkzkLPm6Yx
	eqfGaF9q5xHWngXyepTAZxbspuQTb0oGqenAyYG9O8q/63hBhEPNrFM6Y3srwEPaTjzZ8VgMfR7
	mZBekArsAfRqIZzFFfhj7CPJSriXePRuORcl3d8CKs
X-Google-Smtp-Source: AGHT+IGsbjdIZEsb5wc9vqK07PdI58ZsOPbCxRxdP6BxMlSS0khhYcp5BGEzji8jV6SKr7Ol3/sH6CJpeWqb
X-Received: by 2002:a05:6830:2b06:b0:7c5:3045:6c6f with SMTP id 46e09a7af769-7c7445b5ea6mr2843020a34.20.1763150044999;
        Fri, 14 Nov 2025 11:54:04 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7c73a324d05sm573284a34.3.2025.11.14.11.54.04
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Nov 2025 11:54:04 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3437f0760daso5955947a91.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 11:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763150043; x=1763754843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arzdhcB0zbOBVOiM/6hbOwxYhTE0CSizIk0DE7KRy3g=;
        b=UBV7XeMSyBL6AxiRncv50LGDiS9HSKz8IXCF1LyvqWDIMEY38PbR9CvfXe88mHJuao
         OAJeeOXMqrc0H8FHJ8YpJo6gwNsqavNankUTiSQwKYnja3g2avfLSu1JnUx807uAYgZa
         H+eiPVH1Mc4bVTia/ejcgZK2OXpmAY/ODvn5A=
X-Received: by 2002:a17:90b:35d0:b0:340:48f2:5e2d with SMTP id 98e67ed59e1d1-343f9eb5052mr4740709a91.9.1763150043619;
        Fri, 14 Nov 2025 11:54:03 -0800 (PST)
X-Received: by 2002:a17:90b:35d0:b0:340:48f2:5e2d with SMTP id 98e67ed59e1d1-343f9eb5052mr4740689a91.9.1763150043231;
        Fri, 14 Nov 2025 11:54:03 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ea5f9fa4sm3108113a91.0.2025.11.14.11.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:54:02 -0800 (PST)
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
Subject: [v2, net-next 04/12] bng_en: Handle an HWRM completion request
Date: Sat, 15 Nov 2025 01:22:52 +0530
Message-ID: <20251114195312.22863-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114195312.22863-1-bhargava.marreddy@broadcom.com>
References: <20251114195312.22863-1-bhargava.marreddy@broadcom.com>
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
index d7149f098a5..a8ebf889330 100644
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
index d13c0c52553..8a38b022f7a 100644
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
index 41463d3825b..68ff9a8e277 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -392,6 +392,43 @@ static void __bnge_poll_work_done(struct bnge_net *bn, struct bnge_napi *bnapi,
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
@@ -442,8 +479,11 @@ static int __bnge_poll_work(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
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
@@ -560,6 +600,8 @@ int bnge_napi_poll(struct napi_struct *napi, int budget)
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


