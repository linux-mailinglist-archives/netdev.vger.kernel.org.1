Return-Path: <netdev+bounces-182459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679AFA88C9B
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 22:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5747017B830
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB08A1E3DF4;
	Mon, 14 Apr 2025 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSk+FYHt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72211E2838
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660825; cv=none; b=DUIoGs50aibsVt6Lt5IawuLz4xXW6YQw6hi9ZbxvwbFmShmiyUz1Gw2YvHyefOx32gaBVHTNzg2wHNExF6H7cHlS7kTOyOktqm2wzvGm36nkL0R25aoVuvn+bQPpcsjDuq7wXe7UyTQdpJdIytXRFNgP1ZWMVd1H09aZwQI678g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660825; c=relaxed/simple;
	bh=4m07XAFXEHRao0S8aNSjGgjqwYXL2LB4RJCU06Eo5uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8fWrq7zAmj1nNdqrlQ2Gbc1w74nPGd999uh0H/DKYAf6ffyaCEdZxMAGBtrQxQk2OilYCm7pViRkMyOVL+P8ske5DWrfJX2AlqGiwSoT+SK0/SZoGt0Unb89akIv8TEz6vH3rTe2imWM0+10IG7cQHMaEkeUK625RW/9dlzruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSk+FYHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5B8C4CEE2;
	Mon, 14 Apr 2025 20:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744660825;
	bh=4m07XAFXEHRao0S8aNSjGgjqwYXL2LB4RJCU06Eo5uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aSk+FYHtp3ef66KCxk+2hjtRuUVjYSFJ6VEf39nU1w33oac/eR3q8GjwpSGVHaXIY
	 7KRZp0uTeommCNYrATQGca4hIfolTAMWStIiD4m+9l3O+/wzg2zb/UBrZcBwW89/dP
	 9ZmL2DooRawH2dcQsN7p7Ag5p6hxjYioK8N/oWu7vvuom9zDWgp1UdTnYlCuNS8TDg
	 FM/UcCfz+tdH3GwKCAlfAbAkh39MnYnvKuRGP2FeI2GbWkI3Rc4aBOrfPfwPUGmtSO
	 i/5pkju8/OxunO+Y08M4CGpLpHTYqOsWyzYRlmayTJeuaRdRnE0KKtpEdd09RM78GF
	 jN7Za4fsR2Kuw==
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
Subject: [PATCH net-next V2 10/14] devlink: Add 'keep_link_up' generic devlink device param
Date: Mon, 14 Apr 2025 12:59:55 -0700
Message-ID: <20250414195959.1375031-11-saeed@kernel.org>
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
2.49.0


