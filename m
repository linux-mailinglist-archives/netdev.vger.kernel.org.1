Return-Path: <netdev+bounces-131225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2483498D631
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF9441F22AE9
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27F51D0780;
	Wed,  2 Oct 2024 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlOdNzsf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4B01D0173;
	Wed,  2 Oct 2024 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876234; cv=none; b=WUk4oHTnxLWnaGFRZXPRle4gBIhfj+EhbAo+wkfignqAmP483EXhlEi4QHdlKqgepk8sY2h/nT8LKqCrWv5xON9I7wu3UM5//u3GUp25cKXUl0n39ZEGtnzbccZ/YaXwnGQFmFGKQzGsboVfBNiVs42JJWVRYQq/vaBRmwHoBqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876234; c=relaxed/simple;
	bh=kMjd07tgy5sd0BZAnwy0Z+W8j7avodeosBIponWnJPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBrBEdiGQeq6JOzTYSlYIbnqp1S7x954wUQuB8olQv+217aDlaqBX5SiaB+jqyhSoi5g9/Me+lHujAEuZGhWDvCImt0ulAwKaGtE0owYiydVuF19vqSCJM5oUXyDfkDhlyI8loSXmpt4K//jtdvMzvundF76FpzgkrkKSTIx36c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlOdNzsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48AAC4CEC5;
	Wed,  2 Oct 2024 13:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727876234;
	bh=kMjd07tgy5sd0BZAnwy0Z+W8j7avodeosBIponWnJPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SlOdNzsfCJ5U0Y6f8op+Tfva0ZHx38sHhuVPg6WQo04encSMQQKKvhI/giS253G/2
	 AGs+MebuA92Ecm/ckcR0tCLIU7J7lkXSjv3zI46Ap5ecmN7gJNhBmBoWfNKb0k3y2L
	 Z0xfGVkpTxIMyhw2NpRc0i+DPpC9K379GHEnh0sndLrd0hACyrtfxG/Q8xNXTIP9uF
	 2NjpQGPSYgRVFuMsXAEXYlt+5C/FfNsiQxzKOCpB/lfKuw9czgG8G5MSk+Rwj9sgXd
	 p42JhVYVE/S9QSy7jzl67KX/736RR3/LlcUtuGMrk1U+emk0hsAxsXKRZXIn0HVYNz
	 IaYN4GElM23tA==
Date: Wed, 2 Oct 2024 14:37:04 +0100
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 02/12] net: tunnel: add
 pskb_inet_may_pull_reason() helper
Message-ID: <20241002133704.GY1310185@kernel.org>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
 <20241001073225.807419-3-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001073225.807419-3-dongml2@chinatelecom.cn>

On Tue, Oct 01, 2024 at 03:32:15PM +0800, Menglong Dong wrote:
> Introduce the function pskb_inet_may_pull_reason() and make
> pskb_inet_may_pull a simple inline call to it. The drop reasons of it just
> come from pskb_may_pull_reason().
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


