Return-Path: <netdev+bounces-138249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C1F9ACB77
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05071286990
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4F31B6CF2;
	Wed, 23 Oct 2024 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGPuHhC+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FFD1AE850
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690913; cv=none; b=Esy9mFCILJedRO7CJAr+bv+7KOANfpPVnuTx0FrVI5BL8N1LX4HmoJzmXxt4N4PK3OLPeJMYTJ283JoZamIyIZm4mcpzvRiUDB3BJHJxddLFGO87pbHE44hyNdq04aqBHFt6CI3VhHMPtOZElCgWtj0CBX7h28NVGkWC/50NlzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690913; c=relaxed/simple;
	bh=u9FF3WzzoqNp4eLryQOSowGgpuAPFK0vwL3y9Yg8ZNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5tzO/KnofrIcRgzWSmoOLxcz0TbBiqvF6QGhMdhrqkLztByp60LK3MMNJdMYc2BrCQbSCScK6lyICLS1AGIeMqzYWmjNpug7iygEMwxEEH4XkSC47a+RkzIin54WtpAM3Nhkz7jC7774pKgTZCQgw4ISJ9PQZhPjv+MwOkqIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QGPuHhC+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729690911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAM8ZRvTda+LEs/8ya4sgurWTTiohnnijyfOuyfhNxo=;
	b=QGPuHhC+o8n1N4VS2NxdbkoX92jXhTAyWtrYDg24i706jDkvx0Dxk2249U5NY+wx/NNFRV
	PYDeyoIomc6kSV1fo7NzZfN49NGYpag4AbmLsbkQ9dQU1XwKcyLMNEThGB2ncm3KKXTuq4
	2BpGZ/89cNqs9jw3CDG9+ataP9EMl8I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-u5I4w3B7PuaaCu4uG0nf8A-1; Wed, 23 Oct 2024 09:41:50 -0400
X-MC-Unique: u5I4w3B7PuaaCu4uG0nf8A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d52ccc50eso3435462f8f.3
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 06:41:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729690908; x=1730295708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAM8ZRvTda+LEs/8ya4sgurWTTiohnnijyfOuyfhNxo=;
        b=SPjmx7zDoAEFZOSPY5xZ6g4nkWQVvnf2JZ4zGn1l6B/0OBu9ogdUvOoepSWPeD7+bs
         F2BmQBLEj5GmfhbZSOOv4gaGojUHj4RxC3AX7pe/GB4oGKavrXeumlpbVgpdX2cKbhWK
         jBFOxHcRKeousSln3VDoE14svdg2YfMRmFtR9c1VopC47IJi4aS8EjUOmdI8/DAXdzdk
         GYt7jxSOBkOg1rMEBxLlEYposj+3A3eRjtqOS9wdR/O3FkJ0jze2LAgs6KICALaQBhaT
         fE21eX+jgWpGs4tlDmu3dmPDqTa7mcG3XbJRc+lZYh9EHadS9j1FUXS9XUCHXh6pCbSC
         HPRg==
X-Gm-Message-State: AOJu0Yy/jyOS3G0hH/lbzgqrTlhe2xA8B6Hq8ZHGCT8pIDxWqKohO5sC
	1wAiUy8XhOGQSnflM+c/ceNdJwXp12zm8vofKuMfn+jvxdL/pTQC+QV724NEiACxFiH4BrLR4xa
	usHK8GDXl78RhNazXp6lZ0Q6t1ZXRJzlEJKyxjwMNJ3KarPEr1XXQeEtUz1f7toNWV/qmk0gfXz
	g327OmUkmMoORauJNOH11kvH3IM7sIrLnLic9J0g==
X-Received: by 2002:a5d:44c2:0:b0:374:cd3e:7d98 with SMTP id ffacd0b85a97d-37efcf106ddmr2013612f8f.19.1729690908087;
        Wed, 23 Oct 2024 06:41:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXPXXPAYcibfIzDBRMTHs9hPWdPNDz3Eha+UK8URGkuRSuFekIz7fNUsSwd5AIqn2zOU7BLQ==
X-Received: by 2002:a5d:44c2:0:b0:374:cd3e:7d98 with SMTP id ffacd0b85a97d-37efcf106ddmr2013576f8f.19.1729690907619;
        Wed, 23 Oct 2024 06:41:47 -0700 (PDT)
Received: from rh.fritz.box (p200300f6af01c000f92aec4042337510.dip0.t-ipconnect.de. [2003:f6:af01:c000:f92a:ec40:4233:7510])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a5882dsm8898858f8f.50.2024.10.23.06.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 06:41:47 -0700 (PDT)
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
	Paolo Abeni <pabeni@redhat.com>,
	Parav Pandit <parav@nvidia.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH v2 RESEND] net/mlx5: unique names for per device caches
Date: Wed, 23 Oct 2024 15:41:46 +0200
Message-ID: <20241023134146.28448-1-sebott@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20240920181129.37156-1-sebott@redhat.com>
References: <20240920181129.37156-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the device name to the per device kmem_cache names to
ensure their uniqueness. This fixes warnings like this:
"kmem_cache of name 'mlx5_fs_fgs' already exists".

Reviwed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 8505d5e241e1..c2db0a1c132b 100644
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
+	snprintf(name, sizeof(name), "%s-mlx5_fs_fgs", dev_name(dev->device));
+	steering->fgs_cache = kmem_cache_create(name,
 						sizeof(struct mlx5_flow_group), 0,
 						0, NULL);
-	steering->ftes_cache = kmem_cache_create("mlx5_fs_ftes", sizeof(struct fs_fte), 0,
+	snprintf(name, sizeof(name), "%s-mlx5_fs_ftes", dev_name(dev->device));
+	steering->ftes_cache = kmem_cache_create(name, sizeof(struct fs_fte), 0,
 						 0, NULL);
 	if (!steering->ftes_cache || !steering->fgs_cache) {
 		err = -ENOMEM;
-- 
2.42.0


