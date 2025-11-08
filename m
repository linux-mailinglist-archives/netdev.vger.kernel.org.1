Return-Path: <netdev+bounces-236979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 13181C42BF5
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 12:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6D0134A2A8
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 11:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADF629A32D;
	Sat,  8 Nov 2025 11:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="APTqCz1J"
X-Original-To: netdev@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D8F27B349;
	Sat,  8 Nov 2025 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762602004; cv=none; b=Ge7hDOhkt8lFt5sH6d1nfpNKzHtN4uZqF/1/b/I0wC80/VP3T62OXg3DPa3yqKuZktUjezCnJ3G6rsfpJk/p7gD8+QCxb3kOiOjm+J8oOwnDJ6uWaWA4Msh2QcbnCOA1Fnd09nPYeDUXfH5ygyItpvhCH0gxQyMzLUWuHFZdBe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762602004; c=relaxed/simple;
	bh=rcvqYef/OxWDoBBkjpuWqzOIQ8eqGLlRvppwm1CrAF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3uxy5Sc5fGNRqrl4auI8AqI7glOIdwqjLNO1mrrWvYk36N+Herm6EDso/BR1KReMz6Mab9W+YwdirJJGjcgXG1wZzzkdvXkcwVoNvCJaVfcnRe0s68w9zvVy2F9/znB6qb9+p8KFnhwNeXiF6FNAzQ+dcFGS/FJ/vnzQxHMcA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=APTqCz1J; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout2.routing.net (Postfix) with ESMTP id B39E55FE85;
	Sat,  8 Nov 2025 11:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1762601993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p7uhLo/agwhBgHHuGTDmQCEG8rXbE6aWjg4WrceCqds=;
	b=APTqCz1Jc5s6V9bo+Co9k6atAjhC8MSQ8UIbwhAgzwkK1lYFMnKX8RWZMJvtbQRHJvEd1L
	n6NXXf7tB2w4lrI9CxYR176AZGo/swW3YjHyOiiHx+Ia66RCUbBISM55hVUAqyZ5hs6Dy9
	s53BNxko/6xW3qq3oOWFb+dCpoQ6dTQ=
Received: from frank-u24.. (fttx-pool-217.61.148.22.bambit.de [217.61.148.22])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 72F171226CD;
	Sat,  8 Nov 2025 11:39:53 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [RFC net-next 0/3] Add RSS and LRO support
Date: Sat,  8 Nov 2025 12:39:16 +0100
Message-ID: <20251108113926.102054-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

This series is currently only for discussion to get the upported SDK driver
changes in a good shape.
To use it some other parts are still missing like USXGMII PCS support on
mt7988.

patches are upported from mtk SDK:
- https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/refs/heads/master/master/files/target/linux/mediatek/patches-6.12/999-eth-08-mtk_eth_soc-add-register-definitions-for-rss-lro-reg.patch
- https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/refs/heads/master/master/files/target/linux/mediatek/patches-6.12/999-eth-09-mtk_eth_soc-add-rss-support.patch
- https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/refs/heads/master/master/files/target/linux/mediatek/patches-6.12/999-eth-10-mtk_eth_soc-add-hw-lro-support.patch

RSS / LRO

HW-acceleration for ending traffic. For routed traffic PPE is needed and
hw offloading in nftables.
Bridged traffic may need additional changes (openwrt use bridger utility).

RSS (Receive Side Scaling)

using 4 additional IRQ for spreading load

cat /proc/interrupts | grep ethernet

echo 1 > /proc/irq/105/smp_affinity
echo 2 > /proc/irq/106/smp_affinity
echo 4 > /proc/irq/107/smp_affinity
echo 8 > /proc/irq/108/smp_affinity

moving tx frame-engine irq to different cpu (here 3rd)
echo 4 > /proc/irq/103/smp_affinity

disable RPS (Receive Packet Steering) for all macs:

echo 0 > /sys/devices/platform/soc/15100000.ethernet/net/eth0/queues/rx-0/rps_cpus

pay attention on iperf-version (iperf 3.17 is ok, 3.12 is not)

traffic must be created using multiple streams so that it can be splitted, so use
multithreaded iperf3

on R4: bin/iperf3 -s
on the other side: iperf3 -c 192.168.1.1 -i 1 -P 4

you should reach ~9.3 GBit/s

and see spreading load over CPU cores

root@bpi-r4-phy-8G:~# cat /proc/interrupts | grep eth
103: 20 198366 0 0 GICv3 229 Level 15100000.ethernet
105: 3611 0 0 0 GICv3 221 Level 15100000.ethernet, 15100000.ethernet
106: 2 6842 0 0 GICv3 222 Level 15100000.ethernet, 15100000.ethernet
107: 4 0 27643 0 GICv3 223 Level 15100000.ethernet, 15100000.ethernet
108: 3 0 0 27925 GICv3 224 Level 15100000.ethernet, 15100000.ethernet

using the iperf3 from debian bookworm (3.12) results in only 6.7GBit/s, so
newer version is needed (not tested yet in trixie).

LRO(Large Receive Offload)

Add HW LRO RX rule:

ethtool -N [interface] flow-type tcp4 dst-ip [IP] action 0 loc [0/1]

Delete HW LRO RX rule:

ethtool -N [interface] delete [0/1]

Enable/Disable HW LRO rule:

ethtool -K [interface] lro [on | off]

Show the current offload features:

ethtool -k [interface]

example:

ethtool -N eth2 flow-type tcp4 dst-ip 192.168.1.1 action 0 loc 0
ethtool -K eth2 lro on ethtool -k eth2

using iperf(2) instead of iperf3 to reach full traffic!

verify with propritary debugfs (not part of this series)

Enable HW LRO rings
echo 4 1 > /proc/mtketh/hw_lro_auto_tlb
Enable HW LRO statistics
echo 5 1 > /proc/mtketh/hw_lro_auto_tlb

cat /proc/mtketh/hw_lro_stats

Mason Chang (3):
  net: ethernet: mtk_eth_soc: Add register definitions for RSS and LRO
  net: ethernet: mtk_eth_soc: Add RSS support
  net: ethernet: mtk_eth_soc: Add LRO support

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 770 ++++++++++++++++----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 171 +++--
 2 files changed, 757 insertions(+), 184 deletions(-)

-- 
2.43.0


