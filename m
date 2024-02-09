Return-Path: <netdev+bounces-70470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA16784F23E
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99931C22ADA
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 09:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FE966B55;
	Fri,  9 Feb 2024 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZI+jILH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E14667E60
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707470694; cv=none; b=d4MK9oK0NuKUgsifQan5zhCAcU2siC2dS2OesEh8Hxt05B69Q1Mw3rKqg83P5DI9AWQJS8/7QcgHkcXC9T+G8ZmjjC1/lPWKzeBVy2GHM0TFxzbeC29HICjn2GjBhPTApYJpIWf2lY9tv3FLAoCOW4sO5tLzPBxABUT2g4XMIaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707470694; c=relaxed/simple;
	bh=7vVvUu5TIK6TdR3/escfiBNRu8Rtp+wjm8JvZLOY1F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beTJJIUWRutdobqxduxeQDYOHqESap4KjMyAGyE6WidTYopJ2ELuzga5m8TDlnPJr1WENEqKD95y3DC5avq+5EcycHLNFip/OL73NvWv2jabCMD8g8Gc0KHr+rogi34L/KMasPN0us22HVJRIplKiF3mC2gmr5tYX5Wi3lAN2OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZI+jILH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43AFC433F1;
	Fri,  9 Feb 2024 09:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707470694;
	bh=7vVvUu5TIK6TdR3/escfiBNRu8Rtp+wjm8JvZLOY1F4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fZI+jILHxE1+uwfgl1sAdritqpDVmQAIPE4lPGEZVkZ/IT05nbeLUzQynK2b6vC2M
	 V9op/1ZSk3fhjJT5PABlaxeao9RTdhjPBG9VgYoCms4uv8RqoOXZsTqa9XvMkGpZ6Z
	 9N/v8zmwtAa0CcfV//7SG8MFMefYblIpyU4dv+/d/NXBbpvBUB23kwbFvA38Hi7x/b
	 WzSn0PRTdgEqqakh5W8XhidhQ2sirgDlJT+dF3E7M71ELpvtOfqfk8XHrIHqTPqvEb
	 X/grfhAHzXjfBJLKITTXZe+1SEWXHmVkLmzTwi0QkSCw5O9Q+qJ4Dx1okwUTfSfdcC
	 fhgYIzzRzAoMQ==
Date: Fri, 9 Feb 2024 09:24:49 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, sd@queasysnail.net, vadim.fedorenko@linux.dev,
	valis <sec@valis.email>, borisp@nvidia.com,
	john.fastabend@gmail.com, vakul.garg@nxp.com
Subject: Re: [PATCH net 3/7] tls: fix race between tx work scheduling and
 socket close
Message-ID: <20240209092449.GP1435458@kernel.org>
References: <20240207011824.2609030-1-kuba@kernel.org>
 <20240207011824.2609030-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207011824.2609030-4-kuba@kernel.org>

On Tue, Feb 06, 2024 at 05:18:20PM -0800, Jakub Kicinski wrote:
> Similarly to previous commit, the submitting thread (recvmsg/sendmsg)
> may exit as soon as the async crypto handler calls complete().
> Reorder scheduling the work before calling complete().
> This seems more logical in the first place, as it's
> the inverse order of what the submitting thread will do.
> 
> Reported-by: valis <sec@valis.email>
> Fixes: a42055e8d2c3 ("net/tls: Add support for async encryption of records for performance")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


