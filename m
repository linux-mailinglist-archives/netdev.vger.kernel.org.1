Return-Path: <netdev+bounces-212693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C68EB219D4
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7616A462157
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E512B2D94AE;
	Tue, 12 Aug 2025 00:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzHb3qOt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB2C2DCF5A
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754958635; cv=none; b=JXF1uy5tBGTqHErHVNLeqYmrsWcldcWZkNlK0/Qcs0NoHS4TSHW6L3ER3PIqIm9TBAJ/uvYiQgecMYpdkkO0u/CfKHjnBVU50EflfbHmo0SabzI9ZwotDY6uCugcEiExdkBuKQtI6kdAntE5WmM5jxe5udcdIt8FxMUXVGZEfnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754958635; c=relaxed/simple;
	bh=XuN+6CCt6cPxnSzJbpL8GnrHtHFh6xquhBYp8pHWAws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Di46n28aasbTvrXzaTZ7jyoEN73Hcz80KHVomAKAmzWyjF4RFbMyPilh5QL7V8h4kDGrpzSPLGD7TTxshMCaRTTUfezZ+KZGMnswENxG4gQgyxFF3tsacnplO2sG1LxWItlc4qoppNGAt3Z4HJajjMq3NHDCORTSsNpyj/w6UFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzHb3qOt; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e8da9b7386dso4862120276.1
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754958633; x=1755563433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=939Nx6uVLvw4l3lvlfanPraTohmmdWkgrL+mk0f9MXQ=;
        b=UzHb3qOtPKP/jN4+JcZINVFDbpBR+yWluXggTqNVRUO1jpMM99BGGlG3y5+6pQb9wa
         DClArATfsWtM3mPtkxTIs5O6ffQb3wJDeSrk25UW+dK7hcfFejdnywVvUAD6iwqSrJKp
         3zU4nWoFDVFhzDZ6Ff8fPxSkIXS5wtogmk1ERapiweYksdwt5rtrZ2E25H/UO+/xjjkm
         dLVTZ0XSIwilQje9g9O7XmSqlFneZXSWqNODtfo0oTn21v3IsxS9DKjkxhM6N5PlqMOW
         JEyEWezfHOOSFNFfSWsIngh2dp4HCm9Q5nYbRqOqC3H7qxlOujqqfCVHznqa64yI6EpY
         G7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754958633; x=1755563433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=939Nx6uVLvw4l3lvlfanPraTohmmdWkgrL+mk0f9MXQ=;
        b=LmnvXjIaoRSqxLI0aNfjI6LiXt4fdqx+xPZ0rA86LLuPUa6hParD2udBW+TEbqog7m
         fPaCZsw7NGehyDzo1CBGtA3S83DZWm5NUGuk47cVbMQ5tTHIJ2HhJYiJuMMtY9gS6g1c
         2Qb4ySsnrS2rdCNU/whv7DE2gJ8A313SN8twDOhD1zCvncHuWt/TaIVYuS9wrlL1Y1mp
         bbE0vXyu/FWy0k4E5Wx7KqIDVXu71f2Kl7F56X64XRBJXTeRo5sTIsWBniTj0auR6iK4
         Z9pdXBsPfHru1O6iYsoh2Tabgsp8l9HZvMkvqkDy9gKSUU+GvOJLul74WJ+Y1zuSDGgX
         Zg0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUv94P2s1ZL2R6jQXFVTaUzCxh8d6GQX3Mu/KfIHnUBNeyhWMkHamSvP+pjqZbEA+tWZY65NGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySipQghvf36LPDPsz7zrJXUW1mBeR+EEkMjh3qPC/LvIc+7UQv
	Z2oiXtQkf/ssUB5J0/G3Ok+kZJQ0g9i0wbc+5abhJ2wJlXkWVY1oFO86
X-Gm-Gg: ASbGnctbgilgqqWzjhTakhvSR804kIMgXeLmByvE2ZNRjiDLaSXVxDHOKBjN3l1vmhx
	3tZpOlyteAammSRAZT74moL9QxRCq6mNI3E5GeRk4nFLrdOfj8OCpw9bBYy12w1SQmrki+9UFug
	rfLVX34jPSL24+gqLgeqqwaaBXUFRylqLSzLI4oBUllvTzrLmtLx/2zg83kSRQ7D3cjYBHc3qix
	joLaYIllEY2jWXQJBniUKZELdtH/L0BWpG2qNsxiWkh2mu5i6Yu/g5i17gg4p89lj0Tg8t606Yp
	zw6B0gSkIWpA2rkSBSh6E4Z9QdVsGBLDpLKMPvF2Xg9tLnVhU8EKAAAsTtqH1i8Pde3lgFQgw+r
	X6DkZiv4gCML6w45oZecE
X-Google-Smtp-Source: AGHT+IHMr2fK+gN9pot6e1ZEGd6u52XMNt1eK3X2j57nnbjjrmr9JuWQdEyQ4WvOKkqmUC6ZsnP+1w==
X-Received: by 2002:a05:690c:3388:b0:719:d8dc:343f with SMTP id 00721157ae682-71c42f6f059mr18051317b3.15.1754958633276;
        Mon, 11 Aug 2025 17:30:33 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71c44458bc4sm2087087b3.14.2025.08.11.17.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 17:30:32 -0700 (PDT)
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
Subject: [PATCH net-next v6 19/19] net/mlx5e: Implement PSP key_rotate operation
Date: Mon, 11 Aug 2025 17:30:06 -0700
Message-ID: <20250812003009.2455540-20-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812003009.2455540-1-daniel.zahka@gmail.com>
References: <20250812003009.2455540-1-daniel.zahka@gmail.com>
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


