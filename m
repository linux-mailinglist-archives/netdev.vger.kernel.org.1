Return-Path: <netdev+bounces-98713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CF28D2279
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 19:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A53F7B22890
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1193174EC0;
	Tue, 28 May 2024 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYQ6jRRn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD518173342
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716917319; cv=none; b=Qb1OxYYHIZaaoxGtdq8mQuvOQGjThGsunJfGYmj86H5PpQ4eF/HBMlhKIgsUqcw1uC3UnuxOK54eW85K0gcRZFGmwtlSI9Z/yBUpLczAJaCnwT/4YqZi/ykXRKPgKmPN0JZLw22wTTA5wCsI+2X4CUoKklNEjqaJIikJnmifES4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716917319; c=relaxed/simple;
	bh=ypISCf5PSJfxhEXAEpQE6XM2s49bpxhhDEfY7X6NrJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLD7H+Duwy/uZW7FANZ3/PMIE0CCshPrphVLt/oFsxi4l7vrtf8uxfR+HLnY2SoJ4xh2zG5r8IMxZdroar/RX0clFuY1Kng0gqkhlLLU82TYqIlCvfVaaPhbdDvdELtBu4FZ6z/5EumfQKlmEX1iFx4Oio38J/8JkqvWBVk2YKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYQ6jRRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB57FC3277B;
	Tue, 28 May 2024 17:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716917319;
	bh=ypISCf5PSJfxhEXAEpQE6XM2s49bpxhhDEfY7X6NrJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nYQ6jRRnmYLUS7Ltspld09QAJAaBF/n1FRdWPXoLG9SkUZW7ZxWg8dL1uWgNvhf/0
	 M0fvY+Y0DMXaYEWnURDvkHcBITZsB3BRTdfhahLyMXhkdRMOtvuepaEmYD4HWZj8HS
	 +ysrXJSOoiv6dlk7radPsesKUg1JHP9BatuotCvBNqCD5XLNeJfbZ0loECa8cHF2pm
	 h2R760z3f1Khu/D54x8sXD9m3pgtrWMOLlZkhFQ/J1MQM10bGnIhIfkz3tLB1Vx+nW
	 6YynmTPeK+WTebNCBa8JJ3Nf78HvNATgYAwkg+1aBQqlC9KunT50QUz0Mj/Cgh9JzR
	 uJi8BsLNHwinQ==
Date: Tue, 28 May 2024 10:28:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, Jiri Pirko
 <jiri@resnulli.us>, Madhu Chittim <madhu.chittim@intel.com>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>, Simon Horman <horms@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Sunil Kovvuri Goutham
 <sgoutham@marvell.com>, Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [RFC PATCH] net: introduce HW Rate Limiting Driver API
Message-ID: <20240528102838.68d774aa@kernel.org>
In-Reply-To: <db51b7ccff835dd5a96293fb84d527be081de062.camel@redhat.com>
References: <3d1e2d945904a0fb55258559eb7322d7e11066b6.1715199358.git.pabeni@redhat.com>
	<f6d15624-cd25-4484-9a25-86f08b5efd51@lunn.ch>
	<e2cbbbc416700486e0b4dd5bc9d80374b53aaf79.camel@redhat.com>
	<9dd818dc-1fef-4633-b388-6ce7272f9cb4@lunn.ch>
	<f7fa91a89f16e45de56c1aa8d2c533c6f94648ba.camel@redhat.com>
	<a0ada382-105a-4994-ad0f-1a485cef12c4@lunn.ch>
	<db51b7ccff835dd5a96293fb84d527be081de062.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 May 2024 13:05:41 +0200 Paolo Abeni wrote:
> And the latter looks IMHO the simple/better. At that point I would
> probably drop the 'add' op and would rename 'delete' as
> 'reset':
> 
> int (*set)(struct net_device *dev, int how_many, const u32 *handles,
> 	   const struct net_shaper_info *shapers,
>            struct netlink_ext_ack *extack);
> int (*reset)(struct net_device *dev, int how_many, const u32 *handles,
>              struct netlink_ext_ack *extack);
> int (*move)(struct net_device *dev, int how_many, const u32 *handles,
>             const u32 *new_parent_handles,
> 	    struct netlink_ext_ack *extack);
> 
> An NIC with 'static' shapers can implement a dummy move always
> returning EOPNOTSUPP and eventually filling a detailed extack.
> 
> NIC without any constraints on mixing and matching different kind of
> shapers could implement the above as a loop over whatever they will do
> for the corresponding 'single shaper op'
> 
> NIC with constrains alike the one you pointed out could validate the
> final state before atomically applying the specified operation.
> 
> After a successful  'reset' operation, the kernel could drop any data
> it retains/caches for the relevant shapers - the current idea is to
> keep a copy of all successfully configured shaper_info in a xarray,
> using the 'handle' as the index.

IMHO this is more confusing that the current API, maybe we just need
better driver-facing documentation? Deleting a node from the hierarchy
doesn't delete the HW, same as deleting a TCAM entry doesn't chisel off
a part of the chip. If you want to switch from WRR to SP you'd need to
delete all the weight nodes and insert SP nodes as children.

If we modeled mux nodes as multi-entry nodes explicitly it may be
easier. Meaning make the scheduling and weights part of the mux node,
not its children.

