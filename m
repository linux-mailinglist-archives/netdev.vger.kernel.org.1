Return-Path: <netdev+bounces-217923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9587AB3A65F
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBECA06EE9
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D343C33A021;
	Thu, 28 Aug 2025 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e90lso6p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DA53375CD
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398620; cv=none; b=hThKxe/ed/J8sizewo5dCWzliVIyQSllZrsj+ZmGu4XQBPHBTckCqcisoCTC011PLG+RBv1k9VwJ0fFYOc50OKzohs1M4V7qZnjgy8foNDfL/DB9ve4yqEhikVv3rZ3WU3IevuSq5cJs8eduofpipkl/PgY9t5Tt+uBiRcJsT2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398620; c=relaxed/simple;
	bh=XuN+6CCt6cPxnSzJbpL8GnrHtHFh6xquhBYp8pHWAws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XkUyuu2UpVEdxFHI2S9kutZIwso4vSKFv7BvBVDSh/Js3kcWL9WhhgtBUcYOdFW7yOQJDjdj32Op9GdHda/ClnytCnfd8iQFkqRGgCt0AhtKPaDpTh793mCTF/M5lwUMjODLkmYeZJ22MbizcEoLvAU0xN3/sKpAHHdDjlTCge0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e90lso6p; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d603b674aso7521847b3.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 09:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756398618; x=1757003418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=939Nx6uVLvw4l3lvlfanPraTohmmdWkgrL+mk0f9MXQ=;
        b=e90lso6pMFBngJKbrOhpmA2WNI8jl50jh0Qmwg1TE5nnVyxru5bn7uTvBz0PTJrgVj
         /Je4LejeAQf37HazfPdQY2vuigpFAS/4IRNno3RoWMg/hspdLPerLQoZMa6MwB9LiZ1J
         LJMkBzgQtqGAXpTl7PZKD6imgqRbEIBY6b2Zyvz+Mc/X+7b7uxy60yzE/C6TEqKcYW0W
         dd058ttD9aYNlz7tQO8RH+M5B4ABDLDO088WY0yMQenulHKIegZ8Dv9qaLuuPbSjJ68h
         bvDy4pmJ+KyLF4SsKL6TRAXZETHCYqn1zOcdOas8LaFql0o0YDgT5yEtbEWRuK4qM0pR
         ONXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398618; x=1757003418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=939Nx6uVLvw4l3lvlfanPraTohmmdWkgrL+mk0f9MXQ=;
        b=oF05WpF33kCTGTBA5DovEuViAcMPq7lKXTZV+DrzPhgsVgfap5twJON75jj9NpcS6G
         UymiOLD47xvN/V3WnkuwneCrVyJsh/lzzrtydTMVvKI2hvd+Mx/jHLEKykg6IeTc5n8s
         9PdHmEVxSsAKKs3AhOFVH42iWwYuVf2voiLCP4yge2YLSh9uBKjldvN4CPs71vljeqFT
         rQ+8G/9sG3E2gKeP3Z7K8YVawI3qJVyw19oYfjaFUU6Z+4CNAs7DrgJbccHsfFvTEN2M
         dm3NyFB7WJgPksXfAQFJ19NVza3Grft19OBpK07d/gnyqvhTqeM8HbegPiIJyS59xyp7
         i3Kw==
X-Forwarded-Encrypted: i=1; AJvYcCV75/mh2+y9JJkq9E+enhCg55eCi+Z4/rAC3gqOmDZgzn8lu/xkdlIf7LICLx1zAG1pRIgPhK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YznMzlRWoeT1BMSB6zcAVqsAKgsE8Mgv3L8+WoMrtghbgyRtyUK
	/dr6/2x9Ny64HuPefydvctSYzE8xpe3OLNcXXH3KnQnkSJRC5jAQbFda
X-Gm-Gg: ASbGnctf47LcQvi+s3mBvEeYRK/HVklF2dvc0FmWAFja4iqtU0sHRoOILvOAAGZO3Aq
	wB2oVAcmxNb7z+cL7CbAs5NP4LWNlvPUVT1TgmLgcvepAVq5DZEoNBjmdvWBEpouh6LmPG85TLg
	4BILOXMoq3D7Oqtc+F2P4w6XxmZvLckkX686Je3IrfpuGHlR195M4MPRd5oiIKZ4SiozO1hkaDD
	qRMxoBxc61AsD7w5qeJi8434vw1aPoKOz4tRb0nphgWdyHMjxvbiE8CfVPdiV+jpWGWliqr3o8N
	3EPkFmbkVnzEpgSN/tnk43PUXhvUnsW2JPAHpjlsmqMpCDuKq2Dcfcpdqf5TxaFVSCT9KX5Wl65
	9+TqvTA==
X-Google-Smtp-Source: AGHT+IF6udwo7jHjUCQvH4W4JgkQsqy2TseMQ6uSiVMQae5Si8ds434nepbtLjoaq/+37gLCG12l7A==
X-Received: by 2002:a05:690c:f92:b0:721:67c7:936e with SMTP id 00721157ae682-72167c79487mr21277617b3.50.1756398617342;
        Thu, 28 Aug 2025 09:30:17 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:46::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-721ce5cd204sm411457b3.59.2025.08.28.09.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:30:16 -0700 (PDT)
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
Subject: [PATCH net-next v10 19/19] net/mlx5e: Implement PSP key_rotate operation
Date: Thu, 28 Aug 2025 09:29:45 -0700
Message-ID: <20250828162953.2707727-20-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250828162953.2707727-1-daniel.zahka@gmail.com>
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
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


