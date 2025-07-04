Return-Path: <netdev+bounces-203994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A92AF8715
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 07:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115561C46C61
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 05:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD271F0995;
	Fri,  4 Jul 2025 05:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDaB9UK6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37072202F71
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 05:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751605202; cv=none; b=j+Tckh2nSpNSwVCSNhqW7YM5/xenD0cPRubKLiijJVJv1miT9Gl+HojKhe32mNhJbWVKM7n0BYOEy6s9+99QoCuXMW31ix5rr2G3XkoHNJJ0znVrAKHk6kZD1ZjERlXS8DUANJ8XMqDWWKh4Vwkx1xNklU5t7EQWL5FbIyQe0i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751605202; c=relaxed/simple;
	bh=zvoc0LPYOeqqIPwoE9YqHKbFS0LjR6Y/cA8my0h8PjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnsXkpxvZZl8ABjQIwUv451DmDn1+JIvCDSgugj3rCPmBodhVKSzSpJraY5zI6vWoR/xG3nh5HqoAQ4getyfL0VHEpnxQM5pKnS6jAadHKGgCje4NOgQi3ClRr2qKSnVD9tJQTzBml5dKsLB8U+dGKkki+Tj1yJIv79pnhSMTpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDaB9UK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04366C4CEE3;
	Fri,  4 Jul 2025 05:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751605202;
	bh=zvoc0LPYOeqqIPwoE9YqHKbFS0LjR6Y/cA8my0h8PjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JDaB9UK694opcLZ8gBkfVBDrUArkjMBhJ3m1SLGFdIeMpCESH/PeVRQV/1Fj8XLyD
	 efO4RUK/+f5YK4LRP3ENCT0OG3RolXfUJdDWWGjS+2PL+umwEcUyhlYjTGP3lmJw67
	 W+935poryNVtPnrskJu+nLjbBuQI/vIYf4lDPvIL28Scq0b0tr80kVwiKnp0jr7deN
	 tZi5sy6eF1R2EUp7iqdgFeL1C63R8wyJHpmsonsW4obWx1+/b9k4C4oSs/r3QAFuas
	 Eh4nhaRkpFCskV1zq8MRzqHWblNVjrDC35qCJx6LKc44vThoG5SvgOah7uQzu6K9in
	 Yh8KJNOKu0hBg==
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
Subject: [PATCH net-next V4 09/13] devlink: Add 'keep_link_up' generic devlink device param
Date: Thu,  3 Jul 2025 21:59:41 -0700
Message-ID: <20250704045945.1564138-10-saeed@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250704045945.1564138-1-saeed@kernel.org>
References: <20250704045945.1564138-1-saeed@kernel.org>
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

Issue: 3962500
Change-Id: Ibaf98f6f90b92f015ca3884bfeee007ab51c8d32
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Issue: 2114292
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
index 67751c612e10..444e12b80e21 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -524,6 +524,7 @@ enum devlink_param_generic_id {
 	DEVLINK_PARAM_GENERIC_ID_EVENT_EQ_SIZE,
 	DEVLINK_PARAM_GENERIC_ID_ENABLE_PHC,
 	DEVLINK_PARAM_GENERIC_ID_TOTAL_VFS,
+	DEVLINK_PARAM_GENERIC_ID_KEEP_LINK_UP,
 
 	/* add new param generic ids above here*/
 	__DEVLINK_PARAM_GENERIC_ID_MAX,
@@ -588,6 +589,9 @@ enum devlink_param_generic_id {
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


