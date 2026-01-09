Return-Path: <netdev+bounces-248474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D832D08EF4
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 12:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7BE53059E80
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 11:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E1E35BDDD;
	Fri,  9 Jan 2026 11:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXe9VPz5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E08B35B142
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 11:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767958160; cv=none; b=GWSP5pOug6dWhbUY+R2wcUQCMo5SjO6aDVqwV7X0xWdG+aluiUEFBi/vKs1gUPEwXvac1Xy4UFPA8JPz6aV4GjV45bGzips9r5kTZE+NZR7x1abKCHiyTv245O19s46iFcG8U75vQU/c89cHJzxpKoS22gN/a/r51w6JHTRQp6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767958160; c=relaxed/simple;
	bh=F6waAxUTN0XHkxjyQT+jUXiZnFRXTIpv+p7I9hYKiIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLYdBcxKiadKcezVUqzVErsiRHz2aA3Y6mivaftromaPZYmA9u7ka7EIx5+/ezXot2Tj4izPn9eFAi9tcRSlosS5NIN5akxTt1GVcGsQ0uHjqflv+TQ8bEmHrMFJGlKzf5Con67FjShJQ2yguKdNDg62kgBe9SwQbaMNRdGNSXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXe9VPz5; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so36786255e9.3
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 03:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767958153; x=1768562953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkGYuXz+QxHGRROmceDvRDL3xnFuc5UQrONsfTFdwcU=;
        b=hXe9VPz5zpwUdxHdQiNA7nI7D89AQSveggNCgVpkqkyCGsukQrI2unq7opkC9S70QQ
         Ma3zfkPfDUchjPMEWupLTGaO52psc0mwkWd9sHH0rVDMpJ/s47PPp/C/qQYRoWs5cWOw
         p0zwWsuRel4KPLiXU1oykrX0YVN3ZClfZLk69wJYfhTz2dgqJjX5InV/gzoij6MTQFzj
         ZZcTi2drf7HmcEjpmvWNx1GOynGzLktFNmg/od6VyS2UB7nPosKJXOSHbHPMZufx9OxL
         CuzbUvqb6Ugpd5rIAnXpo+GMO05CiFtWBfNlTCgqkedlFa8dFNmiVxO9h0hHzAqwFhRW
         NJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767958153; x=1768562953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HkGYuXz+QxHGRROmceDvRDL3xnFuc5UQrONsfTFdwcU=;
        b=nshKpAISbaxDVeA6B2zAwxyzREN7YebprlJapuexAjc1Cp0N7f4x+pRWi08iYS2KJJ
         oqQy6Y0iNRNEiegwrAR3ZBfefATJaq2znOE0DagpW2xvTVxH8UJNTSfmd6p03K/eXO6T
         jJAx2SMY5/XmC01xyPwbvlPVkZ12UaBqiYJf/OUdAhspKtN6J29lMfm4FXZYdALaf7PP
         EgyIgqVPrLVNZZ8IszvoI52XLQK5NK0eb9zYLpbxgo8sPJwAyt8RPc4fmT8QrdpmCGdR
         P6zGZCnwrKAHLc4eD/33yLIdQ2IiKBPmYmoLCM39bzQoAYUKFcCHmKi/akw2+DYvB7t7
         UCNA==
X-Gm-Message-State: AOJu0Yy/uvousdMMzNT/jzP0O3ihFjqgUO/UphGYMdzx7y/XBP3Qk2Fr
	i/1hQiXYlmySMGsjhZn2p1EySMpHTwfPLhLNxo0e+vZyPkk2nYpdmL1qAGiiHA==
X-Gm-Gg: AY/fxX7/2V8CpLf/XqtUbtyVJ7V//cE65isYdcdyGm42ypFZUeJBomhVfrgW8kC/wnP
	syd3VJoQZp2nhMRuopkWXkZuDPLF4zjDAhHvCwoimvyUmzzsZ8OUKo8YWDDlPdqQWyX04p8BBIy
	mBoxBai1PSoGTXkVBL3cIqENYaSq13jW8Sb8ZzDX3KAhDRxA3KQdRxTgDBkexteuTqHI2PhWZOe
	ZoXKc8dltIfUcWQRqrldIU8WUshDZRtR6zgI7Xru2jd9xthk4ionjlVu2zns5IqDCa5RnQ+ExLi
	d5FN3RU7NcRIr+8YGnehX69xNNliI2aXkv+DzBrwolS1xDcLM2bv0m4mXEDN2py+UEkjnmeW4o0
	EXL3LvuERLiY7sHSVN6hMqvlvX3eN38FQLGovSF6Ubj5sZfiYD6tUil2dkDCIV44ELbdd7xrR2l
	uHHwnCpkvTcXxpgHzN9IRvRC/a6Fy8bmbhhKj7h/tFxCZifhZ5mbnjhV0OSkr0XQI8pV3KH5m4y
	es5jUTi
X-Google-Smtp-Source: AGHT+IFSy1+lFxUURQmqDSNKN0HOOFkFOx1ujyLXJg2nypF43Lq0YrQtt9+vrxTHS0Rrgmo+7XmdqQ==
X-Received: by 2002:a05:600c:1d14:b0:477:97c7:9be7 with SMTP id 5b1f17b1804b1-47d84b0a7bdmr104836275e9.1.1767958152875;
        Fri, 09 Jan 2026 03:29:12 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:69b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8636c610sm60056985e9.0.2026.01.09.03.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 03:29:12 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Ankit Garg <nktgrg@google.com>,
	Tim Hostetler <thostet@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	John Fraker <jfraker@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Joe Damato <joe@dama.to>,
	Mina Almasry <almasrymina@google.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Yue Haibing <yuehaibing@huawei.com>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dtatulea@nvidia.com,
	io-uring@vger.kernel.org
Subject: [PATCH net-next v8 7/9] eth: bnxt: support qcfg provided rx page size
Date: Fri,  9 Jan 2026 11:28:46 +0000
Message-ID: <28028611f572ded416b8ab653f1b9515b0337fba.1767819709.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1767819709.git.asml.silence@gmail.com>
References: <cover.1767819709.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support for qcfg provided rx page sizes. For that, implement
the ndo_default_qcfg callback and validate the config on restart. Also,
use the current config's value in bnxt_init_ring_struct to retain the
correct size across resets.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 36 ++++++++++++++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 +
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 137e348d2b9c..3ffe4fe159d3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4325,6 +4325,7 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 		struct bnxt_rx_ring_info *rxr;
 		struct bnxt_tx_ring_info *txr;
 		struct bnxt_ring_struct *ring;
+		struct netdev_rx_queue *rxq;
 
 		if (!bnapi)
 			continue;
@@ -4342,7 +4343,8 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 		if (!rxr)
 			goto skip_rx;
 
-		rxr->rx_page_size = BNXT_RX_PAGE_SIZE;
+		rxq = __netif_get_rx_queue(bp->dev, i);
+		rxr->rx_page_size = rxq->qcfg.rx_page_size;
 
 		ring = &rxr->rx_ring_struct;
 		rmem = &ring->ring_mem;
@@ -15932,6 +15934,29 @@ static const struct netdev_stat_ops bnxt_stat_ops = {
 	.get_base_stats		= bnxt_get_base_stats,
 };
 
+static void bnxt_queue_default_qcfg(struct net_device *dev,
+				    struct netdev_queue_config *qcfg)
+{
+	qcfg->rx_page_size = BNXT_RX_PAGE_SIZE;
+}
+
+static int bnxt_validate_qcfg(struct bnxt *bp, struct netdev_queue_config *qcfg)
+{
+	/* Older chips need MSS calc so rx_page_size is not supported */
+	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS) &&
+	     qcfg->rx_page_size != BNXT_RX_PAGE_SIZE)
+		return -EINVAL;
+
+	if (!is_power_of_2(qcfg->rx_page_size))
+		return -ERANGE;
+
+	if (qcfg->rx_page_size < BNXT_RX_PAGE_SIZE ||
+	    qcfg->rx_page_size > BNXT_MAX_RX_PAGE_SIZE)
+		return -ERANGE;
+
+	return 0;
+}
+
 static int bnxt_queue_mem_alloc(struct net_device *dev,
 				struct netdev_queue_config *qcfg,
 				void *qmem, int idx)
@@ -15944,6 +15969,10 @@ static int bnxt_queue_mem_alloc(struct net_device *dev,
 	if (!bp->rx_ring)
 		return -ENETDOWN;
 
+	rc = bnxt_validate_qcfg(bp, qcfg);
+	if (rc < 0)
+		return rc;
+
 	rxr = &bp->rx_ring[idx];
 	clone = qmem;
 	memcpy(clone, rxr, sizeof(*rxr));
@@ -15955,6 +15984,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev,
 	clone->rx_sw_agg_prod = 0;
 	clone->rx_next_cons = 0;
 	clone->need_head_pool = false;
+	clone->rx_page_size = qcfg->rx_page_size;
 
 	rc = bnxt_alloc_rx_page_pool(bp, clone, rxr->page_pool->p.nid);
 	if (rc)
@@ -16081,6 +16111,8 @@ static void bnxt_copy_rx_ring(struct bnxt *bp,
 	src_ring = &src->rx_agg_ring_struct;
 	src_rmem = &src_ring->ring_mem;
 
+	dst->rx_page_size = src->rx_page_size;
+
 	WARN_ON(dst_rmem->nr_pages != src_rmem->nr_pages);
 	WARN_ON(dst_rmem->page_size != src_rmem->page_size);
 	WARN_ON(dst_rmem->flags != src_rmem->flags);
@@ -16235,6 +16267,8 @@ static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
 	.ndo_queue_mem_free	= bnxt_queue_mem_free,
 	.ndo_queue_start	= bnxt_queue_start,
 	.ndo_queue_stop		= bnxt_queue_stop,
+	.ndo_default_qcfg	= bnxt_queue_default_qcfg,
+	.supported_params	= QCFG_RX_PAGE_SIZE,
 };
 
 static void bnxt_remove_one(struct pci_dev *pdev)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 4c880a9fba92..d245eefbbdda 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -760,6 +760,7 @@ struct nqe_cn {
 #endif
 
 #define BNXT_RX_PAGE_SIZE (1 << BNXT_RX_PAGE_SHIFT)
+#define BNXT_MAX_RX_PAGE_SIZE BIT(15)
 
 #define BNXT_MAX_MTU		9500
 
-- 
2.52.0


