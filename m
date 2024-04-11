Return-Path: <netdev+bounces-86990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD3B8A13AB
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 13:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07BA6B20A92
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2056E14AD3B;
	Thu, 11 Apr 2024 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNSUZZdW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF69014B06B
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836562; cv=none; b=oRm54+j/zNpTHSVbM9CQF+lTURSdnBtOIv4APIknaajL5tvKDq8lU+pUDXJglv/5LP1iWfw2stwToLrjeJAULvDWPNTIFykccJ/sosi3V4+XBL3szIwJRIBNnp9nSM9vimONEyvn/nc6k4G+8s2QEHXphnVuR0QCTmP377IdnS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836562; c=relaxed/simple;
	bh=45n4QPkTxS4+VQo6cLSlB1JF/CKypi42AGMrySpett4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYQCTUjqm10UWWppFdqbr8U2lzF0c84gBXNPOXDzWkdQGcLGo78j26dL2PjJwWcprveMVc6+PJp4mjvCgE2iof1EEq9l8QZfTbXjS01+ONBc6rvZfQGx1cTfo/xD61IFp5HBVtRz8KQnFBgqBpvy9rwDE801omd6hLpe/OjbAiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNSUZZdW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3E6C433F1;
	Thu, 11 Apr 2024 11:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712836561;
	bh=45n4QPkTxS4+VQo6cLSlB1JF/CKypi42AGMrySpett4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZNSUZZdWgZEElYUTVkLAQnGWpIqa9emWeUOK2B8d9P+JDvBJpZjpl6YTsJu9wsJ7n
	 +dVEGXMOsze4yjPAwHUlhZIzMbUUNZW/n5IpxD28N0affjUXzGxIKLYjKeXsHDZdBF
	 xLDD7C+Q7wWsYV5+/fsD3IReHZ1mJgAeThxOT0TxG5uZ2iv9NtfNsB2m2yMAcasWcA
	 /RyX2C1pqbaoCCH0p3l95MZjDzuDZ+PJcJAb3TlBQyUFtegBlQc88rjpU/KD02+E48
	 c41L+6WK4Ay4o9wTEoes07KABu+XKErLydUJzs7Tyyi95fjykGDOEyX8tgXVlXjHxk
	 sRGuOPKIt7H+A==
Date: Thu, 11 Apr 2024 14:55:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Antony Antony <antony@phenome.org>
Cc: antony.antony@secunet.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v8] xfrm: Add Direction to the
 SA in or out
Message-ID: <20240411115557.GP4195@unreal>
References: <9e2ddbac8c3625b460fa21a3bfc8ebc4db53bd00.1712684076.git.antony.antony@secunet.com>
 <20240411103740.GM4195@unreal>
 <ZhfEiIamqwROzkUd@Antony2201.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhfEiIamqwROzkUd@Antony2201.local>

On Thu, Apr 11, 2024 at 01:07:52PM +0200, Antony Antony via Devel wrote:
> On Thu, Apr 11, 2024 at 01:37:40PM +0300, Leon Romanovsky via Devel wrote:
> > On Tue, Apr 09, 2024 at 07:37:20PM +0200, Antony Antony via Devel wrote:
> > > This patch introduces the 'dir' attribute, 'in' or 'out', to the
> > > xfrm_state, SA, enhancing usability by delineating the scope of values
> > > based on direction. An input SA will now exclusively encompass values
> > > pertinent to input, effectively segregating them from output-related
> > > values. This change aims to streamline the configuration process and
> > > improve the overall clarity of SA attributes.
> > > 
> > > This feature sets the groundwork for future patches, including
> > > the upcoming IP-TFS patch.
> > > 
> > > v7->v8:
> > >  - add extra validation check on replay window and seq
> > >  - XFRM_MSG_UPDSA old and new SA should match "dir"
> > 
> > Why? Update is add and delete operation, and one can update any field
> > he/she wants, including direction.
> 
> Update operations are not strictly necessary without IKEv2. However, during
> IKEv2 negotiation, updating "in" SA becomes essential.

The thing is if you want to limit update routine to fit IKEv2 only, or
continue to allow users to do whatever they want with netlink and their
own applications without *swan.

I don't have knowledge about such users, just remember seeking tons of
guides how to setup IPsec tunnel with iproute2 and scripts, one of them
can be potentially broken by this change.

Thanks

