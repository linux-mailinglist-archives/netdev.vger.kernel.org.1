Return-Path: <netdev+bounces-239611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D64C6A373
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id C038B2B2BF
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503F73624A5;
	Tue, 18 Nov 2025 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jgKbMy0G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D56361DD5;
	Tue, 18 Nov 2025 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763478444; cv=none; b=uZsUbhItmwZswDBJrhvqQJNmWGW+2ZIioUhsL5bA3ZZ4HOEmxbH9bGk6BuYi1znb7g03dXRpDWwks/hw9fbaWP+WGTlRdr5P1OVYRoEWa4k0KHVlhjDEIptkXExzYHdwnnRnZ8M1fdNtj7qvWxmQxL84uV4Fq5RleNwaTTiDdws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763478444; c=relaxed/simple;
	bh=FpptKdkktnbV8lRUcTA1teIsHADXy8g/clxAqoJyvJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGcAY3kaaxBYbMZfwjBADuc263XfITfFGVELzq3LoKNshszqi96RjgOBggDXyRJv9K8hgIhyMj3PD0n84nD599tQW5V3d8XHPFi/GWCGN4FaRtoX1znOmvnwX1od0x4X+XjYHNxYk7wSBQijSY1KqQTs9S3DSKNg4lyYeOI8RNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=jgKbMy0G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A02DC19421;
	Tue, 18 Nov 2025 15:07:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jgKbMy0G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1763478441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=53GxV1m13oe/UtuCSpAIXdwfKKfevX1hM7SglRWeFhg=;
	b=jgKbMy0GRSj2r+dK8VJmSIG/2/gxb49bq2aKGNSF2CYuwt21WNR9y1pJLu+mdh5xWpXWJx
	UmLdIKXt6MwZD7bfwYcHbTpNQUln9sh3jkL8NPgTK0Y/3nquvgge0UNLZp92FvXOMjCMoB
	TlQObx//+1GE5yoIUWhkjVWI/VbvdCQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b78eff9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Nov 2025 15:07:20 +0000 (UTC)
Date: Tue, 18 Nov 2025 16:07:15 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jordan Rife <jordan@jrife.io>
Subject: Re: [PATCH net-next v3 04/11] netlink: specs: add specification for
 wireguard
Message-ID: <aRyLoy2iqbkUipZW@zx2c4.com>
References: <20251105183223.89913-1-ast@fiberby.net>
 <20251105183223.89913-5-ast@fiberby.net>
 <aRvWzC8qz3iXDAb3@zx2c4.com>
 <f21458b6-f169-4cd3-bd1b-16255c78d6cd@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f21458b6-f169-4cd3-bd1b-16255c78d6cd@fiberby.net>

Hi Asbjørn,

On Tue, Nov 18, 2025 at 12:08:20PM +0000, Asbjørn Sloth Tønnesen wrote:
> > I'll need to do my own reading, I guess, but what is going on with this
> > "legacy" business? Is there some newer genetlink that falls outside of
> > versioning?
> 
> There's a few reasons why the stricter genetlink doesn't fit:
> - Less flexible with C naming (breaking UAPI).
> - Doesn't allow C struct types.
> 
> diff -Naur Documentation/netlink/genetlink{,-legacy}.yaml

Oh, thanks, useful diff. So the protocol didn't change, persay, but the
non-legacy one just firms up some of the floppiness of what was done
before. Makes sense.

> > There's lots of control over the C output here. Why can't there also be
> > a top-level c-function-prefix attribute, so that patch 10/11 is
> > unnecessary? Stack traces for wireguard all include wg_; why pollute
> > this with the new "wireguard_" ones?
> 
> It could also be just "c-prefix".

Works for me.

> >> +      dump:
> >> +        pre: wireguard-nl-get-device-start
> >> +        post: wireguard-nl-get-device-done
> > 
> > Oh, or, the wg_ prefix can be defined here (instead of wireguard_, per
> > my 10/11 comment above).
> 
> The key here is the missing ones, I renamed these for alignment with
> doit and dumpit which can't be customized at this time.

Oh, interesting. So actually, the c-prefix thing would let you ditch
this too, and it'd be more consistent.

> > On the other hand, maybe that's an implementation detail and doesn't
> > need to be specified? Or if you think rigidity is important, we should
> > specify 0 in both directions and then validate it to ensure userspace
> > sends 0 (all userspaces currently do).
> 
> As is, the YNL-based clients are taking advantage of it not being validated.
> Changing that would require adding some new YNL type properties.
> See this series[1] for my earlier attempt to extend YNL in this area.
> 
> [1] https://lore.kernel.org/r/20251022182701.250897-1-ast@fiberby.net/
> 
> The modern way would be to use multi-attrs, but I don't think it's worth it
> to transition, you mainly save a few bytes of overhead.

Oh, huh, interesting. In libmnl, this parameter is referred to as "type"
instead of index, so it was natural to stick 0 there. It looks like so
does Go's netlink library, but in wgctrl-go, Matt stuck index there.

So... darn. We're stuck with this being poorly defined. I guess we can
have as the text something like:

    The index/type parameter is unused on SET_DEVICE operations and is zero on GET_DEVICE operations.

> WGDEVICE_A_IFINDEX
> WGDEVICE_A_PEERS2: NLA_NESTED
>    WGPEER_A_PUBLIC_KEY
>    [..]
>    WGPEER_A_ALLOWEDIPS2: NLA_NESTED
>      WGALLOWEDIP_A_FAMILY
>      [..]
>    WGPEER_A_ALLOWEDIPS2: NLA_NESTED
>      WGALLOWEDIP_A_FAMILY
>      [..]
> WGDEVICE_A_PEERS2: NLA_NESTED
>    [..]

Def not worth it. But good to know about for future protocols.

> >> +        While this command does accept the other ``WGDEVICE_A_*``
> >> +        attributes, for compatibility reasons, but they are ignored
> >> +        by this command, and should not be used in requests.
> > 
> > Either "While" or ", but" but not both.
> > 
> > However, can we actually just make this strict? No userspaces send
> > random attributes in a GET. Nothing should break.
> 
> I agree that nothing should break, just tried to avoid changing UAPI in the
> spec commit, but by moving the split ops conversion patch, then I can eliminate
> this before adding the spec.

Okay, great, let's do that.

Thanks a bunch.

Jason

