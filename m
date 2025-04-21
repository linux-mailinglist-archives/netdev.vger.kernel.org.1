Return-Path: <netdev+bounces-184454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1060A95962
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18BFB16B094
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA0622576E;
	Mon, 21 Apr 2025 22:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYiMlw4E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091E3225412
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 22:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274518; cv=none; b=mekMOich9Pii1zZZLOTP4dP36O3KythH+Rv8t1JtdBLSxEFm5Kc/nA3R74R9TE+YguDYD9mpr52J4KcVfpyrZfZSjVCtILSOZNOZKNnU+WES8M9UtUNXwCn2tI5ZeL/wzcGIpa59JDwhhQoH0exFFAR/ubY4DYfr887cPAJwrAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274518; c=relaxed/simple;
	bh=h+6s1Ix6ULO/2aQ92ulWkYyTH+KDrIARSyFfCAZ8vu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrXc+Wqf8S7HuMvL1ZtAJadBOpC85J+VxEqNDApwGpuHPwzXbW3AA7QNtHT289n7JuMy1M2vD773DmrNfd1qa/vV/tB6MZSIFejsNNp88V6MVNMdS4EWzK48Z5J5nHb+yVHT7qxlKNpKkVml0cM6y1NbPYza4w1uFk4wPqBc6xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYiMlw4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D57C4CEED;
	Mon, 21 Apr 2025 22:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274517;
	bh=h+6s1Ix6ULO/2aQ92ulWkYyTH+KDrIARSyFfCAZ8vu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bYiMlw4Ei/AZbthQXOApyQkBp1UnicbOS+3m/JJg3VgZiX8M8J0ln11E9CwIhl/iL
	 fLgXxKZunVJwc8Z+dnRDENq/Ei05Hx99HuPNBel4GnDPuY+3W3ikeGLCW+7/U/rkb4
	 EMWbAvWtUN+K6yLHhIDv+jhS+AjjJ6ziLgzN8smsCJO/D5WKhzQIdRiKTfrF6yx/1E
	 qM66tPK8JOnn/7FSvn5/27wep10Rvs99VVLYRrk3B959Eqeh9Ru3H1UqKrrfmwHH8a
	 MFQ8PKDTsvTuNiLyY7CRsBlmtAONyU9YG4DqKTY/0CfalZf8y9GdZLt1+Ph3cgOPXP
	 znP0qko4aGxuA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	asml.silence@gmail.com,
	ap420073@gmail.com,
	jdamato@fastly.com,
	dtatulea@nvidia.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 05/22] net: add rx_buf_len to netdev config
Date: Mon, 21 Apr 2025 15:28:10 -0700
Message-ID: <20250421222827.283737-6-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421222827.283737-1-kuba@kernel.org>
References: <20250421222827.283737-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add rx_buf_len to configuration maintained by the core.
Use "three-state" semantics where 0 means "driver default".

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/netdev_queues.h | 4 ++++
 net/ethtool/common.c        | 1 +
 net/ethtool/rings.c         | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index f4eab6fc64f4..a9ee147dd914 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -24,6 +24,10 @@ struct netdev_config {
 	 * If "unset" driver is free to decide, and may change its choice
 	 * as other parameters change.
 	 */
+	/** @rx_buf_len: Size of buffers on the Rx ring
+	 *		 (ETHTOOL_A_RINGS_RX_BUF_LEN).
+	 */
+	u32	rx_buf_len;
 	/** @hds_config: HDS enabled (ETHTOOL_A_RINGS_TCP_DATA_SPLIT).
 	 */
 	u8	hds_config;
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 502392395d45..def6cb4270c2 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -832,6 +832,7 @@ void ethtool_ringparam_get_cfg(struct net_device *dev,
 
 	/* Driver gives us current state, we want to return current config */
 	kparam->tcp_data_split = dev->cfg->hds_config;
+	kparam->rx_buf_len = dev->cfg->rx_buf_len;
 }
 
 static void ethtool_init_tsinfo(struct kernel_ethtool_ts_info *info)
diff --git a/net/ethtool/rings.c b/net/ethtool/rings.c
index 628546a1827b..6a74e7e4064e 100644
--- a/net/ethtool/rings.c
+++ b/net/ethtool/rings.c
@@ -41,6 +41,7 @@ static int rings_prepare_data(const struct ethnl_req_info *req_base,
 		return ret;
 
 	data->kernel_ringparam.tcp_data_split = dev->cfg->hds_config;
+	data->kernel_ringparam.rx_buf_len = dev->cfg->rx_buf_len;
 	data->kernel_ringparam.hds_thresh = dev->cfg->hds_thresh;
 
 	dev->ethtool_ops->get_ringparam(dev, &data->ringparam,
@@ -302,6 +303,7 @@ ethnl_set_rings(struct ethnl_req_info *req_info, struct genl_info *info)
 		return -EINVAL;
 	}
 
+	dev->cfg_pending->rx_buf_len = kernel_ringparam.rx_buf_len;
 	dev->cfg_pending->hds_config = kernel_ringparam.tcp_data_split;
 	dev->cfg_pending->hds_thresh = kernel_ringparam.hds_thresh;
 
-- 
2.49.0


