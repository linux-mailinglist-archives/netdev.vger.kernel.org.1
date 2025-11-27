Return-Path: <netdev+bounces-242406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8895FC9029A
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 21:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD38D352958
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 20:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4DE328253;
	Thu, 27 Nov 2025 20:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dt9Zt17j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9193203AE
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 20:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764276283; cv=none; b=gHIBI+Y90bjZTJ/exq+CTAmnzGNp0SCm+CusIJ5T3SSq+VsbCldP4F2vNjj8HMZiV6PwH/3JQyndoqRnVzBOmmBm6Xn0T6nMXqpA0bj1IRXfEAOkv3tI5W4vJFNiLGrMSla/27AH6zhx4i5qjz+hlfWSMz8jXXZp8LBCum02eC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764276283; c=relaxed/simple;
	bh=2LyuBsPor15Og8w8FehldYD9uvgj0U/Qd8569PQOz/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltNI2606LOtdGZI6HS7rnkazkcYDuWAzjIhRm34ViTSPFwlwXAZBf+dLwu1Qlxmcm5B3GhuzV9p9tOFFd+P6N2BqIeas76mBhOF3eCJPOq4T9lhEhQSwSQHp4eQuZhYDs6h5LkZ1zxMsOA3thqqrjtuSXBaz488x1o4wtME5osM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dt9Zt17j; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b32900c8bso826167f8f.0
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764276280; x=1764881080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8Gbmeh89/N4kjz62es84Em0iR2fT9OzX01rnhn2RRU=;
        b=Dt9Zt17jvBDfWOm7l30BS/Oc9Qe4F/BCWiKv+NhmEU+EbZvJPCxVKJjkVJ7p05Qsk7
         f+8HMtAEyrJ/LQu9mxbnstQIKAqZWcOo7jj53Um9pLTE1/W5SgENl/f71t6civSLcKS6
         TaFFcDsqJ8YuQSea11TSOhuoTfDcqc3QveUkZsU0qlpRkGXJAJuyUJi2LeFrufincLTE
         mMa9vRq30CO//JeW4SAmfpybZg/NdMb02WZLscsQcs6SoNP9RKnwlzc4iHx/ow4os4XJ
         +rir21G5YO0AvWbqVK4MN9F94EakNOkiLfbxe7G9f8ik8N7dk+z8OCgg+COok/ENF4ZF
         7jiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764276280; x=1764881080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M8Gbmeh89/N4kjz62es84Em0iR2fT9OzX01rnhn2RRU=;
        b=XgCnes17eFgxFKqOhJVyctOKUDPfSkcMiee/EZngGn95lRMbWDjGRTXCSrrhVu7NSQ
         fbPERhohHy5LAeccOeuGpjRxo1nEdt4Quq0Xh7DlgivFS6q3t5eGk+yxy2hmsnxdfNju
         O40q3+C0Mz6bqW3ChK8Q0wl0GrG4t8rQeJL/2i23c4nDLGRlX8gWQOqru0nKe4oP+yAi
         A5OpHpKopCLL828Cs+3zZrH7wtzy2sdQWln1qA8l0Z871w/csj/VTIfUi7qKAfAHaA85
         +UmrEmG7KniymHq8QF3vO8Wy+oo6BH/Vgd4e3DmxfOAHabCH1oDg98AknCxBt/3ghe1N
         e+Pg==
X-Gm-Message-State: AOJu0YyyXEmqV43SwW2eCTkGxH2yabhfusvBcAWuK6lrvwnqYzxg3faj
	kqtLPJN+qzqKUdft0I+0ZqZ1hCeOPPLH9IL5T2dF3v7ptujyGxNOnd8u9ft1MA==
X-Gm-Gg: ASbGncsRk3AZx66DwN8WiYMtnSzDlNj06EBGz1im3DZFftWYU6NkX3Wvz/Nium6HaDD
	pQ2GxE0vSlf644LGKxThDvlON5jg0oKdmjkESudntBsufZdIQ8emiXKoigdOYLyGZQl/IYg+xjc
	EeJo9HeHoTQi+GlFGus6Z/PctYOy13TSRv8KS8nk/EZhR0FB1e2nDZrymRxKrORvme+5KJ8tyx6
	MjNnZcVVrNCpljg+qTaJ8nrGiUdVxmMnKAXS/WWv22q2i29pb/isIjcHDzMjFrMFRpZx661nzPZ
	LbqTAWrU7RgGTKhh66IOpB01VaY6+a5KqoC0qsD1WzEKFJd9yP/2/C/YYQk5Pnfve/KviGmWP8b
	ARsWs1QZ0hR6sUbatogLxIirzF6rxTgUF2Y+WsKHWWVZWdsjYwmlltf1a4wYgrQaxaUqlbUAb6/
	n8KcxRd9dZr/vVTQ==
X-Google-Smtp-Source: AGHT+IGuV2DWxNxvizrrGr6FH3gzPVUslsgMTwKhOGOXoIvvKJIWs4/U+A5R9xyG+U9svjhm0G8y7A==
X-Received: by 2002:a05:6000:26c9:b0:42b:30f9:79b6 with SMTP id ffacd0b85a97d-42cc1d62843mr26242387f8f.58.1764276279891;
        Thu, 27 Nov 2025 12:44:39 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5d614asm5346105f8f.12.2025.11.27.12.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 12:44:39 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	io-uring@vger.kernel.org,
	dtatulea@nvidia.com
Subject: [PATCH net-next v6 8/8] selftests: iou-zcrx: test large chunk sizes
Date: Thu, 27 Nov 2025 20:44:21 +0000
Message-ID: <ef9cc9f58d60656a8afef1fc84f066aeb7b27378.1764264798.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764264798.git.asml.silence@gmail.com>
References: <cover.1764264798.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test using large chunks for zcrx memory area.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 .../selftests/drivers/net/hw/iou-zcrx.c       | 72 +++++++++++++++----
 .../selftests/drivers/net/hw/iou-zcrx.py      | 37 ++++++++++
 2 files changed, 97 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
index 62456df947bc..fed5452e2ca3 100644
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
@@ -12,6 +12,7 @@
 #include <unistd.h>
 
 #include <arpa/inet.h>
+#include <linux/mman.h>
 #include <linux/errqueue.h>
 #include <linux/if_packet.h>
 #include <linux/ipv6.h>
@@ -37,6 +38,23 @@
 
 #include <liburing.h>
 
+#define SKIP_CODE	42
+
+struct t_io_uring_zcrx_ifq_reg {
+	__u32	if_idx;
+	__u32	if_rxq;
+	__u32	rq_entries;
+	__u32	flags;
+
+	__u64	area_ptr; /* pointer to struct io_uring_zcrx_area_reg */
+	__u64	region_ptr; /* struct io_uring_region_desc * */
+
+	struct io_uring_zcrx_offsets offsets;
+	__u32	zcrx_id;
+	__u32	rx_buf_len;
+	__u64	__resv[3];
+};
+
 static long page_size;
 #define AREA_SIZE (8192 * page_size)
 #define SEND_SIZE (512 * 4096)
@@ -65,6 +83,8 @@ static bool cfg_oneshot;
 static int cfg_oneshot_recvs;
 static int cfg_send_size = SEND_SIZE;
 static struct sockaddr_in6 cfg_addr;
+static unsigned cfg_rx_buf_len = 0;
+static bool cfg_dry_run;
 
 static char *payload;
 static void *area_ptr;
@@ -128,14 +148,28 @@ static void setup_zcrx(struct io_uring *ring)
 	if (!ifindex)
 		error(1, 0, "bad interface name: %s", cfg_ifname);
 
-	area_ptr = mmap(NULL,
-			AREA_SIZE,
-			PROT_READ | PROT_WRITE,
-			MAP_ANONYMOUS | MAP_PRIVATE,
-			0,
-			0);
-	if (area_ptr == MAP_FAILED)
-		error(1, 0, "mmap(): zero copy area");
+	if (cfg_rx_buf_len && cfg_rx_buf_len != page_size) {
+		area_ptr = mmap(NULL,
+				AREA_SIZE,
+				PROT_READ | PROT_WRITE,
+				MAP_ANONYMOUS | MAP_PRIVATE |
+				MAP_HUGETLB | MAP_HUGE_2MB,
+				-1,
+				0);
+		if (area_ptr == MAP_FAILED) {
+			printf("Can't allocate huge pages\n");
+			exit(SKIP_CODE);
+		}
+	} else {
+		area_ptr = mmap(NULL,
+				AREA_SIZE,
+				PROT_READ | PROT_WRITE,
+				MAP_ANONYMOUS | MAP_PRIVATE,
+				0,
+				0);
+		if (area_ptr == MAP_FAILED)
+			error(1, 0, "mmap(): zero copy area");
+	}
 
 	ring_size = get_refill_ring_size(rq_entries);
 	ring_ptr = mmap(NULL,
@@ -157,17 +191,23 @@ static void setup_zcrx(struct io_uring *ring)
 		.flags = 0,
 	};
 
-	struct io_uring_zcrx_ifq_reg reg = {
+	struct t_io_uring_zcrx_ifq_reg reg = {
 		.if_idx = ifindex,
 		.if_rxq = cfg_queue_id,
 		.rq_entries = rq_entries,
 		.area_ptr = (__u64)(unsigned long)&area_reg,
 		.region_ptr = (__u64)(unsigned long)&region_reg,
+		.rx_buf_len = cfg_rx_buf_len,
 	};
 
-	ret = io_uring_register_ifq(ring, &reg);
-	if (ret)
+	ret = io_uring_register_ifq(ring, (void *)&reg);
+	if (cfg_rx_buf_len && (ret == -EINVAL || ret == -EOPNOTSUPP ||
+			       ret == -ERANGE)) {
+		printf("Large chunks are not supported %i\n", ret);
+		exit(SKIP_CODE);
+	} else if (ret) {
 		error(1, 0, "io_uring_register_ifq(): %d", ret);
+	}
 
 	rq_ring.khead = (unsigned int *)((char *)ring_ptr + reg.offsets.head);
 	rq_ring.ktail = (unsigned int *)((char *)ring_ptr + reg.offsets.tail);
@@ -323,6 +363,8 @@ static void run_server(void)
 	io_uring_queue_init(512, &ring, flags);
 
 	setup_zcrx(&ring);
+	if (cfg_dry_run)
+		return;
 
 	add_accept(&ring, fd);
 
@@ -383,7 +425,7 @@ static void parse_opts(int argc, char **argv)
 		usage(argv[0]);
 	cfg_payload_len = max_payload_len;
 
-	while ((c = getopt(argc, argv, "sch:p:l:i:q:o:z:")) != -1) {
+	while ((c = getopt(argc, argv, "sch:p:l:i:q:o:z:x:d")) != -1) {
 		switch (c) {
 		case 's':
 			if (cfg_client)
@@ -418,6 +460,12 @@ static void parse_opts(int argc, char **argv)
 		case 'z':
 			cfg_send_size = strtoul(optarg, NULL, 0);
 			break;
+		case 'x':
+			cfg_rx_buf_len = page_size * strtoul(optarg, NULL, 0);
+			break;
+		case 'd':
+			cfg_dry_run = true;
+			break;
 		}
 	}
 
diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index 712c806508b5..83061b27f2f2 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -7,6 +7,7 @@ from lib.py import ksft_run, ksft_exit, KsftSkipEx
 from lib.py import NetDrvEpEnv
 from lib.py import bkg, cmd, defer, ethtool, rand_port, wait_port_listen
 
+SKIP_CODE = 42
 
 def _get_current_settings(cfg):
     output = ethtool(f"-g {cfg.ifname}", json=True)[0]
@@ -132,6 +133,42 @@ def test_zcrx_rss(cfg) -> None:
         cmd(tx_cmd, host=cfg.remote)
 
 
+def test_zcrx_large_chunks(cfg) -> None:
+    cfg.require_ipver('6')
+
+    combined_chans = _get_combined_channels(cfg)
+    if combined_chans < 2:
+        raise KsftSkipEx('at least 2 combined channels required')
+    (rx_ring, hds_thresh) = _get_current_settings(cfg)
+    port = rand_port()
+
+    ethtool(f"-G {cfg.ifname} tcp-data-split on")
+    defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto")
+
+    ethtool(f"-G {cfg.ifname} hds-thresh 0")
+    defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}")
+
+    ethtool(f"-G {cfg.ifname} rx 64")
+    defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}")
+
+    ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}")
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    flow_rule_id = _set_flow_rule(cfg, port, combined_chans - 1)
+    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
+
+    rx_cmd = f"{cfg.bin_local} -s -p {port} -i {cfg.ifname} -q {combined_chans - 1} -x 2"
+    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {port} -l 12840"
+
+    probe = cmd(rx_cmd + " -d", fail=False)
+    if probe.ret == SKIP_CODE:
+        raise KsftSkipEx(probe.stdout)
+
+    with bkg(rx_cmd, exit_wait=True):
+        wait_port_listen(port, proto="tcp")
+        cmd(tx_cmd, host=cfg.remote)
+
+
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
         cfg.bin_local = path.abspath(path.dirname(__file__) + "/../../../drivers/net/hw/iou-zcrx")
-- 
2.52.0


