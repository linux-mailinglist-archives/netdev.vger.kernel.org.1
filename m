Return-Path: <netdev+bounces-200422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C94DAE57D8
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1241161F7D
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 23:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151AE241136;
	Mon, 23 Jun 2025 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtorriwA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57A322D4FF
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720646; cv=none; b=PMGSOLJMeoPryC1R5XCNzNJxT020K9DMKniKdYOEkZsHsOVpgb1XY4YDt9tddnSXfPt93EEGE5jmjDBY+b+dcSIGAWAEjnIfT8pIX0N98SOn5H98xp52rI7X+angj/v3I97OxxwJiIQeSoRY8oGktBjKMWWp3Ge0UqrTETzBew4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720646; c=relaxed/simple;
	bh=jfkv9lu/UJtZn3sfThFt7n+5euVKXwPkn5BZZaoBBio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wm3DTRQg+FBrWiTmPlbSeWKYimfFRoPQj4pjP3Q63Dx2VXl90zlaGsU7JvZfRkW1Lcfi+ROHbbqY3kiIUlLLEnxEU6tSZO4u0X1jg4hfSS6OnskDUChlPfHWy3suevRh5mRolDUFOqDkY1+Go0UhZLGQ577UtIW3Ww/r9q/YdoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtorriwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FA8C4CEEA;
	Mon, 23 Jun 2025 23:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750720645;
	bh=jfkv9lu/UJtZn3sfThFt7n+5euVKXwPkn5BZZaoBBio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HtorriwAjxJ8IvzqahsPXCjGtAhgnIuzPBeeQwFp/+vqD8DvqBVQ8BUP/Q8OWhlCK
	 maU7OJNtSVdswWdWgOeK9OmkWEiOBL0yVW2c5TqXg6lndtdq8DOPMaeeFeln/TmnK0
	 GLZ0HZCH35KMJ9wm8O2h8WVY+EUIZG+R7P1j385FvNT/DHI+NO+EIbtvuVtQ+WnZoK
	 x7Qe8MmWuT1UZHhPlcD870l8HRHqSciFq9Dd7h09rX00wZ9X+ReVq7oaF5Om6up89Q
	 PepFP2e8zu87AaT1Y/9pzYVeZB9abM4aPGmdcR7TqxoJlhJKneAOU4op4tFn+5Rhq4
	 xqbTIWoyQ7JPQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/8] net: ethtool: dynamically allocate full req size req
Date: Mon, 23 Jun 2025 16:17:14 -0700
Message-ID: <20250623231720.3124717-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623231720.3124717-1-kuba@kernel.org>
References: <20250623231720.3124717-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for using req_info to carry parameters between
SET and NTF allocate a full request info struct. Since the size
depends on the subcommand we need to allocate it on the heap.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - s/into/info/
---
 net/ethtool/netlink.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 9de828df46cd..a9467b96f00c 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -863,8 +863,8 @@ static int ethnl_default_done(struct netlink_callback *cb)
 static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	const struct ethnl_request_ops *ops;
-	struct ethnl_req_info req_info = {};
 	const u8 cmd = info->genlhdr->cmd;
+	struct ethnl_req_info *req_info;
 	struct net_device *dev;
 	int ret;
 
@@ -874,20 +874,24 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (GENL_REQ_ATTR_CHECK(info, ops->hdr_attr))
 		return -EINVAL;
 
-	ret = ethnl_parse_header_dev_get(&req_info, info->attrs[ops->hdr_attr],
+	req_info = kzalloc(ops->req_info_size, GFP_KERNEL);
+	if (!req_info)
+		return -ENOMEM;
+
+	ret = ethnl_parse_header_dev_get(req_info, info->attrs[ops->hdr_attr],
 					 genl_info_net(info), info->extack,
 					 true);
 	if (ret < 0)
-		return ret;
+		goto out_free_req;
 
 	if (ops->set_validate) {
-		ret = ops->set_validate(&req_info, info);
+		ret = ops->set_validate(req_info, info);
 		/* 0 means nothing to do */
 		if (ret <= 0)
 			goto out_dev;
 	}
 
-	dev = req_info.dev;
+	dev = req_info->dev;
 
 	rtnl_lock();
 	netdev_lock_ops(dev);
@@ -902,7 +906,7 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ret < 0)
 		goto out_free_cfg;
 
-	ret = ops->set(&req_info, info);
+	ret = ops->set(req_info, info);
 	if (ret < 0)
 		goto out_ops;
 
@@ -921,7 +925,9 @@ static int ethnl_default_set_doit(struct sk_buff *skb, struct genl_info *info)
 	netdev_unlock_ops(dev);
 	rtnl_unlock();
 out_dev:
-	ethnl_parse_header_dev_put(&req_info);
+	ethnl_parse_header_dev_put(req_info);
+out_free_req:
+	kfree(req_info);
 	return ret;
 }
 
-- 
2.49.0


