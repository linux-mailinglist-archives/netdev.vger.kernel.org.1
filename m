Return-Path: <netdev+bounces-126296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B6D9708B5
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 18:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C9B1F21B56
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2522617C98C;
	Sun,  8 Sep 2024 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="W0eg9OPM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9113A176230
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 16:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725811746; cv=none; b=ocyM9xqP9u0D4vpkCUZ/r7Dulv5YNxkFq8oBJC4Qr3Tbb4KFqBzi9GtnWcfIpwYAIEeI2GqLxPV127cVALLOzIHnhO37ASkrHhg5XDiqFjkwDnI4C4Ml0OUIQJ5lpC1aqGSXQHxkeCvyfl/xhqIdGeqFXsD5lwCIQWDb3T9m6Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725811746; c=relaxed/simple;
	bh=4HEYXckzb30ldYDuv6OJ1NZpctFxN6G/pxcTLPkqpU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BuK/kOFwMqUHED2LVFuQm/VQDA6JLIuIU6hAvFYyhfIOMfe0tAWOnfB//GN0mpNvshLevtIYi33oq2LTRTkdWk7NZSlJHIHOMpAhkxlsQ0CNCC7giduVsb+ym4NDke8AU+afR1hf+/jC7QNKkt1RfC7gJYtt9lM1ah2hGtVZh90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=W0eg9OPM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fee6435a34so30451175ad.0
        for <netdev@vger.kernel.org>; Sun, 08 Sep 2024 09:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725811743; x=1726416543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPqS0EtM6+tGmEgcYaXfQxu3vZbAasBMjVTJ7sHaKBI=;
        b=W0eg9OPMngSp6ybIFB5oq4IB6cv9G+mpQ0SAqvEzmC9MkxSjbxC5Xw3zXG67zs0jFk
         KbgUglMGRj2AQbmtWReAVdvJyCN3B5iCsNGaivaxZnNzyB528qdctatcSNonK+IYCiNP
         6GKLdo12yk/oYHkC3d6yWJZf7laXTUU4fKElM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725811743; x=1726416543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gPqS0EtM6+tGmEgcYaXfQxu3vZbAasBMjVTJ7sHaKBI=;
        b=uIQ+TZ0JOe16VkVm+PaziD8oqBJouaz53lekS/m+8D3b3FRWPpUYV5JawLw5bKcWDX
         bdkd9vMIhfLXaCSkP34h302p8Hf5LCG32cY/JIgGYGH5xKiR0mp+Z2sLW4voHc/46VN2
         6+b1TdeO+unuMxZzMzuZa6vMnmk7jTkbvODKF2V0QVwuajv+/8UMJJXFE42dT8ZPZuco
         Z4YoHcdFLhFQEQKcc0bbaoZTzv2+NFgqEq7MjESaPeoDdp3fzb0R6fifX6a6JuEiWxXN
         xtcoeEUTrla6Kt4r+aw1dzN5+ZM/FBffDs1HJVNIyn+aoqPJwcpfzTJgDmiegff0wEcl
         aiHg==
X-Gm-Message-State: AOJu0YxQg71wxCfu9+uMXwyTKFEP/th1orJJvS3OZIt5anb1yYAw2hY2
	RxHbT10nSDED3/mdipNql+5XqaJ8h9fQylPl4kr/4aKA6HVfekq3+P3b3iwBmG2dJJRV8I0FU7Y
	PymgdjEAgOjpe2nEGMaQhmp+NJhd9pjKcAJF88FE1LeVh9APJxRAp54q2VSPsoO5gC4FzGDzxVU
	tZQFWMXSl8bvKxP46JVjTMbny/eTLvYcNnYsNs2t61
X-Google-Smtp-Source: AGHT+IGK4rR7SL/3525ecrLJrxwc+z1VKN6ygfWdTXmVhAnwErckliz5jxK7Lr6ScN1xS4HxwJmdDA==
X-Received: by 2002:a17:902:f64e:b0:205:9220:aa37 with SMTP id d9443c01a7336-206f051e59emr78713005ad.22.1725811743466;
        Sun, 08 Sep 2024 09:09:03 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f3179fsm21412535ad.258.2024.09.08.09.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 09:09:03 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	kuba@kernel.org,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v2 8/9] mlx5: Add support for napi storage
Date: Sun,  8 Sep 2024 16:06:42 +0000
Message-Id: <20240908160702.56618-9-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240908160702.56618-1-jdamato@fastly.com>
References: <20240908160702.56618-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_napi_add_storage to assign per-NAPI storage when initializing
NAPIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 47e7a80d221b..2b718ee61140 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2696,7 +2696,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 	c->aff_mask = irq_get_effective_affinity_mask(irq);
 	c->lag_port = mlx5e_enumerate_lag_port(mdev, ix);
 
-	netif_napi_add(netdev, &c->napi, mlx5e_napi_poll);
+	netif_napi_add_storage(netdev, &c->napi, mlx5e_napi_poll, NAPI_POLL_WEIGHT, ix);
 	netif_napi_set_irq(&c->napi, irq);
 
 	err = mlx5e_open_queues(c, params, cparam);
-- 
2.25.1


