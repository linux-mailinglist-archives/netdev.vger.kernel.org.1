Return-Path: <netdev+bounces-122412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B288961295
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE721F2113D
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3E01D2786;
	Tue, 27 Aug 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMrjkLZe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999B11D2781
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772627; cv=none; b=WKOkvDOHIUTBaD31k2haY31mNGZ7XgpQwuVLpDvnI7P2OOXWdcv/n9wTulIMRlTMsCEj9ZJ8edxWZ/wMsAvwc4IZTH2TPN1SDBOCtpiWH5Npyrd5mcnpgSdC31bn0koDe70iRLJtAoAoLZcB9Mo4PzXDm9EwpgCKEim+OKBpDUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772627; c=relaxed/simple;
	bh=+SmnV3m4mtRLAe1YU69Wq3ahIgs3nZ9yTZOgLQFmmy0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=db63i8HDufXJ234/yv4IReeyiUIOeYw0OzbOAAh2oy0MHPEC74xJIo0DjYxPFvVneLN8D9IP++iBb5FE92hbBpnEBSHmREz/IPpBvH1tCtbvANGMYkrmkUiWJI9NmPgvYowOv0v+UwYzOvti6ltk8O6uJrz8xYrBzeC4w+MF6Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMrjkLZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63868C4AF66;
	Tue, 27 Aug 2024 15:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724772627;
	bh=+SmnV3m4mtRLAe1YU69Wq3ahIgs3nZ9yTZOgLQFmmy0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AMrjkLZewbyRaG8D2qMPw2bfqrGI5jABe1AC4HgKIaXfik2IwqnF6GWIR6PSBcRKK
	 p4iidnMzxhXZoaQ8rnMzaTvY3rGI+RFre+O91Vl6cfjZXjEZrDjYlPOtvSQ0iBMCvC
	 iryMdoEs1bOnrOZDnyMywgPcxm4SqOVN4bWgzZXCYx9/IqinyjN6T+FkWWqTiXtoz9
	 dTt1F8gZHWOmIeSLCIVONDDmdAa7Zx4/pRs0JoS+yJMOXboaAcVc7f9dwON0iLl/NB
	 8zKUZ4SQCsaulNtAUU3Q9gr2W1ujlO1TK/34nmCJ3rnTj0V4IbWVJZn62sKkOSPnc8
	 baY/mwd8VEoyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF373822D6D;
	Tue, 27 Aug 2024 15:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net_sched: sch_fq: fix incorrect behavior for small
 weights
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172477262751.676231.3993653788339998451.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 15:30:27 +0000
References: <20240824181901.953776-1-edumazet@google.com>
In-Reply-To: <20240824181901.953776-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, jsperbeck@google.com,
 ncardwell@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 24 Aug 2024 18:19:01 +0000 you wrote:
> fq_dequeue() has a complex logic to find packets in one of the 3 bands.
> 
> As Neal found out, it is possible that one band has a deficit smaller
> than its weight. fq_dequeue() can return NULL while some packets are
> elligible for immediate transmit.
> 
> In this case, more than one iteration is needed to refill pband->credit.
> 
> [...]

Here is the summary with links:
  - [net] net_sched: sch_fq: fix incorrect behavior for small weights
    https://git.kernel.org/netdev/net/c/bc21000e99f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



