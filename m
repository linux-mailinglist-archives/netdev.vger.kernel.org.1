Return-Path: <netdev+bounces-97039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7B98C8DA2
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 23:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3084E1F22C34
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 21:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9B512FB10;
	Fri, 17 May 2024 21:19:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxb.hotsplots.de (mxb.hotsplots.de [185.46.137.13])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30262F36
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 21:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.46.137.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715980771; cv=none; b=hrskUf+fjHLMqZejmSltlrnuL6wEGxOdR81ULOtM+UeqlL14UZE3hT+4IIN6FqMtLPXcrPNt6XjE3Nc2JsTuKR9ZJbKei9n6fMpy/4b/m2/Ihr5kOLcG3HyPkWnWqqAKSAkYnSCG9pNJ1DES0WXXn64gvsNJHUt7dOrhIy40Bnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715980771; c=relaxed/simple;
	bh=IaJHkiKhE0+KeAi8FOKZqlaVvig/l5XJxYriTZOm858=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Rg5tNAERFUgBc15FETrQIASySRMu8MBd/fUdXFFW2/c52K8OdvfEZd5QBO0rL6tnUFjzjVxTkKEReYDtihuxEVz+RfRcZiKFQcmUbXz1Iu1E8K5gRA1K4OFZR9DUWZXQTmWPrCmRtoG6R2/Swo25lRI1nHTT9Ex656vHlp6oa8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotsplots.de; spf=pass smtp.mailfrom=hotsplots.de; arc=none smtp.client-ip=185.46.137.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotsplots.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotsplots.de
Received: from build2.hotsplots.bln (unknown [217.66.62.140])
	by mxb.hotsplots.de (Postfix) with ESMTPS id 791128C020E;
	Fri, 17 May 2024 23:19:22 +0200 (CEST)
Received: from mf by build2.hotsplots.bln with local (Exim 4.89)
	(envelope-from <faecknitz@hotsplots.de>)
	id 1s84z4-0007GJ-Bu; Fri, 17 May 2024 23:19:22 +0200
From: =?UTF-8?q?Martin=20F=C3=A4cknitz?= <faecknitz@hotsplots.de>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Martin=20F=C3=A4cknitz?= <faecknitz@hotsplots.de>,
	mhi@lists.linux.dev
Subject: [PATCH v2] net: mhi: set skb mac header before entering RX path
Date: Fri, 17 May 2024 23:19:09 +0200
Message-Id: <20240517211909.27874-1-faecknitz@hotsplots.de>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: --------------------------------------------------
X-Rspamd-Server: mxb
X-Rspamd-Queue-Id: 791128C020E
Authentication-Results: mxb.hotsplots.de;
	none
X-Spamd-Result: default: False [-50.00 / 500.00];
	 ASN(0.00)[asn:33811, ipnet:217.66.48.0/20, country:DE];
	 IP_WHITELIST(-50.00)[217.66.62.140]

skb->mac_header must be set before passing the skb to the network stack,
because skb->mac_len is calculated from skb->mac_header in
__netif_receive_skb_core.

Some network stack components, like xfrm, are using skb->mac_len to
check for an existing MAC header, which doesn't exist in this case. This
leads to memory corruption.

Fixes: 7ffa7542eca6 ("net: mhi: Remove MBIM protocol")
Signed-off-by: Martin Fäcknitz <faecknitz@hotsplots.de>
---
v2: - add "Fixes" tag
    - CC maintainers

 drivers/net/mhi_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
index ae169929a9d8..e432efddcb22 100644
--- a/drivers/net/mhi_net.c
+++ b/drivers/net/mhi_net.c
@@ -221,6 +221,8 @@ static void mhi_net_dl_callback(struct mhi_device *mhi_dev,
 			break;
 		}
 
+		skb_reset_mac_header(skb);
+
 		u64_stats_update_begin(&mhi_netdev->stats.rx_syncp);
 		u64_stats_inc(&mhi_netdev->stats.rx_packets);
 		u64_stats_add(&mhi_netdev->stats.rx_bytes, skb->len);
-- 
2.11.0


