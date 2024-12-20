Return-Path: <netdev+bounces-153554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0F39F8A45
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA7D164A8C
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221413C6BA;
	Fri, 20 Dec 2024 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBwvR+Tj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE226381C4
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 02:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734663170; cv=none; b=scxa0M9zcWDY/ccYmPyloedeDw8LWsohq93OSb+GsEgyrLAl/RJ/hwjmFA4WHYmf705lc2ui36jbVnBgB8MXdLiKdfyrIg9mcHkhw6qlGPZsapZWd9p5QevEhzXLrvhDnAt5htRWIt4vMAJZTm1+/xTkK9Kez8GbJ7+hxq0l74Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734663170; c=relaxed/simple;
	bh=rFgB8KwvQwd0+Syadw8w4LstogVIVzm2fVBZPWu7Db4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXZ2gApRK5zYUGi85EPGIrJtHc+W8oKrsk+g38oIWj97GMFakLgVk820x1FQ2SVPzB7JUQIO56HzENvde0mEzBAXPR1YztsxKayWLXiQ5s9V1I2Nqc64crlCwwyE8DV66ruafJxpXDzutM0DGPBmU7gt0znvP8xKvBHdge9R/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBwvR+Tj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBD4C4CED4;
	Fri, 20 Dec 2024 02:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734663169;
	bh=rFgB8KwvQwd0+Syadw8w4LstogVIVzm2fVBZPWu7Db4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZBwvR+Tj2c1Q0ggxvN3td2gHrkcJ5Lx1vgzFfnEruWd3hMiL84TXjJ+GpoJM+7dA3
	 8ARUcIwEQExNrgj2cKULQR/VFYd58tf4Q/VvC/gPdSE754JwNsMcPugnhTbZXxz8+3
	 uK+lLnDUqgsv/RJ4yDNwLuaO5NZ/A6CIYIHkl5+66Iqfjis5IDDgoWJuQ08RLCMWVg
	 9LBWOh39qawPRBdGAjx9LYOnaYDT60a44bpbLBEmabfToztIyDasTunPDOgt0xEbig
	 EfaN+5B05Js8ZP46CskJp9FrvbbvJxGHOgzol3wWvkF1ZLP8ufNzoFwDsrm6k0C+om
	 ALDxryDJCqnTQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 04/10] eth: fbnic: support setting RSS configuration
Date: Thu, 19 Dec 2024 18:52:35 -0800
Message-ID: <20241220025241.1522781-5-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220025241.1522781-1-kuba@kernel.org>
References: <20241220025241.1522781-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Duyck <alexanderduyck@fb.com>

Let the user program the RSS indirection table and the RSS key.
Straightforward implementation. Track the changes and don't bother
poking the HW if user asked for a config identical to what's already
programmed. The device only supports Toeplitz hash.

Similarly to the GET support - all the real code that does the programming
was part of initial driver submission, already.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index e71ae6abb0f5..5523803c8edd 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -201,6 +201,60 @@ fbnic_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh)
 	return 0;
 }
 
+static unsigned int
+fbnic_set_indir(struct fbnic_net *fbn, unsigned int idx, const u32 *indir)
+{
+	unsigned int i, changes = 0;
+
+	for (i = 0; i < FBNIC_RPC_RSS_TBL_SIZE; i++) {
+		if (fbn->indir_tbl[idx][i] == indir[i])
+			continue;
+
+		fbn->indir_tbl[idx][i] = indir[i];
+		changes++;
+	}
+
+	return changes;
+}
+
+static int
+fbnic_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
+	       struct netlink_ext_ack *extack)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	unsigned int i, changes = 0;
+
+	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
+	    rxfh->hfunc != ETH_RSS_HASH_TOP)
+		return -EINVAL;
+
+	if (rxfh->key) {
+		u32 rss_key = 0;
+
+		for (i = FBNIC_RPC_RSS_KEY_BYTE_LEN; i--;) {
+			rss_key >>= 8;
+			rss_key |= (u32)(rxfh->key[i]) << 24;
+
+			if (i % 4)
+				continue;
+
+			if (fbn->rss_key[i / 4] == rss_key)
+				continue;
+
+			fbn->rss_key[i / 4] = rss_key;
+			changes++;
+		}
+	}
+
+	if (rxfh->indir)
+		changes += fbnic_set_indir(fbn, 0, rxfh->indir);
+
+	if (changes && netif_running(netdev))
+		fbnic_rss_reinit_hw(fbn->fbd, fbn);
+
+	return 0;
+}
+
 static int
 fbnic_get_ts_info(struct net_device *netdev,
 		  struct kernel_ethtool_ts_info *tsinfo)
@@ -312,6 +366,7 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_rxfh_key_size	= fbnic_get_rxfh_key_size,
 	.get_rxfh_indir_size	= fbnic_get_rxfh_indir_size,
 	.get_rxfh		= fbnic_get_rxfh,
+	.set_rxfh		= fbnic_set_rxfh,
 	.get_ts_info		= fbnic_get_ts_info,
 	.get_ts_stats		= fbnic_get_ts_stats,
 	.get_eth_mac_stats	= fbnic_get_eth_mac_stats,
-- 
2.47.1


