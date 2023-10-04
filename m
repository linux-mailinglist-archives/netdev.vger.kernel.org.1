Return-Path: <netdev+bounces-38001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAEF7B84E4
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 18:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 95CF628140D
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 16:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995911BDE2;
	Wed,  4 Oct 2023 16:22:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821AD1B292;
	Wed,  4 Oct 2023 16:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FB5C433C7;
	Wed,  4 Oct 2023 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696436527;
	bh=pvpGmo1Yrt+7LMlccum7Usx/gcLqZWbEtiJQ4DejeFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VxEPyFJ1+lzraM+2M57RSOdNws0syfKnTDqjRM04kXjmrrlVE8B/VdzofnQmIW3e3
	 dZUu8GH9stBl1Tf/kSB3YrD+ci3AP6NWfLnImPAt7mTEZqGAyJUUyjCKLJCqkwLmw4
	 tR/E0V48Gdn+lVVTadNmmvFyCr05bFrYpoFDEo4j6iplF5O+U6Rnkg5SjzKgSMivep
	 WDMZxiVuIUCAzkkGnS+QZ3o4C9ez+qgKsqxFlHmPCg+QUUhmolRny9hu4DdWF86v7y
	 jZZs1O1tDU99DveNkLdW/+4mdW0n17IMpNb5SsOVzms5ipZxA77rxjElhRn7Oh7eYf
	 zIHIMI5gkfVow==
Date: Wed, 4 Oct 2023 09:22:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/4] tracing: improve symbolic printing
Message-ID: <20231004092205.02c8eb0b@kernel.org>
In-Reply-To: <20230921085129.261556-5-johannes@sipsolutions.net>
References: <20230921085129.261556-5-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Sep 2023 10:51:30 +0200 Johannes Berg wrote:
> So I was frustrated with not seeing the names of SKB dropreasons
> for all but the core reasons, and then while looking into this
> all, realized, that the current __print_symbolic() is pretty bad
> anyway.
> 
> So I came up with a new approach, using a separate declaration
> of the symbols, and __print_sym() in there, but to userspace it
> all doesn't matter, it shows it the same way, just dyamically
> instead of munging with the strings all the time.
> 
> This is a huge .data savings as far as I can tell, with a modest
> amount (~4k) of .text addition, while making it all dynamic and
> in the SKB dropreason case even reusing the existing list that
> dropmonitor uses today. Surely patch 3 isn't needed here, but it
> felt right.
> 
> Anyway, I think it's a pretty reasonable approach overall, and
> it does works.
> 
> I've listed a number of open questions in the first patch since
> that's where the real changes for this are.

Potentially naive question - the trace point holds enum skb_drop_reason.
The user space can get the names from BTF. Can we not teach user space
to generically look up names of enums in BTF?

