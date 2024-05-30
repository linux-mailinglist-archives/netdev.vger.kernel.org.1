Return-Path: <netdev+bounces-99587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7CD8D5650
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 01:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B30284CA3
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 23:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9B618398A;
	Thu, 30 May 2024 23:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJapuffz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCD218397C;
	Thu, 30 May 2024 23:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112186; cv=none; b=YClGm+uPIsGiVVf1/JLGfn046LoS/DwPpu5tdjLAiUeB1oZajuZ6romB15VaYYbuZmAqEmBVXb2kB0Pw0gBH5ecpdLVzx+rYnRB/ZbLUsr8nacZEPjDSb6rglkOBaQfRjkqQhg5rUZvdU8UyGak1L+3rrpOMz/aRf7K1qJlLonY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112186; c=relaxed/simple;
	bh=Tc3mfR659n1UEdqi4bi378GMou0NHGPpevDsK5F2eK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L4dP8afUrKM1m90mQH575wJ01AZpcRCyA8VU7cNf9dnAOe1usGwTV5zU1a+QLUTp1FHGeiQ6aZ0JZpcoYGjJDszGgwLzaOe3Je6SvZ+f8sz2BF0sejbU2glKZ4ZGZCC+jUB1wx7mrMJTCfOrwNFWYQ2PXByqsmx4EiUY0NXl+7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJapuffz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28748C4AF0C;
	Thu, 30 May 2024 23:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717112185;
	bh=Tc3mfR659n1UEdqi4bi378GMou0NHGPpevDsK5F2eK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hJapuffzj+Ah08nz7JesYCuLgG7/6ADXBDTv3ViohtuON8qxHJbSTLm5+M8K5tkWA
	 cop6ZnUrO5EqoQSq4cw0YdUx9bBmKYIH/MJFoMt8aKDvARHu9J5ZSKJSeYh5/Yg4kO
	 5nC8QF3Kpd8iQhz5BztnXw+KXFBKG9AnNJqJk7Ojf/AAE4k+0MynVOnPEUnoXhXgJk
	 rCMAZV+qoqWX0qrBLjybF+nNRi8YK2TjlgTpTNV9ahv0iU1qgrgEXJLYvZ8MTg0ueb
	 07SgCM8sPTS2EKmJRMYV7mmrqsl+1rRGbJIhKT4gBPL3HYNuhjBKdFVDp4lPOFQ3Fr
	 y1CbDKreim89Q==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com,
	pabeni@redhat.com
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	matttbe@kernel.org,
	martineau@kernel.org,
	borisp@nvidia.com,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/3] tcp: add a helper for setting EOR on tail skb
Date: Thu, 30 May 2024 16:36:15 -0700
Message-ID: <20240530233616.85897-3-kuba@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530233616.85897-1-kuba@kernel.org>
References: <20240530233616.85897-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TLS (and hopefully soon PSP will) use EOR to prevent skbs
with different decrypted state from getting merged, without
adding new tests to the skb handling. In both cases once
the connection switches to an "encrypted" state, all subsequent
skbs will be encrypted, so a single "EOR fence" is sufficient
to prevent mixing.

Add a helper for setting the EOR bit, to make this arrangement
more explicit.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/tcp.h    |  9 +++++++++
 net/tls/tls_device.c | 11 ++---------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 32741856da01..08c3b99501cf 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1066,6 +1066,7 @@ static inline bool tcp_skb_can_collapse_to(const struct sk_buff *skb)
 static inline bool tcp_skb_can_collapse(const struct sk_buff *to,
 					const struct sk_buff *from)
 {
+	/* skb_cmp_decrypted() not needed, use tcp_write_collapse_fence() */
 	return likely(tcp_skb_can_collapse_to(to) &&
 		      mptcp_skb_can_collapse(to, from) &&
 		      skb_pure_zcopy_same(to, from));
@@ -2102,6 +2103,14 @@ static inline void tcp_rtx_queue_unlink_and_free(struct sk_buff *skb, struct soc
 	tcp_wmem_free_skb(sk, skb);
 }
 
+static inline void tcp_write_collapse_fence(struct sock *sk)
+{
+	struct sk_buff *skb = tcp_write_queue_tail(sk);
+
+	if (skb)
+		TCP_SKB_CB(skb)->eor = 1;
+}
+
 static inline void tcp_push_pending_frames(struct sock *sk)
 {
 	if (tcp_send_head(sk)) {
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index ab6e694f7bc2..dc063c2c7950 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -231,14 +231,10 @@ static void tls_device_resync_tx(struct sock *sk, struct tls_context *tls_ctx,
 				 u32 seq)
 {
 	struct net_device *netdev;
-	struct sk_buff *skb;
 	int err = 0;
 	u8 *rcd_sn;
 
-	skb = tcp_write_queue_tail(sk);
-	if (skb)
-		TCP_SKB_CB(skb)->eor = 1;
-
+	tcp_write_collapse_fence(sk);
 	rcd_sn = tls_ctx->tx.rec_seq;
 
 	trace_tls_device_tx_resync_send(sk, seq, rcd_sn);
@@ -1067,7 +1063,6 @@ int tls_set_device_offload(struct sock *sk)
 	struct tls_prot_info *prot;
 	struct net_device *netdev;
 	struct tls_context *ctx;
-	struct sk_buff *skb;
 	char *iv, *rec_seq;
 	int rc;
 
@@ -1138,9 +1133,7 @@ int tls_set_device_offload(struct sock *sk)
 	 * SKBs where only part of the payload needs to be encrypted.
 	 * So mark the last skb in the write queue as end of record.
 	 */
-	skb = tcp_write_queue_tail(sk);
-	if (skb)
-		TCP_SKB_CB(skb)->eor = 1;
+	tcp_write_collapse_fence(sk);
 
 	/* Avoid offloading if the device is down
 	 * We don't want to offload new flows after
-- 
2.45.1


