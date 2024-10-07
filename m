Return-Path: <netdev+bounces-132679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E39992C41
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF03A1F22DF6
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CB21D47D9;
	Mon,  7 Oct 2024 12:42:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE341D415D;
	Mon,  7 Oct 2024 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304922; cv=none; b=j3FCeIbV3ZgBLbu5HjnqtY+C0NzKRYL7fCM0YUu/6vFBGTZuP3Zlx2Ups5DFrvChnmack4YZytkf+lQ+19YwEQw1zpAjtGAkbjhb+x9Qnl8/tktZq5hcEIgxash7WNpgR9t2Dyhz3kVRkNPrzoUQeMWoTm0oDQrq9FcNzg80EoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304922; c=relaxed/simple;
	bh=cZhV2qPiFjDdEQqGl5oq97yO4OM1xzFW6BUmRKYsNDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHdccNcXf3x8JZVbOALThvNPa5G/Q4eOynnSask29i5scx8mK7Dvt72ZUqx806YCr9wahFMZ8c4JJ/Pa+jetCYMpH740Jb0CzwBMssAmYk9TJGsFEjdDEsdQXJVQAiiI78/SdZhaLuzukwYDM25dNuHGlPIOXCqtTgcQiH801ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XMdw56TrTz6LCxH;
	Mon,  7 Oct 2024 20:37:41 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 40DAA140680;
	Mon,  7 Oct 2024 20:41:58 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 7 Oct
 2024 14:41:53 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v01 3/4] selftests: net/psock_fanout: restore loopback up/down state on exit
Date: Mon, 7 Oct 2024 15:40:26 +0300
Message-ID: <7b2cb791fb402b88e22013ae012363d596befb50.1728303615.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1728303615.git.gur.stavi@huawei.com>
References: <cover.1728303615.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 frapeml500005.china.huawei.com (7.182.85.13)

Minimize the risk that psock_fanout leaves loopback device in a different
state than the start state.

Restore loopback up/down state when test reaches end of main.
For abort on errors, globally replace all 'exit' with 'cleanup_and_exit'
that restores loopback up/down state.

Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
---
 tools/testing/selftests/net/psock_fanout.c | 73 +++++++++++-----------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/tools/testing/selftests/net/psock_fanout.c b/tools/testing/selftests/net/psock_fanout.c
index a8b22494a635..64edcd661d43 100644
--- a/tools/testing/selftests/net/psock_fanout.c
+++ b/tools/testing/selftests/net/psock_fanout.c
@@ -108,7 +108,7 @@ static int sock_fanout_open(uint16_t typeflags, uint16_t group_id)
 	fd = socket(PF_PACKET, SOCK_RAW, 0);
 	if (fd < 0) {
 		perror("socket packet");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 
 	pair_udp_setfilter(fd);
@@ -118,11 +118,11 @@ static int sock_fanout_open(uint16_t typeflags, uint16_t group_id)
 	addr.sll_ifindex = if_nametoindex("lo");
 	if (addr.sll_ifindex == 0) {
 		perror("if_nametoindex");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 	if (bind(fd, (void *) &addr, sizeof(addr))) {
 		perror("bind packet");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 
 	if (cfg_max_num_members) {
@@ -139,7 +139,7 @@ static int sock_fanout_open(uint16_t typeflags, uint16_t group_id)
 	if (err) {
 		if (close(fd)) {
 			perror("close packet");
-			exit(1);
+			cleanup_and_exit(1);
 		}
 		return -1;
 	}
@@ -161,7 +161,7 @@ static void sock_fanout_set_cbpf(int fd)
 	if (setsockopt(fd, SOL_PACKET, PACKET_FANOUT_DATA, &bpf_prog,
 		       sizeof(bpf_prog))) {
 		perror("fanout data cbpf");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 }
 
@@ -173,7 +173,7 @@ static void sock_fanout_getopts(int fd, uint16_t *typeflags, uint16_t *group_id)
 	if (getsockopt(fd, SOL_PACKET, PACKET_FANOUT,
 		       &sockopt, &sockopt_len)) {
 		perror("failed to getsockopt");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 	*typeflags = sockopt >> 16;
 	*group_id = sockopt & 0xfffff;
@@ -211,17 +211,17 @@ static void sock_fanout_set_ebpf(int fd)
 	if (pfd < 0) {
 		perror("bpf");
 		fprintf(stderr, "bpf verifier:\n%s\n", log_buf);
-		exit(1);
+		cleanup_and_exit(1);
 	}
 
 	if (setsockopt(fd, SOL_PACKET, PACKET_FANOUT_DATA, &pfd, sizeof(pfd))) {
 		perror("fanout data ebpf");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 
 	if (close(pfd)) {
 		perror("close ebpf");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 }
 
@@ -239,19 +239,19 @@ static char *sock_fanout_open_ring(int fd)
 	if (setsockopt(fd, SOL_PACKET, PACKET_VERSION, (void *) &val,
 		       sizeof(val))) {
 		perror("packetsock ring setsockopt version");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 	if (setsockopt(fd, SOL_PACKET, PACKET_RX_RING, (void *) &req,
 		       sizeof(req))) {
 		perror("packetsock ring setsockopt");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 
 	ring = mmap(0, req.tp_block_size * req.tp_block_nr,
 		    PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
 	if (ring == MAP_FAILED) {
 		perror("packetsock ring mmap");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 
 	return ring;
@@ -297,7 +297,7 @@ static void test_control_single(void)
 	if (sock_fanout_open(PACKET_FANOUT_ROLLOVER |
 			       PACKET_FANOUT_FLAG_ROLLOVER, 0) != -1) {
 		fprintf(stderr, "ERROR: opened socket with dual rollover\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 }
 
@@ -311,30 +311,30 @@ static void test_control_group(void)
 	fds[0] = sock_fanout_open(PACKET_FANOUT_HASH, 0);
 	if (fds[0] == -1) {
 		fprintf(stderr, "ERROR: failed to open HASH socket\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 	if (sock_fanout_open(PACKET_FANOUT_HASH |
 			       PACKET_FANOUT_FLAG_DEFRAG, 0) != -1) {
 		fprintf(stderr, "ERROR: joined group with wrong flag defrag\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 	if (sock_fanout_open(PACKET_FANOUT_HASH |
 			       PACKET_FANOUT_FLAG_ROLLOVER, 0) != -1) {
 		fprintf(stderr, "ERROR: joined group with wrong flag ro\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 	if (sock_fanout_open(PACKET_FANOUT_CPU, 0) != -1) {
 		fprintf(stderr, "ERROR: joined group with wrong mode\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 	fds[1] = sock_fanout_open(PACKET_FANOUT_HASH, 0);
 	if (fds[1] == -1) {
 		fprintf(stderr, "ERROR: failed to join group\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 	if (close(fds[1]) || close(fds[0])) {
 		fprintf(stderr, "ERROR: closing sockets\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 }
 
@@ -349,21 +349,21 @@ static void test_control_group_max_num_members(void)
 	cfg_max_num_members = (1 << 16) + 1;
 	if (sock_fanout_open(PACKET_FANOUT_HASH, 0) != -1) {
 		fprintf(stderr, "ERROR: max_num_members > PACKET_FANOUT_MAX\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 
 	cfg_max_num_members = 256;
 	fds[0] = sock_fanout_open(PACKET_FANOUT_HASH, 0);
 	if (fds[0] == -1) {
 		fprintf(stderr, "ERROR: failed open\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 
 	/* expected failure on joining group with different max_num_members */
 	cfg_max_num_members = 257;
 	if (sock_fanout_open(PACKET_FANOUT_HASH, 0) != -1) {
 		fprintf(stderr, "ERROR: set different max_num_members\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 
 	/* success on joining group with same max_num_members */
@@ -371,7 +371,7 @@ static void test_control_group_max_num_members(void)
 	fds[1] = sock_fanout_open(PACKET_FANOUT_HASH, 0);
 	if (fds[1] == -1) {
 		fprintf(stderr, "ERROR: failed to join group\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 
 	/* success on joining group with max_num_members unspecified */
@@ -379,12 +379,12 @@ static void test_control_group_max_num_members(void)
 	fds[2] = sock_fanout_open(PACKET_FANOUT_HASH, 0);
 	if (fds[2] == -1) {
 		fprintf(stderr, "ERROR: failed to join group\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 
 	if (close(fds[2]) || close(fds[1]) || close(fds[0])) {
 		fprintf(stderr, "ERROR: closing sockets\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 }
 
@@ -400,25 +400,25 @@ static void test_unique_fanout_group_ids(void)
 				  PACKET_FANOUT_FLAG_UNIQUEID, 0);
 	if (fds[0] == -1) {
 		fprintf(stderr, "ERROR: failed to create a unique id group.\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 
 	sock_fanout_getopts(fds[0], &typeflags, &first_group_id);
 	if (typeflags != PACKET_FANOUT_HASH) {
 		fprintf(stderr, "ERROR: unexpected typeflags %x\n", typeflags);
-		exit(1);
+		cleanup_and_exit(1);
 	}
 
 	if (sock_fanout_open(PACKET_FANOUT_CPU, first_group_id) != -1) {
 		fprintf(stderr, "ERROR: joined group with wrong type.\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 
 	fds[1] = sock_fanout_open(PACKET_FANOUT_HASH, first_group_id);
 	if (fds[1] == -1) {
 		fprintf(stderr,
 			"ERROR: failed to join previously created group.\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 
 	fds[2] = sock_fanout_open(PACKET_FANOUT_HASH |
@@ -426,7 +426,7 @@ static void test_unique_fanout_group_ids(void)
 	if (fds[2] == -1) {
 		fprintf(stderr,
 			"ERROR: failed to create a second unique id group.\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 
 	sock_fanout_getopts(fds[2], &typeflags, &second_group_id);
@@ -434,12 +434,12 @@ static void test_unique_fanout_group_ids(void)
 			     second_group_id) != -1) {
 		fprintf(stderr,
 			"ERROR: specified a group id when requesting unique id\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 
 	if (close(fds[0]) || close(fds[1]) || close(fds[2])) {
 		fprintf(stderr, "ERROR: closing sockets\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 }
 
@@ -459,7 +459,7 @@ static int test_datapath(uint16_t typeflags, int port_off,
 	fds[1] = sock_fanout_open(typeflags, 0);
 	if (fds[0] == -1 || fds[1] == -1) {
 		fprintf(stderr, "ERROR: failed open\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 	if (type == PACKET_FANOUT_CBPF)
 		sock_fanout_set_cbpf(fds[0]);
@@ -485,13 +485,13 @@ static int test_datapath(uint16_t typeflags, int port_off,
 	if (munmap(rings[1], RING_NUM_FRAMES * getpagesize()) ||
 	    munmap(rings[0], RING_NUM_FRAMES * getpagesize())) {
 		fprintf(stderr, "close rings\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 	if (close(fds_udp[1][1]) || close(fds_udp[1][0]) ||
 	    close(fds_udp[0][1]) || close(fds_udp[0][0]) ||
 	    close(fds[1]) || close(fds[0])) {
 		fprintf(stderr, "close datapath\n");
-		exit(1);
+		cleanup_and_exit(1);
 	}
 
 	return ret;
@@ -506,7 +506,7 @@ static int set_cpuaffinity(int cpuid)
 	if (sched_setaffinity(0, sizeof(mask), &mask)) {
 		if (errno != EINVAL) {
 			fprintf(stderr, "setaffinity %d\n", cpuid);
-			exit(1);
+			cleanup_and_exit(1);
 		}
 		return 1;
 	}
@@ -569,6 +569,7 @@ int main(int argc, char **argv)
 	ret |= test_datapath(PACKET_FANOUT_FLAG_UNIQUEID, port_off,
 			     expect_uniqueid[0], expect_uniqueid[1]);
 
+	loopback_up_down_restore();
 	if (ret)
 		return 1;
 
-- 
2.45.2


