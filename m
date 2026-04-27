Return-Path: <netdev+bounces-281257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uONwEX0b72lx6gAAu9opvQ
	(envelope-from <netdev+bounces-281257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:17:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C48B46EEAE
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 10:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FD17301FD6E
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 08:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF08539A800;
	Mon, 27 Apr 2026 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="femWp/wI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A9D1A8F84
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 08:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277788; cv=none; b=K5Vk39I+z2xFB4ztsY3CZF+M5CUhlGa6LIOaXcCSLzuRmoYVR8lqKmXfq5JtLuCFxa32ezjjqfgQYuiEXYxs7xsgS7mrmj11XH8F1cNFRcz0CZHAvZCzGHrqh4yXtWpILD94FzziveODCehBeo9osvn7xTvXpQX/MmiyKN5G0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277788; c=relaxed/simple;
	bh=hMglcFQSz31hJgpjWEqZO+bMNqVqQrCNw2tIdm+z4D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSRGGQKfdgMAPrwwFNG/31/ID0zjtP/T8jv3BvbSzMa3pYqzSt4E0JFWa6uE7DYUMtCxHpLqwLaxLNgcPJRbbbxeRCGyuqC0o1vfsVM1hoq1BxX3CQmg599VS7D473Tze6bwdZEQR4fro8nqoHG6opC+pAMhHiVHLIbUb0+ulx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=femWp/wI; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777277786; x=1808813786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hMglcFQSz31hJgpjWEqZO+bMNqVqQrCNw2tIdm+z4D4=;
  b=femWp/wIDQMxjWkT5nMMZbOwDACwq1JWR/0MbaVebAdmOT9IDGsIGKeT
   96FOtNXBnQ75TeTQ2tvsQ9xt4uEPfioeG8/zQCY6UnJCVSwvjFJ7eiGPw
   0d+MJVY2A5sQY25IBsU4Ko0HRZk6onORY5AG6RXEMU1sYnhz6/kq7aZSN
   vNAEEdrazjZIrfBjiOeHjphOIAlhYzgJ5j/9bA9m3CdRMI4zLAnFb17Ra
   +FNBMexL6nB547Ex8ZVfBJbKlA8Ns2vwk6e8aV3OBjGEiNaii23BlOA0l
   Wor12//ImGHWxeE0Dx8W1wZw9UCx+KPyY8E7J0Fs8EGh8sWBJEFyTsitH
   w==;
X-CSE-ConnectionGUID: aTd7OkTxQ86spdhB2o7zmw==
X-CSE-MsgGUID: qD1+/BNSS8GLwvK/W+Qg7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="103621872"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="103621872"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:16:26 -0700
X-CSE-ConnectionGUID: P2d6FAewS+y9OVEagBh/OA==
X-CSE-MsgGUID: B+aHVFNHR8GfzE/lhgmy9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="229252784"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 27 Apr 2026 01:16:24 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 2B3E698; Mon, 27 Apr 2026 10:16:23 +0200 (CEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 2/2] net: thunderbolt: Fix lockdep issue during tunnel tear down
Date: Mon, 27 Apr 2026 10:16:23 +0200
Message-ID: <20260427081623.2338179-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260427081623.2338179-1-mika.westerberg@linux.intel.com>
References: <20260427081623.2338179-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8C48B46EEAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281257-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.intel.com];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]

When unplugging cable with lockdep enabled it triggers following:

 ======================================================
 WARNING: possible circular locking dependency detected
 6.18.0-rc4+ #1636 Tainted: G S
 ------------------------------------------------------
 kworker/u56:2/416 is trying to acquire lock:
 ffff88818642c8a8 ((work_completion)(&ring->work)){+.+.}-{0:0}, at: __flush_work+0x562/0xde0

 but task is already holding lock:
 ffff888184b30fa8 (&net->connection_lock){+.+.}-{4:4}, at: tbnet_tear_down+0x110/0x6f0 [thunderbolt_net]

We actually don't need to net->hold the connection_lock any more than
necessary to figure out if the connection is up or not, and can return
early if it is not.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/net/thunderbolt/main.c | 59 +++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 631af237998d..d8fcf18fc55c 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -372,48 +372,47 @@ static void tbnet_free_buffers(struct tbnet_ring *ring)
 
 static void tbnet_tear_down(struct tbnet *net, bool send_logout)
 {
+	int ret, retries = TBNET_LOGOUT_RETRIES;
+
 	netif_carrier_off(net->dev);
 	netif_stop_queue(net->dev);
 
 	stop_login(net);
 
 	mutex_lock(&net->connection_lock);
+	if (!net->login_sent || !net->login_received) {
+		mutex_unlock(&net->connection_lock);
+		return;
+	}
+	net->login_sent = false;
+	net->login_received = false;
+	mutex_unlock(&net->connection_lock);
 
-	if (net->login_sent && net->login_received) {
-		int ret, retries = TBNET_LOGOUT_RETRIES;
+	while (send_logout && retries-- > 0) {
+		netdev_dbg(net->dev, "sending logout request %u\n",
+			   retries);
+		ret = tbnet_logout_request(net);
+		if (ret != -ETIMEDOUT)
+			break;
+	}
 
-		while (send_logout && retries-- > 0) {
-			netdev_dbg(net->dev, "sending logout request %u\n",
-				   retries);
-			ret = tbnet_logout_request(net);
-			if (ret != -ETIMEDOUT)
-				break;
-		}
+	tb_ring_stop(net->rx_ring.ring);
+	tb_ring_stop(net->tx_ring.ring);
+	tbnet_free_buffers(&net->rx_ring);
+	tbnet_free_buffers(&net->tx_ring);
 
-		tb_ring_stop(net->rx_ring.ring);
-		tb_ring_stop(net->tx_ring.ring);
-		tbnet_free_buffers(&net->rx_ring);
-		tbnet_free_buffers(&net->tx_ring);
-
-		ret = tb_xdomain_disable_paths(net->xd,
-					       net->local_transmit_path,
-					       net->tx_ring.ring->hop,
-					       net->remote_transmit_path,
-					       net->rx_ring.ring->hop);
-		if (ret)
-			netdev_warn(net->dev, "failed to disable DMA paths\n");
-
-		tb_xdomain_release_in_hopid(net->xd, net->remote_transmit_path);
-		net->remote_transmit_path = 0;
-	}
+	ret = tb_xdomain_disable_paths(net->xd,
+				       net->local_transmit_path,
+				       net->tx_ring.ring->hop,
+				       net->remote_transmit_path,
+				       net->rx_ring.ring->hop);
+	if (ret)
+		netdev_warn(net->dev, "failed to disable DMA paths\n");
 
-	net->login_retries = 0;
-	net->login_sent = false;
-	net->login_received = false;
+	tb_xdomain_release_in_hopid(net->xd, net->remote_transmit_path);
+	net->remote_transmit_path = 0;
 
 	netdev_dbg(net->dev, "network traffic stopped\n");
-
-	mutex_unlock(&net->connection_lock);
 }
 
 static int tbnet_handle_packet(const void *buf, size_t size, void *data)
-- 
2.50.1


