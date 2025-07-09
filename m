Return-Path: <netdev+bounces-205524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27706AFF132
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 20:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78615567DA5
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 18:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC6023BCEB;
	Wed,  9 Jul 2025 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9L3tMLA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A44F2367D7
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087264; cv=none; b=OE5ZZmwohith6GgHXCb3OzkeCiAQrvdsAOEtfvNFSE+tM7w7Zc9bwEuGqpGSM+blSeY9fJgMUehh/NJqakn+xG+FWoDtGWte+iMCGKFsTHvqE9W7V69QWeM6BhegiM672CjyRjvaEzNs+UFvVOFqi6Q/kuySKFFoyWGUn59rJfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087264; c=relaxed/simple;
	bh=qFhkbva89UGSm8lgYPCTFFYoMPQ1oQ2EI5cB/u0VAWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXUwf53v/bu1p/inJXCB4YK3GRMkX7ORGuMRMGNpZW8L5yN2ZG4PSD42Y9Hwal7r73G5gp8oGfyEAzx6vlxryIJijbJFOOIEpPhRmt/JYEnqcT7jFRFrWWD3ub/L/Hz7RKElgD7L3MbRu+knyuJoZZoDA4+tnhtXLk+ti4On3Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9L3tMLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B819C4CEEF;
	Wed,  9 Jul 2025 18:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752087263;
	bh=qFhkbva89UGSm8lgYPCTFFYoMPQ1oQ2EI5cB/u0VAWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V9L3tMLAOu3yfaYo13TETHvD1W1/4Nr4mpA1YHSr1f2Ho8qGAngbzK7OKxEMrr/R2
	 BMPsCXKYY4rk4ovBS4b6OPW3kwTi/8UypDC2G4NukVWjf97qGvix7rBvaItgcEr8Kp
	 3SN8GT9M3sak58HbRqu8J4DJkRC0hHAnddf460CZxefqZh5yOEMeDYVyMfetEp2utZ
	 cc0agdGDSqPGPfbex3FpQDRRkyjsUL9BmyFLTqBdKiVI7QRbPXu53SPZnSgKjw2ccg
	 IlAVCMojtO+w/w+/Q+/1Rfrqz7onJrCJneph/YKTmG/JiYDcRr8BSEGWmFqmsECbtc
	 yzmfLCdSjclcg==
Date: Wed, 9 Jul 2025 19:54:20 +0100
From: Simon Horman <horms@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net 1/3] atm: clip: Fix potential null-ptr-deref in
 to_atmarpd().
Message-ID: <20250709185420.GK721198@horms.kernel.org>
References: <20250704062416.1613927-1-kuniyu@google.com>
 <20250704062416.1613927-2-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704062416.1613927-2-kuniyu@google.com>

On Fri, Jul 04, 2025 at 06:23:51AM +0000, Kuniyuki Iwashima wrote:
> atmarpd is protected by RTNL since commit f3a0592b37b8 ("[ATM]: clip
> causes unregister hang").
> 
> However, it is not enough because to_atmarpd() is called without RTNL,
> especially clip_neigh_solicit() / neigh_ops->solicit() is unsleepable.
> 
> Also, there is no RTNL dependency around atmarpd.
> 
> Let's use a private mutex and RCU to protect access to atmarpd in
> to_atmarpd().
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v2: Add __rcu to silence Sparse

Reviewed-by: Simon Horman <horms@kernel.org>


