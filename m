Return-Path: <netdev+bounces-170504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DED4A48E5A
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7961B3B4F8C
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C83155C88;
	Fri, 28 Feb 2025 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adbnsuHn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52678155393
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740708807; cv=none; b=CBvkxnorVsuTaMDsT6yF8U4qRuk/x0jXWT4GU5fLQZCsD6crfbw9DZRUXFlobrIwSi7rJRHoXSjS+b3hFiOfzyVfvOTiXhXRQpqKxmq+oAtW9u7+r2gjcIqilNTHieTth4Q1YdM0Fvejb8thxokgK4R3OBHs12typxRAC7gwlEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740708807; c=relaxed/simple;
	bh=HE9WGnKckoIPRwgIa2MwuKMbjUsExbqAECEfcrhsSwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4qwB371k1EXsjLOYfzsP9aN3WT1ixE/Pkik9mi6hgAIda+aPwGBYqtaFiWBM3oxWqXbn5DpJdDVOq/JQIja5FM9L74ZkpgCcTB4uwxJmGUx77ECUCr8N+V2mmoogf6I+nGhj0dmuWbi/UdVpq/mR1mJdzAwwFejZ4gIq4lBc4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adbnsuHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A69C4CEE7;
	Fri, 28 Feb 2025 02:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740708806;
	bh=HE9WGnKckoIPRwgIa2MwuKMbjUsExbqAECEfcrhsSwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=adbnsuHnZum3F4QLXUegKFJZn5l9eYxOlV2LIdaf923aXkbeEExwPRrH/Iv+AKlvC
	 wl6+Tlktl6akg3atFNLngoeGhyB/nCZI7oyYeyBQvKxQzvXwQTXtvBwgByNE/5Ffik
	 w97C4yGz2tbGMnmi55Ff3pxqQJLWzWeSkx+h56fbG1xGaTAp8d5yLs2Uy+JlWE9bOc
	 TaXqtm/99RkfveLS2p2LYTQzJiY8073Fr759wFL08OyUWNC54rJ/5qFRygK2wZoEKR
	 w97MiHfNV+7SE0AmKVBo+xT40wmdtm03NmZqnuypQGkvuA934JqpWWU/pYN7qLYOK7
	 +qlcDimKKy/kA==
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
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: [PATCH net-next 02/14] devlink: Add 'total_vfs' generic device param
Date: Thu, 27 Feb 2025 18:12:15 -0800
Message-ID: <20250228021227.871993-3-saeed@kernel.org>
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

From: Vlad Dumitrescu <vdumitrescu@nvidia.com>

NICs are typically configured with total_vfs=0, forcing users to rely
on external tools to enable SR-IOV (a widely used and essential feature).

Add total_vfs parameter to devlink for SR-IOV max VF configurability.
Enables standard kernel tools to manage SR-IOV, addressing the need for
flexible VF configuration.

Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
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
index e19d978dffa6..d163afbadab9 100644
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
2.48.1


