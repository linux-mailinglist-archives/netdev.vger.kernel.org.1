Return-Path: <netdev+bounces-115471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C62946763
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 06:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AE01C20C05
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 04:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3E113665B;
	Sat,  3 Aug 2024 04:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1+zYLzh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADE513635D
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 04:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722659213; cv=none; b=uQIMyiouSeDu10KWiSFGHm4Z3oEgzOj26xCzDzLij33VCnPQD3A/4Y7VUGnMrnzt4ojwsoa3CRMAofV1a1rDT3OXO5UUyVCMS16vMpdkm9LtUBhvCjHEL5OTU43ElO+Y0Zi1iqimOsmBDjCAoZwoDXYBMItDUQjOjhL7TrWYI18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722659213; c=relaxed/simple;
	bh=9QWTJ3UkjaqqR3IuV/bA/w6aTyOS0uCVQVQTaaRRaS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6YjuqIus4r4f9u0nAWk4zsj7xfz2xgDgVDf1HdiQcIG3py12vgSvlPf3vyEU1V2HbEizlxr3EThmNXvOFuMJin5MzVWFN+snXJJbn/FCoNOtNzWjHreyseDOKhZI4uh/pQ3X8KGGDPb3a7go1EDNwmr6RqmGPTwY1KNgPQqKTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1+zYLzh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F3BC4AF0A;
	Sat,  3 Aug 2024 04:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722659213;
	bh=9QWTJ3UkjaqqR3IuV/bA/w6aTyOS0uCVQVQTaaRRaS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q1+zYLzhDUpviHVWkGojA44vLbCNFnugg+9fcXVrcwE2Gfi02hRXN6xr8DmPuI5FJ
	 PNLJUi4MGIQVwmeEYr5seaLLv0uLhtQtk7/bPV7txsBPspLRPbxigibNh0BHDcE4RX
	 l2hcb0BBUit3ub9Ae0xy63v6Ce0hHu9qsO6eYiGws6flJNtFUspEtdH5eNzS0LJyNt
	 P77uLuaHcAnJwhVxT8iAXpH3mPec6Y4jQoOJNdrLC/ArkX6n7pH31gWtSBqf9wdY8w
	 jP2piU8yk2hB80eSLC/64Er7uTyfpsd8qbUvvjf2OAXeC6ub+UZ7PfAol7GHZcH19U
	 HljsoyGb3AgHw==
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
Subject: [PATCH net-next v2 04/12] ethtool: make ethtool_ops::cap_rss_ctx_supported optional
Date: Fri,  2 Aug 2024 21:26:16 -0700
Message-ID: <20240803042624.970352-5-kuba@kernel.org>
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

cap_rss_ctx_supported was created because the API for creating
and configuring additional contexts is mux'ed with the normal
RSS API. Presence of ops does not imply driver can actually
support rss_context != 0 (in fact drivers mostly ignore that
field). cap_rss_ctx_supported lets core check that the driver
is context-aware before calling it.

Now that we have .create_rxfh_context, there is no such
ambiguity. We can depend on presence of the op.
Make setting the bit optional.

Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/ethtool.h | 3 ++-
 net/ethtool/ioctl.c     | 6 ++++--
 net/ethtool/rss.c       | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 303fda54ef17..55c9f613ab64 100644
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
index 8ca13208d240..52dfb07393a6 100644
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
2.45.2


