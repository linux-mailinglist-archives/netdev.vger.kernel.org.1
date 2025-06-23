Return-Path: <netdev+bounces-200421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 916DFAE57D4
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 01:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7AA1C25B04
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 23:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB34222D4F2;
	Mon, 23 Jun 2025 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDMM6juz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E3222D4DE
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750720645; cv=none; b=uWGdNOmdNpSpgkEwpgQXLYmlxC/5H19GFpCF5fT62m11S256ol3qzRSMiGZHrLOsEUT3m+OI0yohq7ZxCFZj6NGfLe7iBqEi7DxgDCW0ME9fk+/LFtsBhqaMQUFfCD9kLpDvnSVg9et26T2NmEruK/TuoZvzlnU65xQfVm1EDKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750720645; c=relaxed/simple;
	bh=o5gbc0Ad2hc2oA3o8yDWjlwmBSwHkfHHkUBVMr+37/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVM/Uqoe6srKhLMi/ktJ8kzGMC1itWrM5n/fda7Ab0XOuN/gv7orfHxxtR4s+a6ivgW1q5n0gQdXFE4wtqiFu7dCyQdWVuVD/cu4x485IgL1OmF/bqEa6szOqOREBihxSyn9q2Ws552ZYFkVeekIfJD9nRVjlDDqC7XLhPDrydY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDMM6juz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB32CC4CEED;
	Mon, 23 Jun 2025 23:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750720645;
	bh=o5gbc0Ad2hc2oA3o8yDWjlwmBSwHkfHHkUBVMr+37/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDMM6juzcFuHXn5I/weAyvtsaNRMXjpgrvMnRgY/nUp8AwmhINwilfLLG7yfN4AUd
	 xrTCDxlXIAwPBUSh0XCPLNPzuGRDbYqkOuVdCVP+b2ZqBtp/CzSXEUVC4o8ivZ1UY+
	 cxF9hbLFSoNR3MyG4W4/xKL2g2A2TTntObZDhK0LyuwaULsg1DOul2lmm9PB8rgJ+I
	 BETwtiGsPKBzpnRjvAOggDU+Nl5mwVXA5/0zw3A85e+LvrrfE785Y6AB7PgNr/ILZ1
	 SAnbKUTx7Hr/VO+xWscynN7jga1u+g16KxlSYed3/Ai8aZI7xoggcdxqXKOqaxTq0f
	 rKKC0VRymPB4w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/8] netlink: specs: add the multicast group name to spec
Date: Mon, 23 Jun 2025 16:17:13 -0700
Message-ID: <20250623231720.3124717-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623231720.3124717-1-kuba@kernel.org>
References: <20250623231720.3124717-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the multicast group's name to the YAML spec.
Without it YNL doesn't know how to subscribe to notifications.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/ethtool.yaml       | 6 ++++++
 include/uapi/linux/ethtool_netlink.h           | 2 --
 include/uapi/linux/ethtool_netlink_generated.h | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index c1651e175e8b..cfe84f84ba29 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -2492,3 +2492,9 @@ c-version-name: ethtool-genl-version
         attributes:
           - header
           - events
+
+mcast-groups:
+  list:
+    -
+      name: monitor
+      c-define-name: ethtool-mcgrp-monitor-name
diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index 09a75bdb6560..fa5d645140a4 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -208,6 +208,4 @@ enum {
 	ETHTOOL_A_STATS_PHY_MAX = (__ETHTOOL_A_STATS_PHY_CNT - 1)
 };
 
-#define ETHTOOL_MCGRP_MONITOR_NAME "monitor"
-
 #endif /* _UAPI_LINUX_ETHTOOL_NETLINK_H_ */
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 4944badf9fba..859e28c8a91a 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -867,4 +867,6 @@ enum {
 	ETHTOOL_MSG_KERNEL_MAX = (__ETHTOOL_MSG_KERNEL_CNT - 1)
 };
 
+#define ETHTOOL_MCGRP_MONITOR_NAME	"monitor"
+
 #endif /* _UAPI_LINUX_ETHTOOL_NETLINK_GENERATED_H */
-- 
2.49.0


