Return-Path: <netdev+bounces-143572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450BF9C30E2
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 05:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545591C20A8D
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 04:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AE9145B21;
	Sun, 10 Nov 2024 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YtY6tIkQ"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7239D2FA;
	Sun, 10 Nov 2024 04:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731214412; cv=none; b=VBZpcRV+3tdqBSvIMcV5hSr6PYVWBpyTgEzDQD+tOr9r/rRQEFRdEbmaKy0jLq+BmeI0csXiPZk+aRyAV9yxhvMEFZdV9Qmm0nNlvGkh0G2t4OZXlYp9r8AYTsrz7zePraj1zMfGPFF/lo2+88CAtHeNBu1bKbC4vyihcwAlqCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731214412; c=relaxed/simple;
	bh=Acy5eGAhWgxkyGU/f5UmK0PsdRN6Scg4QxeIp1wqEfs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CtEt1ERKfT6+8wl+bgwBXU8I2LQa1zlMt1FklZnysu4s5PTt4NawOy80EVROjN3lZ0rdY9/MzhQvaPIl75nruF6+VhtTm4x4PYmOLBkYKRU9IDA8zZHjp6wJVMRfpnZceAGlB8+AgxV1EFNGFBen9SijYycFUlOJHVPiWvyeiZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YtY6tIkQ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=k0aNs
	uiJeOW3JSrOJtiMNVEl/LdLoETA7BfyQ4D8UCo=; b=YtY6tIkQERLmtmQib+6G+
	fkhqIqzQL3pBtH0KBTAAyfATvdvlZDiO2JnfJ5xKZZ6/63hCfNSzGEn1WqyqH/WT
	Z+chtWP3HpYKBGYAMD5EaSIliqOdSnWgMLgEd999w3tyk+QggFgn6bc0qCoXKLXr
	5mVaRwHLP+phSVeipvwXoY=
Received: from localhost.localdomain (unknown [111.35.191.191])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBnsJgGPDBnwu2xBg--.36552S4;
	Sun, 10 Nov 2024 12:52:37 +0800 (CST)
From: David Wang <00107082@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH] net/core/net-procfs: use seq_put_decimal_ull_width() for decimal values in /proc/net/dev
Date: Sun, 10 Nov 2024 12:52:21 +0800
Message-Id: <20241110045221.4959-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBnsJgGPDBnwu2xBg--.36552S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr15Jr45Cry3Xr1Dtw4Utwb_yoWrXr1rpF
	y3KasIqr48Xr98tF1DJrZ2q34FqFySvF47W3ZrG3yfG3W5Xr95Jr1FgrW2kF1UG3yDAw45
	t3srWFyYy3yjgr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE1vVZUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMweTqmcwLjy4QQAAsx

seq_printf() is costy, when reading /proc/net/dev, profiling indicates
about 13% samples of seq_printf():
	dev_seq_show(98.350% 428046/435229)
	    dev_seq_printf_stats(99.777% 427092/428046)
		dev_get_stats(86.121% 367814/427092)
		    rtl8169_get_stats64(98.519% 362365/367814)
		    dev_fetch_sw_netstats(0.554% 2038/367814)
		    loopback_get_stats64(0.250% 919/367814)
		    dev_get_tstats64(0.077% 284/367814)
		    netdev_stats_to_stats64(0.051% 189/367814)
		    _find_next_bit(0.029% 106/367814)
		seq_printf(13.719% 58594/427092)
And on a system with one wireless interface, timing for 1 million rounds of
stress reading /proc/net/dev:
	real	0m51.828s
	user	0m0.225s
	sys	0m51.671s
On average, reading /proc/net/dev takes ~0.051ms

With this patch, extra costs parsing format string by seq_printf() can be
optimized out, and the timing for 1 million rounds of read is:
	real	0m49.127s
	user	0m0.295s
	sys	0m48.552s
On average, ~0.048ms reading /proc/net/dev, a ~6% improvement.

Even though dev_get_stats() takes up the majority of the reading process,
the improvement is still significant;
And the improvement may vary with the physical interface on the system.

Signed-off-by: David Wang <00107082@163.com>
---
 net/core/net-procfs.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
index fa6d3969734a..a0d6c5b32b58 100644
--- a/net/core/net-procfs.c
+++ b/net/core/net-procfs.c
@@ -46,23 +46,26 @@ static void dev_seq_printf_stats(struct seq_file *seq, struct net_device *dev)
 	struct rtnl_link_stats64 temp;
 	const struct rtnl_link_stats64 *stats = dev_get_stats(dev, &temp);
 
-	seq_printf(seq, "%6s: %7llu %7llu %4llu %4llu %4llu %5llu %10llu %9llu "
-		   "%8llu %7llu %4llu %4llu %4llu %5llu %7llu %10llu\n",
-		   dev->name, stats->rx_bytes, stats->rx_packets,
-		   stats->rx_errors,
-		   stats->rx_dropped + stats->rx_missed_errors,
-		   stats->rx_fifo_errors,
-		   stats->rx_length_errors + stats->rx_over_errors +
-		    stats->rx_crc_errors + stats->rx_frame_errors,
-		   stats->rx_compressed, stats->multicast,
-		   stats->tx_bytes, stats->tx_packets,
-		   stats->tx_errors, stats->tx_dropped,
-		   stats->tx_fifo_errors, stats->collisions,
-		   stats->tx_carrier_errors +
-		    stats->tx_aborted_errors +
-		    stats->tx_window_errors +
-		    stats->tx_heartbeat_errors,
-		   stats->tx_compressed);
+	seq_printf(seq, "%6s:", dev->name);
+	seq_put_decimal_ull_width(seq, " ", stats->rx_bytes, 7);
+	seq_put_decimal_ull_width(seq, " ", stats->rx_packets, 7);
+	seq_put_decimal_ull_width(seq, " ", stats->rx_errors, 4);
+	seq_put_decimal_ull_width(seq, " ", stats->rx_dropped + stats->rx_missed_errors, 4);
+	seq_put_decimal_ull_width(seq, " ", stats->rx_fifo_errors, 4);
+	seq_put_decimal_ull_width(seq, " ", stats->rx_length_errors + stats->rx_over_errors +
+				  stats->rx_crc_errors + stats->rx_frame_errors, 5);
+	seq_put_decimal_ull_width(seq, " ", stats->rx_compressed, 10);
+	seq_put_decimal_ull_width(seq, " ", stats->multicast, 9);
+	seq_put_decimal_ull_width(seq, " ", stats->tx_bytes, 8);
+	seq_put_decimal_ull_width(seq, " ", stats->tx_packets, 7);
+	seq_put_decimal_ull_width(seq, " ", stats->tx_errors, 4);
+	seq_put_decimal_ull_width(seq, " ", stats->tx_dropped, 4);
+	seq_put_decimal_ull_width(seq, " ", stats->tx_fifo_errors, 4);
+	seq_put_decimal_ull_width(seq, " ", stats->collisions, 5);
+	seq_put_decimal_ull_width(seq, " ", stats->tx_carrier_errors + stats->tx_aborted_errors +
+				  stats->tx_window_errors + stats->tx_heartbeat_errors, 7);
+	seq_put_decimal_ull_width(seq, " ", stats->tx_compressed, 10);
+	seq_putc(seq, '\n');
 }
 
 /*
-- 
2.39.2


