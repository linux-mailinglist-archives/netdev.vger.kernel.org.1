Return-Path: <netdev+bounces-87876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ABC8A4D5A
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37BE91C20D52
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AE65D47E;
	Mon, 15 Apr 2024 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZ8mOvzx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41F64BA94
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713179427; cv=none; b=fzW6/gqai4nwXwzgvBoX0JyM9XOreYVUCv0ZcvjnekVaY5obBoTsWOZhpbqC0kORthkyYBfl9wOlfPekNhN1ijWbd6hlfT5OKY5drrvV85haBpWG5mpwQWQA47ORRe9sMAzMsFv8W+FUt/EIF7bXgEJ699utqZPBZ5TjL71FQBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713179427; c=relaxed/simple;
	bh=a3qWi42GixFcG+gSlDD5MDveGjJAjk+uzHoykdlFjBQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cYX78jA5QKGDUzPFyV5YsvurYA+lrk2dRyTxzGc2OstzQtrPxjlwgTZWMdSERU2pOgUelFpEGTAAT6/1E1x3inRGMZJHdEB3gr6F9f3rUwja5F5ZzlDXEIx5y4G9+wzXnLU6FSyP9WtMl8rjhX3NQ2WEdrmBKCUlmAEU5D/QcYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZ8mOvzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C017C3277B;
	Mon, 15 Apr 2024 11:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713179427;
	bh=a3qWi42GixFcG+gSlDD5MDveGjJAjk+uzHoykdlFjBQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AZ8mOvzxwH8jpKEPqB3QppRbNzrB7+qwXDX6S/KDtsHOQLqqZXiUqZoU+hpyFdsQj
	 5u6+WpyeG4daCYLaUyvmIziNAGpqJ9tQxMw0zfDtuoeUrG6EEdeRvE1/KgnVmsJxWd
	 mfN5Lz2naeJyh2VEa3FDZTWCfnIwkxGi8ILqK17O1L6LHRTF3wI5yD61u5x+n1QubM
	 CWjO3Qh9aRjnYMw+q1C7Ph9w9j7dEUZ+v+EcGuwWNXwtbzrEqOXtvNS/kSXbPy45Wu
	 PbS6vLB27gxOzdBY5P5WtZ7kBCrNh3LO/TpLYPoTX0wZlAdiAjW6Y9wJv8PcCEBdUP
	 Un7CUAQdj5I0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 270D0C43140;
	Mon, 15 Apr 2024 11:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] udp: Avoid call to compute_score on multiple sites
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171317942715.31565.13734913046471806260.git-patchwork-notify@kernel.org>
Date: Mon, 15 Apr 2024 11:10:27 +0000
References: <20240412212004.17181-1-krisman@suse.de>
In-Reply-To: <20240412212004.17181-1-krisman@suse.de>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, kuniyu@amazon.com,
 netdev@vger.kernel.org, martin.lau@kernel.org, lmb@isovalent.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 12 Apr 2024 17:20:04 -0400 you wrote:
> We've observed a 7-12% performance regression in iperf3 UDP ipv4 and
> ipv6 tests with multiple sockets on Zen3 cpus, which we traced back to
> commit f0ea27e7bfe1 ("udp: re-score reuseport groups when connected
> sockets are present").  The failing tests were those that would spawn
> UDP sockets per-cpu on systems that have a high number of cpus.
> 
> Unsurprisingly, it is not caused by the extra re-scoring of the reused
> socket, but due to the compiler no longer inlining compute_score, once
> it has the extra call site in udp4_lib_lookup2.  This is augmented by
> the "Safe RET" mitigation for SRSO, needed in our Zen3 cpus.
> 
> [...]

Here is the summary with links:
  - [v3] udp: Avoid call to compute_score on multiple sites
    https://git.kernel.org/netdev/net-next/c/50aee97d1511

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



