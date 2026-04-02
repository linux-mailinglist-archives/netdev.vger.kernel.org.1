Return-Path: <netdev+bounces-274701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDh1Er/ZzmmGqgYAu9opvQ
	(envelope-from <netdev+bounces-274701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:03:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C700138E3B1
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EC453074A01
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 21:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE44B389108;
	Thu,  2 Apr 2026 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMu/gG1Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB4537C915;
	Thu,  2 Apr 2026 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775163615; cv=none; b=bsUZ4RBuj+936Wx9FRNHag0C+nVBAJQrLDlNNRsQ2ER9eq0Ujgs8KfGDEYMt5EdqukCUWE7vAm6lbW5uzGasJev00ULKfKL1KkFMK8gkwR709qTY+I6Bym8KPX3xZZUgSGFD/EGsMhntmdZ8V1pzfHTJMZ45gmot3eTqO4aw0sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775163615; c=relaxed/simple;
	bh=bphm+tAH2cT1kmlF/w/ZjVFghWPiehqG5zy3NO9299w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X48+Z33SmbN+a3oL6rgQpWaoeiGaKWZ3G3b5KTfKtKB3PLdW2UUTPEUw8uvj+ihHggwshKaRmt/bJ4AdlGFQozF2s5AHqB0lv4Of7ppaL5i/55+xt3RpHbo5S9KubUlNPESh3V43lRDCqbL93Bqg3wjHlEKCzE7lZQ/2vdF7lis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMu/gG1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E4CC2BCB1;
	Thu,  2 Apr 2026 21:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775163615;
	bh=bphm+tAH2cT1kmlF/w/ZjVFghWPiehqG5zy3NO9299w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GMu/gG1Q17/9aZwha61RWbkUBocQzT701x5m4WCVbcwOaHvCJSlS6GQK049iAY0if
	 Qnnbsjy9+Pa4PjVGfLEo7fp3J9dq79ie0dwtvlBIm+wkakJgZI4r9/R9PmKq36c+41
	 qHzHpIuLrXcAdWmoiwH6SOCzj/o2ulD0rwKAaMU/v7K2oApoU8/5y1vjNAoBEabhUt
	 zyryvk15Jhrlrf+JmPriJqbatWXZN7hNszP1zbMBWgH+coqUZ8+dX+Mjp3RVt0iuKw
	 Qt8WusEjpZjKvJHz7mvCWeXU2pMcfVtxXBh/uPrB+OvyNcO2x7O8AZa6VnP2Gq3zTO
	 rILdOgJFkpwiw==
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
Subject: [PATCH net-next v2 8/8] selftests: drv-net: gro: add a test for bad IPv4 csum
Date: Thu,  2 Apr 2026 14:00:00 -0700
Message-ID: <20260402210000.1512696-9-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402210000.1512696-1-kuba@kernel.org>
References: <20260402210000.1512696-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-274701-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C700138E3B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We have a test for coalescing with bad TCP checksum, let's also
test bad IPv4 header checksum.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - add a third packet
v1: https://lore.kernel.org/all/20260401182625.372605-7-kuba@kernel.org/
---
 tools/testing/selftests/net/lib/gro.c      | 29 ++++++++++++++++++++++
 tools/testing/selftests/drivers/net/gro.py |  1 +
 2 files changed, 30 insertions(+)

diff --git a/tools/testing/selftests/net/lib/gro.c b/tools/testing/selftests/net/lib/gro.c
index b99c0f00b8fe..11b16ae5f0e8 100644
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
@@ -685,6 +686,24 @@ static void send_changed_checksum(int fd, struct sockaddr_ll *daddr)
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
+
+	create_packet(buf, PAYLOAD_LEN * 2, 0, PAYLOAD_LEN, 0);
+	write_packet(fd, buf, pkt_size, daddr);
+}
+
  /* Packets with non-consecutive sequence number don't coalesce.*/
 static void send_changed_seq(int fd, struct sockaddr_ll *daddr)
 {
@@ -1402,6 +1421,10 @@ static void gro_sender(void)
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 
 	/* ip sub-tests - IPv4 only */
+	} else if (strcmp(testname, "ip_csum") == 0) {
+		send_changed_ip_checksum(txfd, &daddr);
+		usleep(fin_delay_us);
+		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
 	} else if (strcmp(testname, "ip_ttl") == 0) {
 		send_changed_ttl(txfd, &daddr);
 		write_packet(txfd, fin_pkt, total_hdr_len, &daddr);
@@ -1598,6 +1621,12 @@ static void gro_receiver(void)
 		check_recv_pkts(rxfd, correct_payload, 2);
 
 	/* ip sub-tests - IPv4 only */
+	} else if (strcmp(testname, "ip_csum") == 0) {
+		correct_payload[0] = PAYLOAD_LEN;
+		correct_payload[1] = PAYLOAD_LEN;
+		correct_payload[2] = PAYLOAD_LEN;
+		printf("bad ip checksum doesn't coalesce: ");
+		check_recv_pkts(rxfd, correct_payload, 3);
 	} else if (strcmp(testname, "ip_ttl") == 0) {
 		correct_payload[0] = PAYLOAD_LEN;
 		correct_payload[1] = PAYLOAD_LEN;
diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index ee95144b73ac..221f27e57147 100755
--- a/tools/testing/selftests/drivers/net/gro.py
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -301,6 +301,7 @@ def _run_gro_bin(cfg, test_name, protocol=None, num_flows=None,
 
     # Tests specific to IPv4
     ipv4_tests = [
+        "ip_csum",
         "ip_ttl", "ip_opt", "ip_frag4",
         "ip_id_df1_inc", "ip_id_df1_fixed",
         "ip_id_df0_inc", "ip_id_df0_fixed",
-- 
2.53.0


