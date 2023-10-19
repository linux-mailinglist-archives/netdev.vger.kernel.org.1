Return-Path: <netdev+bounces-42508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D527CF0CC
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 09:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F75281E8F
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 07:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9122E8F6B;
	Thu, 19 Oct 2023 07:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D96F8F64
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 07:09:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27499130
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 00:09:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1qtN9X-0002RO-TQ; Thu, 19 Oct 2023 09:09:07 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1qtN9W-002jpd-Oi; Thu, 19 Oct 2023 09:09:06 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1qtN9W-002Bj7-2H;
	Thu, 19 Oct 2023 09:09:06 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net v1 1/1] ethtool: fix clearing of WoL flags
Date: Thu, 19 Oct 2023 09:09:04 +0200
Message-Id: <20231019070904.521718-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

With current kernel it is possible to set flags, but not possible to remove
existing WoL flags. For example:
~$ ethtool lan2
...
        Supports Wake-on: pg
        Wake-on: d
...
~$ ethtool -s lan2 wol gp
~$ ethtool lan2
...
        Wake-on: pg
...
~$ ethtool -s lan2 wol d
~$ ethtool lan2
...
        Wake-on: pg
...

This patch makes it work as expected

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/ethtool/wol.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ethtool/wol.c b/net/ethtool/wol.c
index 0ed56c9ac1bc..fcefc1bbfa2e 100644
--- a/net/ethtool/wol.c
+++ b/net/ethtool/wol.c
@@ -108,15 +108,16 @@ ethnl_set_wol(struct ethnl_req_info *req_info, struct genl_info *info)
 	struct net_device *dev = req_info->dev;
 	struct nlattr **tb = info->attrs;
 	bool mod = false;
+	u32 wolopts = 0;
 	int ret;
 
 	dev->ethtool_ops->get_wol(dev, &wol);
-	ret = ethnl_update_bitset32(&wol.wolopts, WOL_MODE_COUNT,
+	ret = ethnl_update_bitset32(&wolopts, WOL_MODE_COUNT,
 				    tb[ETHTOOL_A_WOL_MODES], wol_mode_names,
 				    info->extack, &mod);
 	if (ret < 0)
 		return ret;
-	if (wol.wolopts & ~wol.supported) {
+	if (wolopts & ~wol.supported) {
 		NL_SET_ERR_MSG_ATTR(info->extack, tb[ETHTOOL_A_WOL_MODES],
 				    "cannot enable unsupported WoL mode");
 		return -EINVAL;
@@ -132,8 +133,9 @@ ethnl_set_wol(struct ethnl_req_info *req_info, struct genl_info *info)
 				    tb[ETHTOOL_A_WOL_SOPASS], &mod);
 	}
 
-	if (!mod)
+	if (!mod && wolopts == wol.wolopts)
 		return 0;
+	wol.wolopts = wolopts;
 	ret = dev->ethtool_ops->set_wol(dev, &wol);
 	if (ret)
 		return ret;
-- 
2.39.2


