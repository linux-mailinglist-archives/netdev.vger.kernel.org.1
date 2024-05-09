Return-Path: <netdev+bounces-94870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF618C0E9F
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079551C21A4C
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEAA130E34;
	Thu,  9 May 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bel+ZxZF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EF512FF8C
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715252426; cv=none; b=jGkqeK33WTAJ+14Oi6SE1RJ1JHJG4KMShmlYM1v+yOoBHHMSUA9Qo2iwR71NOxfxo1IGnepocR9vaCeyr7BLCDxFaCFBRShHve/IphsWWJUfzQB0VEskWFwWFhGZcM0NyZkhVbcbA1K9AwtlbiqH3Q4FHCcPeNSWVKT4UvW7W6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715252426; c=relaxed/simple;
	bh=oiYrFcVXcIdeJNQt0Vt+Wqd2amviAN+UyppH8WlBQG8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iNjprsNxciaP1hABDrAy2KiwnbyHbv9pAI1CV6p5lEcYLLjMF1WujdBuT90YD+P/BhQNspFmmAWOwQzKA44BiUqYI60zNAha0h7z9Mj/6R8/Jv8nZ7vAQrOlmvIaineYJ7P21rLv3bEwubR9lodzhrgDHRj+67M9vK4kbhj8F0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bel+ZxZF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59cdd185b9so330323066b.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 04:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715252422; x=1715857222; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dAA13ePi94GJNPEs4FpOTYd6Pg0GRkX3LYO1veVyWjs=;
        b=bel+ZxZFQdUntv97u2uqZuFKZJjU4k6joe/dAJppuESxanrW75CwqvTYi2OwOPgvsv
         tLmkleVSZSxrT5O2ksdOAV2R9ow26mCqIrfwrwDvv3W4TwngvGsdbOWCUJm9a6ONe0Vl
         /JUpyDD/ea3dUfqO782iTtczG95W2iN3Qa8H8sYrqC7CAWzgJnWy7kVhdjGqwu09GBL6
         B/tb8svZdb3AtfnadNQqDCcpB1aURNea/2xCdOpbZQI1KwxnMmWaqU9K3D7bJJTJAWi+
         4A9traFl3O9luKheCzIIdNNYAb6BfrH01+AUbWH3VtZKoHXkucHOKx9PpDtog8e1aaKc
         VMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715252422; x=1715857222;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dAA13ePi94GJNPEs4FpOTYd6Pg0GRkX3LYO1veVyWjs=;
        b=c1BngZHIE8n4U/Ur7pXDjHk0/nM0B2QJPRLIeGeYcoFx+CacX5sfH5FukBoD+y38G5
         kEflBJCMk3YxZZRJ4q6XkqlZhH0NhZv3sNPB9aKpfgh1IG0w7TDSObXMUmbbx32C7Him
         gASxjJ5gD1q7Oy3veHZUrhqf30XEy7K3pkAHxgz4pxi6hOH8U87XgJRM2BT1wRcZf/cv
         +CmQpN6rTWOv+HWwv6EXGTFyLUEJbszya1LRJpuZcEkmg0Dq8fbLmTxa5Laxd2FzpdoF
         hy2vX4RJ5ec77Hg4mEbdLmC/M2BtVbJD/PPOzZC+BxUyAnG1YmOpnJrfECm1/+tES7lz
         aAxw==
X-Forwarded-Encrypted: i=1; AJvYcCUxK7fUYCly9Md21Dp0LG5V69K8aPM5Vs/wgGJFNvdBELtdNtfG2hgGb323NVqO5i6uTAI8j7sRCRN8ojEKkCxF8BbOqOmj
X-Gm-Message-State: AOJu0YzSXAJBhTKWZgaFc0D+SFsWQnMeU04ex9x2ATv7P+STfPzMotS+
	hdlQ7xKIijHuECaJbrXObZiEBI/A+TFtXdxk+VE5Skp+pzGQZ5bEmZCODEQ/CbI=
X-Google-Smtp-Source: AGHT+IGbK+NqgxFz2Fj31M2oeH3+j6qnkR+cgqHhABgu7n8femfrqEdq3aeg1PWdIgkZis5QTbZqvw==
X-Received: by 2002:a17:906:2bd3:b0:a59:a1b1:2978 with SMTP id a640c23a62f3a-a5a116ece99mr175295866b.20.1715252422057;
        Thu, 09 May 2024 04:00:22 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7d70sm60549766b.125.2024.05.09.04.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 04:00:21 -0700 (PDT)
Date: Thu, 9 May 2024 14:00:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shay Drory <shayd@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Moshe Shemesh <moshe@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] net/mlx5: Fix error handling in mlx5_init_one_light()
Message-ID: <a2bb6a55-5415-4c15-bee9-9e63f4b6a339@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If mlx5_query_hca_caps_light() fails then calling devl_unregister() or
devl_unlock() is a bug.  It's not registered and it's not locked.  That
will trigger a stack trace in this case because devl_unregister() checks
both those things at the start of the function.

If mlx5_devlink_params_register() fails then this code will call
devl_unregister() and devl_unlock() twice which will again lead to a
stack trace or possibly something worse as well.

Fixes: bf729988303a ("net/mlx5: Restore mistakenly dropped parts in register devlink flow")
Fixes: c6e77aa9dd82 ("net/mlx5: Register devlink first under devlink lock")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 331ce47f51a1..105c98160327 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1690,7 +1690,7 @@ int mlx5_init_one_light(struct mlx5_core_dev *dev)
 	err = mlx5_query_hca_caps_light(dev);
 	if (err) {
 		mlx5_core_warn(dev, "mlx5_query_hca_caps_light err=%d\n", err);
-		goto query_hca_caps_err;
+		goto err_function_disable;
 	}
 
 	devl_lock(devlink);
@@ -1699,18 +1699,16 @@ int mlx5_init_one_light(struct mlx5_core_dev *dev)
 	err = mlx5_devlink_params_register(priv_to_devlink(dev));
 	if (err) {
 		mlx5_core_warn(dev, "mlx5_devlink_param_reg err = %d\n", err);
-		goto params_reg_err;
+		goto err_unregister;
 	}
 
 	devl_unlock(devlink);
 	return 0;
 
-params_reg_err:
-	devl_unregister(devlink);
-	devl_unlock(devlink);
-query_hca_caps_err:
+err_unregister:
 	devl_unregister(devlink);
 	devl_unlock(devlink);
+err_function_disable:
 	mlx5_function_disable(dev, true);
 out:
 	dev->state = MLX5_DEVICE_STATE_INTERNAL_ERROR;
-- 
2.43.0


