Return-Path: <netdev+bounces-215237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA3CB2DB2C
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D574E790F
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD978307487;
	Wed, 20 Aug 2025 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJPR5Hcn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B92C3054F3
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689506; cv=none; b=cqYqMoaBTYil31H+dDwKy3exwZuKxEALgQQNjK0BryzIwaQNUPk/vjLUlcGC9PKdtpcPHnQ6yJ9PtNuvnAseWBKVLEbkNlAOsq/NFi4Vsilpyx5zL2ohmx8ago+o0vmzxEjuOwLyEdAsSXJm/ge97bAeoAqqEwRMzAiYC8wSrOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689506; c=relaxed/simple;
	bh=XuN+6CCt6cPxnSzJbpL8GnrHtHFh6xquhBYp8pHWAws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7wMqV9ni3y+wFYYdOhK6+o020SkeMaamSq38sEjRQYdzLhzeEORbYQULMlMupTgd4U+dqb2hqHq6zj1UNmmzlpdoKqRnxBAIM8uPzXK7HJtJd0i++QpTlPvQlPrgy0qTVsMHZCD2LKBgiMWN5RTQuanyxvmcestRfXA+FJ6Ba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJPR5Hcn; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e93cc7c64faso3326522276.0
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 04:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755689503; x=1756294303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=939Nx6uVLvw4l3lvlfanPraTohmmdWkgrL+mk0f9MXQ=;
        b=PJPR5Hcnk6iqZ+ioG9vfS8uIYhJnhko1qcZGEShYTzUYjU3lToCeYQJuwecZeSNnyI
         F19pI2OaGbprlswTO1FW2zYiaXvVyi8D9Icp1dE5+8ZWtDfCjFMzRpH/kmlqTOYY2pQm
         a3MC3fHaeaearrbO0ndqhCiMAWydJhkGueELG4R5fG8QyWi2EUnP0itIKlEi8BHMmesA
         oY6z0C6tSJsma/mdyE8ntxObNN7WT5aIuyc6RuS/yKNch2CbsSiWseiUHzzd2rL/U2j1
         p6Jl+GBYXz2ytqAw5ZHQjqln44JfIgltpequ7ERlZAy3I5O1Q02itMrB/7/nJCL0FX2z
         550Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755689503; x=1756294303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=939Nx6uVLvw4l3lvlfanPraTohmmdWkgrL+mk0f9MXQ=;
        b=tb3LdAOSWqPlg1+CGrT7h0Cxp+fBL70AdgBYuVrMcM3QXAfIbRgYsryaqcnVKyzAe5
         5I9qeKwzvBO5vzKReGRtljyG4JBTSL9ey+QMXVn6znSsX3p3VOIWiLaGhtMikc+qwL8E
         /xjsJu0Rze2XCEk9j90wpos9AwaP46uKweYspLEX1dkLvKVpdQO7P/0WQt+Eeu369uFX
         UQg9w4+qjxsyQAqagsK7XhLZWgjASDA6suRxuu04/poqSL23/zCH9KVkB5O/v4g7bgZ0
         V4UrkuMI9RtSZxNxSKPE/O47JeXWzjdfDrU/l+lOLeg2V7htjwYkMT50Vj0daRyKzJIs
         5mDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXigY7W7MqTJqvNUOwjS2bPJSLH2SdzmWeXT6yeFR2ltt03PRQX5kDea5PoVMhZDaoUYKlLJ10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFRfa30Vi+kJckWL07U/ttgxkzwekdtax9qKCn+0v/6YNiaa1/
	/CiMTyYG7FcIfp3g8iaGavK8rxzMUFqJEu/tQw93fYntMDLpxTfEF8Z/
X-Gm-Gg: ASbGncsR2kwW9+fw65Zb0SgYu8bbS3GLFzMHI57wJvl/GV5bd68bKyPIqSPjwR3AkE5
	U/mcm5kYmM5zsSHDP6vm3fdzR+50SbszlIQxE4s8usArBRyL7JbhaAD7t2OKHKgjZUGLFG1vx8f
	MOSjyty3FqCHRi8+740oEQavRd7/CW3sSPdX+dvKgzJ0tGFyU9KhKjMWuFqpi/XmJ/5S62Gdn1C
	6fH0Uu4M5w6N7kqi7mH7qn+o4lAgU7UIGmAVcj1P3gc1YaTJ15AW9lYIWWSRdgqiGikNm9py33D
	38tWVCbAfuD5Xj+FBpxjmfGM2BHTSNIyVCFEImrqjrA6NuKliTs2yN9z9UyUbVxonrqQRJbUf/G
	iw393f04Kn74vUAffXta4adsOTP223q8=
X-Google-Smtp-Source: AGHT+IF9gvr6eAFtrVPm0nNYLjFu8dFf+BcLhnT6KcZvO6q39U7Qbo/KvRC1I9NAh4AlGIRAQxqCBQ==
X-Received: by 2002:a05:6902:2e10:b0:e90:44a9:61bc with SMTP id 3f1490d57ef6-e94f65de2bcmr2710127276.4.1755689503156;
        Wed, 20 Aug 2025 04:31:43 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94f14d53cbsm1050644276.26.2025.08.20.04.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:31:42 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kiran Kella <kiran.kella@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v7 19/19] net/mlx5e: Implement PSP key_rotate operation
Date: Wed, 20 Aug 2025 04:31:17 -0700
Message-ID: <20250820113120.992829-20-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250820113120.992829-1-daniel.zahka@gmail.com>
References: <20250820113120.992829-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raed Salem <raeds@nvidia.com>

Implement .key_rotate operation where when invoked will cause the HW to use
a new master key to derive PSP spi/key pairs with complience with PSP spec.

Signed-off-by: Raed Salem <raeds@nvidia.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-16-kuba@kernel.org/

 .../net/ethernet/mellanox/mlx5/core/en_accel/psp.c    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index 56f39f452bc8..406fe351cd28 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -82,11 +82,22 @@ static void mlx5e_psp_assoc_del(struct psp_dev *psd, struct psp_assoc *pas)
 	atomic_dec(&psp->tx_key_cnt);
 }
 
+static int mlx5e_psp_key_rotate(struct psp_dev *psd, struct netlink_ext_ack *exack)
+{
+	struct mlx5e_priv *priv = netdev_priv(psd->main_netdev);
+
+	/* no support for protecting against external rotations */
+	psd->generation = 0;
+
+	return mlx5e_psp_rotate_key(priv->mdev);
+}
+
 static struct psp_dev_ops mlx5_psp_ops = {
 	.set_config   = mlx5e_psp_set_config,
 	.rx_spi_alloc = mlx5e_psp_rx_spi_alloc,
 	.tx_key_add   = mlx5e_psp_assoc_add,
 	.tx_key_del   = mlx5e_psp_assoc_del,
+	.key_rotate   = mlx5e_psp_key_rotate,
 };
 
 void mlx5e_psp_unregister(struct mlx5e_priv *priv)
-- 
2.47.3


