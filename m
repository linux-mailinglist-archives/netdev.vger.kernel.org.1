Return-Path: <netdev+bounces-133395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA5A995C93
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 02:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C74F3B23C3C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6362F143748;
	Wed,  9 Oct 2024 00:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="NvJwEECo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E013B58D
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 00:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728435377; cv=none; b=fTq7dRNOWjeXfY4MLh1TTTE3AtgiwCT6zTQecEyf5uomlm686M0CnQFkRN6l73TDIrFbZqVROSKzKKgAVDICWteBHanYvKV7m09kRJUK4cXCzSaWJqQkm6ydlOmMHxkmp8o9TfBdTL1n7bUiJSK8djR6VTGQ5GGWvme/urhKaRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728435377; c=relaxed/simple;
	bh=9AG0+lo9vEUg3YGDMTJw7BHymobbZ1x4BvfJUKFyf90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n3R32Wd6p4JMS1pYGs6EPaUJuml4sEqbEXtdJYhfp2LTHKr+3X7LsAUI8Go9OStcYJ2Rp9fD1F1vOMw1LGIb1LCgBxccMndYb2tSbxo/wVEts/aNsIICqkpPpa2dqsfUFTYXRhrQX80y/IjojCbxkP28NZgdne5oCOqs7jj6cCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=NvJwEECo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20bc2970df5so47392915ad.3
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 17:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728435375; x=1729040175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiZhR6ZDOV6PKrXmW0MGtxp50pihY0OuQCjK7Nfyoqk=;
        b=NvJwEECoN/hEORPvMpysflMoByQNiHzow3FSI/3KXwzPDhCgje32G+mjfRDUNAQ7ql
         TiHXCcGJST6MMbSlSvx0GPALw91WwiXfDJX2m1S91d1Av4v78PY/6GIdSMSuEfLzkHZF
         ClfWvw0bRuVfWuoJUI+tvbfkSR0hKjKZNLa2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728435375; x=1729040175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AiZhR6ZDOV6PKrXmW0MGtxp50pihY0OuQCjK7Nfyoqk=;
        b=hxWAICnnNcuAUFP8I9T5Q3wPcPtQdlUgGvjC3TiwBWQuIosV+OguRMbKSkTRdNz3yW
         13BFX1Uc3LxA6ztQJv6AocZAkrTgZmGBFRoQPdH19NkZxQNKoXDXmvBliex90H+F7ItW
         x8Y6ZeujpiO/mjqRIbP/7PRJ+dQGi/o+WSHVe0toA/8Vfb6M11LxhG3o/Tm9UzUyetL0
         R2LD98boEJI4JFElWZ4yAxF04Tnd4kHOr+t0pRiXcn1SIh0FjJoR8FNAXVmDn8LE26xV
         yGx+XtUFh/e2TUP8D3+pAWbcYarnQVuQVDGksYkSR8lQNU+HvFKwrK3qJJq2+XPGhbsO
         ZDRA==
X-Gm-Message-State: AOJu0YxxEGs6Xlp3SWiZFv7mBi+gdvjCDi4CMK/P+GwPv82FEU4OGcuT
	/fGqavdFuMw8wBOMPLsCUyvt+7YCHYaf/qFaW0TWtkdzcHXlhUfHbR/sW7fsxGJVMNjrpOEKYiH
	1KST+YveI53d3cZqz++pMnHjFCoAplHgqCZKpQNJ3VCuN2cIrC6hf+t54oYfnsYJfI6qqgSkBPw
	ozOWhRJmE31RR+bhGCoMPCKrlDgu4RRMWMQTE=
X-Google-Smtp-Source: AGHT+IH6h1S0EIM9d4SunI15VDvdI8I+pNVG0304L1KJl7mZQ1dQzI5hTEQrUahwl6H9gOdnwxmgrA==
X-Received: by 2002:a17:903:228f:b0:20b:9088:6545 with SMTP id d9443c01a7336-20c6380574dmr12981235ad.46.1728435374645;
        Tue, 08 Oct 2024 17:56:14 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cec92sm60996045ad.101.2024.10.08.17.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 17:56:14 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v5 8/9] mlx5: Add support for persistent NAPI config
Date: Wed,  9 Oct 2024 00:55:02 +0000
Message-Id: <20241009005525.13651-9-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241009005525.13651-1-jdamato@fastly.com>
References: <20241009005525.13651-1-jdamato@fastly.com>
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
2.34.1


