Return-Path: <netdev+bounces-94480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A2A8BF9A9
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53C31C2195D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407B976405;
	Wed,  8 May 2024 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxHIC0tt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9618C1F
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161258; cv=none; b=Cwf7uMp5Jp4ny6nrLClikxblIiJ0Oy8zMFG9ESIcf3G+OgRdRqHaM/KpTY/ujUo0bJEdKEHOMDYkW28c/oyarWI6AFyaQb9kfh293HH0Es8SrRhoOTOVzpeA1R71QZvTMV836EkgDx/5CsijfoLIQmHpgloo2zUV5SZltOgYhcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161258; c=relaxed/simple;
	bh=Qf40gOwlkM8pIeB3b6oSMf/gq4V7xtdlG8ige2ZKgbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoPwFUruWPOSpq+U0Z/6di3K3nppN9/clZFs72vk904GVO6SMGm/5f8JG9SOlRZAMSXigObuwwD/E745bDELbuMVmTKrqOB/ntFzc6GKOhgDSEboY1iVOTLoqwvXM4FVsQHtBgRvcYIQ8Vr2P1ctgqlviorZgOJknjh2yuFhlQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxHIC0tt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B74AC113CC;
	Wed,  8 May 2024 09:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715161257;
	bh=Qf40gOwlkM8pIeB3b6oSMf/gq4V7xtdlG8ige2ZKgbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxHIC0ttMRKUWVg9hZgDygCIM396zTX0XDH5Sa0ADgSYMnE7bZMtx5w0axPmAuah7
	 S92Tn1W/wm4uKQxPWbqyz9zNatpTlc3QauJZ25sjxCSykM063iwHJ5jEN6RvXBB4X5
	 WSWLThx06ptVY5oE8CQNXs9P17PleMzEHCUvsjeMadA6TY9sTr/uogPx00Kb3GxwHu
	 4vN3vCTqLt1lmo8Y6uMt/EDwqINSHR3PH6ZbwOG8nlvbcPyrmtkEf4aQB5T2wBbj3T
	 0el34idnbDyhxgmiZTuv7QMjJqeIwlpXjxbUWMSGpdF4md3Ga0Z2cuEF6qfM86+Zim
	 CwEC1LfeymlKA==
Date: Wed, 8 May 2024 10:40:53 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Guillaume Nault <gnault@redhat.com>
Subject: Re: [PATCHv2 net] ipv6: sr: fix invalid unregister error path
Message-ID: <20240508094053.GA1738122@kernel.org>
References: <20240508025502.3928296-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508025502.3928296-1-liuhangbin@gmail.com>

On Wed, May 08, 2024 at 10:55:02AM +0800, Hangbin Liu wrote:
> The error path of seg6_init() is wrong in case CONFIG_IPV6_SEG6_LWTUNNEL
> is not defined. In that case if seg6_hmac_init() fails, the
> genl_unregister_family() isn't called.
> 
> At the same time, add seg6_local_exit() and fix the genl unregister order
> in seg6_exit().

It seems that this fixes two, or perhaps three different problems.
Perhaps we should consider two or three patches?

Also, could you explain the implications of changing the unregister order
in the patch description: it should describe why a change is made.

> Fixes: 5559cea2d5aa ("ipv6: sr: fix possible use-after-free and null-ptr-deref")

I agree that the current manifestation of the first problem
was introduced. But didn't a very similar problem exist before then?
I suspect the fixes tag should refer to an earlier commit.

> Reported-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

I think these bugs are pretty good examples of why not
to sprinkle #ifdef inside of functions - it makes the
logic hard to reason with.

So while I agree that a minimal fix, along the lines of this patch, is
suitable for 'net'. Could we consider, as a follow-up, refactoring the code
to remove this #ifdef spaghetti? F.e. by providing dummy implementations
of seg6_iptunnel_init()/seg6_iptunnel_exit() and so on.

-- 
pw-bot: changes-requested

