Return-Path: <netdev+bounces-203986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02525AF870D
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 07:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 404DC7A617D
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 04:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869F11F2C45;
	Fri,  4 Jul 2025 04:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9BXRClk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633DA1F0E3E
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 04:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751605194; cv=none; b=pi2Kd15RnwdhU0qEC4h4hzM/V1GYl54ef/KUTZ5X7ek7dlWdKbGy+5tG3712diY5pLolV3rw5XYuctgnkdxY9EGyPynSOnsJ22ZJH2EL7ligYbI4C1WlnBbph4Rt7WIzYGetf40ziHxwvqwiuq+hinfBnEE8BxslPlUncV2zhXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751605194; c=relaxed/simple;
	bh=fMtMLZUZ7u+XZFXFoBb4MBwhhHxABCDQXGuQ6dtYtyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9mRw431dUEgvGRdcBEUT5gMC998v5tuf72PkmnYFaLtLL5LuIdrIW/yzWl7TxSLsO/3WEU6wecYfUeB5HKEBEGkIiPif/e2sLLUzFJXYzjORWY9ucjcWs4D337+N13jSsVI58R/kl0qsXF7I4MXUYYSYY0/6pg9sJ3dmhAunfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9BXRClk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4C3C4CEEB;
	Fri,  4 Jul 2025 04:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751605193;
	bh=fMtMLZUZ7u+XZFXFoBb4MBwhhHxABCDQXGuQ6dtYtyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9BXRClkymz20Jf+WQHpfcM9WmeGiUMEsV3YtlnddqIEAetXQJSROIVU8QuZh81Id
	 NG6OEDWbc/h1U0ys3OxHI1/SN7IJXgbDWdde/pDbGUn5BlanlJRCcweJhQ/VHJ20uG
	 78kzxIbxXKIxJchx2iB9I5D8IJ9kfzrtNK85tgRv5boze+jfMj7RPycjMVIXbqg0k1
	 7zZPqJ9mE2LKBHFOO6FlSniNEqH3s9jO6kar3ve8EAH8c4wzXFtbDGNb74H+1pB1wd
	 MRfqKaI9LtIeVGd5tJb6N7wR5Fv50/hxhhQtX5PumSjoajix+VZSauUEPxAA7Mu3n9
	 PLQPlzhdRsFVw==
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
Subject: [PATCH net-next V4 01/13] devlink: Add 'total_vfs' generic device param
Date: Thu,  3 Jul 2025 21:59:33 -0700
Message-ID: <20250704045945.1564138-2-saeed@kernel.org>
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

From: Vlad Dumitrescu <vdumitrescu@nvidia.com>

NICs are typically configured with total_vfs=0, forcing users to rely
on external tools to enable SR-IOV (a widely used and essential feature).

Add total_vfs parameter to devlink for SR-IOV max VF configurability.
Enables standard kernel tools to manage SR-IOV, addressing the need for
flexible VF configuration.

Issue: 3962500
Change-Id: I1fb8cf4a76a73f4713c09ea56c3644784094340d
Issue: 2114292
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


