Return-Path: <netdev+bounces-159487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F19BFA1599A
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2588A167114
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840771B3F3D;
	Fri, 17 Jan 2025 22:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O8fm2XBf"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E062B1AA1D1;
	Fri, 17 Jan 2025 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737154233; cv=none; b=ZxkiFPcqGt/tXz5Aas0IuovI4XpqtCHwh8FJK8KBDwqhkU7nQ9DgmblkmGur0g40TrygVX70D5mcFoe2iIDZlr0CRIUCmMIsKmdGpCDLkoZxkgSK4UQdzSVmxyg9fzVk45PsOG3IEdz3K0qdEDxPDNPNsFkXUupZ9ZxdDKTXoQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737154233; c=relaxed/simple;
	bh=g5wekne9OuC1w4oS3BWqlZfOiUbIMDziYDdzKIo/Yg4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dVh5KLRKt1QC//rmURkOi+AE+xlq7go2Oihr+CB4gt3aLAHMhA3Q0dxHiA2L15cQOp6s3iKUWwhId50tl5eUa+16r5/5hDMw+OyKmsCt1BxcsWuiLvwL24BhU2NmHSPT02mET+SuPqL5a0vZv8bpz4l5sX5eRC7+v+yRIRCRnmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O8fm2XBf; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 5155CC003E0D;
	Fri, 17 Jan 2025 14:50:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 5155CC003E0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1737154225;
	bh=g5wekne9OuC1w4oS3BWqlZfOiUbIMDziYDdzKIo/Yg4=;
	h=From:To:Cc:Subject:Date:From;
	b=O8fm2XBfDhjuGMNddsC9CTPT7TgnYdTSTodv/K34z1RqM2mqdIxaW+bzPyhDWo202
	 lsyESXEBeSpPQxefekTbRMBrVaa5ALxNCETTOxGn4LU9sz69QOiDYFDN2M0w/JYmHD
	 fCDndJjnpbQQzxGCGCsknT+HFtN5mUuNg1+Wugco=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id DBE7B18041CAC6;
	Fri, 17 Jan 2025 14:50:24 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: f.pfitzner@pengutronix.de,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ethtool] netlink: settings: Fix PHYAD printing
Date: Fri, 17 Jan 2025 14:50:19 -0800
Message-Id: <20250117225019.3912340-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PHY address was printed in hexadecimal rather than decimal as it
used to be and is expected.

Fixes: bd1341cd2146 ("add json support for base command")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 netlink/settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/netlink/settings.c b/netlink/settings.c
index b9b3ba9ed836..300825839e4e 100644
--- a/netlink/settings.c
+++ b/netlink/settings.c
@@ -605,7 +605,7 @@ int linkinfo_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 		uint8_t val = mnl_attr_get_u8(tb[ETHTOOL_A_LINKINFO_PHYADDR]);
 
 		print_banner(nlctx);
-		print_uint(PRINT_ANY, "phyad", "\tPHYAD: %x\n", val);
+		print_uint(PRINT_ANY, "phyad", "\tPHYAD: %u\n", val);
 	}
 	if (tb[ETHTOOL_A_LINKINFO_TRANSCEIVER]) {
 		uint8_t val;
-- 
2.34.1


