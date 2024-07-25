Return-Path: <netdev+bounces-113047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AAE93C7AF
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 19:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728AF1F2214E
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 17:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7225C19DFB4;
	Thu, 25 Jul 2024 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="as/xKyy8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CE154759
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721928727; cv=none; b=uXFpxFwt+XAmNuYCBXp4+Zr4aKHVhPON1tY27geENFeU0t7qCUznCMgnQmMT6UrMjC5ARGL2bAo8eQSmY4uVHYphaWPsVeBime8ZUZcTht5k0pDt1FfU3JhhZOjAum1CWCM+CxvqvQWu5newh6Mb17rgFmbNOEgm90kdj4WSNUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721928727; c=relaxed/simple;
	bh=2B8f8WrE/l9cZDKXtQV+EoRITpd2Vb6bfklW5ohZbOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7cA7eexBbm8j/5BszscxTFjNncPsFv99jGTtawSGRCaYW47tPlPgmIz7acLiIR1uolrHp3PjCtCbuB89ZjXFkVoHeSj8L6j1BcUZDGazKAHagtjOqTf/m2a51nIdlpqfKAs6mv6h8Wok4LgmcIShZEGIekrvOjQVyvlAw8Y8fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=as/xKyy8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fda7fa60a9so10781485ad.3
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 10:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721928725; x=1722533525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTcg3xMugKDibMEmmZN7kJxyVON51JXLS1Pzxqr/s+s=;
        b=as/xKyy86veQMkLqtOOn1xQV4BXzXG6nYWAGOgKt4u2EqnA0oFnWFaTCcIolC+Tdy4
         6R7eXdl6qo7ioVxsANQkr5eo1TdJ8aaD0bG6l1w65k1GF8Cj5HmkcWrWooxN2PYY8CCg
         xWueKT/sAwLwnpg7kgmYD2mKw5R0cS8qOo2QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721928725; x=1722533525;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTcg3xMugKDibMEmmZN7kJxyVON51JXLS1Pzxqr/s+s=;
        b=qfEIr5ZFURgHu/0sASka3dii1Onr9HgXMqqGtNtVLPIqRBV/q4GVtWwXkxOQ/yBLIz
         gbFjpXJSCWRJfq1u1pSToQA/4gpr4ncGonbPnc5TYEXdwqM8buEX7TeITaTumZhzWBja
         OGFhweru/sbMuuQILEOc+jf5rg9QralHl0uha+UN0lesXoM0GhXmmERNSQsmYeZ2ssZT
         KfnnQhy8Gi1npGVuZD4WLWehEld72CBees6pmByb+TSbGUlvHngnZg6qqNTIeUpdxYSe
         Ae+A02fGgpJmQmigbVpR7BL7MR69H5PFbRt04LjIPKcsZ2cwOe4mPprEj0cin0moEcNA
         oxzg==
X-Forwarded-Encrypted: i=1; AJvYcCXbCvLCt5nWuVVeph6xtfBrBMjON+a/r9a6euFSdWMT6U+fTPwsHMo2IlQ2T2Jx6wevJwXlrMTK+dald8uT+7Bz82FR4tlE
X-Gm-Message-State: AOJu0Yx16g0c5lb+8iI66gemRiEcSWzKvlZChkI+YxS/6bq8vtWiMUs9
	xGlulbAGpFfOG5RD7OCyfr/BJVJ4Bfra9HepeiVcm9Ob53L/KylfH0TD3Or2itedgDmda/vqkep
	k
X-Google-Smtp-Source: AGHT+IEHWuSit46jzp2J7leIsiryxj2NVW4bJWKskg5DpGgQVktJIJ9Ea8ATaouY1IkMnAbA/2Yiag==
X-Received: by 2002:a17:902:ea0a:b0:1fc:58fc:caf7 with SMTP id d9443c01a7336-1fed91d6d82mr31849155ad.14.1721928725156;
        Thu, 25 Jul 2024 10:32:05 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa988dsm16802115ad.263.2024.07.25.10.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 10:32:04 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:32:02 -0700
From: Joe Damato <jdamato@fastly.com>
To: Cindy Lu <lulu@redhat.com>
Cc: dtatulea@nvidia.com, mst@redhat.com, jasowang@redhat.com,
	parav@nvidia.com, sgarzare@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATH v6 3/3] vdpa/mlx5: Add the support of set mac address
Message-ID: <ZqKMEoDIZx8XFhlq@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, mst@redhat.com,
	jasowang@redhat.com, parav@nvidia.com, sgarzare@redhat.com,
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
References: <20240725013217.1124704-1-lulu@redhat.com>
 <20240725013217.1124704-4-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725013217.1124704-4-lulu@redhat.com>

On Thu, Jul 25, 2024 at 09:31:04AM +0800, Cindy Lu wrote:
> Add the function to support setting the MAC address.
> For vdpa/mlx5, the function will use mlx5_mpfs_add_mac
> to set the mac address
> 
> Tested in ConnectX-6 Dx device
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index ecfc16151d61..d7e5e30e9ef4 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3785,10 +3785,38 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
>  	destroy_workqueue(wq);
>  	mgtdev->ndev = NULL;
>  }

Nit: Other code in this file separates functions with newlines,
perhaps one is needed here?

> +static int mlx5_vdpa_set_attr(struct vdpa_mgmt_dev *v_mdev,
> +			      struct vdpa_device *dev,
> +			      const struct vdpa_dev_set_config *add_config)

Nit: it appears that the alignment is off on these parameters. Did
checkpatch.pl --strict pass on this?

> +{
> +	struct virtio_net_config *config;
> +	struct mlx5_core_dev *pfmdev;
> +	struct mlx5_vdpa_dev *mvdev;
> +	struct mlx5_vdpa_net *ndev;

[...]

