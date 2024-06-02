Return-Path: <netdev+bounces-100031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0178D7870
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 23:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D44D1C20AA0
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 21:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB0A6D1A4;
	Sun,  2 Jun 2024 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqI+0szZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EC0210E6
	for <netdev@vger.kernel.org>; Sun,  2 Jun 2024 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717365558; cv=none; b=QD30dsBpPrPqGyAPeILdD4Hb0gkNXy1u6aHLt8du8I8mTUALl7Zw9jSfxIh8zqLZ+YIQ/IMOWuKRh/1fHncePvTLdpVmF7sk+dt9Ef5lzCfuF5se5TTdt0IrfspxGO4zrWh6ahaaOqjLGkkHysgl4zi9UVS2t5aMRlXSj6a9rPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717365558; c=relaxed/simple;
	bh=p/8BwAknmxmeA3Cpda0OfON0xJfyzddJjyTzvJVDoqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QwCatW7pTmCzliTGHi3UBAQmv4qcPpHwen6duLDa8d5+cn4jLjmI8DKL/Wu648RxEzNaEP6mtCbNcbCmmYj7FbnSwoljGtcpnY+zuhJS0il8RoP8fVPJIgUPQl22ogecFV7LYnMLyzj6i0VNJN1KmceolZcBm0jyaPg+ShkU1sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqI+0szZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B08C2BBFC;
	Sun,  2 Jun 2024 21:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717365558;
	bh=p/8BwAknmxmeA3Cpda0OfON0xJfyzddJjyTzvJVDoqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tqI+0szZrN/nZ4rcR6lC1HJS5JpTRSh54FfkM1xYfGB4fnOEMzmsbhg3NkwX9Oodi
	 vmfV3Gfz7DvXPqDb09/t9RNBPNcDZWYQzNHVpUUxSCuAeU3HDHzvP5ZtDfh/GrNFli
	 tWiGi9bgCPrIoStJFnGDvVBCkYRnM9THecFlfqqg56s5TYy3ZnxHCKm91sbQNGi4pw
	 bSNLOxwraz4iClJR6YGFvwmQeMu+ITe0hsrGwhIkfQvnirI2u/aXNmIHhlwDbMEV0r
	 q7AIX9e2vsRtpVYWD66iug1UOzlGVaGNKThXx7ZyklIjkU3zBKGLjfcsMFmL4L+bI/
	 HdCq2hYf0GQYA==
Date: Sun, 2 Jun 2024 14:59:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, Jaroslav
 Pulchart <jaroslav.pulchart@gooddata.com>
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() in
 inet_dump_ifaddr()
Message-ID: <20240602145916.0629c8e2@kernel.org>
In-Reply-To: <ad393197-fd1a-4cd8-a371-f6529419193b@kernel.org>
References: <20240601212517.644844-1-kuba@kernel.org>
	<20240601161013.10d5e52c@hermes.local>
	<20240601164814.3c34c807@kernel.org>
	<ad393197-fd1a-4cd8-a371-f6529419193b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Jun 2024 20:23:17 -0600 David Ahern wrote:
> > The dump partitioning is up to the family. Multiple families
> > coalesce NLM_DONE from day 1. "All dumps must behave the same"
> > is saying we should convert all families to be poorly behaved.
> > 
> > Admittedly changing the most heavily used parts of rtnetlink is very
> > risky. And there's couple more corner cases which I'm afraid someone
> > will hit. I'm adding this helper to clearly annotate "legacy"
> > callbacks, so we don't regress again. At the same time nobody should
> > use this in new code or "just to be safe" (read: because they don't
> > understand netlink).  
> 
> What about a socket option that says "I am a modern app and can handle
> the new way" - similar to the strict mode option that was added? Then
> the decision of requiring a separate message for NLM_DONE can be based
> on the app.

That seems like a good solution, with the helper marking the "legacy"
handlers - I hope it should be trivial to add such option and change
the helper's behavior based on the socket state.

> Could even throw a `pr_warn_once("modernize app %s/%d\n")`
> to help old apps understand they need to move forward.

Hm, do you think people would actually modernize all the legacy apps?

Coincidentally, looking at Jaroslav's traces it appears that the app
sets ifindex for the link dump, so it must not be opting into strict
checking, either.

