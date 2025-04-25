Return-Path: <netdev+bounces-186139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A87A9D47E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CDCE7ACDBD
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299F522DF9F;
	Fri, 25 Apr 2025 21:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5Ztm1Zd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0545D224257
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 21:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617709; cv=none; b=QAGy5YAnies3mEnVWiexUdGoUboqWZoeJ0eqSIRB9wggfOhhbiBJOdInTZny29yGkNawkBHAYZIfbo31gWkhrubi9vZ2mRJJ3d4SiJxYDKSu/RQreIyg3yhIZx/lhrRH2N9Y2w0H3ZHbGLHHKxqq38hoizoSnueUzwviY8ZtIvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617709; c=relaxed/simple;
	bh=2qsBAm5qcTQBBUijy0Dz4GRElX7fSmIu01rQyZbiUO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8WBh+WkBB+pumgKZZyePD6/dcggv3SYL646yD/5qQpmblJZ6qYhlLyY/FhpEitO3q71S+Stos3+3+M2400mPrHX8+REh1MqNrJ57OKHD8TbMMIo33PVu9GbXX67kHAtiD6+skLy04RkolIcRfvW5bhdY/85ifbb6yNvL/h6744=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5Ztm1Zd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5506C4CEE4;
	Fri, 25 Apr 2025 21:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745617708;
	bh=2qsBAm5qcTQBBUijy0Dz4GRElX7fSmIu01rQyZbiUO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s5Ztm1ZdOvjdI8V/uiGyJNo8BJdPa10Es4GmksGVNwRu2fL4YERqjyOgaQDeOhKyS
	 NLVRITIkyUwEZkdwBNnARDYPy2Q0RfCDdoXRdYLALPWI5mmM+PqlXqHHUncU5SpSsC
	 uG7Pn25zBsmyzA8BoeozcKEmSm2yfz//BvBV8f3ybY+D7LbCd9Oekz8mlg/jNunXVJ
	 OMOTeVzKWhZ1gqNMZhdhkHfh34x+mfg6WCzlCetJwbu0i3HcccjqoVESgcZ1NLDtPF
	 6xJ1ozpY9e3+wMoSYPnqAy402ZQ/ce+mMUph71tzD3ASp5bz9BaIONKEaP1Ja/TcG+
	 /AZzgGez+segA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V3 11/15] devlink: Add 'keep_link_up' generic devlink device param
Date: Fri, 25 Apr 2025 14:48:04 -0700
Message-ID: <20250425214808.507732-12-saeed@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425214808.507732-1-saeed@kernel.org>
References: <20250425214808.507732-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Devices that support this in permanent mode will be requested to keep the
port link up even when driver is not loaded, netdev carrier state won't
affect the physical port link state.

This is useful for when the link is needed to access onboard management
such as BMC, even if the host driver isn't loaded.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 Documentation/networking/devlink/devlink-params.rst | 4 ++++
 include/net/devlink.h                               | 4 ++++
 net/devlink/param.c                                 | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
index f266da05ab0d..2fbfab78030f 100644
--- a/Documentation/networking/devlink/devlink-params.rst
+++ b/Documentation/networking/devlink/devlink-params.rst
@@ -140,3 +140,7 @@ own name.
    * - ``total_vfs``
      - u32
      - The total number of Virtual Functions (VFs) supported by the PF.
+   * - ``keep_link_up``
+     - Boolean
+     - When enabled, the device will keep the port link up even if the driver is
+       not loaded.
diff --git a/include/net/devlink.h b/include/net/devlink.h
index b409ccbcfd12..ca32c61583cf 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -523,6 +523,7 @@ enum devlink_param_generic_id {
 	DEVLINK_PARAM_GENERIC_ID_IO_EQ_SIZE,
 	DEVLINK_PARAM_GENERIC_ID_EVENT_EQ_SIZE,
 	DEVLINK_PARAM_GENERIC_ID_TOTAL_VFS,
+	DEVLINK_PARAM_GENERIC_ID_KEEP_LINK_UP,
 
 	/* add new param generic ids above here*/
 	__DEVLINK_PARAM_GENERIC_ID_MAX,
@@ -584,6 +585,9 @@ enum devlink_param_generic_id {
 #define DEVLINK_PARAM_GENERIC_TOTAL_VFS_NAME "total_vfs"
 #define DEVLINK_PARAM_GENERIC_TOTAL_VFS_TYPE DEVLINK_PARAM_TYPE_U32
 
+#define DEVLINK_PARAM_GENERIC_KEEP_LINK_UP_NAME "keep_link_up"
+#define DEVLINK_PARAM_GENERIC_KEEP_LINK_UP_TYPE DEVLINK_PARAM_TYPE_BOOL
+
 #define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
 {									\
 	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				\
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 7f36bb8d970c..2fc3bd2650ab 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -97,6 +97,10 @@ static const struct devlink_param devlink_param_generic[] = {
 		.name = DEVLINK_PARAM_GENERIC_TOTAL_VFS_NAME,
 		.type = DEVLINK_PARAM_GENERIC_TOTAL_VFS_TYPE,
 	},
+	{	.id = DEVLINK_PARAM_GENERIC_ID_KEEP_LINK_UP,
+		.name = DEVLINK_PARAM_GENERIC_KEEP_LINK_UP_NAME,
+		.type = DEVLINK_PARAM_GENERIC_KEEP_LINK_UP_TYPE,
+	},
 };
 
 static int devlink_param_generic_verify(const struct devlink_param *param)
-- 
2.49.0


