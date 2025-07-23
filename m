Return-Path: <netdev+bounces-209514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B122B0FBA7
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD652960228
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36C123D29F;
	Wed, 23 Jul 2025 20:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaoN1HTc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1400823F294
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 20:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302920; cv=none; b=lhAInNxlokO978lTxJmvduG3m01dji+wrDz8oFR7vX9QbTyLkkoQUEyHZML+jyeV96LdLBtqcMhgQrlfMkXHu65mxEQUCyr/5Bd8iHEEKGdIOv9XpR3feSXZ5vPqvGZVWZP0dmaUARW6CTTOKH2zPWkok4aoxcTPQ5cEO2wxk/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302920; c=relaxed/simple;
	bh=spoGdToWQ7Qrm4bToQXLFz/9ptP2rN3jOZ+nPouxc+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MxI7kw7wg9Hf88BosTwmuQx6+SzjaTjJWfZpn1yZ1UUgZrlIMZBbhOAwaKK8sFK3mHEJUYaUInVMQL7dMjCUQSNC37HjyHGMm6ZVASpCtAtjNtcI3XufP6i8DuKOfiZajqARS3TQlkFOdBQpMzLraK/ax1zzCVN7lrtBth/Iz2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaoN1HTc; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-70f862dbeaeso3426117b3.1
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 13:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753302918; x=1753907718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkOu+beI+6o/oWvo1KmSXmhEqOhds8ciBXnxJyc2DQ8=;
        b=KaoN1HTc4nGqIqhASwHQEixCNuJ66biNuWokoRQ7R3nv4m2mauapiRQTSvGoAE3ACn
         zChAsaKZXGOnOt0lxlhRvdzRMbuFy03XfjgcMsH83LvXrwfYlqth4Z8wLJ8thcCQpoiv
         S/2/o+ey1ffH3f32OgbLB2/ZlGJzqxFuwDY71Lhv7fHgVhlYOGF8xst/qFABitnEQd1p
         SBJXxf8kShkyXrU4gNysZyzh45tXn9kWiC0K/801emvmBm1Qkef44iQbT/nHKSah/4Fw
         1iGfq7dqfQTtA0SXRq7M2GhCYY0ylUEaB1wfjhQj9OX/XnkwIH5/cF+4twHdwUkuadgG
         ZZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302918; x=1753907718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkOu+beI+6o/oWvo1KmSXmhEqOhds8ciBXnxJyc2DQ8=;
        b=k5guCp+aAdNNyt5d7MTtHWTeZeR1ZP0PZdtyo5ZglSAf1uft4NNR3vlGg/D7NxF6Ns
         Avl1YO5epLQ1JSxijhzMUGy7s0fHSyBV/BCo9HcaecwB5h/wYpY9yX9jO6ntOZ5NDkzQ
         6yfVQ7lSxfw/R7iKn6WKNZjbk+Az4CmZ7uTz7uJSCilSJxlUCIlwOwo9antxyT/Jgh1f
         RcKr4FCof0+Z+OtCaWQsTC9sBc0dVhAGvhmL+O0q0OoYyvTPakljvuAqhISLQEds1A7L
         ePVdpZZNFcVHf0G3/wxHm0Bzgm9481FTvERpaqNbDTO3jvEhZpOt5R+zehyxYiItxk6d
         5SCA==
X-Forwarded-Encrypted: i=1; AJvYcCURlhCkkZwTHgLIj7DuqkiApOvxzP4KZNocKHgcLiKM3nqZVoiHd4WLkeDicUWIQ6wS+zsMA5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIZqx2slq4mOBqU7n8x+YuMeRrev9nKbys2xE51HLIHxbdbasO
	VznTPXdMyEoUCvO8ZCX2RORJgInoICJANFz6rncKntI1wDWz+iPfY7+tTDBDxw==
X-Gm-Gg: ASbGncthCP2P+MwbHqyXLVIWqr45qh974G/bpE3N6g7+vZf6PFoRgdwD9nGrAkPAXdC
	/tR6ok7lLALM+pPBTJfOP6Ad7NtPlJUXoX1/GZYb3ldh6QDa4yguFVXeEwRhybjZBzrh6Xue3VG
	8YzjFbiQupOUv/O6th0263s5ctcEggY7mIy5fweGee6zTf/p3SeyFHGqCJboPEgY7EAzr6mtr4A
	BFOGkHNdVhQpW78LA+fCGigdjjh8e7Cb7YuBM0k+HJj1PTUkupLHlOCQDiUIdPvyczydBzIvcBs
	aLt/E+SPOtS8YdVD6hKX8vSnxTIdkzIcK0rJgcqL7MDxENwyy+qKCBxKJLAa3u+Uvt+HprQPdc5
	VRgZgKm3FNSlaC0QL5R6N
X-Google-Smtp-Source: AGHT+IF49j0xX2jqHA9ZGMx+nR+tDBDTAapckGPyomDhVcfPv5oh2OXNoSJR1/E1ZMKO5I5txFmskg==
X-Received: by 2002:a05:690c:9c0c:b0:70e:15e7:59e2 with SMTP id 00721157ae682-719b42b608cmr65394927b3.24.1753302917897;
        Wed, 23 Jul 2025 13:35:17 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:49::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7195310a8c9sm31841447b3.8.2025.07.23.13.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:35:17 -0700 (PDT)
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
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v5 19/19] net/mlx5e: Implement PSP key_rotate operation
Date: Wed, 23 Jul 2025 13:34:30 -0700
Message-ID: <20250723203454.519540-20-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250723203454.519540-1-daniel.zahka@gmail.com>
References: <20250723203454.519540-1-daniel.zahka@gmail.com>
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
2.47.1


