Return-Path: <netdev+bounces-117372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C763E94DAF1
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA981F21C9B
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDDC13B590;
	Sat, 10 Aug 2024 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtsTtNRZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A34A13A253
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723268487; cv=none; b=u0CsfheNkIp4YL4J48STx0u/DTTdE5oT4rOweB0IjAqDunwm8W8B+F23SdIvPv3iG6ZD6X7vhBP3s+rkYidMHJ4Ai1Lygcur93IhyT5JquBPWcpwr9zQ67amHH8izdYtrZlRs1tvctxkKF6oVVoF0uJ/+xu1Xjj89RDTJl1PM9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723268487; c=relaxed/simple;
	bh=ZnBtdeyp11brBkiQM7OLPU1kLJToVDZ0f/Vv2YsCG84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9tzLeb8rsupeSGBPP85zOmYPS1sSwiLMCE2F9wDngb/zFCZ2Nr0O48+x3nnZk8Ddak3wf90QRZwra6w9SpaQ9qYT1lhJrlxFx6EOyGYWM8MRTwuQBX0X6n24Pw/RZi37rijK2Xpxi7Ltu5bB3HysdEwFaLbifusRK40tpofXrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtsTtNRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B728C32786;
	Sat, 10 Aug 2024 05:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723268487;
	bh=ZnBtdeyp11brBkiQM7OLPU1kLJToVDZ0f/Vv2YsCG84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BtsTtNRZnbyvWbhg76UqLlbIcyCiIZHlDASnJ/Qr0ZV9A/hkQqLMh/ssC1Bax/QZa
	 7kFBcm3DyJ6Qu+nr1dfXfp/eyTCrn99GItpyQXGktUJ0d+dl7iKpl0zBR30q/Fk1Zc
	 3wbrWj7JC+0hsKyt+PXhpFQrwvdRDKR4qmzbP1ceZaPLXYYICK2M2tXG5jfGQzZ3Aw
	 jwmu0oB/zKf0w0BJRGD9vY2yp0jCXq2u/kZsB+0ZlMNVasMKDvS0vTZfGlAlMU0cG1
	 LpKIbO0OiJ3H6y9YQx4oCPCtFu8lgTFXbCiEXssA0Re071GdVmIB7ai0WY6ScfW6DK
	 hgNDhmJdMGIsA==
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
Subject: [PATCH net-next v5 04/12] ethtool: make ethtool_ops::cap_rss_ctx_supported optional
Date: Fri,  9 Aug 2024 22:37:20 -0700
Message-ID: <20240810053728.2757709-5-kuba@kernel.org>
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
index ba8630eb02ef..1698b73812ce 100644
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


