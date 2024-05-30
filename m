Return-Path: <netdev+bounces-99268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C478D440A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 05:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76CF28789C
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60D7502B1;
	Thu, 30 May 2024 03:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf9/8G/6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11C5256A
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 03:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717039452; cv=none; b=PWLHeZSlJR95ZnpVvJEyrpcWy+mmXYRfr9JEx0haHXkPN4fCbM8p3d846XhTZ9CE/38ti2adi2fCgReVqqoJmj4pDaY9NiuJP8RB0qZqDZDrc5UUboio6ZyyydlAMBqAtN1oGRT8SeIz/vaSCopuvcG4S9BtEetVzKZhWh95CQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717039452; c=relaxed/simple;
	bh=EqPgvQD3bgaunDTxkmnWs3KDpSk166V11kpz35S51hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqbto8uwmSI01x2/RfErbnQn0/fRD+JnjcgRxMZ9ungZsRFymW+TWKsHQqDQaFA2BJgyp+NphU1rNZ6gMQIXI13ot909DhsblZdLu6XMObtJKKP9ItB7JFwCOYCXhVf/ig59iA2hUeiBAP20XHffxkgeHN6aKzSAl/xBgZwNBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf9/8G/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F34C32782;
	Thu, 30 May 2024 03:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717039452;
	bh=EqPgvQD3bgaunDTxkmnWs3KDpSk166V11kpz35S51hU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nf9/8G/6VgXxTDU0a2mg1UwIeiO+7Chnab9WF8Lnt34v0O9JPCJjSASYNw05/oKw1
	 g649T7/Wa+cUH5SBNCVd9CL8EheJeIJIjINtue/XYKXdOP7fKMUNeiXcV8rAoKe7fs
	 0NABDVn6V9AUngLrT/H60Elpkj6MqjGU3C3pXtGjGoSvBc0JtojxCbZlqj+MhVlW84
	 HJ+fzj57+TgkR0/zv7IaBEZOOrxFf1mhQhUaYDf1uMuwbn/7NQMCThB86VfcbFzF/I
	 9IDOSgwrQ4lw2SzbJfYz9+ZnNEza7/VD7dbVnvkzJKSqfVPfnv/E/DnNLATqn7bN0m
	 JMvJFXnSItBsw==
Date: Wed, 29 May 2024 20:24:10 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next 02/15] net/mlx5e: SHAMPO, Fix incorrect page
 release
Message-ID: <ZlfxWrWUtFs8USej@x130.lan>
References: <20240528142807.903965-1-tariqt@nvidia.com>
 <20240528142807.903965-3-tariqt@nvidia.com>
 <20240529181220.4a5dc08b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240529181220.4a5dc08b@kernel.org>

On 29 May 18:12, Jakub Kicinski wrote:
>On Tue, 28 May 2024 17:27:54 +0300 Tariq Toukan wrote:
>> Fixes: 6f5742846053 ("net/mlx5e: RX, Enable skb page recycling through the page_pool")
>
>Sounds like a bug fix, why net-next?
>

This only affects HW GRO which you couldn't enable before this series.

