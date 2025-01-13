Return-Path: <netdev+bounces-157901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1CFA0C442
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34FE33A4AEC
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 21:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02AC1CDFCE;
	Mon, 13 Jan 2025 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8TBvCBL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B79B17CA12
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736805371; cv=none; b=gCLNwyvLz5ZVH0Z9S1hyfZB0ysBpvpWyPTZvuG1rXfpxNKKObWuoxZ/Ck9sCZIeb2fnuUL99iKJrNkYcTyHrCtf1zU1x80RNDM/4Dq+n3/+llH+uVDhJ8jmQ/tAM6b1cP2Yi9lYb3Gxk2R8WNfTJVX9jdP4D+Lip1mc0DGsNkPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736805371; c=relaxed/simple;
	bh=LlFdz3sSHr8Mig3a5a+nDARMgJIO2APz9lV+DFGzGMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFW/UOAQ8GwBYJhjQ1LvAf56xu62PY+FgYmFNDR578iuq+J2MOMRpnjq5tjShlSrmSnIWn+CLUELj/msIjd/uNDWlrj6HgEK5Ykay/ovn1tBUBVU9TaeiTx4L2YWeBFesnQ5LDwrovTLU7Rea0J+sMVEgcTW8elCmZp6f7Fwq9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8TBvCBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A7EC4CED6;
	Mon, 13 Jan 2025 21:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736805371;
	bh=LlFdz3sSHr8Mig3a5a+nDARMgJIO2APz9lV+DFGzGMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n8TBvCBLuTAxjrYFxq7G6CmqTHJJXntoNQ1oPwIgZsaunpqa5sRcObaXgsqvvsB3M
	 fxOvQSBN7nw+NUE+luaI8AtiXaUKLUcGUuoJnwquVALm+vh2eZPNSdJRAIQvnBYuRA
	 aSSR0H+BLHek1LQOfy+PGfoLUXQxpmV2YR1XMlPYAyU8mMfB1nQ3e7iLrab7nyPnX0
	 Zq1NLlgibUZmBj4pfzhtJre4E8v0AqGsKCxwonUHRBfx8EvmZqPwXcs1eWh13gEvDT
	 4PGAh9w9vu4axFN+sNfKncBjk/mOIYkCQVHp1rYwhJj0/A4qdZRg6TMQbuycIyzdG3
	 w3cZMP/C7Pn3A==
Date: Mon, 13 Jan 2025 13:56:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Gerhard Engleder <gerhard@engleder-embedded.com>,
 magnus.karlsson@intel.com, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] tsnep: Link queues to NAPIs
Message-ID: <20250113135609.13883897@kernel.org>
In-Reply-To: <Z4WKHnDG9VSMe5OD@LQ3V64L9R2>
References: <20250110223939.37490-1-gerhard@engleder-embedded.com>
	<Z4VwrhhXU4uKqYGR@LQ3V64L9R2>
	<91fc249e-c11a-47a1-aafe-fef833c3bafa@engleder-embedded.com>
	<Z4WKHnDG9VSMe5OD@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 13:48:14 -0800 Joe Damato wrote:
> > > The changes generally look OK to me (it seems RTNL is held on all
> > > paths where this code can be called from as far as I can tell), but
> > > there was one thing that stood out to me.
> > > 
> > > AFAIU, drivers avoid marking XDP queues as NETDEV_QUEUE_TYPE_RX
> > > or NETDEV_QUEUE_TYPE_TX. I could be wrong, but that was my
> > > understanding and I submit patches to several drivers with this
> > > assumption.
> > > 
> > > For example, in commit b65969856d4f ("igc: Link queues to NAPI
> > > instances"), I unlinked/linked the NAPIs and queue IDs when XDP was
> > > enabled/disabled. Likewise, in commit 64b62146ba9e ("net/mlx4: link
> > > NAPI instances to queues and IRQs"), I avoided the XDP queues.
> > > 
> > > If drivers are to avoid marking XDP queues as NETDEV_QUEUE_TYPE_RX
> > > or NETDEV_QUEUE_TYPE_TX, perhaps tsnep needs to be modified
> > > similarly?  
> > 
> > With 5ef44b3cb4 ("xsk: Bring back busy polling support") the linking of
> > the NAPIs is required for XDP/XSK. So it is strange to me if for XDP/XSK
> > the NAPIs should be unlinked. But I'm not an expert, so maybe there is
> > a reason why.
> > 
> > I added Magnus, maybe he knows if XSK queues shall still be linked to
> > NAPIs.  
> 
> OK, so I think I was probably just wrong?
> 
> I looked at bnxt and it seems to mark XDP queues, which means
> probably my patches for igc, ena, and mlx4 need to be fixed and the
> proposed patch I have for virtio_net needs to be adjusted.
> 
> I can't remember now why I thought XDP queues should be avoided. I
> feel like I read that or got that as feedback at some point, but I
> can't remember now. Maybe it was just one driver or something I was
> working on and I accidentally thought it should be avoided
> everywhere? Not sure.
> 
> Hopefully some one can give a definitive answer on this one before I
> go through and try to fix all the drivers I modified :|

XDP and AF_XDP are different things. The XDP part of AF_XDP is to some
extent for advertising purposes :) If memory serves me well:

XDP Tx -> these are additional queues automatically allocated for
          in-kernel XDP, allocated when XDP is attached on Rx.
          These should _not_ be listed in netlink queue, or NAPI;
          IOW should not be linked to NAPI instances.
XDP Rx -> is not a thing, XDP attaches to stack queues, there are no
          dedicated XDP Rx queues
AF_XDP -> AF_XDP "takes over" stack queues. It's a bit of a gray area.
          I don't recall if we made a call on these being linked, but
          they could probably be listed like devmem as a queue with
          an extra attribute, not a completely separate queue type.

