Return-Path: <netdev+bounces-188384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 396C3AAC9C1
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 17:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24F94675D4
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 15:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62055283C9F;
	Tue,  6 May 2025 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Qnl8UiwP"
X-Original-To: netdev@vger.kernel.org
Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135AA502BE;
	Tue,  6 May 2025 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746546193; cv=none; b=OrAUfWr28R19JhiDu6wHe9KHm8KjcEJ4MiJmnhNdoCUiSwG0mQJROZlCBXSN/p742HUaVjcdMuZR5YZH1lAElbH3mDUk6xG1zR+bu7qDjluzJ+ZzQJ38GxIz5HPqPHE8nTd2p/dlWvIybDtdyZk45hPPtu6YRvf6iOfYsIsLpkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746546193; c=relaxed/simple;
	bh=trOYAQt+u6g/+0ca/NPoUGlmZxBIAH+K7WGNZur1uT8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GnuOm9276O+OZXnIacky1Z1ThB1vACYVtLaGKCeKc6nnARufFcyCeafiaA1mrmkl1DOi645erTTrUWN3eTaqF/19wOLcZYDfiuwgFyJ9DghMzViQLJR9FtbDyHr5z2CtAlJIgCvMaKR1SCLO6QrD/1lKB7JeMdCzEHVY8mFReZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=Qnl8UiwP; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:921:0:640:f23d:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id EBBC1611F9;
	Tue,  6 May 2025 18:41:28 +0300 (MSK)
Received: from alex-shalimov-osx.yandex.net (unknown [2a02:6b8:b081:b12d::1:42])
	by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Lfe9O40FZiE0-e7d4r06C;
	Tue, 06 May 2025 18:41:27 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1746546088;
	bh=6Nj69zDpsZrIMdvpl4cIIhICll/FusHh4GXSyJ8JWdI=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=Qnl8UiwPDF4i7rvKqTXbsfWLqfcc8qi93odLfmP8eWVAEGU0lKONAzkaaBp/lm36H
	 ypEPFflClA/oT1zX53MX/BOP0ajoRmDF70wDCvfqoAzeiLVaDewdQYBkEPFoHn5JNS
	 2iAC6c3Ip1+jE6UkEX+7BfUrb++h/VMfM65Y3aTQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Alexander Shalimov <alex-shalimov@yandex-team.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Alexander Shalimov <alex-shalimov@yandex-team.ru>
Subject: [PATCH] net/tun: expose queue utilization stats via ethtool
Date: Tue,  6 May 2025 18:41:17 +0300
Message-Id: <20250506154117.10651-1-alex-shalimov@yandex-team.ru>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TUN/TAP devices are heavily used in network virtualization scenarios
such as QEMU/KVM with "-netdev tap" and are commonly paired with virtio-net
or vhost-net backends. Under high network load, queues of the tuntap device
may become saturated, resulting in TX drops.

Existing aggregated drop counters alone are often insufficient during
complex debugging and performance tuning, especially in high-throughput
environments. Visibility of real-time queue utilization is critical for
understanding why guest VMs might be unable to dequeue packets in time.

This patch exposes per-queue utilization statistics via ethtool -S,
allowing on-demand inspection of queue fill levels. Utilization metrics are
captured at the time of the ethtool invocation, providing a snapshot useful
for correlation with guest and host behavior.

Signed-off-by: Alexander Shalimov <alex-shalimov@yandex-team.ru>
---
 drivers/net/tun.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 7babd1e9a378..122327e591a5 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3537,6 +3537,57 @@ static void tun_get_channels(struct net_device *dev,
 	channels->max_combined = tun->flags & IFF_MULTI_QUEUE ? MAX_TAP_QUEUES : 1;
 }
 
+static void tun_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
+{
+	char *p = (char *)buf;
+	int i;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (i = 0; i < dev->real_num_tx_queues; i++) {
+			snprintf(p, ETH_GSTRING_LEN, "tx_queue_usage_%u", i);
+			p += ETH_GSTRING_LEN;
+		}
+		break;
+	}
+}
+
+static int tun_get_sset_count(struct net_device *dev, int sset)
+{
+	switch (sset) {
+	case ETH_SS_STATS:
+		return dev->real_num_tx_queues;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static void tun_get_ethtool_stats(struct net_device *dev,
+				  struct ethtool_stats *stats, u64 *data)
+{
+	struct tun_struct *tun = netdev_priv(dev);
+	struct tun_file *tfile;
+	int i;
+	int producer, consumer, size, usage;
+
+	rcu_read_lock();
+	for (i = 0; i < dev->real_num_tx_queues; i++) {
+		tfile = rcu_dereference(tun->tfiles[i]);
+
+		producer = READ_ONCE(tfile->tx_ring.producer);
+		consumer = READ_ONCE(tfile->tx_ring.consumer_head);
+		size = READ_ONCE(tfile->tx_ring.size);
+
+		if (producer >= consumer)
+			usage = producer - consumer;
+		else
+			usage = size - (consumer - producer);
+
+		data[i] = usage;
+	}
+	rcu_read_unlock();
+}
+
 static const struct ethtool_ops tun_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_RX_MAX_FRAMES,
 	.get_drvinfo	= tun_get_drvinfo,
@@ -3549,6 +3600,9 @@ static const struct ethtool_ops tun_ethtool_ops = {
 	.set_coalesce   = tun_set_coalesce,
 	.get_link_ksettings = tun_get_link_ksettings,
 	.set_link_ksettings = tun_set_link_ksettings,
+	.get_strings	    = tun_get_strings,
+	.get_sset_count	    = tun_get_sset_count,
+	.get_ethtool_stats  = tun_get_ethtool_stats,
 };
 
 static int tun_queue_resize(struct tun_struct *tun)
-- 
2.39.5 (Apple Git-154)


