Return-Path: <netdev+bounces-202537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A714AAEE2DB
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61AA3BB18D
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7721B28ECF5;
	Mon, 30 Jun 2025 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTxF05Y7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528C7285C9C
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751298062; cv=none; b=XjPhKe8VfMYoaE4iGqaiDLYRsU9eWXGWNYpH4GDKiCxjGMrqDOXTEsPdWa/GnmRUQTxV0Gll4IqgiFyV5ASgM7MEYSmMJTYbmpA4l9RO4EMYyMjA+RRr0Ul+ZFi5oc6KaBvgZxcwgNRM6J1F7iB+g/Yl2zXVp189Ctmmy+dL3ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751298062; c=relaxed/simple;
	bh=ee5THgGGQ6wRO7SXdQooQrI4I46tfO3Y/cWKyvuk5Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nq7qLwywcViABfoajRQsakY7m4Az+GzjukqfmcODx8u3Hh4/KU4ID5y51P8ND+wbpPxMgtvk8enYto4hcNuTEIacIrg1pScHIF4qMX8/favrusjHLdj/IoqYl+7JoVeOUBuatNAPbQOCB3h+4CN9brKLchXPgv3L1IolbSUtDzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTxF05Y7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918BBC4CEE3;
	Mon, 30 Jun 2025 15:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751298061;
	bh=ee5THgGGQ6wRO7SXdQooQrI4I46tfO3Y/cWKyvuk5Ng=;
	h=From:To:Cc:Subject:Date:From;
	b=eTxF05Y7RxSvhPlAXmF+t1ab1gm7teZxrQp9LSkp+/GFyBPyZUR+/yNRO8RPK0G4Z
	 rdrwX7N1eq6qqePKAnlRxDnsmMnLes3LlG6B/IlQhi5c7tgpygFkLOuz69oyqWM2l9
	 jA2/tQTPXRiZG4PSubpiRPl30OIbBA4T1bsxdr4JxDlCN3ADVmvsdK+n5dXPVWvhUu
	 PoXgUPA1EinW4e9H/Nj2jNps4PM+P7/eK7Ob2cz9xcUzR20TS+qhUu9aPr9GgISe+v
	 nd+CAt4JpujNshYsucCxRyh/f2D0wYMrrMje2dWmP4LmSFSQPWIvT22bZeGgN6VUsu
	 5K6U0WkwE+O7w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	idosch@idosch.org
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] net: ethtool: fix leaking netdev ref if ethnl_default_parse() failed
Date: Mon, 30 Jun 2025 08:40:53 -0700
Message-ID: <20250630154053.1074664-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ido spotted that I made a mistake in commit under Fixes,
ethnl_default_parse() may acquire a dev reference even when it returns
an error. This may have been driven by the code structure in dumps
(which unconditionally release dev before handling errors), but it's
too much of a trap. Functions should undo what they did before returning
an error, rather than expecting caller to clean up.

Rather than fixing ethnl_default_set_doit() directly make
ethnl_default_parse() clean up errors.

Reported-by: Ido Schimmel <idosch@idosch.org>
Link: https://lore.kernel.org/aGEPszpq9eojNF4Y@shredder
Fixes: 963781bdfe20 ("net: ethtool: call .parse_request for SET handlers")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/netlink.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 09c81cc9a08f..b1f8999c1adc 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -455,10 +455,15 @@ static int ethnl_default_parse(struct ethnl_req_info *req_info,
 	if (request_ops->parse_request) {
 		ret = request_ops->parse_request(req_info, tb, info->extack);
 		if (ret < 0)
-			return ret;
+			goto err_dev;
 	}
 
 	return 0;
+
+err_dev:
+	netdev_put(req_info->dev, &req_info->dev_tracker);
+	req_info->dev = NULL;
+	return ret;
 }
 
 /**
@@ -508,7 +513,7 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 
 	ret = ethnl_default_parse(req_info, info, ops, !ops->allow_nodev_do);
 	if (ret < 0)
-		goto err_dev;
+		goto err_free;
 	ethnl_init_reply_data(reply_data, ops, req_info->dev);
 
 	rtnl_lock();
@@ -554,6 +559,7 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 		ops->cleanup_data(reply_data);
 err_dev:
 	netdev_put(req_info->dev, &req_info->dev_tracker);
+err_free:
 	kfree(reply_data);
 	kfree(req_info);
 	return ret;
@@ -656,6 +662,8 @@ static int ethnl_default_start(struct netlink_callback *cb)
 	}
 
 	ret = ethnl_default_parse(req_info, &info->info, ops, false);
+	if (ret < 0)
+		goto free_reply_data;
 	if (req_info->dev) {
 		/* We ignore device specification in dump requests but as the
 		 * same parser as for non-dump (doit) requests is used, it
@@ -664,8 +672,6 @@ static int ethnl_default_start(struct netlink_callback *cb)
 		netdev_put(req_info->dev, &req_info->dev_tracker);
 		req_info->dev = NULL;
 	}
-	if (ret < 0)
-		goto free_reply_data;
 
 	ctx->ops = ops;
 	ctx->req_info = req_info;
@@ -714,13 +720,13 @@ static int ethnl_perphy_start(struct netlink_callback *cb)
 	 * the dev's ifindex, .dumpit() will grab and release the netdev itself.
 	 */
 	ret = ethnl_default_parse(req_info, &info->info, ops, false);
+	if (ret < 0)
+		goto free_reply_data;
 	if (req_info->dev) {
 		phy_ctx->ifindex = req_info->dev->ifindex;
 		netdev_put(req_info->dev, &req_info->dev_tracker);
 		req_info->dev = NULL;
 	}
-	if (ret < 0)
-		goto free_reply_data;
 
 	ctx->ops = ops;
 	ctx->req_info = req_info;
-- 
2.50.0


