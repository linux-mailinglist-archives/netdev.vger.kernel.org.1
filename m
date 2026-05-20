Return-Path: <netdev+bounces-289670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MejELQDDWrXsAUAu9opvQ
	(envelope-from <netdev+bounces-289670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:43:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0685586553
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6305301F17D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB29622A7F0;
	Wed, 20 May 2026 00:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kG42ZrdZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E246223DE9
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 00:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237809; cv=none; b=f0WXtwT3RJhUoWwytZyVfLojZfEhytEZn46zLQA3gOSQ6GsXRV/ZqbHwIoo6EM+RjDObyxpbfVPmF8akn+8ErTYD9T/KAL16RT07qoEyDhGvq1EkTew3ZRAnpL5vZK2rGJJuXLMOZ+EqABrM0ycQkVWPKEXrt8Qxy79jsLf1Sz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237809; c=relaxed/simple;
	bh=SfJL8LPr6GDe/OJHPFWr3tFTOY3oYhXDoBP3xAEQFZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PQwVAoQfweXvM/V0l/Ozm7rJGkGGyt/sUHqIlUfn/Wlc/9rrFgnM/QlIrA5VErT1Ws8CnHPzSfNJsNCfwcsNqe9RorKx7RxywNxrOS5hb/vd5Z6AjH03Me93A3cJUoXDOGSVtmAbY7w8cba4ELexGGROBKhCrG87m/BL9KdjAG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kG42ZrdZ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-369576666d5so1926447a91.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 17:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779237808; x=1779842608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIm5luJhGoab49QPoC2ghLiKrO+q0wci/8m1qO+0CIs=;
        b=kG42ZrdZfsuIxYwfGIAIbW3Ey3bsdgUl6/tBGaCLyDEbrdX6pvGreHuKjktN/XpzO1
         lS+9XVwoTp4AJEvgrT/yx65r/w055Y8d5MCWWjFW1Za91qSmB7BIxH/zLaD3wfYDffvn
         s9SJ1PrS2f95/hBPZbL1m8ujiiWqU95+EEs6zOePDSSEAbzXlO6UeF986M9tSINlZYu1
         y7zMuWicwC6FTSVSNvGPBPwW4JHZvJ1xddA1Y4uwHO0fzFATHIdQjZQGdwhKl7/Rbgu4
         gIjfTCDjzOXfUwzbR5hFg7E8JvSZ4aTHGq0zLsqLY9ozoy+VFdrme2lA/l08Jk2fa7Lh
         O7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779237808; x=1779842608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hIm5luJhGoab49QPoC2ghLiKrO+q0wci/8m1qO+0CIs=;
        b=V6HRBYxVUyP4oT1+vzm0EqhzDF411/H51aS8csHDg1ulctvRVjC5sVgqiBIcQL7RgJ
         66+uSPKHeB4aQbsy9qQBoJU4mWxK4XDvwXxFrndtRmRa+JrVu1cTbdr1NIKulxT4klPC
         LZjRkOVsA02bSISLJeNhfjRayrd7CKD9FDInQ5U6xMeAU1S6eA/jT6Nam7MItbkNsa1G
         8SyHO/+k/HeXXqtId1UO4yBc4NuQj9+TsjdRlF3hp1BuFpgZRbOirfo24EeJFC/I5WZi
         ntjBvaVpcbJ7Jz2tyUzqA7mFD93S3KKlksSzphJJVjP3WYTte8NHW4EUrfrtYNiDL9JQ
         5bWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+qOA+e6XAUM3NcjnCa9UOP1Nj29rf/F/4J6fpwCNay3Am9zYMXKd/kyUEEkPhMJnSUlLxYOqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUqruJot+UT4GW+sre0s7MZQdH4ZAZvHLY4DSLJdmTf3Q4oP//
	A30tIOCPUfVjIUZNcR2I0NVGHvLbXdAjjDzWxKX9nrpAvL8MGHkwRKCb
X-Gm-Gg: Acq92OE+koaLWv8Hoqx1TEShguY7AriQLu9JScv5avJZTwmWMg8YPx775rqBlw82Jni
	nfJjkpb/M61rf8meGdb54VCBE/3hQ3jTIFw2ww+Gi1wrx038aT5DOuh3NUsEBuhjLC7RSxKg2si
	7mATuA7dH8q1ZX+OKfUB1burLe2zeMchTE3YC9Wy9vU6iI2IpeHhWOXHdMPcB5Ne+TYAQ9w0a2i
	ds/i6exhF2q9VBDZWOasJjN07VuXPo9obhI61is3wfEvJgubNbRZTql6c5Wzuc9c0+QKvOD/Lj0
	AimFAzY0aAf+nik+ji398r8KIZx9Z2OXTYG0kDi72/oPnMSQxgVPUxUEEgx4f3834I1mgXeE3A8
	Od28Q+x7b00Gs0pkW3MqW1lDH5RlQbL9wJdfRnDMNjL6bu/m7v1xbCuh5q0OYdT4t8Cn5enYLZ4
	/REubzVbJbE14CBmoLXMeuaPk4ttt+XW24vbSfMNWKjN/ntAJdtJ3hHuBp56MoID+iXlxNB515u
	mizvYUyiiCYjBsO9NlS+M5Wykusdn4kQKNN0rXAXw==
X-Received: by 2002:a17:90b:38cf:b0:35f:b647:d98a with SMTP id 98e67ed59e1d1-369519c6bcfmr20468519a91.5.1779237807712;
        Tue, 19 May 2026 17:43:27 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1923:2c20:f1df:d520:8103:19c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951059f4dsm14746277a91.0.2026.05.19.17.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 17:43:27 -0700 (PDT)
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
Subject: [PATCH net v4 5/5] selftests/xsk: drain CQ to wait for TX completion
Date: Wed, 20 May 2026 08:42:44 +0800
Message-Id: <20260520004244.55663-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260520004244.55663-1-kerneljasonxing@gmail.com>
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289670-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B0685586553
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


