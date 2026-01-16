Return-Path: <netdev+bounces-250551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C9ED329C6
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 15:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 119CF307CD35
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CB2336EDE;
	Fri, 16 Jan 2026 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWhqv27X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9112701DC
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573653; cv=none; b=VVC7qo7SfmtKU4VmgSjtw/OGYFJHz0IeGN/9ZcH+vyj18Ug/ZDbdZjvOnHiMLaw81snngJK4EpkeIB/yeEOZWW1OgfAh/SBWO/G1lXTjy2l+Wpxq/gl5wi3EvvDrOvHTOT0Er5CTi7i653Kz5UHw/4r1DldkJstnCzDMt6lVxBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573653; c=relaxed/simple;
	bh=yzKkE2JcZSXXIfvZ8dUIIb9iNh0SPryV3tCTeE5Fq84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Cpxjk7RADaLy7tTPbK2FnhVeP0NCloMLb9p7ISr6oFFuAiUjCgK/SPAcLUPAgVcKG/ScGzhMKmQaQkLAQflqlz1EGjc08QNTHBvo9pfkHe4qKQQgo6kB135Eo/ANGWgM+PA/sJLlntdfBxeh5hE+Lrx0JgJCXDRKRg2RWfLYRUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWhqv27X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EA7C116C6;
	Fri, 16 Jan 2026 14:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768573653;
	bh=yzKkE2JcZSXXIfvZ8dUIIb9iNh0SPryV3tCTeE5Fq84=;
	h=From:Date:Subject:To:Cc:From;
	b=kWhqv27XGnnwNLvRUp6IEfA7NniLmaVIU4wUIq1Bq9VW6Mznlnv3aBLseZXOJg2cd
	 kWR8T8qqffY8YjD8pZGtzU2LBknya3rcW0ydrZc+ArwmGbpx5XbV0QdzztNKbEB1NK
	 kamAHqfaLOHUZq4FjjfYRGBBfLu/P/Iq2vElHj4La222oTDyQF6DL4DHSV1+xiz7mi
	 uQxZN0zyYGjB60DgdNjD6h5I8bRVxSBoHza4inCVCnXhs+qfK0aob1k5SqIpT+JmLk
	 wAIwHOT0fZyrCsWDq3kfLzPl9lpipDPZaOTzUd9cQenaVAiaBBOu+OlxdBuN5waJKI
	 G5l4NxCDHZKqg==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 16 Jan 2026 15:27:29 +0100
Subject: [PATCH net-next] net: ethernet: xscale: Check for PTP support
 properly
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-ixp4xx-fix-ethernet-v1-1-9ab3b411c77e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAMAwEvyI5G2hVCvoV8SB11VyqtEUC4t+tH
 oednZsSoiDRUN0UcUmSIxSwdUV+n8MGlqUwNaZxxlrHomenyqsoI++IAZm7dW7d0hvjvafyPCP
 K/ldH+oQAzTQ9zwsk5dqwbwAAAA==
X-Change-ID: 20260116-ixp4xx-fix-ethernet-4fa36d900ccc
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

In ixp4xx_get_ts_info() ixp46x_ptp_find() is called
unconditionally despite this feature only existing on
ixp46x, leading to the following splat from tcpdump:

root@OpenWrt:~# tcpdump -vv -X -i eth0
(...)
Unable to handle kernel NULL pointer dereference at virtual address
  00000238 when read
(...)
Call trace:
 ptp_clock_index from ixp46x_ptp_find+0x1c/0x38
 ixp46x_ptp_find from ixp4xx_get_ts_info+0x4c/0x64
 ixp4xx_get_ts_info from __ethtool_get_ts_info+0x90/0x108
 __ethtool_get_ts_info from __dev_ethtool+0xa00/0x2648
 __dev_ethtool from dev_ethtool+0x160/0x234
 dev_ethtool from dev_ioctl+0x2cc/0x460
 dev_ioctl from sock_ioctl+0x1ec/0x524
 sock_ioctl from sys_ioctl+0x51c/0xa94
 sys_ioctl from ret_fast_syscall+0x0/0x44
 (...)
Segmentation fault

Check for ixp46x support before calling PTP.

Fixes: c14e1ecefd9e ("net: ixp4xx_eth: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/xscale/ixp4xx_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index e1e7f65553e7..fa3a7694087a 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -1014,7 +1014,7 @@ static int ixp4xx_get_ts_info(struct net_device *dev,
 {
 	struct port *port = netdev_priv(dev);
 
-	if (port->phc_index < 0)
+	if (cpu_is_ixp46x() && (port->phc_index < 0))
 		ixp46x_ptp_find(&port->timesync_regs, &port->phc_index);
 
 	info->phc_index = port->phc_index;

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20260116-ixp4xx-fix-ethernet-4fa36d900ccc

Best regards,
-- 
Linus Walleij <linusw@kernel.org>


