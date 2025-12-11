Return-Path: <netdev+bounces-244351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFE5CB5593
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 10:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CA96300BA10
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 09:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4F32D77EA;
	Thu, 11 Dec 2025 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEq170XH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9959E2AEF5
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765444987; cv=none; b=nj0bUGYkibzV3Gse1R5Foxlh5orkIbF2d0tLuqYH4hzPFmERxi0IkhNsI71hY7rJqOU0drq//FSCLxLZScmrGjGSxrqEW78fEOBOM0ep0u1LdQ+xTvplu1UHF4gYk90eLhJbKPJKXl9SKDWPHhZuK44yOVkar2xbx8OtKURRRUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765444987; c=relaxed/simple;
	bh=bjKQo1w1mTcjf/pBxglkX17NJeLWpqcU+JSc+crewmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwTwiAaa2o/v0856LnzyBjObBNvPXJ9+gFoceWLXCNEtSdKsXiqqSRZ65urwqa8H1yoA6hIlBt2rq7Cmh9hwmDLOkvZVL0UWGtFs7xlUlLzUa9b8G6QSCuehik+BUDSLg//7eIFQN2Hei1R5yO9katRCvClYgAKR1fyH/k9T+LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEq170XH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189FDC4CEF7;
	Thu, 11 Dec 2025 09:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765444987;
	bh=bjKQo1w1mTcjf/pBxglkX17NJeLWpqcU+JSc+crewmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VEq170XHOprHnEzlkCxSFdoElRSO0Kqituh8tjch8vm38LVdtLyfZzjfeAStULkcp
	 Tr3tNUB5RmG4JwouQSYGY2hg08y/mvpTCl/haQ2yFWgNucPLLbaxQkqQ4E30k8AJx2
	 9AxppnwSdJsVXxLjUCBA+v4Kxia0yeVYpEqd5/Eykb4WZYcJcvSVjhqgi9udbjYR/h
	 VyayUlQ7jySudxDYvxaykuzWM8G6BnWxzLVILzsH1fXQk6iuqSbRi64ThqtPLnaVE8
	 f10o7IzW4XEayBf3BuO19vkOA2Upl5VXmI+BBhV2g0jLe8HUCTv2a+sQJOY3dnFM4m
	 v6Ho+K2W3vfig==
Date: Thu, 11 Dec 2025 18:23:03 +0900
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, security@kernel.org,
 netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us
Subject: Re: [PATCH net] net/sched: sch_qfq: Fix NULL deref when
 deactivating
Message-ID: <20251211182303.5251e1e2@kernel.org>
In-Reply-To: <CAPpSM+T51DDkcSehkc-3r3FbcYQzXkTq4LGx8RRfD2fACwM8pg@mail.gmail.com>
References: <20251205014855.736723-1-xmei5@asu.edu>
	<4mxbjdgdxufrv7rm7krt4j7nknqlwi6kcilpjg2tbcxzgrxif3@tdobbjya7euj>
	<aTYDlZ+uJfm7cQAn@pop-os.localdomain>
	<CAPpSM+T51DDkcSehkc-3r3FbcYQzXkTq4LGx8RRfD2fACwM8pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Dec 2025 15:17:57 -0700 Xiang Mei wrote:
> Sorry for not explaining that. This PoC could be complex to use TC to
> trigger. I was thinking about the same thing: transforming this C
> program to `tc` commands so we can have a tc-tests case, but this bug
> is related to a race condition.
> 
> We have to use racing to create the state mentioned in the commit
> message: "Two qfq_class objects may point to the same
> leaf_qdisc"(Racing between tc_new_tfilter and qdisc_delete). I failed
> to find a clean way to use `tc` to trigger this race after several
> hours of trial, so I gave up on that. For non-race condition bugs,
> I'll try to provide self-tests.

Speaking under correction here, but you can submit the test as C code
to the tools/testing/selftests/net directory. It doesn't have to use
existing bash tooling. It needs to follow kernel coding style as Cong
alluded to, however. Ideally if you could rewrite the reproducer to use
YNL C that'd be save a lot of netlink boilerplate.. I think QFQ is
supported by YNL tho not sure if that support is sufficient.

Two more asks/questions
 - could you please add the crash info to the commit message
 - there is a similar code construct in qfq_deact_rm_from_agg()
   does it also need to be fixed?

And a reminder to not top post on the kernel mailing lists, please.
-- 
pw-bot: cr

