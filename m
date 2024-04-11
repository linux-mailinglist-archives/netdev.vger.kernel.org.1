Return-Path: <netdev+bounces-87131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118A58A1D67
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 20:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF002288BCB
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 18:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7708C1D8EAC;
	Thu, 11 Apr 2024 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WoWuczK5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537684F200
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855134; cv=none; b=m1aae/HYiHFRsNr5moOszs8hvIlCl+CPI2xV3Q269Msc9n5WTiTd6fOpx6pTTNv+rmF+TXR1pL2RyHkVC69SOGq2clCYT3hCQYe1E93KDOjHDI3wOkw4XxPuIAJq5sdUz6kM5ImNUmFC2yb+OGH7o+z30s9l3ejW67/EwT/fY2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855134; c=relaxed/simple;
	bh=9Lku11rc7ULbmUCsLru3zfEvYbeQNXdZ+Uuyim1nrtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9RsahRtGxfa8epEyzWUoYxmtfq77bAZMpcuuGkLvcNqPLcObfLJadVQSVEEAeyVbOPMdcatdhJ5t/PiSZCBTK7T01lZzJhkfMkRvgtITDu/ecFAp3bU9yRwK4BcNxinRq3cTroBe+PyhwlbrMp/6kfwFIdr8ZORvyLKpdZd5eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WoWuczK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23540C072AA;
	Thu, 11 Apr 2024 17:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712855133;
	bh=9Lku11rc7ULbmUCsLru3zfEvYbeQNXdZ+Uuyim1nrtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WoWuczK5UznPzAlWku112iAoYeMI6fJ07OMW6XHD3imi1VWvB38BtvgF0SFTiWNjc
	 oBEsjrmQnr/74N47pF5+MOrzF4wNSRZgR60JHNDvSpR3d1LZK1TRLWBeMGId3X2IDB
	 sF9IoCTOfshdOiGLsICfHpRqNXTWAkQSirr7k8o2POJGr/sWy10U3r2/hlQxSMuYCT
	 CP8qtDWJNp4TGZ1EYinFDyROxP9VqVilZRthM/FNHXMW3PtH4yawWblL3CUR7oSS7n
	 AwyhsuJ9U7G0cecJdXmgrBWfN2MygUKyB3PKtkaVr4t2na1MnTyauJ3Hs6iNBl6dhG
	 qiLFb+uGq+wyQ==
Date: Thu, 11 Apr 2024 20:05:29 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Paul Wouters <paul@nohats.ca>
Cc: Antony Antony <antony.antony@secunet.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v10 1/3] xfrm: Add Direction to
 the SA in or out
Message-ID: <20240411170529.GQ4195@unreal>
References: <20240411114132.GO4195@unreal>
 <549D487E-8B20-439C-93EB-85E0B3C9A2D7@nohats.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <549D487E-8B20-439C-93EB-85E0B3C9A2D7@nohats.ca>

On Thu, Apr 11, 2024 at 12:20:31PM -0400, Paul Wouters wrote:
> On Apr 11, 2024, at 07:41, Leon Romanovsky via Devel <devel@linux-ipsec.org> wrote:
> > 
> > 
> > I asked it on one of the previous versions, but why do we need this limitation?
> > Update SA is actually add and delete, so if user wants to update
> > direction, it should be allowed.
> 
> An SA can never change direction without dealing with updated SPIs. Logically, it makes no sense. Sure, if you treat SA’s as Linux lego bricks that can be turned into anything, then yeah why not. Why not turn the SA into block device or magic flute?
> 
> If you keep to the RFC, an SA is uni directional. More things might apply too, eg the mode (transport vs tunnel) should not change, sequence numbers can only increase, etc.

Right, and it looks like preventing change of direction is only small
part of larger task - "improve validation of SA updates".

Thanks

> 
> Paul
> 

