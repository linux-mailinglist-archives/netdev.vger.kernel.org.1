Return-Path: <netdev+bounces-212196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E2DB1EAC2
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 16:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AE11C260CD
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B847D2836A0;
	Fri,  8 Aug 2025 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2GY9zuk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37CC2820B1;
	Fri,  8 Aug 2025 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664818; cv=none; b=bzKd7dsuNkrRegAm3YhEH01asVjhvXFMkmH/UN2PyV0gJfsbhwoMsAmkvv2fDZ6F3+j9dsblSKtb2hJ42NioNAbwhI7drDFBhH75EKAdLadtzfzjRsrEx7+BeHtWMnI7eovIOY2b6KWnpm0J3Z/oAzfb6LaMt1sQsNjR0unD1wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664818; c=relaxed/simple;
	bh=HJznfjOPVIVAcdG/yijDgFSeUPzX9QrleFENOmhqLx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnJn6Po1eWYawPfT38LwoirHj0imCB2gRTx5W/+QTFBuNDrVL0liQpTQMuVkb/ifM2CpS6nUpUEOrVrDTGuPx1IBqqqZCbk7ZYTvagclid9lRcxWHxP2iS5bDT0TUHPvze26b6xBHT8FgIGRsNgWLC/7Mb9qudvnZent5BcubTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2GY9zuk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-454f428038eso19166735e9.2;
        Fri, 08 Aug 2025 07:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664815; x=1755269615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WCRZzjR9Y1U54BdRr9CdSntDYjrhBbPu4rgTyBmD0U=;
        b=N2GY9zukuTxqivSJuFKIJJsYnMQjrhB6MkFtPy5mPuDjj+8eqaPDIh5Doq3qvSFvCN
         9gYHNI25Edt059Kt+WAIhLXAOrUwsW3/Uonio4jZN+1OzD+/FjHjOuZqvshkAKuYW4nB
         bOTVUk98sShF2VxcvkFau7VVrlVcOSYYJRPt2IiCLXDHFO9eUIIY8Yn1tqwbc3B8SKjX
         jIq9BqI1rtoZ0Sre9SZRtElYDw01JqQ2vU76thHxPcJyAb045F0IwHYL3I0LKQ3WBvK5
         Et80v+8qXULkVEq2zVCSvJBgwkeVt0YMCq6tF0oWHhJGKsSlLnB7Xg9oVgUTMG94h0dx
         5TaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664815; x=1755269615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WCRZzjR9Y1U54BdRr9CdSntDYjrhBbPu4rgTyBmD0U=;
        b=ldyqnl9tcAS5TcWQgujHcog4qZe6to2g/Q69U5/RL0OaJhDkCvZ0EAubfGgXeGuMlf
         BVrIK0vfGtPPLE/IuMXOMm9kNJPko7yz+1Tf41+D60VWEU/gk9Gq19dmwToDfIuc37AV
         Nho0glhq/nZEGN74TbmEcsYPTidFWp8rS8ntB6eJp/y6mVlB9JYt+KBxfAU4i/aOwOV2
         ZY7xc6Glsk380oomsrX0aqQEEN5hR6londhFBxFPcLyC+Xhx9jLJz/jeBSO5fRWFZ9lk
         pZNJ5RGOU9BsEQv97XQt8+3fXLxqSm0++l/Rv0vifoxrvc9FUyMPJH6lRJ0WX9JRi5WD
         Du4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqod6Rw8MTg+gL/N4cqC+1LufLiH1AZYkRZlswfQ3sh0JOFi5qzqWHWwOayrQZUBf51+lX/or5RsH6aQs=@vger.kernel.org, AJvYcCX7cRtYEtghAcEwGCkApRmPuXceiG4yYJ9XqUP9Q1fJ2Tk/KNFNWJbHdSeXvAiXfoMe5U4cbL+f@vger.kernel.org
X-Gm-Message-State: AOJu0Yx65gAQT0bVVj34wModgZKMnGhTdn3z9gc0qLBXRYXDk4ELmQpG
	p+gGEyOwa6tuFWejA3Y1fxDMGJCPXLKYU+1jy50SPPZwX6tJgeNH5oA1
X-Gm-Gg: ASbGnct4Wl1zYzYnC+DBXxTqLQVYcwkvombGH2dfY1zJGnaLls/ID068dSSz/fHkQFL
	xyK4ss/aKb/eaEeVCfj0no9gsEOhAVVlur4ZqHlvQQuNtw5UNBTxOb/0NBtmEicNmqXKo7cKDix
	bDU1dt80UDKEUIAJnO//qYsW0ogyf/+ZXNJ3i6o6TNlCasxQXUMWWMxS9QhaQCQubx5BtHa6/zr
	N6Crp9bVGbRVHIS289Ycm21bbg7PEu5yo4slDAibjuDC1Pp/dDbOK9JJz4iK+AiP/Fake2FE/fa
	MtN8XZ3zUytw/XvMSs+KGP9TkzOuvcLnU3Ed8p2SwnydvgqJm5yZtuovKSko7O0y9ONK+HeCQfy
	9lIXDcg==
X-Google-Smtp-Source: AGHT+IFvOLBbq0CtPJBCaK0yQcO0BYO8elt06NdTDE/CBSyGPSNYVuG9wWWZkyZGI+j18maNytSwDQ==
X-Received: by 2002:a05:600c:8b4b:b0:456:1c4a:82ca with SMTP id 5b1f17b1804b1-459f4f3dc8emr30947185e9.32.1754664814661;
        Fri, 08 Aug 2025 07:53:34 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:a360])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e58400f5sm135106725e9.2.2025.08.08.07.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:53:33 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: asml.silence@gmail.com,
	Eric Dumazet <edumazet@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	michael.chan@broadcom.com,
	dtatulea@nvidia.com,
	ap420073@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC v2 03/24] net: ethtool: report max value for rx-buf-len
Date: Fri,  8 Aug 2025 15:54:26 +0100
Message-ID: <25b5e549975f0af88183adb2712db147bcecfb2c.1754657711.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754657711.git.asml.silence@gmail.com>
References: <cover.1754657711.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Unlike most of our APIs the rx-buf-len param does not have an associated
max value. In theory user could set this value pretty high, but in
practice most NICs have limits due to the width of the length fields
in the descriptors.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 Documentation/netlink/specs/ethtool.yaml                  | 4 ++++
 Documentation/networking/ethtool-netlink.rst              | 1 +
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c | 3 ++-
 include/linux/ethtool.h                                   | 2 ++
 include/uapi/linux/ethtool_netlink_generated.h            | 1 +
 net/ethtool/rings.c                                       | 5 +++++
 6 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 1063d5d32fea..77627f1ec54e 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -449,6 +449,9 @@ attribute-sets:
       -
         name: hds-thresh-max
         type: u32
+      -
+        name: rx-buf-len-max
+        type: u32
 
   -
     name: mm-stat
@@ -2046,6 +2049,7 @@ operations:
             - rx-jumbo
             - tx
             - rx-buf-len
+            - rx-buf-len-max
             - tcp-data-split
             - cqe-size
             - tx-push
diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index cae372f719d1..05a7f6b3f945 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -902,6 +902,7 @@ Kernel response contents:
   ``ETHTOOL_A_RINGS_RX_JUMBO``              u32     size of RX jumbo ring
   ``ETHTOOL_A_RINGS_TX``                    u32     size of TX ring
   ``ETHTOOL_A_RINGS_RX_BUF_LEN``            u32     size of buffers on the ring
+  ``ETHTOOL_A_RINGS_RX_BUF_LEN_MAX``        u32     max size of rx buffers
   ``ETHTOOL_A_RINGS_TCP_DATA_SPLIT``        u8      TCP header / data split
   ``ETHTOOL_A_RINGS_CQE_SIZE``              u32     Size of TX/RX CQE
   ``ETHTOOL_A_RINGS_TX_PUSH``               u8      flag of TX Push mode
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
index 998c734ff839..1c8a7ee2e459 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
@@ -377,6 +377,7 @@ static void otx2_get_ringparam(struct net_device *netdev,
 	ring->tx_max_pending = Q_COUNT(Q_SIZE_MAX);
 	ring->tx_pending = qs->sqe_cnt ? qs->sqe_cnt : Q_COUNT(Q_SIZE_4K);
 	kernel_ring->rx_buf_len = pfvf->hw.rbuf_len;
+	kernel_ring->rx_buf_len_max = 32768;
 	kernel_ring->cqe_size = pfvf->hw.xqe_size;
 }
 
@@ -399,7 +400,7 @@ static int otx2_set_ringparam(struct net_device *netdev,
 	/* Hardware supports max size of 32k for a receive buffer
 	 * and 1536 is typical ethernet frame size.
 	 */
-	if (rx_buf_len && (rx_buf_len < 1536 || rx_buf_len > 32768)) {
+	if (rx_buf_len && (rx_buf_len < 1536)) {
 		netdev_err(netdev,
 			   "Receive buffer range is 1536 - 32768");
 		return -EINVAL;
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index de5bd76a400c..9267bac16195 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -77,6 +77,7 @@ enum {
 /**
  * struct kernel_ethtool_ringparam - RX/TX ring configuration
  * @rx_buf_len: Current length of buffers on the rx ring.
+ * @rx_buf_len_max: Max length of buffers on the rx ring.
  * @tcp_data_split: Scatter packet headers and data to separate buffers
  * @tx_push: The flag of tx push mode
  * @rx_push: The flag of rx push mode
@@ -89,6 +90,7 @@ enum {
  */
 struct kernel_ethtool_ringparam {
 	u32	rx_buf_len;
+	u32	rx_buf_len_max;
 	u8	tcp_data_split;
 	u8	tx_push;
 	u8	rx_push;
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index e3b8813465d7..8b293d3499f1 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -192,6 +192,7 @@ enum {
 	ETHTOOL_A_RINGS_TX_PUSH_BUF_LEN_MAX,
 	ETHTOOL_A_RINGS_HDS_THRESH,
 	ETHTOOL_A_RINGS_HDS_THRESH_MAX,
+	ETHTOOL_A_RINGS_RX_BUF_LEN_MAX,
 
 	__ETHTOOL_A_RINGS_CNT,
 	ETHTOOL_A_RINGS_MAX = (__ETHTOOL_A_RINGS_CNT - 1)
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


