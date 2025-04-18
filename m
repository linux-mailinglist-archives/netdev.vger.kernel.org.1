Return-Path: <netdev+bounces-184055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64E6A92FE5
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391BA3A7DF6
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F40267B07;
	Fri, 18 Apr 2025 02:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pp3ts+0Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BDD770E2;
	Fri, 18 Apr 2025 02:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744943149; cv=none; b=cVXjyaEaRBovJQ8cMaojnnjJrlWQNMX8RuPJa5ote3IXMl6yeMKMYBFWlgVYm/FEctuJtI875hNwHJHK2h3prK28UaLdAwr6LbU27/c5C/kJOtP0UVeUdJ7eUKth3/oT07XfKvsVmhJttnBaTsgJ5pSGZ1rrD+zNH6Cqqris7vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744943149; c=relaxed/simple;
	bh=1mXDAI/S5vr5p1X81NHt2LdADcBB2pqbWg9JJmWE/es=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EuOjUIfMTQ218oAJJG6PBCyeapO8xlEGXMBk4uBJme3mWiXR6Kj6cAmlbiJ+AbHCDj2hbsjBHoSftJniautttTWvgcZBcOctFljOwxDCnx+bQpk/v7Gdia+bj9qgLzPSQgeHFTZMRu+lMHj2yVVyujSzP8lZQT5kYxC6EYtDbsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pp3ts+0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB72C4CEE4;
	Fri, 18 Apr 2025 02:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744943149;
	bh=1mXDAI/S5vr5p1X81NHt2LdADcBB2pqbWg9JJmWE/es=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pp3ts+0YHwbbyHdi6Ek0l9DSU7OyxOaHH2/b8ft6hMtPXeJZRn2yKt7h+gIr4OjpX
	 Gq21S61jaWKTCEtGnBm+ZiQz1iCq31EQtFYDhrZb2FbtUtnNCbUCUmJvbWkhF4jx4r
	 nARVCbnAuiWia6OZ/29fF4O1V1eXekXnHn/5b0GX1XVQYBulQMinDYg1GCiQk8+dIw
	 gMvKdYTsgBOOnrrBEg7lcUkUPaYdRKnjkIZsmXlBgmpf0etlfqQ5LGv9o24PY7ZxsC
	 fh3UtElZkrsesWYI2o25TbsqIDCGevkzA2bF5eeOpcZ2bSwwiBJEXpIrVzqqfOjVBq
	 i2axsLj+k9QWA==
Date: Thu, 17 Apr 2025 19:25:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Sathesh B Edara <sedara@marvell.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <hgani@marvell.com>,
 <vimleshk@marvell.com>, Veerasenareddy Burru <vburru@marvell.com>, Shinas
 Rasheed <srasheed@marvell.com>, Satananda Burla <sburla@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net v3] octeon_ep_vf: Resolve netdevice usage count
 issue
Message-ID: <20250417192547.36a7503e@kernel.org>
In-Reply-To: <07549649-3712-47b9-917b-c5001f9761cb@intel.com>
References: <20250416102533.9959-1-sedara@marvell.com>
	<07549649-3712-47b9-917b-c5001f9761cb@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 13:26:43 -0700 Jacob Keller wrote:
> > @@ -834,7 +833,6 @@ static void octep_vf_tx_timeout(struct net_device *netdev, unsigned int txqueue)
> >  {
> >  	struct octep_vf_device *oct = netdev_priv(netdev);
> >  
> > -	netdev_hold(netdev, NULL, GFP_ATOMIC);
> >  	schedule_work(&oct->tx_timeout_task);
> >  }  
> I guess the thought was that we need to hold because we scheduled a work
> item?

Looks like something I would have asked them to do :)
But it was probably merged before I could review next version ?

I mean, passing NULL for the tracker is... quite something.

> Presumably the driver would simply cancel_work_sync() on this timeout
> task before it attempts to release its own reference on the netdev, so
> this really doesn't protect anything.

It does, but before unregistering :/

Sathesh, schedule_work() returns a value. You should use it.

