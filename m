Return-Path: <netdev+bounces-129098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B51497D6F5
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 16:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C2F1F24F54
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 14:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E408C17C215;
	Fri, 20 Sep 2024 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYpgZDmR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A5A17BB06
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842824; cv=none; b=Pk04YKOw1zM+CIO7asSAT0jnyCTy3pXkIC6J/gWriLGP6zNSGBfu3w7tqI3jNEqAAk/FHlrMOs9JrjOc2jcD/1rvj1TsiTpMbL9E0iAagDOCTS0Pd5jH1koIbk5Ts0TPKAwPXR1XNQ8dqkb+2044b8QOzP1NHiznkWreZHAcLr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842824; c=relaxed/simple;
	bh=tUfgUOq49WrEDpN5pdgY6D/0Qk7FtO9dpv32vCJn3IU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hLdHhVdR4n1ZcYuUQ0p+SoKs/CQ/sTEZcwLmn7Finbi28PY2f2ujg0h8IgvvNzrFqE55zRAmpe02TpIHaB3fzBTf/tqf7nxXgwGT17I6YTdVAozNzHGYE9NVSqWOLx6SbNY6lJGGDpKToU18sXJ4y8HQ0zj7y38uXOVccKrLgnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OYpgZDmR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726842822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nh73bzW1xNMFfeehNCkHV0pz1FHPuovA0JZeAor5wJM=;
	b=OYpgZDmRwiXVEnZW//1CjqZgdskRbpR7jPmmt/TnE9CWvSm6MAmdqJgtN+OlFQHyKLWAcZ
	t6knyZEO2z7DW8Dpexz3m62wDCkFVRc6YAvxWmuVA1kmieqtcYY0C1uxfb+NCBLIxpT+3e
	2mj8Et2VEAOeJLWBHK3Hzpw/OqAO0XA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-EwyHvo2mOleUHrUDu8qtmQ-1; Fri, 20 Sep 2024 10:33:40 -0400
X-MC-Unique: EwyHvo2mOleUHrUDu8qtmQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42caca7215dso13770905e9.2
        for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 07:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726842818; x=1727447618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nh73bzW1xNMFfeehNCkHV0pz1FHPuovA0JZeAor5wJM=;
        b=LmJaXNbURcpF5QFwZGmdZIUG40rAb+h5wgMkI26m4XkCPgxgPWwnusuBrZMVg2GiE1
         glEzLW0x37Qq/Lw0g/lQ1ARSoI1w0ezPfzn3bzrdgslo54o0hsszuFoDt5wEDfogzlFt
         OxhgXxN7zacKs6gRTsKbvDlwKFbuB/CLl+qhUjJMA37FfVmWdFeH8goEIjM6sVYhtni2
         wcRVxY4Ixk+bN2WHlnCAl73S6v8Iqy232O6mv6W7CqMeX0C3qtGg5pXxLg7WOUvKxMd0
         Nk2l3Xto6WvGL7LYhEiopL6KXjqflg0AvgQfDHfBbVPfl8pr38UFkEzPvcjgRqHsh1e3
         HBig==
X-Gm-Message-State: AOJu0YyuyGb8IYovR2BIvv9Ndwn94bukt89MAI+nklYejjpcLZUvZg7W
	um2LyodTqbxY/ar/vMODZu6H0Xw4OFQ25bYv0vpF7st74fAjzmv2lsr7nUuDkkVXdYhorL2fIJi
	VsfDspNQR9eLKRukVzaGKmyU01Ajf41OEmsN6W606mxyTT9S6O3ax+X2TVBlQaEGCSPWScM5GC4
	gBlK1UoeRfpa9ofNYfDZt8kJPERqTFSVezI8k=
X-Received: by 2002:a05:600c:1913:b0:42b:ac80:52ea with SMTP id 5b1f17b1804b1-42e7c15b463mr17788095e9.6.1726842817909;
        Fri, 20 Sep 2024 07:33:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd1vVMqqhTQymkaT07xRTWXVi5ZjKJWcWsXMiOmQS35B7J37IDcfa/8i4iM26zXTYmInNzAQ==
X-Received: by 2002:a05:600c:1913:b0:42b:ac80:52ea with SMTP id 5b1f17b1804b1-42e7c15b463mr17787815e9.6.1726842817465;
        Fri, 20 Sep 2024 07:33:37 -0700 (PDT)
Received: from rh.fritz.box (p200300e16705d800cb8281343aec4007.dip0.t-ipconnect.de. [2003:e1:6705:d800:cb82:8134:3aec:4007])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e85ccsm17749784f8f.42.2024.09.20.07.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 07:33:37 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] net/mlx5: unique names for per device caches
Date: Fri, 20 Sep 2024 16:33:35 +0200
Message-ID: <20240920143335.25237-1-sebott@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the pci device name to the per device kmem_cache names
to ensure their uniqueness. This fixes warnings like this:
"kmem_cache of name 'mlx5_fs_fgs' already exists".

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 8505d5e241e1..5d54386a5669 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3689,6 +3689,7 @@ void mlx5_fs_core_free(struct mlx5_core_dev *dev)
 int mlx5_fs_core_alloc(struct mlx5_core_dev *dev)
 {
 	struct mlx5_flow_steering *steering;
+	char name[80];
 	int err = 0;
 
 	err = mlx5_init_fc_stats(dev);
@@ -3713,10 +3714,12 @@ int mlx5_fs_core_alloc(struct mlx5_core_dev *dev)
 	else
 		steering->mode = MLX5_FLOW_STEERING_MODE_DMFS;
 
-	steering->fgs_cache = kmem_cache_create("mlx5_fs_fgs",
+	snprintf(name, sizeof(name), "%s-mlx5_fs_fgs", pci_name(dev->pdev));
+	steering->fgs_cache = kmem_cache_create(name,
 						sizeof(struct mlx5_flow_group), 0,
 						0, NULL);
-	steering->ftes_cache = kmem_cache_create("mlx5_fs_ftes", sizeof(struct fs_fte), 0,
+	snprintf(name, sizeof(name), "%s-mlx5_fs_ftes", pci_name(dev->pdev));
+	steering->ftes_cache = kmem_cache_create(name, sizeof(struct fs_fte), 0,
 						 0, NULL);
 	if (!steering->ftes_cache || !steering->fgs_cache) {
 		err = -ENOMEM;
-- 
2.42.0


