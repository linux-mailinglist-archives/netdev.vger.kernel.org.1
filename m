Return-Path: <netdev+bounces-203522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BA1AF6463
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DEE523AE1
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 21:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D55324418D;
	Wed,  2 Jul 2025 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzUkN8LU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EDB242D84
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751492990; cv=none; b=NZtVQFI+xaWJNCt8sjTW748waYQ2jrELMTUnQfww5xLAfmTsHHLlzHgXOODY21+QUSzGad0xZHH5Sde3f62HeKh22Y1UOXm6VtykDIPilblVeSpCtFJl+9Kj+mwen/hl/6TFiBmAfkkfkTDQ8EI13wwSirfNnJH6nvGpDoEYc9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751492990; c=relaxed/simple;
	bh=OCa2o+c8VjyxJ2s+GyfQFsyRKEx209cXGEDt7nnFU+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=utdugmdX25kPYoONK+D5/9ymDtxZDY2HAZ4XqUlg1LHBJ8AgIT9ATxm2tTkCDdaEhWcm6EJQV2AawfthsF7zk4k3p3ZWBFUMLHYH9AryCj1cmqfQvijA9dX3wHTAPbrylF8OiiVgwPV+srOEgqZFtR69jn2jBb0BYyiOueijdUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzUkN8LU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB570C4CEEE;
	Wed,  2 Jul 2025 21:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751492990;
	bh=OCa2o+c8VjyxJ2s+GyfQFsyRKEx209cXGEDt7nnFU+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SzUkN8LUloYEzeWqfS22/JAcJFmoqtCKLHgKdweBWIjD9kTUhgcHK+eVbQlygi+9Q
	 yJYXpf46H7Sv/2uW1bugZ9I/PUsIF2RMY9aMcrz7dsxzGBnZJFJDIcnRuvVY6A6INk
	 Em0ZrxnK8kJI+6LZ37Gkv5SVlIEe4mnV8d5Z+G3NOE4QJvI4QE07/pQv3V361LHmb1
	 DeLztSWwscwMRYgUswAl5oRAHP3bZN1vRcCJpGiSuFaGoQRGEdMQbvA6XlfUmFgIT5
	 Se+z8ADaqLyUYBTeV2i3aQ6W77RjxoSx4pbOEu5nZHK6T7WLdcfeuwVq9wBwGxejoG
	 X1an6BuGsmz0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDF1383B273;
	Wed,  2 Jul 2025 21:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/sched: Always pass notifications when child class
 becomes
 empty
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175149301450.875317.4500699769123962307.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 21:50:14 +0000
References: <d912cbd7-193b-4269-9857-525bee8bbb6a@gmail.com>
In-Reply-To: <d912cbd7-193b-4269-9857-525bee8bbb6a@gmail.com>
To: Lion Ackermann <nnamrec@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, victor@mojatatu.com, mincho@theori.io

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Jun 2025 15:27:30 +0200 you wrote:
> Certain classful qdiscs may invoke their classes' dequeue handler on an
> enqueue operation. This may unexpectedly empty the child qdisc and thus
> make an in-flight class passive via qlen_notify(). Most qdiscs do not
> expect such behaviour at this point in time and may re-activate the
> class eventually anyways which will lead to a use-after-free.
> 
> The referenced fix commit attempted to fix this behavior for the HFSC
> case by moving the backlog accounting around, though this turned out to
> be incomplete since the parent's parent may run into the issue too.
> The following reproducer demonstrates this use-after-free:
> 
> [...]

Here is the summary with links:
  - net/sched: Always pass notifications when child class becomes empty
    https://git.kernel.org/netdev/net/c/103406b38c60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



