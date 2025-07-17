Return-Path: <netdev+bounces-208040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B85B4B0986A
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 01:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18517189E54C
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 23:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9880424A079;
	Thu, 17 Jul 2025 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwvxc0yQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75549248F60
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795853; cv=none; b=sBnJUZIaPp4elynnRFRSExKhThELxR1tOdSdw6JoBOhid97sSSGUUBhke1hPjVB0zFbkhYssLBX3POcYGJLYWNZWMOCCACWbUwnWEtCfFgdbBp26LY17SvV+tZZ159tskrkMDwOzsWdD2GWZXHgCFx5A4RZy0aEsmGTnuBcoDkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795853; c=relaxed/simple;
	bh=eRmhRVClV2vCuXSDfYXww0gTJ4v7LGjWUDgLn9B9/f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fj9CreRUlTlRoffBAX7fEMQAxptZgKEsoxzYKn8nwfRooc1bIu1drfAKHtUc3f4S9AiayE6ewOCRAg95dOeheN8dzQ4ktP1TsmWxiEEEM3kGPFeAhpYxyJP//7PQ3Ix/L7PxdWUBAsBdFh0l0c8aDm3kiuMhtcw+EdKWcrHKtO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwvxc0yQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E87C4CEE3;
	Thu, 17 Jul 2025 23:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795853;
	bh=eRmhRVClV2vCuXSDfYXww0gTJ4v7LGjWUDgLn9B9/f0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uwvxc0yQ6ZpffGQt2lyE5VGQNJU9SRKS8qnbCD9eKw7lu9KKpaumWHwzzU2blLSfB
	 NzSQuCaHxtvnzrfxzBZGKPy70rFEWHGmlgs5NkEJtZOnlVVxGvg2KEMcLyXVzFk2OK
	 rW9TcuzaY69JLqaEwGQJVO3fI2+e+yFTnjUML6SdGB0AeY56+Rf2UBk5oieG9ADgAX
	 9WuIMj+MGr9N3ODPqwcNuPd8EXZWfC/mKoSOljRxYgB6/FT0lB6mz0ZDkJbVj6csCm
	 /qiRm9kWSVRyB7/flHF4RiLCV2HNs3pDo4lW1Ucodq1bEs8l7B8TdHoyC6Qm70Vbi8
	 tDahliiXqG06Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	andrew@lunn.ch,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	kory.maincent@bootlin.com,
	gal@nvidia.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/8] ethtool: rss: factor out allocating memory for response
Date: Thu, 17 Jul 2025 16:43:38 -0700
Message-ID: <20250717234343.2328602-4-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717234343.2328602-1-kuba@kernel.org>
References: <20250717234343.2328602-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To ease the code reuse for RSS_CREATE we'll want to prepare
struct rss_reply_data for the new context. Unfortunately
we can't depend on the exiting scaffolding because the context
doesn't exist (ctx=NULL) when we start preparing. Factor out
the portion of the context 0 handling responsible for allocation
of request memory, so that we can call it directly.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/rss.c | 47 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 3c6a070ef875..07a9d89e1c6b 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -113,21 +113,11 @@ rss_prepare_flow_hash(const struct rss_req_info *req, struct net_device *dev,
 }
 
 static int
-rss_prepare_get(const struct rss_req_info *request, struct net_device *dev,
-		struct rss_reply_data *data, const struct genl_info *info)
+rss_get_data_alloc(struct net_device *dev, struct rss_reply_data *data)
 {
-	struct ethtool_rxfh_param rxfh = {};
-	const struct ethtool_ops *ops;
+	const struct ethtool_ops *ops = dev->ethtool_ops;
 	u32 total_size, indir_bytes;
 	u8 *rss_config;
-	int ret;
-
-	ops = dev->ethtool_ops;
-
-	ret = ethnl_ops_begin(dev);
-	if (ret < 0)
-		return ret;
-	mutex_lock(&dev->ethtool->rss_lock);
 
 	data->indir_size = 0;
 	data->hkey_size = 0;
@@ -139,16 +129,39 @@ rss_prepare_get(const struct rss_req_info *request, struct net_device *dev,
 	indir_bytes = data->indir_size * sizeof(u32);
 	total_size = indir_bytes + data->hkey_size;
 	rss_config = kzalloc(total_size, GFP_KERNEL);
-	if (!rss_config) {
-		ret = -ENOMEM;
-		goto out_unlock;
-	}
+	if (!rss_config)
+		return -ENOMEM;
 
 	if (data->indir_size)
 		data->indir_table = (u32 *)rss_config;
 	if (data->hkey_size)
 		data->hkey = rss_config + indir_bytes;
 
+	return 0;
+}
+
+static void rss_get_data_free(const struct rss_reply_data *data)
+{
+	kfree(data->indir_table);
+}
+
+static int
+rss_prepare_get(const struct rss_req_info *request, struct net_device *dev,
+		struct rss_reply_data *data, const struct genl_info *info)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_rxfh_param rxfh = {};
+	int ret;
+
+	ret = ethnl_ops_begin(dev);
+	if (ret < 0)
+		return ret;
+	mutex_lock(&dev->ethtool->rss_lock);
+
+	ret = rss_get_data_alloc(dev, data);
+	if (ret)
+		goto out_unlock;
+
 	rxfh.indir_size = data->indir_size;
 	rxfh.indir = data->indir_table;
 	rxfh.key_size = data->hkey_size;
@@ -318,7 +331,7 @@ static void rss_cleanup_data(struct ethnl_reply_data *reply_base)
 {
 	const struct rss_reply_data *data = RSS_REPDATA(reply_base);
 
-	kfree(data->indir_table);
+	rss_get_data_free(data);
 }
 
 struct rss_nl_dump_ctx {
-- 
2.50.1


