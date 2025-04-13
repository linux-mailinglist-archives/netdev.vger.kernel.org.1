Return-Path: <netdev+bounces-181942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDF9A870E0
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 08:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300563BC3B3
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 06:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E766213541B;
	Sun, 13 Apr 2025 06:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="b4tnsWbj"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-63-194.mail.qq.com (out162-62-63-194.mail.qq.com [162.62.63.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9904A08
	for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 06:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.63.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744526378; cv=none; b=VoXyzACu+WsKz8AWSkg6V/VjbtCcOX0qikdrvqtowvrk/6uXqYk1hQHvxRD6YmTdTdaHwXTa4DPuXBmLg72EsdHksGE5tOvlB6z6byPLsPkatXF0HZRnOftxVj+bN9myrsv/v0MExX60D60Ks3mIQM5of3BGSQ/qxb4/yGytJTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744526378; c=relaxed/simple;
	bh=VfjOKrdlXknj6vXHwWJVj/PZAb+mg4jlr/TvsLO2kuQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=TRWwiI6lRNuajyzL7QZ7WCUUCfN38MDYxXFxvwX980oNOIRP0vvMTZQnE3nEOZJkBsWNFHkOZeDyWYwi3+PGrPFeAzdi3fDhVtio9Zws+Bt0HajnZZEPMXTsXlPsmcR4WZGVm48Sc0gkzEMwGHOJcr2Qd9f/e6pD3bh4lGkcftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=b4tnsWbj; arc=none smtp.client-ip=162.62.63.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1744526368; bh=D0ZirlimTq5Afw6FKAt5hzKPG4G54aL2TbVMhjYhzlk=;
	h=From:To:Cc:Subject:Date;
	b=b4tnsWbjPr4eItwnN1C59EUSbxQGnkF3dDSJVziD85xcM7c7ebpSintw3hbUs2v2u
	 4OgOXWL8M+smPZWm6+lHCqYFxvyLaYLlV1b2Y3AnEKgcfUP7SI64q0enqGKG0HBpfC
	 69wAMEmmEGDLkL1LJdds6IbKz9lQrdI4TG1cEEDk=
Received: from ground-ThinkStation-P3-Tower.. ([159.226.94.115])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 42AADAF5; Sun, 13 Apr 2025 14:16:42 +0800
X-QQ-mid: xmsmtpt1744525002t7211d50w
Message-ID: <tencent_20ED8A5A99ECCFE616B18F17D8056B5AF707@qq.com>
X-QQ-XMAILINFO: OQ59tfF64tJLUuC/UaBXPGpc48yfl8ikeVT8EldQ9/JSA1xi0KT6CnB5h+ygdL
	 yAi4dcg4GWRX5w0iOjTgpCPgf7owO7fFlHn1rO0nyeZqLbXnmmdif5W6ZLwrvIV2P24TWPIi//vw
	 hVEROrgssqRDOdjKnqkcGnM5tsNSGuZ5gz+gZ8LbND6+xUE9O/KnIYMK2VOBknTrZQaMG+Q8Nedr
	 uE2h7mPKWRcoT1CoRLIONBVSkLewM9jxmmbNUEhisK+1jdHXDMXJSplC8RaMBFSVveOXf+7UVdGP
	 2TjrV93cYnI4xAmX4KJyp5BF4DMDBmFPrbTvAwO7LkdoDRw7WUd140GPSfW0MBxE9+9YskhEUjO/
	 sNfT8FdcFs1x66drPsgfHXfwOiikiMtZtUHqBI3gDNJP7N2qVUt8EzkXCcbxYs9kHPtjajmLvq9N
	 QEWe9eMgQl4a3YJN7TsGTc8py4pUkXPLRu/qFGej1fr1V3ONfUnLuuWlXcEohUsicEa1CkkHsJNM
	 7tt8iSg6IWpoij83wpzK4QZOTrXXJmBoN0uGRB5qD8ZXKD7AB4Me8bja0DdQyg1nzR7Kr/ymeGm+
	 MN8qPN94abOG134g/V1J4aPa28fJAnqzSV5twvkrJGv82xnc0nHVwz1TCnKQOcvHIeyPghEegyOl
	 98Qjv4GUQk6sLRO+ul/XzdDB/uecJsaEGKVEJBXiV0VNZCu07rZc0/83ckrH5PeBzhX6CflZDhbD
	 RsayhWW/hCBBsw0AovPIEIABRUzM7DPQYRjMp/X+FoVWfuQD3IiKeKGVe0TZkZXt6uItgRWj4CHP
	 wf2/Xoq+2X+wAb62oEgk1LKEyiV37/GMNzlLL3vPdvYSTlgakkbBAx9yaKYe3dUYX3Prvuy8EUaP
	 Pha73Z/JlqhDlj9LSbAIpT2PRoUkWA6u4wcx2Gw44x0JeJu3kxDlyVt0r4Zzqfmvv6j6DfFOdc
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: cxxz16 <990492108@qq.com>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	bbhushan2@marvell.com,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	cxxz16 <990492108@qq.com>
Subject: [Patch next] octeontx2-pf: fix potential double free in rvu_rep_create()
Date: Sun, 13 Apr 2025 14:16:39 +0800
X-OQ-MSGID: <20250413061639.2162285-1-990492108@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rvu_rep_create(), the netdev is allocated via alloc_etherdev()
and assigned to rep->netdev. This rep structure is then stored
in the priv->reps array indexed by rep_id.

If either rvu_rep_devlink_port_register() or register_netdev() fails,
the function frees ndev using free_netdev(ndev) before jumping to 
the 'exit:' label. However, in the 'exit:' section, the function 
iterates over priv->reps[] and again frees rep->netdev, which points 
to the same ndev.

This results in a potential double free of the same netdev pointer,
which can cause memory corruption or crashes.

To fix this, avoid calling free_netdev(ndev) before jumping to 'exit:'.
The cleanup logic at 'exit:' should handle the freeing safely.

Signed-off-by: cxxz16 <990492108@qq.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 04e08e06f30f..de9a50f2fc39 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -681,7 +681,6 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 		eth_hw_addr_random(ndev);
 		err = rvu_rep_devlink_port_register(rep);
 		if (err) {
-			free_netdev(ndev);
 			goto exit;
 		}
 
@@ -691,7 +690,6 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 			NL_SET_ERR_MSG_MOD(extack,
 					   "PFVF representor registration failed");
 			rvu_rep_devlink_port_unregister(rep);
-			free_netdev(ndev);
 			goto exit;
 		}
 
-- 
2.34.1


