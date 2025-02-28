Return-Path: <netdev+bounces-170512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7DEA48E62
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529243B5034
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F388189902;
	Fri, 28 Feb 2025 02:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2q9Bm/w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF2A191F94
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740708813; cv=none; b=LFsnM79JTntpg49BH3HP+0GrNc13T8dAZf48QjwvL9Sn23BF6BIjondTOlpoupeP2+8AM2bHry1dkC+2bgYFktmyRDKTU4qiwag6aqFAu+aY8qRSDXTdscX4p3BtxE4j31SftA+vcals+13ZFx86yM2qX5EgpyNpF8j49/wg804=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740708813; c=relaxed/simple;
	bh=e2UyFwvb7YG6fS/MIJ7A6ZIuqda98izGWJzliK2kf94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DP+FT/xkOEAWMOw17mNBb6OKPbLY+7ZCEYExIrIjjLEmv21kWRaebuC8QpyI1OrnZqhbTcVatC7ngJan1PBtpHO/Twh4zl62VId4HxRjcWfxuoXbafaPo2z22IuIHPpFKpb04GGG6GLgIAbH5DX/AD1V8nII42xxVG+/v/NaGq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2q9Bm/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38448C4CEE7;
	Fri, 28 Feb 2025 02:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740708813;
	bh=e2UyFwvb7YG6fS/MIJ7A6ZIuqda98izGWJzliK2kf94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e2q9Bm/wOeOs6jZPU94ThfPSalD6oAynV4Aud4/Vxr0GfNHYLlfJNkDIQs8msckAz
	 JruqosCobzKRsH4P1cdGLBfOT3mbltrp4L2FR9/NCQZYpY2IDaWwFqcATfAV1sl7bt
	 fp6Sgb3s+ykm/xeEXhA1F/oqG48V/OMkGV2ia7MgYxcOEojGC85/dWkcIcCrm/EMup
	 t7WCUtPAB2OTD8P/36yizdVj4fu1Us5ioNWSd2hB96SbnHuJUvQ9OY/4eXaVPCsoua
	 +xJRSPfTtCJUypcY7w1w1Zqn/YPFrjPedfU56/kvJ6rmitemcNAf8ISX7gdljBKOJK
	 2IWrscJJjGLsw==
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
Subject: [PATCH net-next 10/14] devlink: Add 'keep_link_up' generic devlink device param
Date: Thu, 27 Feb 2025 18:12:23 -0800
Message-ID: <20250228021227.871993-11-saeed@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228021227.871993-1-saeed@kernel.org>
References: <20250228021227.871993-1-saeed@kernel.org>
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
index c3d39817a908..03c65ccf2acf 100644
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
2.48.1


