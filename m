Return-Path: <netdev+bounces-50035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4F27F461E
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3551C2088C
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 12:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E701CA9C;
	Wed, 22 Nov 2023 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="1u8YfFUG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF88210A
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 04:25:32 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a00b056ca38so358556866b.2
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 04:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700655930; x=1701260730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IAN1ngsgNsFuH+J9VbBFPBvFgT3FD5POoaP7ntnF3dA=;
        b=1u8YfFUGcRc1IIG++Mkz/UD1OTjeZtp/X3ugXKsaiVxtinLgDVL9V0Eio7y2wVmwwZ
         7in8kY2/mOn3W8CXXiHR2ctLeUfXtnJUh1lScrbv/cAWQtghjAp8gp/V/owcAd1cwoLI
         b9UN0pWODFfi41DFA9QwdpVrAg9a47bH4S/Y5A1/msKQlAi5YIhnedamBBa7C2IwIdWc
         LGwKdH8t3L0Y0MlgrbCXIN0HTpumE7iLwqQrvDbqoKSRWQoeRJIwlpguirRinDeF4x0x
         CLYXfdNzdml+zRILVxTcTILhmUaux/rcCL2WI10UB9uh2zvaM0sHNc5W2s0gbCDZfdJf
         jEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700655931; x=1701260731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAN1ngsgNsFuH+J9VbBFPBvFgT3FD5POoaP7ntnF3dA=;
        b=ltBcULQgUVaYj/f7GGU+nSq56tz394OwYMzk4UDuryfNzgZRCNLoO1VxqrZOnOKdxK
         bB6lYh9K7xPNn0IwLoIg1XZeZrAwStw9Ccg+MWp2U0SD3LeFo3/Go5VC3L6UUhjDqL8a
         8scDA36cFHwS4Cj1UBtmuuyQoVhh3p7kH8MN5ZumZBn0MdsM3D7LYREr0i8u935CUQ2j
         0L7x2uIr1TY5cJA3qMAhRNWF9Zka3XReBznfGLtWLLhQdSSEH/ZQwCrwYJrmJ50fBbDI
         MEPKMHNCOsvOJmzacNylhyLVJQf20UCX33P1Z+o9TifAw66sA7/iaXZgJoyZy40nalMf
         kY5Q==
X-Gm-Message-State: AOJu0Yz8kXv2njdqYimHkxqqzta2BlC7Ms8oksFAP0zFHanevrSLn6qi
	jhWB3KTGThydh5f8yID06tdTJg==
X-Google-Smtp-Source: AGHT+IG7RsK/6FXjU/eS2/Gd53KFobKSsVvA46WETbFYZiWduZo7HahEeq7UA6BpFNV0jgM1r7NdAA==
X-Received: by 2002:a17:906:78c:b0:a04:5301:2e8f with SMTP id l12-20020a170906078c00b00a0453012e8fmr1308306ejc.19.1700655930608;
        Wed, 22 Nov 2023 04:25:30 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id s10-20020a170906060a00b009efe6fdf615sm6413869ejb.150.2023.11.22.04.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:25:30 -0800 (PST)
Date: Wed, 22 Nov 2023 13:25:29 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Leon Romanovsky <leon@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [net 09/15] net/mlx5e: Forbid devlink reload if IPSec rules are
 offloaded
Message-ID: <ZV3zOavX9yx/9cM+@nanopsycho>
References: <20231122014804.27716-1-saeed@kernel.org>
 <20231122014804.27716-10-saeed@kernel.org>
 <ZV3GSeNC0Pe3ubhB@nanopsycho>
 <20231122093546.GA4760@unreal>
 <ZV3O7dwQMLlNFZp3@nanopsycho>
 <20231122112832.GB4760@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122112832.GB4760@unreal>

Wed, Nov 22, 2023 at 12:28:32PM CET, leon@kernel.org wrote:
>On Wed, Nov 22, 2023 at 10:50:37AM +0100, Jiri Pirko wrote:
>> Wed, Nov 22, 2023 at 10:35:46AM CET, leon@kernel.org wrote:
>> >On Wed, Nov 22, 2023 at 10:13:45AM +0100, Jiri Pirko wrote:
>> >> Wed, Nov 22, 2023 at 02:47:58AM CET, saeed@kernel.org wrote:
>> >> >From: Jianbo Liu <jianbol@nvidia.com>
>> >> >
>> >> >When devlink reload, mlx5 IPSec module can't be safely cleaned up if
>> >> >there is any IPSec rule offloaded, so forbid it in this condition.
>> >> >
>> >> >Fixes: edd8b295f9e2 ("Merge branch 'mlx5-ipsec-packet-offload-support-in-eswitch-mode'")
>> >> >Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
>> >> >Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>> >> >Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>> >> >---
>> >> > drivers/net/ethernet/mellanox/mlx5/core/devlink.c |  5 +++++
>> >> > drivers/net/ethernet/mellanox/mlx5/core/eswitch.h |  2 ++
>> >> > .../mellanox/mlx5/core/eswitch_offloads.c         | 15 +++++++++++++++
>> >> > 3 files changed, 22 insertions(+)
>> >> >
>> >> >diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>> >> >index 3e064234f6fe..8925e87a3ed5 100644
>> >> >--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>> >> >+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>> >> >@@ -157,6 +157,11 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
>> >> > 		return -EOPNOTSUPP;
>> >> > 	}
>> >> > 
>> >> >+	if (mlx5_eswitch_mode_is_blocked(dev)) {
>> >> >+		NL_SET_ERR_MSG_MOD(extack, "reload is unsupported if IPSec rules are configured");
>> >> 
>> >> That sounds a bit odd to me to be honest. Is pci device unbind forbidden
>> >> if ipsec rules are present too? This should be gracefully handled
>> >> instead of forbid.
>> >
>> >unbind is handled differently because that operation will call to
>> >unregister netdevice event which will clean everything.
>> 
>> But in reload, the netdevice is also unregistered. Same flow, isn't it?
>
>Unfortunately not, we (mlx5) were forced by employer of one of
>the netdev maintainers to keep uplink netdev in devlink reload
>while we are in eswitch. It is skipped in lines 1556-1558:

That is clearly a bug that should be fixed. That will solve the issue.


>
>  1548 static void
>  1549 mlx5e_vport_rep_unload(struct mlx5_eswitch_rep *rep)
>  1550 {
>  1551         struct mlx5e_rep_priv *rpriv = mlx5e_rep_to_rep_priv(rep);
>  1552         struct net_device *netdev = rpriv->netdev;
>  1553         struct mlx5e_priv *priv = netdev_priv(netdev);
>  1554         void *ppriv = priv->ppriv;
>  1555
>  1556         if (rep->vport == MLX5_VPORT_UPLINK) {
>  1557                 mlx5e_vport_uplink_rep_unload(rpriv);
>  1558                 goto free_ppriv;
>  1559         }
>  1560
>  1561         unregister_netdev(netdev);
>  1562         mlx5e_rep_vnic_reporter_destroy(priv);
>  1563         mlx5e_detach_netdev(priv);
>  1564         priv->profile->cleanup(priv);
>  1565         mlx5e_destroy_netdev(priv);
>  1566 free_ppriv:
>  1567         kvfree(ppriv); /* mlx5e_rep_priv */
>  1568 }
>
>> 
>> >
>> >devlink reload behaves differently from unbind.
>> 
>> I don't see why. Forget about the driver implementation for now. From
>> the perspective of the user, what's the difference between these flows:
>> 1) unbind->netdevremoval
>
>netdevice can be removed and there is no way to inform users about errors.
>
>> 2) reload->netdevremoval
>
>According to that employer, netdevice should stay.
>
>> 
>> Both should be working and do necessary cleanups.
>
>I would be more than happy to see same flow, but this is above my
>pay grade and I have little desire to be in the middle between
>that netdev maintainer and his management.
>
>Feel free to approach me offline, and I will give you the names.
>
>Thanks
>
>> 
>> 
>> >
>> >Thanks

