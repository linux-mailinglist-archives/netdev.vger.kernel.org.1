Return-Path: <netdev+bounces-277751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Cl1GAmxT22kpAQkAu9opvQ
	(envelope-from <netdev+bounces-277751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 10:10:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF643E312A
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 10:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7CD64300BCBD
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 08:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752ED309DDB;
	Sun, 12 Apr 2026 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjziGkTO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E2961FCE
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 08:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775981412; cv=none; b=lmse3GG6WL+zaivvG05pGOyvHS4vZx1EosxD+TN0YmpdjywlIB38buZlB25n8tIyR7Ijr4DdeCNGNQd0XAFBGS6wzCXvhg2EFAdl8EGG+33CPKwbzJIPakDDCCpD0LTCOwuyJhjsAAjoYh9m9OrBegz/j1ff9kzslU8+tsxbSAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775981412; c=relaxed/simple;
	bh=36H48P9hjoQUXkzENXR+4KOVxVLh08Uk+rBggeOjamo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WQDg3/qgCLQMS1CVBgHxBMamMl8KSqkcS70Kv3r0Dh89yc1nu11gxTXlqh3owgJq7WZ0fvOg+A66FbTHZlpz2uqoUiJ1OQNgt5oPlsqhUNbj2XLYKoI0vQeQTNjTxMyq15N2h+qVCtIdz0aSA/i1n8TS8hdA7scFUauksHzjZe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjziGkTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5731CC19424;
	Sun, 12 Apr 2026 08:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775981411;
	bh=36H48P9hjoQUXkzENXR+4KOVxVLh08Uk+rBggeOjamo=;
	h=From:Date:Subject:To:Cc:From;
	b=fjziGkTO/dy4HMECql4anEfWbo8cHbp0IkS9s42ZvcrWSt6akH3InZQ5hmsQpP5Ut
	 W9g/lCICDlqUbWKxCtpqmCFMhgp+FDMs327ptDG3KeVQsVp5N5f3T1lG0VDU7AeO5c
	 Z6j2wvqnTRkTFHghQrRr4rOEB0Uu9TP+z1FQ/eIeA0e/rhQKA1UhFhdNzjYHK5bBKG
	 i9bpQ7YHPnwCpjJpJix4/0Oqy/ag2kKFXZ6q2gzLG+AhVbYmqF+j80jub4x3hAa3Y3
	 zfjJcK7a7WemazFtqjSUzyidz/yG3eHTRm3Kknd3jFdgZh8Vl4ESM6JHXgCcmh14RK
	 2oVtNaJOPHkKA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 12 Apr 2026 10:09:41 +0200
Subject: [PATCH net] net: airoha: Fix max TX packet length configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-airoha-fix-max-mtu-v1-1-333030d0a564@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MOwqAQAwFryKpDWgUf1cRi7BGTeEquyqCeHeDx
 RTD8N4DUYJKhC55IMilUTdvkqcJuIX9LKijOVBGVVbmhKxhWxgnvXFl4zhxal3dUOGEmMCGexD
 L/2kPXg4Y3vcDABmZzGkAAAA=
X-Change-ID: 20260412-airoha-fix-max-mtu-f9c7823ce2a2
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277751-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFF643E312A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

According to the Airoha documentation, REG_GDM_LEN_CFG() register does not
include FCS length. Fix MTU configuration removing ETH_FCS_LEN from
maximum TX packet length configuration.

Fixes: 54d989d58d2ac ("net: airoha: Move min/max packet len configuration in airoha_dev_open()")
Fixes: 03b1b69f0662c ("net: airoha: Introduce airoha_dev_change_mtu callback")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index c14cdce588a7..a81ffda72b39 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1629,9 +1629,9 @@ static void airoha_update_hw_stats(struct airoha_gdm_port *port)
 
 static int airoha_dev_open(struct net_device *dev)
 {
-	int err, len = ETH_HLEN + dev->mtu + ETH_FCS_LEN;
 	struct airoha_gdm_port *port = netdev_priv(dev);
 	struct airoha_qdma *qdma = port->qdma;
+	int err, len = ETH_HLEN + dev->mtu;
 
 	netif_tx_start_all_queues(dev);
 	err = airoha_set_vip_for_gdm_port(port, true);
@@ -1833,7 +1833,7 @@ static int airoha_dev_change_mtu(struct net_device *dev, int mtu)
 {
 	struct airoha_gdm_port *port = netdev_priv(dev);
 	struct airoha_eth *eth = port->qdma->eth;
-	u32 len = ETH_HLEN + mtu + ETH_FCS_LEN;
+	u32 len = ETH_HLEN + mtu;
 
 	airoha_fe_rmw(eth, REG_GDM_LEN_CFG(port->id),
 		      GDM_LONG_LEN_MASK,

---
base-commit: 02f72964395911e7a09bb2ea2fe6f79eda4ea2c2
change-id: 20260412-airoha-fix-max-mtu-f9c7823ce2a2

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


