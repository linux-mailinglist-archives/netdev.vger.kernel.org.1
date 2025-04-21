Return-Path: <netdev+bounces-184451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2A6A9595B
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B196B7A63EC
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51896224241;
	Mon, 21 Apr 2025 22:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueY9PjDF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC2E224237
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274516; cv=none; b=jBn1YQBiSfu/Cn5YqBWTomTTdMCQtTJluw8i7Hf+NYt1FBafG3UPBSmdIgbYr1jtuBbGMkTYPZFTXZmoXE4OBEzCm2J6EC/4ZF7nNfhTcIV3uQI146lglEdSGFlCkhjVg9YUwgQgKlkA8irLI8F7FQjZyMPJj3KeWMqMkQLT9vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274516; c=relaxed/simple;
	bh=DbyHeTaDvY5Z5FBS9DAKit/hcQei+3skr01rXh5nnNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYuKx+bpgMOi+ftH2hh58NdgmmTsp1VWiExCmwPX50I1vdnNskeP1/GgjxX6QKQCLrabG61VliBcQyUP9LXbjimh6SdnBV9UKimdj0the6GuSCSz55H4yUjJSgCSFHwglSPBgfTNMqBwEteYHbTKB/jvEzRQz7/lhtFM6gdBg8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueY9PjDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4D7C4CEEF;
	Mon, 21 Apr 2025 22:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274515;
	bh=DbyHeTaDvY5Z5FBS9DAKit/hcQei+3skr01rXh5nnNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ueY9PjDFpNcHSWfABoc/52BHesCMaGgxRWQwq9ihYmHE/68EjIuBNoU6t7/K/sN2a
	 qPcgyXqLSyqW00n+JcI6F+b1A9JgQEh7Uh08yZ17tPGJC1q20TyfWeS6e23xiAWNFT
	 UHIxuWgzrjaV3Ym/sVt6m9rR+l2mlhwsE/WPCj5u2aeaV8CPHomryDInI8U4787Kmg
	 qSc88pNLJLC3QdunV2RBOMmXGyYjMRzu5ohKlDAfqvfqjplcPiM6/COnzexI3gXVQY
	 gXKNN4xlO5ECvQTcrujL0VvCFJFVjnumoftjDnQlsYF6INSJwRmMxrL6+S7WQhG0Sq
	 2WqqlmQcU5q9w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	asml.silence@gmail.com,
	ap420073@gmail.com,
	jdamato@fastly.com,
	dtatulea@nvidia.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 02/22] net: ethtool: report max value for rx-buf-len
Date: Mon, 21 Apr 2025 15:28:07 -0700
Message-ID: <20250421222827.283737-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421222827.283737-1-kuba@kernel.org>
References: <20250421222827.283737-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike most of our APIs the rx-buf-len param does not have an associated
max value. In theory user could set this value pretty high, but in
practice most NICs have limits due to the width of the length fields
in the descriptors.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/ethtool.yaml                  | 4 ++++
 Documentation/networking/ethtool-netlink.rst              | 1 +
 include/linux/ethtool.h                                   | 2 ++
 include/uapi/linux/ethtool_netlink_generated.h            | 1 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 3 ++-
 net/ethtool/rings.c                                       | 5 +++++
 6 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 655d8d10fe24..3c09bfc206e1 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -338,6 +338,9 @@ uapi-header: linux/ethtool_netlink_generated.h
       -
         name: hds-thresh-max
         type: u32
+      -
+        name: rx-buf-len-max
+        type: u32
 
   -
     name: mm-stat
@@ -1781,6 +1784,7 @@ uapi-header: linux/ethtool_netlink_generated.h
             - rx-jumbo
             - tx
             - rx-buf-len
+            - rx-buf-len-max
             - tcp-data-split
             - cqe-size
             - tx-push
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index eaa9c17a3cb1..b7a99dfdffa9 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -893,6 +893,7 @@ Gets ring sizes like ``ETHTOOL_GRINGPARAM`` ioctl request.
   ``ETHTOOL_A_RINGS_RX_JUMBO``              u32     size of RX jumbo ring
   ``ETHTOOL_A_RINGS_TX``                    u32     size of TX ring
   ``ETHTOOL_A_RINGS_RX_BUF_LEN``            u32     size of buffers on the ring
+  ``ETHTOOL_A_RINGS_RX_BUF_LEN_MAX``        u32     max size of rx buffers
   ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT``        u8      TCP header / data split
   ``ETHTOOL_A_RINGS_CQE_SIZE``              u32     Size of TX/RX CQE
   ``ETHTOOL_A_RINGS_TX_PUSH``               u8      flag of TX Push mode
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 7edb5f5e7134..1f61f03f354e 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -72,6 +72,7 @@ enum {
 /**
  * struct kernel_ethtool_ringparam - RX/TX ring configuration
  * @rx_buf_len: Current length of buffers on the rx ring.
+ * @rx_buf_len_max: Max length of buffers on the rx ring.
  * @tcp_data_split: Scatter packet headers and data to separate buffers
  * @tx_push: The flag of tx push mode
  * @rx_push: The flag of rx push mode
@@ -84,6 +85,7 @@ enum {
  */
 struct kernel_ethtool_ringparam {
 	u32	rx_buf_len;
+	u32	rx_buf_len_max;
 	u8	tcp_data_split;
 	u8	tx_push;
 	u8	rx_push;
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index fe24c3459ac0..5a6393c0975f 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -157,6 +157,7 @@ enum {
 	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,
 	ETHTOOL_A_RINGS_HDS_THRESH,
 	ETHTOOL_A_RINGS_HDS_THRESH_MAX,
+	ETHTOOL_A_RINGS_RX_BUF_LEN_MAX,
 
 	__ETHTOOL_A_RINGS_CNT,
 	ETHTOOL_A_RINGS_MAX = (__ETHTOOL_A_RINGS_CNT - 1)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 010385b29988..2466fe04b642 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -376,6 +376,7 @@ static void otx2_get_ringparam(struct net_device *netdev,
 	ring->tx_max_pending = Q_COUNT(Q_SIZE_MAX);
 	ring->tx_pending = qs->sqe_cnt ? qs->sqe_cnt : Q_COUNT(Q_SIZE_4K);
 	kernel_ring->rx_buf_len = pfvf->hw.rbuf_len;
+	kernel_ring->rx_buf_len_max = 32768;
 	kernel_ring->cqe_size = pfvf->hw.xqe_size;
 }
 
@@ -398,7 +399,7 @@ static int otx2_set_ringparam(struct net_device *netdev,
 	/* Hardware supports max size of 32k for a receive buffer
 	 * and 1536 is typical ethernet frame size.
 	 */
-	if (rx_buf_len && (rx_buf_len < 1536 || rx_buf_len > 32768)) {
+	if (rx_buf_len && (rx_buf_len < 1536)) {
 		netdev_err(netdev,
 			   "Receive buffer range is 1536 - 32768");
 		return -EINVAL;
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index aeedd5ec6b8c..5e872ceab5dd 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -105,6 +105,9 @@ static int rings_fill_reply(struct sk_buff *skb,
 			  ringparam->tx_pending)))  ||
 	    (kr->rx_buf_len &&
 	     (nla_put_u32(skb, ETHTOOL_A_RINGS_RX_BUF_LEN, kr->rx_buf_len))) ||
+	    (kr->rx_buf_len_max &&
+	     (nla_put_u32(skb, ETHTOOL_A_RINGS_RX_BUF_LEN_MAX,
+			  kr->rx_buf_len_max))) ||
 	    (kr->tcp_data_split &&
 	     (nla_put_u8(skb, ETHTOOL_A_RINGS_TCP_DATA_SPLIT,
 			 kr->tcp_data_split))) ||
@@ -281,6 +284,8 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		err_attr = tb[ETHTOOL_A_RINGS_TX];
 	else if (kernel_ringparam.hds_thresh > kernel_ringparam.hds_thresh_max)
 		err_attr = tb[ETHTOOL_A_RINGS_HDS_THRESH];
+	else if (kernel_ringparam.rx_buf_len > kernel_ringparam.rx_buf_len_max)
+		err_attr = tb[ETHTOOL_A_RINGS_RX_BUF_LEN];
 	else
 		err_attr = NULL;
 	if (err_attr) {
-- 
2.49.0


