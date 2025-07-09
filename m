Return-Path: <netdev+bounces-205237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E47FAFDDCB
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 05:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4919E3BB8D4
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 03:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC66A1DFD9A;
	Wed,  9 Jul 2025 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Re7Y84vj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8812B1DF261
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 03:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752030307; cv=none; b=PbWgb7RKJ21umFPAa4+m6gqgmz3+VhwOV7Nw184/0a8F4fM4QK7zHlOj1V8lv81fDchEMmJtsdCD9FQ0Gpc0vFZqc95XPjUTmcM92uiZ66A95YYckhwNhHNm16fRNGqohWuLm81a34TX8FuWssJJigc4TUcPS9n8Snvcc/syVxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752030307; c=relaxed/simple;
	bh=DtBu/+IkiCv2ilm41z19btwQtH7Pal6WABx7rktrgtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByHF7KzFOcw7llQHzmTcl5n30wJ/moep00CPCxXtBLJxNZlyrBh64x5YxhehsVtD0Jw/dVVvZ4VVbVvrjuoEu1WpTEBm5E0tjwgptcUYCPTf+qOhDeKg939So213S8tadoyubwK4SEse2ZOn/h/eM3uZ4q4ukHO6z/8ZLwszwkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Re7Y84vj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480CBC4CEED;
	Wed,  9 Jul 2025 03:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752030307;
	bh=DtBu/+IkiCv2ilm41z19btwQtH7Pal6WABx7rktrgtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Re7Y84vjS3VCvkHS3U0HqS1641X7V7v2iJMitLjaIP7BuciB+t+XbJvn20TY9sJxk
	 veekQBA6MfZQBKSdUW040zzoR6NnKXqsKXbsMVHguqzfZUFETeSqrpV77XkA/MqeiW
	 BTJTC9PRQtUc4wUoxD8ftTH3ace2y8I7GvdR3EQiJ+/0/Ns2pBkUgwcrSJMattGC/8
	 mjSf1Xz4EmXDgB7SoFAREt4x8AuN6bzpLgqTlRfPQbNbeMY3ECwqUIz3w6xpS/qQyn
	 6UyrpwtxEP2zm8FqIcTWIAja3wqX5sOeqcRNwYHd4ieb0+IuLuht4EBhvEQm1Ac0L8
	 /Sk8sPCNYITAQ==
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
	Simon Horman <horms@kernel.org>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Kamal Heib <kheib@redhat.com>
Subject: [PATCH net-next V6 01/13] devlink: Add 'total_vfs' generic device param
Date: Tue,  8 Jul 2025 20:04:43 -0700
Message-ID: <20250709030456.1290841-2-saeed@kernel.org>
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
index d0ce5a7e984c..32508b4d5df3 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -523,6 +523,7 @@ enum devlink_param_generic_id {
 	DEVLINK_PARAM_GENERIC_ID_IO_EQ_SIZE,
 	DEVLINK_PARAM_GENERIC_ID_EVENT_EQ_SIZE,
 	DEVLINK_PARAM_GENERIC_ID_ENABLE_PHC,
+	DEVLINK_PARAM_GENERIC_ID_TOTAL_VFS,
 
 	/* add new param generic ids above here*/
 	__DEVLINK_PARAM_GENERIC_ID_MAX,
@@ -584,6 +585,9 @@ enum devlink_param_generic_id {
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


