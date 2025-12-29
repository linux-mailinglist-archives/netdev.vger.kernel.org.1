Return-Path: <netdev+bounces-246252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7820FCE7D03
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 19:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EBC7300CA26
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 18:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE67318143;
	Mon, 29 Dec 2025 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tb6hc+j0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886F431283B
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033204; cv=none; b=OyjvZ/tB4FIP7w3pDs3Xtvu5RN5uu+Yz+i8UZ80IkpgQfzLei9yLTfkTKfWLStq6PMAD2m84Q7jxW4901qA0WkHHC+L0Y+36cWVMCqGJJhEkAsJ2c81v+mOFgWO2qnTXomtGnMZWKFTbYWrUbbR6k6BMXI91O23nVhZFTIWJoic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033204; c=relaxed/simple;
	bh=qGwja4jbU90EfEiCTzCUsKad+WYvPi0zq/Q40XMSSYo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ssHvPMPvv5/mJKpSvakebfAqxJnRSVwh2Zp900mSSNTXeMm2zruyWzmpjL/yVf53rUHwABigNLjOZxdAvgSEaiWOM4cFxX+fsbI50MU4aA0beIBF9y/H3F7CmS5/mKH0EGiZ7ibdclxh+XJg6Vt6LaVeLjtjjPU133liXEIKV+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tb6hc+j0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F056AC4CEF7;
	Mon, 29 Dec 2025 18:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767033204;
	bh=qGwja4jbU90EfEiCTzCUsKad+WYvPi0zq/Q40XMSSYo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tb6hc+j0XjbdETDI+YhbIZ4brVh1/QAlKvuDK/eYpFt+ZO4VfMELkbxO0EI7z3C4l
	 xJ3IDnDDziVky9NCkf3Gvr4n22kDJdFm2+G48OSjEt2EfsVIIgB+lb+LIMFw3DdvVf
	 XPMAFRPn/D8FkES7Pk/uF04Zhn5g0sF7bra7/+05uqHn20KZIPP1mOTk0JMZXxZ/Ta
	 VrJgwBJ7XJghd4EHilDF6ZXIhdKo+C2HpwOvf9J4v0HlcPPGHH/6hmRVfIgGBVJQTZ
	 mOetAv+DBg9/2xMpgzNXa/6gwtnk973/ASSPE92Jhp/BQL+qNahokm0jP7J34xzwPR
	 IzI3diuyhmGXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5A833808200;
	Mon, 29 Dec 2025 18:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] usbnet: avoid a possible crash in dql_completed()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176703300655.3023586.12898706359256438972.git-patchwork-notify@kernel.org>
Date: Mon, 29 Dec 2025 18:30:06 +0000
References: <20251219144459.692715-1-edumazet@google.com>
In-Reply-To: <20251219144459.692715-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+5b55e49f8bbd84631a9c@syzkaller.appspotmail.com,
 simon.schippers@tu-dortmund.de

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 19 Dec 2025 14:44:59 +0000 you wrote:
> syzbot reported a crash [1] in dql_completed() after recent usbnet
> BQL adoption.
> 
> The reason for the crash is that netdev_reset_queue() is called too soon.
> 
> It should be called after cancel_work_sync(&dev->bh_work) to make
> sure no more TX completion can happen.
> 
> [...]

Here is the summary with links:
  - [net] usbnet: avoid a possible crash in dql_completed()
    https://git.kernel.org/netdev/net/c/e34f0df3d81a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



