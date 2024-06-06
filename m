Return-Path: <netdev+bounces-101518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3BC8FF276
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 18:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91ADA1C25F5E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FD619642A;
	Thu,  6 Jun 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJuVXrKH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD74826AED;
	Thu,  6 Jun 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691239; cv=none; b=A5tXEF52+Y6VDlynpO+NU0iw2/nxdEu9joCX3qUYo3C/uM3m67pC5IQCyEE72zvaUJmx76yh7Z1r7QLIPUVhtOHJ4xCVyRgQNnTz+6HYz9QDybmW9gE7SIc98/lZ59JDVvhciiNGhkGIMNqp41FmHo86ieL7+w3f8LHuHWcDsMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691239; c=relaxed/simple;
	bh=6VICEBA+N+C44oFl2sfagYtTaeVv9T6hSa3ovrDQ06w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxTZ4elHHIjZ4HdP1q6L2W8kk28rCMPZBqo9iZvD7PMJk/BqeofyxT6QwXaiamuyi9DFw9F/WVoDE4boziT226E/yFW+uiqwHXD2SicT986lbDNgy1oO6EKGRY3eziQlwiejj+oTu2Img0PWFy8BDzW91kpwUWIOSF6xS4YZmpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJuVXrKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6A8C2BD10;
	Thu,  6 Jun 2024 16:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717691239;
	bh=6VICEBA+N+C44oFl2sfagYtTaeVv9T6hSa3ovrDQ06w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJuVXrKH1Z77lg0LTOl/7x4pd87ipJUtEp0dJ3Ub1iNbRyrxlP7J+mSekcyqxCwPp
	 qdi3iuLdUyx5Js1XPZVKibe7ff1ueZISw5vBetcmgwGcs75E6hSArqzz+Fy8+UN9yg
	 fh0U2VpofJhe+ynMCY4lDHOGNnXezIOVTwEo8qIXS9yZEYI8Lr3kywJYH3II13vE8S
	 vodypQM4e9qK2O302wEYxzDL9mgPYLdZlgecMhcE/7/dTg7+Gy9XmNA+PRc/lWF2ic
	 N5qP5T+Ao1l801gQr6aePJmSU9ikKGLuS+957VETT3RH6x4a31HTsJQO+tv8vmAlTi
	 RogrcSv4qY44Q==
Date: Thu, 6 Jun 2024 17:27:14 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: hns3: add cond_resched() to hns3 ring
 buffer init process
Message-ID: <20240606162714.GN791188@kernel.org>
References: <20240605072058.2027992-1-shaojijie@huawei.com>
 <20240605072058.2027992-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605072058.2027992-3-shaojijie@huawei.com>

On Wed, Jun 05, 2024 at 03:20:58PM +0800, Jijie Shao wrote:
> From: Jie Wang <wangjie125@huawei.com>
> 
> Currently hns3 ring buffer init process would hold cpu too long with big
> Tx/Rx ring depth. This could cause soft lockup.
> 
> So this patch adds cond_resched() to the process. Then cpu can break to
> run other tasks instead of busy looping.
> 
> Fixes: a723fb8efe29 ("net: hns3: refine for set ring parameters")
> Signed-off-by: Jie Wang <wangjie125@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


