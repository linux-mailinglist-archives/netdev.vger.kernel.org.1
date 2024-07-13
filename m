Return-Path: <netdev+bounces-111294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C2D9307CA
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 00:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD052B20EFD
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 22:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A298D1741F2;
	Sat, 13 Jul 2024 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNuN/KLn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AC41741E0;
	Sat, 13 Jul 2024 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720910134; cv=none; b=mtapBJYXXTWIEYNwI03KuDmKS5C78QjcFomelLCGxvcYUmSi+t8Ff12DYY4o6p53Wjd2YFsll6hcUF5A9mENbJMxWOzi5LGW60PXJlNQJQpvH4B1SLdGBlPKprByVosDNDZgvjfCVGSbedH5dv9Ln5ZZubcjz/o4ytSfh8oMToM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720910134; c=relaxed/simple;
	bh=zQUxCqtUpN52n9YsEQxbjE8McWWkxC6aEh066/NralQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhZZcYAO5RL6Va2auXmK6ifxHsAimRlQfFwjQA4UJ+Jaxj90uH4wTFI2VBry2cLq6iZrmeoctnCLFlwWZPg6YMmC1sFNsL7R7teT4uyjSWKr1rhiJsPhPY7jidVxR6e/WwXv7gqDAuYlFtRjS104wFjwVoyG8oHwueAvoSSSL6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNuN/KLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94C8BC4AF0F;
	Sat, 13 Jul 2024 22:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720910134;
	bh=zQUxCqtUpN52n9YsEQxbjE8McWWkxC6aEh066/NralQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TNuN/KLnVTqee778aHu2dlA7WIyvigcmlfKY3stUj1rxOvT9viyCQynS3KSfb+k1/
	 RHjfRTc7WJvIVjbmeNF0JUkZAPYIe9a4D6umdGtJ7lE6Ii8nf5k7z5zq6bHIFFrt3q
	 7BUAWXjpqb+EEMop9aGkLJQtwUk9k0+dwzQZS3K1v+tvtyrxUDVyDe4fuqrNLCSgDD
	 2kn8QjRQZYWVDxd8jt3VJSUtOf1tJ1ULaZNcDqQ5KmSc3Kl0rlIeubQQ6KhjwvPQxJ
	 v0hn4oHGIyhL3Z/l1s1iubAF92LNani7LBkg1ZzJuVUZrU4IX195xsBvKmGHwL6dxI
	 g3PG5ueJCmocg==
Date: Sat, 13 Jul 2024 15:35:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Breno
 Leitao <leitao@debian.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 Madalin Bucur <madalin.bucur@nxp.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 2/5] net: dpaa: eliminate NR_CPUS dependency in
 egress_fqs[] and conf_fqs[]
Message-ID: <20240713153532.28bf1320@kernel.org>
In-Reply-To: <20240710230025.46487-3-vladimir.oltean@nxp.com>
References: <20240710230025.46487-1-vladimir.oltean@nxp.com>
	<20240710230025.46487-3-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 02:00:22 +0300 Vladimir Oltean wrote:
> +	priv->egress_fqs = devm_kcalloc(dev, dpaa_max_num_txqs(),
> +					sizeof(*priv->egress_fqs),
> +					GFP_KERNEL);
> +	if (!priv->egress_fqs)
> +		goto free_netdev;
> +
> +	priv->conf_fqs = devm_kcalloc(dev, dpaa_max_num_txqs(),
> +				      sizeof(*priv->conf_fqs),
> +				      GFP_KERNEL);
> +	if (!priv->conf_fqs)
> +		goto free_netdev;

Gotta set err before jumping
-- 
pw-bot: cr

