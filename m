Return-Path: <netdev+bounces-208038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC4DB09865
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 01:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F743B0855
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 23:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5C9244690;
	Thu, 17 Jul 2025 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mj2KLFgJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F47242D7F
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795852; cv=none; b=FU71ISUtSgpHe6JUkWLl6mqDEDOAnp3LUkgPLaCvOCvSdHsqRiuFhJnIBOjuKF0yzJSNaQ/y25cu+p9ndoclZ5q4k22G7p1kaI3e524c+GQ7LnbKujxq987k2YTOcJ7UywMW3r5afd8QDZaoYLkjy104S2qOSazrc9AFEL4hzco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795852; c=relaxed/simple;
	bh=leKWwje9Kq/GGchGQwLBSeENJaFW+oS1C9Gl+TfrRt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fiCdvF7iYupbRV1oybT4+e5oPKFvRYUE+TrFBLQAwDMYHIdJc4if3M+1rJb4qx5zUYYWaPy1U+DleKEaFuaYjO6f0lOetjr1nqjt2fWmxukBcDUxryHmb+0bXQeGBWRMXgosNE/kq9L3Zoe8sQqgRVTb3r6kOU4W4SzUxZgjDfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mj2KLFgJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AFEC4CEEB;
	Thu, 17 Jul 2025 23:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795851;
	bh=leKWwje9Kq/GGchGQwLBSeENJaFW+oS1C9Gl+TfrRt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mj2KLFgJWRlh9yo+kwS9yhsO6Zg1YTfcf6LEmGwBPIy6eLH8UE6VRyZ+FLicpTxdr
	 cDvpb8qb6LkRzryTquRvtVPYrYP7yFynvtt3xh8hdHVjzFEdpVznm1uL/gyiLzuRer
	 tz/OWvrtS8p2wv/LBNVeWspXzcomhJ5RF2QIhrZx7XyzJIRmtxlysWeIZ0Y0Dav93Z
	 DkrnP0FrVy0WxBTMLZDdib34goaGaR5dyLk5bkFkH5Xdz8+NW4SIvNA5uqKNKZIaQU
	 oa/cblGVIxyzrmWn/hWSQdLANHUxZOnlyaXfPbqda+TmdONKMQR3QwLrJmn79gKG8I
	 NvPmJvMZ3PbMA==
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
Subject: [PATCH net-next 1/8] ethtool: assert that drivers with sym hash are consistent for RSS contexts
Date: Thu, 17 Jul 2025 16:43:36 -0700
Message-ID: <20250717234343.2328602-2-kuba@kernel.org>
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

Supporting per-RSS context configuration of hashing fields but
not the hashing algorithm would complicate the code a lot.
We'd need to cross check the config against all RSS contexts.
None of the drivers need this today, so explicitly prevent
new drivers with such skewed capabilities from registering.
If such driver appears it will need to first adjust the checks
in the core.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 4dcb4194f3ce..82afe0f2a7cd 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -829,6 +829,10 @@ int ethtool_check_ops(const struct ethtool_ops *ops)
 		return -EINVAL;
 	if (WARN_ON(ops->supported_input_xfrm && !ops->get_rxfh_fields))
 		return -EINVAL;
+	if (WARN_ON(ops->supported_input_xfrm &&
+		    ops->rxfh_per_ctx_fields != ops->rxfh_per_ctx_key))
+		return -EINVAL;
+
 	/* NOTE: sufficiently insane drivers may swap ethtool_ops at runtime,
 	 * the fact that ops are checked at registration time does not
 	 * mean the ops attached to a netdev later on are sane.
-- 
2.50.1


