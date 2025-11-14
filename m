Return-Path: <netdev+bounces-238545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0B3C5AE2D
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 02:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 478A34E2660
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 01:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327D51DB95E;
	Fri, 14 Nov 2025 01:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MW7tZCQo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D47EEB3;
	Fri, 14 Nov 2025 01:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763082931; cv=none; b=oNYRzFjwZcqr2taSRUp/wUdrHuGLhgQGctXhmuqgUAxQSZm5Ry5k/UkYobQZThVDM0FsPaiFGZ9f/IE8Z76BcBTeVyqmXzrdNrdvGQnwgTo6y8qSoiEUeG230Hx9vnLb0I8Pb+zm0/I1YUGLBwgOPdM2hbjLZknzAFvYY1bzwGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763082931; c=relaxed/simple;
	bh=VdRjP+mVcT5n42lUoYJcl4wtQbB4jERHjzOo/SD1Uaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHQfugmzTTNLFB0qiYHfZN7yZ2sN6ILPz5Kxo8SveIqdRYk651XBqwI74zZ1VMe+8U78/aH18oVs3INmZHOH0jU2nzzWsUKbaCLhRnwn00Vv6krEqNpP1eknxaDjmv1hwzw7cjUXk9npQ+ACoX97wiHhMIslafY4ez3Jij1FqpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MW7tZCQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF155C16AAE;
	Fri, 14 Nov 2025 01:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763082930;
	bh=VdRjP+mVcT5n42lUoYJcl4wtQbB4jERHjzOo/SD1Uaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MW7tZCQoXmSd7hxHKrf4jId6bihlxpHlBjVNSKVajzjvILrYAXBJUAU8pLg4z3/yo
	 xKNBjwQNFad1KNBCRDZHF0sQPrNXjD32fDUPIJIu5WEQUa1dqs+THhZ1L+0eMwAz5a
	 sDP7+FgHSftgxjIrcjkOfooglGmR+7W6HjhmldJmGWB2YltSmM9DicuBzfwy6bUqwO
	 W99ONbmu1yQX34NylsaLulWbkxqamwywKz80JPqh1hqIdfwnWRMDc7ujJN0y/awFg0
	 lVOs6EWf22twzFAhUGvTUYOWLV1SXPECBBh7CAhZoUcSBynAsL3O1dGJErHGqJbF8W
	 zSMXglDeTFzYQ==
Date: Thu, 13 Nov 2025 17:15:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shay Drori <shayd@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Carolina Jubran
 <cjubran@nvidia.com>
Subject: Re: [PATCH net] devlink: rate: Unset parent pointer in
 devl_rate_nodes_destroy
Message-ID: <20251113171528.12517f4a@kernel.org>
In-Reply-To: <d751e671-9b73-42ce-acce-c98947b632c2@nvidia.com>
References: <1762863279-1092021-1-git-send-email-tariqt@nvidia.com>
	<20251112181248.190415f7@kernel.org>
	<d751e671-9b73-42ce-acce-c98947b632c2@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Nov 2025 10:33:09 +0200 Shay Drori wrote:
> > On Tue, 11 Nov 2025 14:14:39 +0200 Tariq Toukan wrote:  
> >> The function devl_rate_nodes_destroy is documented to "Unset parent for
> >> all rate objects". However, it was only calling the driver-specific
> >> `rate_leaf_parent_set` or `rate_node_parent_set` ops and decrementing
> >> the parent's refcount, without actually setting the
> >> `devlink_rate->parent` pointer to NULL.
> >>
> >> This leaves a dangling pointer in the `devlink_rate` struct, which is
> >> inconsistent with the behavior of `devlink_nl_rate_parent_node_set`,
> >> where the parent pointer is correctly cleared.
> >>
> >> This patch fixes the issue by explicitly setting `devlink_rate->parent`
> >> to NULL after notifying the driver, thus fulfilling the function's
> >> documented behavior for all rate objects.  
> > 
> > What is the _real_ issue you're solving here? If the function destroys
> > all nodes maybe it doesn't matter that the pointer isn't cleared.
> 
> The problem is a leaf which have this node as a parent, now pointing to
> invalid memory. When this leaf will be destroyed, in
> devl_rate_leaf_destroy, we can get NULL-ptr error, or refcount error.
> 
> Is this answer your question?

Kind of. I was hoping you can add a concrete example to the commit
message. What sequence of user operations are needed with mlx5 to
make the kernel oops.

