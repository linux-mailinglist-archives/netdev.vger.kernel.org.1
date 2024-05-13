Return-Path: <netdev+bounces-96060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BD48C4271
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3185D286F2F
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1894A154BF7;
	Mon, 13 May 2024 13:46:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mxb.hotsplots.de (mxb.hotsplots.de [185.46.137.13])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C989154C00
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.46.137.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607965; cv=none; b=RWojlbRI6wTlmxxBdLU5CB0uMniQNSx3dhDtaippdVAX0Sjk+Dq2T0HSH7QBSFc4Dg5AmqwZAdonj9kb4mqRisCfIdTN40uFgtKttdN2OcLdS93uFEowm+jvfTivv3wQ/vP84sWCDhnJh6em1Whm2Bn4VEtpqcT8Cll6Y7R+xEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607965; c=relaxed/simple;
	bh=NGJniBEAmQSKTOk9H/vLsPNyxbrJ/NiKLpTW3dO3mN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=k03xEgIlxzYb4C7zbKLybPXURpnQq9V+P2Wtk/Boeopdm2IV9tTpZ1qmjRjlENMMdvOpIAvOJnhQ9tp+roHq26KthumbqCNCHIQXZiKslCMyZAX7G+XpHbDDdWoxqHchqfgChmxCbm3gpiAREKk0Wu6atjkv4KC1uxjvmPfiUIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotsplots.de; spf=pass smtp.mailfrom=hotsplots.de; arc=none smtp.client-ip=185.46.137.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotsplots.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotsplots.de
Received: from build2.hotsplots.bln (unknown [217.66.62.140])
	by mxb.hotsplots.de (Postfix) with ESMTPS id 094878C01F9;
	Mon, 13 May 2024 15:38:44 +0200 (CEST)
Received: from mf by build2.hotsplots.bln with local (Exim 4.89)
	(envelope-from <faecknitz@hotsplots.de>)
	id 1s6Vt5-0007nk-U2; Mon, 13 May 2024 15:38:43 +0200
From: =?UTF-8?q?Martin=20F=C3=A4cknitz?= <faecknitz@hotsplots.de>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Martin=20F=C3=A4cknitz?= <faecknitz@hotsplots.de>
Subject: [PATCH net] net: mhi: set skb mac header before entering RX path
Date: Mon, 13 May 2024 15:38:30 +0200
Message-Id: <20240513133830.26285-1-faecknitz@hotsplots.de>
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
X-Rspamd-Queue-Id: 094878C01F9
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

Signed-off-by: Martin Fäcknitz <faecknitz@hotsplots.de>
---
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


