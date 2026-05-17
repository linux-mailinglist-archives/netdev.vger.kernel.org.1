Return-Path: <netdev+bounces-288781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLMJNF88CmrtxwQAu9opvQ
	(envelope-from <netdev+bounces-288781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 00:08:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D999564232
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 00:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C582430031C3
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 22:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE6D33D503;
	Sun, 17 May 2026 22:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vassilevski.com header.i=@vassilevski.com header.b="ng+CYJnH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E8F33E374
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779055707; cv=none; b=Q3mLEGIwYvQZvkROwhb6kKtnZ/je4AyX2GjtWE4zXdvDpssk5GR4rtMY/3+F0QQWnGI5sc5MpX4UtEwvyl4OszpRHtX7Jm9+tyua+XzX4vS7t+OISYh6jAzoK3PTTNGtTIZS4I06mugz3IyTPjBsgtikfAe5rEkENUCMxwt8zLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779055707; c=relaxed/simple;
	bh=fUybwcI3Qhke5NXaKBUawwSoKSsPvAZQEP8Mu2rHLMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hfGgbR87gVByQl3ClIfIkY2Jjhx6mw46x2PdBWau0Y87xLD1Gaev+5egornR/1pOj2vW521Rq0l9sKA4qbOKbRNqrkaQAnQnCvXgcOGWpxkI/F8BtciXm5xcx+JWn74LyRf90/0U8X/VAplS11Obt52Il+MfHx7w3kd1ZlWBwl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vassilevski.com; spf=pass smtp.mailfrom=vassilevski.com; dkim=pass (1024-bit key) header.d=vassilevski.com header.i=@vassilevski.com header.b=ng+CYJnH; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vassilevski.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vassilevski.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vassilevski.com;
	s=protonmail; t=1779055700; x=1779314900;
	bh=yhuZ9PVMA1JtklmBBJx+69LxSoJx/lc5QUYBdIOwS+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ng+CYJnH8WXaw4H6LNkwfzjby/h9V45sGAnjlZUgqj9ZOK+ifVeIJjbfAOffGtGDS
	 +Xt5YwHiFuyOSypMB9V69Vb6gT9WMSYsp69tdxo4fLEPghAcU1EzQN9E70FK2jZK4z
	 diXD9mlFzfi/9v0tpfh9lrshZQPtJ1z20kDyb8cM=
X-Pm-Submission-Id: 4gJZnR1YTKz1DDXY
From: Alexander Vassilevski <oss@vassilevski.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Chintan Vankar <c-vankar@ti.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Alexander Vassilevski <oss@vassilevski.com>
Subject: [PATCH v3] net: ethernet: ti: am65-cpsw-nuss: remove dead vid check in slave_add_vid()
Date: Sun, 17 May 2026 15:07:57 -0700
Message-ID: <20260517220757.2679458-1-oss@vassilevski.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515225715.3641804-1-oss@vassilevski.com>
References: <20260515225715.3641804-1-oss@vassilevski.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4D999564232
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[vassilevski.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[vassilevski.com:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288781-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linaro.org,ti.com,wanadoo.fr,vger.kernel.org,vassilevski.com];
	DKIM_TRACE(0.00)[vassilevski.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oss@vassilevski.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:email,vassilevski.com:email,vassilevski.com:mid,vassilevski.com:dkim]
X-Rspamd-Action: no action

am65_cpsw_nuss_ndo_slave_add_vid() returns early at the top with:

     if (!netif_running(ndev) || !vid)
         return 0;

so vid is guaranteed to be non-zero in the rest of the function. The
subsequent

     if (!vid)
         unreg_mcast = port_mask;

is therefore unreachable. Drop the dead branch.

With that branch gone, unreg_mcast is only ever its initializer value
of zero, so drop the variable and pass 0 directly to
cpsw_ale_vlan_add_modify().

No functional change.

Found by Smatch.

Fixes: 7bcffde02152 ("net: ethernet: ti: am65-cpsw-nuss: restore vlan configuration while down/up")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/kernel-janitors/aS_lhMwppbDHoEcX@stanley.mountain/
Signed-off-by: Alexander Vassilevski <oss@vassilevski.com>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
Changes in v3:
  - Combine v1 and v2 into a single cumulative patch
  Link to v2: https://lore.kernel.org/kernel-janitors/20260517151611.393789-1-oss@vassilevski.com/

Changes in v2:
  - Also drop the now-unused unreg_mcast variable; pass 0 directly to
    cpsw_ale_vlan_add_modify()
  Link to v1: https://lore.kernel.org/kernel-janitors/20260515225715.3641804-1-oss@vassilevski.com/

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 7ac75fc8cd..434a310808 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -302,7 +302,7 @@ static int am65_cpsw_nuss_ndo_slave_add_vid(struct net_device *ndev,
 {
 	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
-	u32 port_mask, unreg_mcast = 0;
+	u32 port_mask;
 	int ret;
 
 	if (!common->is_emac_mode)
@@ -316,11 +316,9 @@ static int am65_cpsw_nuss_ndo_slave_add_vid(struct net_device *ndev,
 		return ret;
 
 	port_mask = BIT(port->port_id) | ALE_PORT_HOST;
-	if (!vid)
-		unreg_mcast = port_mask;
 	dev_info(common->dev, "Adding vlan %d to vlan filter\n", vid);
 	ret = cpsw_ale_vlan_add_modify(common->ale, vid, port_mask,
-				       unreg_mcast, port_mask, 0);
+				       0, port_mask, 0);
 
 	pm_runtime_put(common->dev);
 	return ret;

base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
-- 
2.43.0


