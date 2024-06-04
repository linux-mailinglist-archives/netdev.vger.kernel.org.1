Return-Path: <netdev+bounces-100421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9C58FA7FF
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 04:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9CA1C24840
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 02:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8BD12D758;
	Tue,  4 Jun 2024 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0JeEuOq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA6353E31
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466433; cv=none; b=nW106lyGiTsHl+e8ZK3B0f+abNxJpJ+2HI6hMjSLZCuj2HkcyK9Qym9q21IFbjfkZo1pPr3bsMZQN+fEGZAlIis10QLibCa+Bhx278Brz8qfoXuSD8mDIp7Twscoj9OSQ4yqpfUVRQGWGTB+7XdHBk4a4zbJmO2tVjIAL+hvrmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466433; c=relaxed/simple;
	bh=mXYaGTOgmBxNFLSk8IKgeJd3BGJpwZCX0yRFAE+9Ybc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BCcE7po4wOFDocvhWkkxOV9nj1fHgtKetT/j+o/TN5qr+L3+E5NMRQQubCdRSjPhqsV1ack7R2Mm3IuT4j0ZUv0bui1ejjbGi7RfQHf3Mi4z3b8/Nwu+P34eNQe3ggvPVM1RSJr8Je5YXPBnZKiiXn/iiKsUx7VTsHGEwNwz2Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0JeEuOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93149C4AF08;
	Tue,  4 Jun 2024 02:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717466432;
	bh=mXYaGTOgmBxNFLSk8IKgeJd3BGJpwZCX0yRFAE+9Ybc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W0JeEuOqmkV+mHbYK6Ah/ou/qVJoK9eXLZ0nifEV0aYxHMlsR7KOyt2E531lR1KKV
	 /3cp+VoKp5mNYKnK8xMIj116PKEmQPjPFQA/OTRs0iCH0o63vBBhlUXXflzKjweTEL
	 DZPDiUt4X/ycnbjml9YHclScK3tUbuO/QwNWiFaoWKll18RNPdfp2VzWQB7A/9GdhJ
	 6Ae1fMvicFZZaEZB2LIeY5QnWeXdPqDREcCigcmKW2ONvmx5gNipEzxt2mu0Dl2Y8/
	 TltEhDDockARzXB9Sz8Qo1x0s2xZQPkT8kDbiomHi+a1bHSvgUVL+tupjnO7VxvvUr
	 dWZusZ8OXK7QA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 816C8CF21FD;
	Tue,  4 Jun 2024 02:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] dst_cache: fix possible races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171746643252.10384.7925557773948726669.git-patchwork-notify@kernel.org>
Date: Tue, 04 Jun 2024 02:00:32 +0000
References: <20240531132636.2637995-1-edumazet@google.com>
In-Reply-To: <20240531132636.2637995-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 31 May 2024 13:26:31 +0000 you wrote:
> This series is inspired by various undisclosed syzbot
> reports hinting at corruptions in dst_cache structures.
> 
> It seems at least four users of dst_cache are racy against
> BH reentrancy.
> 
> Last patch is adding a DEBUG_NET check to catch future misuses.
> 
> [...]

Here is the summary with links:
  - [net,1/5] ipv6: ioam: block BH from ioam6_output()
    https://git.kernel.org/netdev/net/c/2fe40483ec25
  - [net,2/5] net: ipv6: rpl_iptunnel: block BH in rpl_output() and rpl_input()
    https://git.kernel.org/netdev/net/c/db0090c6eb12
  - [net,3/5] ipv6: sr: block BH in seg6_output_core() and seg6_input_core()
    https://git.kernel.org/netdev/net/c/c0b98ac1cc10
  - [net,4/5] ila: block BH in ila_output()
    https://git.kernel.org/netdev/net/c/cf28ff8e4c02
  - [net,5/5] net: dst_cache: add two DEBUG_NET warnings
    https://git.kernel.org/netdev/net/c/2fe6fb36c781

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



