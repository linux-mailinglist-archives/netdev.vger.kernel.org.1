Return-Path: <netdev+bounces-83453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF528924B8
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 21:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336A91C21663
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 20:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7702013A418;
	Fri, 29 Mar 2024 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8kIiXSW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEB113A89E
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742436; cv=none; b=sGBUlJY5vM9m2lHpTBOcND9omo/ApxHPn7Hgiafw67C1pAbBpjC8gxlCpE5o9pxKGVRdsuoNDNvvDej7HwxVgs4YFXYZ7EGo/4EdDMQob2LazUlkLqZl0iZz9UtnjHV66luuq/DGwJ+jZ2a/fvJ8zjnI28FchIC9OQevi6ie1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742436; c=relaxed/simple;
	bh=AKC/DkGfqvN8PPgkkA9YpVmAlCuj7rSHkPl2gEJTpGI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fh39QP1/iuC+doFZDp66xaj94ObX9k6ODd5sYtvdYd+EbbGeSGh/zi1SEJf1aMVQ34cPFaVG45AFJ6WJmo5HChLAjSbpMxg6orV/T5LviPBQdmYtLIIj4oiySLZHqtbnU0MJC/PYPOIE2JyZ5ZOobn9v1+fnqfqBtLI2IiKh2F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8kIiXSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A92FFC43390;
	Fri, 29 Mar 2024 20:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711742435;
	bh=AKC/DkGfqvN8PPgkkA9YpVmAlCuj7rSHkPl2gEJTpGI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g8kIiXSWssgtm29f3G9EdBMVxtTpPZql0JTtsYa5cgSTCzpDi/lQVkKQd2NpUu4h9
	 6+1VOwKa3FEs/ZhC5VDijOjz9/AjL/6u5y0bl94b24PEdebX4flQ1RziwgT63RMyhc
	 kri4OC/+Xn2MmmkSAlZ+7sMj4inECZ6+xDYKen931Yu5vDPCMNZUzEwdV8TVuzRDiI
	 cZwj5C5ELjlw76ZfEGg7iikajDJ0gD4WCjWBfNEAiJsBdQ/CR5omfg9cwnB/BlNFf0
	 I15/EuL/lB6n5/IAuG0DCaYBHTe4rn6JtW/Snp7f3hGFmprY1sLOQ/u2GSPpY/MpdN
	 vWrXhfb1+F9wQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 981DDD84BAF;
	Fri, 29 Mar 2024 20:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] erspan: make sure erspan_base_hdr is present in
 skb->head
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171174243561.4906.133976208184828473.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 20:00:35 +0000
References: <20240328112248.1101491-1-edumazet@google.com>
In-Reply-To: <20240328112248.1101491-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+1c1cf138518bf0c53d68@syzkaller.appspotmail.com, lorenzo@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Mar 2024 11:22:48 +0000 you wrote:
> syzbot reported a problem in ip6erspan_rcv() [1]
> 
> Issue is that ip6erspan_rcv() (and erspan_rcv()) no longer make
> sure erspan_base_hdr is present in skb linear part (skb->head)
> before getting @ver field from it.
> 
> Add the missing pskb_may_pull() calls.
> 
> [...]

Here is the summary with links:
  - [v2,net] erspan: make sure erspan_base_hdr is present in skb->head
    https://git.kernel.org/netdev/net/c/17af420545a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



