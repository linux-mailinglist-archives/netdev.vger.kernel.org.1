Return-Path: <netdev+bounces-163223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34594A299D1
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 20:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78851610DE
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 19:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6EA1FF1DE;
	Wed,  5 Feb 2025 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8xtDMsV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF45C1FF1BA
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 19:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782662; cv=none; b=tPXv3HxRIzTQRdbpoHPIQTJD8q5HtEpRje+/kCjKovtwO6583N8q0mG3brPOP31PL83fbsJ4lRXgtSFlFtl1LblPC2gbLSPle4j3QohAv3nVUGZZoHFmLerq+EVqk90HMcCf0fdwKpkf1OVzBMqcyTYMp3qgmhfLnahbidrWRx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782662; c=relaxed/simple;
	bh=AeqGAHzRk96rJf580MaMjQyCrRl8lSpqykqzKM+VYaA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMcus3SeKosNkgWiwgUd3NZJkS566Q2uRkZhTAsR/ZfA8r7HCqeiaPvWsZ6DKwDB+h6m5yKHmmoefd5rvkS5aE9saXTIiU/oVCCImL8qeFF1Kpw2mb/6qyZEM05OicZ2WrzSxkcTtdYxtAG5pvjc2OVfEHNMrxzZHyD7E36giOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8xtDMsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1621FC4CED1;
	Wed,  5 Feb 2025 19:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738782661;
	bh=AeqGAHzRk96rJf580MaMjQyCrRl8lSpqykqzKM+VYaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o8xtDMsVSkmvCK7HKAjPlygQI20kwqni4tPce8EZBClNBQJ5IINRP8uCx+tjCk3fs
	 C6rQDTk5b5wO0F+0/9MjThQQ4+FXRz8rmzozSaQedmu8o4CGE88yvsO8zPjOwE5eN8
	 lDDAm+1Gwpm16QSLRV3robgpZ4kWrv7xUFh+u9VYQN2dm/qZEtMWF8PkIwxKXxvllL
	 cBl0EhXMfkYSTgm2FbC6rWawflXe5Dxq44R2Mx4GoV1F5TwJ75IfJaVguzAnGRkoC2
	 Pid5uVugqkrF9rIuPIsuHVX1npDyClArJwZsEnMXOnNN/DlTVx/G290FlnoAoUTVU/
	 CHT2d7oLXOAEA==
Date: Wed, 5 Feb 2025 11:11:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@idosch.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 tariqt@nvidia.com, hawk@kernel.org
Subject: Re: [PATCH net-next 4/4] eth: mlx4: use the page pool for Rx
 buffers
Message-ID: <20250205111100.4ba5b56f@kernel.org>
In-Reply-To: <Z6OoZwJ-REpisYb6@shredder>
References: <20250205031213.358973-1-kuba@kernel.org>
	<20250205031213.358973-5-kuba@kernel.org>
	<Z6OoZwJ-REpisYb6@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 20:05:27 +0200 Ido Schimmel wrote:
> On Tue, Feb 04, 2025 at 07:12:13PM -0800, Jakub Kicinski wrote:
> > @@ -283,6 +265,7 @@ int mlx4_en_create_rx_ring(struct mlx4_en_priv *priv,
> >  	pp.netdev = priv->dev;
> >  	pp.dev = &mdev->dev->persist->pdev->dev;
> >  	pp.dma_dir = DMA_BIDIRECTIONAL;
> > +	pp.max_len = PAGE_SIZE;  
> 
> Possibly a stupid question, but can you explain this hunk given patch #1
> does not set 'PP_FLAG_DMA_SYNC_DEV' ?

Not sure, I wrote this a while back, I probably left this here 
"for future self", when sync support is added. To remember that
since we still do the page flipping thing we must sync the entire
page, even if MTU is smaller. It's a common source of bugs.

