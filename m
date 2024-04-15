Return-Path: <netdev+bounces-88083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 356D18A5999
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 20:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64EE11C20D55
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 18:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772D4139CEC;
	Mon, 15 Apr 2024 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qX4ZzWXn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523B612C46D
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713204774; cv=none; b=LcQhM+LPYqTOr2rEGNMvbbiPcPWKdLgdk6xPIEocJ5pbtubcQRG6LMhf4QFR7kMie/m8/kpMf8VCsDt9Ou/jf4vyEdEGxUtAECeL2by0QgpHbqNbDbOzkYaCfsxVveOIDg39IbMTZxFucnFBtqywmdV0rvFZzXsarLS6W9lNNAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713204774; c=relaxed/simple;
	bh=YAS67SQS9G8zoRIB3qYXj+8B/wEUrOF3rTcWOl5OqwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e//9OqY1yCLlJjv4FC1Twj08tkNf2/GG8nHKdNuYVKQxr65Ehy5+5fPetIvdcfJSWjGSPcjkAH10AfAGtXh+b9+M3fPMTHhaKhm7c3dpBVXA4trhfH0lQEWA9HlqKQKyRkQ6RWkCkAXIHffE1V/bsUEuopukf/FBnFhNfrTGp6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qX4ZzWXn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F408FC113CC;
	Mon, 15 Apr 2024 18:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713204773;
	bh=YAS67SQS9G8zoRIB3qYXj+8B/wEUrOF3rTcWOl5OqwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qX4ZzWXnhyziD5Tr9s/4jE5NJcJeu1CaVE4XPthOy84IT8F9r3/G3uTcrcT3VH5CA
	 2ZYK70rHMFHxlBR/kN3oqtXssBCE6+YMhXq576QpQLk9hefZEeIym3UcZF/u7Co5D6
	 FQqNeGIdlRaWr+lFqF8jEi/va11Uft2xkmkuTt3tO2+gDvIDehTjXvJiJUepPzCZFS
	 SS4lqmA7xKZYdGt0KTNsKRPJjVOdTuM3bd4SyG79DGQU8XDJ/R5kVLOAiu4Sz31wK3
	 /Cy/5LUi96AYovX6n/1/22DzA3JTcFbB4KgwbdV0NUm2tjOaTQzxFSh4fqM1Y3/B1X
	 MZ4YCVs+R5uQw==
Date: Mon, 15 Apr 2024 21:12:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Antony Antony <antony@phenome.org>, antony.antony@secunet.com,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v8] xfrm: Add Direction to the
 SA in or out
Message-ID: <20240415181248.GB6832@unreal>
References: <9e2ddbac8c3625b460fa21a3bfc8ebc4db53bd00.1712684076.git.antony.antony@secunet.com>
 <20240411103740.GM4195@unreal>
 <ZhfEiIamqwROzkUd@Antony2201.local>
 <20240411115557.GP4195@unreal>
 <ZhhBR5wTeDAHms1A@hog>
 <20240414104500.GT4195@unreal>
 <Zhz1DmZZCrMq__B_@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zhz1DmZZCrMq__B_@hog>

On Mon, Apr 15, 2024 at 11:36:15AM +0200, Sabrina Dubroca wrote:
> 2024-04-14, 13:45:00 +0300, Leon Romanovsky wrote:
> > On Thu, Apr 11, 2024 at 10:00:07PM +0200, Sabrina Dubroca wrote:
> > > 2024-04-11, 14:55:57 +0300, Leon Romanovsky wrote:
> > > > On Thu, Apr 11, 2024 at 01:07:52PM +0200, Antony Antony via Devel wrote:
> > > > > On Thu, Apr 11, 2024 at 01:37:40PM +0300, Leon Romanovsky via Devel wrote:
> > > > > > On Tue, Apr 09, 2024 at 07:37:20PM +0200, Antony Antony via Devel wrote:
> > > > > > > This patch introduces the 'dir' attribute, 'in' or 'out', to the
> > > > > > > xfrm_state, SA, enhancing usability by delineating the scope of values
> > > > > > > based on direction. An input SA will now exclusively encompass values
> > > > > > > pertinent to input, effectively segregating them from output-related
> > > > > > > values. This change aims to streamline the configuration process and
> > > > > > > improve the overall clarity of SA attributes.
> > > > > > > 
> > > > > > > This feature sets the groundwork for future patches, including
> > > > > > > the upcoming IP-TFS patch.
> > > > > > > 
> > > > > > > v7->v8:
> > > > > > >  - add extra validation check on replay window and seq
> > > > > > >  - XFRM_MSG_UPDSA old and new SA should match "dir"
> > > > > > 
> > > > > > Why? Update is add and delete operation, and one can update any field
> > > > > > he/she wants, including direction.
> > > > > 
> > > > > Update operations are not strictly necessary without IKEv2. However, during
> > > > > IKEv2 negotiation, updating "in" SA becomes essential.
> > > > 
> > > > The thing is if you want to limit update routine to fit IKEv2 only, or
> > > > continue to allow users to do whatever they want with netlink and their
> > > > own applications without *swan.
> > > > 
> > > > I don't have knowledge about such users, just remember seeking tons of
> > > > guides how to setup IPsec tunnel with iproute2 and scripts, one of them
> > > > can be potentially broken by this change.
> > > 
> > > Nothing is going to break with this change. Old scripts and old
> > > userspace software are not providing XFRMA_SA_DIR, so none of the new
> > > checks apply.
> > 
> > Right, but what about new iproute2, which eventually will users get
> > after system update and old scripts?
> 
> I suspect that new iproute2 will add an option to set the direction
> (otherwise it'd have to guess a value, that's not the goal of xfrm
> support in iproute), and only pass XFRMA_SA_DIR when the user gave
> that extra argument, so nothing will change there either?

Correct, thanks for the clarification.

> 
> -- 
> Sabrina
> 

