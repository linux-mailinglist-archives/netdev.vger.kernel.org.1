Return-Path: <netdev+bounces-35948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEBD7AC1CC
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 14:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8B4AF282039
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 12:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E732B18E00;
	Sat, 23 Sep 2023 12:17:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD622101EE
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 12:17:14 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C85A19C
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 05:17:11 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id k1ZLq0FE4ttXNk1ZLq9cSW; Sat, 23 Sep 2023 14:17:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1695471430;
	bh=MZ+x3+dMxPzCGceJF8/93Shpse4vUvBYF6v0b3D2kfE=;
	h=From:To:Cc:Subject:Date;
	b=pWrkqoYWrs+z0eZtol7HHfGiyoEXhV/dOMobQxnDEhy6fd6vb/VVWl+xgiAj4FXnz
	 4PvjXGd+S2o3TMbt4Ut7bO62rSgDkrpmxKcfbTt9ZBgTg+WQ1X+cRAIwr8ZPvxx+TL
	 unF0hAolnIG5mmLcu0WkE4eqgFOYmtiwp+867RTzbgveloEchATdFmfzfB359NaQHC
	 y2nJVmMr/0cV50aDKXwfsgFzViVX8Rul99nI4gR5DjZMggg/qrfGY34L7oFPnBMrvX
	 SvRULTOQBPjgKYToaahMrfT2APagS9YohRwfVWOAZ9IrPna8uYXnvjEX6NrQaznMMa
	 +RLYynY5dib/w==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 23 Sep 2023 14:17:10 +0200
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next] iavf: Avoid a memory allocation in iavf_print_link_message()
Date: Sat, 23 Sep 2023 14:17:05 +0200
Message-Id: <966968bda15a7128a381b589329184dfea3e0548.1695471387.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

IAVF_MAX_SPEED_STRLEN is only 13 and 'speed' is allocated and freed within
iavf_print_link_message().

'speed' is only used with some snprintf() and netdev_info() calls.

So there is no real use to kzalloc()/free() it. Use the stack instead.
This saves a memory allocation.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 8ce6389b5815..980dc69d7fbe 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1389,18 +1389,14 @@ void iavf_disable_vlan_insertion_v2(struct iavf_adapter *adapter, u16 tpid)
 static void iavf_print_link_message(struct iavf_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
+	char speed[IAVF_MAX_SPEED_STRLEN];
 	int link_speed_mbps;
-	char *speed;
 
 	if (!adapter->link_up) {
 		netdev_info(netdev, "NIC Link is Down\n");
 		return;
 	}
 
-	speed = kzalloc(IAVF_MAX_SPEED_STRLEN, GFP_KERNEL);
-	if (!speed)
-		return;
-
 	if (ADV_LINK_SUPPORT(adapter)) {
 		link_speed_mbps = adapter->link_speed_mbps;
 		goto print_link_msg;
@@ -1452,7 +1448,6 @@ static void iavf_print_link_message(struct iavf_adapter *adapter)
 	}
 
 	netdev_info(netdev, "NIC Link is Up Speed is %s Full Duplex\n", speed);
-	kfree(speed);
 }
 
 /**
-- 
2.34.1


