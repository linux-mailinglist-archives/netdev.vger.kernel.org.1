Return-Path: <netdev+bounces-178097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D5CA74983
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 12:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46D13BF1D2
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 11:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC8E2192FC;
	Fri, 28 Mar 2025 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtpikPw6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B289213E7D
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743162699; cv=none; b=G/yygmUG9vOugX34ECjyhP/UeDdmlyL1gWhu/SnBjXSU39+xYPYUdt3TQEpOWBHIPMkKC+c+KXwyon08koh8+AGUMR4xHzpRMyAR4GBH6Q2tBFUT8rVuP+AR8EZnM/hNS6dpvYlLWuwkjz9DH3IubLkHjv3EgOlTwGGP6iy4KTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743162699; c=relaxed/simple;
	bh=MVH5EuCt00aXD/uHtRbXKmk5SpPnle7FziGF2MoENTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EpAZbIPpyQBOw2Obepf6NQU+Is3EjIQbHUWF6xdUjLYH/v2yZdBQIVpkWfD8zD2okAKVdvyAzaAVyxj7bEWD7LgMfYPcqncC4fUw72M/9gbiXGk2TzC+NgIY5fvi70COW6RtIMqxQqxG291iig/6iw1gctVDlHzAlWzua2MBaOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtpikPw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5BFC4CEE4;
	Fri, 28 Mar 2025 11:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743162698;
	bh=MVH5EuCt00aXD/uHtRbXKmk5SpPnle7FziGF2MoENTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NtpikPw6W3SVPGsBrEvfqwRQoMM5k8Cv0Ug9ME0/6sxdJvPUmAfyxDU2Wpz5Lcbke
	 IJIR3QhNy26Cwh+O6YYEP1TQQS7PL6vHXcpmLQB3+UzVXLo5SaXfWa8YK3Mxm61IWl
	 634NyApAPO2aKUE5L/QLEpZpK+d/KFDFr/xTJ0U7mxPx3AQOxTAu1jPZkNC3SuCYZG
	 bCyZJPeZ2kHmtsC8KHthDuHuhXounvxIkYMx+/TDORxtyREew/nsNz1pAOLE42Ypva
	 MIlWM2VP8XEmP4syFtnRmR7G8MHSLfjaGIpUa7H5u5aOF7G1fnkNeKDZfCPyQuvY78
	 UxfJhmx0fyyjA==
Date: Fri, 28 Mar 2025 04:51:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 jdamato@fastly.com, sdf@fomichev.me, almasrymina@google.com,
 xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net] net: fix use-after-free in the
 netdev_nl_sock_priv_destroy()
Message-ID: <20250328045137.0730fc6c@kernel.org>
In-Reply-To: <20250328062237.3746875-1-ap420073@gmail.com>
References: <20250328062237.3746875-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Mar 2025 06:22:37 +0000 Taehee Yoo wrote:
> In the netdev_nl_sock_priv_destroy(), an instance lock is acquired
> before calling net_devmem_unbind_dmabuf(), then releasing an instance
> lock(netdev_unlock(binding->dev)).
> However, a binding is freed in the net_devmem_unbind_dmabuf().
> So using a binding after net_devmem_unbind_dmabuf() occurs UAF.
> To fix this UAF, it needs to use temporary variable.
> 
> Fixes: ba6f418fbf64 ("net: bubble up taking netdev instance lock to callers of net_devmem_unbind_dmabuf()")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

