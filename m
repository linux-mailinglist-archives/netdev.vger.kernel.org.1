Return-Path: <netdev+bounces-218030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF1DB3AD9B
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 620414E0EED
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C4E263F2D;
	Thu, 28 Aug 2025 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5EdWGpf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4631A295
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756420727; cv=none; b=GoTx/s4kb1LdqHcdtClpBYdC6Sveaa7QL2Qe98eZ9fA2bkd7Ii1gQ8R3d0FKwKbMAWUZRE6mKqAFeo6e2zbN74jzEb0TZQIRMuwyBuVuyHNUXjVwaNSgy/WJqdi3+/qwtdkyM+z7SZmWJjATwX+1pbYl53aqOqHrXwl7BReyWMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756420727; c=relaxed/simple;
	bh=pWxbuDPREd99bmnZ2L+IGFjZ5CgmDDghj7eYriJtAhs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8UNtPiiTKGmVtXkgaVV2Jex6k/xj+YrPimk5gMCmMMJXkZmOOwGbdZFjZJUTOdo3xnRYhBNn+xLChkjEA7E8G4KE4AYuqR84b2OmFsl8sbCApXOFLvWMmAhvhZr/Nf6vzYW5VfMifEVGFR2DWFjPgFTlB7z50FS2aiG2iVSBRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5EdWGpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F58C4CEEB;
	Thu, 28 Aug 2025 22:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756420727;
	bh=pWxbuDPREd99bmnZ2L+IGFjZ5CgmDDghj7eYriJtAhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B5EdWGpf5+2ZYSi6MzjuKP4WbzPoSbjMC9zuOU32QtYwxZNDTjADcYABKiGbzb9TY
	 Tm4N9OJXtryG6D6nz+zz4lteDpnwTdOITF7e1gib9jutzlXXXfeztxyxF11g3VlbOa
	 nGbgGTMrfdjbagEinBxU9WpTpxGqgXKjjNT07wic2XMY3hapXjUq8Scjzs+MHvXh+k
	 UxmAPePj8oV/C8xfqyo7YGk62HSGRQDzsvTBh5O6uUe7xeH7i0xpA+IqZG6IiLRQT9
	 pO0Uf0uWXoTCAYXFt4+8cniUsBHgVssfj4WREWiFn0tL9N1vSrYa8sQdU2GVuezIA/
	 PDj0Pg+AK8Nmg==
Date: Thu, 28 Aug 2025 15:38:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next V6 09/13] devlink: Add 'keep_link_up' generic
 devlink device param
Message-ID: <20250828153845.4928772b@kernel.org>
In-Reply-To: <aLC3jlzImChRDeJs@x130>
References: <20250709030456.1290841-1-saeed@kernel.org>
	<20250709030456.1290841-10-saeed@kernel.org>
	<20250709195801.60b3f4f2@kernel.org>
	<aG9X13Hrg1_1eBQq@x130>
	<20250710152421.31901790@kernel.org>
	<aLC3jlzImChRDeJs@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 13:09:50 -0700 Saeed Mahameed wrote:
> >> I don't see anything missing in the definition of this parameter
> >> 'keep_link_up' it is pretty much self-explanatory, for legacy reasons the
> >> netdev controls the underlying physical link state. But this is not
> >> true anymore for complex setups (multi-host, DPU, etc..).  
> >
> >The policy can be more complex than "keep_link_up"
> >Look around the tree and search the ML archives please.
> 
> Sorry for replying late, had to work on other stuff and was waiting
> internally for a question I had to ask about this, only recently got the
> answer.
> 
> I get your point, but I am not trying to implement any link policy
> or eth link specification tunables. For me and maybe other vendors
> this knob makes sense, and Important for the usecase I described.

I think I was alluding to making the link stay up dependent on presence
of BMC / management engine and or some NIC-internal agents. So to give
a trivial example the policy could be:
 - force down
 - leave up if BMC present
 - force up
I don't recall prior discussions TBH so doing more research will be
necessary..

