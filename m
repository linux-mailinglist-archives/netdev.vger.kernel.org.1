Return-Path: <netdev+bounces-173154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A42A5782F
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 05:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B8C1899BCE
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 04:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781EA186E2D;
	Sat,  8 Mar 2025 04:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI5B6Aqr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E0F185B67;
	Sat,  8 Mar 2025 04:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741406413; cv=none; b=APWyWHiw4uikkzuyxbz0+njv88iXOx3CMmTFzmuaqNTI6WGMwfsR2N4mqARTOGWcMNt5Q0o9hsbKUf4lOvNhfr/MLwTPAJJCzTN9g5ZjI+8AEvhy1ER5oQh66IHMFbRnYC9Rdsr2bbRGKdQbHNwpddHijfZ/Kaw9yT2le8ZBZi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741406413; c=relaxed/simple;
	bh=AKZQcLt8bJjf3yO+2hntp6XSMDsV4hEw7RDBU6jMiv4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eeRyCJbLqpijeTHsHKjQTdCb0MhigAx57d9Sd0M2DfVdYLvx1Q7JCzimo+0IQiGv/1AWwiI1wrqqVdF5wdMHXQLPH5lpnu7rQZatbnq0j8GnO0XMu6KxZ74fWEgoslT/DKbXqU9Y66NsdEE0bb7NTRGNEYYuvo3zRB7zZ/LMZ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI5B6Aqr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253C0C4CEE0;
	Sat,  8 Mar 2025 04:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741406413;
	bh=AKZQcLt8bJjf3yO+2hntp6XSMDsV4hEw7RDBU6jMiv4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jI5B6Aqrfb/J+Ay8dXgT/W4U0Dc8h4aePqt/97cNKRdGZ/iy9/rkL6GONJHoM9pys
	 YwyrUvIMBbx3uz6KMX5HOeT6EXgnukN+nCGgx2iGgHrCeGyjzmRLgn3hO7v6S/hG91
	 Fp7Ss96xhctAC6gq4C6sDTY4le8zHkWGiWCbHDndg4OCoaHcNVNHFMYXBsWTVPe8/p
	 0wEhfnt8xfz7yWfSR/G68iH022UagG0S7feFcxdyJwZXq5z1UIYRxmSlddtzcyZ0yJ
	 B0pBFNP5WOJQ/zWZ9VVBZval1FKdRNytK2CzqyForuTJku+YdcHNZbpjjpOSCD89le
	 IaxAlQX7oGB1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC160380CFFB;
	Sat,  8 Mar 2025 04:00:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netpoll: Optimize skb refilling on critical path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140644649.2570715.2453066021799126950.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 04:00:46 +0000
References: <20250304-netpoll_refill_v2-v1-1-06e2916a4642@debian.org>
In-Reply-To: <20250304-netpoll_refill_v2-v1-1-06e2916a4642@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 04 Mar 2025 07:50:41 -0800 you wrote:
> netpoll tries to refill the skb queue on every packet send, independently
> if packets are being consumed from the pool or not. This was
> particularly problematic while being called from printk(), where the
> operation would be done while holding the console lock.
> 
> Introduce a more intelligent approach to skb queue management. Instead
> of constantly attempting to refill the queue, the system now defers
> refilling to a work queue and only triggers the workqueue when a buffer
> is actually dequeued. This change significantly reduces operations with
> the lock held.
> 
> [...]

Here is the summary with links:
  - [net-next] netpoll: Optimize skb refilling on critical path
    https://git.kernel.org/netdev/net-next/c/248f6571fd4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



