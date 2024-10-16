Return-Path: <netdev+bounces-136053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558BC9A023A
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160C7285703
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 07:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBB218C351;
	Wed, 16 Oct 2024 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+SaTTf9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46465189B91;
	Wed, 16 Oct 2024 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729062923; cv=none; b=E0hPqhVRGWJ1pUxtMnmChzQ11vQRns3KLEP1rWHddQIrTM3/qA1s7HP+f6U9+9fczYPuFz1vxOfdFLNrU3yCLnUBbKgCIDEnxsXDur5UgEYH5nSUne9Ax7t/D+e/D95FmB/E2oskzY1v15i7jGJpRfgg14HsKiX6bttQ0egrSsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729062923; c=relaxed/simple;
	bh=KmpHGPpckMlLOw+STBz++93cljXfi7PKSyMU0WApqbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7bujL4yeMPUrMk6Ma/GmHXCWit/vieK9rxBKfg1exYQyJgZDHaEQUFz9IaEmKrYpTxU2TTySd2EOdC9McZ5cF3Xy3ID1KFE19/PkyXzCjiCKROE44IprDEO7owTIUmINU+w8ibbseOrnEjDsPdpEw+AzOvvatfu9uk/8TD1w8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+SaTTf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65B2C4CEC5;
	Wed, 16 Oct 2024 07:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729062922;
	bh=KmpHGPpckMlLOw+STBz++93cljXfi7PKSyMU0WApqbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n+SaTTf9i1WXM5tHdoxVgXnO0NtDT8QhYV1UIu4M1OU1AuvUl3ecy5mWszBxFsqMQ
	 zhBOucEIA4CVsCCgn5AwoZA44+IkN4ZyTb9SLiwduIcy1xnQyc0LpTmFDzCdUz6DnT
	 OlLXNAAtOmStdk2prcEa44IKYteOU7i02ohibxj+iykk1/EcwCNWffU3PJCeHjKxrC
	 7yIbtkSPw9jRHHOvJZlvlJfEpfYrDN7JXfVZ66IxE0iUBmeF3hntU0SM2RRFH6Zjkq
	 O+QZBNTDkDM4Ve22T8jFzyF1RelJfzb79La0K3rOtSv5LUFW32RnE9V11LsyTyi+D1
	 hfYc6GIGozQWQ==
Date: Wed, 16 Oct 2024 08:14:48 +0100
From: Simon Horman <horms@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: wwan: fix global oob in wwan_rtnl_policy
Message-ID: <20241016071448.GC2162@kernel.org>
References: <20241015131621.47503-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015131621.47503-1-linma@zju.edu.cn>

On Tue, Oct 15, 2024 at 09:16:21PM +0800, Lin Ma wrote:
> The variable wwan_rtnl_link_ops assign a *bigger* maxtype which leads to
> a global out-of-bounds read when parsing the netlink attributes. Exactly
> same bug cause as the oob fixed in commit b33fb5b801c6 ("net: qualcomm:
> rmnet: fix global oob in rmnet_policy").
> 
> ==================================================================
> BUG: KASAN: global-out-of-bounds in validate_nla lib/nlattr.c:388 [inline]
> BUG: KASAN: global-out-of-bounds in __nla_validate_parse+0x19d7/0x29a0 lib/nlattr.c:603
> Read of size 1 at addr ffffffff8b09cb60 by task syz.1.66276/323862

...

> According to the comment of `nla_parse_nested_deprecated`, use correct size
> `IFLA_WWAN_MAX` here to fix this issue.
> 
> Fixes: 88b710532e53 ("wwan: add interface creation support")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


