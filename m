Return-Path: <netdev+bounces-154606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1423D9FEC3B
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 02:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053401882E5D
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 01:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E6B77102;
	Tue, 31 Dec 2024 01:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrWb9ZHd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C73CFC0B;
	Tue, 31 Dec 2024 01:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735610229; cv=none; b=gvl7jjQEgCyvf7WBLvKSMPWBsKOV3B+DXuH5PSfU5tZ6tU+LUKkH/V4PbLMIQfOYeAYTyjzCsM7tXxU0JCiuWU7QaOOYCJbhjp/mIcXdk74yH1I1zenKiTP5OoI8+rM0qp2E6hjhp4m/KOxxSQvSXSvOeHiFcYbq+7JRl4N0SKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735610229; c=relaxed/simple;
	bh=fRi1/cyYsP4f/11Q3ST8koykwqO6f93zRKTw0DImof4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=An6B+vh5EjwGCjVsSTZz+5pFZ5k+pVpMh6bYlOHvgXP9/sAQWMYwOebZJmfXyL/66Z5UoKghvtyds1Eu4oVrDTMZFwp7TUxcE31OyBJAvbux8Y0bi3zhi7x9NC9LT4KLiJJmW8w/9tmD9zi+euNq0I5i4BSHfnrDU+uQAnAU32Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrWb9ZHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0597C4CED2;
	Tue, 31 Dec 2024 01:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735610229;
	bh=fRi1/cyYsP4f/11Q3ST8koykwqO6f93zRKTw0DImof4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jrWb9ZHd2aWRfr3QHlWs55MNvW3p2YFDa28r+YCJQuPp6eYflObE4PFXxLOH6ncCj
	 YJ5Ttqq2heor+Tv9kVnT813KIRuMnTGku+YYcZvHtjyN/S4wQn7Fk9s0Vf+DIsoUDr
	 80Wr9FgJwuE2U+AW8sZakg7HqrJrAzANSNFrT04tDXOpO3awNdOxN+zRt5ZfpVXfD/
	 xAnYfKWNmE9MzJGkwLE6WEmxe7JyLpwDFeCEkdyc2Y+PcU/wyW/kX32ZbqxNM3sugP
	 0pXQ+GMTsypmEGh8gvz7fB6fsy0xQPPx4UvmlXiKXKiRlv90vbCNagIDniZNzRkphq
	 TVr5gWpdxO9YQ==
Date: Mon, 30 Dec 2024 17:57:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: John Sperbeck <jsperbeck@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Breno Leitao
 <leitao@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: netpoll: ensure skb_pool list is always
 initialized
Message-ID: <20241230175707.5e18ae96@kernel.org>
In-Reply-To: <20241222012334.249021-1-jsperbeck@google.com>
References: <20241222012334.249021-1-jsperbeck@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Dec 2024 17:23:34 -0800 John Sperbeck wrote:
> Move the skb_pool list initialization into __netpoll_setup().  Also,
> have netpoll_setup() call this before allocating its initial pool of
> packets.
> 
> Fixes: 6c59f16f1770 ("net: netpoll: flush skb pool during cleanup")

The fixes tag seems to be off by one? Wasn't the problem was introduced
by commit 221a9c1df790 ("net: netpoll: Individualize the skb pool") ?

Since __netpoll_setup() can be called by other drivers, shouldn't 
we move refill in there? Since the pool is per np?

Optionally, could you extend the netcons tests to exercise netcons over
vlan? I think it should be able to trigger the crash you're fixing?
-- 
pw-bot: cr

