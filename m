Return-Path: <netdev+bounces-134659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA43C99AB6F
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87474284AD6
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC171D1F5D;
	Fri, 11 Oct 2024 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="foKSwG9Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB5E1D1E77
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672374; cv=none; b=eUjTIGNYp/Dr0DA0etnl1R6AIK76UTHGqhUp3Lo3CGlISnXuiJSab1WbqrJ+dc+np9INqZzthuVyLU0Qg5yhbcry70c/B40AErQR5aZ+Gyz0WdD2wDgweQa1T7OKIhoXgq4fO74761Eupi1S6DSBOro8UQCgylDmwyOkN7WiuX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672374; c=relaxed/simple;
	bh=rdUwUl0O8uACIgxUtWrf+uGT//W8R20vX+DxgJVlwC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J45dyLwfSFtk1iM/NpPdOwJd5kbsiCFUQXAbawJPZjKKQrO6+Mw5znt8B3xiliBJx9wkryXTHRuRQpJPpmjDqxlwMzqWKwCNkjlbEDSyaVJrjB3B2LJmoYId7UZvwSWyIEtZzoSK8SJLuuCbA0zSb+eVQ/MbkP6nOzE/Lvog+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=foKSwG9Z; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2eba31d3aso952536a91.2
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 11:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728672372; x=1729277172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnL/nRVpUbVr0QJP8g9nrYJJ88Tc0QHRfi4pl34q3/U=;
        b=foKSwG9Z5R+oVSEEsAsDF6CMRqzlGN11KZofIQGq9q3IyINWyrlipI4wHK6oIMhgF/
         ggef884BilgLINlz0fAlFJn+wCZ2D0SEZO8sjJy4tYyIRluddptQn04h0v33ephS2m0r
         H2d6e47LHM7fi1TWDXRVxkD+TtEKhtHfUo23E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672372; x=1729277172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnL/nRVpUbVr0QJP8g9nrYJJ88Tc0QHRfi4pl34q3/U=;
        b=rRk5KfutLKvRlmmDyEvHGUGNUqGHetyrGAzg8fJHDir1DcXnnCVb4OL/L4r2hF+1fe
         lUzzKIu5rbhVrTn7m0kh1oXSGJc/RrmGbifmr/et39XQjSe+KNonwtN+bp0MVyLXHgYb
         LkYqPtDAEJ4MPmUZicrvsvwG5saLWg7f1rQ7/kKDdK+xvge+uOzG2XpQ1EuXmaAfcHCM
         DgzFzBEwpSGxEM1Cy7jkXnPGuOansDw2jVHw9SqH5mAYmNDXO19fKvRoK5HzWgE/9sE4
         eUpLhKEitvYmJOOIrWu8yZq2G6zqaUMDjcNi2VgQ+sKVE+nrkB8eQkSB9KmAPUogU2Fn
         q0WQ==
X-Gm-Message-State: AOJu0Yz2F1Gs1Ol6m3dPCwNVcDa3zBem3kDWAbC8ReISMtraTmFASY29
	KA0Fx0BvMOeeHlQND87UbWLhedKHPRE6lkfbRPs6uTzr5IXZCzzYgyXUI1zgm9cpwZsmmtVOSXy
	al6sL1n7tHxVx1THV0mGrzuOT/r1oXLQeemW5jqkEUVhszEiRPFvDsRMrMTHu2LkziTvUvRiT8s
	PqPl9A5aEf6zAStRZryOuurLL7csr9v53O93k=
X-Google-Smtp-Source: AGHT+IEFsFDVLhRfbEt3rKS6YFF2OdRWJzbou3HLQ3bnnhFginEdMVv+nVTJNPgJ7nFKxYZB38UDGw==
X-Received: by 2002:a17:90a:ee8f:b0:2e2:cf5c:8ee3 with SMTP id 98e67ed59e1d1-2e2f0a48877mr5057995a91.10.1728672372104;
        Fri, 11 Oct 2024 11:46:12 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e30d848e1csm687625a91.42.2024.10.11.11.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:46:10 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v6 8/9] mlx5: Add support for persistent NAPI config
Date: Fri, 11 Oct 2024 18:45:03 +0000
Message-Id: <20241011184527.16393-9-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241011184527.16393-1-jdamato@fastly.com>
References: <20241011184527.16393-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_napi_add_config to assign persistent per-NAPI config when
initializing NAPIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a5659c0c4236..09ab7ac07c29 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2697,7 +2697,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	c->aff_mask = irq_get_effective_affinity_mask(irq);
 	c->lag_port = mlx5e_enumerate_lag_port(mdev, ix);
 
-	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
+	netif_napi_add_config(netdev, &c->napi, mlx5e_napi_poll, ix);
 	netif_napi_set_irq(&c->napi, irq);
 
 	err = mlx5e_open_queues(c, params, cparam);
-- 
2.25.1


