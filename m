Return-Path: <netdev+bounces-239301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF2BC66AF6
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 01:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 8C65529166
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 00:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA09269806;
	Tue, 18 Nov 2025 00:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CU1lcHAw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1CD134CF;
	Tue, 18 Nov 2025 00:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763426624; cv=none; b=nokzIhry6WcCBIvH8LLcpdyZ8zKQ9jvXIb1lM5rdSjPpvgSb7bdeF0dWhZEUcl9Z2goucFiQJRNL495nK2feh/Sdye3KHMddBP2D7naKSyM5F4LJbSI2E7Sepk6Ywo94bfKlBC4kAOQmoyAj4jLlnDBA3pH4aytT35oacImExLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763426624; c=relaxed/simple;
	bh=CSFZAdTYrevegC7XTq56D+EgM1dZWxxQCwyRl+RdqeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlrXG/a/NhMddrO5gGRXSm6sTr2OuBXnhemeWeFReWk4MNW2XjN+bBil2z6aMCWGYtr6ro28sX4vcoPZUa+tPNjmdn/BrsYhueYB8MwrBGGxKR73KbC7a+D3dOQBr22VuCf4nIoQ06y8WzE0z/wRD0MVs1yRbItCbx/0L9EGq4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=CU1lcHAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EE0C4AF0B;
	Tue, 18 Nov 2025 00:43:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="CU1lcHAw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1763426619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMKGQwFbGC9Wgvpt95lJSohz33kV6/eDvcxgRAGJqo4=;
	b=CU1lcHAw6UsM6Q+HRcXQtoEbcZhSu18KtHBPqbJPvGkTDLoWjBAy8nsXs0lUYN0t3oVtMg
	YOGsAFcA3K0X2oEsFZ7qPwf8+eEUJbzcQkwO/Z5WATh6nMwnRhEERF3d4On8k8rGeFPGjI
	+YmDW4bMHRgLmepFDiQ0xiFQGFha7W0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 239c5921 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Nov 2025 00:43:38 +0000 (UTC)
Date: Tue, 18 Nov 2025 01:43:37 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>
Subject: Re: [PATCH net-next v3 00/11] wireguard: netlink: ynl conversion
Message-ID: <aRvBOWHU5Zow65HD@zx2c4.com>
References: <20251105183223.89913-1-ast@fiberby.net>
 <20251110180746.4074a9ca@kernel.org>
 <aRQGIhazVqTdS2R_@zx2c4.com>
 <20251117161439.1dedf4b6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251117161439.1dedf4b6@kernel.org>

On Mon, Nov 17, 2025 at 04:14:39PM -0800, Jakub Kicinski wrote:
> On Wed, 12 Nov 2025 04:59:30 +0100 Jason A. Donenfeld wrote:
> > On Mon, Nov 10, 2025 at 06:07:46PM -0800, Jakub Kicinski wrote:
> > > On Wed,  5 Nov 2025 18:32:09 +0000 Asbjørn Sloth Tønnesen wrote:  
> > > > This series completes the implementation of YNL for wireguard,
> > > > as previously announced[1].
> > > > 
> > > > This series consist of 5 parts:
> > > > 1) Patch 01-03 - Misc. changes
> > > > 2) Patch    04 - Add YNL specification for wireguard
> > > > 3) Patch 05-07 - Transition to a generated UAPI header
> > > > 4) Patch    08 - Adds a sample program for the generated C library
> > > > 5) Patch 09-11 - Transition to generated netlink policy code
> > > > 
> > > > The main benefit of having a YNL specification is unlocked after the
> > > > first 2 parts, the RFC version seems to already have spawned a new
> > > > Rust netlink binding[2] using wireguard as it's main example.
> > > > 
> > > > Part 3 and 5 validates that the specification is complete and aligned,
> > > > the generated code might have a few warts, but they don't matter too
> > > > much, and are mostly a transitional problem[3].
> > > > 
> > > > Part 4 is possible after part 2, but is ordered after part 3,
> > > > as it needs to duplicate the UAPI header in tools/include.  
> > > 
> > > These LGTM, now.
> > > 
> > > Jason what's your feeling here? AFAICT the changes to the wg code
> > > are quite minor now.   
> > 
> > Reviewing it this week. Thanks for bumping this in my queue.
> 
> Sadness. We wait a week and no review materializes. I think the patches
> are fine so I'll apply them shortly. The expected patch review SLA for
> netdev sub-maintainers is 24h (excluding weekends and holidays)
> https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html

Sadness indeed. I've had some urgent matters come up, but this is now
top of the stack, and I've given it a quick preliminary pass. I'd
planned to take this through my wg tree.

Jason

