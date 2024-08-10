Return-Path: <netdev+bounces-117375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D7794DAF4
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADA92826BD
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D322743ACB;
	Sat, 10 Aug 2024 05:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXGzoG6/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9E343AB3
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723268490; cv=none; b=an/e3/36bEm3qnpqspXkP86Aa2ltunG4PxlON6nxO32SfYTcgIrzCmELI5EkmLer+1LsGKG8PjAU4gTmFMzfMudMW9k3BJ2uWLUqtY7HB07Z8Wb5XCezwsRG5kP9xwSlgyY22JWYfJJBsqOjvjmovPF145/nay7bfNV52DhPfyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723268490; c=relaxed/simple;
	bh=lIno4aI++2TXO7b+efn8pUHCnDi/i1cC62eqDjVwWuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRQNVlMHn+wfiijQoEAO84MCzsaw723czVGIJTSZLB2ZXAjT6BBhB9WYpRtbuNqe/ukiQwSxg/3WwFuxHtFxF0yARqCBelA2+T3AIRcQapjef23devQt25v+ecZisHbaCXRIxeghlCDPvz+NeA5Yo+y/rQMC536t21/fatOYjCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXGzoG6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3958C4AF0C;
	Sat, 10 Aug 2024 05:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723268489;
	bh=lIno4aI++2TXO7b+efn8pUHCnDi/i1cC62eqDjVwWuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NXGzoG6/dr3eVQT4rkOiOOy+IX11hZyyS8Ixnjn/By4Xve1fM+xJ8pBsul2Jtr+7r
	 SLX7U4BxWGlpvhzJ6wXpB71oCCCWYQnSxk2+yPnWEz89cM7ZYDhAm5h+yVN1g4RqkM
	 Y/P1D2d/ma21WcHZVtkCv23azHgPcgfMqb2GZVbvEerNVWXTwQoaZqY71wE8+RYcD8
	 Z8/H5zBYc55zppSwDX+uJ0QMCS7Gd7+9G7Us9hgojAcwb8x/ReoumzP9zSshssgx4q
	 9PYYJ+C8zBIinFpGmKm8xTiW4KjHI/bjDiqkY1U6xyE6uhxquKjphJKuxzqQeNp0Xe
	 YoMGH0raW7tpA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	shuah@kernel.org,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	ahmed.zaki@intel.com,
	andrew@lunn.ch,
	willemb@google.com,
	pavan.chebbi@broadcom.com,
	petrm@nvidia.com,
	gal@nvidia.com,
	jdamato@fastly.com,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v5 07/12] ethtool: rss: move the device op invocation out of rss_prepare_data()
Date: Fri,  9 Aug 2024 22:37:23 -0700
Message-ID: <20240810053728.2757709-8-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240810053728.2757709-1-kuba@kernel.org>
References: <20240810053728.2757709-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor calling device ops out of rss_prepare_data().
Next patch will add alternative path using xarray.
No functional changes.

Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/rss.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index cd8100d81919..5c477cc36251 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -43,13 +43,9 @@ rss_parse_request(struct ethnl_req_info *req_info, struct nlattr **tb,
 }
 
 static int
-rss_prepare_data(const struct ethnl_req_info *req_base,
-		 struct ethnl_reply_data *reply_base,
-		 const struct genl_info *info)
+rss_prepare_get(const struct rss_req_info *request, struct net_device *dev,
+		struct rss_reply_data *data, const struct genl_info *info)
 {
-	struct rss_reply_data *data = RSS_REPDATA(reply_base);
-	struct rss_req_info *request = RSS_REQINFO(req_base);
-	struct net_device *dev = reply_base->dev;
 	struct ethtool_rxfh_param rxfh = {};
 	const struct ethtool_ops *ops;
 	u32 total_size, indir_bytes;
@@ -57,16 +53,6 @@ rss_prepare_data(const struct ethnl_req_info *req_base,
 	int ret;
 
 	ops = dev->ethtool_ops;
-	if (!ops->get_rxfh)
-		return -EOPNOTSUPP;
-
-	/* Some drivers don't handle rss_context */
-	if (request->rss_context) {
-		if (!ops->cap_rss_ctx_supported && !ops->create_rxfh_context)
-			return -EOPNOTSUPP;
-
-		data->no_key_fields = !ops->rxfh_per_ctx_key;
-	}
 
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
@@ -109,6 +95,31 @@ rss_prepare_data(const struct ethnl_req_info *req_base,
 	return ret;
 }
 
+static int
+rss_prepare_data(const struct ethnl_req_info *req_base,
+		 struct ethnl_reply_data *reply_base,
+		 const struct genl_info *info)
+{
+	struct rss_reply_data *data = RSS_REPDATA(reply_base);
+	struct rss_req_info *request = RSS_REQINFO(req_base);
+	struct net_device *dev = reply_base->dev;
+	const struct ethtool_ops *ops;
+
+	ops = dev->ethtool_ops;
+	if (!ops->get_rxfh)
+		return -EOPNOTSUPP;
+
+	/* Some drivers don't handle rss_context */
+	if (request->rss_context) {
+		if (!ops->cap_rss_ctx_supported && !ops->create_rxfh_context)
+			return -EOPNOTSUPP;
+
+		data->no_key_fields = !ops->rxfh_per_ctx_key;
+	}
+
+	return rss_prepare_get(request, dev, data, info);
+}
+
 static int
 rss_reply_size(const struct ethnl_req_info *req_base,
 	       const struct ethnl_reply_data *reply_base)
-- 
2.46.0


