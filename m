Return-Path: <netdev+bounces-115474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30688946766
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 06:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438341C20C41
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 04:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB0013A3EC;
	Sat,  3 Aug 2024 04:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg8sNuj9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB45A13A3E4
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 04:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722659216; cv=none; b=HR3FBII30b5iumkbIcAt9iQmWpSsD+uLmFvou+bGzlsin5prh+O23v3u4zli7oCR95CBKJoDq5qao8E1CotEoIIHdEwvM/EMdjH0qI/4VbeLcNbVOgksWGN5b2+rCpgBB4dSNtdmKlgIx/HOXcBK9rCKi6hCnYHQHDe7apW+GqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722659216; c=relaxed/simple;
	bh=mern0oxMBhMjRajxmnvl090135JBDOuY+VtdAgYTjBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsne3JyZVKBFnvAkpTY78uH/OxBZP09HvtpNL0aNNPR0MdjOvKVDscSPBD6olIp7Ac/Igoa4mC9a5GA9QUbDAZxxRE9Yg1RzeNtXkneJeprM7aEgBOxwtG5YJiMC2HyXHGrskbqHYrMfgWfrlrLc/QA+CQqQ/f73rmcEwC2JlXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg8sNuj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA2EC4AF0A;
	Sat,  3 Aug 2024 04:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722659215;
	bh=mern0oxMBhMjRajxmnvl090135JBDOuY+VtdAgYTjBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qg8sNuj9tOlqqzBV2Q0Xk5Hpp0HE2J3j1kI1Pe2nIVTEktWUNDntr/Md7RVAhW9Y5
	 PNvypnvSdCYtqvA1lvXPrxHoitg5DS9EEGJAPs2hum0HPf8Y0Jrgb+sLRBn8e/cjlz
	 xQslNk81LOt+tmdFws2yIYr4PCQ+2nxnEpYdQKFK+ZRKOVyoonUDc4vwzvVqOzUa7B
	 NspjQiITWhmsKwtMlIGAI7sxAv+a3yfefvgdbW2HR/Y7wL612ThLaP7T83cxXWeuMP
	 fSH8QWVH7dR1aCSDS6/Zb/1oIj+YykJcddcH4luqbfFSoebnheerYpEQJowObxg6EM
	 3fGZh/qBVAy8Q==
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
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 07/12] ethtool: rss: move the device op invocation out of rss_prepare_data()
Date: Fri,  2 Aug 2024 21:26:19 -0700
Message-ID: <20240803042624.970352-8-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240803042624.970352-1-kuba@kernel.org>
References: <20240803042624.970352-1-kuba@kernel.org>
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
2.45.2


