Return-Path: <netdev+bounces-115160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FAE945535
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 02:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D68F2865AF
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 00:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801EBF4FB;
	Fri,  2 Aug 2024 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufswCFsX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5541757E
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722557892; cv=none; b=ldfyvlFoimtwOjHjA/iZrDeJOs4KIHj9h6mVYuNjiVyXSq3rETTVL59FFNZigf2YUn6CZVINKX9wotYi53iDN7HCEdyQmawoiI6oGtCHPncseFHMHK9SdAhue6QkhNciUK5P10oLKuMUZ7JdOMoyJHZDss0/lYwEId0f8i5Wvdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722557892; c=relaxed/simple;
	bh=Ek0HnL765IYSSULDFgT83ngzhX2waq7xQro793Wa8UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1XQ0XmXYNJDqM2xP3rr/DBufIhJhC25QvIPXl2uW48aR0MuraMXglpAjiI/rmdGjxTfVrRGErvB4uKkslG6gMNl5+A2H897YMr5Yp/2S253x4Wt1y0f+SIeXVyzgeQ2qlHHH9AS/Hh7TSOdmOb+cll2f5uptiMF211BT9aVfls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufswCFsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB61C4AF11;
	Fri,  2 Aug 2024 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722557891;
	bh=Ek0HnL765IYSSULDFgT83ngzhX2waq7xQro793Wa8UQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ufswCFsX9VMqMUxjOyxT4uQ0kXW8f1ueyDTT5DWzM05pfBPhjVCmyjpOGpXh36ID7
	 7X0//DghnJjFsVPfu02pFwqHU4tDFMiW6iAHbvGCcRGAtGOky4ywBKB6akx2d6/X6v
	 kUHqDwkLtyUihc2nEsIYHIsTzWP/MI5+svWaig04zSK9xTA2bRvamG8v/e1BVeC1fZ
	 rnPV97Ks2uZM+DnbyolDpDP9YXHvHXxqSCVAit+G+W1XTyatgJeEVqY5MWeoBW/BBS
	 PSGBKAWdflPPL7pioU7n8wCCCHQwNE9ByUsTY+nhu5hnH5lVNzVOn/kQ0uctj7o1yv
	 CTIP/uBluQ2tg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dxu@dxuuu.xyz,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com,
	gal.pressman@linux.dev,
	tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 07/12] ethtool: rss: move the device op invocation out of rss_prepare_data()
Date: Thu,  1 Aug 2024 17:17:56 -0700
Message-ID: <20240802001801.565176-8-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802001801.565176-1-kuba@kernel.org>
References: <20240802001801.565176-1-kuba@kernel.org>
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
2.45.2


