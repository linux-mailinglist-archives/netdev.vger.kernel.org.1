Return-Path: <netdev+bounces-70594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B01D084FAD6
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 18:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E201C266B7
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 17:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD8A7BAF7;
	Fri,  9 Feb 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFZ9nEEa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276AF7BAF4
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 17:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498958; cv=none; b=krlatVi5KaE15wPTfv/iQJ2N2dIioieMBDb6jko6LNCIzxOthPA5+X0BXG6u1aSCMiKtcTt2KeBgWqr0P7KVtvCRUCDNuf2n+z2qz3pnJQ0IpU0RFxZkirseVy9fo7h9ccDt6JKOdBZe7YcLPNNMKbe6wU9gMFRAW0IfkkhjA4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498958; c=relaxed/simple;
	bh=nfyUo80qI42Kcan7DmQ6iEXtdTmcAtNUkBQEY7xI2Vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qB6l1Q865ZUt5LsqL+6N5ReNUMPi7yDc0Nzo4fPlaJDB+sJzCy9nRMhl2Vg6zaVwhrxD8D7EMYMYat64hT/0NGycq4TaFunc60h9+yupBTlrBIz7Hdga/Zy8jW/2r4wZQk2Lccg27itOgTxWiyQ1lNsuayrOzAEk5K2P5oH0+co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFZ9nEEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE0CC433C7;
	Fri,  9 Feb 2024 17:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707498957;
	bh=nfyUo80qI42Kcan7DmQ6iEXtdTmcAtNUkBQEY7xI2Vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JFZ9nEEa7/vc3DgDI7gGEPMvxf6uRPwb6I3veepiuIjuIJs5soHpeZh1DzI+ERHWw
	 fsPOqWq1wNsGQyCfAEyDY6+9RWO9Bnwco/D+GD7I9zlYj6me2/hFIqSAFoLxMWGFoA
	 uSBQ4h5SPmRjoQfTtNpTQg/WBVmYrsr1xpTfTr1i8I2dcwiCoGtA1W0dxeZm1+8ZVz
	 sP9iLzcXqcOy9AgyoLxrVJcgwrQR0w7wAHaKXTElsjUdG5ZUeZlxTIHM1GvE+aLqvo
	 TX98gUw5rolrE5BRRIxYV2W7yerfR3UwSkjTtTvHguI4gmRekYm13cBzWU/F8XKT1u
	 xT4uCqTpoK/7w==
Date: Fri, 9 Feb 2024 17:15:53 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Naman Gulati <namangulati@google.com>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net 3/3] net-device: move lstats in net_device_read_txrx
Message-ID: <20240209171553.GE1533412@kernel.org>
References: <20240208144323.1248887-1-edumazet@google.com>
 <20240208144323.1248887-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208144323.1248887-4-edumazet@google.com>

On Thu, Feb 08, 2024 at 02:43:23PM +0000, Eric Dumazet wrote:
> dev->lstats is notably used from loopback ndo_start_xmit()
> and other virtual drivers.
> 
> Per cpu stats updates are dirtying per-cpu data,
> but the pointer itself is read-only.
> 
> Fixes: 43a71cd66b9c ("net-device: reorganize net_device fast path variables")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Coco Li <lixiaoyan@google.com>
> Cc: Simon Horman <horms@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


