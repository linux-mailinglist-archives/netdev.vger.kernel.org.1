Return-Path: <netdev+bounces-274218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGn9IrhkzWkHdAYAu9opvQ
	(envelope-from <netdev+bounces-274218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:32:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A71837F4DF
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C5B5304F20C
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 18:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70E83F54A1;
	Wed,  1 Apr 2026 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggVVZ8Av"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A420C3D47BF;
	Wed,  1 Apr 2026 18:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775067996; cv=none; b=DkwbR5/gSC0tiOaRdwpqdGPVvQMzKkPmdc/kMdK1ifBEU00Xn9X06l/fPtuTlOIe6XwRG15QJsIdzAbXUOXD5o1lybYXBWdQTcv5UQgudwvdJX9Wn/KuEk4iFTw8Ak0AOsqD/ey287jHrXXh4DuMrG0jFWAEwGZe53RRqtYET+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775067996; c=relaxed/simple;
	bh=ddmBzIN4XbsRju1vfmB9KU23zOCwSxlP13c5rkVv36E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1CvXTiODZ65lv3yhN/l/jALvogtVawJzZ8tSOSyeF5YdZiN1JRbNyw8UKYk9TS0BkIw3jGXA6Y1/6kASIkPc6Y6k9kaJmP70IM9mO+G6uUT3Ubwd1HXXXUrZ4XZTYeaLRfVrwHRoN1b8yskgoZnsHinV+ToCftI79QN4uz29oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggVVZ8Av; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B444C4CEF7;
	Wed,  1 Apr 2026 18:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775067996;
	bh=ddmBzIN4XbsRju1vfmB9KU23zOCwSxlP13c5rkVv36E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ggVVZ8AvrGE4vCHaKdzOm3GIXdOSdKkatY2IB6IXT2tPJ9tYTzWIS3zsB39Xv23HT
	 XKMf+bC6X7xYZwknqVZsUDOVrsatIhhgqZ8Pg698h61gOHfhWYyXmYGU0uoy3CcAU3
	 JeMRJctbQSBDVjSu0VS4m8gezmQO2CyykVgmHAOxJvmthTWMeMQkXgH97UtSzLjjVA
	 8j3i1KPvu/pHxIzlum0Mv5KeEf2CgZDnTI92I663HRaPExveXI+sL1tDf2nafdTVeX
	 0UGvUuyaMotWIEtdVlEIEMK1M38dblFNxxJ49o8DCqu2VEgkBJf54TV0r1kuPlyqoQ
	 D+ShCfXD9fvaA==
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
	anubhavsinggh@google.com,
	richardbgobert@gmail.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 6/6] selftests: drv-net: gro: add a test for bad IPv4 csum
Date: Wed,  1 Apr 2026 11:26:25 -0700
Message-ID: <20260401182625.372605-7-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401182625.372605-1-kuba@kernel.org>
References: <20260401182625.372605-1-kuba@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-274218-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A71837F4DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We have a test for coalescing with bad TCP checksum, let's also
test bad IPv4 header checksum.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/gro.c      | 25 ++++++++++++++++++++++
 tools/testing/selftests/drivers/net/gro.py |  1 +
 2 files changed, 26 insertions(+)

diff --git a/tools/testing/selftests/net/lib/gro.c b/tools/testing/selftests/net/lib/gro.c
index 762e88932ed2..a458cfbd11eb 100644
--- a/tools/testing/selftests/net/lib/gro.c
+++ b/tools/testing/selftests/net/lib/gro.c
@@ -36,6 +36,7 @@
  *  Packets with different (ECN, TTL, TOS) header, IP options or
  *  IP fragments shouldn't coalesce.
  *   - ip_ecn, ip_tos:            shared between IPv4/IPv6
+ *   - ip_csum:                   IPv4 only, bad IP header checksum
  *   - ip_ttl, ip_opt, ip_frag4:  IPv4 only
  *   - ip_id_df*:                 IPv4 IP ID field coalescing tests
  *   - ip_frag6, ip_v6ext_*:      IPv6 only
@@ -675,6 +676,21 @@ static void send_changed_checksum(int fd, struct sockaddr_ll *daddr)
 	write_packet(fd, buf, pkt_size, daddr);
 }
 
+/* Packets with incorrect IPv4 header checksum don't coalesce. */
+static void send_changed_ip_checksum(int fd, struct sockaddr_ll *daddr)
+{
+	static char buf[MAX_HDR_LEN + PAYLOAD_LEN];
+	struct iphdr *iph = (struct iphdr *)(buf + ETH_HLEN);
+	int pkt_size = total_hdr_len + PAYLOAD_LEN;
+
+	create_packet(buf, 0, 0, PAYLOAD_LEN, 0);
+	write_packet(fd, buf, pkt_size, daddr);
+
+	create_packet(buf, PAYLOAD_LEN, 0, PAYLOAD_LEN, 0);
+	iph->check = iph->check - 1;
+	write_packet(fd, buf, pkt_size, daddr);
+}
+
  /* Packets with non-consecutive sequence number don't coalesce.*/
 static void send_changed_seq(int fd, struct sockaddr_ll *daddr)
 {
@@ -1392,6 +1408,10 @@ static void gro_sender(void)
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
 	/* ip sub-tests - IPv4 only */
+	} else if (strcmp(testname, "ip_csum") == 0) {
+		send_changed_ip_checksum(txfd, &daddr);
+		usleep(fin_delay_us);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "ip_ttl") == 0) {
 		send_changed_ttl(txfd, &daddr);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
@@ -1588,6 +1608,11 @@ static void gro_receiver(void)
 		check_recv_pkts(rxfd, correct_payload, 2);
 
 	/* ip sub-tests - IPv4 only */
+	} else if (strcmp(testname, "ip_csum") == 0) {
+		correct_payload[0] = PAYLOAD_LEN;
+		correct_payload[1] = PAYLOAD_LEN;
+		printf("bad ip checksum doesn't coalesce: ");
+		check_recv_pkts(rxfd, correct_payload, 2);
 	} else if (strcmp(testname, "ip_ttl") == 0) {
 		correct_payload[0] = PAYLOAD_LEN;
 		correct_payload[1] = PAYLOAD_LEN;
diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index 68b7b29ea2ee..ba9f4146034c 100755
--- a/tools/testing/selftests/drivers/net/gro.py
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -306,6 +306,7 @@ def _run_gro_bin(cfg, test_name, protocol=None, num_flows=None,
 
     # Tests specific to IPv4
     ipv4_tests = [
+        "ip_csum",
         "ip_ttl", "ip_opt", "ip_frag4",
         "ip_id_df1_inc", "ip_id_df1_fixed",
         "ip_id_df0_inc", "ip_id_df0_fixed",
-- 
2.53.0


