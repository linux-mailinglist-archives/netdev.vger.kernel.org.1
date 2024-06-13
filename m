Return-Path: <netdev+bounces-103285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D77C90761C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 17:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6091F23FC6
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C63149012;
	Thu, 13 Jun 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9Po2DJY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7E4148FFF
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291430; cv=none; b=S4yCKaaeaeKGJfGqA3zdziXzrFUwe0RmDJLDiQANPezBxocTBCAXv3bjq9hXL37bqeFK/geDibHp+ECcXceQdH1N00RDcCOVc2VHITvWGt1vDHoNyflQ2s2B2YumKY4ws4Jkahm0toq1rc5OeoZQ2Gfjn9GrJrhS6jWw/qbS0g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291430; c=relaxed/simple;
	bh=jDhIknpiFJBOO73+zsA0enXHwxWePaJcVvHsjbhAzUo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OYHZQo5lYwz8QycoDmHXPf16ppZ0gYFaJ02Of9z+B4xZYBCCcZfW1rku2gTkcmwNC7SC3i6CEGVCf4B2cXWcrR9EG0biZUheflDdyhtS9vcElORIQ0CC1ItvGmTX5bWlJGiwEYLNhAXF+x6LW8OzjPBlRf2mgXFCsD9nrb4Tghs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9Po2DJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13D33C32789;
	Thu, 13 Jun 2024 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718291430;
	bh=jDhIknpiFJBOO73+zsA0enXHwxWePaJcVvHsjbhAzUo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W9Po2DJYOq5TIH9Rl/G7cUGhZ/jG77NODuX4kBcKB9EvohZBOUEbAwsz9pARgDfOy
	 RL2e4RyKTbTIEY0dJrNqQ7YYTGC4I4df5X6Rgs2VDYqIQ6n9H6hYoP3aU50X9ayVDp
	 smz/L6yjiIkTFnBroZs5g9ZyjhJoO5Xm9deetqfQrrFd06qf8KJbPgqI7GDaZlnggh
	 b4y1Q34d+qHCgLnNn73oD1iWiE0jHYUejZ5FO+mYarhqCGHlQIsX/m00JZpM0Cl7uX
	 WCqnQexqjAi4JhLoJO6R5MrefOjGWhsMwz8DNOtMzI0mLS3H2cpUnl2LOHWTIZw+ut
	 ivE1JWv00P7mA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 059ACC4314C;
	Thu, 13 Jun 2024 15:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6] af_unix: Read with MSG_PEEK loops if the first unread byte
 is OOB
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171829143001.24472.11084199730476804380.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jun 2024 15:10:30 +0000
References: <20240611084639.2248934-1-Rao.Shoaib@oracle.com>
In-Reply-To: <20240611084639.2248934-1-Rao.Shoaib@oracle.com>
To: Rao Shoaib <rao.shoaib@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuniyu@amazon.com, netdev@vger.kernel.org,
 Rao.Shoaib@oracle.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Jun 2024 01:46:39 -0700 you wrote:
> Read with MSG_PEEK flag loops if the first byte to read is an OOB byte.
> commit 22dd70eb2c3d ("af_unix: Don't peek OOB data without MSG_OOB.")
> addresses the loop issue but does not address the issue that no data
> beyond OOB byte can be read.
> 
> >>> from socket import *
> >>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
> >>> c1.send(b'a', MSG_OOB)
> 1
> >>> c1.send(b'b')
> 1
> >>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
> b'b'
> 
> [...]

Here is the summary with links:
  - [v6] af_unix: Read with MSG_PEEK loops if the first unread byte is OOB
    https://git.kernel.org/netdev/net/c/a6736a0addd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



