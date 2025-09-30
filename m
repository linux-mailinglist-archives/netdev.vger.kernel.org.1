Return-Path: <netdev+bounces-227348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F356CBACCEE
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 14:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5463A76A2
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 12:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5D42F9C2A;
	Tue, 30 Sep 2025 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KayxsDOP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7921DD9AD
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235108; cv=none; b=Qi99enQynUXLsxlDppheGQb+PjBl7GXe4YFPuBek3Pmm6nIB9BlMSBBj29XXiCfuDE93U8lccef/WwEOHJUZr2lpKKnlcSUX1/kb/7llt4/4rEOzIWbFrEqqmr+iJerl/sKHEXzqw7TJSfw0Y7Luvy0NrtySWrpxoDQem3fFONM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235108; c=relaxed/simple;
	bh=N3iWQBr+C6sq5xql6Cd1AX/fvpXX92N8aQvLLb5U5E8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=auNYkELgLzHGrhJE5WTTMN8yjr2GSBdKEi3GVx9x5b7cxfcI4NSUMn1RivrufDCzqiJfFUGFJCaxD8gVbzPtYh5asz5NnmQDxSabvjTFiyG0w3vTUvsrk12ID6m9zvNJTyiT1j3EoAduhQYUrfid5xPukFO5NJH12+qHInjDLl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KayxsDOP; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3fa528f127fso4627686f8f.1
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 05:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759235105; x=1759839905; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S6lOcLfmjHHMwdRKIuWAlaFWrbjWxKqUiXJMf1tdzpQ=;
        b=KayxsDOPIF+Wrm+kQOBRpu9ibozip57hTC9ymTs/ic6YA3Pbm4IV40dKAMSqryYspd
         wYOS6DtGkLc2WhIJyhphMPUgTdOeGA+gdXj88PhsNyE7E5BS6YHIlYK7eXN6n7RXvKy5
         eSsT7uEhGonZxy+jDM8E2dQLHBU3uxHcabK/KgG6+e8WCJZ7EKHuvQs0cPEiCbb2jKlP
         Nwlcu6c/YZltw9iltwQRCmPej+iXAk/rqErkHoH7uGuuyvNkFNuy7I24Yy+EWl4yNpa0
         Hfd6fVPf4HkIFQyqMUm/0NpkNPHTuGHD4sEfrcPMEUtawlOtvTdc7CIvgsC7YtcVvIlx
         D1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235105; x=1759839905;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6lOcLfmjHHMwdRKIuWAlaFWrbjWxKqUiXJMf1tdzpQ=;
        b=CVbpK4/tEBKjN9v+YANfgLvXXKVDgwvxa2bSlbuoDTEh7R8l9neRcDYUnQFs8UknKA
         ELpjzRW3cM4chTi7FqXlr82tUxK86ABj/BAEf2o8Mx5WJLwEkBZxExftGVTK0bmkoc/e
         ODzjppyIMhwX2Fv+r/TmWt5kKTfYZiYFURmrYnWTNgxgV69E+YgGDkJHuavHSzrsTGlQ
         WaF/nhd2t/PJn1Byp7rMxAwluXrQ7WwHed2ufEMGdtPzdPbYhc+ZH/6uEBK3WqRneEyv
         d5zxhOajieqph34ZhwW9v54tBZEV6EHvhumzqZPj4KrZPiyBd9u5I9zUZkafXS0f5Xqi
         PDuA==
X-Forwarded-Encrypted: i=1; AJvYcCWUMDqWAOI/b77WUhmfDk8i7Ee7LaT4Toi81/H+2Y7J5NXS54aL6QvShZgvjP12twERklJHD2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcY1PFG8OXAA5JQwwRqgCfsEeoVVlZQL7hPooZlU2uOto2c/NI
	jNiLJJqL2Vn00Ndyb7/DDgtHUTlnBqdKMyM4yh9Z2fxE+C56q1qkN+nkE9Pw/Yr2zeo=
X-Gm-Gg: ASbGncsVNvooP6fGr1EeBItyXcMrT0w5f7mDISC19GKbQyUiVoXirVnjWv1C5JtzfBJ
	GFTclLbYIwky/GDANeJOi5y04+oxrmsCyEieLxDCiP9XOXV0SKIhvmGVnncn5vhgSb1+Z4EGAL+
	erwCR+E5bPYg60oLsJQBBMMWSOqv1F9FWamYonRCrlH0NA5NjcsGjaKwac8v58eEk9IbPmeb7Hd
	Bhzo16JQcDRhnETYj8wExa9dyYhBwNIxlk7F5OgAS20kQR6bBxe7l8d+yOmf5BH9DULtm7y4ZmA
	/PC94yjvdcsBW1zdW3UbpHtMWRzW0Z6swvXYEySeJQdruwTZHtywD32h14xRzUTUpTvLjttb0PW
	lHPgebgvUXTepHft9tX32fS/S7N58+iOyukWR6lduZX8m+6ZNS9Qf4xKoSyaDc50=
X-Google-Smtp-Source: AGHT+IHLfXLZ95GySBe9ZuBPDMocDcdm4e3YftS67zYrym4isY22xPTXaFrasbFvqRJbXcP0Bwxl5A==
X-Received: by 2002:a5d:5888:0:b0:3ea:d634:1493 with SMTP id ffacd0b85a97d-4240f261673mr4414743f8f.3.1759235104947;
        Tue, 30 Sep 2025 05:25:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fc82f2ff6sm22407808f8f.56.2025.09.30.05.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:25:04 -0700 (PDT)
Date: Tue, 30 Sep 2025 15:25:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yan Burman <yanb@mellanox.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Amir Vadai <amirv@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] net/mlx4: prevent potential use after free in
 mlx4_en_do_uc_filter()
Message-ID: <aNvMHX4g8RksFFvV@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Print "entry->mac" before freeing "entry".  The "entry" pointer is
freed with kfree_rcu() so it's unlikely that we would trigger this
in real life, but it's safer to re-order it.

Fixes: cc5387f7346a ("net/mlx4_en: Add unicast MAC filtering")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index d2071aff7b8f..308b4458e0d4 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -1180,9 +1180,9 @@ static void mlx4_en_do_uc_filter(struct mlx4_en_priv *priv,
 				mlx4_unregister_mac(mdev->dev, priv->port, mac);
 
 				hlist_del_rcu(&entry->hlist);
-				kfree_rcu(entry, rcu);
 				en_dbg(DRV, priv, "Removed MAC %pM on port:%d\n",
 				       entry->mac, priv->port);
+				kfree_rcu(entry, rcu);
 				++removed;
 			}
 		}
-- 
2.51.0


