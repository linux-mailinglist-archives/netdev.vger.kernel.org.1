Return-Path: <netdev+bounces-73745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E36EA85E14C
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 16:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985E91F25479
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5CB80613;
	Wed, 21 Feb 2024 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="Tkr091/r"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62766994A
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529689; cv=none; b=ffC7apcU3JufWuudrIcJZR+Ad7KvsnZqlCLjjOXTd/55Cn6sweGiuzYKvjG5w5eVBJA2i6ENkAVfO/SroBbTURAQvzb3lPH5OFlgGMCA8KHWrMyD0rBWqfXfUt6WincOxHc0fLdDqMZMKVrC5l9xHFRhOrRGX/eMz8VhX3sI/Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529689; c=relaxed/simple;
	bh=5DY2vP3fh+12w9Q3Lwb7BOV0eZgADCHqdkFnhD1etCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V91QbDuPCx1lPkZVJ4xROBZHtiN3Eo45brRNFAdNNcJaO8CLSZPnKxJcCNokjZAgWk+f9GAbqI0Bqpnv5c5Sqjfh+R+ccrnGHxDb4p5xtxIi6LHgpTeyV0WkaP9UOKv46ujc10rCZUOSa2q87J5HGNXQbDTGEQFZJh2Snq7LWis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=Tkr091/r; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202402211524333312faa6f1ff8ac70d
        for <netdev@vger.kernel.org>;
        Wed, 21 Feb 2024 16:24:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=s/caDJaFZJfijRBUbE9HcfXhVRapEiIBClN7x3MNKtE=;
 b=Tkr091/rSh3MjtECMoVW5DkgdkH0UWSiC2sLNwU+LLImd4mo2bBByoxXOGok1WKln0zJeC
 KVqNqQYqPm1azt0jCuW6/gxEld+2qTkle3TRf5XGXNOY+lt6NsJF+84BmMcPhgEaOBTZPw3v
 mXFlUQ0Qd29h2K8rW4knsFGhMgR4k=;
From: Diogo Ivo <diogo.ivo@siemens.com>
To: danishanwar@ti.com,
	rogerq@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	jan.kiszka@siemens.com
Subject: [PATCH net-next v3 07/10] net: ti: icssg-prueth: Adjust the number of TX channels for SR1.0
Date: Wed, 21 Feb 2024 15:24:13 +0000
Message-ID: <20240221152421.112324-8-diogo.ivo@siemens.com>
In-Reply-To: <20240221152421.112324-1-diogo.ivo@siemens.com>
References: <20240221152421.112324-1-diogo.ivo@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

As SR1.0 uses the current higher priority channel to send commands to
the firmware, take this into account when setting/getting the number
of channels to/from the user.

Based on the work of Roger Quadros in TI's 5.10 SDK [1].

[1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y

Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
Changes in v3:
 - Address Roger's comments on SR1.0 handling

 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index 9a7dd7efcf69..688a148f32b4 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -142,6 +142,9 @@ static int emac_set_channels(struct net_device *ndev,
 
 	emac->tx_ch_num = ch->tx_count;
 
+	if (emac->is_sr1)
+		emac->tx_ch_num++;
+
 	return 0;
 }
 
@@ -152,8 +155,15 @@ static void emac_get_channels(struct net_device *ndev,
 
 	ch->max_rx = 1;
 	ch->max_tx = PRUETH_MAX_TX_QUEUES;
+
+	if (emac->is_sr1)
+		ch->max_tx--;
+
 	ch->rx_count = 1;
 	ch->tx_count = emac->tx_ch_num;
+
+	if (emac->is_sr1)
+		ch->tx_count--;
 }
 
 static const struct ethtool_rmon_hist_range emac_rmon_ranges[] = {
-- 
2.43.2


