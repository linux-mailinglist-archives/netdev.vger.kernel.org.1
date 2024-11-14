Return-Path: <netdev+bounces-144948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 130649C8D89
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDEFB1F246EC
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391CC7DA66;
	Thu, 14 Nov 2024 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osFdQlLd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103AF1E521;
	Thu, 14 Nov 2024 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596590; cv=none; b=SiiPbzznEJwgsNGoEVgdQbXroP+fSAYJujckQIBiG/lrE5elUe5VpcIj7CaMxVRsUhgkszOT+X9p7LUYFIgZ9DdrLVgfhdngPazA/bOWTRvfTeaSnSsw2g/F1scdlQxeOj9s+JHNiwdApiNuqSg97sH8/d29hb4nrrh12EISk7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596590; c=relaxed/simple;
	bh=BsYcovQdRC1h0DdNzlfc6JaWZH38UXOZmf3UeEbmyK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otcbLpOzBcLde7qhGdMCOPDl9cya4SBr6t7yiojAZ8azIfisgBhcBf/K9ZCwe5VyPznUZCYhfOwfjOUN72C3yV9Ink4fxMUFVoZTi6+tgqd9NoiL52XnLwWn/wjuuthbgHpEVJcBxsId4jW/B3oH1Lc8kmDNsj/gBtIgll0xN8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osFdQlLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD42C4CECD;
	Thu, 14 Nov 2024 15:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731596589;
	bh=BsYcovQdRC1h0DdNzlfc6JaWZH38UXOZmf3UeEbmyK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=osFdQlLdTLNZDDz8qcYxE0pksuKJf+MsPBZ9dfcAB47ehzDwF/NIHeOQtIPWfsKuf
	 6qMJfW+hjFp0R86JNn4LD4D/Nj3AaVxoTiDZpGCvMlIZ7GCRxGQuFLYIRkNFC6yiDe
	 HllX0q44mYgUnuC2FLy4aBEEnZSA41mnUM8Wmm4hfYPoi7POINFoFiGoc7wvaX9HCq
	 MybdfGuqzdxCK0nOgSznlmWcNYnazTr2mbGsBBeCNnvTYc6JvMMSLg4LsOIjlxax/h
	 mKW5phHgvP+Jxpv4DvShW9Kbs29YC9AF1H6Ne/mJ6jwzaU/YHqlYZY9RRZp8L9+VRG
	 s4QL31zLqU6aA==
Date: Thu, 14 Nov 2024 07:03:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH net v2] ipmr: Fix access to mfc_cache_list without lock
 held
Message-ID: <20241114070308.79021413@kernel.org>
In-Reply-To: <20241114-ancient-piquant-ibex-28a70b@leitao>
References: <20241108-ipmr_rcu-v2-1-c718998e209b@debian.org>
	<20241113191023.401fad6b@kernel.org>
	<20241114-ancient-piquant-ibex-28a70b@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 00:55:57 -0800 Breno Leitao wrote:
> On Wed, Nov 13, 2024 at 07:10:23PM -0800, Jakub Kicinski wrote:
> > On Fri, 08 Nov 2024 06:08:36 -0800 Breno Leitao wrote:  
> > > Accessing `mr_table->mfc_cache_list` is protected by an RCU lock. In the
> > > following code flow, the RCU read lock is not held, causing the
> > > following error when `RCU_PROVE` is not held. The same problem might
> > > show up in the IPv6 code path.  
> > 
> > good start, I hope someone can fix the gazillion warnings the CI 
> > is hitting on the table accesses :)  
> 
> If you have an updated list, I'd be happy to take a look.
> 
> Last time, all the problems I found were being discussed upstream
> already. I am wondering if they didn't land upstream, or, if you have
> warnings that are not being currently fixed.

https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/859762/82-router-multicast-sh/stderr

