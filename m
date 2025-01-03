Return-Path: <netdev+bounces-154877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF9EA002E0
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 03:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601AD1883F2C
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 02:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC8619D06E;
	Fri,  3 Jan 2025 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwZvtXzi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70AD195B33
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735872618; cv=none; b=o17TyzzhLjqc73E5ra8tMtW4idzhT3gfwsbzq30DnoI47TeeoaGoqA1IEE9LreBhmhpq1DDec9uuuJhx5/HK/GDBdL5eiDI6ujjxj20hsVwIclM18nNZcFwPbGaWDppFFj0GdMxUWYK1Z71mb6eu3osfyGbWYekdtiGuJ16yHUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735872618; c=relaxed/simple;
	bh=DjLjn/zKZu7hr1ifxKsnSJub/2mXavze7SDS7JdqNEI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FbIntBB52084aRtFIiEugHYKuESm9MwmAJ3z6sNQcGKyuvI7SeR2I1cQXa7GxRzB22+W4JdpStoCsnd/S2tD+clkkYal/rBAtnQ+Ee9xTuG2mgHjvhPq6dBjYlzJkPNEfR/ptcQUClJTvlsVLWyAAFNDlkTShoKdtfll9s6fm6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwZvtXzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4324FC4CED0;
	Fri,  3 Jan 2025 02:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735872618;
	bh=DjLjn/zKZu7hr1ifxKsnSJub/2mXavze7SDS7JdqNEI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UwZvtXzivfC2z5vk/rm5MIcOm+5x1EYWMyUfC3cxUiBss09be4RJDYkBYy53j469Y
	 hFS1c17WTQv3zDiXxrpF48AgoEQSkUN5b7T6hF2mFp3I9+tEyS53UVGbHYKFQJSokE
	 cCclDxvVU3Wa3GyQqFwp5Mv1pwOcjv1p0QGjvBNBhLxsDgoLZZhpqAVhCeFv+JI94J
	 IDd8VdttTFRbxhMJkGnc3iutP0mtsCmuCIkxDpesp0lrKqhJSc0PCv3i+MBByiML6s
	 Mt8MFDcnyYf7AALOQ5zY/YYW6cO+P6q3I+0615CPhmf/go+B854zvgPhN4bz3vaXgS
	 l/G+17Ug0KnAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB022380A964;
	Fri,  3 Jan 2025 02:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] af_packet: fix vlan_get_tci() vs MSG_PEEK
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173587263851.2091902.4288494842181064874.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jan 2025 02:50:38 +0000
References: <20241230161004.2681892-1-edumazet@google.com>
In-Reply-To: <20241230161004.2681892-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, willemb@google.com,
 eric.dumazet@gmail.com,
 syzbot+8400677f3fd43f37d3bc@syzkaller.appspotmail.com,
 chengen.du@canonical.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Dec 2024 16:10:03 +0000 you wrote:
> Blamed commit forgot MSG_PEEK case, allowing a crash [1] as found
> by syzbot.
> 
> Rework vlan_get_tci() to not touch skb at all,
> so that it can be used from many cpus on the same skb.
> 
> Add a const qualifier to skb argument.
> 
> [...]

Here is the summary with links:
  - [net] af_packet: fix vlan_get_tci() vs MSG_PEEK
    https://git.kernel.org/netdev/net/c/77ee7a6d16b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



