Return-Path: <netdev+bounces-274765-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNj0KYv6zmn7sAYAu9opvQ
	(envelope-from <netdev+bounces-274765-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:23:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1E738F2FE
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B2F83064697
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 23:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83CE3A641C;
	Thu,  2 Apr 2026 23:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="CNJijNab"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6057B3A1A55
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 23:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775172165; cv=none; b=ia0VzAYk4oiAV6blGZ+ObA9jEBIRnI65SmCBvu6NzTNs7FZ2DNSsk/TDdZy1+ae7YPYrr655TtyKcjVX31kQS/9uOvczLVfl9iOVFQxmoRfWOI6Ybv83TxHmn2zLW6ic0kJrwXAuivTaMEX/sZ9H5JkZCIzI6Oz3mGDky3c02I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775172165; c=relaxed/simple;
	bh=Tjl8imYH1OqXLWE1hPP3jcyr3QCjzn5ejtwy1XlU14c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqOusMeTJLEWHlv1NEpxS9v+DTZa+YXf5TIqjJjGqkeQhs97uNu4LfM4GhGXLnXFJdwTRZrPgoGsMRo9D4L9OcA0CtyA4vMPpRmQ53FNjyGymoIMzHJQcjOLxToa8dbkl6sklEqesYkhgUVsvp7D+E5Gk27o9LRewBZAVMoMS5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=CNJijNab; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so652742b3a.3
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 16:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775172163; x=1775776963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Syye3jGbYJUGP9iil2Gf3tWEkqi92NaZ66fdyleX4E8=;
        b=CNJijNabvExYIGaObQNLzgv9yFh6J2hhDbMpfvlv3j0cS0QRWRFj+PLaRkHdimwYOA
         xxnihqq0KFrDxQywV6mcf9y5w1BJKKF4ISFqJFlutgpeQUwo7d/x0gulT0cpoTbSyF7o
         LSeFvKi4oIxHr2F3ZsRymVTqN6eTOWJapchTz8JY60gx7363UK7TVIsyXia0MbGEnPIo
         kdmDTPlWD7pqacX9ZMoOFkwr//XfRxDnBdiT4NXsR1JWo019XLYx01hIZ99E/ctfdeq6
         SHuElnk9jxHPhsryLNqn9QfSIWOeYhIJeqAXpq0Ze6S+dMWehlRDqjfDrk0pu2ZDAqhT
         py7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775172163; x=1775776963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Syye3jGbYJUGP9iil2Gf3tWEkqi92NaZ66fdyleX4E8=;
        b=Ir+c5N6s1CpZkaxtp4qMi9hyT4D80okt3EvQaHEM2EtImi3h8+znhqHu7/whycdFf2
         VDbr4e8ivY12EG1oRomR7hKx1KObvN7SNBcnA/iLyQ+EMJXkTcO1OjCkhnRhuKWhGudD
         sIM09dkps6tGZbOK+YaXsNMHQrRJuBPw9MaJDrS4b5Nk823Fy+Pqjc7UNUufX9x4Q1Nu
         vNX4IAIcKfR1irBvTHAP7YdH2hS0hXOoPF0fJCAYfEbng6OTSG/I0IiiE0NjG/AN1kTL
         3X7eVc13Yw4zMruep4zMPWdcH5gbUYwZ64k3n2vVcFSt8GZO+ybmNi3xC1Txgz+1TwPd
         1DAQ==
X-Gm-Message-State: AOJu0YzN3OMFgc7aBA+3KZ3K4uHZv5GPNJV18iBHHQK9KSGxEUwY19DZ
	QY+Q/OyCxzvlqplMfqQIm9YfJ72pYu6VaGi+LolZxojuQQP4XE2CgKamn0tNlEOJWRM4oEqPgt3
	Lyq+seJM=
X-Gm-Gg: ATEYQzy2dXYU8GRzOaKmKX/61KZlJGrd6otM8Mm8c+nysg2bIealTQ8H5kwVv6UWc/o
	9/8OPJN2zfPtS8Lp/NdY5269LmIUksHrT50/IrtCyPIbmq3+T939a+ugStP2BCbeVsu+QVt/YF5
	NzVF+EkW54TIrf9r8g1AGAQomwC3yMkIzMjEc7oqyFMcy8+DlyoegSyf2tPa10pm4DuuAd2NVzG
	CG4H3LHt9EW8RzoGulD621E5p5lVLXlFRLI71GYcdmX5XapglNvmpeydERIzQ3w9PV3+ZKqKqIY
	nric2Jwlcq6k3Tw2sRhQuFGi8poi+UyNzY60WpQB0Iqa0iBqAq64tiJzEbgxpp+tHobD54jyO7r
	9mMLtETf/efhR+l4x1zXRUvWmbUAd0znYflriAsLgZh+EBU21FM+yE6j/sQxyB/8/EQTT5bLZSO
	j4qCu5
X-Received: by 2002:a05:6a00:4b53:b0:82c:e1a3:986f with SMTP id d2e1a72fcca58-82d0db93629mr734500b3a.43.1775172163414;
        Thu, 02 Apr 2026 16:22:43 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:47::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3ccc8sm5445968b3a.19.2026.04.02.16.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 16:22:43 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	willemb@google.com,
	Joe Damato <joe@dama.to>,
	linux-kselftest@vger.kernel.org
Subject: [net-next 2/3] selftests/net: Test PACKET_STATISTICS drops
Date: Thu,  2 Apr 2026 16:21:58 -0700
Message-ID: <20260402232203.2004496-3-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402232203.2004496-1-joe@dama.to>
References: <20260402232203.2004496-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-274765-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama-to.20251104.gappssmtp.com:dkim,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: 5F1E738F2FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend psock_snd to test drops by setting a tiny receive buffer and
sending a large burst of packets.

Signed-off-by: Joe Damato <joe@dama.to>
---
 tools/testing/selftests/net/psock_snd.c  | 52 ++++++++++++++++++++----
 tools/testing/selftests/net/psock_snd.sh |  5 +++
 2 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/psock_snd.c b/tools/testing/selftests/net/psock_snd.c
index 5be481a3d2bd..7bbce274b9f0 100644
--- a/tools/testing/selftests/net/psock_snd.c
+++ b/tools/testing/selftests/net/psock_snd.c
@@ -39,6 +39,7 @@ static bool	cfg_use_gso;
 static bool	cfg_use_qdisc_bypass;
 static bool	cfg_use_vlan;
 static bool	cfg_use_vnet;
+static bool	cfg_drop;
 
 static char	*cfg_ifname = "lo";
 static int	cfg_mtu	= 1500;
@@ -49,6 +50,8 @@ static uint16_t	cfg_port = 8000;
 /* test sending up to max mtu + 1 */
 #define TEST_SZ	(sizeof(struct virtio_net_hdr) + ETH_HLEN + ETH_MAX_MTU + 1)
 
+#define BURST_CNT (1000)
+
 static char tbuf[TEST_SZ], rbuf[TEST_SZ];
 
 static unsigned long add_csum_hword(const uint16_t *start, int num_u16)
@@ -212,13 +215,14 @@ static void do_send(int fd, char *buf, int len)
 	if (ret != len)
 		error(1, 0, "write: %u %u", ret, len);
 
-	fprintf(stderr, "tx: %u\n", ret);
+	if (!cfg_drop)
+		fprintf(stderr, "tx: %u\n", ret);
 }
 
-static int do_tx(void)
+static int do_tx(bool burst)
 {
 	const int one = 1;
-	int fd, len;
+	int i, fd, len;
 
 	fd = socket(PF_PACKET, cfg_use_dgram ? SOCK_DGRAM : SOCK_RAW, 0);
 	if (fd == -1)
@@ -242,6 +246,10 @@ static int do_tx(void)
 
 	do_send(fd, tbuf, len);
 
+	if (burst)
+		for (i = 0; i < BURST_CNT; i++)
+			do_send(fd, tbuf, len);
+
 	if (close(fd))
 		error(1, errno, "close t");
 
@@ -290,6 +298,7 @@ static void do_rx(int fd, int expected_len, char *expected)
 static int setup_sniffer(void)
 {
 	struct timeval tv = { .tv_usec = 100 * 1000 };
+	const int one = 1;
 	int fd;
 
 	fd = socket(PF_PACKET, SOCK_RAW, 0);
@@ -299,6 +308,10 @@ static int setup_sniffer(void)
 	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)))
 		error(1, errno, "setsockopt rcv timeout");
 
+	if (cfg_drop)
+		if (setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &one, sizeof(one)))
+			error(1, errno, "setsockopt SO_RCVBUF");
+
 	pair_udp_setfilter(fd);
 	do_bind(fd);
 
@@ -309,7 +322,7 @@ static void parse_opts(int argc, char **argv)
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "bcCdgl:qt:vV")) != -1) {
+	while ((c = getopt(argc, argv, "bcCdDgl:qt:vV")) != -1) {
 		switch (c) {
 		case 'b':
 			cfg_use_bind = true;
@@ -323,6 +336,9 @@ static void parse_opts(int argc, char **argv)
 		case 'd':
 			cfg_use_dgram = true;
 			break;
+		case 'D':
+			cfg_drop = true;
+			break;
 		case 'g':
 			cfg_use_gso = true;
 			break;
@@ -367,11 +383,23 @@ static void check_packet_stats(int fd)
 	if (getsockopt(fd, SOL_PACKET, PACKET_STATISTICS, &st, &len))
 		error(1, errno, "getsockopt packet statistics");
 
-	if (st.tp_packets != 1)
-		error(1, 0, "stats: tp_packets %u != 1", st.tp_packets);
+	if (cfg_drop) {
+		/* PACKET_STATISTICS reports all packets seen (including
+		 * drops) in tp_packets
+		 */
+		if (st.tp_packets < st.tp_drops)
+			error(1, 0, "stats: tp_packets %u < tp_drops %u",
+			      st.tp_packets, st.tp_drops);
 
-	if (st.tp_drops != 0)
-		error(1, 0, "stats: tp_drops %u != 0", st.tp_drops);
+		if (st.tp_drops == 0)
+			error(1, 0, "stats: expected drops but tp_drops == 0");
+	} else {
+		if (st.tp_packets != 1)
+			error(1, 0, "stats: tp_packets %u != 1", st.tp_packets);
+
+		if (st.tp_drops != 0)
+			error(1, 0, "stats: tp_drops %u != 0", st.tp_drops);
+	}
 
 	/* verify clear on read */
 	memset(&st, 0xff, sizeof(st));
@@ -394,7 +422,12 @@ static void run_test(void)
 	fdr = setup_rx();
 	fds = setup_sniffer();
 
-	total_len = do_tx();
+	total_len = do_tx(cfg_drop);
+
+	if (cfg_drop) {
+		check_packet_stats(fds);
+		goto out;
+	}
 
 	/* BPF filter accepts only this length, vlan changes MAC */
 	if (cfg_payload_len == DATA_LEN && !cfg_use_vlan) {
@@ -405,6 +438,7 @@ static void run_test(void)
 
 	do_rx(fdr, cfg_payload_len, tbuf + total_len - cfg_payload_len);
 
+out:
 	if (close(fds))
 		error(1, errno, "close s");
 	if (close(fdr))
diff --git a/tools/testing/selftests/net/psock_snd.sh b/tools/testing/selftests/net/psock_snd.sh
index 1cbfeb5052ec..b6ef12fad5d5 100755
--- a/tools/testing/selftests/net/psock_snd.sh
+++ b/tools/testing/selftests/net/psock_snd.sh
@@ -92,4 +92,9 @@ echo "raw gso max size"
 echo "raw gso max size + 1 (expected to fail)"
 (! ./in_netns.sh ./psock_snd -v -c -g -l "${max_mss_exceeds}")
 
+# test drops statistics
+
+echo "test drops statistics"
+./in_netns.sh ./psock_snd -D
+
 echo "OK. All tests passed"
-- 
2.52.0


