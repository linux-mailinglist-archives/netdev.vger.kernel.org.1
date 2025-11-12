Return-Path: <netdev+bounces-237800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A056C504EF
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 03:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 072864E82B4
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 02:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F87296BDB;
	Wed, 12 Nov 2025 02:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qk439HWX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC52296BD2
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 02:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762913436; cv=none; b=i4XCEMRXHyM+ZBzZiTvSHRF0LVPg0HRnG52GlYdv1k5AtvZ7xAY1dZcR7EULxwcUvRzEvJtUciE3y2+znKnjCVZVq9Q250wODHymoiduAcZJ7IkdexAe7smtJ0nWVnq/+SriP8K5r4tFwQZE9PxewTcacHjVTtuVW0MPHnIJFaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762913436; c=relaxed/simple;
	bh=5KuOH7eSpx2KhlFWQvMC1P/VTYADDOs2giwnyXxsJko=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gbdc7o0SWcer/VM4pLpwU4or3339FOBcssOOKUo7M1CyC6Kn0MKEQJlrK3LFgifz3wlB8MYy29UQmI889EkHaXvr5kbplLykppJ0nwt7rPuzzssKg8JDbNbz6dk+qiMwL1ZHdMQl5/T3vaY5ykE53rkkSREwCB/eszaRk+3VL34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qk439HWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FDAC19422;
	Wed, 12 Nov 2025 02:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762913436;
	bh=5KuOH7eSpx2KhlFWQvMC1P/VTYADDOs2giwnyXxsJko=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qk439HWXnY8P7S0OdJ2kAZ7yj4OUc7Asgsh38g657Ujxt2xND1doXmuRZosXqPTuZ
	 D78u0DSDOUUOP5NrynFiTzJuvGFImJ0vWXfVz+IgEWew/1WxcKDn52E2Ijtyc1ZUVl
	 sb9hhOV2rQUSFZ8gKdJre9jBMkQlp6gUEoh85j5x1avMZ8oF0hbWTMHqmHPA2bUwGd
	 cxPZ8vmmRDzj8942oJ6kPwhi/vmX8tHwodG9e0QhWQ/8FqXGrMhPXCzVyiOqlduq5O
	 bOeZ0GmMXI6gQw28f+Mtl36WdKsmX5vkE6f4F0OmOCq6mF2gItW5E8GGZcietd7Rdo
	 me4G2W1zQJXfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6DEC3380DBCD;
	Wed, 12 Nov 2025 02:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net_sched: limit try_bulk_dequeue_skb() batches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176291340626.3636068.18318642966807737508.git-patchwork-notify@kernel.org>
Date: Wed, 12 Nov 2025 02:10:06 +0000
References: <20251109161215.2574081-1-edumazet@google.com>
In-Reply-To: <20251109161215.2574081-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 kuniyu@google.com, willemb@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, hawk@kernel.org, toke@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  9 Nov 2025 16:12:15 +0000 you wrote:
> After commit 100dfa74cad9 ("inet: dev_queue_xmit() llist adoption")
> I started seeing many qdisc requeues on IDPF under high TX workload.
> 
> $ tc -s qd sh dev eth1 handle 1: ; sleep 1; tc -s qd sh dev eth1 handle 1:
> qdisc mq 1: root
>  Sent 43534617319319 bytes 268186451819 pkt (dropped 0, overlimits 0 requeues 3532840114)
>  backlog 1056Kb 6675p requeues 3532840114
> qdisc mq 1: root
>  Sent 43554665866695 bytes 268309964788 pkt (dropped 0, overlimits 0 requeues 3537737653)
>  backlog 781164b 4822p requeues 3537737653
> 
> [...]

Here is the summary with links:
  - [net] net_sched: limit try_bulk_dequeue_skb() batches
    https://git.kernel.org/netdev/net/c/0345552a653c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



