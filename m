Return-Path: <netdev+bounces-104680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E054A90DF8D
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 01:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61D71B2105B
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 23:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F6516DC17;
	Tue, 18 Jun 2024 23:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="JIXjRyuf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AA414D44D
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 23:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718751919; cv=none; b=RawPlzhZejV+pt2FpU3yppESMGRj+Tw2PmHDlpHOr35oMvX75jb4ihxYh91DHGrsIusS4RuUR8FUuyHOKp5Shn3sEMrSE6bSCAejgoTMNN/RwgG6FjoA1GIa4LKvSXbNTS4OzUBrW8BMMZ9mP/Gb/czx/PsgWc7jUZz45VIds64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718751919; c=relaxed/simple;
	bh=glEX0VUKvtgiB6inb2XpHM0sZrK2EH35bIQWtllj2yI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Caiqrm3k4f1bJt0P2laLOI7HiuFhQM+AA68M5sWKdda9PTGo25sk4IGfFyeF2ayCro7VrHJh0Egi6dHq4Jy/KQCDQNhTfoLw5YjAdvd0U/mfVlbvB1NcknYJaRa9Heot8tRi61+8mjbvbUlT+2THwgjGAZF9Dt5MIKMCMJVoH+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=JIXjRyuf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f717b3f2d8so1967365ad.1
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 16:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1718751917; x=1719356717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hP6mIwDnrkH1V8wGcUBtz78Sh+3YRq5iXxb49FZAWAA=;
        b=JIXjRyufm+UyOplVKcezOLpEcXAkRFifgAXgIrabjsTK/U/Djsz17rnO4Q+pMsC9zQ
         sjn/tDgi47pTrJO8JRBWivZiSW5PDKA+VmxopmExiiszII1SRN4FE3AybjJ79m6ISYLj
         zbUs6gO4scJ0mWtHiKyo37c/f1kZ8mhx5A0QZINdp1aDDMx9q6Y6JrAJJbUQ3LLst4eh
         JUhd7iN7BQVlS2KrDrtFjg8LyWwIxlRnayEQ7x0eBtonJipKVuQd/Sun8/5ilNyRyEBL
         YUPLmOmfOUxYQWfwlm9c/rRJQTUnJIA43hmK+OjZwUWprSc7RL7kEIhOmw/ESz774JBG
         5b/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718751917; x=1719356717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hP6mIwDnrkH1V8wGcUBtz78Sh+3YRq5iXxb49FZAWAA=;
        b=rNiOfl/HSLyPrlu+8Zx9+FHkwMhpxjMTl/bw73qCsqHbzOkpFIwLyKTxMu7XIjU4rh
         GyklfHVXGWyxu+3RwYz2ll80nyhQW3GcPadbDcWU5LPVzU1XVN7idmAejfybrlLL4ulp
         23hIBBcb+jax5cyf1LXKPUpU2WnE4u0lTlspj2ImRBznHruTgSD++j1l0BB6NTBywvd+
         TsFNShxCCa+0UhTWv7LXX6YdD4bI+M57wO28MrIDkme2LNa+Pe2WjAE1xLznVpcMVLdc
         9tD9vsmOPVXdyRWqbIDkY/18Ec5CmZbH/WoP9jBs7eU0WYunYnQXJYrP2BD+ZBLzeP2y
         +NBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHGyif9aqLWop63HNACqyQ2QnwtuWu4y9kQ3eTFhC7lB43DvRfVaa4y7uESuhocFHQYvKRB0QicyV1iNagmERDPPPzScOq
X-Gm-Message-State: AOJu0YwQ7v7BvsB3I4uxF4emdhUJC1DTdsDqjYuHZH+nFNvifDItMvXu
	K0IVTVg5g6hz1BA7UxkDf3ja6oeMBW9eIWRfrwJpYe2MeGfVeYrMTcarlbpEMKU=
X-Google-Smtp-Source: AGHT+IHnaqXfyJRbJbjPRTyIi61ILkqGfhPUjMx0p9RTZ5BuzBFQ4/44+kVfmGE0zi9GSDnJpJRa8A==
X-Received: by 2002:a17:903:120b:b0:1f7:9a7:cd33 with SMTP id d9443c01a7336-1f98b2132d9mr46292455ad.3.1718751917293;
        Tue, 18 Jun 2024 16:05:17 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cbd:da2b:a9f2:881? ([2620:10d:c090:500::6:95e4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9aa18d643sm4117255ad.35.2024.06.18.16.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 16:05:16 -0700 (PDT)
Message-ID: <070a3de4-d502-45f9-913f-5392e0ebee45@davidwei.uk>
Date: Tue, 18 Jun 2024 16:05:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 1/7] net: move ethtool-related netdev state
 into its own struct
Content-Language: en-GB
To: edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.com,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com
Cc: Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
 habetsm.xilinx@gmail.com, sudheer.mogilappagari@intel.com,
 jdamato@fastly.com, mw@semihalf.com, linux@armlinux.org.uk,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, saeedm@nvidia.com, leon@kernel.org,
 jacob.e.keller@intel.com, andrew@lunn.ch, ahmed.zaki@intel.com
References: <cover.1718750586.git.ecree.xilinx@gmail.com>
 <03163fb4a362a6f72fc423d6ca7d4e2d62577bcf.1718750587.git.ecree.xilinx@gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <03163fb4a362a6f72fc423d6ca7d4e2d62577bcf.1718750587.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-18 15:44, edward.cree@amd.com wrote:
> diff --git a/net/core/dev.c b/net/core/dev.c
> index c361a7b69da8..29351bbea803 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11065,6 +11065,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>  	dev->real_num_rx_queues = rxqs;
>  	if (netif_alloc_rx_queues(dev))
>  		goto free_all;
> +	dev->ethtool = kzalloc(sizeof(*dev->ethtool), GFP_KERNEL_ACCOUNT);

Why GFP_KERNEL_ACCOUNT instead of just GFP_KERNEL?

> +	if (!dev->ethtool)
> +		goto free_all;
>  
>  	strcpy(dev->name, name);
>  	dev->name_assign_type = name_assign_type;
> @@ -11115,6 +11118,7 @@ void free_netdev(struct net_device *dev)
>  		return;
>  	}
>  
> +	kfree(dev->ethtool);

dev->ethtool = NULL?

