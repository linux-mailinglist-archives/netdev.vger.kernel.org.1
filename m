Return-Path: <netdev+bounces-77468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A251871E26
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 12:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4467D2839D3
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C951956472;
	Tue,  5 Mar 2024 11:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="GwD1SkRc"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65859433CA
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638940; cv=none; b=p4fmzNidl6YYUA+jtzGOvriEhZKvKHxRT3909EhZMu/7gMNNW+eIP7qMr12MyrHbHxYjiA/lyW0yOZnsG4l1aVD+sMvkZXxae9cFRWFxP0l6wexexkEuOHyFRYLIpzIBfVmN7YWNkhZqYQUDWbmwd8+04VzsfFq5/aiT5qMAXc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638940; c=relaxed/simple;
	bh=ehCQzbU98PbxbRVOW1Rth3grJuDztP8ehwGPO+uBpQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfzuP6fID9Q3cKlB2ycE6bV+tDi5MRLZVIGJXOg5BkQZTJG0C2bzPwIWKA+HpOzXxdKCyUEuCS6m4S6N7BRrVRAQ1NC199h9JOYltdOZeLRTGeye7n183/aPXvcjaetgYmfjto9ZPbZv3/uXa58WQve4XVYFamFrhvfFDeT51UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=GwD1SkRc; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240305114110eabb6ca6777f2022a5
        for <netdev@vger.kernel.org>;
        Tue, 05 Mar 2024 12:41:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=xwkwkmHbxfkquWdaLwL3yKkRZ08P5g4eRH5gsZUmVtI=;
 b=GwD1SkRcc00845JkSQj5lM6zs1uuvLry24Z1hSTLuZYSKOHDi6Z874TITjjTqjz05dcCjV
 lwoL82TUgYHT8VjG6Dqv3nlORVwDk7Z9Ea6kmmaJlBQXVAhaBHYlWU2qY5Bot/mncCjLgoWq
 RQPqPHRp3aTvZZ2zOp07quVwwrUfY=;
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
Subject: [PATCH net-next v4 07/10] net: ti: icssg-prueth: Adjust the number of TX channels for SR1.0
Date: Tue,  5 Mar 2024 11:40:27 +0000
Message-ID: <20240305114045.388893-8-diogo.ivo@siemens.com>
In-Reply-To: <20240305114045.388893-1-diogo.ivo@siemens.com>
References: <20240305114045.388893-1-diogo.ivo@siemens.com>
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
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
Changes in v4:
 - Add Reviewed-by from Roger

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
2.44.0


