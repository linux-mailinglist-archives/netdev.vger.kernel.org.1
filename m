Return-Path: <netdev+bounces-201181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D84AE8544
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC2A189F6FF
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AF92690DB;
	Wed, 25 Jun 2025 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoIdn96n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1901F269AFB
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859554; cv=none; b=Qcz36XXYsnTzKB1FbNdWfXv74L5Y9hOnV6Flo05Ww2wH/4LwCGyzHcQh0gKP1rgBbbyesdw1q4nVBQEASTympbRgvTnir6ptTdCWsT4Pxwx6kBZmONavBSrDAefmF7nrxRVavEcPgIS0Dwzd2M+aLSP7i4XcUEshLPRjWG8ZNpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859554; c=relaxed/simple;
	bh=PluDXuINl0h+7RQF75H+oHgjxFlsTVDd60o/nmWkCbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGVQwng22fJW2APWpOj3DJ0dcyqb5zrO7mY2I9Ob4d2zq8DZaN0/AWXb2k/n5Ec8jmmHYveQZ1V0Jt8bg4y33sDDMXFBzjuDXstJKXxwIYW9sKtKvhKShaDLbZ0VPMpKP+h0OnJ4krJHZqgNXUBqMEZu2MiTyCJzhEhN+LOiW4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoIdn96n; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e7387d4a336so1480466276.2
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 06:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750859551; x=1751464351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGSHC5YOETvA+FvOosnMbPG4L7vRJxIYLZaKg+pMbxs=;
        b=YoIdn96nrVnCSs+bAUWfQWhQTfioJKfDmQXRxF8u7sailkDX2cWPdLdkLpzJ6UsA4D
         B5vqH0OjpDWDBVRA0rTaZ3RcelG+ktyp9sarAm4FQa+CQR4Hvnl32/f25nts3iENVT8O
         Zvi0QwFxV3zhXzlaUdR5UWZmlokV/Yy9NTShNrF6peRl/iRvoW5tWAVm+fCq2upDadjw
         tWHTna3idfbMJTAvtROyiYpnBulBXka0Qm6lu36jtNXuaUSDLs2wBNbEvu9Lt2TtQdB9
         I5e3sWCgMjbARXD7JCJ2231aeNJlsoJKGaifnimB/5jEyZRIYjVtP4T79L2YHhU81kj2
         M6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750859551; x=1751464351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGSHC5YOETvA+FvOosnMbPG4L7vRJxIYLZaKg+pMbxs=;
        b=YwMKr3mfU/gmK34BGZbbdeJ4cWIBZ9Ym+HuWJgEM8fAGqLGijFWGGMli5ytxOuFrhQ
         unDiqHqrZSUXVNisICSOg5gTxS7XjQstaWMNXvVWdGkVtBdGXkPM1/ENC+Xioacpo4zU
         crK4nGFYLmuZ0Em8DTJhd6h1Tm4ZOft+M43mReIf0LYsTawRDuqdHzYMKNqloPl9yGQ+
         fcb1QkdYQXzEhcZDPJ2yqRAjVsJ/hDxXn9rvxA9t7LSokrJYYkbnWwJuamkGM7CEQpwI
         nHCm8+0bGOmK/BllZG4NZ3XdANeJfnGwlGSzeQ22dRqcam8fz/KI4RiEKViI+ariEKqa
         Nj/A==
X-Forwarded-Encrypted: i=1; AJvYcCVSYueJVqdERpupHw2dblVPN3yulxMPo96rdtDiscMvcKmme0GxeSK/Mc2cKbSj5mq3HbDwhEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaAY8/bAAplldOtA6e2/RIratA3YHmHNpVl3qHbXSdwTB9FbIC
	Pv9hgHPQYEL94P5f/Uuace7R1XVerAoz1VmYffX/A9pOBt2qR/JQR7ox
X-Gm-Gg: ASbGncsoVLZp6S2gWFaBXKorFJackMJkdtRqGuLOfFCUBKqmyhwCRRi7kuk+Vt9msEA
	amtbiA6fCz7rtIAlqCcYvCnLJZcuylYGzltqtNMPnwHrlWYDQWpVhcONzv1f6ppAj0Ysk4xNFXZ
	pYMEBWrawctRmwdbtCv/O61v4mspt1kEL2W0xtuDBDvMZPGTw+S0MUNvxR6MSr+FA6l47AUUskx
	17BzV17HDtvDaMMEUVThdgXUtv6yjnS/W0JG4Gg891TmbKgZtQ7W12QAqihdyNq2uttB8A+pOtN
	E/VGtq/L0TRQl3fZJLLFsgS4+rLih40GDNxaGPTDkZ2bHdGgRED40Cqy
X-Google-Smtp-Source: AGHT+IFtVchFi9uYNLCcZJY+IJRJucQnkip1VJSlhcJfyh+d2cNyXN7M9nhhKKwu2QebiTKS6PUW0Q==
X-Received: by 2002:a05:6902:1685:b0:e81:9fc5:2592 with SMTP id 3f1490d57ef6-e8601765b98mr3790435276.29.1750859550866;
        Wed, 25 Jun 2025 06:52:30 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ab0a8d7sm3670739276.25.2025.06.25.06.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:52:30 -0700 (PDT)
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
Subject: [PATCH v2 17/17] net/mlx5e: Implement PSP key_rotate operation
Date: Wed, 25 Jun 2025 06:52:07 -0700
Message-ID: <20250625135210.2975231-18-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250625135210.2975231-1-daniel.zahka@gmail.com>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
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
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-16-kuba@kernel.org/

 .../net/ethernet/mellanox/mlx5/core/en_accel/psp.c    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index fb2b7e4e2f06..f35e3b381c95 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -96,11 +96,22 @@ static void mlx5e_psp_assoc_del(struct psp_dev *psd, struct psp_assoc *pas)
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


