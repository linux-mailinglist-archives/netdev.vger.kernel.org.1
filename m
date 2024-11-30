Return-Path: <netdev+bounces-147903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 879109DEFC3
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 11:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A9828163F
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 10:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5227C14C59C;
	Sat, 30 Nov 2024 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d1YyKLUz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C0B14D28C
	for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732960869; cv=none; b=WxlOnKCT//bSJINsWWtsRYj8cTQBTLI37XHmWML8s0t1knXt8WQMnnX6RyXxsiyk/+AwwFK/BAU4vioW1zi07xoUnb5NbmaIwPvnV+sTBLkDcQSLRgpErx6q6l50mzt/9KKR5mrXo/SyrQr/QLsMM9tShFXk3jPjy5/KDY8udzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732960869; c=relaxed/simple;
	bh=/XpaTseG/TEeisBd+wk4TWWeiStEhV6ICnH01fIZSu0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GH7fEd3B/vkT3VefO10jIkIzvzuMCq7R0sAWdtqtz15O2Nizl0pUCdy5hyflYPKdwfduDlJEDVEwxHAPgdK0P6kgMewBKgQsahJLvz5tHL59PvYzuYzkhmOH8OJp84O9LCf21WtJXZO2whqOFENwJLCKVasYe1T1kpbk8gcbQuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d1YyKLUz; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d0bdeb0374so1127895a12.0
        for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 02:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732960866; x=1733565666; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a67SmAxg7nZOip6zVhj4ZsmBcbeJIrKRZCIwBRUJFXg=;
        b=d1YyKLUzWuTjh2B4bEUrPOGTF5zhAiYqp3Ha8yY5Quyjso2KPJm4Yt6xEyzT99yZz2
         nFTJbNWOzGTTXjU4aPAATBmUn9maJj4zvf1B4UH2+n2o8SSGI5XRf5s0U2ynrVd5ZKuv
         YUzR+igj4Mu9a8DiHoCfEAWtSUzpMBwqOVMcG6dwxs0d8tGpWBcLnAN7x1FzwIZXFXqs
         T33rqTeCOZ/nOxYSQbL4xJI4egCBO00mku5/zd8Zpodkuw367jFtr5ktz4QjnNhR5TJ1
         9Q8N4GlOZI6BhdRzkg8HKX+AwHu4VlfYOohIYLH3AcMBeLpuR7GkjR5Ude0X1SclfK12
         OCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732960866; x=1733565666;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a67SmAxg7nZOip6zVhj4ZsmBcbeJIrKRZCIwBRUJFXg=;
        b=mTrkiTmGi6LWUjCjz8FzpMrlvGenQ/oDmZvBWCrNqqPhEgahzSFwiA7Y0g6Rayi0hY
         MZpfMW2tb2feeuzWe3if2QosjmbY8uDmzVozyMGle0i7ZkiWwx+m0rej0rD0/RBCKNbC
         1BtTVuPHbjVRb34fQ80ZGfl4LW9gisn1loCqkmVsgxPsuz1HH7Mvtlat4zvrsVEf5+hi
         gU62KtSuKsypmy0KoAp1JLh6nuUMktPMUcVk/8LX++6dVmaFYStJy/+8t0/nQs7/vGJr
         /M02biRpm1Uq4SeqTb/6UXqYQigmPPP4T4d+ar8zZtaip1hi9QaC40y6UU44f51mnOef
         4Oqg==
X-Forwarded-Encrypted: i=1; AJvYcCU6P0nwmqUOPIpx6SrHLlNvjh7E1GJSBD+TcfOKp22qC4I2M+G3BFB+V9Aiq7C8SBAyX73+v7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDdGq8Z8J1Jew/joadJKH62w+HCI/H45ALIECHoleuIzZMelgB
	+/AW+nqMIu/4qzlbSDHkYDil0TDmeMa/u6+Mt4xgPXkQ9JncqsoylNDeg/6z3VFn2wDPAXFmy1q
	VfYIl/w==
X-Gm-Gg: ASbGnctOIO69Jyj+b/aSlcOJfPjT75ypNePF6nzxIYpZZD77Q4jMI8yg19ZfLJYkxm2
	EYhlS5LcFHxzjf7+/wbDCFDuBYQXb2UvC2c+gmQzClfsLkB/Vvs/n6eGCoBiyZZMftJicG68e9K
	jcjCESgRSK63ytgSg8vu7D5DlpPGq9N8t0OouFaAEU4bSuiflKSC8IddwrOaH3KyaLc2XI9Y1Jz
	c1z6YR3opCUNspqO6gZ79dro0TG9p52IsddJ3HulBqe4PnGkKngfw9OWGjtMOt85UuedGoC
X-Google-Smtp-Source: AGHT+IHz6Lgpgq1CwlN5SY6GoUtJEsnuXZdZiLP/TvT694J0WqT85iYkJrByZ7WTMbPj28wc6GAvsQ==
X-Received: by 2002:a05:6402:354c:b0:5cf:e9d6:cc8a with SMTP id 4fb4d7f45d1cf-5d080bd019amr12849937a12.20.1732960865832;
        Sat, 30 Nov 2024 02:01:05 -0800 (PST)
Received: from localhost (h1109.n1.ips.mtn.co.ug. [41.210.145.9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d097dd619bsm2665439a12.39.2024.11.30.02.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 02:01:05 -0800 (PST)
Date: Sat, 30 Nov 2024 13:01:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Muhammad Sammar <muhammads@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] net/mlx5: DR, prevent potential error pointer dereference
Message-ID: <aadb7736-c497-43db-a93a-4461d1426de4@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The dr_domain_add_vport_cap() function genereally returns NULL on error
but sometimes we want it to return ERR_PTR(-EBUSY) so the caller can
retry.  The problem here is that "ret" can be either -EBUSY or -ENOMEM
and if it's and -ENOMEM then the error pointer is propogated back and
eventually dereferenced in dr_ste_v0_build_src_gvmi_qpn_tag().

Fixes: 11a45def2e19 ("net/mlx5: DR, Add support for SF vports")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 .../net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c    | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
index 3d74109f8230..a379e8358f82 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
@@ -297,6 +297,8 @@ dr_domain_add_vport_cap(struct mlx5dr_domain *dmn, u16 vport)
 	if (ret) {
 		mlx5dr_dbg(dmn, "Couldn't insert new vport into xarray (%d)\n", ret);
 		kvfree(vport_caps);
+		if (ret != -EBUSY)
+			return NULL;
 		return ERR_PTR(ret);
 	}
 
-- 
2.45.2


