Return-Path: <netdev+bounces-207503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0309FB0788A
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 799FC7BDD11
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 14:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBAF2F548E;
	Wed, 16 Jul 2025 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAqnRfst"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680922F5466
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677193; cv=none; b=e7y0IsU0xTuj0qWW8/RMrDvhig2hJbbwuCzY2X8HksdyC4V50JDY+3wKb37mRSa1iZaWcAm4VRYmxAw+m3XVQ4oMpzwVfnivSXqVYSec7LqIgSXtDd2ovy0+GYyLMPfbDzFYqunTYBu79q/ZuZz0TomxtWsoY7XGHgShMNrMjbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677193; c=relaxed/simple;
	bh=spoGdToWQ7Qrm4bToQXLFz/9ptP2rN3jOZ+nPouxc+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+PT8SvFArS6UlUMnX7Tb8cAKxO4rJwxwNxfK7cOjv3O0lFWOEx1xfXuetg18ARmxemv3GLqDXsy41IA2XYL54txc7MdNPsjd0ufmiJWDf95FktOozF2xcSI7gE7zgsbE72D05kfYIJHYFa+lTFUgOhpzgl96CtCV0sbD2RHWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAqnRfst; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7183fd8c4c7so5287157b3.3
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 07:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677191; x=1753281991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkOu+beI+6o/oWvo1KmSXmhEqOhds8ciBXnxJyc2DQ8=;
        b=SAqnRfstibqNIWXbGvqkOqSFNn+BUWUkjLT83BbzX4lX/yjCrvR0O+trMvH7RaSKa3
         0XYAbSQ8lIFyMsP3d7T2LD9ltR0qyVJszzh1CgsxDMx/4i98YTagYWSNyG3i+9GVvPC1
         uYXW7peK6SnH+PdQQk+/xbdKSBYn3qx8jXwf/qAfuDzJWynxpT9hxl0BtIP1B5SWntGm
         vV+Gt8Nc8LNk9TNDJF6ZtxoV6fuGfidAT2vpYWvOnT5xWJX8MWzkSzuqbn7HdYAMktON
         xrCNPMkoxBV4ehK4FYjzNk8/DsPE7UrlEaSpMwD4gZwJeZCo0LWOCi6G9bjNK4bfVHSu
         s/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677191; x=1753281991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkOu+beI+6o/oWvo1KmSXmhEqOhds8ciBXnxJyc2DQ8=;
        b=oJpanXBMGFOSA1np1bPHh64ZOzntVBpWUw6P0meh0QCsfEEfaXcUCfbNbbTBltfKZb
         S702+DNWf7o4mb1ruXOJIfOVMH2xXURjK+5OnQ3a8dOjos4Jqhan8FmuU3+CKNBKAZ1N
         3iVOWRbitFzsZP/1VUlZWIiGBKQ229MbuY7S+KtDjbD6HNIq22jCHV1+djX1amb5Dk4h
         6pJRJt2LaesALWdatGNPsr/9zCd/3eCUtv4T199TEj3VNpm/S1PGy/KHb+oIIaYzxk3P
         WUGQpm+JfOAYsfZEUNbXvqHw16zfABuSKANhIvrVGZEyGADRwYxKmglG6dKAGiGcV/gR
         k2mw==
X-Forwarded-Encrypted: i=1; AJvYcCUHqYX98pFrlbSlsup4/eIsw/ZSEbxzmasLriY6tYZ5AvWcNBhZLupB/Shb4IeogefYI+eZ7SY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXkn3KrXN2ulbMYZejtlBLyf9XX2/32D4rHm2d2S5iGtghAk8d
	LQMQeEzi0iVtmrMKydbI/Dba028cN0J6o7Qcs09sDMpB7isyf4AgVCoc
X-Gm-Gg: ASbGncvbD9etg4x8bjNb3CjUz/dxry04j1gz4VruiOTfWnJ/wvgzzhwzs0cheDbMihP
	l4XucZMCfHG4n/cJJ8omhIBmiX7ybrDg6Es/QY0gutA0IYq89wziTceBoAX/vyelw6JZpSNCjCh
	gyXjVCuxnOHQ6QaFJpiJ4g+NEWezUmd8Xiqt3aIwzaa/LbfLRzN1yFwEYPgiYq2bGk4h5aXt0q2
	jAQJPJrkPY28n6rovacoZZBO6u1yTllSCF14K+KQR+bz1elmb4L52nl70JPDt9nyipKCvi66PE/
	qBQjQlq7Wum1V4BIkj2ftL1+tT+lDaRIEz5f0WUVrDyIz2yGlnYbUuaRfGyVFbPvGBaPGOftjXY
	73qqo7xzZGUkUTpXXp2rpIs+JhOtGw2o=
X-Google-Smtp-Source: AGHT+IE9tSbXT+/SfTbUMjITNpaOUK3ySxANyM9g8UoqQzaVIYnA103d7e2AInw0VhS7ULbSuc8PJw==
X-Received: by 2002:a05:690c:a0a6:20b0:718:3992:9146 with SMTP id 00721157ae682-7183992943dmr19765497b3.42.1752677191302;
        Wed, 16 Jul 2025 07:46:31 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:41::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c5d4f86asm29478617b3.7.2025.07.16.07.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:46:29 -0700 (PDT)
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
Subject: [PATCH net-next v4 19/19] net/mlx5e: Implement PSP key_rotate operation
Date: Wed, 16 Jul 2025 07:45:40 -0700
Message-ID: <20250716144551.3646755-20-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250716144551.3646755-1-daniel.zahka@gmail.com>
References: <20250716144551.3646755-1-daniel.zahka@gmail.com>
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


