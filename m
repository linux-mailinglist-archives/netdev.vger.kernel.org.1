Return-Path: <netdev+bounces-52157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A4D7FDA60
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 15:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AB08B20ED4
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A212834541;
	Wed, 29 Nov 2023 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IesClxi1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3178310E4
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 06:51:18 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b538d5c4eso4998705e9.1
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 06:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701269476; x=1701874276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s6Z5IEXZFBz4uTjmRRxhbakEEh/x4dXjj/6bssZ0P2M=;
        b=IesClxi1qtaMyrwVVCHTUnyLwrudCOWYNXoejN1L3zQ92LWQv4oiWtCWZ6LF62LSlk
         v78THY1302C2ED8TibRkC4JnE8wUzZWGWul6HFP93EIT4YZARn607kLWleIFrifdi03f
         gGtK3l1+qCdh16cg5ewKEQN9chQ6Xqb/D9sqrnYFCUbdXt2xaNv/klfBWTUU0AczuGeQ
         N3+DfMWWwbGrC5t9Juzr4Lek+dpY/wu6bjnADBBiTtlK7AN2uMQ4A3Y2Tx+uirazCddp
         dnQhUv46ik7ujDPojqWD7KlAkoW52Ri8eQbtwP+44Pd+EQ1h/d/Vh2cgnB2uJ+ZDOtBn
         C4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269476; x=1701874276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6Z5IEXZFBz4uTjmRRxhbakEEh/x4dXjj/6bssZ0P2M=;
        b=wYiMw5nyFiu6Od5qQllckh8RK1VOLFmFlMHk03Q7M5Hwgz1YPyI4dLByUUOjiu5mGa
         jmtghXwfqrx+O0ZAVCHwc4/44nL/ew9SRWvuiKt19Qyfi9PeBJcZfmi+AYkX9pLF5fAi
         rShwKuoXxo84uSRxkZn7XpR65r11IliXejvYaY4lssykjJ2LNQP3CgLPkjKnyDluNwhe
         rxkt/Nvb+SVVqlauBDcrMan0660Y3HZNCcgyd7Hr5pXnsstnGN6Gv7iH5K70LR/Ojxt/
         EI/BV+/76UHq+wu/PWPQcvaqOLtw7Z0h6siKWJQCaTveeAw8KmuW38tHG5WN1QoqLxGy
         GAcQ==
X-Gm-Message-State: AOJu0YzyYDLkfg4hu5PeTHM+kJ0HEYjCbxKzGqIcCbFQkF7QvDp+wpWC
	hZTVHibKj9SwyVL6AUXShkDERg==
X-Google-Smtp-Source: AGHT+IE5UW3e6U/GDV5giYDbXhC6oPyjeD1q8fDF4W4WNTgH7iq90B2RtgBCQ08/rlJRoGKwTvIDoQ==
X-Received: by 2002:a05:600c:198b:b0:408:55f8:7de with SMTP id t11-20020a05600c198b00b0040855f807demr12568163wmq.28.1701269476614;
        Wed, 29 Nov 2023 06:51:16 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n40-20020a05600c3ba800b0040b34720206sm2481720wms.12.2023.11.29.06.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:51:15 -0800 (PST)
Date: Wed, 29 Nov 2023 15:51:14 +0100
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
Message-ID: <ZWdP4utCeq4MIJ99@nanopsycho>
References: <20231122014804.27716-1-saeed@kernel.org>
 <20231122014804.27716-10-saeed@kernel.org>
 <ZV3GSeNC0Pe3ubhB@nanopsycho>
 <20231122093546.GA4760@unreal>
 <ZV3O7dwQMLlNFZp3@nanopsycho>
 <20231122112832.GB4760@unreal>
 <ZWXW5o9XIb0RHpkb@nanopsycho>
 <20231128160849.GA6535@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128160849.GA6535@unreal>

Tue, Nov 28, 2023 at 05:08:49PM CET, leon@kernel.org wrote:
>On Tue, Nov 28, 2023 at 01:02:46PM +0100, Jiri Pirko wrote:
>> Wed, Nov 22, 2023 at 12:28:32PM CET, leon@kernel.org wrote:
>> >On Wed, Nov 22, 2023 at 10:50:37AM +0100, Jiri Pirko wrote:
>> >> Wed, Nov 22, 2023 at 10:35:46AM CET, leon@kernel.org wrote:
>> >> >On Wed, Nov 22, 2023 at 10:13:45AM +0100, Jiri Pirko wrote:
>> >> >> Wed, Nov 22, 2023 at 02:47:58AM CET, saeed@kernel.org wrote:
>> >> >> >From: Jianbo Liu <jianbol@nvidia.com>
>> 
>> [...]
>> 
>> 
>> >while we are in eswitch. It is skipped in lines 1556-1558:
>> >
>> >  1548 static void
>> >  1549 mlx5e_vport_rep_unload(struct mlx5_eswitch_rep *rep)
>> >  1550 {
>> >  1551         struct mlx5e_rep_priv *rpriv = mlx5e_rep_to_rep_priv(rep);
>> >  1552         struct net_device *netdev = rpriv->netdev;
>> >  1553         struct mlx5e_priv *priv = netdev_priv(netdev);
>> >  1554         void *ppriv = priv->ppriv;
>> >  1555
>> >  1556         if (rep->vport == MLX5_VPORT_UPLINK) {
>> >  1557                 mlx5e_vport_uplink_rep_unload(rpriv);
>> >  1558                 goto free_ppriv;
>> >  1559         }
>> 
>> Uplink netdev is created and destroyed by a different code:
>> mlx5e_probe()
>> mlx5e_remove()
>> 
>> According to my testing. The uplink netdev is properly removed and
>> re-added during reload-reinit. What am I missing?
>
>You are missing internal profile switch from eswitch to legacy,
>when you perform driver unload.
>
>Feel free to contact me or Jianbo offline if you need more mlx5 specific
>details.

Got it. But that switch can happend independently of devlink reload
reinit. Also, I think it cause more issues than just abandoned
ipsec rules.


>
>Thanks
>
>> 
>> 
>> 
>> >  1560
>> >  1561         unregister_netdev(netdev);
>> >  1562         mlx5e_rep_vnic_reporter_destroy(priv);
>> >  1563         mlx5e_detach_netdev(priv);
>> >  1564         priv->profile->cleanup(priv);
>> >  1565         mlx5e_destroy_netdev(priv);
>> >  1566 free_ppriv:
>> >  1567         kvfree(ppriv); /* mlx5e_rep_priv */
>> >  1568 }
>> >
>> 
>> [...]
>> 
>> 

