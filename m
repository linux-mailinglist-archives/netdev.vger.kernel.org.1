Return-Path: <netdev+bounces-117066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7CE94C8CA
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 05:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD9628581F
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 03:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58BA1C28E;
	Fri,  9 Aug 2024 03:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3vN+Jhg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D001BDDF
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 03:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723173514; cv=none; b=NmNCBMVDAJaBCdI0YMmIRRFz2kCtq/2o+MNPnC9TUqgwzFxr8H26IBsxvBFCTFyKkWQQpe7qpnzBTYq7ON88pvNKA4kvLmg9r7IhITS39KEdy9p9Zh89aO3Se2RqJ7/5I67oq4EYIFVcbETgntUjp+BSVrg8TVXO1nqsPJcMW7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723173514; c=relaxed/simple;
	bh=ZOdVsJ8rG8hEj0DPN3zS6bgBw0b37Jm93j7z1j8PG2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvXsjIZL06kfKQffQokPXH6fNTMhee/fT4tXtiUz3xInr6PBviXbFqmnHaC1AIeApUYTNhl1om/8mTVqFSN7JWlhJr9/PaAeb8IkCL7GLktAnQkmfidqcJRJX1HgHTSqm8HoCegU0jlV5YQp8cN4szbh2r05sGHJAehOnmmKNlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3vN+Jhg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F04BC4AF15;
	Fri,  9 Aug 2024 03:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723173514;
	bh=ZOdVsJ8rG8hEj0DPN3zS6bgBw0b37Jm93j7z1j8PG2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n3vN+JhgTjtfBY4AkyaYlcLTG2ztPG9n1WNt7yqjmRLI+oo08VQmBlydgL8hxuXTG
	 SAecOsQ0YOxNMVHWs1DthJfYjml8UrpGa4ugz446fLjT5mA0l5GWdwvdEVCIVmefR+
	 G1ryT2YGND++kAHqHwAG7SLf9ntkDfIedDEAeF8IT03aUEfFs4J6FAakbdMGokF/Ki
	 QjTpBUlFcj3FgwykKUgBcc087Bugcv/G3w6yStz2TRNAxt3XnAU7II9YGf3AugCLgu
	 w6Ds76ECJTDtVlEao/8vjFHprl6bx5uHnNKWIpZ/du1rUoDjW1neVWizbWr7XohdYE
	 rPxo44Fm5zFeg==
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
Subject: [PATCH net-next v4 04/12] ethtool: make ethtool_ops::cap_rss_ctx_supported optional
Date: Thu,  8 Aug 2024 20:18:19 -0700
Message-ID: <20240809031827.2373341-5-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240809031827.2373341-1-kuba@kernel.org>
References: <20240809031827.2373341-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cap_rss_ctx_supported was created because the API for creating
and configuring additional contexts is mux'ed with the normal
RSS API. Presence of ops does not imply driver can actually
support rss_context != 0 (in fact drivers mostly ignore that
field). cap_rss_ctx_supported lets core check that the driver
is context-aware before calling it.

Now that we have .create_rxfh_context, there is no such
ambiguity. We can depend on presence of the op.
Make setting the bit optional.

Reviewed-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/ethtool.h | 3 ++-
 net/ethtool/ioctl.c     | 6 ++++--
 net/ethtool/rss.c       | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 989c94eddb2b..a149485904d8 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -727,7 +727,8 @@ struct kernel_ethtool_ts_info {
  * @cap_link_lanes_supported: indicates if the driver supports lanes
  *	parameter.
  * @cap_rss_ctx_supported: indicates if the driver supports RSS
- *	contexts.
+ *	contexts via legacy API, drivers implementing @create_rxfh_context
+ *	do not have to set this bit.
  * @cap_rss_sym_xor_supported: indicates if the driver supports symmetric-xor
  *	RSS.
  * @rxfh_indir_space: max size of RSS indirection tables, if indirection table
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index e18823bf2330..aa2432dca885 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1227,7 +1227,8 @@ static noinline_for_stack int ethtool_get_rxfh(struct net_device *dev,
 	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd32)
 		return -EINVAL;
 	/* Most drivers don't handle rss_context, check it's 0 as well */
-	if (rxfh.rss_context && !ops->cap_rss_ctx_supported)
+	if (rxfh.rss_context && !(ops->cap_rss_ctx_supported ||
+				  ops->create_rxfh_context))
 		return -EOPNOTSUPP;
 
 	rxfh.indir_size = rxfh_dev.indir_size;
@@ -1357,7 +1358,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd32)
 		return -EINVAL;
 	/* Most drivers don't handle rss_context, check it's 0 as well */
-	if (rxfh.rss_context && !ops->cap_rss_ctx_supported)
+	if (rxfh.rss_context && !(ops->cap_rss_ctx_supported ||
+				  ops->create_rxfh_context))
 		return -EOPNOTSUPP;
 	/* Check input data transformation capabilities */
 	if (rxfh.input_xfrm && rxfh.input_xfrm != RXH_XFRM_SYM_XOR &&
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index 5c4c4505ab9a..a06bdac8b8a2 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -60,7 +60,8 @@ rss_prepare_data(const struct ethnl_req_info *req_base,
 		return -EOPNOTSUPP;
 
 	/* Some drivers don't handle rss_context */
-	if (request->rss_context && !ops->cap_rss_ctx_supported)
+	if (request->rss_context && !(ops->cap_rss_ctx_supported ||
+				      ops->create_rxfh_context))
 		return -EOPNOTSUPP;
 
 	ret = ethnl_ops_begin(dev);
-- 
2.46.0


