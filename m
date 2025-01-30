Return-Path: <netdev+bounces-161580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF73A22759
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 01:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0593B164395
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 00:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9095D182BC;
	Thu, 30 Jan 2025 00:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtYiQcX2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B0B2F5B;
	Thu, 30 Jan 2025 00:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738198593; cv=none; b=Ht/8q3pVyYC2NaF+Nb+nQp/lHMmjN7d47F4WNL8OpocaXn0WtNlr2SZCGKrLHHVNZUHZi9pa3ewA8O3fubvrbLSYCHVP8LFljGHE2TAYzNmPH93W09Ei9QjLi5n8RG9CC2LCpm33tszNJN5ibkLl3m+01vZjq+ArnTgIXVMH4Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738198593; c=relaxed/simple;
	bh=RATQnFJ4yiIq994c3gK6VZsKGmFoYXBwpgXJneTRwn8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hauvi41wJfcrKUNX8Jc7tdq5enRLZN+41kWYbxRkA61R4T9ziUv6RVws8nyIU9NM1Tr1asJzzf/V/2bXk94OcH1hYOMpP0MOXZnWZYPd4d9wdfDdetU0DTlE8OLwlZ5FWsqVBptKYcBCsrNrgoO5PrpEzPherZ87ReeEgl5jfuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtYiQcX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3D1C4CED1;
	Thu, 30 Jan 2025 00:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738198592;
	bh=RATQnFJ4yiIq994c3gK6VZsKGmFoYXBwpgXJneTRwn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JtYiQcX2MGNna3OAdzbxyK70cvNJkUQ8DBSbawlSzt1iA1b6B2qW/J5olt7MRwStv
	 w1H5BfUkww0MIRt9lUBHoO4Eyq/2XVAiCu9fNC0c68Q/KnIc0moRSqTdloXzQrFCjp
	 Isq7f/ZLpxZ/ZKprSHjpheAtfQTOIuSriETlmmoNLJIDTO/94zUO8KL8aI6dHZVFVp
	 ZHW/mNsWr64X8vrLsfUYqSXS7LoWq/Y7INkLqiGZkX/L5S5L4Ft4Qs6P+PSX/dlTNB
	 oaU1N5cW3qsatly6Sc1UelHASUZ63byzUg7P8XlNXYN4MllHB1dl1CMb8fM94GuVvY
	 l5caLAnhoDqiw==
Date: Wed, 29 Jan 2025 16:56:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Abdullah <asharji1828@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, horms@kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com,
 syzbot+5cfae50c0e5f2c500013@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] net: ipmr: Fix out-of-bounds access i
 mr_mfc_uses_dev()
Message-ID: <20250129165631.50e9e58d@kernel.org>
In-Reply-To: <20250129085017.55991-1-asharji1828@gmail.com>
References: <678fe2d1.050a0220.15cac.00b3.GAE@google.com>
	<20250129085017.55991-1-asharji1828@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jan 2025 12:50:17 +0400 Abdullah wrote:
> The issue was reported by Syzbot as an out-of-bounds read:
> UBSAN: array-index-out-of-bounds in net/ipv4/ipmr_base.c:289:10
> Index -772737152 is out of range for type 'const struct vif_device[32]'
> 
> The problem occurs when the minvif/maxvif values in the mr_mfc struct
> become invalid (possibly due to memory corruption or uninitialized values).
> This patch fixes the issue by ensuring proper boundary checks and rcu_read
> locking before accessing vif_table[] in mr_mfc_uses_dev().
> 
> Fixes: <COMMIT_HASH>
> Reported-by: syzbot+5cfae50c0e5f2c500013@syzkaller.appspotmail.com
> Signed-off-by: Abdullah <asharji1828@gmail.com>

Could you explain what you're trying to do here?

Are you just tossing patches to test at syzbot? If yes, please remove
the unnecessary CCs, reply directly to the syzbot address, there is no
need to spam the mailing lists.

Or do you mean this as a real submissions? In which case why is there
<COMMIT_HASH> instead of the correct commit? The entire submission
feels a little.. LLM-aided.
-- 
pw-bot: cr

