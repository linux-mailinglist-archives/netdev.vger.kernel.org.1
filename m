Return-Path: <netdev+bounces-217366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1175BB38726
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EEDF1882742
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8E53570C5;
	Wed, 27 Aug 2025 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYfk+D/A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393E53568F7
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310045; cv=none; b=R06GkHz2lzPqkXYEiROQPSft4xCkFzm6mjQ5vl40QIW6y1pHRzM8VL1nApqWcplxhLjOZS05D0miAsz43lkGYSKcjKqc8+X0AV0qKX8ObOeFGl16t6OxvE0zwtuciuL7zWy9iyIBNDQCLKi6QKXs0k4w2EFAFms6YtfvI+CT/S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310045; c=relaxed/simple;
	bh=XuN+6CCt6cPxnSzJbpL8GnrHtHFh6xquhBYp8pHWAws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUJj+ewAQuAkNVA6fS36R+caXYPgGuJ7kQoXGvdW0rZFFgtynS2ndiA4bMO1BI1JCQTOaazl/T5RFNhyDhGrMYw7UnZhzfe0Qq9YaK+nRTJCU0RCAeiDgfEEOkB1RNl6RALl+ta0EqrvNzVFANZw3zN0x5V+4o6TzjSQ0/LvyqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYfk+D/A; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d601859f5so53188727b3.0
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 08:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310043; x=1756914843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=939Nx6uVLvw4l3lvlfanPraTohmmdWkgrL+mk0f9MXQ=;
        b=nYfk+D/Aj69E7ptIMV2bQUHsQQFTCSmBieY9jGEMmEPEUTrtJl7zTTIg7NsPROREK2
         BT4KSvoQK6/RgzOXBQgjuT5sTguK6yTmieaI943EzphHmSU4vbbyzqt9kbwOnO/qMlOe
         SnB6RahXNPtwm2nwbYkxHAdSEyMOmzaqV69TZ0s8xjctX+qJ/S4ScEZGZwyf798WXY6B
         +L5V7rDbqkprJqrloMtLa7PFOt8turPyYVtgZN3dN10+q02g8dcncSQLpbObH0M9rDS5
         GvNRZCJvnbr8WPoheACRG0FuTWbH/xe8ZCcHInhinOpMyL7ZF3W37HraZfmT8GnwL2r4
         xWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310043; x=1756914843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=939Nx6uVLvw4l3lvlfanPraTohmmdWkgrL+mk0f9MXQ=;
        b=fbSu1G6TtLZx3ujEGqu7PjpKE5wQ9Z+BqaIG2949VK/9ruBEdIr3XLc4OnmP8plcgX
         iM2yJ/dzrrh0ZPAxyzktRchifq9Q3OumMnwfUJN6wEU/xUXWYmQAoioMnNY7mo9tXY9P
         Zlrk72HUwDY+dufyhdZmxjoFFVPDb49DD6lDe0VDCONM7q45OetVLF0Y+N2OjaejsrTX
         7wXcnti4/je1HiFAWNGI7OO5mtt229opUxoAYaJxV8Z8K4GydWXKi7Oo5zO61QetRjqK
         GCqR4/IMfkLOLjWZLzCT/Mh8F/lBMb6Kf0S9ctia4TAS8su387lrlkFLutzUm6lYep22
         peyA==
X-Forwarded-Encrypted: i=1; AJvYcCUXb9/7rvFjYyEz1ih4gPXla0jwOifaSCkEegGzzXhWiuEXbuLLHof8s7/TGqq6ywbpuWcpvbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOH6r0xkXcWKrdY5zpKy5qFtN/CI7kMjNktvjCdYHjBaRS3NOI
	+9mSeTFL1GCzf34IpohDMXoyrLo9uAJCjuzhF53Qamc+eBJqg/geo1Mn
X-Gm-Gg: ASbGncvTWi0n3pAsRtE8EXceSf0QXQAcNhpGEEU0nJe98y+QsVnd/dVSjlOcm2Al0pK
	AQ2AV5treSVrdaTPULutd0lt2SFuCquLGilQPJoXkGSKDFwRFOhTPu4cEqIZzgFvOeTBvMgL0/s
	lv/yxgetOCz8hyww6zrSlVIbS/bbHRoKoRaGYPJ9zcxQimYnzM4oo4ezjPGnrsQ24DUUaig1QNC
	p3vxhHzbGwLhakU18E7k6YHUMB/cMsyUuBwpPkBCSb49NLqSrByiEtMDTxMgElYqfOtk4lWd46I
	gwLRxL1sUE42yNfib+l68gNuizPkxivbdNNGVeir1Fh52h2hqjsmBPBLV64HTMQ8vwJiihbUgXN
	gBjuFveYcjc2CyNrQSisQJfiVnoFCfg==
X-Google-Smtp-Source: AGHT+IHoS5SSlXBvEMNURNHcrMb6CTZ1wZkjsrdTulBrSV4FXpxAKvPmgyyFATfdkSxUvrcA5r7dUg==
X-Received: by 2002:a05:690c:368d:b0:71c:40c9:b0d1 with SMTP id 00721157ae682-71fdc108111mr226424987b3.0.1756310043133;
        Wed, 27 Aug 2025 08:54:03 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:b::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5f65afbaf1esm3156628d50.9.2025.08.27.08.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:54:02 -0700 (PDT)
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
Subject: [PATCH net-next v9 19/19] net/mlx5e: Implement PSP key_rotate operation
Date: Wed, 27 Aug 2025 08:53:36 -0700
Message-ID: <20250827155340.2738246-20-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250827155340.2738246-1-daniel.zahka@gmail.com>
References: <20250827155340.2738246-1-daniel.zahka@gmail.com>
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


