Return-Path: <netdev+bounces-129119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7202297D980
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 20:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDBDCB211FF
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 18:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589C617E918;
	Fri, 20 Sep 2024 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyGr+YIu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5770F22331
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726855902; cv=none; b=o/Di/TtB+qOjVQ24kvMkIKZNuWnkejHO+ghkDUqTu41kR5mmNIDZbpV3AwvJYvxLatw5qaY9tZdLQls4J7AX9Gj0ZkyAseGqvr9pGsjAssqLcLE13eTqR0hDsQV4Aasuf64xsHiOHaSKMT/uinzcbaYEFosgCwLyYWn2CG352eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726855902; c=relaxed/simple;
	bh=QBJtY3q03Hr/PpRhpzA994iX75ZkzJVz9Fy5vr8eskc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMpBfhVjknRsCEK6MtwjSQUYzJricITlnFN4bQVK6OAJlJnzqhgJ2yTa3R6Dh0lzm9d10YNsna3arHUWMo0lOlEn8dTKV0IX8rrNo7OIa2IX8Rqkuma8JezzmZ1Km6JN5s8mv2BPHgI0PuazbmwDt8OUIxHs5GYngRRXY7X13lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IyGr+YIu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726855899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j9YI0Mx5SgwWvTuwt/Zk6J43Azxd9r7yYf/eWhY2wBY=;
	b=IyGr+YIuXnO1jtWk9qQz66rbcMlnyzhVvB2JvbxoDXEDPd9nPpF7eQIfLO61jA1paDMwV+
	sKByx3t4cSB2Mw6GhvR2QWi3XSBPT5hdgjgQV6v7fvxR5ihpMOohnAUHquWf9Nkw59qW7F
	Tx8SFD/7nA7cg9I5dou0/r9Lk5kYUUY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-9T-wUBGhM0KmKEkV66Jopg-1; Fri, 20 Sep 2024 14:11:38 -0400
X-MC-Unique: 9T-wUBGhM0KmKEkV66Jopg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374c32158d0so1340278f8f.1
        for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 11:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726855897; x=1727460697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9YI0Mx5SgwWvTuwt/Zk6J43Azxd9r7yYf/eWhY2wBY=;
        b=t6wnfQdqQGKKwV0wrYyX877cFR17iG2YIAWxzquBZ0LjFfXp+eyZkQJ3P1g8TtTx/v
         bXBRqLBglwDpnr/zUmulAxR0NTmC9M7WYdvNOWzqrviUN+IS/Dztoy3uMJy8pflSb0fC
         zkTlBaIN20iev5xYu99Z0Dmgbq5hF3zeoyv7fPzcqEOlUI5DpCMJrZ0y5XJbebFpepxW
         w4aYr6CPuUChCH3fSCWo3Q0eY1kb2r7XTzA+Aqes7B1qVhBOZ9jB9onHTtwpn1TDQQfR
         PLiyxtTCyZZrcQUQpZzYg6TWUMaaaDa6Kn+uYOYVrK3ZkprhBJZrnkvR/4/fvjJ8U98v
         LNFw==
X-Gm-Message-State: AOJu0YzMqOw7lpA/r3arF/tmOWjmXQqa18OcdD7V4RKd78n8pUEbcXHv
	2duxSMlCLhw/Czh+CxdXKxaoU4UTP51iex3MHHcIShEBAxYSqjA0BmUx65EsJQIa8Js6Zrzi5X6
	bSomUIjuZAjSp6EhPmy4L7B8AN/XKlP6qCUtBVX8pMV8dQa7tArikD3Tv6g+MbgKV6U7dBZzoPb
	i4cq9TuERzjCbtYu/2ijJJbpuzxOtKeyveA8U=
X-Received: by 2002:a5d:58e4:0:b0:368:64e:a7dd with SMTP id ffacd0b85a97d-37a42386bc8mr2199129f8f.53.1726855896670;
        Fri, 20 Sep 2024 11:11:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBcxtJ3sS5JJFgcJgBZHUw8G5EqMXIrri2f+A56fBjGFG9X4lsHzRKtM9Z31wcMlAPyWoT3w==
X-Received: by 2002:a5d:58e4:0:b0:368:64e:a7dd with SMTP id ffacd0b85a97d-37a42386bc8mr2199107f8f.53.1726855896231;
        Fri, 20 Sep 2024 11:11:36 -0700 (PDT)
Received: from rh.fritz.box (p200300e16705d800cb8281343aec4007.dip0.t-ipconnect.de. [2003:e1:6705:d800:cb82:8134:3aec:4007])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e7afbfa1asm29450025e9.21.2024.09.20.11.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 11:11:35 -0700 (PDT)
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
	Parav Pandit <parav@nvidia.com>
Subject: [PATCH v2] net/mlx5: unique names for per device caches
Date: Fri, 20 Sep 2024 20:11:29 +0200
Message-ID: <20240920181129.37156-1-sebott@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <IA0PR12MB8713EC167DC79275451864BADC6C2@IA0PR12MB8713.namprd12.prod.outlook.com>
References: <IA0PR12MB8713EC167DC79275451864BADC6C2@IA0PR12MB8713.namprd12.prod.outlook.com>
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


