Return-Path: <netdev+bounces-114598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2EB942FE4
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 15:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E661F2BA0E
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 13:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E181B1512;
	Wed, 31 Jul 2024 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="uSsA3imR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC00A1B14F9
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 13:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722431752; cv=none; b=mPGsUtSJ13x2k9FlP0K4RYnZV8rE96gboqHbTZJxXTRsprRaGEhcM0Jh7OWEExw4BTuwG1mpNCY+e2eUu2sSobAGXqyfQNu72gb0N5g3QtgGXv9HuiCLan+Y/BTeQxiTSTjP8xDZkd8dAnffBMlSLAXkB/UCBjiSBgdBP+1wN/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722431752; c=relaxed/simple;
	bh=qo1WSz+DwSUqU7HhNHqK7kdtYZRK+oTo7qEoP+pgsvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxrhZwzV5VWOggfFkY097oq+Pqtv9ozJZYCRZbVYu7yvamBXrpe+ngxZBgOAtMgSXV33j//Cwwk6sfVFMFjNS6ZLQzYCgp+XCwBOlZHy4Xc9cB8kFQFDb7PEoZMj3nH616Ac9iUxgG1eBb4J5Hnz48niOlxz1FqTnqRDH0WKAJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=uSsA3imR; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ff3d5c6e9eso13724335ad.1
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 06:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1722431750; x=1723036550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuFr+V/Moo3zBNEjQ8Mn/A7f6EiWmcuh1Yg65Fn2eZ8=;
        b=uSsA3imRVX0PcYZ2L6VUU3Sscmw7lDX89n7Yxd+Gl8lFbAMRWsuNoEqfJostGTinWD
         HAehYJVPrr/s6+5d8zttKoZWQ91Q41QYKD4wfY6Vk6v7cZgs5JmC4mIi15NClg06lt7I
         3asjRLW1aVxUzjqttSkAT2rbL3rSIB/VTWWC1b5oTEaoGt8V2fNdWlREL3dJG0jMDW3f
         ZMuJ+jkXd9F9pfTxQeXCisBAJp7bfXqm0RoE68YmygCG10U5NQqbDoeQUz7U9K+Lly+g
         hYqA4y0xd+GwT7o2d+zOWbt4nMSWk2L10iCsJjLrRR9dYoPj8BkcyRfY0K1BWG6IPT+E
         eEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722431750; x=1723036550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuFr+V/Moo3zBNEjQ8Mn/A7f6EiWmcuh1Yg65Fn2eZ8=;
        b=qsOymifQG70DnpA7ng5LLpOiKTftkL2fJ3CpkQSdd8ZecJnb3gP6BqUFIzlLbtu9B7
         zkICHohFNwBYm3shO+3/LsXzAguN/IMfMFHMiXb3kTU7tVFtkCPhNzMZUX5C2apGtuhQ
         wiZg1AZKSgX9xjh8ueGPw6uj3j+6PdOwgdV9KWGNRtKkPWtlj1q4cP9EtyBc7wG1WsWC
         hRFG1s6JB/8CkZkqfag8XW4PVzlxXfRAzgXNK4P7+0SCE5R8BzN2NyDkaQgFvL/TsP6p
         UFFeRyRIWFDocbcGDUNzPJ38svxYf7TZHyWSfsgqdVblAPuX7cIM21faHj6+t0UMAvc1
         rxUA==
X-Gm-Message-State: AOJu0YyWQq2A9czdA63FWrQXSaFsy4AdTnn3qFBELg4qx/E5lIUjW5Cq
	avS/oHq87k66JbE3iLBQq/lFCmU0BHLChlw6GOjQOBZcsnl/zFmbqCSzKZj8qX6Fxv+t3N54HWs
	9JJY=
X-Google-Smtp-Source: AGHT+IHW0IBl5fFZrLdxUlLX8ZYQqtD5Xmkh8QgTVIucuUD8sqTiyTM7WASWtjkGc1fkM0VQ3EEBEA==
X-Received: by 2002:a17:902:e84a:b0:1fb:35c7:8ea4 with SMTP id d9443c01a7336-1ff04808980mr136504945ad.2.1722431749940;
        Wed, 31 Jul 2024 06:15:49 -0700 (PDT)
Received: from localhost (fwdproxy-prn-116.fbsv.net. [2a03:2880:ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee1241sm120743955ad.172.2024.07.31.06.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:15:49 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next v2 3/4] bnxt_en: stop packet flow during bnxt_queue_stop/start
Date: Wed, 31 Jul 2024 06:15:41 -0700
Message-ID: <20240731131542.3359733-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731131542.3359733-1-dw@davidwei.uk>
References: <20240731131542.3359733-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation when resetting a queue while packets are
flowing puts the queue into an inconsistent state.

There needs to be some synchronisation with the FW. Add calls to
bnxt_hwrm_vnic_update() to set the MRU for both the default and ntuple
vnic during queue start/stop. When the MRU is set to 0, flow is stopped.
Each Rx queue belongs to either the default or the ntuple vnic.

With calling bnxt_hwrm_vnic_update() the calls to napi_enable() and
napi_disable() must be removed for reset to work on a queue that has
active traffic flowing e.g. iperf3.

Co-developed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8822d7a17fbf..ce60c9322fe6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15172,7 +15172,8 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_rx_ring_info *rxr, *clone;
 	struct bnxt_cp_ring_info *cpr;
-	int rc;
+	struct bnxt_vnic_info *vnic;
+	int i, rc;
 
 	rxr = &bp->rx_ring[idx];
 	clone = qmem;
@@ -15197,11 +15198,16 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
 
-	napi_enable(&rxr->bnapi->napi);
-
 	cpr = &rxr->bnapi->cp_ring;
 	cpr->sw_stats->rx.rx_resets++;
 
+	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
+		vnic = &bp->vnic_info[i];
+		vnic->mru = bp->dev->mtu + ETH_HLEN + VLAN_HLEN;
+		bnxt_hwrm_vnic_update(bp, vnic,
+				      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
+	}
+
 	return 0;
 
 err_free_hwrm_rx_ring:
@@ -15213,9 +15219,17 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_rx_ring_info *rxr;
+	struct bnxt_vnic_info *vnic;
+	int i;
+
+	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
+		vnic = &bp->vnic_info[i];
+		vnic->mru = 0;
+		bnxt_hwrm_vnic_update(bp, vnic,
+				      VNIC_UPDATE_REQ_ENABLES_MRU_VALID);
+	}
 
 	rxr = &bp->rx_ring[idx];
-	napi_disable(&rxr->bnapi->napi);
 	bnxt_hwrm_rx_ring_free(bp, rxr, false);
 	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
 	rxr->rx_next_cons = 0;
-- 
2.43.0


