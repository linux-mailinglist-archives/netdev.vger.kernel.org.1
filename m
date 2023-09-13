Return-Path: <netdev+bounces-33453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0186579E088
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6D8281C21
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78C318049;
	Wed, 13 Sep 2023 07:12:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9514182A4
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:12:51 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167591729
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:12:51 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401da71b7faso75329355e9.2
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1694589169; x=1695193969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndFgl5rQ+eLb/RGVgEXExn24nZ5LgTHyOKGUMhNNXIc=;
        b=vD1RB/7JP2PAyya9bhZyoCTRSHD/2B9Z2gfTu1hpEHi+vqu16IFhItYAttHzTZBS0X
         MSq4LgEdGAqwqUV3e3d9esMHAfXKEUsJI2d7oiIyN5z2AGOQECyOZKieRxb/ycyJxmoO
         aoSKC+WmlhAXsYEEkazbpKjjutJbWC/QfkC2xzosK1kgSIA4K0JF3N+pNBMC0rj3stpo
         OnnZvhwER62QRnveHU3INiXRrpESOD9lUkk+HeOQJhfirGm5uAuA1ItYAO2M1LBKPCAY
         rTJv85Q+J1cNUAJBphBU3K6NG7Zuta8BpYxyk0TzkzHd2IqwmVNUr3kJbC9S5RU4jx0m
         Taqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694589169; x=1695193969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndFgl5rQ+eLb/RGVgEXExn24nZ5LgTHyOKGUMhNNXIc=;
        b=vayPTKVZ15YkvVq6ukQ7/HOcdAKAEbzOmHCvv2cbSI98ajU/4Xj4IFsKIgsjY4QE74
         v/htZ9JZYWWXgYpWJkIu+fpsGyJfAoBbsR05BzGTLGioK0lvUKs826bUDvcxarVE97W6
         mm3U5PbgA1GfapFa9KWitxT45ThOWPGGd2UFCGCiFBZR3uMJhqEfpVERHdCYO4ic4DaR
         fEVVYtIE7yYGGwG7hAf14C96F7jeNB6L73uVVeiLB0JmBespHFc+xm8ipNjPpoTf0GDu
         l2g/2y22Cb6ubrc+8RY3y19prHq/+jKFhMTqsI65SyG3sAnLNv3Kk6xJHrQgZ1d4z3ca
         wX3A==
X-Gm-Message-State: AOJu0YwZolvCo1W4J3LLpVFAzg4THcOtHytk7FzlqrdZekOOP87aFpkK
	hQh1zsQxsDvu+U2QARzKrgCJrvNA8m5fwG+H9C8=
X-Google-Smtp-Source: AGHT+IGIMa3qf4yeZgKgvKNUEyiJxQLifeqs4WfDPPzkVL5/gO7noP/6BCEZSAbPteZ2mUL3y2rqRA==
X-Received: by 2002:a05:6000:1190:b0:317:f046:25ef with SMTP id g16-20020a056000119000b00317f04625efmr1432596wrx.44.1694589169467;
        Wed, 13 Sep 2023 00:12:49 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id t3-20020a05600001c300b0031f07d1edbcsm14776978wrx.77.2023.09.13.00.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 00:12:48 -0700 (PDT)
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
Subject: [patch net-next v2 02/12] net/mlx5: Disable eswitch as the first thing in mlx5_unload()
Date: Wed, 13 Sep 2023 09:12:33 +0200
Message-ID: <20230913071243.930265-3-jiri@resnulli.us>
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

The eswitch disable call does removal of all representors. Do that
before clearing the SF device table and maintain the same flow as during
SF devlink port removal, where the representor is removed before
the actual SF is removed.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- fixed a typo in patch description
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 15561965d2af..d17c9c31b165 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1405,9 +1405,9 @@ static int mlx5_load(struct mlx5_core_dev *dev)
 
 static void mlx5_unload(struct mlx5_core_dev *dev)
 {
+	mlx5_eswitch_disable(dev->priv.eswitch);
 	mlx5_devlink_traps_unregister(priv_to_devlink(dev));
 	mlx5_sf_dev_table_destroy(dev);
-	mlx5_eswitch_disable(dev->priv.eswitch);
 	mlx5_sriov_detach(dev);
 	mlx5_lag_remove_mdev(dev);
 	mlx5_ec_cleanup(dev);
-- 
2.41.0


