Return-Path: <netdev+bounces-288690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHlvGVJhCWpOXgQAu9opvQ
	(envelope-from <netdev+bounces-288690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:33:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C41455F85E
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 08:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7817830054D5
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 06:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046FE2DFA2F;
	Sun, 17 May 2026 06:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFPVz0CT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819F42853F8
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778999630; cv=none; b=qB+63b4mfcyfV0rdx6KdQPDq4M0ZU2gLq/WkA14bsHqbWQGBq193sLQew/E2Fh2N+s3mKyRy4jz7gPfPhiiyYq1O1Br73nOn1OSAJZfDoiWdbdBePO3uwwc913k045Vu83oI7bNHcvgYdc3lxt2/rtM21hBUWzv9WhGkuVlEiRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778999630; c=relaxed/simple;
	bh=SfJL8LPr6GDe/OJHPFWr3tFTOY3oYhXDoBP3xAEQFZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OvYGt39XNQes17CElsRoCDJa7YGhsMbtHDRupL+B0wek8vm/uTtVQUqHA8taTjFxBtT0zywGI9AFQRMRWf6OMeF2wIgXt018frJjMnDUg6E0x9vTClhYzgXejWGek9+ZKDhAL35kXpLd+980jCozkkIFQxoa0NgzgzeQvxMqi+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFPVz0CT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bd80b3aa13so7268765ad.0
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 23:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778999629; x=1779604429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIm5luJhGoab49QPoC2ghLiKrO+q0wci/8m1qO+0CIs=;
        b=LFPVz0CTnabNV70QkHAtoy44q6rQUs49dTNMFBysffpLfi2vOyf1eOp3jbwx0kCYx+
         G5lfjak2NYhbubdCBczPUfh0UWdLyee8PWNVtGjn7x6PaElKoLcYzTlBZG8kfw1XCzNt
         vwmXjOYzbcBa5bzxxNkcG6E1mQQHW0Oe79xigVIH5l9NpICRSBf9y7ToHlOcUJ6J/7dK
         gcUCNGz8teQUy2P2loek+IKezPOB9snEKEuvMWlnhQfaYxyg0B3tuMOvWs+alkJUrCco
         9hOexUpwnuMMuW3LPPldSZr1+LRyNq1sKktZo1AdCPMxL1knTKIfyqiRt4Kl0zdOE8vO
         OKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778999629; x=1779604429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hIm5luJhGoab49QPoC2ghLiKrO+q0wci/8m1qO+0CIs=;
        b=DWN69k5EykYYRt33FaiA4URMhbRnaxWHAf69X0adUwZSfPAThlMprO99jVta24g70Q
         B4oEB+zwz/wFY9TRuVu4iCypSBaEGXN5VyM71d57QlerQTxwDDCUHByCpKucPyNpAl0K
         gtR1bgr6chzRMUQfLTCZQXCWJk9UNFTO70Y+oAjjYoPeWtX0qko5PLLLncvlujG2xRTQ
         rd6WvPItdXO98Hqw7gmAVhkke5wr1vYLu2ar2ezb3WA7ie9J3wWLFRl3Ht41pci/bPtu
         z1DV7yqMY3ut+qxWPL+Px4tfZuAxfHqEd4LTb+U9Do3UP3S2GmChkd5bkC6RwgGR2nRf
         o6ug==
X-Forwarded-Encrypted: i=1; AFNElJ++53LaLIylmT3TA28+fkMy0vtB+zEXJ9jlME4wLqdnwdN6Di7QdlHVx32Yp3m/3Tmtq/bwHS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8D3cELfFe+yxxBDgEpxA5PgdLdCX8GR/q2b94cSZuqY8FNOdU
	QlWC3uMLfRIBNs9RiACcpCTMqW2NEfXPqODNWo4v0Dtz/h2qJWpOmxQg
X-Gm-Gg: Acq92OEZdmm4qnphighfT9uTEdpNks9GtbLEjM9zzuv6QnqWYf9A4Msv8/TRIf5mgba
	SyEfV9cmrvlNyayTPKPlYmNvexghPBW4lDFT0+EImbMnm5hbVEbrMqk873RWjF+c/cMTz4mgpXG
	IEEBO+3JQDy8rTC8K2Ku5ot4ZrsD+vDwo4lg3oOKgZMVqzsfnCojqf2UC2+SntXATj0Ywx2iCbG
	MJsNQ8KpysUYmJsjGgLV6qJQd3+CuFAN28DP9SeVYlP0yH2nGVrWapzETd/8lsfVG3G/B2Xk2yn
	UyZApJNHfIHQikPEvIY/hzc5r14fk9oqdJScd9CpmPfR6Qlj+m/VaZOKY1YIk7zKZADtS/MDFeJ
	DMETGmgB2zwgc1SgNsthQWCWvQnqSqEnM06S9IhA62F/HTsX1RHZsk/pf+Z0tyB47L9RMXup74r
	2p+6Y49vlkWuR2LGlrym/8wRuAYzcndaYiz+mIlez35WPFtz8lIxJBvAl1KUntNKXfK94JrFF3k
	RKkfDruNKOmff+TjAb2x4+tzPqhGEc=
X-Received: by 2002:a17:903:950:b0:2bd:a3c5:6d96 with SMTP id d9443c01a7336-2bda3c56ef9mr55165785ad.14.1778999628794;
        Sat, 16 May 2026 23:33:48 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:78ef:13e7:10c0:51d5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2cesm111625115ad.14.2026.05.16.23.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 23:33:48 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v3 5/5] selftests/xsk: drain CQ to wait for TX completion
Date: Sun, 17 May 2026 14:33:11 +0800
Message-Id: <20260517063311.28921-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260517063311.28921-1-kerneljasonxing@gmail.com>
References: <20260517063311.28921-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2C41455F85E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288690-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Action: no action

From: Jason Xing <kernelxing@tencent.com>

After the kernel xsk drain_cont patches, dropped multi-buffer
descriptors get their buffer addresses published to the completion
queue (CQ) via the skb destructor instead of being cancelled. As a
result, the CQ entries observed by user space no longer match the
software-side accounting based on valid_frags only:
__send_pkts() bumps xsk->outstanding_tx by valid_frags, while
complete_pkts() decrements it by every CQ entry it consumes,
including those produced by drops/drains. This makes
outstanding_tx underflow and causes wait_for_tx_completion() to
exit while valid descriptors are still sitting in the TX ring,
which in turn makes receive_pkts() time out for the
ALIGNED_INV_DESC_MULTI_BUFF, UNALIGNED_INV_DESC_MULTI_BUFF and
TOO_MANY_FRAGS subtests.

Fix this with two changes to the TX completion path:
- complete_pkts(): tolerate extra CQ completions by clamping
  outstanding_tx to zero instead of failing.
- wait_for_tx_completion(): after the outstanding_tx loop finishes,
  add a drain loop that kicks TX and consumes remaining CQ entries.
  After the drain loop exits, do a short usleep and one final
  complete_pkts() call so that real hardware (e.g. ice) has enough
  time to post late CQ entries before we conclude the ring is
  fully drained.

Adjust the multi-buffer invalid-desc tests so that the last
descriptor of every invalid packet has XDP_PKT_CONTD cleared.
Without this, the kernel drain_cont logic would consume
descriptors past the packet boundary and eat into the next valid
packet, breaking pkt_nb validation. Concretely:
- XSK_DESC__INVALID_OPTION is changed from 0xffff to 0xfffe so it
  no longer asserts the XDP_PKT_CONTD bit (bit 0).
- testapp_invalid_desc_mb() clears XDP_PKT_CONTD on the trailing
  descriptor of the invalid-address and invalid-length packets.
- testapp_too_many_frags() appends one extra terminating
  descriptor so the over-sized invalid packet ends with
  XDP_PKT_CONTD cleared, preventing the drain from spilling into
  the trailing sync packet.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 48 +++++++++++--------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 7950c504ed28..1f196c8ebc73 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -31,7 +31,7 @@
 #define POLL_TMOUT			1000
 #define THREAD_TMOUT			3
 #define UMEM_HEADROOM_TEST_SIZE		128
-#define XSK_DESC__INVALID_OPTION	(0xffff)
+#define XSK_DESC__INVALID_OPTION	(0xfffe)
 #define XSK_UMEM__INVALID_FRAME_SIZE	(MAX_ETH_JUMBO_SIZE + 1)
 #define XSK_UMEM__LARGE_FRAME_SIZE	(3 * 1024)
 #define XSK_UMEM__MAX_FRAME_SIZE	(4 * 1024)
@@ -950,17 +950,11 @@ static int complete_pkts(struct xsk_socket_info *xsk, int batch_size)
 
 	rcvd = xsk_ring_cons__peek(&xsk->umem->cq, batch_size, &idx);
 	if (rcvd) {
-		if (rcvd > xsk->outstanding_tx) {
-			u64 addr = *xsk_ring_cons__comp_addr(&xsk->umem->cq, idx + rcvd - 1);
-
-			ksft_print_msg("[%s] Too many packets completed\n", __func__);
-			ksft_print_msg("Last completion address: %llx\n",
-				       (unsigned long long)addr);
-			return TEST_FAILURE;
-		}
-
 		xsk_ring_cons__release(&xsk->umem->cq, rcvd);
-		xsk->outstanding_tx -= rcvd;
+		if (rcvd > xsk->outstanding_tx)
+			xsk->outstanding_tx = 0;
+		else
+			xsk->outstanding_tx -= rcvd;
 	}
 
 	return TEST_PASS;
@@ -1274,6 +1268,8 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk, b
 static int wait_for_tx_completion(struct xsk_socket_info *xsk)
 {
 	struct timeval tv_end, tv_now, tv_timeout = {THREAD_TMOUT, 0};
+	unsigned int rcvd;
+	u32 idx;
 	int ret;
 
 	ret = gettimeofday(&tv_now, NULL);
@@ -1293,6 +1289,17 @@ static int wait_for_tx_completion(struct xsk_socket_info *xsk)
 		complete_pkts(xsk, xsk->batch_size);
 	}
 
+	do {
+		if (xsk_ring_prod__needs_wakeup(&xsk->tx))
+			kick_tx(xsk);
+		rcvd = xsk_ring_cons__peek(&xsk->umem->cq, xsk->batch_size, &idx);
+		if (rcvd)
+			xsk_ring_cons__release(&xsk->umem->cq, rcvd);
+	} while (rcvd);
+
+	usleep(100);
+	complete_pkts(xsk, xsk->batch_size);
+
 	return TEST_PASS;
 }
 
@@ -2075,10 +2082,10 @@ int testapp_invalid_desc_mb(struct test_spec *test)
 		{0, 0, 0, false, 0},
 		/* Invalid address in the second frame */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
-		{umem_size, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
+		{umem_size, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, 0},
 		/* Invalid len in the middle */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
-		{0, XSK_UMEM__INVALID_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
+		{0, XSK_UMEM__INVALID_FRAME_SIZE, 0, false, 0},
 		/* Invalid options in the middle */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XSK_DESC__INVALID_OPTION},
@@ -2229,7 +2236,7 @@ int testapp_too_many_frags(struct test_spec *test)
 		max_frags += 1;
 	}
 
-	pkts = calloc(2 * max_frags + 2, sizeof(struct pkt));
+	pkts = calloc(2 * max_frags + 3, sizeof(struct pkt));
 	if (!pkts)
 		return TEST_FAILURE;
 
@@ -2247,20 +2254,19 @@ int testapp_too_many_frags(struct test_spec *test)
 	}
 	pkts[max_frags].options = 0;
 
-	/* An invalid packet with the max amount of frags but signals packet
-	 * continues on the last frag
-	 */
-	for (i = max_frags + 1; i < 2 * max_frags + 1; i++) {
+	/* An invalid packet with too many frags */
+	for (i = max_frags + 1; i < 2 * max_frags + 2; i++) {
 		pkts[i].len = MIN_PKT_SIZE;
 		pkts[i].options = XDP_PKT_CONTD;
 		pkts[i].valid = false;
 	}
+	pkts[2 * max_frags + 1].options = 0;
 
 	/* Valid packet for synch */
-	pkts[2 * max_frags + 1].len = MIN_PKT_SIZE;
-	pkts[2 * max_frags + 1].valid = true;
+	pkts[2 * max_frags + 2].len = MIN_PKT_SIZE;
+	pkts[2 * max_frags + 2].valid = true;
 
-	if (pkt_stream_generate_custom(test, pkts, 2 * max_frags + 2)) {
+	if (pkt_stream_generate_custom(test, pkts, 2 * max_frags + 3)) {
 		free(pkts);
 		return TEST_FAILURE;
 	}
-- 
2.43.7


