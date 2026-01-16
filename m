Return-Path: <netdev+bounces-250399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CC339D2A2CA
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD95B3039843
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 02:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451C12F60BC;
	Fri, 16 Jan 2026 02:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzBmdbTi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22945224FA
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 02:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768530837; cv=none; b=BMcCdv7KRRzmu/C5tI+JafZPYdbRTdjH3is8LImn+4ud//wi4J0ZvQ7paqNJONlXPTYY+IXlUdguKwnE117I1lBQqXPm+Fi0AZoALFx2EC5y3t0RXH6wSwRsqi7CiEOz27xzdZCa8DNe21CFv3bdJyNXKYCwprzFeeu5u0j1Qzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768530837; c=relaxed/simple;
	bh=nfpCv9XH3mdzOxCKXEixjHOhpJiiHoQ2YuriFNEW6zo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B4r3k/4LFvzMXljc6IBaQrMxXggjsjWy/1TL6k74M16r1t4YW/FJde7LJzIY31fzHnsmRTFW7jw5YwujOEzsqWTozXM3VHbTHMUwBewsg4YrIBvwruzGQJF5M1dUPfAs2dh47aDuACTXRCgdLMsDfcPdtE3MQnOe670rwaeWfU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzBmdbTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA4AC116D0;
	Fri, 16 Jan 2026 02:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768530836;
	bh=nfpCv9XH3mdzOxCKXEixjHOhpJiiHoQ2YuriFNEW6zo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rzBmdbTiRrOGZEsm6qYJqASYuwg7JKCe3JfUHmJKm/r3CjVICH3ih/RcmYTPtuuIw
	 Grk8mweuMwg0qmmM6qCynQ5zSepJNSTLcar7D+clv7wwY5SKowjmPUo/28cz7/6cvI
	 958LwSBZVwr9bGe/Kw/6oJ21LAFmOxNvRHRYvF/UFoFgxegb6AUBeacVhxFj5y1tif
	 7hCK8sqS4dVEfzWlWkz0bFlX5XHuL27pCYqGovXl7CoXEY5a+scVj7BUFy/9crOvMN
	 pLyIZdKNz3Ywp7hp1RiO0ffJdOnc5PbDT5p3eGyp4ixb6ta9P/AmXHlgc0efJ6psE0
	 6mkordlT639AQ==
Date: Thu, 15 Jan 2026 18:33:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [Patch net v7 0/9] netem: Fix skb duplication logic and prevent
 infinite loops
Message-ID: <20260115183351.3ffc833e@kicinski-fedora-PF5CM1Y0>
In-Reply-To: <20260113190634.681734-1-xiyou.wangcong@gmail.com>
References: <20260113190634.681734-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 11:06:25 -0800 Cong Wang wrote:
> This patchset fixes the infinite loops due to duplication in netem, the
> real root cause of this problem is enqueuing to the root qdisc, which is
> now changed to enqueuing to the same qdisc. This is more reasonable,
> more intuitive from users' perspective, less error-prone and more elegant
> from kernel developers' perspective.
> 
> Please see more details in patch 4/9 which contains two pages of detailed
> explanation including why it is safe and better.
> 
> This reverts the offending commits from William which clearly broke
> mq+netem use cases, as reported by two users.
> 
> All the TC test cases pass with this patchset.

Hi Cong, looks like this was failing in TCD

# not ok 709 7c3b - Test nested DRR with NETEM duplication
# Value doesn't match: bytes: 98 != 196
# Matching against output: {'kind': 'netem', 'handle': '3:', 'parent': '2:1', 'options': {'limit': 1000, 'duplicate': {'duplicate': 1, 'correlation': 0}, 'seed': 11404757756329248505, 'ecn': False, 'gap': 0}, 'bytes': 196, 'packets': 2, 'drops': 0, 'overlimits': 0, 'requeues': 0, 'backlog': 0, 'qlen': 0}

https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/474644/1-tdc-sh/stdout

So I marked it as changes requested.

