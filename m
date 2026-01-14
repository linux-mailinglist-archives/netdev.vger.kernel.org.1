Return-Path: <netdev+bounces-249711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEB6D1C49F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 04:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE66930019C2
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97FC2D6E78;
	Wed, 14 Jan 2026 03:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPY2DTgE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76D72356C6
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 03:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768362221; cv=none; b=WFBuOpUtkSxyp5kmD57GcZdu2B6YgEJeSRRnE5sWWjbm51/3BOZhmFP8YAD4p7Lc3jFuag2yFQLsLa6ovWRYdEwjNNxHczL4eEJAAWXS/7pKXcxHdewHG9WnciycfKhR+ZfyBLaM44hHRZavHLJ1pMAHs/zCds+mir4AUQzeLRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768362221; c=relaxed/simple;
	bh=bsX6P7h5mlkiKtIPh2WDj8gqWgoDrh7JW1H2JR+fQYg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HCcqzcWwJ42uNZlBVebFA+z47U0MqTrMS7cvY2yQBwSlL4iDGbYOlQWX9ly6V184iDkEgu0y01owj1LOuDaf1KeuXSjSwrW/PvvJ0Xf+vCRQN3vEwGdNXqIvyj71a5/afEbgwAIMVnHaXBNS2i0HK6r8VxuTHZNs9MJ5Abhroxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPY2DTgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BCCC4CEF7;
	Wed, 14 Jan 2026 03:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768362221;
	bh=bsX6P7h5mlkiKtIPh2WDj8gqWgoDrh7JW1H2JR+fQYg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TPY2DTgEoiLPuVnRXqihI5Usc3AjNs/w7Wj62CxDv86fQ1+MSAnlZNvaZV1E/CB15
	 P+Ux+YZ2Jn18acTTWyI2iDHlPoHc9ZaTJ/9lB1B6dwWKkxdWqUVu8b243ImM1FQF97
	 H61V9+nSdBOhVLsbUEMgtWEX+C+Xrh5yMjyDu9hzwxbDqmDBmqMN0j5ExvigC1rKj4
	 ugJdka1qc4uGm/tIrUDuPA2WRPAZM5+PxD9pupwkdh1zZtgGGvXYA65oFEQI/oHk22
	 Y0fV3gi8DBM0JMT4nPDQH77pi/d6D0Gihvf0/xa4VlfqGaSEBsN9QyRDCOgWRViVt8
	 Al/BK7KBPb8ng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 789553808200;
	Wed, 14 Jan 2026 03:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: sch_qfq: do not free existing class in
 qfq_change_class()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176836201401.2575016.13444177808892506620.git-patchwork-notify@kernel.org>
Date: Wed, 14 Jan 2026 03:40:14 +0000
References: <20260112175656.17605-1-edumazet@google.com>
In-Reply-To: <20260112175656.17605-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+07f3f38f723c335f106d@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Jan 2026 17:56:56 +0000 you wrote:
> Fixes qfq_change_class() error case.
> 
> cl->qdisc and cl should only be freed if a new class and qdisc
> were allocated, or we risk various UAF.
> 
> Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
> Reported-by: syzbot+07f3f38f723c335f106d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6965351d.050a0220.eaf7.00c5.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net] net/sched: sch_qfq: do not free existing class in qfq_change_class()
    https://git.kernel.org/netdev/net/c/3879cffd9d07

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



