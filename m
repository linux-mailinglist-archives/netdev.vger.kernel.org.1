Return-Path: <netdev+bounces-149347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C801A9E5339
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06670167500
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE9F1DCB2D;
	Thu,  5 Dec 2024 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhU0dryU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0531DCB0E
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396419; cv=none; b=DgK7tDcEQZXgdWKxGMy8u1if4y4+8R3gmsP/8iTDxG44s8N0MRcM3xKL2KoX+p+9NTbG58LYnypTRNHQWLTNIPWWp/u5H7+hkx3EqCA/EuLQSMtU8RW13abPnfElfJUwb452L3R0ORtAThhBBtthoJt/2t/c6GF21+vU77OJiM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396419; c=relaxed/simple;
	bh=J9mjWOIDcisekw9n3ITByY1jEYymu7qNRbIFDRf8N7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XATb98vl6KhCQbn4BQVrjLbQq/dA5//086K+vtG+64rob00oy31UnbP7rnieUgg5ajIJ0q5cpl93OasZM9pZQVWWyILJQroXIjJaxTUH5yQGtGKy2D+vqUiwVETmk0Wey0LvBE99BV6ATXtIlqKsSxgHLWFBBWSzAhz3/6Tei1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhU0dryU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D52BC4CED6;
	Thu,  5 Dec 2024 11:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733396419;
	bh=J9mjWOIDcisekw9n3ITByY1jEYymu7qNRbIFDRf8N7U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UhU0dryU+BzkalbKM4hFybGEws9MJGiwJQvyf7Cduw2lHbanYcHKFGZ3EIgpMpX4D
	 DFLfdLI/pWlXyDyfPdAGizxjICZs0lbcTZ8rrn7VMzH7llpy6wUE/KlRE6gS8Sf3nu
	 YZksaNpb92E2tdElQy7MFkkYqRqXcV1oT8drny85FA4hoMoiwaYF0Qar2uXirLu3Rj
	 74MlyXdzVsViTxNiDvy2reClPV21pyvUHr5zqubJpkTMIiGVWKN8HB9e8NOsC2sBs2
	 OBkf9ht1whqkkxZD82SXUhBqw9yHwDVgEWaCcaRT2xY/ear9YJIxAEYXg7dBrBTIN6
	 i/ISAGQBl5ORw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342BD380A94D;
	Thu,  5 Dec 2024 11:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: avoid potential UAF in default_operstate()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173339643375.1549157.2163133507378717165.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 11:00:33 +0000
References: <20241203170933.2449307-1-edumazet@google.com>
In-Reply-To: <20241203170933.2449307-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+1939f24bdb783e9e43d9@syzkaller.appspotmail.com,
 vladimir.oltean@nxp.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  3 Dec 2024 17:09:33 +0000 you wrote:
> syzbot reported an UAF in default_operstate() [1]
> 
> Issue is a race between device and netns dismantles.
> 
> After calling __rtnl_unlock() from netdev_run_todo(),
> we can not assume the netns of each device is still alive.
> 
> [...]

Here is the summary with links:
  - [net] net: avoid potential UAF in default_operstate()
    https://git.kernel.org/netdev/net/c/750e51603395

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



