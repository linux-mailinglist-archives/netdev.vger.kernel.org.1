Return-Path: <netdev+bounces-49960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 813457F414E
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCF12817F2
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 09:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28243D399;
	Wed, 22 Nov 2023 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QBFmb+Z9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92838B2
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:13:48 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a049d19b63bso37414066b.2
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700644427; x=1701249227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf0DudhhzPWU6llQYdjpEyP4T/pVYqS/vshpeEh7np0=;
        b=QBFmb+Z9Q5u3KfZuXd9PVjVOk8zMNUkRO9Gxa5m2De+Z+JHVsf525zkhzKRcQ6hkzA
         9zOfBMPn/FuOdlfrhPZPUGxw3f/Xa6LmldevRpkafOLMBa/pG4sIochxE+L5C2zndLtF
         qG8VvCo57K5hUJ1n1Tqixtlmp3L+/IiQFFDijXMT4tHylEAGClww/ydn5F+6TDZjX+zB
         enZomFvG0abO7ViReJJysddOxwJFjSXzog1X7VtWzCYNZ9bDJ03ou+R/ZdQyi/vOG18F
         9APTUzzLvy7u/kzI2zJaKCULuZXWjLLCsBuaExR8qZYMXG4uD90w/yNDIwLe9fIgnIu/
         AHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700644427; x=1701249227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yf0DudhhzPWU6llQYdjpEyP4T/pVYqS/vshpeEh7np0=;
        b=TvJquu0pcJ/e7Eo6KcNX4VHUg7CSM5VZXFgvASu1v2JujsT3v78Lchieb/CHCPKZ5g
         CAdL+XvBPtqJ2B0ZBTu3+2TnEF4+UnwNobhcu420Qr4kIQP2Dh5GEn3yEFArihkUxocl
         SKqaJvdzch8EPcSfXly+WJX22eAzMryVlzfHVso7jwuwz9S5y7wMRk3iojwCM3HljqvB
         7yfU9Pf9ay/n6pKZEM19rWo/rPeSG0WO/AuXuR/l1jz5KPflv59h0ueLAge2+oddKbXP
         CqdFCpoeRiz3QJDcjSok7BdOFlKEpFqCw5yyU54MAt+kWBCEDebDhMlYd05q7iVgnRpL
         pB+Q==
X-Gm-Message-State: AOJu0YxXal72GW2ig1ZzT0cliu9ud5v3TFJ8vBp5vaTF079fyCOyC2W4
	ju43BjhJzbb85xzrR63twZHZeQ==
X-Google-Smtp-Source: AGHT+IHIKLzgbioxzauk2v6O21BIXyznCKlwcFGzwnZGS7KWhIS+0PQIM6Q6Mf89iDZIJEEE8XPN/Q==
X-Received: by 2002:a17:906:cf8d:b0:9ff:2364:c0ae with SMTP id um13-20020a170906cf8d00b009ff2364c0aemr1007255ejb.56.1700644426898;
        Wed, 22 Nov 2023 01:13:46 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n21-20020a1709062bd500b00a015eac52dcsm2191803ejg.108.2023.11.22.01.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 01:13:46 -0800 (PST)
Date: Wed, 22 Nov 2023 10:13:45 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [net 09/15] net/mlx5e: Forbid devlink reload if IPSec rules are
 offloaded
Message-ID: <ZV3GSeNC0Pe3ubhB@nanopsycho>
References: <20231122014804.27716-1-saeed@kernel.org>
 <20231122014804.27716-10-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122014804.27716-10-saeed@kernel.org>

Wed, Nov 22, 2023 at 02:47:58AM CET, saeed@kernel.org wrote:
>From: Jianbo Liu <jianbol@nvidia.com>
>
>When devlink reload, mlx5 IPSec module can't be safely cleaned up if
>there is any IPSec rule offloaded, so forbid it in this condition.
>
>Fixes: edd8b295f9e2 ("Merge branch 'mlx5-ipsec-packet-offload-support-in-eswitch-mode'")
>Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
>Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>---
> drivers/net/ethernet/mellanox/mlx5/core/devlink.c |  5 +++++
> drivers/net/ethernet/mellanox/mlx5/core/eswitch.h |  2 ++
> .../mellanox/mlx5/core/eswitch_offloads.c         | 15 +++++++++++++++
> 3 files changed, 22 insertions(+)
>
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>index 3e064234f6fe..8925e87a3ed5 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>@@ -157,6 +157,11 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
> 		return -EOPNOTSUPP;
> 	}
> 
>+	if (mlx5_eswitch_mode_is_blocked(dev)) {
>+		NL_SET_ERR_MSG_MOD(extack, "reload is unsupported if IPSec rules are configured");

That sounds a bit odd to me to be honest. Is pci device unbind forbidden
if ipsec rules are present too? This should be gracefully handled
instead of forbid.


>+		return -EOPNOTSUPP;
>+	}
>+
> 	if (mlx5_core_is_pf(dev) && pci_num_vf(pdev))
> 		NL_SET_ERR_MSG_MOD(extack, "reload while VFs are present is unfavorable");
> 
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
>index b674b57d05aa..88524c2a4355 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
>@@ -846,6 +846,7 @@ void mlx5_eswitch_unblock_encap(struct mlx5_core_dev *dev);
> 
> int mlx5_eswitch_block_mode(struct mlx5_core_dev *dev);
> void mlx5_eswitch_unblock_mode(struct mlx5_core_dev *dev);
>+bool mlx5_eswitch_mode_is_blocked(struct mlx5_core_dev *dev);
> 
> static inline int mlx5_eswitch_num_vfs(struct mlx5_eswitch *esw)
> {
>@@ -947,6 +948,7 @@ static inline void mlx5_eswitch_unblock_encap(struct mlx5_core_dev *dev)
> 
> static inline int mlx5_eswitch_block_mode(struct mlx5_core_dev *dev) { return 0; }
> static inline void mlx5_eswitch_unblock_mode(struct mlx5_core_dev *dev) {}
>+static inline bool mlx5_eswitch_mode_is_blocked(struct mlx5_core_dev *dev) { return false; }
> static inline bool mlx5_eswitch_block_ipsec(struct mlx5_core_dev *dev)
> {
> 	return false;
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>index bf78eeca401b..85c2a20e68fa 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
>@@ -3693,6 +3693,21 @@ void mlx5_eswitch_unblock_mode(struct mlx5_core_dev *dev)
> 	up_write(&esw->mode_lock);
> }
> 
>+bool mlx5_eswitch_mode_is_blocked(struct mlx5_core_dev *dev)
>+{
>+	struct mlx5_eswitch *esw = dev->priv.eswitch;
>+	bool blocked;
>+
>+	if (!mlx5_esw_allowed(esw))
>+		return false;
>+
>+	down_write(&esw->mode_lock);
>+	blocked = esw->offloads.num_block_mode;
>+	up_write(&esw->mode_lock);
>+
>+	return blocked;
>+}
>+
> int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
> 				  struct netlink_ext_ack *extack)
> {
>-- 
>2.42.0
>
>

