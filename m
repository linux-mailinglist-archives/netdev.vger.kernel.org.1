Return-Path: <netdev+bounces-250621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 194C5D38614
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 20:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C8F1301DBBF
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 19:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB11D3A0E84;
	Fri, 16 Jan 2026 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LMy9cGi5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f98.google.com (mail-dl1-f98.google.com [74.125.82.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1EE3644CC
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768592296; cv=none; b=ch9uywFbq2khHnRd5t8oc0MW5br27BAP0CdP90n/NAxF1fvvXY9RAK6teLbzhTb91sMws4UzaBk2aKlEIsKg5TzUrP4doCnfV0PQRUVQ5QK4k9D/gczcLD7FHkptRuuFAXc8i4FnF/HTgcaXXTaHaroxMtpkBoV3LsC9USuk4gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768592296; c=relaxed/simple;
	bh=x88N3oxkXRPiWEgxunQ43AN6MNHv3SUlHx6gqxlfUpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Usb49RRoxUHv1mNtvaVXMc9l/EbqqAAohWPZkGNfmQ3ZUP1cTXYebzsRXnTmZvyJKHgzki1ceKUlndWm22qxlSJSr7lqJwXCg7Uf6N0YJ50sOBPCeW5zwD/8DPdpyfCpRNlxz1+EDFBOipjfAsFc+Wu7UDh+X2m+OTnxq8AsHVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LMy9cGi5; arc=none smtp.client-ip=74.125.82.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-dl1-f98.google.com with SMTP id a92af1059eb24-12339e2e2c1so1538748c88.1
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 11:38:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768592294; x=1769197094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dzdMWEzSJ2Iibm3SBd/RgNfSnuzOKnyQSBjs/m3tLHM=;
        b=Ghnq75HqQfh607jk4mMu8hWW5H16xYcd6S+oPYC8LADn+JtichkWAKUGsD+MdFbaRf
         EaiPIsX5m6Y+4y7dLa/htgoXsIS9nWdSEflYfnA2bwE8voUF2yDtRLvr74gBqEOQZtEc
         OZVm0lQiFp7i2FqvsxDrA+fIZteTn29LRxuZ39LYLjibMpHUWC+1+cywsBh0ZJaM/3jf
         1IAGteO0usVrp30zC5FxdxQsyesFxrbr54ZCv5xEMq0lnb8XtzCjoANjCmTB7OJpxxMG
         G1Jr2A4aGUPbh4Z9LAngx9vuemdnGNlA+mz1mpGr1iD1XVODnqqZk0ieOyhbVgXBoCOH
         VI+w==
X-Gm-Message-State: AOJu0Yw5rkL9OXfIR9Z91njiR1M6zMS/A38dNDiHDJkCfF/+9cXshVJW
	VI9XwxMLPEPsJx/B4fqNpjm9Q15Z3toBwBCNVCy/e83DOOR17JTj6HoztEP9gY0vJqhVRqdzV4H
	Yw4/09q8ulxwE7cxF1AwC7jZHzAw9inpYYmH8zvCLQz0SJWfd7UJrzPaXsOxZSkqFrmSSNAWjAk
	oaD43yT4iyHPjwQB0d24Q2KuL/82xaIrsHgEJIG7r6eIYfyN9okvKjrOkBx58cGEcismjrBs/we
	HQqjtJJlCqjpAPnKQ==
X-Gm-Gg: AY/fxX726B3FpAKKB2iuKfkYDPrTuoUszU38z+czU6VSMU0m/ZmFUeyn3jc/I//zGAx
	VqQtW9vcnty4dLaIswNWmgHjbfT7ilqMpTk0ml9EjrjSPrw7HYnqDPRxIK8KbHNWVy41jDj2DTk
	sl4GbJLClOoACAxdiLVJcgHpsR9rszW4gcNdrxUhAMHbyf8cCJS5yNrmdlyK6mHIsIkvFO9Haa2
	YQeLJtNKYdR1tEnVa6Raw3iiDPcbeHDsAQN9XHDpIVtVUuMdeHsXINsY+DiQSQmFt2aqAhi9dsD
	/QIth1GanZmlz7oNaVU7jvLeeO9HmNrDsIw9xyk9qIHshZyT2apsoe4RGxFq8+HdGzuQCNWNoaN
	vy3Vwq5lMapvj8ob/vWo5c2E4cuZk/n83kaf7m2cQ2E7MEeIKSycv3BUbHkS1mZgJ22yAlIpqPc
	WOTmVDpZTo3ViRUn9gYZaSiDhPr0v4PmnRmrZiL+W6s+k2mi1R
X-Received: by 2002:a05:7022:5f13:b0:123:36f3:2d2f with SMTP id a92af1059eb24-1233d11e198mr6355366c88.26.1768592294291;
        Fri, 16 Jan 2026 11:38:14 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1244a893bf1sm752781c88.0.2026.01.16.11.38.14
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jan 2026 11:38:14 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34ab8aafd24so2484710a91.0
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 11:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768592292; x=1769197092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzdMWEzSJ2Iibm3SBd/RgNfSnuzOKnyQSBjs/m3tLHM=;
        b=LMy9cGi5+7Kh2IlAFQdMKZTk2KiNHSEMl8Kh+j8RM0oRHZPgS3p1cvK+yMumxeMrk7
         EQsHYYRYWGjskaggRmA3GkrVjpoCtrU9P4DnlxMcB0tLxjeYz2Ng3RWnPY2+ZrjEv7ur
         ke3K9WwPw8WPJY0Y4a9oMrz2ZOmQwQDkHubYE=
X-Received: by 2002:a17:90b:2246:b0:34a:a16d:77c3 with SMTP id 98e67ed59e1d1-35272bcb638mr3448712a91.2.1768592292458;
        Fri, 16 Jan 2026 11:38:12 -0800 (PST)
X-Received: by 2002:a17:90b:2246:b0:34a:a16d:77c3 with SMTP id 98e67ed59e1d1-35272bcb638mr3448694a91.2.1768592292011;
        Fri, 16 Jan 2026 11:38:12 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35273121856sm2764909a91.15.2026.01.16.11.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 11:38:11 -0800 (PST)
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
	ajit.khaparde@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v5, net-next 3/8] bng_en: Handle an HWRM completion request
Date: Sat, 17 Jan 2026 01:07:27 +0530
Message-ID: <20260116193732.157898-4-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116193732.157898-1-bhargava.marreddy@broadcom.com>
References: <20260116193732.157898-1-bhargava.marreddy@broadcom.com>
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  3 +-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  1 +
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    | 44 ++++++++++++++++++-
 3 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index aef22f77e583..594e83759802 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2303,8 +2303,7 @@ static int bnge_open(struct net_device *dev)
 
 static int bnge_shutdown_nic(struct bnge_net *bn)
 {
-	/* TODO: close_path = 0 until we make NAPI functional */
-	bnge_hwrm_resource_free(bn, 0);
+	bnge_hwrm_resource_free(bn, 1);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 9303305733b4..4cc69b6cf30c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -77,6 +77,7 @@ struct tx_cmp {
 	#define CMPL_BASE_TYPE_HWRM_FWD_REQ			0x22UL
 	#define CMPL_BASE_TYPE_HWRM_FWD_RESP			0x24UL
 	#define CMPL_BASE_TYPE_HWRM_ASYNC_EVENT			0x2eUL
+	#define CMPL_BA_TY_HWRM_ASY_EVT	CMPL_BASE_TYPE_HWRM_ASYNC_EVENT
 	#define TX_CMP_FLAGS_ERROR				(1 << 6)
 	#define TX_CMP_FLAGS_PUSH				(1 << 7)
 	u32 tx_cmp_opaque;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index 850e3c67e9ac..360ff6e2fa58 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -377,6 +377,43 @@ static void __bnge_poll_work_done(struct bnge_net *bn, struct bnge_napi *bnapi,
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
@@ -427,8 +464,11 @@ static int __bnge_poll_work(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
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
@@ -546,6 +586,8 @@ int bnge_napi_poll(struct napi_struct *napi, int budget)
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


