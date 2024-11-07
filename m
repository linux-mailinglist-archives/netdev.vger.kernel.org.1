Return-Path: <netdev+bounces-143097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8789C1220
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 00:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0561283F4E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 23:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C6F1EBA12;
	Thu,  7 Nov 2024 23:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpwD5Kr6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554471E04A9
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 23:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731020422; cv=none; b=iZOKGEfV1e90Aee1ujZ4fkG3HiYAZWV6GucXdm5noAelWrg+aHguKidJk/8/ymyIWCOVFnwPLH1S/rHlGsTk2V+JiQTxun0Xu1rZf8ZzUm3xwUKlS3gPVeH0/dkAN8qEFi7zIMsFnLkDbpx8E9mj3Hm3RADroC+lwICtGn97vos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731020422; c=relaxed/simple;
	bh=pva7AnxrvgkkcX+EstiqFz5STD1D8V5iLA7pGDBj7+0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EzjZAl9eoUYQqSOZnYS/pOK6BO7mXaZ7TMFZ2PIpr7u6tJgWZJIznhwtjPjjGY1Jc3/4mSJgy6rLf7KuZQ5/lP6IF5xldT9w4ynCr0P+Z7lDBcUjuobgdk6/zSB0OphfxH5VOC6/yL+vcfu88Bb30egev6F2ckd0BYa9aeHF7G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpwD5Kr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEC7C4CECC;
	Thu,  7 Nov 2024 23:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731020422;
	bh=pva7AnxrvgkkcX+EstiqFz5STD1D8V5iLA7pGDBj7+0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kpwD5Kr68OXzfIbhzv+fRDs/fO62+H1Km2fQ/3fnEHixE4O8w9xjursLUpR6oOCkC
	 gw5X5wNmPMaO93+h9WQSrM9Xevy6CUWQpwS80Rk+NNWCD2I9k2/ERXE5wnqBGC9kB3
	 mqN+pEIwwXZGVvNzbdmi5BiS/a16qqrTg1zCxVEIbxV9AgJGk05vIfRcBNByc9d8UW
	 +gYg3uQjEFG2fy4UBRUHRNAMr9tMfBm3ufqY6ZHsZoR0hRKr9Yxv5eo2dYlnhhb1P/
	 VqQ4QE/sRBBleescx0Rd0LhsZRTVFWRGbdXCxF0x9m1LhiaBZ0XfOmmxN3ln7vIvSL
	 F+aLW15Wf9+YQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F813809A80;
	Thu,  7 Nov 2024 23:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/2] netlink: terminate outstanding dump on socket
 close
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173102043131.2125877.11150196031872984825.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 23:00:31 +0000
References: <20241106015235.2458807-1-kuba@kernel.org>
In-Reply-To: <20241106015235.2458807-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, johannes@sipsolutions.net, pablo@netfilter.org,
 syzkaller@googlegroups.com, kuniyu@amazon.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Nov 2024 17:52:34 -0800 you wrote:
> Netlink supports iterative dumping of data. It provides the families
> the following ops:
>  - start - (optional) kicks off the dumping process
>  - dump  - actual dump helper, keeps getting called until it returns 0
>  - done  - (optional) pairs with .start, can be used for cleanup
> The whole process is asynchronous and the repeated calls to .dump
> don't actually happen in a tight loop, but rather are triggered
> in response to recvmsg() on the socket.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] netlink: terminate outstanding dump on socket close
    https://git.kernel.org/netdev/net/c/1904fb9ebf91
  - [net,v2,2/2] selftests: net: add a test for closing a netlink socket ith dump in progress
    https://git.kernel.org/netdev/net/c/55d42a0c3f9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



