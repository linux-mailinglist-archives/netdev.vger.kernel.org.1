Return-Path: <netdev+bounces-178931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 883DFA7996A
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 02:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10A123B1B76
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 00:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B95CA52;
	Thu,  3 Apr 2025 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djXc35wq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038FC2907
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 00:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743640197; cv=none; b=suR2aVLeAsj6TNGXEY6WHAc1dcwX5NSd3TfGzN7bpxNDzn9J4EWR6M6kGoZvGl09PwPmipBFq+RszDZqXlSXNc2a98bDQy3KY6fwpWaFmlbHmZN62Ya0GcXFa+XQuYgUf0WpRXbDy3tNsh/GBqApDwG1Tqw3y22I8fqa/x9UY7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743640197; c=relaxed/simple;
	bh=GMwqHQVII7100EiyJtvMks5ZEQM7JkLN2Se9mNI9dd8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p9lWNkgf3qUY24qYwnRoBdXvExyui3Q+VLIJ0HjxG8StqEgaiCcTtSkCDVI4AynA6nGaNo8/LyPrUiDCjs3w9fmRgZ8KJcf+gPFpvcFNcIqgNrRQqAGuhrpg0LBolUnBQZyD3aHFP6xX9JbZyZ38RnlJ4qwfl8fhIkYmM54n/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djXc35wq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F605C4CEDD;
	Thu,  3 Apr 2025 00:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743640196;
	bh=GMwqHQVII7100EiyJtvMks5ZEQM7JkLN2Se9mNI9dd8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=djXc35wqKDEzKOvtdaWeljE+HZv0njWYulHNt424qGSOKiJRVrygzEgnqdAkiY2ea
	 lKvezYjVmp28NjZveTcXpIUWuwFNsLeUZ7QbblBmZrxwvolqBRfhqaVqO0npVe4fB5
	 n+8lR6enusUti+VZhoBeCWNHmZgPwxu7+LVgKpagyT5pfMULjiCx3w69WKeyvcWhMm
	 5r15w+QYUi3UKYWoQ47CeLV6EioUBTlZYAbnOewsVCLz31p2lcAyPmtFwfsF6hRwZK
	 IblaVWBUzS2t0ZyBTUC2L/Ik5tQXbKBV/idmESXSWQLqOCq70EIsNJZYMMKUTO+ebK
	 jj4UpIcqBBn0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F84380CEE3;
	Thu,  3 Apr 2025 00:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net 0/2] udp: Fix two integer overflows when sk->sk_rcvbuf
 is close to INT_MAX.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174364023325.1731187.12666225758668243399.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 00:30:33 +0000
References: <20250401184501.67377-1-kuniyu@amazon.com>
In-Reply-To: <20250401184501.67377-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 1 Apr 2025 11:44:41 -0700 you wrote:
> I got a report that UDP mem usage in /proc/net/sockstat did not
> drop even after an application was terminated.
> 
> The issue could happen if sk->sk_rmem_alloc wraps around due
> to a large sk->sk_rcvbuf, which was INT_MAX in our case.
> 
> The patch 2 fixes the issue, and the patch 1 fixes yet another
> overflow I found while investigating the issue.
> 
> [...]

Here is the summary with links:
  - [v5,net,1/2] udp: Fix multiple wraparounds of sk->sk_rmem_alloc.
    https://git.kernel.org/netdev/net/c/5a465a0da13e
  - [v5,net,2/2] udp: Fix memory accounting leak.
    https://git.kernel.org/netdev/net/c/df207de9d9e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



