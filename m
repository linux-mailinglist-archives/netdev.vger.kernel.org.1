Return-Path: <netdev+bounces-221944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E071B5260A
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DA3A006DE
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11041267B89;
	Thu, 11 Sep 2025 01:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJHeWtpi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7769422688C
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 01:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555289; cv=none; b=go4hEI2uGRgNuAPmDkAFOqEDSvCVNnNAnrFcaQTG9eH29Jkz6P3z9nppJ3JcxyZmXvCzs6UzDMiwFYLuRjJG2kAVJm+t3dWvYK3GNJ5EhIs3VUVTMPF5p99PL+t/ctB3oOneqGg4BfaD15r/kUX+Qb/67E7v5CIo6sAQVPY6w68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555289; c=relaxed/simple;
	bh=z7CCUcXNRGOSwRx55UilEXeZ7ji/KjYa3aBI66esJBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbgDAQByul/MNZnWApBsRLyakZKOv/RM7+v0PPXDIvhwTHcpLN6+RlazkypdGyReDX/HZJ8gzF/bUp8oG8jQozOfNd9SKEyBOqNbL6ftwSyjfbx3OfArlLXw1wRC8b9Gb0V11QFKgwlfK49Klxu+CcdZ+7DeRgE7Pj6EmNqqPfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJHeWtpi; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-60f4678ce9eso106168d50.2
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 18:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757555286; x=1758160086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1dbg2IUW/gjxWay8VnxqBQUaNJkg2EY3rMaMW38x1g=;
        b=OJHeWtpiqsYk2i/WhMWPtfGzNpmXqlcu6E2b9MX9pJ/TTUJ+hWryXvkTwWCEUfs0Tf
         w+KH7YrJK6JvPxKaCTmsdVL26fzFnp5eWGTt1mXsUXJKXX71jREMX/ZYROBUFOY1anZL
         Se5okJxKtFonwe8TzitQxAIdYo1zD2fPb0KJAK4NuwJsvav7sDCcXJE4088BE4LNx6jo
         iuUVBQIo2G+nRL3lHdtxJNrTK0xDBQIrFN5xl/O4eAy+92F4vdQ98nkPUuBwdnpipwhu
         C8buPmXad6cVMLJ7P7fM0q6th8H6NOUyTyAqgywuBNgm+glaBzKxBvd5xhAz7uf5jwi1
         4VbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757555286; x=1758160086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1dbg2IUW/gjxWay8VnxqBQUaNJkg2EY3rMaMW38x1g=;
        b=MsaeDF2U23YTDBA43YmpLevOJcM5MqGbK5xBC9TjhTccIn8HNDC9X3ZtLrMVeT/IFy
         Hfg6tSPAscAXBrwqpNT0GwBj1sJvJgp9lUstCxb8LGsyY8TZqxoRmJ7tVIHgvD46hjrS
         gXldD0dUCacG6BXzVEAP2njf4KIY2o1NX0VVQM3ZibzBpYEBEs5MyE8PvHBnFnjo+58p
         gUxHMmH8K7krRLkPROmOmzkjnWowjP212BeeFpTZziF6jLtvu+zjVcIgfnEFRZqr9BXw
         YRY0NxESoEV3HCS9pWs85RO8vwLOYz3NNgU9ak1X+V0W4iS9nvf0OP02bWIOeBYDpUKQ
         Ywfw==
X-Forwarded-Encrypted: i=1; AJvYcCXk7gkJqAJpzyTrVeOTR1yBiFZocZdlY4hMPoyAuV/KlrxtFrJ39FukQJzzDLix0RzEWZacYaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKj0xJ7lraedzjrRTDeOMW/90QrZzGBboLsfdpwc7e39TeXjgV
	ucos2otkdMSrPl2pB+f/u9wMtUgV8HXJX9E23unur6nQBP16XaSB4V1X
X-Gm-Gg: ASbGncs32EUP1NWDQFfteC/fJLAsU2B6b9wfcuJTZZ3U64gVTkh+mpkaqvBNbrRQ1HC
	Ez3dE01nlU3duIdkqCGHAdSrPUYfhLCvUDrJCQiO2PAgaMvxbfiQUSfE3h1fsbsqVibabIYJQjQ
	pnIiWJAV1EFsauWUR077Uw0t7oQOXocu0H/ofIgXIOOKxCXEdBSggcWwkR14KrOPTf0bcF44J7E
	XsoN/esw/YkOH18cTIao6BQkH1OZazJ59F8TQo/ECJ66nLuM6a474YLjMLYKctvc+JBPbpoWDrj
	rdwgUqacS/98D3J/njYO3yQTIU3MkAJ32Kt42T61TV6tR39P9mxyzeTiK5pft+ZPoLqSh/hiPlR
	2eMmd30Yed/v2tX+/KCDjB2S+p8AdAh0=
X-Google-Smtp-Source: AGHT+IGLNgZertD4VqPrSPjvbIDDOzFJUFsHsemuV5WTiuaz2FvX4r52cO5Gl0ri1GKZeCoiyZ8Qug==
X-Received: by 2002:a05:690e:d4f:b0:5f3:315d:8fed with SMTP id 956f58d0204a3-6102268511bmr11789338d50.8.1757555286283;
        Wed, 10 Sep 2025 18:48:06 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:47::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea3cefe1471sm72548276.3.2025.09.10.18.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:48:05 -0700 (PDT)
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
Subject: [PATCH net-next v11 19/19] net/mlx5e: Implement PSP key_rotate operation
Date: Wed, 10 Sep 2025 18:47:27 -0700
Message-ID: <20250911014735.118695-20-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911014735.118695-1-daniel.zahka@gmail.com>
References: <20250911014735.118695-1-daniel.zahka@gmail.com>
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

 .../mellanox/mlx5/core/en_accel/psp.c         | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index 372513edfb92..b4cb131c5f81 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -827,11 +827,34 @@ static void mlx5e_psp_assoc_del(struct psp_dev *psd, struct psp_assoc *pas)
 	atomic_dec(&psp->tx_key_cnt);
 }
 
+static int mlx5e_psp_rotate_key(struct mlx5_core_dev *mdev)
+{
+	u32 in[MLX5_ST_SZ_DW(psp_rotate_key_in)] = {};
+	u32 out[MLX5_ST_SZ_DW(psp_rotate_key_out)];
+
+	MLX5_SET(psp_rotate_key_in, in, opcode,
+		 MLX5_CMD_OP_PSP_ROTATE_KEY);
+
+	return mlx5_cmd_exec(mdev, in, sizeof(in), out, sizeof(out));
+}
+
+static int
+mlx5e_psp_key_rotate(struct psp_dev *psd, struct netlink_ext_ack *exack)
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


