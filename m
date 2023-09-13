Return-Path: <netdev+bounces-33463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E61C79E0A8
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0633C28154F
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBF219BD2;
	Wed, 13 Sep 2023 07:13:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621BC19BB4
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:13:08 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A138C1728
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:13:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401d10e3e54so70078035e9.2
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694589186; x=1695193986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSueh9Yv9KLqh0yGW2vN2PuFR/O304sW84zrnLv9qZc=;
        b=BworEQEKs+VLTezeoJwXMEFi0nHn0wWlwMQUv1TSt6TqN/iUgmlmcbHaiPRuoQ/GZs
         SOTvY9WkGCTjYtcJIhtQVnKrRH8RSxsV0LK/RILpoop1P4mUoSZW9ffTm58Uiakaq04B
         6BWPf7isdpH2py/LIGH+0ZRXvepVqBcCskFsXsDCNEUhhWH69DZ/NOVUma0jEESce3yO
         AhBOk1Kyy3+6GUu5AQ2oDy1svSAgq82x13mlXb3KhwNLhmn4fD6jPgMiBHHUyB+8m/p8
         oxqHGqZszYyzvh1tlk3AMIoxxNdmNVG4CHcMWWnJk6cSpgnmCiSaZCTjfLYxfee4sKDM
         Bocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589186; x=1695193986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSueh9Yv9KLqh0yGW2vN2PuFR/O304sW84zrnLv9qZc=;
        b=qLwdu1dpuu6qwsbHtDfQEexafUjsHRoN/rpSE5d7PFA7Myj4PKYEADh66SJmrKn9Wa
         BrdRr9zBmKryL0q35DPSlEdK/mMANV01Vl9flOxP5fOzp1LwPoP0Rht6hEml5f2+6mfI
         yLnFvBLcAt9g0qCJqxYl2vzodGHZ901ijiUPHixrT77mwmUNkeI2nvkOurB4b/Pm0juh
         MqGMv4uBY+Jl/PSY8mzJSmV/RDaCczyWr53JvBT++EmWI+hg9eNaxOwLoYzcYEhW9xnb
         zSlZMi9MYhD9lIDgACOR2hM0/66XyLnqk4jFSR8ZNumCKxMi6ENycwiKOSyyW2rZNOVt
         2Kmg==
X-Gm-Message-State: AOJu0YzbhHVjTdqOJk3GJAm30Tri9p6OtmwAXUGSLUGbA67LSsMsS5hq
	mcHa/a3BDYwsMkoqLa4t5LRNBsh3NxUllWX3zuk=
X-Google-Smtp-Source: AGHT+IG4DmhRepIORlDwJzUudoZ9xr485y2+6khn0CpS7JRGEFsIktAkKIJ1hCMaRZGMGVzf6wkRng==
X-Received: by 2002:a1c:7407:0:b0:401:d803:6241 with SMTP id p7-20020a1c7407000000b00401d8036241mr1251338wmc.21.1694589186204;
        Wed, 13 Sep 2023 00:13:06 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id x20-20020a05600c2a5400b003fe601a7d46sm1099400wme.45.2023.09.13.00.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:13:05 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	idosch@nvidia.com,
	petrm@nvidia.com,
	jacob.e.keller@intel.com,
	moshe@nvidia.com,
	shayd@nvidia.com,
	saeedm@nvidia.com,
	horms@kernel.org
Subject: [patch net-next v2 12/12] net/mlx5e: Set en auxiliary devlink instance as nested
Date: Wed, 13 Sep 2023 09:12:43 +0200
Message-ID: <20230913071243.930265-13-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913071243.930265-1-jiri@resnulli.us>
References: <20230913071243.930265-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Benefit from the previous commit introducing exposure of devlink
instances relationship and set the nested instance for en auxiliary
device.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- new patch
---
 drivers/net/ethernet/mellanox/mlx5/core/en/devlink.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/en/devlink.c
index c6b6e290fd79..0b1ac6e5c890 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/devlink.c
@@ -12,11 +12,19 @@ struct mlx5e_dev *mlx5e_create_devlink(struct device *dev,
 {
 	struct mlx5e_dev *mlx5e_dev;
 	struct devlink *devlink;
+	int err;
 
 	devlink = devlink_alloc_ns(&mlx5e_devlink_ops, sizeof(*mlx5e_dev),
 				   devlink_net(priv_to_devlink(mdev)), dev);
 	if (!devlink)
 		return ERR_PTR(-ENOMEM);
+
+	err = devl_nested_devlink_set(priv_to_devlink(mdev), devlink);
+	if (err) {
+		devlink_free(devlink);
+		return ERR_PTR(err);
+	}
+
 	devlink_register(devlink);
 	return devlink_priv(devlink);
 }
-- 
2.41.0


