Return-Path: <netdev+bounces-87585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238BA8A3A5A
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 04:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C776A1F226A8
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 02:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B3814A81;
	Sat, 13 Apr 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNZOI0lZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E45A14285
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712974230; cv=none; b=YkDk93iys9F1TdqE+T/3jdwauW5dEr8qp7ND47hd+yO+OeRWGzTLiPk3A2VtLTd2bgYf5jlxXgbUYYXc1Cz6pUBy8HowaMbbn4lJ3DXRAQ8Sg+uDipMQ9twuS7O4D9pMHLh+G3TuuiHT+9O1fjUZo2ajNMYiDDZYcHwJZ0HUygc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712974230; c=relaxed/simple;
	bh=JL4bGQE7EG411LKAhJjBY9xNL+SBzvWV8hlO5bRu1m8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z/mxxHU0TzGwL3xVZ0J5fI+df3LjPLwGMwnKBCKgjUDtEkCjzk9VtSRDCLdvuADXPxqDzQaBj0QhTNQ6xLn+UBErOVj7bjWJIE6j5k0+qJy6giUDh2V0gF/x68Td0nlt3qfmjJpD6gQOq0E+oRpD7mfpPU5+OM2ewHfIe94slGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNZOI0lZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5843C32781;
	Sat, 13 Apr 2024 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712974229;
	bh=JL4bGQE7EG411LKAhJjBY9xNL+SBzvWV8hlO5bRu1m8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hNZOI0lZNwyVVVwPKgM87VJB4Tfw1DKfXA9wp+2X7WQHPB3mbRdptbheRVCR6gUUl
	 JGRnf1RFBNV7yD3D+GCF3/RUb6Gv3flcjQ9h/9OwbfAMG7v464JgYwaoE3CZ+DFzD5
	 HtrlRTBDftbbNLPJypml/w1sd/ULHW/2tDujmlOnlFQK7VPfBAZ7nTsEXeglQksd0U
	 WMHzLxX/qBGTnomXUxWpZrjSc2k6VeOC9V/ncNkTMbwRZlXSRKT52SvONduZCR4vLB
	 7EMLsCY+ofW2gflVkmqucyRqnd4HIRmZpResfbSGQoJ6f1gC0SujYJ3oiN20mkiRrk
	 yyWZvYCqVgx6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAB08C32751;
	Sat, 13 Apr 2024 02:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] af_unix: Fix MSG_OOB bugs with MSG_PEEK.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171297422982.31124.3409808601326947596.git-patchwork-notify@kernel.org>
Date: Sat, 13 Apr 2024 02:10:29 +0000
References: <20240410171016.7621-1-kuniyu@amazon.com>
In-Reply-To: <20240410171016.7621-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, rao.shoaib@oracle.com, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Apr 2024 10:10:14 -0700 you wrote:
> Currently, OOB data can be read without MSG_OOB accidentally
> in two cases, and this seris fixes the bugs.
> 
> 
> Changes:
>   v2:
>     Drop patch 3
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] af_unix: Call manage_oob() for every skb in unix_stream_read_generic().
    https://git.kernel.org/netdev/net/c/283454c8a123
  - [v2,net,2/2] af_unix: Don't peek OOB data without MSG_OOB.
    https://git.kernel.org/netdev/net/c/22dd70eb2c3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



