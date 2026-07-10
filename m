Return-Path: <netdev+bounces-306687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nAYXMstLUWo4CAMAu9opvQ
	(envelope-from <netdev+bounces-306687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:45:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC8473DE89
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:45:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ISs7k0Ly;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306687-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306687-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 640CD3010610
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671D238837A;
	Fri, 10 Jul 2026 19:45:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB42138F253;
	Fri, 10 Jul 2026 19:45:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712713; cv=none; b=oOJMYdZODqL/njZLx5M3k7Zngw5dB39h44UXvWLk3yQZuetDZ7Mlys4TNcEZlEBpIoL7VR5ww+tGAOYaNss2vjIi7Jbvdjta42V5FVw7WgKc4y418NTQYs6cHQ8tjUw9XiqRecHG1CE3TvPhSGt0IQ98pSfL15YDOkUYygQ07xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712713; c=relaxed/simple;
	bh=woEMa072B6FgiX3OZeS/66WbdJR6hpOoNhGZbMu0y18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g1/wOvoAMXGdqQH7JZfdVrn2aGlfTe00BzxmqUr69ejIv7y7UkKz9txgdipBSIR6zvF2DlIgkZg9y/dEklqo0XksnwtmPoJNsxNY8ilMnYFloUfk97WZu4tJ62+JC9itxKkRajiBox1F8vEpb82OW/Im893JiHi/zAFBC4l/Evk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISs7k0Ly; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783712709; x=1815248709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=woEMa072B6FgiX3OZeS/66WbdJR6hpOoNhGZbMu0y18=;
  b=ISs7k0LyiK4z9sZNAGUkDfrx9NxtcuHOY9BsdelBvrbsOD89/9KzlGv7
   dMDWc/X8sS8HmapXeYlGlh2dnf3rhUjTdkOyceX7ZDQdmPu6qgOBxNk+n
   sYpqTaiH3EclcCjxVtO9RfpWqQzz6EBXGIiWYjROyCzI4kTvX6EbNyLrv
   94fPw3wtwBd6VY/M4I6w+TLLly7I/Av0/uuCwNetZTbklc6cj0e5eib1B
   NfE+5gKYSNRndOcso6A8rEfxNObsmRiFUYceTpc4j04R0YMlzewm/435a
   TJZtTiX9YXssXOsSTkl62kdiPYtKFbG2dxJTwxfmYXjwxm7+ozguAh1JP
   A==;
X-CSE-ConnectionGUID: YjwCULbMRYacq8kYfMC4aQ==
X-CSE-MsgGUID: Y/qsTDBWSsyfzyumpI77mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101965234"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="101965234"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 12:45:07 -0700
X-CSE-ConnectionGUID: tFbq0+ObRtChixwozf2rbw==
X-CSE-MsgGUID: 2eY4j9w6Rw6EOORRzJfulQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="293157373"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa001.jf.intel.com with ESMTP; 10 Jul 2026 12:45:04 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	stfomichev@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	bjorn@kernel.org,
	kerneljasonxing@gmail.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 net 5/5] selftests/xsk: account invalid multi-buffer Tx descriptors
Date: Fri, 10 Jul 2026 21:44:24 +0200
Message-Id: <20260710194424.84844-6-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260710194424.84844-1-maciej.fijalkowski@intel.com>
References: <20260710194424.84844-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306687-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bjorn@kernel.org,m:kerneljasonxing@gmail.com,m:maciej.fijalkowski@intel.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciej.fijalkowski@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9DC8473DE89

Invalid descriptors in the middle of a multi-buffer packet still belong
to the packet being consumed from the Tx ring. The tests should therefore
count the whole invalid packet as outstanding in verbatim mode, even
though the packet must not be expected on the Rx side.

Make fragment counting follow the packet boundary instead of stopping at
the first invalid fragment. Update custom stream generation so invalid
middle fragments terminate the generated Rx packet while Tx accounting
still covers all descriptors consumed from the invalid multi-buffer
packet.

Also add explicit end fragments after invalid middle descriptors. This
exercises the kernel drain logic and verifies that subsequent valid
packets are not interpreted as continuations of the invalid packet.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 .../selftests/bpf/prog_tests/test_xsk.c       | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index de17dd48f176..7abb4935edf9 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -427,14 +427,14 @@ static u32 pkt_nb_frags(u32 frame_size, struct pkt_stream *pkt_stream, struct pk
 	}
 
 	/* Search for the end of the packet in verbatim mode */
-	if (!pkt_continues(pkt->options) || !pkt->valid)
+	if (!pkt_continues(pkt->options))
 		return nb_frags;
 
 	next_frag = pkt_stream->current_pkt_nb;
 	pkt++;
 	while (next_frag++ < pkt_stream->nb_pkts) {
 		nb_frags++;
-		if (!pkt_continues(pkt->options) || !pkt->valid)
+		if (!pkt_continues(pkt->options))
 			break;
 		pkt++;
 	}
@@ -665,11 +665,11 @@ static struct pkt_stream *__pkt_stream_generate_custom(struct ifobject *ifobj, s
 			if (!frame->valid || !pkt_continues(frame->options))
 				payload++;
 		} else {
-			if (frame->valid)
+			if (frame->valid) {
 				len += frame->len;
-			if (frame->valid && pkt_continues(frame->options))
-				continue;
-
+				if (pkt_continues(frame->options))
+					continue;
+			}
 			pkt->pkt_nb = pkt_nb;
 			pkt->len = len;
 			pkt->valid = frame->valid;
@@ -1209,6 +1209,7 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
 	for (i = 0; i < xsk->batch_size; i++) {
 		struct pkt *pkt = pkt_stream_get_next_tx_pkt(pkt_stream);
 		u32 nb_frags_left, nb_frags, bytes_written = 0;
+		struct pkt *first_pkt = pkt;
 
 		if (!pkt)
 			break;
@@ -1253,6 +1254,8 @@ static int __send_pkts(struct ifobject *ifobject, struct xsk_socket_info *xsk,
 		if (pkt && pkt->valid) {
 			valid_pkts++;
 			valid_frags += nb_frags;
+		} else if (pkt_stream->verbatim && pkt_continues(first_pkt->options)) {
+			valid_frags += nb_frags;
 		}
 	}
 
@@ -2099,13 +2102,16 @@ int testapp_invalid_desc_mb(struct test_spec *test)
 		{0, 0, 0, false, 0},
 		/* Invalid address in the second frame */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
-		{umem_sz, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
+		{umem_sz * 2, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
+		{0, MIN_PKT_SIZE, 0, false, 0},
 		/* Invalid len in the middle */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
 		{0, XSK_UMEM__INVALID_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
+		{0, MIN_PKT_SIZE, 0, false, 0},
 		/* Invalid options in the middle */
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XDP_PKT_CONTD},
 		{0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XSK_DESC__INVALID_OPTION},
+		{0, MIN_PKT_SIZE, 0, false, 0},
 		/* Transmit 2 frags, receive 3 */
 		{0, XSK_UMEM__MAX_FRAME_SIZE, 0, true, XDP_PKT_CONTD},
 		{0, XSK_UMEM__MAX_FRAME_SIZE, 0, true, 0},
@@ -2117,8 +2123,8 @@ int testapp_invalid_desc_mb(struct test_spec *test)
 
 	if (umem->unaligned_mode) {
 		/* Crossing a chunk boundary allowed */
-		pkts[12].valid = true;
-		pkts[13].valid = true;
+		pkts[15].valid = true;
+		pkts[16].valid = true;
 	}
 
 	test->mtu = MAX_ETH_JUMBO_SIZE;
-- 
2.43.0


