Return-Path: <netdev+bounces-51663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287C37FB9D3
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 13:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49BC21C213D3
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 12:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CEB4F8A6;
	Tue, 28 Nov 2023 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JfClEpIQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976D095
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 04:02:49 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a04196fc957so775554666b.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 04:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701172968; x=1701777768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ceta966qggbmFy2XPjDd3e7R7EPGhd2AQuN4GWtaJVc=;
        b=JfClEpIQYJc8FQFTbccYEcmjU4UTe++t8V8JWYwBkD+v8+y8joBMZWSnQr1rfQ015D
         LtM2HJTn8chKMIXw23VUb6MB9yOfoxER/NZs2CxXkhy+xxMLBo13myknR+bB1lmxpFhH
         nDjmCtDDFqNzpDfQyMGq1JKgkNlgG0havdz4aw+AGIKn/klgaRnuM1CX/UEBh9nTofNK
         WiVcuyg1imOmVxWJOGSaPz29u8LFsJSbB7iepykmWhm0AZ+csuwWzZd3wHD2wvciJTnW
         gNzAuOOl55u0fQvkBFEuNKqdpOi5rcVuaZByhMISV573s5F9cIbp5qkkfFuD9bkogrAC
         guUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701172968; x=1701777768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ceta966qggbmFy2XPjDd3e7R7EPGhd2AQuN4GWtaJVc=;
        b=uqW+dNB+qxyOOKDshgFpQXrLLPiu5IPUYP6DvbfuzgCz0FP6Y8CDHJoxb7IPtaampQ
         /Gs6FL4V15PLQfWWzcw3i6V6+qI+Mc9db+xYzJT5HVpukYTewGLjos9m1qEGY2JY9pT2
         FVxPJ0G+V36Uj0++eZ3kqD8cCErjdCagjFh7wnIHpFbRY9upVDK1eGJtmDtpih8MuwOw
         DEep/0fwhl862mn/7AWedNd1UKbH5nWO1DKkR0X1fPxNqFr2Ugj6lQkzQCVZXw0fl3WT
         O0qkqW6ztAW02CZ1H+zmzEycJGyTwQvRw65z1p3ldGDNx1wQTYp2rZIkfDoV/byBqkGF
         re7Q==
X-Gm-Message-State: AOJu0YzsiMpoSBaSZbdtMbWsmJUZO5oP2AnuPA8h0nyzSz5VUl/YKz/6
	eP8DaZ0r6hhf9N3kliC2FzQhcA==
X-Google-Smtp-Source: AGHT+IEd6UJ56oPGSfaPuxtUCzjocRrjTW+fEjwaR2G3Ckwvd7kPd5Lf0JbCi+RYtJIiWBo5p4fwAg==
X-Received: by 2002:a17:906:6d4d:b0:9dd:57dd:ef16 with SMTP id a13-20020a1709066d4d00b009dd57ddef16mr10558179ejt.43.1701172967997;
        Tue, 28 Nov 2023 04:02:47 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id w24-20020a170906481800b009920e9a3a73sm6743018ejq.115.2023.11.28.04.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 04:02:47 -0800 (PST)
Date: Tue, 28 Nov 2023 13:02:46 +0100
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
Message-ID: <ZWXW5o9XIb0RHpkb@nanopsycho>
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

[...]


>while we are in eswitch. It is skipped in lines 1556-1558:
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

Uplink netdev is created and destroyed by a different code:
mlx5e_probe()
mlx5e_remove()

According to my testing. The uplink netdev is properly removed and
re-added during reload-reinit. What am I missing?



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

[...]


