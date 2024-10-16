Return-Path: <netdev+bounces-135982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A0499FE49
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D69CB217BA
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA96113E02D;
	Wed, 16 Oct 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jS6OZ+vR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B369E13CA81;
	Wed, 16 Oct 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729042229; cv=none; b=OJdfN4s/GXeS0VM9PjZaatQ5QwrOVEZ5+Upz0900JwHEnwqd+UH+cv0Ai/i/e0ObaFeluG5dAijC+ga9qoldxqJ+Vd7/BnIpQZF2Y7jDo+I0Xhpz7E+9XxD7XO0LLbSNignrasdz08H50irIinERGqtWgL3MVwTgQi0GUNhTsr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729042229; c=relaxed/simple;
	bh=yFqqIWjAv4sBzkrbDxTqDeZNMr6ST8C+oUPaV6QnE9Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JoySTYW+JhW59kBLwOU5Mhmuq91pEiz2XEET0RLkJOLVroncY9cWPxS33Tp13uGuxoJNXthKzxFvA5VnyomAHMwg/xFtAvbVZM0IiZIDbMWgibf3ofsQTLg58LmoflUkRuWP+SJmCxGULXIxhXZFdKhMw6ynRJ+d5vPq/3uhqfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jS6OZ+vR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F45C4CEC6;
	Wed, 16 Oct 2024 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729042229;
	bh=yFqqIWjAv4sBzkrbDxTqDeZNMr6ST8C+oUPaV6QnE9Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jS6OZ+vRrYgxCMileWWrBa7z8sYwanNUkmEIrrmPLq3yU+h0YOq3A+BRbLXw+4sAo
	 eQuE+FJcK4rS6I6CVrrNOoICV3ghdINgqOpTZDV+FRJrroRqpFmbTfIT+jLTH39vW7
	 oBkGFUpqyX1w82YAn7I6tIxS3j4tDjxBPOlioCtigjEfXAG3t7qVug41z3HWsxEoQ3
	 /p/BsXt8clomlMIfikNPA1I/IV85tBWhsx7LNut8vvmhr5P9ZgJrh2A1SGaB6hDaGR
	 xmkRa20a8YXQTWfMEk8Q8dlU+0ADKCarV5n4uxiLux2tTWgyN+U6bj8ekPBLQfo4Zd
	 OmYt0u5bsvXGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDFA3809A8A;
	Wed, 16 Oct 2024 01:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: cbs: Fix integer overflow in
 cbs_set_port_rate()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172904223423.1350766.2078753850129678538.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 01:30:34 +0000
References: <20241013124529.1043-1-esalomatkina@ispras.ru>
In-Reply-To: <20241013124529.1043-1-esalomatkina@ispras.ru>
To: Elena Salomatkina <esalomatkina@ispras.ru>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, kuba@kernel.org, leandro.maciel.dorileo@intel.com,
 vedang.patel@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Oct 2024 15:45:29 +0300 you wrote:
> The subsequent calculation of port_rate = speed * 1000 * BYTES_PER_KBIT,
> where the BYTES_PER_KBIT is of type LL, may cause an overflow.
> At least when speed = SPEED_20000, the expression to the left of port_rate
> will be greater than INT_MAX.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: cbs: Fix integer overflow in cbs_set_port_rate()
    https://git.kernel.org/netdev/net-next/c/397006ba5d91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



