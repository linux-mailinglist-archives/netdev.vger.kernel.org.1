Return-Path: <netdev+bounces-82961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDE68904E4
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 17:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475342909A9
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFAA8288C;
	Thu, 28 Mar 2024 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGgb4xOC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF7154773
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642895; cv=none; b=MCS21OoKpOFI/w6937RJUnX7gTzYI4ahMhvAX76LieEqRKI5vqoGJPL9CDoRZw59VgQAVjvUoLIv6ajgAGaLXuud0+rKaL8AEWgURJiMFBtdWnFhyjqnAOdgx7C3ny3ASBCj6WKrWS6n2rlZszwM40CASP2qAINdCAyHSOLAMWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642895; c=relaxed/simple;
	bh=ZGbWzrmV77/4nkqUKgQSxwPGvhVeKblIbHnt9BHMivc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOgp1r06SkJP7/ER1+D8EX0xRo9lWd5z9Wcu98EQd0ouJEz9m2zhr7ftY6CvJG5psk6quzrOz6lrm1YK5Wqyw0H9Io0qM+iDzDHxy88fsSb0zuNEDuzEZ9j9kWVzRcVbHwD3EVsRGZTwJwxW/uRhwkhMtPMGCEA/bDmLx3y3qK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGgb4xOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC398C433C7;
	Thu, 28 Mar 2024 16:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711642894;
	bh=ZGbWzrmV77/4nkqUKgQSxwPGvhVeKblIbHnt9BHMivc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iGgb4xOCqgtukj4SvN0SvbuPt6ebsDT89RN0tgOANCThRD2IS3TrwtBiktza/Z6hK
	 BwDEJWXz/XFdFAPLnQKjm4ve0UOYLnwTkw44AFt9N7KhoGVOdKFIbgn2JoMeGoecUV
	 MQgW8f+dtSgPdjfBq27bFw3fiwxHwT1zJiTgEqEqCQynkKixrX3+O1BAlCxPXRO22/
	 YN8RknCtjM+c5GIwJ6XRpQwJvWP281VRa3xbUDtv83uPG92EgxSC9EMt9x7FBMznx9
	 HQch84txvTyM5y5Ld/rYHLgclaIgFR4OHdjNVsIpxuNVAkcl2JuaFA01TJDL+GOjjD
	 Y1TqMw+3zNlkA==
Date: Thu, 28 Mar 2024 09:21:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Aya Levin
 <ayal@nvidia.com>
Subject: Re: [PATCH net-next 5/8] net/mlx5e: Expose the VF/SF RX drop
 counter on the representor
Message-ID: <20240328092132.47877242@kernel.org>
In-Reply-To: <20240328111831.GA403975@kernel.org>
References: <20240326222022.27926-1-tariqt@nvidia.com>
	<20240326222022.27926-6-tariqt@nvidia.com>
	<20240328111831.GA403975@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 11:18:31 +0000 Simon Horman wrote:
> > The "rx_vport_out_of_buffer" equals the sum of all
> > Q counters out_of_buffer values allocated on the VF/SF.  
> 
> Hi Carolina and Tariq,
> 
> I am wondering if any consideration was given to making this
> a generic counter. Buffer exhaustion sounds like something that
> other NICs may report too.

I think it's basically rx_missed_errors from rtnl_link_stats64.
mlx5 doesn't currently report it at all, AFAICT.

