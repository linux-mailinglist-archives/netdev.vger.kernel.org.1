Return-Path: <netdev+bounces-204369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A28CAFA294
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 04:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C5977A5784
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 02:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696B719992C;
	Sun,  6 Jul 2025 02:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llFSgCkS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44239199230
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 02:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751767441; cv=none; b=OvttQ4t+buiz86jfwD8+r+3O5k4yOlJbrO2KdnyuRr+N2uaWKQ6Aky2JQH7+2IJFew1W5/BJPXiXquWp/fvJL72x4upvDBqxak2bxGMqCVJv+8JYmGcyP34dMyXviHshc5yOEQeE64rqfeHuuZOHSN6RPmuGwcRew/+SpqTNPVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751767441; c=relaxed/simple;
	bh=47oULAIXp5YyuQrpiPfJ3WG4rk1vC72P7L+PMORNOO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f46/ZftDeXbmTP4fODPTqA+5saVmoYdtS0Nt7WzUiK6WIWIHj98WfflA0Y1uJ7fEbrJo5t+aTP155rU3jWGomFSeBFM9BajIYZGE6S33XDzWuidUSsWo5+3OVX9zjw1Pjo5ZagB4fB6Qlkxl91v9cvvSSPmWFh0ur3EtGj5WLds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llFSgCkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBE7C4CEE7;
	Sun,  6 Jul 2025 02:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751767440;
	bh=47oULAIXp5YyuQrpiPfJ3WG4rk1vC72P7L+PMORNOO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=llFSgCkSdcX0a+Epp9zUWFcZl1fCeokuYncEKe4JYuEE3ZcDMp19diku5dIg6n35I
	 aEifZcmHL1oAAW2YTEIOFjqMfdF/eP/0VnJC7H94rc1xZ5ppj3VdL73dV/R+GPGAOo
	 p4swgrj9jUZ58+lRU1kVy/YkihKxr2om4trAgNDBkGQNQ2uG/GctJ3fH2wy5ZKGUcJ
	 10ICZSkq81QKfRstoBsHpdFOrxlHVV3HOepCVLWK8GcTkyT0O9rnrGHJI3mosPSFOB
	 cXA/WR/P3vL/5XbGZ3cZw5PsCP0GF6iXCXJBiQficqNrlm6VfzY0GTULo8igmAbPOT
	 ee4EDLK//Imeg==
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
Subject: [PATCH net-next V5 09/13] devlink: Add 'keep_link_up' generic devlink device param
Date: Sat,  5 Jul 2025 19:03:29 -0700
Message-ID: <20250706020333.658492-10-saeed@kernel.org>
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


