Return-Path: <netdev+bounces-53847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC26E804DE5
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F8E5B20B7F
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6EB3F8EA;
	Tue,  5 Dec 2023 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pVFloQJW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB29110D2
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 01:30:56 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1a0bc1e415so487063966b.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 01:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701768655; x=1702373455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xfeFkv51htlj2mlywp3RvqJAs0k2T5yn0UVwIPqoi5I=;
        b=pVFloQJWJmuTbg3lDTZ3ajKhnnbAlNcmcNkxcPjuuMG1aZfIXvKmZi9CBRYar4GaUd
         kNZKtQarDK4crZnwH/8e83G1IKOBKQaBkiaKaj2E3pVDuwrone+4lFDy7XNls+uv5iLr
         +PM9sii3hvKunlC5j4/wpjlkLRGdm10zw4PRzYeVuZBEfVv4UssWFk8p/XM2CmEysi8J
         dkd2CGjKR1PABccExH5IF6SFTb80cE5SUkC3PapQk3XCON7HBoaOAcOj9XXUHdlgCQw5
         4wp6k8hTfMqartCbrk9BjrBJM2PD7/jsSzT95433KRChbwKgH/LY1IvOhW8WDePwXuw7
         ZL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701768655; x=1702373455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfeFkv51htlj2mlywp3RvqJAs0k2T5yn0UVwIPqoi5I=;
        b=bPE3X5NxpfxzfU2AqJiz/awCQ3yScsuF/c0MOiS568GK42GrzSwNZxKV51i8BSFyXW
         uVLLHsrIQR5qVdDrnrV9sGQJN+p+itYahYXGZZMLhb24JQrDQH+Lm/RobgMW9ZBeFf8v
         V6F9beEcRqpZoo4GZQ6I4Dirc+FlA8S89LzckgDb36YJDP6Mcp0y8rCLyf3wX5DG05v1
         Hy3MWRraZqQuOMsA6nnJucPUhlNiFbppSnvaSr4oSdZO96A8kHj0x7nwITUulvrYJFyU
         0uiQFHWTddC2Q13JyG13HXkRZJ+xYfTuHTM0ThaHAAhm/fVWnt9RA/EaiomRj6fuuS5D
         BsBA==
X-Gm-Message-State: AOJu0Yw4qHFPWjfmzzTP7LEbsX/2XN3l4vENmR4zrAI2e5qq48R/00yY
	EBUWchF5bnyR+27/pvahiAMWIg==
X-Google-Smtp-Source: AGHT+IE5Is0T9Gb2pkAaMCcvdCp2+wE6MdXTNVK19edYJVfCNbwyivqpHxNj5ZqvY6JGLEncHhBXcw==
X-Received: by 2002:a17:906:1ba1:b0:a1a:57e2:2cac with SMTP id r1-20020a1709061ba100b00a1a57e22cacmr2495919ejg.144.1701768655390;
        Tue, 05 Dec 2023 01:30:55 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id gq18-20020a170906e25200b00a0988d69549sm6352748ejb.189.2023.12.05.01.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 01:30:54 -0800 (PST)
Date: Tue, 5 Dec 2023 10:30:53 +0100
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
Message-ID: <ZW7tzZZj+zpDSyLk@nanopsycho>
References: <20231122014804.27716-1-saeed@kernel.org>
 <20231122014804.27716-10-saeed@kernel.org>
 <ZV3GSeNC0Pe3ubhB@nanopsycho>
 <20231122093546.GA4760@unreal>
 <ZV3O7dwQMLlNFZp3@nanopsycho>
 <20231122112832.GB4760@unreal>
 <ZWXW5o9XIb0RHpkb@nanopsycho>
 <20231128160849.GA6535@unreal>
 <ZWdP4utCeq4MIJ99@nanopsycho>
 <20231204170538.GC5136@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204170538.GC5136@unreal>

Mon, Dec 04, 2023 at 06:05:38PM CET, leon@kernel.org wrote:
>On Wed, Nov 29, 2023 at 03:51:14PM +0100, Jiri Pirko wrote:
>> Tue, Nov 28, 2023 at 05:08:49PM CET, leon@kernel.org wrote:
>> >On Tue, Nov 28, 2023 at 01:02:46PM +0100, Jiri Pirko wrote:
>> >> Wed, Nov 22, 2023 at 12:28:32PM CET, leon@kernel.org wrote:
>> >> >On Wed, Nov 22, 2023 at 10:50:37AM +0100, Jiri Pirko wrote:
>> >> >> Wed, Nov 22, 2023 at 10:35:46AM CET, leon@kernel.org wrote:
>> >> >> >On Wed, Nov 22, 2023 at 10:13:45AM +0100, Jiri Pirko wrote:
>> >> >> >> Wed, Nov 22, 2023 at 02:47:58AM CET, saeed@kernel.org wrote:
>> >> >> >> >From: Jianbo Liu <jianbol@nvidia.com>
>> >> 
>> >> [...]
>> >> 
>> >> 
>> >> >while we are in eswitch. It is skipped in lines 1556-1558:
>> >> >
>> >> >  1548 static void
>> >> >  1549 mlx5e_vport_rep_unload(struct mlx5_eswitch_rep *rep)
>> >> >  1550 {
>> >> >  1551         struct mlx5e_rep_priv *rpriv = mlx5e_rep_to_rep_priv(rep);
>> >> >  1552         struct net_device *netdev = rpriv->netdev;
>> >> >  1553         struct mlx5e_priv *priv = netdev_priv(netdev);
>> >> >  1554         void *ppriv = priv->ppriv;
>> >> >  1555
>> >> >  1556         if (rep->vport == MLX5_VPORT_UPLINK) {
>> >> >  1557                 mlx5e_vport_uplink_rep_unload(rpriv);
>> >> >  1558                 goto free_ppriv;
>> >> >  1559         }
>> >> 
>> >> Uplink netdev is created and destroyed by a different code:
>> >> mlx5e_probe()
>> >> mlx5e_remove()
>> >> 
>> >> According to my testing. The uplink netdev is properly removed and
>> >> re-added during reload-reinit. What am I missing?
>> >
>> >You are missing internal profile switch from eswitch to legacy,
>> >when you perform driver unload.
>> >
>> >Feel free to contact me or Jianbo offline if you need more mlx5 specific
>> >details.
>> 
>> Got it. But that switch can happend independently of devlink reload
>> reinit. 
>
>Right, devlink reload was relatively easy "to close" and users would see
>the reason for it.

It's a wrong fix. We should fix this properly.

>
>
>> Also, I think it cause more issues than just abandoned ipsec rules.
>
>Yes, it is.
>
>> 
>> 
>> >
>> >Thanks
>> >
>> >> 
>> >> 
>> >> 
>> >> >  1560
>> >> >  1561         unregister_netdev(netdev);
>> >> >  1562         mlx5e_rep_vnic_reporter_destroy(priv);
>> >> >  1563         mlx5e_detach_netdev(priv);
>> >> >  1564         priv->profile->cleanup(priv);
>> >> >  1565         mlx5e_destroy_netdev(priv);
>> >> >  1566 free_ppriv:
>> >> >  1567         kvfree(ppriv); /* mlx5e_rep_priv */
>> >> >  1568 }
>> >> >
>> >> 
>> >> [...]
>> >> 
>> >> 

