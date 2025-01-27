Return-Path: <netdev+bounces-161202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 669A0A20002
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 22:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDDF91887C99
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 21:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5141D90A9;
	Mon, 27 Jan 2025 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMbkXugV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5EA1D89F8;
	Mon, 27 Jan 2025 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738013878; cv=none; b=MTA+cTtknrdgArmhs6XfZKrA5RjaFwG/TQNcHdlgL7oVkrbezvJM1mAekzG27oUx/JK5YCl91ua2G41UAoVpguKDihOsjg9Bon8Ki6bGUYYA9G3u9p1DoNri9CJDkTiOjQAYDq01tUrfTJDiAv5jBHiEcPhLgnyZ6Y66jYsv9vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738013878; c=relaxed/simple;
	bh=9+F2NeqGCxbV1FVrVYA7C/PBIY1+aH/Q7umwgeyM9CA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MmKxdyNkq5fTbfZF/ARDbwIahvSe69eS6ZIvJJTRfaW+ln09SktlNLYecsMG3gJUAAD8MTmld3lxGnwhSHviQOg+XkLw8JYkQUI3X+hIYkAaHmJFIJWL9CG8T8ME17gk9ABV0DaXyGK1p4IMmAZOcW4ILESB99HaDyZzUVxv6p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMbkXugV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBB3C4CED2;
	Mon, 27 Jan 2025 21:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738013878;
	bh=9+F2NeqGCxbV1FVrVYA7C/PBIY1+aH/Q7umwgeyM9CA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mMbkXugVxRWyb2mSXh3WqFFWRCcbF0LbJ51OD3giyH3YmZbAc2/IfwNYBtNF+naBz
	 BrmSw4sHa4pDERoA5NnJh6ZxQj4Mvs27NrLslumemIJamM6D1JAVosq5rZIZEthmvd
	 8siqixPPdZaHnbqulDhcITN9KOQ5AGCplf2rKeU0bdl3B7JRZy5YwkXE88LCAElYWe
	 r3ZZl+i3XVBNSlUVhQ4+EoRujR31eLP/cIG4l8FbMIsFdBSApVOJNAPzZoC4bCXwSU
	 vTAZ1qlAoB4ORpmym6nKx/2pmBVNts8jhs90fS6AKZstZh8QTn0YjftawQ+qq3v68I
	 jmJKOZhbqmqjA==
Date: Mon, 27 Jan 2025 13:37:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, gerhard@engleder-embedded.com,
 jasowang@redhat.com, leiyang@redhat.com, xuanzhuo@linux.alibaba.com,
 mkarsten@uwaterloo.ca, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org (open
 list)
Subject: Re: [RFC net-next v3 1/4] net: protect queue -> napi linking with
 netdev_lock()
Message-ID: <20250127133756.413efb24@kernel.org>
In-Reply-To: <20250121191047.269844-2-jdamato@fastly.com>
References: <20250121191047.269844-1-jdamato@fastly.com>
	<20250121191047.269844-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jan 2025 19:10:41 +0000 Joe Damato wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> netdev netlink is the only reader of netdev_{,rx_}queue->napi,
> and it already holds netdev->lock. Switch protection of the
> writes to netdev->lock as well.
> 
> Add netif_queue_set_napi_locked() for API completeness,
> but the expectation is that most current drivers won't have
> to worry about locking any more. Today they jump thru hoops
> to take rtnl_lock.

I started having second thoughts about this patch, sorry to say.
NAPI objects were easy to protect with the lock because there's
a clear registration and unregistration API. Queues OTOH are made
visible by the netif_set_real_num_queues() call, which is tricky 
to protect with the instance lock. Queues are made visible, then
we configure them.

My thinking changed a bit, I think we should aim to protect all
ndos and ethtool ops with the instance lock. Stanislav and Saeed
seem to be working on that:
https://lore.kernel.org/all/Z5LhKdNMO5CvAvZf@mini-arch/
so hopefully that doesn't cause too much of a delay.
But you may need to rework this series further :(

