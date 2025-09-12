Return-Path: <netdev+bounces-222383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFAAB5402A
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 04:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B470E1C85F66
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 02:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0106D1B043A;
	Fri, 12 Sep 2025 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmSL9tnj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC261A0BF1;
	Fri, 12 Sep 2025 02:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757643020; cv=none; b=YbyTQNKYdhsCzLXj7FEWVSJ0SzZrQCOOtuJmG40VxEmBgm8GDwQAcFhqs548H+G5n0ubjgRYYNHgrkkPfim2X3tzJKBydcFm4y7hm/eI4ySfWmQnDM7MornWruLVBKas+fJEKbUVrTGVL0K10s1upHjX0HKEKT/p9CvP5hcOiXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757643020; c=relaxed/simple;
	bh=JyoKxDgRDs+VYJBLj8DOdJf71IorxaYGYCf6e9JSDOo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fTOLksm1OU92cJZkdNKXmgo3ruuhJCjV2DGwP0dT3lOIaf+xoWcBEVt8eVTR415ZY4/2+TK0bXGpyWCpiVZ+0MpY7T568LqOGgLzBbzrQM44TeWHmdKb2XM96fJLnB/9k+7pm4DZ4mJJqORlUY8F4kNXU1J0SBpEJo0a4O4u3uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmSL9tnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CDFC4CEF1;
	Fri, 12 Sep 2025 02:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757643020;
	bh=JyoKxDgRDs+VYJBLj8DOdJf71IorxaYGYCf6e9JSDOo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bmSL9tnjFfuvb3pvNXrGEpNvUyu006ONrMm9GBdqZMbjKqyMP3+pcjO/+PAxVd4IN
	 4rhpIHq+9KfhFWz1rgsMn0MPsfBQ58Ob3U28JUkLlrGjkxlQTPgl92hEvk0JSmi6aE
	 OgRSkcry1FTkkWH+VNHkly/ugHpyuyY+GIbruA6YfQP1FL4QcNsMdvXpSEj8x0vtQ3
	 FSN8DNm7EGdc6HoTQ0b/vOq4psaxRPAV1KQwjTGHio7u5y4T2TQe+G5QmMWErnK3SU
	 1WVQ5IZGh8n/vO+EHWJyXZeFaSyVwKs6PDf3uAiYyB1n4FGKtBRjt17v5J9fJ5uJZB
	 9D8+o9RpwvdnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C9D383BF69;
	Fri, 12 Sep 2025 02:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] tcp: Destroy TCP-AO, TCP-MD5 keys in
 .sk_destruct()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175764302299.2375845.11338165625021228103.git-patchwork-notify@kernel.org>
Date: Fri, 12 Sep 2025 02:10:22 +0000
References: <20250909-b4-tcp-ao-md5-rst-finwait2-v5-0-9ffaaaf8b236@arista.com>
In-Reply-To: 
 <20250909-b4-tcp-ao-md5-rst-finwait2-v5-0-9ffaaaf8b236@arista.com>
To: Dmitry Safonov <dima@arista.com>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, gilligan@arista.com, noureddine@arista.com,
 0x7f454c46@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 09 Sep 2025 02:18:49 +0100 you wrote:
> On one side a minor/cosmetic issue, especially nowadays when
> TCP-AO/TCP-MD5 signature verification failures aren't logged to dmesg.
> 
> Yet, I think worth addressing for two reasons:
> - unsigned RST gets ignored by the peer and the connection is alive for
>   longer (keep-alive interval)
> - netstat counters increase and trace events report that trusted BGP peer
>   is sending unsigned/incorrectly signed segments, which can ring alarm
>   on monitoring.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] tcp: Destroy TCP-AO, TCP-MD5 keys in .sk_destruct()
    https://git.kernel.org/netdev/net-next/c/9e472d9e84b1
  - [net-next,v5,2/2] tcp: Free TCP-AO/TCP-MD5 info/keys without RCU
    https://git.kernel.org/netdev/net-next/c/51e547e8c89c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



