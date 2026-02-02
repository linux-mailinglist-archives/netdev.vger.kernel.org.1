Return-Path: <netdev+bounces-255738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLC7MShLgGne5wIAu9opvQ
	(envelope-from <netdev+bounces-255738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 07:58:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD57C8FAE
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 07:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 995813006681
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 06:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0FB30EF6B;
	Mon,  2 Feb 2026 06:58:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA1F30DEB2;
	Mon,  2 Feb 2026 06:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770015498; cv=none; b=UShq/F6WEKjRpJdtQnqh1MScp6fTf+ACAMDnuKB7U+IHScxfGCEg+zII92ckDHDjBbdqiPEBh8eYp4BrW1oQR70azebVegWAT5KtAwKf7LvQSVFxIEa7ilYkDh7VD+RcJ1CCDHUKNvBgg8kPR4XFlavAH03im9SYn125HzV4gAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770015498; c=relaxed/simple;
	bh=OmD5Arfn3RrbJ25M0ctPE3l/LqvXsbLTQxMzqMnbtzU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MQpBWOlMCOKNeCtNCsnb4MHTISRTdo9otnOXrlih9ACKdBlbDyjZH41r68m/XADzejgkqm+Ok/2/u+3J6czkE3px0LOQBHprly8CH4ZPjrhxtlJX63C8F4POvhStIPkKmp28hD6VNXBPqp3AOD6HsG2QMTJHj50/go6UrUN1i6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 2 Feb
 2026 14:57:00 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 2 Feb 2026 14:57:00 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Mon, 2 Feb 2026 14:57:01 +0800
Subject: [PATCH net-next v3 07/15] net: ftgmac100: Simplify error handling
 for ftgmac100_initial_mac
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260202-ftgmac-cleanup-v3-7-6a6a8d45280a@aspeedtech.com>
References: <20260202-ftgmac-cleanup-v3-0-6a6a8d45280a@aspeedtech.com>
In-Reply-To: <20260202-ftgmac-cleanup-v3-0-6a6a8d45280a@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Jacky Chou <jacky_chou@aspeedtech.com>, Simon Horman
	<horms@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770015419; l=1005;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=v09SrIG5pIMosiqozTDRpfXyvuVR8w7kAu8PLHCKIaA=;
 b=hm4Ko4VNtaRF4QYcH6DzpuiZLt5OURMcxqKblVRzzc+ozm5sWCHClYGXjeRa67h5UhAXascng
 CR+SbfwK8CpCkYU9aV9SSSabR+O493NX5zEZdwcMg17zTtCnHqXAF7W
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[aspeedtech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255738-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacky_chou@aspeedtech.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aspeedtech.com:mid,aspeedtech.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: 8DD57C8FAE
X-Rspamd-Action: no action

From: Andrew Lunn <andrew@lunn.ch>

ftgmac100_initial_mac() does not allocate any resources. All resources
by the probe function up until this call point use devm_ methods. So
just return the error code rather than use a goto.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 1fb03dd55c8f..e511d6d5f7c2 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1914,7 +1914,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 	/* MAC address from chip or random one */
 	err = ftgmac100_initial_mac(priv);
 	if (err)
-		goto err_phy_connect;
+		return err;
 
 	if (priv->mac_id == FTGMAC100_AST2400 ||
 	    priv->mac_id == FTGMAC100_AST2500 ||

-- 
2.34.1


