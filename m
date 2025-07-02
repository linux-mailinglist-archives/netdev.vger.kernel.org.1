Return-Path: <netdev+bounces-203464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB63AF5FAB
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2822521092
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F7B30B9A4;
	Wed,  2 Jul 2025 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvEJV+yQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4776309A61
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476432; cv=none; b=m2DNFHfQp0/mv/b3gKtiJ1b3Y1sTMKy4ov+qzlpQSUiYPveIOflspOBBTgWXbXvq68U+iNEcALc+rHcxBNLGqFZfl+qhax+GWjbz3FOUb4rEuRa/aRSxcmwa45YsSNQcyxPL+J7Ok2IaDxAT+5ZBEDHmQMdxEUM/jQKraQFEK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476432; c=relaxed/simple;
	bh=PluDXuINl0h+7RQF75H+oHgjxFlsTVDd60o/nmWkCbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9RNMKa5//ZVyXIGJ0rtdJLHeIne/AHYU1VnGbUZ63tWI0vwePzg3T8BXwOTYpM/fFeupDxUBFrRDbwGzTwJRL6JlBxs0PHxadZgIZ3oZhepXHX9slU5JejEkcrecwMzjZhCk1EuAE8Au3wUTTUvudO1pmK+4XHuWJK90Y9INxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvEJV+yQ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-714066c7bbbso80640537b3.3
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 10:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751476430; x=1752081230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGSHC5YOETvA+FvOosnMbPG4L7vRJxIYLZaKg+pMbxs=;
        b=WvEJV+yQKggdJRVCnlP5Li7UnczpS5mtt+V1cJGL4Lv7ykJWFxX+4FfufWhERZVx/P
         jtRr1f5DPaS0PMjml/xKEdEfVkdZYWNqS4zpwpCDN5mTdrrP78rxoUA2TyHW9MYdW3LZ
         K2Ou4vyMf9YZFAh45T9mQ/cRhrWWy/JSR3+uTPb4tM+Jma7y+cZKnCo+faSqfi7CHr+A
         hHk9VYVBOp/xFane+ONN1Y6wkbYdn8Hkve+HlM1pGnQwtP9d/aRSG2Od5BCvtsnfeyGx
         fRDldNetpe1H7PT5uEDcyZV2w+lVWAXv069SwcEQY/VKjr0h0CBn9yRVoazFINuR4vxn
         A9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476430; x=1752081230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGSHC5YOETvA+FvOosnMbPG4L7vRJxIYLZaKg+pMbxs=;
        b=bzR1RimAJh6iTSjki/tz9wKzHgFKlkO6pZMMl3Z6XVJfqslawQsag6yWSBiKRro1Oj
         H5Az/0J/lPyp0YcLxqiGKDDItynIrzTwLJ3+MpsnB/zH9aktAnps4F8UHBqKMTjlVAlT
         Zh17nl1KBlG6naLqspkDxpKb4fjPj/oKdaQagSrJARACQX2RmXSHGRiIYfVnbMEMo5mY
         UDxS79mwj2J/Jqx8eLsL89K0Fz+neaU+lwqAuUyLwdQi/2+1SzCfbf/N9ncJ3O5kDSDF
         18hzpyVz4N97UxhTxIC01ob+6yt/OsF4Xgvfju6Ty3gtwL4iIohoEuXPCRaERsyFOqVj
         P0Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWbUxDDVMeWhSKfiCHRQkBBLU6W7s6O3qqL+YiK+CeZMeOuVhDx5WNP3hGlz7j0xbhhoRzlGX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHirJ5o02apBv/IA/2hJzC7hQCffq558eBZScbKPyyoEsTmAeV
	D1exSZEvBfh8U/EDP/O6ZvWy/iMXLFO/iJszYvlA1A+iBMO1W4xOnVTJ
X-Gm-Gg: ASbGncvKlhnhpW0ZR/VpFDwxEVhEWFlmvHYfMgCumO8kqUtzGx3gY/kWlWOnKI291zY
	d0ZDx6Ktr074fYz9Se+pf8RIaYNv17LYS1r2k1cYgd95dPuc4w5dB8ZgAgcsnUthplgPlKsPWnV
	L54NXSiRCF+aLWl0+V4ZVeeZtOapuO4ZYsjFBH3mjmjpAO2XulpPgYMU+8r2mPuUCeUTtnSnSM1
	agoup3f+1QM3jkyacrNP6pyrVeBNbu1LTVxPvTHYAWX23An0HmfJk0rT0X2+23exprUOYixnv3z
	6wUn4LaDmuUFBS7FONJvqrJC5el1+y4eQszOIplvOdqwr7wK3YumWrd7O+Ub
X-Google-Smtp-Source: AGHT+IFb55564nrLrTjZu3ibqWgXBA3UtX1aTYY7JFN4v7YPNa+ZJSYU7KFPcq1P7Qux/xegI+6GYQ==
X-Received: by 2002:a05:690c:b13:b0:70f:6ebb:b29a with SMTP id 00721157ae682-716590cbcc6mr5452387b3.29.1751476429892;
        Wed, 02 Jul 2025 10:13:49 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:47::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cb4ca3sm25308697b3.92.2025.07.02.10.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:13:49 -0700 (PDT)
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
Subject: [PATCH v3 19/19] net/mlx5e: Implement PSP key_rotate operation
Date: Wed,  2 Jul 2025 10:13:24 -0700
Message-ID: <20250702171326.3265825-20-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702171326.3265825-1-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
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


