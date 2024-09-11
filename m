Return-Path: <netdev+bounces-127181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B80C49747F7
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 03:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C3FB214A0
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 01:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4938822066;
	Wed, 11 Sep 2024 01:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoAIFZMM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E5F8460
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 01:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726019552; cv=none; b=rBRZmWvp0a00s6Gzk+51WLVtHnpmIKZKOfbrGO21Pglp1IFWlTtnn2X5Gd0w0+k4eMHuSEnhowUq8XAOttfqbWJqmjfr5noi3FAkQG4WOzArZ+3UfV1+uyFNTvWRHxTifmtNMibohKPE60ZCBdlB7tBXUBwmzzPfppCGNjHNcYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726019552; c=relaxed/simple;
	bh=2aOvoX8sfk3G8lBjbkRIISO1fgPQ1jinakPbCRroVR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rt5edceggpie3TOe5JH9dVXUzciH0z2HKlSSeodZZLw9cx2R49s50e98QhI0/BcLegsUii7vCsYxgvdGJZRcDDCP6vIwutaAg6FpGNwLOdYDFXvgv06UavuV8cgyIC8N2r1jfbXAkyfcjKFMgEo8ESEnmheIvR5UmYd3XvGfQkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoAIFZMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FB8C4CEC3;
	Wed, 11 Sep 2024 01:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726019552;
	bh=2aOvoX8sfk3G8lBjbkRIISO1fgPQ1jinakPbCRroVR4=;
	h=From:To:Cc:Subject:Date:From;
	b=WoAIFZMMVh1PfzfSle7QSugEnZ5meK8IN6sgtv+R0mZXLVLVKHGple/H7QPO9hnV+
	 jQ4sDXlXXzLZsDqhGeojrcR8JQZAYNqUL9s4tUAzgd5yooqWDVLCKENMn0AfRq1sDf
	 Q9qxGyveTglrHdff83KWRb8IJKXmHbg2D8Qf0+yJT4R1VJBvOSZkzvYLWuRRPujzca
	 g6s53t+zb46+ffzJTc4LERn7n4KvJTwEYDxb8ECOjAMpfIFhTtgfB0uI54cXAz3zgq
	 7cZzT8qV0sttThOnksq7f5523ULBNIw6ZkQARvhlRyySuaw8MY24Vdq9OVJ5fla8hK
	 RU5syFwmPesDg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	justinstitt@google.com,
	horms@kernel.org
Subject: [PATCH net-next] net: caif: remove unused name
Date: Tue, 10 Sep 2024 18:52:28 -0700
Message-ID: <20240911015228.1555779-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Justin sent a patch to use strscpy_pad() instead of strncpy()
on the name field. Simon rightly asked why the _pad() version
is used, and looking closer name seems completely unused,
the last code which referred to it was removed in
commit 8391c4aab1aa ("caif: Bugfixes in CAIF netdevice for close and flow control")

Link: https://lore.kernel.org/20240909-strncpy-net-caif-chnl_net-c-v1-1-438eb870c155@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: justinstitt@google.com
CC: horms@kernel.org

It's a bit unusual to take over patch submissions but the initial
submission was too low effort to count :|
---
 net/caif/chnl_net.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/caif/chnl_net.c b/net/caif/chnl_net.c
index 47901bd4def1..94ad09e36df2 100644
--- a/net/caif/chnl_net.c
+++ b/net/caif/chnl_net.c
@@ -47,7 +47,6 @@ struct chnl_net {
 	struct caif_connect_request conn_req;
 	struct list_head list_field;
 	struct net_device *netdev;
-	char name[256];
 	wait_queue_head_t netmgmt_wq;
 	/* Flow status to remember and control the transmission. */
 	bool flowenabled;
@@ -347,7 +346,6 @@ static int chnl_net_init(struct net_device *dev)
 	struct chnl_net *priv;
 	ASSERT_RTNL();
 	priv = netdev_priv(dev);
-	strncpy(priv->name, dev->name, sizeof(priv->name));
 	INIT_LIST_HEAD(&priv->list_field);
 	return 0;
 }
-- 
2.46.0


