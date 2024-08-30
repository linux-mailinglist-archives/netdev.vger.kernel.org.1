Return-Path: <netdev+bounces-123808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CC6966922
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 20:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1072C1F2150C
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 18:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2BA1BB69B;
	Fri, 30 Aug 2024 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Segi2mHS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A9A1B9B57
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725043733; cv=none; b=bdL+y5D5GmK5aG0wIqacVprnxN38zdmredMs4JQEWBAECPQascl/AmmcfpV9NhHZAt/FWtZeloXQBgtBYmIx6+4U7r+OFo3QoRRTx8RZZUX38AuqIUkILAYv6Fu6c2Tde03z8LoTh4JqmARsowhVXvfTIieDmHs6qxXr6XLQYpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725043733; c=relaxed/simple;
	bh=gkEM9qoL4YZzmRpGtgnNAQ0bHBjwyWWJntONBu2fqGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLEEzv2vCUoVtzvlvIYXFBA/LGR0+3e8W77kt9KwsKQh1butaI8MeCnFxndMFTULp6T6QNIStkGw/ghRxYyc0ZMBv/PX4RqGQpOtiGYu20a3a6GswS31DFZcxBuY5Jw/LNcqEqifVGLBcGj7vbiXteJBeAQbTktf7ZaO11BhmSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Segi2mHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1A7C4CEC2;
	Fri, 30 Aug 2024 18:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725043733;
	bh=gkEM9qoL4YZzmRpGtgnNAQ0bHBjwyWWJntONBu2fqGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Segi2mHSA4w5a5emnsbM+O658y4prhoUp3XtS1qA6ekyijRmpCPxABpQoC1oFjBeH
	 k59B1e13rlJKmMhDY4TDWvhzuWNqU0IryUGT80/7MpcO+HwAzZRVBqv9xZXhxXyhS/
	 PWYzA0bfDiipPhihH97UGzy3GBXe2lmm745PCmodwV/h3ZwE2+0ZI6Wss9VL8k58Fs
	 YXDcFkfUPalpNaE6WVpSrZEJzCDn3bDjvrd7Oi1aaLOPVtIJ6Y9mCITCz1ikRE5u26
	 By8hmaH51rqealXSwWtthsh+eMeF+kJe80jEVMafohCcuihfudpkvm8EU3vro1xPG0
	 Qfdhyj+59MOXw==
Date: Fri, 30 Aug 2024 11:48:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v5 net-next 04/12] net-shapers: implement NL group
 operation
Message-ID: <20240830114851.58cd02c4@kernel.org>
In-Reply-To: <d0244464-0596-4309-89ff-d8dcd9aa3d35@redhat.com>
References: <cover.1724944116.git.pabeni@redhat.com>
	<f67b0502e7e9e9e8452760c4d3ad7cdac648ecda.1724944117.git.pabeni@redhat.com>
	<20240829190445.7bb3a569@kernel.org>
	<d0244464-0596-4309-89ff-d8dcd9aa3d35@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Aug 2024 18:48:41 +0200 Paolo Abeni wrote:
> >> +	const struct net_shaper_ops *ops = net_shaper_binding_ops(binding);
> >> +	struct net_shaper_info *parent = NULL;
> >> +	struct net_shaper_handle leaf_handle;
> >> +	int i, ret;
> >> +
> >> +	if (node_handle->scope == NET_SHAPER_SCOPE_NODE) {
> >> +		if (node_handle->id != NET_SHAPER_ID_UNSPEC &&
> >> +		    !net_shaper_cache_lookup(binding, node_handle)) {
> >> +			NL_SET_ERR_MSG_FMT(extack, "Node shaper %d:%d does not exists",
> >> +					   node_handle->scope, node_handle->id);  
> > 
> > BAD_ATTR would do?  
> 
> We can reach here from the delete() op (next patch), there will be no 
> paired attribute is such case. Even for the group() operation it will 
> need to push here towards several callers additional context to identify 
> the attribute, it should be quite ugly, can we keep with ERR_MSG_FMT here?

Alright. But TBH I haven't grasped the semantics of how you use UNSPEC.
So I reserve the right to complain again in v6 if I think of a better
way ;)

> >> +	if (ret < 0)
> >> +		goto free_shapers;
> >> +
> >> +	ret = net_shaper_group_send_reply(info, &node_handle);
> >> +	if (ret) {
> >> +		/* Error on reply is not fatal to avoid rollback a successful
> >> +		 * configuration.  
> > 
> > Slight issues with the grammar here, but I think it should be fatal.
> > The sender will most likely block until they get a response.
> > Not to mention that the caller will not know what the handle
> > we allocated is.  
> 
> You mean we should return a negative error code, and _not_ that we 
> should additionally attempt a rollback, right? The rollback will be very 
> difficult at best: at this point destructive action have taken place.

net_shaper_group_send_reply() does a bit too much, TBH.
Given the rollback complexity propagating the failure just
from genlmsg_reply() is fine. I think the only case it fails
is if the socket is congested, which is in senders control.
But genlmsg_new() can be done before we start. And we should 
size the skb so that nla_puts sever fail (just pop a WARN_ON()
on their error path, to make sure we catch it if they grow,
I don't think they can fail with your current code).

