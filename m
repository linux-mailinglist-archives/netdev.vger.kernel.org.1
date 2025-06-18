Return-Path: <netdev+bounces-199245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A526ADF8BA
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 23:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F57D178613
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 21:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936C227A935;
	Wed, 18 Jun 2025 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvqJjFEF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A04D1B78F3;
	Wed, 18 Jun 2025 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750282062; cv=none; b=Ydh1eWrd6pTYK4s0NbB5TMAB9LhnAvkEaDGJOzkBSvQ90VdSvAhGSYOtuTe3IYf2zLVLbqW/tzfub07wW9K904nrESht+ZOKoehR+/tvCq41K3JQ4JAk8t1NBKUnh49Ol1xj69Wafermv9IxZGwI51aeXUDtqSFe4RIj4Dfkbkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750282062; c=relaxed/simple;
	bh=oPxq0nX9YaRrg5ryLM85TKzyoC0Q/WSIiKqdSGONZE0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXP9EELEm3iJk7l1Y0GG4JIBh/XnLKnLXYzZ+eVH0Q2mJi+VcMgJHLqDOnIEN8KA5d5iKYt2DZqXfvuaNi3Y4d/mQ4TzVBMsTKOppXqjW1gBdhuvdektu16pk/Y8+GQE4CqgK6Ci2RBfJGJitez5rEHeN8SvF9hBBErUg50mKTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvqJjFEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95919C4CEE7;
	Wed, 18 Jun 2025 21:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750282061;
	bh=oPxq0nX9YaRrg5ryLM85TKzyoC0Q/WSIiKqdSGONZE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XvqJjFEF3slokQpe5oESAULdrxwFBepSGJk8qBsx66ZNL9rP96u0oV9EXrb8X2Oe+
	 SAd5PUAo88TZiwqfPl03m7vresQzPLtSb86tdTWy6r4jHzPdxDdnmc7mUoxo5QIVI/
	 JF0HdO+AseVqM+U84yCm2tGTPWj0BdLMc1JCvg3vHruNKbAtH+GUbtdx/0d3ZWRe1z
	 7+0pV9PMYqwPwEpDH4MnLbnK2kLb0GG6BP683kJd+GoPGwJjgBjffQbXFVeF5Nq9iq
	 Ceb12pXZh+ZoGt7VLfEa9ZHSgtNra5wxAqAsOyg81uj0GX3ka5fcy7S2bfMVpvgmSe
	 uO0IpFkW3jNKg==
Date: Wed, 18 Jun 2025 14:27:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>, Stanislav Fomichev
 <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, ap420073@gmail.com
Subject: Re: [PATCH net v1] netmem: fix skb_frag_address_safe with
 unreadable skbs
Message-ID: <20250618142740.65203c69@kernel.org>
In-Reply-To: <CAHS8izOMfmj6R8OReNqvoasb_b0M=gsnrCOv3budBRXrYjO67g@mail.gmail.com>
References: <20250617210950.1338107-1-almasrymina@google.com>
	<CAHS8izMWiiHbfnHY=r5uCjHmDSDbWgsOOrctyuxJF3Q3+XLxWw@mail.gmail.com>
	<aFHeYuMf_LCv6Yng@mini-arch>
	<CAHS8izOMfmj6R8OReNqvoasb_b0M=gsnrCOv3budBRXrYjO67g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 14:52:17 -0700 Mina Almasry wrote:
> > > Sorry, I realized right after hitting send, I'm missing:
> > >
> > > Fixes: 9f6b619edf2e ("net: support non paged skb frags")
> > >
> > > I can respin after the 24hr cooldown.  
> >
> > The function is used in five drivers, none of which support devmem tx,
> > does not look like there is a reason to route it via net.
> >
> > The change it self looks good, but not really sure it's needed.
> > skb_frag_address_safe is used in some pass-data-via-descriptor-ring mode,
> > I don't see 'modern' drivers (besides bnxt which added this support in 2015)
> > use it.  
> 
> Meh, a judgement call could be made here.  I've generally tried to
> make sure skb helpers are (unreadable) netmem compatible without a
> thorough analysis of all the callers to make sure they do or will one
> day use (unreadable) netmem. Seems better to me to fix this before
> some code path that plumbs unreadable memory to the helper is actually
> merged and that code starts crashing.

Fair points, tho I prefer the simple heuristic of "can it trigger on
net", otherwise it's really easy to waste time pondering each single
patch. I'll apply to net-next as is. Stanislav, do you want to ack?

