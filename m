Return-Path: <netdev+bounces-148975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F2E9E3ABE
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40964169306
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7BA1990C4;
	Wed,  4 Dec 2024 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhHhxDUx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68E3189F57
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733317219; cv=none; b=EOrUSVZTWE7nvXymlP60OTSq7c/GsTQ61RmpyO1L+u5BaMCYIqtkHF25QflSbwkAVQ1CBiW1mCdwdSJJmNrNlso1Jyqzci6NAr8fLk9VIUoagnM94QE0EoMOC0U1l4Fxcut8GN5yuXysP0TRG6Kb2r4SAHIbkblaz6dadJCqJlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733317219; c=relaxed/simple;
	bh=G/+SAlqIVT4ULt9olzosT39t89kRnLrvb9SB/uloQZM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bThB4EYQ0vxzihQT5Lyv+P5SCE+FzuOO+GVs9S8pOf0PgQP8dHd1XYKddsoaXarvri4wIFZe5ohLstiiB+z5nEGgNhGcvfg+YSO2WrsAoRldWWOdzpy1NRUjMGz8RmQ/X02eZkcPHow8wIALdgnGHHnJKv4HFVAW2GxBHiTMbX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhHhxDUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D85AC4CED1;
	Wed,  4 Dec 2024 13:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733317218;
	bh=G/+SAlqIVT4ULt9olzosT39t89kRnLrvb9SB/uloQZM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hhHhxDUxgykIi204YWoofNJQiRjGl91nL4hHGo1T5XIe0aF67feMtE7ppGZ4+NPA7
	 /dgN8miNaUXOv6WAtnPEjWo7GgU4xWWd6MAKYXFUO5cLMdTfHYJW5Tz0s74Ad9TpJA
	 UE4y8i+7vLAimrGxqXm0XfU78a8dCgbg0P1p6IL3hXOMXlw+ZNnuDlIpPTcjEs10l3
	 Lg6tEauUBbnLB0ecHd0owtxXp7rvMQ091Yu5ATtAtzOYvPjLXM8y0RGKvXFfBhswcC
	 Nw15GzeSJwvigi0IffQt3NeXrGk+Q4DcmoZW4Ozaa9r4mIwcUGUujkapJJiYhg7Qjs
	 604TpeAVoAyBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EBC833806656;
	Wed,  4 Dec 2024 13:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sched: fix ordering of qlen adjustment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173331723275.870459.15498672524902230805.git-patchwork-notify@kernel.org>
Date: Wed, 04 Dec 2024 13:00:32 +0000
References: <6c7ae1c8-8573-4f4a-96cb-0a75eab21516@gmail.com>
In-Reply-To: <6c7ae1c8-8573-4f4a-96cb-0a75eab21516@gmail.com>
To: Lion Ackermann <nnamrec@gmail.com>
Cc: netdev@vger.kernel.org, toke@toke.dk, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 2 Dec 2024 17:22:57 +0100 you wrote:
> Changes to sch->q.qlen around qdisc_tree_reduce_backlog() need to happen
> _before_ a call to said function because otherwise it may fail to notify
> parent qdiscs when the child is about to become empty.
> 
> Signed-off-by: Lion Ackermann <nnamrec@gmail.com>
> ---
>  net/sched/sch_cake.c  | 2 +-
>  net/sched/sch_choke.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - net: sched: fix ordering of qlen adjustment
    https://git.kernel.org/netdev/net/c/5eb7de8cd58e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



