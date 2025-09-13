Return-Path: <netdev+bounces-222759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CDCB55DCF
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 04:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF881B28048
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 02:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33421CEAA3;
	Sat, 13 Sep 2025 02:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u11hH6F1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD8F1547CC
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 02:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757729223; cv=none; b=cEJ3LpMUYJj+eOs1vqIlOyNmGGVL/3Fsyf8unejCCTREW/GW0toGwDrTMW/54bV6ta+5JSC45LLqdcym91Ucakwl45NoAgg+4krFAWU9gD5HzMt8SfMP4H4MTr2b95paxWjP9V+oiGomEKAx22KR+rxm/NtjRrwMVpIevu/avrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757729223; c=relaxed/simple;
	bh=0cayYewHGOUZSUCCiG23g6pGHVJnAjiYdiV9qEvqqF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfZyFLEohM/yBgFOlT9dR7224P1hXfGoJrsJr9YlAM2mfr0fQjUgYcftzJGhR09I8J52KNUASNh10+xqbYFNZrG8vZlMNsTmBvYWYeiGocVIM4s+RH6hzEILEjmNbXYwM+2bAG9fSBxbul0qa24P4Ux3+YmliAoZgfEJ6blyinc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u11hH6F1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83A9C4CEF1;
	Sat, 13 Sep 2025 02:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757729223;
	bh=0cayYewHGOUZSUCCiG23g6pGHVJnAjiYdiV9qEvqqF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u11hH6F1eTtgVBiKXFhAW6Y3piqKR8nM4dZTf+fL/TwsQHARoqLWEEG8iudC89Wcd
	 v4YFgEfF+7CmdOStWCEIQ2mbJoXsnEKpclHVEAF89SLeRgchtFOSMdButaXD7dZR4r
	 GRTuYxd2MhrlWinH7D7VtlzNEp0KQMr+atkB3P1cHoKkdC3QaDM/G0UKNA3NqQG4sA
	 Vs/d2fa3HA69Jhc8+DavzhXhqxLxSPDfrg0M/sR7P+rTRwbXybVXGHPPs49Eem8a2I
	 IXCPxiWC344kAH+weMUSyt9wDQySCGhPPlgnAlSiEHSyNiii/zDvaXik+hALtlm7Kd
	 Wl4SQMLjlG81g==
Date: Fri, 12 Sep 2025 19:07:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin Karsten <mkarsten@uwaterloo.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com, Joe Damato
 <joe@dama.to>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v9 0/2] Add support to do threaded napi busy
 poll
Message-ID: <20250912190702.3d0309a0@kernel.org>
In-Reply-To: <17e52364-1a8a-40a4-ba95-48233d49dc30@uwaterloo.ca>
References: <20250911212901.1718508-1-skhawaja@google.com>
	<17e52364-1a8a-40a4-ba95-48233d49dc30@uwaterloo.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 04:08:21 -0400 Martin Karsten wrote:
> The xsk_rr tool represents a specific (niche) case that is likely 
> relevant, but a comprehensive evaluation would also include mainstream 
> communication patterns using an existing benchmarking tool. While 
> resource usage is claimed to not be a concern in this particular use 
> case, it might be quite relevant in other use cases and as such, should 
> be documented.

Thanks a lot for working on this.

Were you able to replicate the results? Would you be willing to perhaps
sketch out a summary of your findings that we could use as the cover
letter / addition to the docs? 

I agree with you that the use cases for this will be very narrow (as
are the use cases for threaded NAPI in the first place, don't get me
started). For forwarding use cases, however, this may be the only
option for busy polling, unfortunately :(

