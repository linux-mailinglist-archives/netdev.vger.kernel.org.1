Return-Path: <netdev+bounces-103241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12807907431
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5E91C227DB
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDACD144D39;
	Thu, 13 Jun 2024 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQR+S+xm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D588F68;
	Thu, 13 Jun 2024 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286427; cv=none; b=MvR4jsjjOoebA3YcgM+kzg2JIZbcnrb6Fi/WRQ6hjdte0KA5yxe8EBcBJU+/XKmEgW2b7OZTarSVA1+Vtwi82vRWuWmHnwozsjqpirhyiaQCy1WPRa51/bFMIzqCdpb7/3RWetrvOHs7+oVaqL+aOLmFYat9pZqDo/mz/Aq3zYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286427; c=relaxed/simple;
	bh=F+vpsUe1Dqx+OiW7G9Jnm5iiQTon9YAexjro/SFNuDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SFlLXEbmYM1TgKWRfMyVV4J3hJ7WWCKP7YLF++rd5LPvQbhd5QWq04wFmwTGZfW6HZdgJwrGVqMhurgg1jTLcm/+WKXyIN0UlMdPlch7u3rO/U0T4q4QcxJsO8QIqkDwYs4x91sFKFuofn4z/rUmJ3XpHQ2gEeemniuooEZm6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQR+S+xm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5097C2BBFC;
	Thu, 13 Jun 2024 13:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718286427;
	bh=F+vpsUe1Dqx+OiW7G9Jnm5iiQTon9YAexjro/SFNuDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rQR+S+xmR2KSIF4UEpapK+WRaIgnwkATsPQq69mgFBtV4TtX9n/55mbgZZjBO4G9f
	 aZ0gb3FNYi5H1si+U7MAMH3X/VTLgHF6JZb1x398NY9TfhZQnayChxunUqG2GlYKb/
	 sJBBl1xCGHXVZKChT8Lvj62a4w47r1RmdGnFTfHvJ0c+uvjp2WAO2WPprxyHZVSM8H
	 Lj2OdTay6E6IE9k/CoiEaueLkWqWWvxfRbqEhbK0JBTogAzYgF0T5k5y9kVZAni+sn
	 mDgIu4qWLmuyOs+brmU2A0aLGPr+9PF1z4pjRUAmpRluO6xWX/O5ElGDrUH9RT++mp
	 8yxsYE6frB9Qw==
Date: Thu, 13 Jun 2024 06:47:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Mina
 Almasry <almasrymina@google.com>,
 <nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iwl-next 01/12] libeth: add cacheline / struct alignment
 helpers
Message-ID: <20240613064706.15f26159@kernel.org>
In-Reply-To: <43c1ec2f-977e-45cd-b974-e943fa880535@intel.com>
References: <20240528134846.148890-1-aleksander.lobakin@intel.com>
	<20240528134846.148890-2-aleksander.lobakin@intel.com>
	<20240529183409.29a914c2@kernel.org>
	<43c1ec2f-977e-45cd-b974-e943fa880535@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 12:47:33 +0200 Alexander Lobakin wrote:
> > Having per-driver grouping defines is a no-go.  
> 
> Without it, kdoc warns when I want to describe group fields =\
> 
> > Do you need the defines in the first place?  
> 
> They allow to describe CLs w/o repeating boilerplates like
> 
> 	cacheline_group_begin(blah) __aligned(blah)
> 	fields
> 	cacheline_group_end(blah)

And you assert that your boilerplate is somehow nicer than this?
See my reply to Przemek, I don't think so, and neither do other
maintainers, judging by how the socket grouping was done.
You can add new markers to include the align automatically too, etc.

> > Are you sure the assert you're adding are not going to explode
> > on some weird arch? Honestly, patch 5 feels like a little too  
> 
> I was adjusting and testing it a lot and CI finally started building
> every arch with no issues some time ago, so yes, I'm sure.
> 64-byte CL on 64-bit arch behaves the same everywhere, so the assertions
> for it can be more strict. On other arches, the behaviour is the same as
> how Eric asserts netdev cachelines in the core code.
> 
> > much for a driver..  
> 
> We had multiple situations when our team were optimizing the structure
> layout and then someone added a new field and messed up the layout
> again. So I ended up with strict assertions.

I understand. Not 100% sure I agree but depends on the team, so okay.

> Why is it too much if we have the same stuff for the netdev core?

But we didn't add tcp_* macros and sock_* macros etc.
Improve the stuff in cache.h is you think its worth it.
And no struct_groups() please.

