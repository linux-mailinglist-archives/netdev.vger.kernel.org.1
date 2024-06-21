Return-Path: <netdev+bounces-105491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9213891173D
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 02:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36761C212B6
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 00:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775A2394;
	Fri, 21 Jun 2024 00:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJ6F209+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5124B10E6
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 00:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718929358; cv=none; b=q5L7cu6wQam1ppwGuoiO9fI+IPU+bpp9GJFylcT/V1TcQOp3FppiifMknMIT8cCMZ8iLOpl1lhZCGWGZ8zFtZTP7nE3Tqq2ww6rVdRemPEXDNymEbuu/sDaJs6LoPq2pgYdT6eNv6piDVbgFyZiEW9NpInbZ4QF5EuTkegCe4ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718929358; c=relaxed/simple;
	bh=ba21dsT4CZN+f7KTvdOLqkGh6nZeS2PvC83gb5rzBz4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPK0/Cdc6q8Tv4ckMGxOSmxGemD5WIxzclzyEqU3e2He/IyC7O6LRx4vUZHd3skeVjTHbJ30C46IV+utoIoXX5JQWt7Z5Hurl5InfjCIVaZrCIa02WOWq+nlS1NZCK3cKIZcrqDDjDXQw6EgCjAKFyyLhI2KZbHFlSk4mVccTGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJ6F209+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676E8C2BD10;
	Fri, 21 Jun 2024 00:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718929356;
	bh=ba21dsT4CZN+f7KTvdOLqkGh6nZeS2PvC83gb5rzBz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pJ6F209+jUPVFn9yGC3dtPyU227mlqkBcyGUz2MkkoWzIb3JSGPZQ2sgkG7GrS/u6
	 Fgr+gIiQecws50syLlqkLjQ5CkTP1x8RNxSNHceMw4w6BmGTpq5INx5UtqRFOcsu+f
	 TGs60YsyIlHCLMNe9xJu4Puqorq7vrrEBJJtC7320byZeos5umd7nDbjrA30PB1n20
	 VI1E9SjggCiV7bsWRlYk4Pq7zyYxv6lwbfc6sFP2moLbpuPqZenkTDipMcDCilAWD6
	 U1BmK3+vdjaVi4aDFRbfeOUG8EXFTAJFo06V9v0BTSGKaHVQpe8U7SUnfxkHael3Ft
	 CtaaEZj5St6Fg==
Date: Thu, 20 Jun 2024 17:22:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Ziwei Xiao <ziweixiao@google.com>, Praveen Kaligineedi
 <pkaligineedi@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>,
 Willem de Bruijn <willemb@google.com>, Jeroen de Borst
 <jeroendb@google.com>, Shailend Chand <shailend@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/6] net: ethtool: perform pm duties outside of
 rtnl lock
Message-ID: <20240620172235.6e6fd7a5@kernel.org>
In-Reply-To: <20240620114711.777046-4-edumazet@google.com>
References: <20240620114711.777046-1-edumazet@google.com>
	<20240620114711.777046-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 11:47:08 +0000 Eric Dumazet wrote:
> Move pm_runtime_get_sync() and pm_runtime_put() out of __dev_ethtool
> to dev_ethtool() while RTNL is not yet held.
> 
> These helpers do not depend on RTNL.

The helpers themselves don't, but can we assume no drivers have
implicit dependencies on calling netif_device_detach() under rtnl_lock,
and since the presence checks are under rtnl_lock they are currently
guaranteed not to get any callbacks past detach() + rtnl_unlock()?

I think its better to completely skip PM + presence + ->begin if driver
wants the op to be unlocked, but otherwise keep the locking as is

I also keep wondering whether we shouldn't use this as an opportunity
to introduce a "netdev instance lock". I think you mentioned we should
move away from rtnl for locking ethtool and ndos since most drivers
don't care at all about global state. Doing that is a huge project, 
but maybe this is where we start?

