Return-Path: <netdev+bounces-277009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCNuLh2s12kMRQgAu9opvQ
	(envelope-from <netdev+bounces-277009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 15:39:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 174D23CB64C
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 15:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04AF130911C8
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 13:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20892C21FE;
	Thu,  9 Apr 2026 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="pspSm2EV"
X-Original-To: netdev@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3077A2C21F7;
	Thu,  9 Apr 2026 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741630; cv=none; b=u4PjL4TF41IsQhm+FiWmk0/olEaNQpW09IIsyuimXdeSKh+G+gbOYmTzEy0lxu7yq0R67O/3ENJ3MAPlt8/rKE94Q7xrIJP6R4Pzle6RBk5gWXspocb5QAVoHAd9srhniiC81apBWWknapglZJT0VqvXILW24dwcM1a4t7CzBo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741630; c=relaxed/simple;
	bh=LbxZW2TZPpsDw+LSPtP7Of++iJrX2VTkmxCvbtsEvCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yk7xzaIMancCsVFQYKPlr/EAAOJb+lOZgDibyIj7brz2Ufjgf2h5XBSyl/qxab55zojS6geGdqfA/pIVTROHszPueWaoidBlnRT/DRy2rcalYBiezo6ax9z1PPb2poNpG6DlpvGYEntqoatsnxErf5aPxXnKqCtrgyoo5MmrSH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=pspSm2EV; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout2.routing.net (Postfix) with ESMTP id 842F0600F5;
	Thu,  9 Apr 2026 13:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1775741626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0rLKwU1N/qqCdCrv9tx/W5ZVb8mZQmZW22Ca/SiHrac=;
	b=pspSm2EV6OnSVVj8ldY+ADJmMhcHgyBGVECtXBh7eB369i2V36LVtmGCPUTR3bM8HNZfAA
	j8zfZY4JDsO7hv3jounVTwd2T+4TX8wzBsKKEYzHBqt7M8NAPAF0tOyzaJHe+xqqK5EQ8g
	iVZDRlcRwxiM2+GQg5hpCIWDNABt/Rs=
Received: from frank-u24.. (fttx-pool-217.61.155.21.bambit.de [217.61.155.21])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 472731226C0;
	Thu,  9 Apr 2026 13:33:46 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [RFC net PATCH v1] net: pcs: pcs-mtk-lynxi: fix bpi-r3 serdes configuration
Date: Thu,  9 Apr 2026 15:33:42 +0200
Message-ID: <20260409133344.129620-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mailerdienst.de:s=routing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277009-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[fe80.eu,makrotopia.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,nxp.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[public-files.de,vger.kernel.org,lists.infradead.org];
	DMARC_NA(0.00)[fw-web.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@fw-web.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailerdienst.de:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[public-files.de:email,fw-web.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailerdienst.de:dkim]
X-Rspamd-Queue-Id: 174D23CB64C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Frank Wunderlich <frank-w@public-files.de>

Commit 8871389da151 introduces common pcs dts properties which writes
rx=normal,tx=normal polarity to register SGMSYS_QPHY_WRAP_CTRL of switch.
This is initialized with tx-bit set and so change inverts polarity
compared to before.

It looks like mt7531 has tx polarity inverted in hardware and set tx-bit
by default to restore the normal polarity.

Till this patch the register write was only called when mediatek,pnswap
property was set which cannot be done for switch because the fw-node param
was always NULL from switch driver in the mtk_pcs_lynxi_create call.

Do not configure switch side like it's done before.

Fixes: 8871389da151 ("net: pcs: pcs-mtk-lynxi: deprecate "mediatek,pnswap"")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/net/pcs/pcs-mtk-lynxi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index c12f8087af9b..a753bd88cbc2 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -129,6 +129,9 @@ static int mtk_pcs_config_polarity(struct mtk_pcs_lynxi *mpcs,
 	unsigned int val = 0;
 	int ret;
 
+	if (!fwnode)
+		return 0;
+
 	if (fwnode_property_read_bool(fwnode, "mediatek,pnswap"))
 		default_pol = PHY_POL_INVERT;
 
-- 
2.43.0


