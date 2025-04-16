Return-Path: <netdev+bounces-183252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 874A4A8B782
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 13:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056B1189EB62
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D549227E8C;
	Wed, 16 Apr 2025 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTll02ek"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A151E5B7D;
	Wed, 16 Apr 2025 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744802252; cv=none; b=OULiVM860aj4n5tq9AcGHq4MjFVxodwgJ3tXJy/8AxYSWsEm6VwrFSAky6X6EMW8+g00rkCICgEoc3fRnuAgO3Idup9sd+nUuwL4kcMcRogQtmQoVhaSce6as9ulAnh/DfxXrw3M4DFAXkYdwnswl7l1kiq3Jf6tV1VhcpIM9zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744802252; c=relaxed/simple;
	bh=Tns0B+Lx33i0bZLUWL8ldbxIJCfVLDFfE5hioMKfZq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvAcqSfuOu0jVjyt65F1QKV6crFy9OvZ6HlQJEAr1LFAOu+Facm4vx+dS1qo6efIDRe1dIdfUYg8WIKgWJtCH209nMEfZQ/CwMUiDAbrzEwGzBo8Fkt7e9+asB9SiDsNMQ03pw5nci/dJT0xTejh6svlCCG5AV82NT/vSuq/+L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTll02ek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B943C4CEE2;
	Wed, 16 Apr 2025 11:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744802251;
	bh=Tns0B+Lx33i0bZLUWL8ldbxIJCfVLDFfE5hioMKfZq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JTll02ekcKe1jlqCoPVhTCAkEgiW8DE+pguYTZ39jsWALpERR+gWzFGVWuGkZmmpv
	 azgt/TjtXkPg7GJX3DH+OvoGEITdVCDMhuJkFGz6f0luN6t9Any2c9tEjM9l+hyJ+k
	 EsKY7u2a7P+vu6NJYnnggF3MtumZj3PwUS0/KPspA4mgsNragjgiNd6cWrvpG+yuMi
	 xnc4OlIWol3OjyfhPqOotMylbLZkOcUoRJHpBq6F0gr+WuWP+L9gB2x2xXMcCCBtzC
	 XmWHDoFGFRlgt6l67IclouDdU8yI59V1avgnDcHme9bB9hrlemdIQdNNIjGLUKf+go
	 nMgsqHmTch1dQ==
Date: Wed, 16 Apr 2025 12:17:27 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pranav Tyagi <pranav.tyagi03@gmail.com>, davem@davemloft.net,
	dsahern@kernel.org, edumazet@google.com, pabeni@redhat.com,
	skhan@linuxfoundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH net-next] net: ipconfig: replace strncpy with strscpy
Message-ID: <20250416111727.GO395307@horms.kernel.org>
References: <20250412160623.9625-1-pranav.tyagi03@gmail.com>
 <20250415163536.GA395307@horms.kernel.org>
 <20250415171927.5108d252@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415171927.5108d252@kernel.org>

On Tue, Apr 15, 2025 at 05:19:27PM -0700, Jakub Kicinski wrote:
> On Tue, 15 Apr 2025 17:35:36 +0100 Simon Horman wrote:
> > > @@ -1690,7 +1690,7 @@ static int __init ic_proto_name(char *name)
> > >  			*v = 0;
> > >  			if (kstrtou8(client_id, 0, dhcp_client_identifier))
> > >  				pr_debug("DHCP: Invalid client identifier type\n");
> > > -			strncpy(dhcp_client_identifier + 1, v + 1, 251);
> > > +			strscpy(dhcp_client_identifier + 1, v + 1, 251);  
> > 
> > As an aside, I'm curious to know why the length is 251
> > rather than 252 (sizeof(dhcp_client_identifier) -1).
> > But that isn't strictly related to this patch.
> 
> Isn't this because strncpy() doesn't nul-terminate, and since this is a
> static variable if we use len - 1 we guarantee that there will be a null
> byte at the end? If we switch to strscpy we'll make the max string len
> 1 char shorter.

Yes, that makes sense to me.
And so I think the patch should also increase 251 to 252.

