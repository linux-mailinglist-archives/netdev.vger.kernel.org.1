Return-Path: <netdev+bounces-246902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A11B8CF236C
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 08:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39EB830719E0
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 07:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF46626C39F;
	Mon,  5 Jan 2026 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LF4fU+1d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA327FD6E
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767597765; cv=none; b=CjqAgqca+QsV5s/SkyyU3NtPZ7FH4Vlly0VvQqrOCKYz4PdWDekne1WuHVyWeQ2tu378qzcnwHfPwpOWmORZe0zRXi/I+03g8DxcJBrl/WxoSlJzl2S8h415gqBZ8KWCGBtMYNInZXhIUk20pIjBUxr0JIcALhBw1Dt8NT/Yh2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767597765; c=relaxed/simple;
	bh=/wME24CEwrWAEU21ThjVbixPTVFQSGmJJfmADqMDWp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/D49q/IQA2fCNGifNYh7PdwEszeP/Xes7wmjrp3dYtaEW4zarQ8z+k8iI7gnibaTGeX/i/gCLb8pcXXZv5SpP3LbaOzozbkpxwGnH7oMADtW9RqzAJrcUgCC8yiLbtA/fvYTjLkZDPGPCcSROtAfG5YrIrQjR5zLPt5epEsD2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LF4fU+1d; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-6447743ce90so12597052d50.2
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 23:22:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767597762; x=1768202562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x9hftn4favyaNi5RDxua41GjYksofMa+nNP6S0BT7ZM=;
        b=e7p7WaSPI4Eontv6i4z4YwRtcT91rjZDss3nu5jnoEytFObh798jP4/Xvad4zl7qCC
         Abum+j4r7VUbB1EfuA5SAxWF+EoHm/A5WadUlMQd1UCX3DKfLFK2AeC0jBpyKpYy2GF2
         UjarlqEnSwGCUCUa4HGXU4h8YWf9YmuRU2keFcAScnYp9p9+BpHKdsctXlpLaOMP1UO4
         w/EfPiretLwTUER9JjMCtlI21XP6bjkm+671vNLT5B1vxN6QJCqLzLQvLBHOZJh2xWIO
         RaNqEFo+S0vOMNUp4U+7/7BtHbqYRtBLfHntE/CfnG2aJ6jgrogi7Xk5UWI8Y6NmSoS+
         YI9Q==
X-Gm-Message-State: AOJu0YygRxlk/Xd1lJ2yq/pokYwBtN1DQnXr297uZlcjlfeErMo7GCN7
	TKcCdRmk2vzrNcMDuuFXbwJz5Y/+zzL+BB98TPzIY+Zie9usDso9TsprUXtvoNt8yJJX6gp8QpS
	0A51zdlcdsB2XetM8hPr/WKWKt7+2XdMVD44cgH7mT1SvMzkN/nHLptd4/OtwJom9o0NM88iDBO
	UVWWuB5/+fZkDe++TJ3IPKgrl/4kpVNbEy2JPyB+VuuP7vVmClrIpNEzH64MDOmNFwYdw3PcYCw
	0jF8A4weCiXE70bVs5d
X-Gm-Gg: AY/fxX6HcLvJ/DrS6mPrH4Kxjbcd4DxYnpOd0k3PX9fDyBf/5VdeF3gX7+bNrnM357X
	mIM37G7WMui6wplCCT3JnC60LjoGdJHp6vwNDNiWQXr0Mo3pLJHbdH4xKYnhFu1yCYzDrjunwk2
	eB2Cq6Z06+sGZyktZ1BvcDgjjv/+bavhz2wxl5NM4cYorqQ9JnkxjKsoyNeusWFVnjYl33j1cXU
	3+AnkMDIw4hojTrS6KGgto6iLS6sE6DeTWfJ6osYoyLFlIfQeSjhD5R1LwECD/Aix2QRlv13C8F
	ol7nw7ti84kQ0DcRLoVJ1lKsWDIo6DQsdk4I8krZvEB3hDgpVm6GXQt9GCpwMJPxBJ44Z3joFqW
	FwmoCBZYQnUVqr2z6GbPmT9YE3i9KdQt7mZNwJDURumFe/wXkSTVf41eKcvYbiKnSXuuMykeGdQ
	x4pHwmkcZx8W+MhSH74T2TBF3KL/pP72KwWB/KlKo2jq7YHRx8f1XURA==
X-Google-Smtp-Source: AGHT+IGlYLKW8DKsa/N4FaqAH49KLnI9i9WASscAMLLJECL/C9SO9aniCSlzhwTGGsKhGkGvDkixWR9IXrfL
X-Received: by 2002:a05:690e:1485:b0:644:774a:96b8 with SMTP id 956f58d0204a3-6467300a0f5mr35127425d50.82.1767597761883;
        Sun, 04 Jan 2026 23:22:41 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6466a94eeaesm2454852d50.13.2026.01.04.23.22.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Jan 2026 23:22:41 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7ba92341f38so14802902b3a.0
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 23:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767597760; x=1768202560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9hftn4favyaNi5RDxua41GjYksofMa+nNP6S0BT7ZM=;
        b=LF4fU+1dfq4+26hkQF0cfxhsKbDHCjvJpWjfzvfJZ4xLqyVAtWxSLqUtr4eI8N2xAJ
         l6knhSxY/UJM+f9955vOVaF/hyyJqgTQZZXyT4qPhInpBvxVhiSLe72KpW0301zWNuBT
         pj5iA3thRFSa74l4Jc/LWilnPoZO1MKOVZpaA=
X-Received: by 2002:a05:6a00:430a:b0:7a2:7bdd:cbe8 with SMTP id d2e1a72fcca58-7ff655b041bmr39061220b3a.18.1767597759854;
        Sun, 04 Jan 2026 23:22:39 -0800 (PST)
X-Received: by 2002:a05:6a00:430a:b0:7a2:7bdd:cbe8 with SMTP id d2e1a72fcca58-7ff655b041bmr39061202b3a.18.1767597759470;
        Sun, 04 Jan 2026 23:22:39 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfab836sm47293293b3a.36.2026.01.04.23.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 23:22:39 -0800 (PST)
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
Subject: [v4, net-next 3/7] bng_en: Handle an HWRM completion request
Date: Mon,  5 Jan 2026 12:51:39 +0530
Message-ID: <20260105072143.19447-4-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260105072143.19447-1-bhargava.marreddy@broadcom.com>
References: <20260105072143.19447-1-bhargava.marreddy@broadcom.com>
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
index 7533c382714e..ad29c489cc88 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2299,8 +2299,7 @@ static int bnge_open(struct net_device *dev)
 
 static int bnge_shutdown_nic(struct bnge_net *bn)
 {
-	/* TODO: close_path = 0 until we make NAPI functional */
-	bnge_hwrm_resource_free(bn, 0);
+	bnge_hwrm_resource_free(bn, 1);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 04989908b133..b5c3284ee0b6 100644
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
index db49a92542c0..fb29465f3c72 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -390,6 +390,43 @@ static void __bnge_poll_work_done(struct bnge_net *bn, struct bnge_napi *bnapi,
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
@@ -440,8 +477,11 @@ static int __bnge_poll_work(struct bnge_net *bn, struct bnge_cp_ring_info *cpr,
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
@@ -559,6 +599,8 @@ int bnge_napi_poll(struct napi_struct *napi, int budget)
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


