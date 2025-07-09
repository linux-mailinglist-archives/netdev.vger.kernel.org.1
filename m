Return-Path: <netdev+bounces-205245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B98FAFDDD4
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 05:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24C5E1C2776C
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 03:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CFA20127D;
	Wed,  9 Jul 2025 03:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3SgDsdq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48FF1E25E8
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 03:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752030315; cv=none; b=JC69ekkpkTKyiLbHuWf5DMGOuJrHlfgXkV/QLJjBRQD0rG2Fg79N9pwnl2m2nzZWgwdUAE06lK9YRJ9JNAgcFtyoxcN61HHrrvlj8QoOor1x1LogK+xNSAyhl8Rx+kZsdzW1r0dZYhAurQ731USFzH2DiPbZ8fGdyb01Cn9qp8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752030315; c=relaxed/simple;
	bh=DXqVxuYIAEa90ZYYRbvgMVMEobADNe0MEGhKuAHCwpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhLe03EIra1qzI3pCtm616gmuK+v/bO8bVYFOPWmKz0yOHFPojoG4PPqZyyaP8NwY9Hd6YYgwfkHP7B8yZnYaZJb26zh/5AnlmOkkEQc4h26DEK47LkcdYO+T0DPKiu2CCFj3JVPgNAQB0aHuS8OcdBl/k/j5AHenVAtF4/njnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3SgDsdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49161C4CEF0;
	Wed,  9 Jul 2025 03:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752030315;
	bh=DXqVxuYIAEa90ZYYRbvgMVMEobADNe0MEGhKuAHCwpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y3SgDsdqKmfKac3R2C8VdAn4tbXcNcbGYHtVtUAaFeFxA4UjC2jTiY9ygWbzJWDXL
	 fa5jZDCqLSav9cH6Gb8vW8K5QymZI1l6H/VSoCJIcs/a+R4CzRZO/CJAG8sIM5BIU7
	 Hgq9/mZZBkuvnwxQ6b1JBzeMLOOgurWBEGaNQFzUafhs0lfewze829wJn9gsAdybDn
	 tkY4jZf0rGoWLkAf95+JfbDyXFttpAhRAtt0TJJddmM4DP80e++GUNGbl//E1rTiaD
	 oTd0OMGJSPCVcZ67tUNGcvpAgm0MZzczND1hQS1zbnz0B191dBU1GBRL38C2f+DU/C
	 B8U7Rr83RIDgQ==
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
	Jiri Pirko <jiri@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V6 09/13] devlink: Add 'keep_link_up' generic devlink device param
Date: Tue,  8 Jul 2025 20:04:51 -0700
Message-ID: <20250709030456.1290841-10-saeed@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250709030456.1290841-1-saeed@kernel.org>
References: <20250709030456.1290841-1-saeed@kernel.org>
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
index f2920371622c..0e9c0e17573d 100644
--- a/Documentation/networking/devlink/devlink-params.rst
+++ b/Documentation/networking/devlink/devlink-params.rst
@@ -143,3 +143,7 @@ own name.
    * - ``total_vfs``
      - u32
      - The total number of Virtual Functions (VFs) supported by the PF.
+   * - ``keep_link_up``
+     - Boolean
+     - When enabled, the device will keep the port link up even if the driver is
+       not loaded.
diff --git a/include/net/devlink.h b/include/net/devlink.h
index b2517813ce17..13331194e143 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -526,6 +526,7 @@ enum devlink_param_generic_id {
 	DEVLINK_PARAM_GENERIC_ID_EVENT_EQ_SIZE,
 	DEVLINK_PARAM_GENERIC_ID_ENABLE_PHC,
 	DEVLINK_PARAM_GENERIC_ID_TOTAL_VFS,
+	DEVLINK_PARAM_GENERIC_ID_KEEP_LINK_UP,
 
 	/* add new param generic ids above here*/
 	__DEVLINK_PARAM_GENERIC_ID_MAX,
@@ -590,6 +591,9 @@ enum devlink_param_generic_id {
 #define DEVLINK_PARAM_GENERIC_TOTAL_VFS_NAME "total_vfs"
 #define DEVLINK_PARAM_GENERIC_TOTAL_VFS_TYPE DEVLINK_PARAM_TYPE_U32
 
+#define DEVLINK_PARAM_GENERIC_KEEP_LINK_UP_NAME "keep_link_up"
+#define DEVLINK_PARAM_GENERIC_KEEP_LINK_UP_TYPE DEVLINK_PARAM_TYPE_BOOL
+
 #define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
 {									\
 	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				\
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 5f9cd492e40c..2a222d1bf81c 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -102,6 +102,10 @@ static const struct devlink_param devlink_param_generic[] = {
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
2.50.0


