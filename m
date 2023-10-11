Return-Path: <netdev+bounces-40055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5347C593A
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B091C20D64
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D22718E1E;
	Wed, 11 Oct 2023 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dEnE6AAc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0C520308
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D029C433C7;
	Wed, 11 Oct 2023 16:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697042051;
	bh=4mdgp90reJQLwSBHmNMedq4n11VgpMgemwkNbEiLRJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dEnE6AAcHRzpDx4e2A9C8G/AGAI3xhXtvy8JeAiSPkkxsXj9XmGQfv/KOVcQAY/r4
	 0x3mppagUsbggdrOJVz2ZJvCcachpjlDiEMotMt6DLnnxF2zX63kw7SbeWgjjJcZme
	 DV3j9ZTTIUIVIHl3AyF02smIturQE6UR2BD0XQAjfxO1vn1uBCsnclzGKnvd5vhUP0
	 SdqzvfYy+cuaQW17M0FzKv+9z4PaFDUlcc5mvgKiBxQVj1GKngJ0AgI+roAppbCBb0
	 Atcv30D8lAts9SOzBQmYumdmf0UNck/fTmbf7t8/id5oQciwpj8iaMoaSPPyu/Yv4b
	 y7YlHY5e5depQ==
Date: Wed, 11 Oct 2023 09:34:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 nicolas.dichtel@6wind.com, fw@strlen.de, pablo@netfilter.org,
 mkubecek@suse.cz, aleksander.lobakin@intel.com
Subject: Re: [RFC] netlink: add variable-length / auto integers
Message-ID: <20231011093410.6c330161@kernel.org>
In-Reply-To: <1335ccffdaaa5a553717e42a855bba1a6f36dc9b.camel@sipsolutions.net>
References: <20231011003313.105315-1-kuba@kernel.org>
	<ZSanRz7kV1rduMBE@nanopsycho>
	<20231011091624.4057e456@kernel.org>
	<1335ccffdaaa5a553717e42a855bba1a6f36dc9b.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 18:21:47 +0200 Johannes Berg wrote:
> > > It's a bit confusing, perheps better just to use nla_put() here as well?  
> > 
> > I want to underscore the equivalency to u32 for smaller types.  
> 
> ITYM "smaller values".

Right, sorry.

> Now I'm wondering if we should keep ourselves some option of going to
> even bigger values (128 bits) in some potential future, but I guess
> that's not really natively supported anywhere in the same way 64-bit is
> supposed on 32-bit.

I was wondering the same. And in fact that's what kept me from posting
this patch for like a year. Initially I was envisioning a Python-style
bigint, then at least a 128b int, then I gave up.

The problem is I have no idea how to handle large types in C.
Would nla_get_uint() then return uint128_t?  YNL also needs to turn the
value into the max width type and put it in a "parsed response struct".
Presumably that'd also have to render all uints as uint128_t..

If we can't make the consumers reliably handle 128b there's no point 
in pretending that more than 64b can be carried. 
I'm not even sure if all 32b arches support u128.

Given that we have 0 uses of 128b integers in netlink today, I figured
we're better off crossing that bridge when we get there..

