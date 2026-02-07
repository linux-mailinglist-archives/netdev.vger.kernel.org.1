Return-Path: <netdev+bounces-257670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMgfIR2JhmmNOgQAu9opvQ
	(envelope-from <netdev+bounces-257670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:36:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D422B104555
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 01:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09D713060194
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 00:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A1B22157B;
	Sat,  7 Feb 2026 00:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgwCVovX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3BD21A457;
	Sat,  7 Feb 2026 00:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770424521; cv=none; b=dA3urr2B98F4mBDGO6/BF2e4LLMA8jA/TidQVo/xBnDLs5RsAv7KoLRIH0irx8cNSVvLAwkVR/D+re+mE+sfDxJmDNRQFrNk0QL//wdI+U2PCK8Dec8Z2PDt8eO0FdHUHE+nv802/at41soP5abWnCgBKEuK/n8I57L9lg2+Kks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770424521; c=relaxed/simple;
	bh=ebNhDFuwOCgh31SMzIMBvy0cHokX8Sm6bFlQoyAQI8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2Txs3xNjC1e2HHLVuZHJux+VRFvlxWuDzG1RzyF62VuNKfkThw4LUv6MKfDGlOv4W9X9E/lHccnj+wim9LxQgGyf4D8YRoOxZFmQ+qqLq7Vnn74bmBBlG1CjQB6wUDazFzDjJWojdZuB4K3jsCDE/9KkunAL1da0SvpH58AyF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgwCVovX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D0BC16AAE;
	Sat,  7 Feb 2026 00:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770424520;
	bh=ebNhDFuwOCgh31SMzIMBvy0cHokX8Sm6bFlQoyAQI8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JgwCVovXmQofe3858fELa1NkaG+5/PvL/GbyKcFP7B8517aYNYXmGL3GJco6QInqP
	 OdUJQW2EzdcKqjp0Pec3Una++UX2L0ixHPZf8gUhhzUpmcg+buYHa4oHzOci2ThjEN
	 KdGq4dQ/TC+OQsAsrkZpkcKavHfzUUGAD2ns8al9ebGYAHJQ8OJxjjqcS7M3T6Ut/q
	 q+jtyMkD0A3nAJ+vSP1L+hu7tb68x8t72/IkT5FjD3cFdMhLLLfJ3NwNJ//Sji6Dir
	 +TIt8MVA5b/qX964B64VFE++ZUodN0g28Rv10C5VST1tAtR1Gi+SnPVUwCV4RvfN67
	 ZBcTnifYG65ug==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	donald.hunter@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 6/9] selftests: drv-net: gro: use SO_TXTIME to schedule packets together
Date: Fri,  6 Feb 2026 16:35:06 -0800
Message-ID: <20260207003509.3927744-7-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260207003509.3927744-1-kuba@kernel.org>
References: <20260207003509.3927744-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com,broadcom.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-257670-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: D422B104555
X-Rspamd-Action: no action

Longer packet sequence tests are quite flaky when the test is run
over a real network. Try to avoid at least the jitter on the sender
side by scheduling all the packets to be sent at once using SO_TXTIME.
Use hardcoded tx time of 5msec in the future. In my test increasing
this time past 2msec makes no difference so 5msec is plenty of margin.
Since we now expect more output buffering make sure to raise SNDBUF.

Experimenting with long sequences I see frequent failures when sending
200 packets, only 50-100 packets get coalesced. With this change
up to 1000 packets get coalesced relatively reliably.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - only enable TXTIME when we are sending a single flow
v1: https://lore.kernel.org/20260205220541.2992807-7-kuba@kernel.org
---
 tools/testing/selftests/net/lib/gro.c | 57 +++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/lib/gro.c b/tools/testing/selftests/net/lib/gro.c
index 02e29509fbea..5b3f8fca08e6 100644
--- a/tools/testing/selftests/net/lib/gro.c
+++ b/tools/testing/selftests/net/lib/gro.c
@@ -63,6 +63,7 @@
 #include <linux/filter.h>
 #include <linux/if_packet.h>
 #include <linux/ipv6.h>
+#include <linux/net_tstamp.h>
 #include <net/ethernet.h>
 #include <net/if.h>
 #include <netinet/in.h>
@@ -74,6 +75,7 @@
 #include <stdio.h>
 #include <stdarg.h>
 #include <string.h>
+#include <time.h>
 #include <unistd.h>
 
 #include "kselftest.h"
@@ -123,6 +125,9 @@ static int tcp_offset = -1;
 static int total_hdr_len = -1;
 static int ethhdr_proto = -1;
 static bool ipip;
+static uint64_t txtime_ns;
+
+#define TXTIME_DELAY_MS 5
 
 static void vlog(const char *fmt, ...)
 {
@@ -330,13 +335,37 @@ static void fill_transportlayer(void *buf, int seq_offset, int ack_offset,
 
 static void write_packet(int fd, char *buf, int len, struct sockaddr_ll *daddr)
 {
+	char control[CMSG_SPACE(sizeof(uint64_t))];
+	struct msghdr msg = {};
+	struct iovec iov = {};
+	struct cmsghdr *cm;
 	int ret = -1;
 
-	ret = sendto(fd, buf, len, 0, (struct sockaddr *)daddr, sizeof(*daddr));
+	iov.iov_base = buf;
+	iov.iov_len = len;
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_name = daddr;
+	msg.msg_namelen = sizeof(*daddr);
+
+	if (txtime_ns) {
+		memset(control, 0, sizeof(control));
+		msg.msg_control = control;
+		msg.msg_controllen = sizeof(control);
+
+		cm = CMSG_FIRSTHDR(&msg);
+		cm->cmsg_level = SOL_SOCKET;
+		cm->cmsg_type = SCM_TXTIME;
+		cm->cmsg_len = CMSG_LEN(sizeof(uint64_t));
+		memcpy(CMSG_DATA(cm), &txtime_ns, sizeof(txtime_ns));
+	}
+
+	ret = sendmsg(fd, &msg, 0);
 	if (ret == -1)
-		error(1, errno, "sendto failure");
+		error(1, errno, "sendmsg failure");
 	if (ret != len)
-		error(1, errno, "sendto wrong length");
+		error(1, 0, "sendmsg wrong length: %d vs %d", ret, len);
 }
 
 static void create_packet(void *buf, int seq_offset, int ack_offset,
@@ -1058,6 +1087,7 @@ static void check_recv_pkts(int fd, int *correct_payload,
 
 static void gro_sender(void)
 {
+	int bufsize = 4 * 1024 * 1024; /* 4 MB */
 	const int fin_delay_us = 100 * 1000;
 	static char fin_pkt[MAX_HDR_LEN];
 	struct sockaddr_ll daddr = {};
@@ -1067,6 +1097,27 @@ static void gro_sender(void)
 	if (txfd < 0)
 		error(1, errno, "socket creation");
 
+	if (setsockopt(txfd, SOL_SOCKET, SO_SNDBUF, &bufsize, sizeof(bufsize)))
+		error(1, errno, "cannot set sndbuf size, setsockopt failed");
+
+	/* Enable SO_TXTIME unless test case generates more than one flow
+	 * SO_TXTIME could result in qdisc layer sorting the packets at sender.
+	 */
+	if (true) {
+		struct sock_txtime so_txtime = { .clockid = CLOCK_MONOTONIC, };
+		struct timespec ts;
+
+		if (setsockopt(txfd, SOL_SOCKET, SO_TXTIME,
+			       &so_txtime, sizeof(so_txtime)))
+			error(1, errno, "setsockopt SO_TXTIME");
+
+		if (clock_gettime(CLOCK_MONOTONIC, &ts))
+			error(1, errno, "clock_gettime");
+
+		txtime_ns = ts.tv_sec * 1000000000ULL + ts.tv_nsec;
+		txtime_ns += TXTIME_DELAY_MS * 1000000ULL;
+	}
+
 	memset(&daddr, 0, sizeof(daddr));
 	daddr.sll_ifindex = if_nametoindex(ifname);
 	if (daddr.sll_ifindex == 0)
-- 
2.53.0


