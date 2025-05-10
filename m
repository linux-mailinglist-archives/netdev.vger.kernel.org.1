Return-Path: <netdev+bounces-189475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FE5AB23FF
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 15:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C5A9E0423
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 13:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678F01F4CA4;
	Sat, 10 May 2025 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6y6IHqc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80111EC006
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746884913; cv=none; b=l1A/oqzOC9A878BqSu3aj8tlBvGRPuZkwejsRwQ9zUDBlH4VeaijFwpYo4H7pXOkRp4QjJApca/pgpoBGbzYsxE6hHqDHmh4qm4YZmLUuuycFahLiCdSTw+R2WLi58npnZI8c0wiZgUVTLjLvsCa1gVK8tb04YxWco1bakjDFfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746884913; c=relaxed/simple;
	bh=TmmYol9krogh8kP9X3YdafWkTPppdE4ld65xq/3SgHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qP1luKmyBSjAtuZHeJikJnHW8VAD2V0VZrFzI0OS/0L7mBMfUu+oZOqprLRHPsCGm4Hw0HOAUQyB/BssyosMvZZeT05rn249IKEOqKcsPvOtvdfk3NG3NjevTfB0vY0DABPDA7HXXwQUpqEFy5AYxnK4gdRMJhL3ed7buVdcerk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6y6IHqc; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-73c17c770a7so3716945b3a.2
        for <netdev@vger.kernel.org>; Sat, 10 May 2025 06:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746884911; x=1747489711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2lFo4rU0Ba7jvad7tnnVpuQHRU3WRtEnqr17/6RqbY=;
        b=N6y6IHqcX+bjfBgwKFiM94cPSh5jDTOiwXuc5fzFjg9GEmy6c0EA1wgDx8MLJa56l2
         FqmwTKEA8xN/3HPFLqEHvSbLTPJBTmnPb1w0npH9uRe6/pxzDUmxoDQj4CZmEWkqN9kT
         3AOh91cDXt98ewuPTqSEl23HzHTUfJqpGX+ZkJwgE606nghNbLKnS9Dvvu3UO2w7t/0+
         nRRh0uKr7SfkIi1l7Z4YxUfJ33kEeObHYWaeJqN69GHNtKxgZqnWExNjuI8lHCW6oRuY
         t6Ko+EcxueRVYTW1Rym1DfSK8hetc3XYguo28dpKvJNfth3fPnKMOrsou6cEcWOHofVA
         Sa5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746884911; x=1747489711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2lFo4rU0Ba7jvad7tnnVpuQHRU3WRtEnqr17/6RqbY=;
        b=DWPkCwD+SX2LNpQdMJrPTBKflcvah+n3LPYFMStaaFbMVVdcSI2VJSjkiCswK444RD
         7BLSwYTI2C8Yajuh3ju0J2GKxF+mFx+lbnhWlfJpeRU8ffaSGwUaEBJ1ZpBl88TnyPzn
         yIZltjXjAcub8qRnEho/AEUZ7mWdrbwdAtnzAcKpNWgHc8nOQzIQDIsEdoEwTcL6e9LS
         REQGehJIQ8JlQkKZpOF3eM78o1Pv0FF4fea/04HQ91RtLSm3cgyossYSSlIUI5eNw/D2
         O1KE8bg67FbxVIBjstugd3jZjTxnZKEDAi7W4ijm3lSw1vibfJGY+3AD31W1qVu4/ncR
         AZEA==
X-Forwarded-Encrypted: i=1; AJvYcCWJwZir/sTKSJOalaibNhrIPNURRTnsyDVrrN3B5zDFN6yOJ+cVT3PkhZnl58WvGyUloRMKAeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgYYTzEx6qGqzoQMT9l1Er11t6+eHODzCiNICC7yeMK/x4f8N6
	n72aI8QAxjBKcc9m/n3RJ4FREkdymWQ2oYjMMRzG8RRpBftGnVKx
X-Gm-Gg: ASbGncsvrCpx2UjdOkLbImt+VNX1D39QmNab6QU/GrZvw8Ri+6Vg5sA/tkDhqgj/HjH
	ZDzzol590VYjS0QQU14QWuP/C6WITg8XiCu3g8vGf8oSG1LXROphPYHLzCOg3By0AM0pX6kXQMf
	BhbHWc3028WlFbssCc4KVKJRNZ5tkAjufpWSSdDtF3EoPpgJiTZKHiWnPDRZT89+JHIV/WkGa73
	4EO/i1HLwQxDUmvH+CLUBwO6L3mUxu/+/mAfqZGiMYro0WZdvVWwjyHRO73BgZyHSzgePtmhig/
	8WAH/2dFwHrabIp3zokshLOFoEuLPdX8/r+WqjPjdC2oj4jpnkvruYHv6ssGWp4uiNoVoBxnM7W
	4z9962Aj+FdxIAw==
X-Google-Smtp-Source: AGHT+IEMbAmm46fLf2DuEv+Kvl0O13z6zOYqVX5wWUuEzOYPM3fBcXq+0jclt4XxJpuuYSO1ZkOrxQ==
X-Received: by 2002:a05:6a21:1788:b0:1f5:8655:3287 with SMTP id adf61e73a8af0-215abd23189mr11179733637.40.1746884911027;
        Sat, 10 May 2025 06:48:31 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7423773939fsm3360424b3a.62.2025.05.10.06.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 06:48:30 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	irusskikh@marvell.com,
	bharat@chelsio.com,
	ayush.sawal@chelsio.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 2/3] net: cxgb4: generate software timestamp just before the doorbell
Date: Sat, 10 May 2025 21:48:11 +0800
Message-Id: <20250510134812.48199-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250510134812.48199-1-kerneljasonxing@gmail.com>
References: <20250510134812.48199-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Make sure the call of skb_tx_timestamp is as close as possible to the
doorbell.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/net/ethernet/chelsio/cxgb4/sge.c                     | 5 +++--
 .../net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c   | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index f991a28a71c3..f2d533acb056 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -1533,7 +1533,6 @@ static netdev_tx_t cxgb4_eth_xmit(struct sk_buff *skb, struct net_device *dev)
 	} else {
 		q = &adap->sge.ethtxq[qidx + pi->first_qset];
 	}
-	skb_tx_timestamp(skb);
 
 	reclaim_completed_tx(adap, &q->q, -1, true);
 	cntrl = TXPKT_L4CSUM_DIS_F | TXPKT_IPCSUM_DIS_F;
@@ -1706,6 +1705,8 @@ static netdev_tx_t cxgb4_eth_xmit(struct sk_buff *skb, struct net_device *dev)
 	cpl->len = htons(skb->len);
 	cpl->ctrl1 = cpu_to_be64(cntrl);
 
+	skb_tx_timestamp(skb);
+
 	if (immediate) {
 		cxgb4_inline_tx_skb(skb, &q->q, sgl);
 		dev_consume_skb_any(skb);
@@ -2268,7 +2269,6 @@ static int ethofld_hard_xmit(struct net_device *dev,
 
 	d = &eosw_txq->desc[eosw_txq->last_pidx];
 	skb = d->skb;
-	skb_tx_timestamp(skb);
 
 	wr = (struct fw_eth_tx_eo_wr *)&eohw_txq->q.desc[eohw_txq->q.pidx];
 	if (unlikely(eosw_txq->state != CXGB4_EO_STATE_ACTIVE &&
@@ -2373,6 +2373,7 @@ static int ethofld_hard_xmit(struct net_device *dev,
 		eohw_txq->vlan_ins++;
 
 	txq_advance(&eohw_txq->q, ndesc);
+	skb_tx_timestamp(skb);
 	cxgb4_ring_tx_db(adap, &eohw_txq->q, ndesc);
 	eosw_txq_advance_index(&eosw_txq->last_pidx, 1, eosw_txq->ndesc);
 
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
index e8e460a92e0e..4e2096e49684 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c
@@ -1640,6 +1640,7 @@ static int chcr_ktls_tunnel_pkt(struct chcr_ktls_info *tx_info,
 	cxgb4_write_sgl(skb, &q->q, pos, end, 0, sgl_sdesc->addr);
 	sgl_sdesc->skb = skb;
 	chcr_txq_advance(&q->q, ndesc);
+	skb_tx_timestamp(skb);
 	cxgb4_ring_tx_db(tx_info->adap, &q->q, ndesc);
 	return 0;
 }
@@ -1903,7 +1904,6 @@ static int chcr_ktls_sw_fallback(struct sk_buff *skb,
 	th = tcp_hdr(nskb);
 	skb_offset = skb_tcp_all_headers(nskb);
 	data_len = nskb->len - skb_offset;
-	skb_tx_timestamp(nskb);
 
 	if (chcr_ktls_tunnel_pkt(tx_info, nskb, q))
 		goto out;
-- 
2.43.5


