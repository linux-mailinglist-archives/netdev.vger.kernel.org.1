Return-Path: <netdev+bounces-145013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2D29C9175
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 19:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2D01F224F9
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 18:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6643C193408;
	Thu, 14 Nov 2024 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qROsG/9l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406FF191F83
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731607901; cv=none; b=bozfYVa2E9+8QD5QWwHxJzRn2yMXNehOV7Il1EU0p96pq+uYpCrqC2cg9lvBklMGhDIxf/Js64xQHLs+QMPB5ZctM8VhLJPx6GZTK9/aetj92urJ4YRTQUA4DZH8LDgyu3b313C6FtBnMDUJmdO/Qh+f49HJbcfORT79UPP+gXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731607901; c=relaxed/simple;
	bh=ajy/0DMCfNdEpyl4vjxYhDIuB7dsR4Hh+h3UbtvYAyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUaV7TzvKNkif9DXknYYieFCfTghIJZvyg0GqJl6oZECmZhH0FT639gn3NvuyY44lQWtwZEVlIFr/6AUE/m3KcWqFB27uYLnHH4gARt6uAceMzsVQdTxXV24i6BC1RkbJX64S6OqIMQ1mBmy0MF85Y1JuyH2aw1n8JtT6G8llMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qROsG/9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C668C4CED7;
	Thu, 14 Nov 2024 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731607901;
	bh=ajy/0DMCfNdEpyl4vjxYhDIuB7dsR4Hh+h3UbtvYAyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qROsG/9lNvoOLdXbQeSBV+ESytrtBRX3F3k03g2vwXO5TBWYSITuNT2hC1NDi7wEC
	 otFPSivn3IklZGP7i9UN2JI0rNVk/BkO63n3vBQDrpNXDfs8GAXOPFBaRau09uJHHH
	 LsGjC9vMJi2wINeQkIiy2ZkDTN3gLLOvrlXM9jpoCvPpS8gAx66pe2wI3CL38KQn6O
	 0YNn+ejcrM+3YHqBfdOF66DL4Ty9mZHgKklrRwj2fZjPyWiKvIUVa7d5R0R3BqvQn/
	 8p1XnnW7kRYL5fod9PvXs+lYBzEUyiXPsHR/zYByK2PzXOFrMuKaV7q7QNDkvllKXz
	 LsArhTG12pyaw==
Date: Thu, 14 Nov 2024 18:11:38 +0000
From: Simon Horman <horms@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH ipsec-next] xfrm: Fix acquire state insertion.
Message-ID: <20241114181138.GB1062410@kernel.org>
References: <ZzXZ0BaL9ypZ1ilY@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzXZ0BaL9ypZ1ilY@gauss3.secunet.de>

On Thu, Nov 14, 2024 at 12:06:56PM +0100, Steffen Klassert wrote:
> A recent commit jumped over the dst hash computation and
> left the symbol uninitialized. Fix this by explicitly
> computing the dst hash before it is used.
> 
> Fixes: 0045e3d80613 ("xfrm: Cache used outbound xfrm states at the policy.")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

Reviewed-by: Simon Horman <horms@kernel.org>

