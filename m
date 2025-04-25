Return-Path: <netdev+bounces-186131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6906BA9D472
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 23:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7842A1BC8177
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 21:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FED226D19;
	Fri, 25 Apr 2025 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apo+MCgJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5254226D07
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617702; cv=none; b=sj5IEDBR+9u+U9Kj0GLnSCXtVOoSkfnBDz72QEY6LZA/h5h3NejvYDckm5U6K6Ytvf6RwVOyAh6q7XBV8uD10Jy7Eb5vci/EaiLAtZY1HJ5IrkQRoxn7KjjDKq52OxnZSmtzrOS3tUF7yxTAPo9c64wf1edtyGywJmGRs414zs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617702; c=relaxed/simple;
	bh=N5MOyvkCX1oGLmoPB7ZcRHnWp4lTySKrfFszFbIRX1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ncR0mPgxPf3RFjtoOZB9VL3vKnBaBk8RllhdZ8WwWJHhlbn974NOtkUHl3G6jZrpPywT/qMchqYpGtWujYA6xdaxAjqgXmZjpLeMidtMUROvsZYdb/cMjAZ0dTe+RIaZjXWU0MPXswsUic2dWsEEyy4jCEaSbUXcEdGa0oW3phc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apo+MCgJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E16C4CEE4;
	Fri, 25 Apr 2025 21:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745617702;
	bh=N5MOyvkCX1oGLmoPB7ZcRHnWp4lTySKrfFszFbIRX1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=apo+MCgJbyMuXICGyVCrOy2vegcEfHgEpqAv9hAlY8tRs8iSpS/KSacQ9sxJw77F+
	 GwFwMNeBDZzwxMK1CfAWeC+maQeVYJkJEOZ4YZMO+sQWIXObasW5PVqmd96+Uxs5UK
	 yF7v489FsQMmfFRS46k7Kg5rBB9EtfFNJVOMHhwhXcrYdY8lyxz+wCo6xW6TJH+++j
	 xNprOeL4/Y1E16+IQpLs7Ada/u/ZatzQyoiHUKJJ2IIn7DNUEq7G9tkQc47EV7V1Fw
	 wyL7FmZIt1LSXB1ujfLgq1USPBGf2TlfY48U2JUks0mwFAV8wfXocttCIIPA4uD+QG
	 y8RjnSsldVByQ==
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
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Kamal Heib <kheib@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V3 03/15] devlink: Add 'total_vfs' generic device param
Date: Fri, 25 Apr 2025 14:47:56 -0700
Message-ID: <20250425214808.507732-4-saeed@kernel.org>
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
index 4e01dc32bc08..f266da05ab0d 100644
--- a/Documentation/networking/devlink/devlink-params.rst
+++ b/Documentation/networking/devlink/devlink-params.rst
@@ -137,3 +137,6 @@ own name.
    * - ``event_eq_size``
      - u32
      - Control the size of asynchronous control events EQ.
+   * - ``total_vfs``
+     - u32
+     - The total number of Virtual Functions (VFs) supported by the PF.
diff --git a/include/net/devlink.h b/include/net/devlink.h
index b8783126c1ed..eed1e4507d17 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -520,6 +520,7 @@ enum devlink_param_generic_id {
 	DEVLINK_PARAM_GENERIC_ID_ENABLE_IWARP,
 	DEVLINK_PARAM_GENERIC_ID_IO_EQ_SIZE,
 	DEVLINK_PARAM_GENERIC_ID_EVENT_EQ_SIZE,
+	DEVLINK_PARAM_GENERIC_ID_TOTAL_VFS,
 
 	/* add new param generic ids above here*/
 	__DEVLINK_PARAM_GENERIC_ID_MAX,
@@ -578,6 +579,9 @@ enum devlink_param_generic_id {
 #define DEVLINK_PARAM_GENERIC_EVENT_EQ_SIZE_NAME "event_eq_size"
 #define DEVLINK_PARAM_GENERIC_EVENT_EQ_SIZE_TYPE DEVLINK_PARAM_TYPE_U32
 
+#define DEVLINK_PARAM_GENERIC_TOTAL_VFS_NAME "total_vfs"
+#define DEVLINK_PARAM_GENERIC_TOTAL_VFS_TYPE DEVLINK_PARAM_TYPE_U32
+
 #define DEVLINK_PARAM_GENERIC(_id, _cmodes, _get, _set, _validate)	\
 {									\
 	.id = DEVLINK_PARAM_GENERIC_ID_##_id,				\
diff --git a/net/devlink/param.c b/net/devlink/param.c
index d0fb7c88bdb8..f1f453ce0073 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -92,6 +92,11 @@ static const struct devlink_param devlink_param_generic[] = {
 		.name = DEVLINK_PARAM_GENERIC_EVENT_EQ_SIZE_NAME,
 		.type = DEVLINK_PARAM_GENERIC_EVENT_EQ_SIZE_TYPE,
 	},
+	{
+		.id = DEVLINK_PARAM_GENERIC_ID_TOTAL_VFS,
+		.name = DEVLINK_PARAM_GENERIC_TOTAL_VFS_NAME,
+		.type = DEVLINK_PARAM_GENERIC_TOTAL_VFS_TYPE,
+	},
 };
 
 static int devlink_param_generic_verify(const struct devlink_param *param)
-- 
2.49.0


