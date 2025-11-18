Return-Path: <netdev+bounces-239741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E4BC6BE55
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 23:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66C88364847
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 22:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B082EA46B;
	Tue, 18 Nov 2025 22:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="qEgXLP2w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F8E1F463E;
	Tue, 18 Nov 2025 22:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763506309; cv=none; b=gQhKy1Iwyy8BcO0vklIzF+jMu9RnzbgRqtPsywSdt8HdOTN277DfJZpLoSAGAOTjWbNzjQfMzS6U8vAvupTYgTdzDnjZg2Z67BRNvJxydk81cDYDQVVek/5Z8SOajiqajVKT/PJLQZ+bnYz8bmxcni6KASQppxyB6jEiLMldGQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763506309; c=relaxed/simple;
	bh=TIfiEbjEha/Rga/+ezN2bErZDU+l4fROSy9d/BKpgWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMQbHj8qpQ9dSkqCzNdj1J6ANAA6nXa2/XZ0qKVPnpPknuFd6Ci1twt2ojI7g3NVTYmIQx+Afurp4adPrA+eqtYzD89YFP5ytjg2zG8gJenaaTQ+z/Z2LZUHDqgKplPTcdzd9kPa7+mTsbtXFYWhdPAVz10G+uGcTS9sDidyQW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=qEgXLP2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9234C116D0;
	Tue, 18 Nov 2025 22:51:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="qEgXLP2w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1763506303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S07VNy/zEM63OV3uJY0CtmcySAf2auNYU/AgFnxHr/0=;
	b=qEgXLP2weHRZDEvKAEhq+kBI2v6LxD6X+Py/fVfEkrwIfKw2gWQzyKg/0OnWTw60xmA5L9
	iumVgcRHZg4eTsfNQL9CtnJYPnWrQ3xTTzJAr0CJ7tr7jQF/I1dE2377wOyDK872zHUlZa
	WS/0zBoUIvmim9YZkFpXq9VTb/nE440=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 23a19fe4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Nov 2025 22:51:42 +0000 (UTC)
Date: Tue, 18 Nov 2025 23:51:37 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>
Subject: Re: [PATCH net-next v3 11/11] wireguard: netlink: generate netlink
 code
Message-ID: <aRz4eVCjw_JUXki6@zx2c4.com>
References: <20251105183223.89913-1-ast@fiberby.net>
 <20251105183223.89913-12-ast@fiberby.net>
 <aRyNiLGTbUfjNWCa@zx2c4.com>
 <d2e84a2b-74cd-44a1-97a6-a10ece7b4c5f@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2e84a2b-74cd-44a1-97a6-a10ece7b4c5f@fiberby.net>

On Tue, Nov 18, 2025 at 10:23:12PM +0000, Asbjørn Sloth Tønnesen wrote:
> On 11/18/25 3:15 PM, Jason A. Donenfeld wrote:
> > On Wed, Nov 05, 2025 at 06:32:20PM +0000, Asbjørn Sloth Tønnesen wrote:
> >>   drivers/net/wireguard/netlink_gen.c | 77 +++++++++++++++++++++++++++++
> >>   drivers/net/wireguard/netlink_gen.h | 29 +++++++++++
> >>   create mode 100644 drivers/net/wireguard/netlink_gen.c
> >>   create mode 100644 drivers/net/wireguard/netlink_gen.h
> >> +#include "netlink_gen.h"
> >> +// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> >> +/* Do not edit directly, auto-generated from: */
> >> +/*	Documentation/netlink/specs/wireguard.yaml */
> >> +/* YNL-GEN kernel source */
> > 
> > Similar to what's happening in the tools/ynl/samples build system,
> > instead of statically generating this, can you have this be generated at
> > build time, and placed into a generated/ folder that doesn't get checked
> > into git? I don't see the purpose of having to manually keep this in
> > check?
> > 
> > (And if for some reason, you refuse to do that, it'd be very nice if the
> >   DO NOT EDIT header of the file also had the command that generated it,
> >   in case I need to regenerate it later and can't remember how it was
> >   done, because I didn't do it the first time, etc. Go's generated files
> >   usually follow this pattern.
> > 
> >   But anyway, I think I'd prefer, if it's possible, to just have this
> >   generated at compile time.)
> 
> The main value in having the generated kernel code in git, is that it can't
> change accidentally, which makes it easy for patchwork to catch if output
> changes without being a part of the commit.
> 
> I will leave it up to Donald and Jakub, if they want to allow these files to
> be generated on-the-fly.

I mean, there is *tons* of generated code in the kernel. This is how it
works. And you *want the output to change when the tool changes*. That's
literally the point. It would be like if you wanted to check in all the
.o files, in case the compiler started generating different output, or
if you wanted the objtool output or anything else to be checked in. And
sheerly from a git perspective, it seems outrageous to touch a zillion
files every time the ynl code changes. Rather, the fact that it's
generated on the fly ensures that the ynl generator stays correctly
implemented. It's the best way to keep that code from rotting.

Jason

