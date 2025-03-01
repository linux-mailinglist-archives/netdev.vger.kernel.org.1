Return-Path: <netdev+bounces-170908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39505A4A829
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 03:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7578E3B4B2F
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 02:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA6C198E81;
	Sat,  1 Mar 2025 02:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6nbeQAm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85293179BC;
	Sat,  1 Mar 2025 02:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740796799; cv=none; b=QFqUu008h2GxWpvgSzZhOfTJx5o2r85PRzV/G0sU/KcsFXBSdeWV1ZlfPpeENVBmnEeJDJMChhKV/hX+yViWzrla9hufD+CEPmUvo0gaXv/kYm4ghPFrZKYbDsxDJivq9/b6Vf2zRKxWbQgO9lDrR89GXO37MbqMq4V7YlEXgcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740796799; c=relaxed/simple;
	bh=vQqG0OMDCP07ToP19OueaMqDHZCcFLtifyE4r5NZKOc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cRBklQix+bFy0vKYe5ZqNSyQzGUuBjYzvs0VX69ZV/ap4ZdhuZw11+kfbf58rNeAsOseqVZuLmnqLM181+mUkU2hvER/YKp4ZqaY9i+kQ57BbXCCcTO9t3oYUSWlWKJBu72NEeO7WEXmN4xHyaT3Mnv0OIK7Ng1dvTQ7dgap2XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6nbeQAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7517C4CEE4;
	Sat,  1 Mar 2025 02:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740796799;
	bh=vQqG0OMDCP07ToP19OueaMqDHZCcFLtifyE4r5NZKOc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W6nbeQAm1kNPSlcJ3DN+TWOx5Qrqf2htKUBDWq+rTKYlIdDDEWFBxyeobwDzu6rvq
	 /mSZjiWdSYIx0/gUH0D+nAdpbzV26kAWOb3NpxCVSbwCgam7v1B1VesMxQ1COPFDbF
	 Weusy62pbkYS5J4JsXnB2JvQNp32prKVmZy7CANtDiDEmf81+dbMqL6wEQTZcIHClB
	 sTDP2vP7jf/Mcqh2E9/pYa1qDU4ri09vCxJcid7YaLz2CoS6QQwL7XQpmjbJ8AskOO
	 K9ImbTmXyEZU1mTOW2AXNYnsFYDIQppa4BDtI9E54GH7Nix/J9df1PGAO9ca1j9Rgt
	 mynD+ssm0/5Ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CB1380CFF1;
	Sat,  1 Mar 2025 02:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] caif_virtio: fix wrong pointer check in cfv_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174079683098.2344768.8052382112959218283.git-patchwork-notify@kernel.org>
Date: Sat, 01 Mar 2025 02:40:30 +0000
References: <20250227184716.4715-1-v.shevtsov@mt-integration.ru>
In-Reply-To: <20250227184716.4715-1-v.shevtsov@mt-integration.ru>
To: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mst@redhat.com, jiri@resnulli.us,
 krzysztof.kozlowski@linaro.org, rusty@rustcorp.com.au,
 erwan.yvin@stericsson.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Feb 2025 23:46:27 +0500 you wrote:
> del_vqs() frees virtqueues, therefore cfv->vq_tx pointer should be checked
> for NULL before calling it, not cfv->vdev. Also the current implementation
> is redundant because the pointer cfv->vdev is dereferenced before it is
> checked for NULL.
> 
> Fix this by checking cfv->vq_tx for NULL instead of cfv->vdev before
> calling del_vqs().
> 
> [...]

Here is the summary with links:
  - caif_virtio: fix wrong pointer check in cfv_probe()
    https://git.kernel.org/netdev/net/c/a466fd7e9faf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



