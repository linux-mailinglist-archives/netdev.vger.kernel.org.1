Return-Path: <netdev+bounces-116222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ED9949858
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 21:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78111C2144F
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 19:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BBF15383D;
	Tue,  6 Aug 2024 19:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zt+h6TTU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A92150990
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 19:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972820; cv=none; b=qOk+IkWrm1imwDpJ3IYzaKp+fZEf22skSXzhirPJ617ze1C7QzRobIWH9RHu49E/omuUu9NtJhl4eeY1sArMnRulZMRCn76XpiCok7ick32Ii+bDdg3pVwXTmJ+UHvdbUDZBfVmO3puHZIQsRWPsP9LGx1ef6SjtPGKkCKh0B7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972820; c=relaxed/simple;
	bh=zuGG0Bgj9l5xKD+PHF+G/QrgAraol3r0Zlqzr4Zap7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwZfIxeuSW6APjqRzN0nY/YC4K8G/1UV1RldcEDdBmvWJ+cf3iwNYnFn9QF4qJU2XO1AwStHPjpsdowuTJv3w/Kudb5L3CG3ROL7GgLdATP7K2ZjUDuRnOfZc75CHI2M0a2Nj472SIA6E88P0T+HJ25EA77nwBLXUmrS47zgIUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zt+h6TTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE9EC4AF0D;
	Tue,  6 Aug 2024 19:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722972820;
	bh=zuGG0Bgj9l5xKD+PHF+G/QrgAraol3r0Zlqzr4Zap7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zt+h6TTUkATAb01jHMXpq/1xX0espaTHSszEe3Mt5DbRMbQm3McBw0T3KHa1VYJGu
	 8ZLGjCfJgfdxaQXczYeI7iBT3KpIDWNULNnOZ4DRkQCyTB4FiWs1SUfNET0TFoN8xE
	 PxqxDNH6zbJfVQn5sNS9vow6vpfUbFXRZgvY0N6n8qY8Ultrl5MSFosWD3QtpqcFq7
	 KwKhbIMT5KwXpJODOhJBjSygKzWntLtSM70jrTX5rG5vk3d1wUDgFEiaCDPrDwAwuR
	 n3L4IfjQJrUjyGxCEJBkttVkoZa4JSUqf8p1v0RrE85OI+/roXXofEd34QrNQQZXT6
	 3ydHovTa6Wgiw==
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
Subject: [PATCH net-next v3 04/12] ethtool: make ethtool_ops::cap_rss_ctx_supported optional
Date: Tue,  6 Aug 2024 12:33:09 -0700
Message-ID: <20240806193317.1491822-5-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806193317.1491822-1-kuba@kernel.org>
References: <20240806193317.1491822-1-kuba@kernel.org>
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


