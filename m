Return-Path: <netdev+bounces-129848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEE9986786
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 22:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8CF2845C0
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 20:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9F114B959;
	Wed, 25 Sep 2024 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyMQP7Vb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692EA14B94C
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727295621; cv=none; b=TTwtXfdMYHLbL/MINGJyCgsvZOSLJq+uL9VuR5It3IEY7APVRIVmbDDRlNQvOqGMhrTeV7kD0KPT3Yhy93H5u4gc2jFxsiyHJjTd4MCiXr5d0W0EHhkv0cydjhadRF/+6iOgKw/vsQA88vXFsAuqaOyIzu2I7IqbmvUBn+S5QCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727295621; c=relaxed/simple;
	bh=q9heOA759Feg+gsc4h6gwRpTD5AW/fy0qmc4G7wb5s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TmtTejWR1lwb8oGf3RWtP5qVKmQRhOS7to1mejfSCImzPC37h5CgrqrlEsXQO338+zPmpERy/Zum4JDSwZFhECZ7BCFWZB5F4U+cXucoOEUEAZawfD2QZkPJIOuXuIbLmckDnOQmWX/EqKXPuz4OlDlmu1O3qzVU2SeokIvlZcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyMQP7Vb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB831C4CECD;
	Wed, 25 Sep 2024 20:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727295621;
	bh=q9heOA759Feg+gsc4h6gwRpTD5AW/fy0qmc4G7wb5s0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qyMQP7VbiB1FbzKySGeDnh8Ii+/99MFSu4htj0baSZnpVfgwXQbpesPWeCx/ap10p
	 ARuwz4S5o9p9rsdXihXw7KUg8hl8sGHYefp2daj62vRucK2zu/H0RYB/aTulCRFWOL
	 iGsRhOq2rfIlLZYF8N9iZdoP9tLwbdvb/+TT68t7T4E3N/h3akkuzBkubehT2zUf8D
	 Rwn2ViXatp4EeIfi9a8LWqZdFcJJC2X2u5a2nAU6kMN1pd5hCc5jaC2WxxwYSKpxO6
	 GjoOfzNHOn68wq6b55nnZQU1vtsW6MYmT4kvHbP1mTu5drMTMNDTdk2H3jV8ulmZ3V
	 LCeqpJeQMnaHA==
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
	Elena Salomatkina <esalomatkina@ispras.ru>,
	Simon Horman <horms@kernel.org>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [net 3/8] net/mlx5e: Fix NULL deref in mlx5e_tir_builder_alloc()
Date: Wed, 25 Sep 2024 13:20:08 -0700
Message-ID: <20240925202013.45374-4-saeed@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240925202013.45374-1-saeed@kernel.org>
References: <20240925202013.45374-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elena Salomatkina <esalomatkina@ispras.ru>

In mlx5e_tir_builder_alloc() kvzalloc() may return NULL
which is dereferenced on the next line in a reference
to the modify field.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a6696735d694 ("net/mlx5e: Convert TIR to a dedicated object")
Signed-off-by: Elena Salomatkina <esalomatkina@ispras.ru>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
index d4239e3b3c88..11f724ad90db 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
@@ -23,6 +23,9 @@ struct mlx5e_tir_builder *mlx5e_tir_builder_alloc(bool modify)
 	struct mlx5e_tir_builder *builder;
 
 	builder = kvzalloc(sizeof(*builder), GFP_KERNEL);
+	if (!builder)
+		return NULL;
+
 	builder->modify = modify;
 
 	return builder;
-- 
2.46.1


