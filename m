Return-Path: <netdev+bounces-182451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33D2A88C93
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 22:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85696176836
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F231DE2D6;
	Mon, 14 Apr 2025 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYltshw1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923B61DE2CB
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660817; cv=none; b=XfZwtusAEjd5KMNU/6c23tHWB9/57/wxgyufu02MMgW6tcAeAGDqDdxlGVDXsB0+nqESAsco2bab9GcydnPjY+JMw4+L1HUpbIbnAPOVHY7XRFSnxz0LPFiekrVD28JQiswMGxjPM2JzHbxBo8Y7uul0Ovy56GIu7Hnnjs3GxmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660817; c=relaxed/simple;
	bh=+MKQOpmjG4snyvBW5pLcpRa/tdtt6j5ZFglTJO0+/co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SspYCCs223EctJIBo3qTd3eZb0sOsYEHIq/lLNRyAWLxJwtbSU4Ifdhmo6xVUASB3ekofdcOWJuU8Ib5ZSR3UkJPp9yuC6+qo5nxlJUeRYa9/2EK2DoB/0sdVuREhkPrCZ/I+adsI5n0eMiseLYlpD/vdHaWPEmXsLl5Fj6qRBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYltshw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE44C4CEE5;
	Mon, 14 Apr 2025 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744660817;
	bh=+MKQOpmjG4snyvBW5pLcpRa/tdtt6j5ZFglTJO0+/co=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cYltshw1UC+6THoxQtK41MUZfWTruaWpKPDPc5+lI0TLSVLSpNupCOgpJqL8bBROB
	 pNHQMXky0l9zDFnhY5nUkHbGwcTMckhqurJsXjkaEZH1x64uMgH3eNSF/2FPOxq81K
	 VHmcp8r01CgqMLYFurwPNNej12ouh2rV0liWs6G1T8I8VPAhFbaV5+AMpWwDIaTJ25
	 Xx/D3dUvkSxY8Uetbwre4I7GzCd6RQrvN6a4QKyONh68KW+ocIfTg3oQtMUV2BbmIB
	 cUzSW0dzRFFTZR5V4e2Tc/xDbVoFVbGgIxjD5Yva7TRofuFlK7jc6thYPZrlDRiwwI
	 fQASoYLeacSTQ==
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
Subject: [PATCH net-next V2 02/14] devlink: Add 'total_vfs' generic device param
Date: Mon, 14 Apr 2025 12:59:47 -0700
Message-ID: <20250414195959.1375031-3-saeed@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414195959.1375031-1-saeed@kernel.org>
References: <20250414195959.1375031-1-saeed@kernel.org>
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
2.49.0


