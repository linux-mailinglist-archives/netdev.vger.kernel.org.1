Return-Path: <netdev+bounces-204361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DCDAFA28B
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 04:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DB63B859A
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 02:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537E315746E;
	Sun,  6 Jul 2025 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gw9rIO7B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F53814AD20
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 02:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751767434; cv=none; b=lel0wltpfNlOJT3xQM9uh5BHHenEGBX0eIhAk+PPab5dwANq7UdcML4Y25M3ZUGauCie64Iyg5qW8AIRhZiSJZoTKmdOh36egIcuwZcsCJtQEGRgXA/tFs/f31+yxBPzUgyiTX3+TNUNNdg1EuN1CfhahhkHxI4KNF8u/5NjKFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751767434; c=relaxed/simple;
	bh=iHLRDMbVWHA7N5bZXhNJBxwJmW7h48rM7zEg7+zLbVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KNzqshQrR+6CiDT4rxgke6sYl7xZKLDNRwqBc99ak/IbbeBZl7mkTPmNAGCm2LN7QD0nFpYCAf8OK/LbGs7SYCO8gkIs9XFeTGiU17NHQ8Xg6TNZaHVDsKNJIhwfDHwxKEF6wthZ8tL5XQBeATYIX/SdYiSNqDeGhleqnTO3KU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gw9rIO7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93B9C4CEE7;
	Sun,  6 Jul 2025 02:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751767432;
	bh=iHLRDMbVWHA7N5bZXhNJBxwJmW7h48rM7zEg7+zLbVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gw9rIO7BO0RrA9m+/WBOnRt3Wf8rW9xCK1glWjsA4Cvw6jRxaEqL5/WidbM+BWfDo
	 AQ6wZYvnKkJQyRsSc/XpjgnkPOj+3pJO+yEJFWXJ+CwjCkGmoMAKBSdYWNIjSlT3Bm
	 fH9uglY8+vTODQNHiZ1/q8KOO7Unql0vzq7OH0HMEDy1/svyv1Euvv4g99E1WayI7S
	 VWH+wRZp5u65Y8gBHOrEy5JjMRZPaB76izMXdmjj3sqDOAx/2UguvhZgcIoN/dpKqv
	 8xMPMsnV/Kz8f189qOT7r0IaNGX7Ndz4HKfGYouDyPmxJESuUoW8asDvTiGyNcnsAg
	 vk+doMmBwOW9g==
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
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH net-next V5 01/13] devlink: Add 'total_vfs' generic device param
Date: Sat,  5 Jul 2025 19:03:21 -0700
Message-ID: <20250706020333.658492-2-saeed@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250706020333.658492-1-saeed@kernel.org>
References: <20250706020333.658492-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlad Dumitrescu <vdumitrescu@nvidia.com>

NICs are typically configured with total_vfs=0, forcing users to rely
on external tools to enable SR-IOV (a widely used and essential feature).

Add total_vfs parameter to devlink for SR-IOV max VF configurability.
Enables standard kernel tools to manage SR-IOV, addressing the need for
flexible VF configuration.

Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Tested-by: Kamal Heib <kheib@redhat.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 Documentation/networking/devlink/devlink-params.rst | 3 +++
 include/net/devlink.h                               | 4 ++++
 net/devlink/param.c                                 | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/Documentation/networking/devlink/devlink-params.rst b/Documentation/networking/devlink/devlink-params.rst
index 3da8f4ef2417..f2920371622c 100644
--- a/Documentation/networking/devlink/devlink-params.rst
+++ b/Documentation/networking/devlink/devlink-params.rst
@@ -140,3 +140,6 @@ own name.
    * - ``enable_phc``
      - Boolean
      - Enable PHC (PTP Hardware Clock) functionality in the device.
+   * - ``total_vfs``
+     - u32
+     - The total number of Virtual Functions (VFs) supported by the PF.
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 63517646a497..c10afb28738a 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -521,6 +521,7 @@ enum devlink_param_generic_id {
 	DEVLINK_PARAM_GENERIC_ID_IO_EQ_SIZE,
 	DEVLINK_PARAM_GENERIC_ID_EVENT_EQ_SIZE,
 	DEVLINK_PARAM_GENERIC_ID_ENABLE_PHC,
+	DEVLINK_PARAM_GENERIC_ID_TOTAL_VFS,
 
 	/* add new param generic ids above here*/
 	__DEVLINK_PARAM_GENERIC_ID_MAX,
@@ -582,6 +583,9 @@ enum devlink_param_generic_id {
 #define DEVLINK_PARAM_GENERIC_ENABLE_PHC_NAME "enable_phc"
 #define DEVLINK_PARAM_GENERIC_ENABLE_PHC_TYPE DEVLINK_PARAM_TYPE_BOOL
 
+#define DEVLINK_PARAM_GENERIC_TOTAL_VFS_NAME "total_vfs"
+#define DEVLINK_PARAM_GENERIC_TOTAL_VFS_TYPE DEVLINK_PARAM_TYPE_U32
+
 #define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
 {									\
 	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				\
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 396b8a7f6013..3a5fe0a639ea 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -97,6 +97,11 @@ static const struct devlink_param devlink_param_generic[] = {
 		.name = DEVLINK_PARAM_GENERIC_ENABLE_PHC_NAME,
 		.type = DEVLINK_PARAM_GENERIC_ENABLE_PHC_TYPE,
 	},
+	{
+		.id = DEVLINK_PARAM_GENERIC_ID_TOTAL_VFS,
+		.name = DEVLINK_PARAM_GENERIC_TOTAL_VFS_NAME,
+		.type = DEVLINK_PARAM_GENERIC_TOTAL_VFS_TYPE,
+	},
 };
 
 static int devlink_param_generic_verify(const struct devlink_param *param)
-- 
2.50.0


