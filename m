Return-Path: <netdev+bounces-240215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1905CC719E3
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 01:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B3F84342025
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 00:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A7021257E;
	Thu, 20 Nov 2025 00:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YjwsnnoZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDB71A76BB;
	Thu, 20 Nov 2025 00:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763600096; cv=none; b=fwxjFS8hwCpN0YjN64yXjV3WvMvgHsA5kT3C4PNXxaqEKXi+56GSqfcqO9HXV3La3apsY7hHIkyyLKn/o7gPRFV2TbIAaTtPBoXXi6MPjCBXD7KLFi45BU4d4bGQRSgoi02HqwqvXhXysOweuQBdtoS7jVbiYBRnAl6cHzFi3aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763600096; c=relaxed/simple;
	bh=8b+S7Fre6XU2fQeNUcxdlk7zzMBS/MD1IpaEk8Aw1yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/gRjHE0yxufM2nUZSBraa2aZy4EiY0/yU/kByoYZ5R2SfLeobzvjYRwIkNfWjBz5HmnBfogqeAyOAyspt2rLVsUltgcPJIoxfXpUiq/1yYYdHgmHMuTV6HrvbsMg0KWF/AXPTIsQlOTe7sFT+2kUSblD5rUmXF0vY6/WhiUd18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=YjwsnnoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAFAC4CEF5;
	Thu, 20 Nov 2025 00:54:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YjwsnnoZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1763600093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nMOmny8d8deudNAgvKqA5B6ZSfjuWQary3xMXoxOMW0=;
	b=YjwsnnoZ/Qs/xgonwxaFwi7W5/6A3KZjh1E6M/wVCndmJvrPt2DtS4er7b6cOas4Z8lbUW
	5D5okw/FU3nqyStAZMQI6hJJAgx2SGKkqTN9BYbpLZokiq+riAwOY1lNkjcfdHMYoKoGpo
	1wOApy/x7JzLigkc/uPs6BiGe1PCU80=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id eadb20d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Nov 2025 00:54:52 +0000 (UTC)
Date: Thu, 20 Nov 2025 01:54:47 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
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
Message-ID: <aR5m174O7pklKrMR@zx2c4.com>
References: <20251105183223.89913-1-ast@fiberby.net>
 <20251105183223.89913-12-ast@fiberby.net>
 <aRyNiLGTbUfjNWCa@zx2c4.com>
 <d2e84a2b-74cd-44a1-97a6-a10ece7b4c5f@fiberby.net>
 <aRz4eVCjw_JUXki6@zx2c4.com>
 <20251118170045.0c2e24f7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251118170045.0c2e24f7@kernel.org>

On Tue, Nov 18, 2025 at 05:00:45PM -0800, Jakub Kicinski wrote:
> On Tue, 18 Nov 2025 23:51:37 +0100 Jason A. Donenfeld wrote:
> > I mean, there is *tons* of generated code in the kernel. This is how it
> > works. And you *want the output to change when the tool changes*. That's
> > literally the point. It would be like if you wanted to check in all the
> > .o files, in case the compiler started generating different output, or
> > if you wanted the objtool output or anything else to be checked in. And
> > sheerly from a git perspective, it seems outrageous to touch a zillion
> > files every time the ynl code changes. Rather, the fact that it's
> > generated on the fly ensures that the ynl generator stays correctly
> > implemented. It's the best way to keep that code from rotting.
> 
> CI checks validate that the files are up to date.
> There has been no churn to the kernel side of the generated code.
> Let's be practical.

Okay, it sounds like neither of you want to do this. Darn. I really hate
having generated artifacts laying around that can be created efficiently
at compile time. But okay, so it goes. I guess we'll do that.

I would like to ask two things, then, which may or may not be possible:

1) Can we put this in drivers/net/wireguard/generated/netlink.{c.h}
   And then in the Makefile, do `wireguard-y += netlink.o generated/netlink.o`
   on one line like that. I prefer this to keeping it in the same
   directory with the awkward -gen suffix.

2) In the header of each generated file, automatically write out the
   command that was used to generate it. Here's an example of this good
   habit from Go: https://github.com/golang/go/blob/master/src/syscall/zsyscall_linux_amd64.go

Jason

