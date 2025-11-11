Return-Path: <netdev+bounces-237732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 023AEC4FC43
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00D73A4F35
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 21:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84534352F92;
	Tue, 11 Nov 2025 20:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AekwG2hf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54B4264612
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 20:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894760; cv=none; b=lftBb9zcAm/CzDb+Gilqccxo/Mh+fFWr2Vc0yTDMGKEj/NulDY01VEcci9fqzPdpX/LYA/U9ErbLghHd+CIIfelgArjYbJp5Dc+gyzrI15Ra42iP3Q481ZnJNS1RCegqbYA2zgMdK+nJX1oqsmUUI5MzwrwQELU/Pcvvx3kfb4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894760; c=relaxed/simple;
	bh=2dT7TDGlrC15m2XrfzBdlAKuJGX3p5VzO4/C1evR7kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zf8fd55HhqU6XQhQNM81R1YUlVcxbEsgWZ+ndQwtC6GLcKqgl4kZm/MxXMeDBp1rqj2UvhkpLa0i+pYAg7B1tU3IhG7O8mJKN/8eiqjYGFSpcqzbbhKqVKgKywVwlJ3Nb8ulcG7l0sa79Lf5TBoxKM1X/bVO3WwsviJQsBsb9o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AekwG2hf; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-297e264528aso1120585ad.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 12:59:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894758; x=1763499558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhBhDYMouQQVQ5LiIxL7eMqigkNt/V1x95UUJwRltOI=;
        b=BKt3bcyRtunOGRK67q42iQWUHRlFGpCGx7lj3mkjoRWRrfVZYr1msYh0ECMHLbsd/a
         nZu70w/KIjB6m1sQNu2lKRnSADKUQikzn1COpJrCh3MPvuZT7j1Z+GWyr0JE9zaHZlXQ
         ipFXirdIUnRCgDWBr42J71mWG2Aa0k27FdleTPTZIpaTYzNYI4638tOvUSRVw42zvZ3S
         fGALo4YECeF8ds7f2R6H7zGRGdSPjNGshZ226pc+OcgIRFpWnoiB61sbWlv2QzW8S1gc
         IvBpYfX7SwxFXXrMpqBGasiKGNOHqlGQ94s1tZo5FUXg54AMQASa9nuX4lsz5Pc3FH+s
         OxkA==
X-Gm-Message-State: AOJu0YzJ0eoUYYN8h4Z5k2EDEOIevZ0QiSogFMqYPWxr/xtJf8yWiELl
	fY5hLqSbZ93UqWP5oSfqS1ut+sAEFU98lv4qIHWNCuCh/6eOGM6VhPACOX42YSdp0PMiSsVnIyC
	KoL0ZC8jQOumrPVeU7TyLBkTGN1O0IyfAk53MVw7sZkZ+eR7rMxmU1m9etn2+8wyr3L7SVYMPAA
	3xTl/B79LM0P2m5WUsS/8jvlrg3RP4vrt1uCuidMU0m8jc936nKd7RX6rEe9H9Flfaw6jgiwIqQ
	U2NIiv29tUT7imeo3LH
X-Gm-Gg: ASbGncsmO6vvQlZxD8dTfUMnHYL6OajWYHx6zaSBx8iL2FRLR1CAD44hF8kunnXEwFA
	ibcka9SMLk4ipGthv2J80FVPffo1ocby6LRuboVQHBhtHpDgkWhNj6gpOMdrjUzTqe6SzFwCk+N
	4G8AyrnH17c1QUuINUNm5C7kRqDZHg6PQbecPTxVck9K4H2lGqpXS2tZ9jTvik7T+wzHxlzgasM
	kEkbvgvmQMLR3UNlJ5x0ZXlA66vqcD8r2qV5QZf2or8uY3I2Hy7dhl9tSrlKi0YyQ7pwv+/bDkU
	X+8ORYvJ3+jEfTRQfRo3wVaBkv1UjPsYQZrWb6mxHmW9CXjNjvkOrSqRHZsVJHwcwRdA7Da4N1r
	x8PlPJcnBcdcHd07y79eSrrTBYdU3Xu4/MeTUz/35DayTDH98O6dXNrar3LLdUQ/s7s6jxEfElY
	NziTgf8ob+EoMoHE0TPfMNdFydK3y7DnRP75aY+V6Y
X-Google-Smtp-Source: AGHT+IEHs+tME8GoFv4OfTQ2BBpRz7HVGBfxzx8VKFZInRBql+Q4gtU3G3W0rutnuqPSGfDhPzaRClYZHyBU
X-Received: by 2002:a17:902:ecc3:b0:295:99f0:6c66 with SMTP id d9443c01a7336-2984edc8ed9mr8658495ad.36.1762894757916;
        Tue, 11 Nov 2025 12:59:17 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2984dcfebf8sm717785ad.31.2025.11.11.12.59.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Nov 2025 12:59:17 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7aeb762bc40so115024b3a.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 12:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762894756; x=1763499556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhBhDYMouQQVQ5LiIxL7eMqigkNt/V1x95UUJwRltOI=;
        b=AekwG2hfz8EU3NvvDEmSEs4ERZcCqXpY5QrCdNjniEfJesdexCygCy8Cj0h8YO+P/6
         hfSDmhaMstxtKdnAMIfJ7eA8CgO+LWV6ayU/8lo5GQapqotpy+asOx+1aCmCENj5rBfy
         FlvPcpoZaIBwRictNSRhpP37TNozolDWHX+NI=
X-Received: by 2002:a05:6a20:5493:b0:352:213a:a22c with SMTP id adf61e73a8af0-3590b02ac3fmr648042637.32.1762894756099;
        Tue, 11 Nov 2025 12:59:16 -0800 (PST)
X-Received: by 2002:a05:6a20:5493:b0:352:213a:a22c with SMTP id adf61e73a8af0-3590b02ac3fmr648019637.32.1762894755654;
        Tue, 11 Nov 2025 12:59:15 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf18b53574sm497131a12.38.2025.11.11.12.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 12:59:15 -0800 (PST)
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
Subject: [net-next 04/12] bng_en: Handle an HWRM completion request
Date: Wed, 12 Nov 2025 02:27:54 +0530
Message-ID: <20251111205829.97579-5-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111205829.97579-1-bhargava.marreddy@broadcom.com>
References: <20251111205829.97579-1-bhargava.marreddy@broadcom.com>
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
index 0b0c398e69a..86f37ca9762 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -18,6 +18,7 @@
 #include <net/page_pool/helpers.h>
 
 #include "bnge.h"
+#include "bnge_hwrm.h"
 #include "bnge_hwrm_lib.h"
 #include "bnge_ethtool.h"
 #include "bnge_rmem.h"
@@ -2318,8 +2319,7 @@ static int bnge_open(struct net_device *dev)
 
 static int bnge_shutdown_nic(struct bnge_net *bn)
 {
-	/* TODO: close_path = 0 until we make NAPI functional */
-	bnge_hwrm_resource_free(bn, 0);
+	bnge_hwrm_resource_free(bn, 1);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index a85c251f7b4..8a881ed800e 100644
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


