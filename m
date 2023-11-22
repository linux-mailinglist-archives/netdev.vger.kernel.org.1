Return-Path: <netdev+bounces-49978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B1A7F42CD
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571401C20829
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 09:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8192E3D971;
	Wed, 22 Nov 2023 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="aQoBFhYV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C238CD66
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:50:40 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9fa2714e828so567920966b.1
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700646639; x=1701251439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yacGPazcQZ0Fmhp+XkbkAnD0nTZtBe5U3QY60Srg0i8=;
        b=aQoBFhYVDeJxUvNdxvNyAGePAOQnM9rFqV2Px+AR1KSxKxq8G/fAVrY4lVMmupmPeK
         gVDCE6o8SVlpozoV955D7unAf/a2yLjCHNRTZuASTIyKou8O9CWqmBlzv4o8YGRuTzTu
         TXJflMJ0CaJq+sKTg9/hH4spyeOMEd+h51PE4VORnTqrGq0enQbCCbhpgBtIK5bT4CN7
         sFMqw2JPFmRlwLu/uo71b440ed47P9SC5VWNOPxnverK+TWtgAkSPO+SlRqlBriDphFu
         FVID7KFBVUz3CuD3Ky3bB2qPeJNithTPPMKUdy6C9QtPcg6u1ysPtjryvJRgdO+ydaOn
         sf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700646639; x=1701251439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yacGPazcQZ0Fmhp+XkbkAnD0nTZtBe5U3QY60Srg0i8=;
        b=KtXlPkSOm8WKvTCuOQz/nr6KQNN/7cUNW/GTD6WkuXpi8z/sMvnQLj0iODNHooNjPC
         l0eGr12beDDO3ZrDm+CyqH9vZ3TR+Np0ev1w9wTYp+HEZTBsoWUtFauv0i55rZVrLXV5
         RLfnDqhvzkaCRngc77YYt/xhd1/pl48YFKZswYx4ThvryY52ON9VRRbCz4TBaGPIo9u6
         S/do8jflTDJ0Rp/gTnxYx2yXP/xN46hZimmi6a395/SQHM4MMAs9e95N/wB0+zMcBPp7
         lTCUOEdZ69i5dHK9mWF23udEfTaCD7cJRiHUThe6jzuDF9OupcP2pm04xVzl6Q2b3coV
         xD8Q==
X-Gm-Message-State: AOJu0YxplhXuy70VBVbOCgnkfdemF+7Dcbpcim9C7PJ9lhg6CjwUqRyV
	kxy6jp71WjqbsRvh1Urvf3vcIw==
X-Google-Smtp-Source: AGHT+IEW4gb6IGv24oRJW1HwtojgV4WAP9QgRAvGciFjEAbKfOGBTp2LwyDZGxhsD1EoCHfcHves4Q==
X-Received: by 2002:a17:906:209:b0:a02:9c3d:6de7 with SMTP id 9-20020a170906020900b00a029c3d6de7mr1162868ejd.13.1700646638837;
        Wed, 22 Nov 2023 01:50:38 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id m8-20020a170906160800b009fad1dfe472sm5022782ejd.153.2023.11.22.01.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 01:50:38 -0800 (PST)
Date: Wed, 22 Nov 2023 10:50:37 +0100
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
Message-ID: <ZV3O7dwQMLlNFZp3@nanopsycho>
References: <20231122014804.27716-1-saeed@kernel.org>
 <20231122014804.27716-10-saeed@kernel.org>
 <ZV3GSeNC0Pe3ubhB@nanopsycho>
 <20231122093546.GA4760@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122093546.GA4760@unreal>

Wed, Nov 22, 2023 at 10:35:46AM CET, leon@kernel.org wrote:
>On Wed, Nov 22, 2023 at 10:13:45AM +0100, Jiri Pirko wrote:
>> Wed, Nov 22, 2023 at 02:47:58AM CET, saeed@kernel.org wrote:
>> >From: Jianbo Liu <jianbol@nvidia.com>
>> >
>> >When devlink reload, mlx5 IPSec module can't be safely cleaned up if
>> >there is any IPSec rule offloaded, so forbid it in this condition.
>> >
>> >Fixes: edd8b295f9e2 ("Merge branch 'mlx5-ipsec-packet-offload-support-in-eswitch-mode'")
>> >Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
>> >Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>> >Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>> >---
>> > drivers/net/ethernet/mellanox/mlx5/core/devlink.c |  5 +++++
>> > drivers/net/ethernet/mellanox/mlx5/core/eswitch.h |  2 ++
>> > .../mellanox/mlx5/core/eswitch_offloads.c         | 15 +++++++++++++++
>> > 3 files changed, 22 insertions(+)
>> >
>> >diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>> >index 3e064234f6fe..8925e87a3ed5 100644
>> >--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>> >+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
>> >@@ -157,6 +157,11 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
>> > 		return -EOPNOTSUPP;
>> > 	}
>> > 
>> >+	if (mlx5_eswitch_mode_is_blocked(dev)) {
>> >+		NL_SET_ERR_MSG_MOD(extack, "reload is unsupported if IPSec rules are configured");
>> 
>> That sounds a bit odd to me to be honest. Is pci device unbind forbidden
>> if ipsec rules are present too? This should be gracefully handled
>> instead of forbid.
>
>unbind is handled differently because that operation will call to
>unregister netdevice event which will clean everything.

But in reload, the netdevice is also unregistered. Same flow, isn't it?

>
>devlink reload behaves differently from unbind.

I don't see why. Forget about the driver implementation for now. From
the perspective of the user, what's the difference between these flows:
1) unbind->netdevremoval
2) reload->netdevremoval

Both should be working and do necessary cleanups.


>
>Thanks

