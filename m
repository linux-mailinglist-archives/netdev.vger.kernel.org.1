Return-Path: <netdev+bounces-100414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8D08FA726
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 02:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E095F285F73
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 00:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AE5D534;
	Tue,  4 Jun 2024 00:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LKpKY3TT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D29611B
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 00:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717462011; cv=none; b=OTXMy69H6pjenIJm8t4QYZGsRGRInjUVf17nOZgVrTQNepMl8XwVXkI/RHAXe08yAqUM6gI4BIvBwBtV86AD4ISO0ujvlCP0CyxnujM4mUfLdaphNRsoWhn6ft4IgE29kIWJqEl2bJIKoY1YHwuAubxmazHPSrbFyIxh82iCo+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717462011; c=relaxed/simple;
	bh=xeCNQPpqwLr+yySpDhWmVdshfjNVE2u1ej0vOZenWDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sOlvYib33YfUtIcpz1C0tdp5WrcvVwQxLCAL+BG1+Lq+vz9VxMgNDTph1y3Wcvu96K67AsW4BjCkulPR7OqTFw2U9ZEG+OMTjw85tc6iiEAXFsCT7VkK+CjHIkAMimRl8u9peC2cdAU1W4gkBzWTrGfMNBbEbshz7GvULxbEO+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LKpKY3TT; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-702508bf0a9so2580070b3a.0
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 17:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1717462009; x=1718066809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRNmM+KNU8Jfr/J37h41UJmq3f6CvWN8UWrAkvJOyKs=;
        b=LKpKY3TTRqwQqFsY5o6UhHJgIL6KQEDy3ioMRKcqew7o6M+kUMtzSrObdvEc4L8Cv/
         HmEFbFkpziIHejIZ9rjd5hlrifzID0AfpsTYsLa7y/mNTRtBvtH3UYhBuBbmdW0FWfRP
         aaa0pxVa6awqGAIEhCQZJNfH5vqxaPg0iaoIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717462009; x=1718066809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRNmM+KNU8Jfr/J37h41UJmq3f6CvWN8UWrAkvJOyKs=;
        b=Ptqoihl7qPKDg3vVaMQCur7SQI94/yBk/Ned2Eku2uTxqMGkc5P3MWVEG92gisoecq
         g7IVJvfR9mer/U16JUdOYcVfXGCc605CfVkPp707LFiBrE8amAlwUWZWlit9SNSrdwYM
         V7BmRjA/ZwLH0KTrJwVSR5XupkukF+z90GZvUQpZE0h2c2OqfOqf/SifPV0zAP208EJZ
         IgHfel49KR8LHpfATxMFx4pKkaWLYAiKxUg1/cyWD+90Z7kSOhz3YZNXm+dhmYZ0Hzut
         5bbfN94gObJGrem3YeQH6O6OCSWRVjh7FOBGXd4+HQdFTBeZl0GwBhycs7xhDuTOXCWt
         Pofg==
X-Gm-Message-State: AOJu0Yw7ak3y9PqRj9cQtcMsVBjzuhS3tO4sxk20+WdS4weWtOUzMZ8m
	vGso0iyXp6ikWOfcDB1RpWECpjdCLB1RfflvYt45gAG0XENz02AjWb7C8LPdPm6GGsoGhCpI03j
	Gvid2n8CxR8yKKia1F3ar7v75NmFlJb/98RLq1YKuIwpy/Qi2RKUzBwZ0ZehM+DdJ0oDlpqBsJr
	UXSOKd9vhPqzwixL47BUYBkBm9NQZRbpSOy2w=
X-Google-Smtp-Source: AGHT+IEtt9vVTnloDJp/tTG4M8U/kxRBbgMOjb/lWQirUf9WpmWYku7QfuorygLOTex+rFk0l3N6hQ==
X-Received: by 2002:a05:6a20:3ca4:b0:1af:d9b1:5862 with SMTP id adf61e73a8af0-1b26f12dcd4mr12054725637.17.1717462008693;
        Mon, 03 Jun 2024 17:46:48 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c26067sm6049316b3a.218.2024.06.03.17.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 17:46:48 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver)
Subject: [RFC net-next v4 2/2] net/mlx5e: Add per queue netdev-genl stats
Date: Tue,  4 Jun 2024 00:46:26 +0000
Message-Id: <20240604004629.299699-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240604004629.299699-1-jdamato@fastly.com>
References: <20240604004629.299699-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

./cli.py --spec netlink/specs/netdev.yaml \
         --dump qstats-get --json '{"scope": "queue"}'

...snip

 {'ifindex': 7,
  'queue-id': 62,
  'queue-type': 'rx',
  'rx-alloc-fail': 0,
  'rx-bytes': 105965251,
  'rx-packets': 179790},
 {'ifindex': 7,
  'queue-id': 0,
  'queue-type': 'tx',
  'tx-bytes': 9402665,
  'tx-packets': 17551},

...snip

Also tested with the script tools/testing/selftests/drivers/net/stats.py
in several scenarios to ensure stats tallying was correct:

- on boot (default queue counts)
- adjusting queue count up or down (ethtool -L eth0 combined ...)

The tools/testing/selftests/drivers/net/stats.py brings the device up,
so to test with the device down, I did the following:

$ ip link show eth4
7: eth4: <BROADCAST,MULTICAST> mtu 9000 qdisc mq state DOWN [..snip..]
  [..snip..]

$ cat /proc/net/dev | grep eth4
eth4: 235710489  434811 [..snip rx..] 2878744 21227  [..snip tx..]

$ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
           --dump qstats-get --json '{"ifindex": 7}'
[{'ifindex': 7,
  'rx-alloc-fail': 0,
  'rx-bytes': 235710489,
  'rx-packets': 434811,
  'tx-bytes': 2878744,
  'tx-packets': 21227}]

Compare the values in /proc/net/dev match the output of cli for the same
device, even while the device is down.

Note that while the device is down, per queue stats output nothing
(because the device is down there are no queues):

$ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml \
           --dump qstats-get --json '{"scope": "queue", "ifindex": 7}'
[]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 138 ++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index d03fd1c98eb6..76d64bbcf250 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -39,6 +39,7 @@
 #include <linux/debugfs.h>
 #include <linux/if_bridge.h>
 #include <linux/filter.h>
+#include <net/netdev_queues.h>
 #include <net/page_pool/types.h>
 #include <net/pkt_sched.h>
 #include <net/xdp_sock_drv.h>
@@ -5279,6 +5280,142 @@ static bool mlx5e_tunnel_any_tx_proto_supported(struct mlx5_core_dev *mdev)
 	return (mlx5_vxlan_allowed(mdev->vxlan) || mlx5_geneve_tx_allowed(mdev));
 }
 
+static void mlx5e_get_queue_stats_rx(struct net_device *dev, int i,
+				     struct netdev_queue_stats_rx *stats)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	struct mlx5e_channel_stats *channel_stats;
+	struct mlx5e_rq_stats *xskrq_stats;
+	struct mlx5e_rq_stats *rq_stats;
+
+	ASSERT_RTNL();
+	if (mlx5e_is_uplink_rep(priv))
+		return;
+
+	/* ptp was ever opened, is currently open, and channel index matches i
+	 * then export stats
+	 */
+	if (priv->rx_ptp_opened && priv->channels.ptp) {
+		if (test_bit(MLX5E_PTP_STATE_RX, priv->channels.ptp->state) &&
+		    priv->channels.ptp->rq.ix == i) {
+			rq_stats = &priv->ptp_stats.rq;
+			stats->packets = rq_stats->packets;
+			stats->bytes = rq_stats->bytes;
+			stats->alloc_fail = rq_stats->buff_alloc_err;
+			return;
+		}
+	}
+
+	channel_stats = priv->channel_stats[i];
+	xskrq_stats = &channel_stats->xskrq;
+	rq_stats = &channel_stats->rq;
+
+	stats->packets = rq_stats->packets + xskrq_stats->packets;
+	stats->bytes = rq_stats->bytes + xskrq_stats->bytes;
+	stats->alloc_fail = rq_stats->buff_alloc_err +
+			    xskrq_stats->buff_alloc_err;
+}
+
+static void mlx5e_get_queue_stats_tx(struct net_device *dev, int i,
+				     struct netdev_queue_stats_tx *stats)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	struct mlx5e_sq_stats *sq_stats;
+
+	ASSERT_RTNL();
+	/* no special case needed for ptp htb etc since txq2sq_stats is kept up
+	 * to date for active sq_stats, otherwise get_base_stats takes care of
+	 * inactive sqs.
+	 */
+	sq_stats = priv->txq2sq_stats[i];
+	stats->packets = sq_stats->packets;
+	stats->bytes = sq_stats->bytes;
+}
+
+static void mlx5e_get_base_stats(struct net_device *dev,
+				 struct netdev_queue_stats_rx *rx,
+				 struct netdev_queue_stats_tx *tx)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+	int i, tc;
+
+	ASSERT_RTNL();
+	if (!mlx5e_is_uplink_rep(priv)) {
+		rx->packets = 0;
+		rx->bytes = 0;
+		rx->alloc_fail = 0;
+
+		for (i = priv->channels.params.num_channels; i < priv->stats_nch; i++) {
+			struct netdev_queue_stats_rx rx_i = {0};
+
+			mlx5e_get_queue_stats_rx(dev, i, &rx_i);
+
+			rx->packets += rx_i.packets;
+			rx->bytes += rx_i.bytes;
+			rx->alloc_fail += rx_i.alloc_fail;
+		}
+
+		if (priv->rx_ptp_opened) {
+			/* if PTP was opened, but is not currently open, then
+			 * report the stats here. otherwise,
+			 * mlx5e_get_queue_stats_rx will get it
+			 */
+			if (priv->channels.ptp &&
+			    !test_bit(MLX5E_PTP_STATE_RX, priv->channels.ptp->state)) {
+				struct mlx5e_rq_stats *rq_stats = &priv->ptp_stats.rq;
+
+				rx->packets += rq_stats->packets;
+				rx->bytes += rq_stats->bytes;
+			}
+		}
+	}
+
+	tx->packets = 0;
+	tx->bytes = 0;
+
+	for (i = 0; i < priv->stats_nch; i++) {
+		struct mlx5e_channel_stats *channel_stats = priv->channel_stats[i];
+
+		/* while iterating through all channels [0, stats_nch], there
+		 * are two cases to handle:
+		 *
+		 *  1. the channel is available, so sum only the unavailable TCs
+		 *     [mlx5e_get_dcb_num_tc, max_opened_tc).
+		 *
+		 *  2. the channel is unavailable, so sum all TCs [0, max_opened_tc).
+		 */
+		if (i < priv->channels.params.num_channels)
+			tc = mlx5e_get_dcb_num_tc(&priv->channels.params);
+		else
+			tc = 0;
+
+		for (; tc < priv->max_opened_tc; tc++) {
+			struct mlx5e_sq_stats *sq_stats = &channel_stats->sq[tc];
+
+			tx->packets += sq_stats->packets;
+			tx->bytes += sq_stats->bytes;
+		}
+	}
+
+	if (priv->tx_ptp_opened) {
+		/* only report PTP TCs if it was opened but is now closed */
+		if (priv->channels.ptp && !test_bit(MLX5E_PTP_STATE_TX, priv->channels.ptp->state)) {
+			for (tc = 0; tc < priv->channels.ptp->num_tc; tc++) {
+				struct mlx5e_sq_stats *sq_stats = &priv->ptp_stats.sq[tc];
+
+				tx->packets += sq_stats->packets;
+				tx->bytes   += sq_stats->bytes;
+			}
+		}
+	}
+}
+
+static const struct netdev_stat_ops mlx5e_stat_ops = {
+	.get_queue_stats_rx  = mlx5e_get_queue_stats_rx,
+	.get_queue_stats_tx  = mlx5e_get_queue_stats_tx,
+	.get_base_stats      = mlx5e_get_base_stats,
+};
+
 static void mlx5e_build_nic_netdev(struct net_device *netdev)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
@@ -5296,6 +5433,7 @@ static void mlx5e_build_nic_netdev(struct net_device *netdev)
 
 	netdev->watchdog_timeo    = 15 * HZ;
 
+	netdev->stat_ops	  = &mlx5e_stat_ops;
 	netdev->ethtool_ops	  = &mlx5e_ethtool_ops;
 
 	netdev->vlan_features    |= NETIF_F_SG;
-- 
2.25.1


