Return-Path: <netdev+bounces-209534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEE0B0FBB5
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF8A1CC3C60
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF031248F59;
	Wed, 23 Jul 2025 20:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkiFu6MP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE8F248861
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 20:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302945; cv=none; b=Y6t1GD88WKKYSFM8hqEZ4rbRC5rDhXB4mwAcqt8agBd7v73Xflbj59Dspk7XqRc6hmsZFRtOJke6dZkbqZpCNzvF7drQwyuQaDn5HDvIYSKYzWb+mWDRifiZyypnpDcQ2yzsZtHK/IScNU75sPvzgiBdyaAPKf5RpNb1y4sjiyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302945; c=relaxed/simple;
	bh=spoGdToWQ7Qrm4bToQXLFz/9ptP2rN3jOZ+nPouxc+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvySMjnzXZ2rAmg++FnX2yuHTjdx2bVN0BC2qP4Bru8nmQuNUghJE5wSy8UkS1xwb0/R0WeBm+57i+tayhjzWeGmPs7Xtx+SoYFO5kptvO/H4ezEvfHbDlJ96RHwRexKf2/K3OfxUREe+FSqbU5l3lBiwMYOZdMJidEo82VTy5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkiFu6MP; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e8bc571ce7aso197552276.0
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 13:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753302943; x=1753907743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkOu+beI+6o/oWvo1KmSXmhEqOhds8ciBXnxJyc2DQ8=;
        b=IkiFu6MPAkrJ0JSYtVb5xYCqqcO1cmV7WIpvM5URenB7ez+/YsIGV2pxRAMjcGLBXD
         zb4rGInA3KJ+XC6hSPozk/8UgcTDwlsWwnJ6gC2BpjWdDwIdlicEISXuK7kLw83WxO84
         nEYgnaimPVYIq/O+baWNgqbmokDOx5to5eVyb24CGeV1dHjcQO2CjfcXSsPGsAueTX0R
         DuHymhVb35SVCwOMSjm9J8SicOMizq5NTFGKPDPssxmnofFoXPKjyXJmoQkVSQmiWVNU
         pIl9M5F9fRLVg4He0hDqkcNAEixZei3xjYel/JziCX6NYnvRxCSn1JBI5w6i8aM6lwPo
         vl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302943; x=1753907743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkOu+beI+6o/oWvo1KmSXmhEqOhds8ciBXnxJyc2DQ8=;
        b=kzC2FPVHkQRtgSxqbHe80W2qgVlYwl/cbl0pzIZd9NcvvOmV7YMxcbcKZ0PiLKFUku
         qapQCirOVrY4HlAoSH+MYT4WxK/eDwy8+UiWrGKyMjHr1B+PBJgsC6hFwImuiQ7HSeQl
         fVTMhPK3DvEXCt+2togrD9vAxabHks5Jcl5gBkjdXSnuySAqfE3gmbXKsl/of409MzQ2
         c8KPydtWA4BY+chzETxHbXI3C3S29BaZKmYzCanerhAwaFx6lQDgvp5z6lOPs4paiLJI
         bqq065jOAJagzuoG8rHqXGUTIBBxDt12bzBfD6/pCkyMpgS6ua6IpHEfnCllc14or5ar
         hpXA==
X-Forwarded-Encrypted: i=1; AJvYcCWqglb41X9DQ69x3RgwkYEMOz1gP9QCb4Xb5QQi/6yRxd3UCFJwIdFB9Yk0vxAq1lyUzFOK67s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+69U7UyQoJv6wpQ5wZBARymq8CoxMnmbszA3DGkaz6h3I4Hqt
	bYcXtkegOrtFfDQzZLeWvOG3ajtRERIgu03IoVGRbGYLcYk4EB+zWvuh
X-Gm-Gg: ASbGncuKhRqQtN+YpYtTkOVuyBraCx96qmofCqBrUvbbmJotkGLmIGfC8R2b8Ne5cW7
	uReOoFxSsM1ETYCHAF9TUWNnJQ3WOaXqFmlkbTEoGbsYBJdBS5sQ6ea5c0GKSwENR3quhZ6Mnp3
	iRCAtqpzq5tbg6WrFGO4UtSeudK/3NtrO4CjkTLGq+9+7dEsLtdPAUiSADkfD+MW1ElzEi7NHYl
	kD0ESWdyNcEAeV+HnOaykEJZvIL7XCoX1hXHzeD8d+yhr5tuGiMyynrC/JTRS9RJNqaTG/PgrIw
	2zTw7S0Xvu3NlFAirjbL5Yku54CKPIam/M11vUstaoaOKtYpUi7dF1YTCu67Ao42WLRghwKL0xh
	9eo8xBmPDrzjnmYNISqY=
X-Google-Smtp-Source: AGHT+IEPm+tBWG7ic+91WxehYgT5LpmlYDSyEqBiSAcu2DWnW5GR46MwMwmjXDHzdlq756zkJVh1wA==
X-Received: by 2002:a05:6902:a90:b0:e8d:7599:15cd with SMTP id 3f1490d57ef6-e8dc58211eamr5820102276.5.1753302943269;
        Wed, 23 Jul 2025 13:35:43 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:b::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8d7cc0eb6dsm4227798276.6.2025.07.23.13.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:35:42 -0700 (PDT)
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
Subject: [PATCH net-next v5.0 19/19] net/mlx5e: Implement PSP key_rotate operation
Date: Wed, 23 Jul 2025 13:34:50 -0700
Message-ID: <20250723203454.519540-40-daniel.zahka@gmail.com>
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


