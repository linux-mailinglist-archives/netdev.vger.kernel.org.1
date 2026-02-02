Return-Path: <netdev+bounces-255826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHdIEsZ7gGnE8wIAu9opvQ
	(envelope-from <netdev+bounces-255826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:26:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B409DCADE2
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 11:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1ACF5300AEE8
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 10:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A05D2D8764;
	Mon,  2 Feb 2026 10:25:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from a2412.mx.srv.dfn.de (a2412.mx.srv.dfn.de [194.95.233.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DAA4AEE2
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.95.233.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770027910; cv=none; b=Q1XicQ5sA9jyl4+RbaCpp9xkNrriv237QhDvFDs9VW1IOCynOFQYEUeyMLdei1pYfSOfebKWXOfIqs8L08oq4omjKlPNKUvQxMu0iHFJKmZso2V6eZXno+9j4cL1EW9uMJM9Fg9RiSh+9U7t0sgnbVNAQiCoP1XQNB89B0fWJ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770027910; c=relaxed/simple;
	bh=zs6yiC3tZmYe7mQh0Lk+YfZZKmUb+3sX1SpN/fwigzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TLPJdy53lOOH5mYj75Wajhnp775uHrKEKOPJyVjuaUYKn4ruy2X222yYXT69+2SXqvw28K+HoqWev0jYmSiXlEQrADkBrWduYu3T3kNL52XFIO9IQV6+Ty6yHV23iME2OCRFDIHurKWpUO2Hf5GCU2Rje86odZc8EZwOwR/ORKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uni-osnabrueck.de; spf=pass smtp.mailfrom=uni-osnabrueck.de; arc=none smtp.client-ip=194.95.233.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uni-osnabrueck.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uni-osnabrueck.de
Received: from vm411.rz.uni-osnabrueck.de (vm411.rz.uni-osnabrueck.de [IPv6:2001:638:508:100::83ad:108f])
	by a2412.mx.srv.dfn.de (Postfix) with ESMTPS id BECF060197;
	Mon,  2 Feb 2026 11:15:02 +0100 (CET)
Received: from kelmenhorst-Latitude-7450.. (unknown [IPv6:2001:638:508:f000:dc51:8c71:7bd3:8975])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: kelmenhorst)
	by vm411.rz.uni-osnabrueck.de (Postfix) with ESMTPSA id 8006930056C3;
	Mon,  2 Feb 2026 11:15:02 +0100 (CET)
From: kelmenhorst <kelmenhorst@uni-osnabrueck.de>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	kelmenhorst <kelmenhorst@uni-osnabrueck.de>
Subject: [PATCH net-next] net: tcp_bbr: use high pacing gain when the sender fails to put enough data inflight
Date: Mon,  2 Feb 2026 11:14:54 +0100
Message-ID: <20260202101454.89445-1-kelmenhorst@uni-osnabrueck.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[uni-osnabrueck.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255826-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NEQ_ENVFROM(0.00)[kelmenhorst@uni-osnabrueck.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B409DCADE2
X-Rspamd-Action: no action

This patch addresses a robustness issue of TCP BBR when run in Virtual Machines
- a common use case considering modern web hosting.
Prior experiments in AWS VMs (https://ieeexplore.ieee.org/abstract/document/9546441),
and our recent measurements in a controlled setup show that VM-based BBR senders
heavily underestimate the available bandwidth during periods of CPU contention.
In our configuration with 10ms periodic timeslices, BBR already degrades in VMs
with less than 70% CPU time share, and the throughput continuously drops with
decreasing CPU shares until it is bandwidth-independently capped at 10 Mbps for
CPU time shares at 35% and lower.
Considering the common use case of BBR in (resource-limited) Linux VMs, this
issue could potentially compromise the robustness of the Internet's transport
layer.

In contrast to Cubic, BBR is very sensitive to off-CPU times. This is because
pacing evenly spreads the target inflight over the RTT, essentially assuming
that the CPU is available during the whole RTT. If this assumption is not met,
the BBR sender cannot achieve the target pacing rate and concludes that the full
bandwidth has been reached, even though the throughput is far below the actual
bandwidth limit.

This commit detects the problematic condition in bbr_update_gains() by
comparing BBR's current target inflight (bbr_inflight() * tp->mss_cache) with
the actual number of bytes inflight (tp->bytes_sent - tp->bytes_acked), and
applies high pacing gain (bbr_high_gain), until the inflight deficit recovers.
With a higher pacing gain, BBR can send faster when the VM does have the CPU,
so that the target inflight volume can be achieved despite off-CPU times.
Re-using the constant STARTUP gain can only solve the issue up to a certain
point, but avoids complex algorithm changes.
Effectively, the patch solves the degradation problem for most critical cases:
with 10ms periodic timeslices, BBRv1 is robust for CPU time shares of 35% and
higher -  instead of 70% and higher when using the original code.

We can share further results of our measurement study upon individual request.

Signed-off-by: Kathrin Elmenhorst <kelmenhorst@uni-osnabrueck.de>
---
 net/ipv4/tcp_bbr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
index 760941e55153..ca6361931491 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -1011,6 +1011,13 @@ static void bbr_update_gains(struct sock *sk)
 		WARN_ONCE(1, "BBR bad mode: %u\n", bbr->mode);
 		break;
 	}
+        // overwrite pacing gain in case the sender fails to put enough data inflight
+        struct tcp_sock *tp = tcp_sk(sk);
+        u64 real_inflight = tp->bytes_sent - tp->bytes_acked;
+        u32 target_inflight = bbr_inflight(sk, bbr_bw(sk), BBR_UNIT) * tp->mss_cache;
+        if (real_inflight < target_inflight) {
+                bbr->pacing_gain = bbr_high_gain;
+        }
 }
 
 static void bbr_update_model(struct sock *sk, const struct rate_sample *rs)
-- 
2.43.0


