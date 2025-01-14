Return-Path: <netdev+bounces-157987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A712A0FFC7
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 04:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7935163CBA
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25B723A10A;
	Tue, 14 Jan 2025 03:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKxBBben"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDD323A102
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 03:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736826698; cv=none; b=tqvWBzltGRyk1IPPEuI73UIGT8E7gyjJTfnZrOqWz3e/qMAHAN0u4mVVTzUNJr/1dnOibnzjy2Q8NdWrnA10618zfYt6RcuN2AjidI2qGixqAzaFg0LCrsy9LlqqgiHMtm/CUA0GVNlWBpiSOAOU8Po13G33BUeBvS9x8EcTnlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736826698; c=relaxed/simple;
	bh=btVdnTT5aSt7o7J4iNkD7SgWWI0lL/mUTDjzB3Vomk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwz6BrSPlbedAq+Am7LFWpnZWDKk5QhsQ2DBRd20wa1VooXqYhNugBXMBB+4UGtBHU0qOdtynQvu+TwcgVOd3vFgfSccgjL6kR+GTTheKXvgInzHYYA1vyrhB0OnroEN7f9cl6HvVz9mwNjIViDzKpLNoue3ma+4fuzA1Ty0Xmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKxBBben; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93A4C4CEE4;
	Tue, 14 Jan 2025 03:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736826698;
	bh=btVdnTT5aSt7o7J4iNkD7SgWWI0lL/mUTDjzB3Vomk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lKxBBbendXhtNHUCHhd80ljZ6slJrV/AnbWczRRh28w59G4E0S9ht7npiVJ9Os5r1
	 vPdAeMJ9sSJnRCXn41mEKTo2NHX3seMCuwL39vy/grkg8Spu6XTSKv2OaS3fWN1QW6
	 7QJIOEt/DVU9MtOKG+ayRGpOl/NN+O1EuHqLopxgui4YQHV1s8FOrvo4wTpr+C93wN
	 5whr5ziMuNoeqhZrgxqywQTokF0p14PKUPYQQlOWH5E/lzR6+eO5bR819JcIQUUKhr
	 r4njPrBUFzPwS3PDAbWRhRPL4ro0KLBQDLxbInihtgBiyw3zsB2kr8hl6RArIKfJdJ
	 bGK6Eso4hB4sQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 11/11] netdev-genl: remove rtnl_lock protection from NAPI ops
Date: Mon, 13 Jan 2025 19:51:17 -0800
Message-ID: <20250114035118.110297-12-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114035118.110297-1-kuba@kernel.org>
References: <20250114035118.110297-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NAPI lifetime, visibility and config are all fully under
netdev_lock protection now.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/netdev-genl.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 810a446ab62c..715f85c6b62e 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -229,8 +229,6 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!rsp)
 		return -ENOMEM;
 
-	rtnl_lock();
-
 	napi = netdev_napi_by_id_lock(genl_info_net(info), napi_id);
 	if (napi) {
 		err = netdev_nl_napi_fill_one(rsp, napi, info);
@@ -240,8 +238,6 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 		err = -ENOENT;
 	}
 
-	rtnl_unlock();
-
 	if (err) {
 		goto err_free_msg;
 	} else if (!rsp->len) {
@@ -300,7 +296,6 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	if (info->attrs[NETDEV_A_NAPI_IFINDEX])
 		ifindex = nla_get_u32(info->attrs[NETDEV_A_NAPI_IFINDEX]);
 
-	rtnl_lock();
 	if (ifindex) {
 		netdev = netdev_get_by_index_lock(net, ifindex);
 		if (netdev) {
@@ -317,7 +312,6 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 			ctx->napi_id = 0;
 		}
 	}
-	rtnl_unlock();
 
 	return err;
 }
@@ -358,8 +352,6 @@ int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 	napi_id = nla_get_u32(info->attrs[NETDEV_A_NAPI_ID]);
 
-	rtnl_lock();
-
 	napi = netdev_napi_by_id_lock(genl_info_net(info), napi_id);
 	if (napi) {
 		err = netdev_nl_napi_set_config(napi, info);
@@ -369,8 +361,6 @@ int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
 		err = -ENOENT;
 	}
 
-	rtnl_unlock();
-
 	return err;
 }
 
-- 
2.47.1


