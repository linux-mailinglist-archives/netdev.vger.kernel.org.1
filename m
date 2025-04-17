Return-Path: <netdev+bounces-183580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E1EA91145
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 03:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553BB1907767
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E8D1B393D;
	Thu, 17 Apr 2025 01:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlNTscMG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABD01A9B5D
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744854004; cv=none; b=urIax129aeV+RgwQyZ12YAcAxBO0MYHbxLR+iff8Nw5nrxA+YdGZuosGW5bN4Vyrtt7ff2a/zq/WVR1DOLXe4h36RUDEks81pb7PxD5bgH4fTpiTnT9Gg/3yoUQEP4iqBbDJOm8FCaiXPcyFU9KSV4dM07fyUFF2aCUnv13gvX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744854004; c=relaxed/simple;
	bh=f+hLMTzKi590RMg21voRZzA5C6FDL1biFyrv9s3ua+E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WJGFK6/9GZ8rJBrZQJnId8eSC37d8LoDp9YrrEjl7NgFdhNhWTEeuzrkNu1aQ4HlXgTBhfgGNCME4FLAxkvKSVqZ5h83oXtOK7IaZduRWfkekRsc9E0Pth5pzsoGLP7yNVOyCMvsDES3r9dqr/N6CRACN8NTn+hlvOblKi0apTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlNTscMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF1AC4CEE2;
	Thu, 17 Apr 2025 01:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744854004;
	bh=f+hLMTzKi590RMg21voRZzA5C6FDL1biFyrv9s3ua+E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rlNTscMGr5zyOX5lyum/Ee3NWMygXTzhSglR6d2FDjp+s0VNcsLVTbfmJdpwCmmQt
	 FvCIEoJEEXJ6D/Zk0jOSm/rvsqDSfE6EtWArz7Ubc11mpZguV2VKlz1CsNF1yXQJqI
	 R9rXx+xDMelolGw9r/WR7yBAgZP8qhTlbiulsifhaYvgIwT/jRMY8Z/OOjtyt9DMKS
	 Ixx1sHvesMqOW3QkCtkz08o7gdq3qKQ7y+8/i40WfAtsJRvul/CUaYPBYopJg2IArv
	 Lgfd2afm1ZZo2rMrr/tAm4T+cE7sHu3n5UuR5GsMZkLqeRel31tc45AyRyX9rEHdhT
	 RlO39u8k/q8Ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D783822D5A;
	Thu, 17 Apr 2025 01:40:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: don't try to ops lock uninitialized devs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174485404226.3559972.11714657798728691228.git-patchwork-notify@kernel.org>
Date: Thu, 17 Apr 2025 01:40:42 +0000
References: <20250415151552.768373-1-kuba@kernel.org>
In-Reply-To: <20250415151552.768373-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 syzbot+de1c7d68a10e3f123bdd@syzkaller.appspotmail.com, sdf@fomichev.me,
 kuniyu@amazon.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Apr 2025 08:15:52 -0700 you wrote:
> We need to be careful when operating on dev while in rtnl_create_link().
> Some devices (vxlan) initialize netdev_ops in ->newlink, so later on.
> Avoid using netdev_lock_ops(), the device isn't registered so we
> cannot legally call its ops or generate any notifications for it.
> 
> netdev_ops_assert_locked_or_invisible() is safe to use, it checks
> registration status first.
> 
> [...]

Here is the summary with links:
  - [net] net: don't try to ops lock uninitialized devs
    https://git.kernel.org/netdev/net/c/4798cfa2097f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



