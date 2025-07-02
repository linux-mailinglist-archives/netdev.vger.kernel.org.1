Return-Path: <netdev+bounces-203295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35953AF1356
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E55A3B7137
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB41B253934;
	Wed,  2 Jul 2025 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tl6gO8QQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864282F42;
	Wed,  2 Jul 2025 11:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751454582; cv=none; b=BJaAvO4TMh0GgQLSqtsWfx7Scg+M+JOopM9rvxMHDODa1BAbUI5x7GLZqV1a36k/s5lC0RN33e/BA70wL+YlmLkIEALzk/bqYwgsxi2WaYfMFv1RBszGZEhcYaeZk+DqHC/MJkrguxpI93pAGT5fGNaULAYbWKPfRSeBSajoWGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751454582; c=relaxed/simple;
	bh=57Fl+FDb715DOTWujCvfQiotxVym/fzMKjNKhXeIWDM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W+Obc6VMVXEGeXLJjbP1jq6NJb4zNViD8kRkFp8EEfUgJvaVN9UBhhr6Vf5UEAhncGTQ3vuy/L3NHssoZM/YHLrv1zmcpYfFUiVgSDnaMWHsgDq3SadyAiRVE/X/MnBK+KdPIYUmfzFda7v2+8zmz7Dk1QgJmSgNTTMv3TP5Epk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tl6gO8QQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B847C4CEED;
	Wed,  2 Jul 2025 11:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751454582;
	bh=57Fl+FDb715DOTWujCvfQiotxVym/fzMKjNKhXeIWDM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tl6gO8QQaEzEes/9o+G2kCfkIUop+0B6nyKMfwxyJItKvZ8fBHm+UsJF4RwlN7iiy
	 JNeojZbOGFEYb/NNEiLsSN46zkkyMV6yMvJfG/zHVMqWt/F3FusbAr1nVuOxX0pcCA
	 TLyHJdjKm7Ysf4XGAWMf/ol+QhGFpWqEekrT1zZqs+FEqUYgwgUjKnYIkqfeeSAY+J
	 jhNPN2CT0tXxhT/jWRTj1zZmK6roqVJOASAy0uBi89t/7SMaEFtVW8C7Z5yiMFz2Uo
	 o72wjsI7aKI8Kf8q6pfaS61wUoU/a3MyeGe0IxPd84LfXaFnB34kJwmXptlDIMpqoB
	 0JIaH0/dhMamQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC93383B273;
	Wed,  2 Jul 2025 11:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] nui: Fix dma_mapping_error() check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175145460676.672551.14139159079861193652.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 11:10:06 +0000
References: <20250630083650.47392-2-fourier.thomas@gmail.com>
In-Reply-To: <20250630083650.47392-2-fourier.thomas@gmail.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, tglx@linutronix.de, mingo@kernel.org,
 willy@infradead.org, dullfire@yahoo.com, u.kleine-koenig@baylibre.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 30 Jun 2025 10:36:43 +0200 you wrote:
> dma_map_XXX() functions return values DMA_MAPPING_ERROR as error values
> which is often ~0.  The error value should be tested with
> dma_mapping_error().
> 
> This patch creates a new function in niu_ops to test if the mapping
> failed.  The test is fixed in niu_rbr_add_page(), added in
> niu_start_xmit() and the successfully mapped pages are unmaped upon error.
> 
> [...]

Here is the summary with links:
  - [net,v2] nui: Fix dma_mapping_error() check
    https://git.kernel.org/netdev/net/c/561aa0e22b70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



