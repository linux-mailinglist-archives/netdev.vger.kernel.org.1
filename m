Return-Path: <netdev+bounces-216631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3E1B34B62
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3FC241471
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B2430BF70;
	Mon, 25 Aug 2025 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHJ0Uw9J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEBB2874FC
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152102; cv=none; b=NX2OuqxcQijcp6jD5IUC6svENTMWLx5du59oEqJso+LGXO7S1ejJayVb5NhZlWOeQqk+d9MMjU/mHWyuifEq6ueHX2gY4pxx9HSMjDl/QwSrFWkIvL/CBvOu8r5xTHa8OFwK3FuNTiGJOMVwzpEc11aZM5nzRtVrhfF4+X+0COA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152102; c=relaxed/simple;
	bh=XuN+6CCt6cPxnSzJbpL8GnrHtHFh6xquhBYp8pHWAws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFV2DVFy2RAmdoPWPNc8QqYXfRWhCoGMih26k36m02InWIcrA4wk1ByDgII033RKTG4m8RiUTSlrHcYnv9M9q2VH7YOhJUYg1WHYuZgKOzOG10Ji9uvnE8destHbKLw8IwyEBakHIPXTBvzmW1FdjODuDA57bZwdAypZpsC05zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHJ0Uw9J; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d5fb5e34cso42565727b3.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 13:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756152100; x=1756756900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=939Nx6uVLvw4l3lvlfanPraTohmmdWkgrL+mk0f9MXQ=;
        b=FHJ0Uw9JfWvY44gFt/yCmMDe6uRHeHnzg4ZMAoXkyZKkodabvfVW3rc4FTLeVULdIU
         sQiFafO8G8tYetSmGV/kaHCyyeZJaD7p4HadQ8RcbKczdVZKskMjcgkU0pVqFSWox3HY
         UISkD6rfJiJOGlZg9xPebqMxMMT/b5V96o7uJ3UHpg+B5FOLwFRAtNKJeE9Ku7l3jJnJ
         ItBBIpeA7qeNQUwtmBKn8cwG5QWL5oMERm2jnkd3p73qxMxmQe3A5mhIqEV0i3ZQQqr9
         lahA6wr0MjmdbWGL75KKwobhtv4UndiqHyVABM9MPOeBUs33cEnOOcsCgDHqaMBtLi/A
         EjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756152100; x=1756756900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=939Nx6uVLvw4l3lvlfanPraTohmmdWkgrL+mk0f9MXQ=;
        b=he1WtGfR48ZQBjpF/muptADxl3lVLsCGcrcGMzvURZbAr1+BCdMfdehrxEv3z2cpg2
         EkAIA8xl8sPXIGSzMe7BgP4vI7u/cYrEZOuWvVqeIcwJiGleClgsLstol6mOZi10Fa51
         r9+iWYgAuFow+67m31KoKf1SYcBCdo77tZnt63GcAe98DjJKr81pi+pygVrW6SPvRn8L
         lD+9dS4V1BENfLvuv+luGM+efV0QMxgBYDIgzI+3LXJfwg8IfUfhz8AoF0WZ4hYdxC09
         ++HdCdWkhjOBRquK9s3byFjweVL8hXNOlSUM1LX+MEO+cRe/9ScWEDxXKMX2iY2aPMwz
         lw0w==
X-Forwarded-Encrypted: i=1; AJvYcCVmSMVxDKw4XZhMRVuab2FEpS2svRTXfTcjZsHtNNq4O096wXyHKdXMRfCJb24c8+NEG2FSBXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxId3RJRp2cMvm7pcAThL7SIKqelaCBE1+CLpBZTsFpY7kdg4vf
	y5V0SQoics3D27w5YLpED80/geaCh3PUPTKwysYs9MZ8tNUb0GN4HMqP
X-Gm-Gg: ASbGncv8/Ccf5noMN/COe8jHUoEQFxoRm0wP0A34qndRccXmJY6ve4Gt9RVWWozt8q0
	R6/sLHCluyqMn2Xl18oxQLzo3RfeiWlTifP0wgI6LC64aTLvOLVvI8Xg8fzvzbpWBQXisDcYEJS
	O+sjOGy+EUe65reSlatUg0kgAeQXeQDYEO2CdJTfrJ5TOB6utURS/ahbhtEO55Xl8OPBuJmhmpo
	JJ87wYIgGLIlmbrob2/EfQjhEAq++dcWQqQJTldVlcP+lNsyNkLY2PpNRsPPsFQWA0UEqqxBUnU
	GH04BZh0dy36OYWaAWcG83GQhzKlPQ5QzOox2xDOreGC+SrktHfzoeiTXUPNnpSrW1RqQvwIE0r
	GIbClaAi+tim10W8R4iAF
X-Google-Smtp-Source: AGHT+IGq7yuONnpIXjwBOu/AyKKn8sd09nQxdcekXdtOQRcY+OZvb7B1o7XxROueBsWqkx/Zg8Zrhg==
X-Received: by 2002:a05:690c:6d88:b0:71b:f46e:691 with SMTP id 00721157ae682-72126b7b763mr11699777b3.11.1756152099945;
        Mon, 25 Aug 2025 13:01:39 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff1881f07sm19412027b3.50.2025.08.25.13.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 13:01:39 -0700 (PDT)
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
Subject: [PATCH net-next v8 19/19] net/mlx5e: Implement PSP key_rotate operation
Date: Mon, 25 Aug 2025 13:01:07 -0700
Message-ID: <20250825200112.1750547-20-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250825200112.1750547-1-daniel.zahka@gmail.com>
References: <20250825200112.1750547-1-daniel.zahka@gmail.com>
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


