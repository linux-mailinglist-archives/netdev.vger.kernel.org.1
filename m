Return-Path: <netdev+bounces-122102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED49E95FE8E
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 03:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3FC28144F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 01:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29369473;
	Tue, 27 Aug 2024 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEn5kFNP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7AA2F37
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724723757; cv=none; b=k1+hk53a11Kfi0ejpkWPrZGZHaBmFa1DnR4ZJhF7l72eeREro8+9JicJAdofo+nXVHhDoeB40RMT6IK/LV831dbxcjWvB8AUm3C/bg1vrYfJ6mghiBeeiJTDSg7FvUQwY6d8UYmFdggzJ/8GtvB0pS2KWpk6CjuZ0XkJ3B4q44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724723757; c=relaxed/simple;
	bh=qr/jV6a2rJxWQbuIQmPvlUGOYp4X1+kj2dkL06i1Xdc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qhl+JsilxMU84UeE5AXuXiXab6chlWhjeEJsqWH0AWhwi+P8nlA5fCiQ6c6F11uo58rx5wGmi9lEPHgsHjykP3yJAiO1JHvdM3giybPiFteR27GEX17iY4DH3dRZ8g8QJmr9NdRkjtrXTEo9u9sNw6/gUAJJrumna0JxXbQNeng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEn5kFNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8687C8B7AF;
	Tue, 27 Aug 2024 01:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724723757;
	bh=qr/jV6a2rJxWQbuIQmPvlUGOYp4X1+kj2dkL06i1Xdc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fEn5kFNPquj0qzyk0qnwugc4o8o3mfoUWBVmy0MXO10Rt4CKxIUd+/tu6aaKoOd3B
	 P6j8oZkanCP/ImVFBvhZHl+0B+2e0KRYCDKWuaq0yHBn3ubpI77h6boU3bnUayHCBw
	 p1FIysnpfVy3CASe+DUEBos8q0vf4pQ/jtXt/FYdPcXDeU7036vhoV+fZ1MQ5D6PEM
	 MeAgnGNUGBPTiJb0w59YeiX4p4+N1mTlliXQP0u8h6t/ZuXn9/5uboiJeoULRYOulS
	 bOqPLxTzwv9w2dnYRZeX08skDxCychSrQrEip/lTectF/2AEvvC4YYXa2jHXFbDLMd
	 AlXA0KBc8ztWw==
Date: Mon, 26 Aug 2024 18:55:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>
Subject: Re: [PATCH v4 net-next 03/12] net-shapers: implement NL get
 operation
Message-ID: <20240826185555.3f460af4@kernel.org>
In-Reply-To: <0e5c2178-22e2-409e-8cbd-9aaa66594fdc@redhat.com>
References: <cover.1724165948.git.pabeni@redhat.com>
	<c5ad129f46b98d899fde3f0352f5cb54c2aa915b.1724165948.git.pabeni@redhat.com>
	<20240822191042.71a19582@kernel.org>
	<0e5c2178-22e2-409e-8cbd-9aaa66594fdc@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 10:52:04 +0200 Paolo Abeni wrote:
> >> + * comprising the shaper scope and a scope-specific id.
> >> + */
> >> +struct net_shaper_ops {
> >> +	/**
> >> +	 * @group: create the specified shapers scheduling group
> >> +	 *
> >> +	 * Nest the @leaves shapers identified by @leaves_handles under the
> >> +	 * @root shaper identified by @root_handle. All the shapers belong
> >> +	 * to the network device @dev. The @leaves and @leaves_handles shaper
> >> +	 * arrays size is specified by @leaves_count.
> >> +	 * Create either the @leaves and the @root shaper; or if they already
> >> +	 * exists, links them together in the desired way.
> >> +	 * @leaves scope must be NET_SHAPER_SCOPE_QUEUE.  
> > 
> > Or SCOPE_NODE, no?  
> 
> I had a few back-and-forth between the two options, enforcing only QUEUE 
> leaves or allowing even NODE.
> 
> I think the first option is general enough - can create arbitrary 
> topologies with the same amount of operations - and leads to slightly 
> simpler code, but no objections for allow both.

Ah, so we can only "grow the tree from the side of the leaves", 
so to speak? We can't create a group in the middle of the hierarchy?
I have no strong use for groups in between, maybe just mention in
a comment or cover letter.

> >> +static int net_shaper_fill_handle(struct sk_buff *msg,
> >> +				  const struct net_shaper_handle *handle,
> >> +				  u32 type, const struct genl_info *info)
> >> +{
> >> +	struct nlattr *handle_attr;
> >> +
> >> +	if (handle->scope == NET_SHAPER_SCOPE_UNSPEC)
> >> +		return 0;  
> > 
> > In what context can we try to fill handle with scope unspec?  
> 
> Uhmm... should happen only in buggy situation. What about adding adding 
> WARN_ON_ONCE() ?

That's better, at least it will express that it's not expected.

> >> +	handle_attr = nla_nest_start_noflag(msg, type);
> >> +	if (!handle_attr)
> >> +		return -EMSGSIZE;
> >> +
> >> +	if (nla_put_u32(msg, NET_SHAPER_A_SCOPE, handle->scope) ||
> >> +	    (handle->scope >= NET_SHAPER_SCOPE_QUEUE &&
> >> +	     nla_put_u32(msg, NET_SHAPER_A_ID, handle->id)))
> >> +		goto handle_nest_cancel;  
> > 
> > So netdev root has no id and no scope?  
> 
> I don't understand the question.
> 
> The root handle has scope NETDEV and id 0, the id will not printed out 
> as redundant: there is only a scope NETDEV shaper per struct net_device.

Misread, yes, no id but it does have scope. That's fine, sorry.

