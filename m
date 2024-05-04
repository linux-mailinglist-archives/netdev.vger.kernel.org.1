Return-Path: <netdev+bounces-93404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D76038BB8C8
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 02:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F611F221F0
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 00:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A83615C0;
	Sat,  4 May 2024 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzeD2KSD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E4822616
	for <netdev@vger.kernel.org>; Sat,  4 May 2024 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714782630; cv=none; b=LYo5SZJUO/ow+bEXNxsL6GKru+IVLBxSBOK/HCV8OY4R/xoYDO/at14EH48nBG24t+qIEXsofsLeoQPuvptwds1VV2IVW6HzpYHry7t+06A7LLrN2MHmeIgPOu/Y9cpOCJFFOQt8hEN+6lkCFxq5p2pXP9SsohNsk2qUaOzmUvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714782630; c=relaxed/simple;
	bh=//miG/cmFa3Qkrdzv/uUfjvfwXWOR92xqs96ca60byI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lKmVDxED1qsU4ecinBqOy0DMzfKjVeCEG7A+CV0fi2w7WXdSFBbq9FQO+7ssWRnYcmzlw7Qp6GgxxP3SHNfa18v8TheV1nl9IIwONAef4FN0Rlgs0fu3bAdOf8vDbhpuG6ylqY2i7gbJrvWJL33f0jRiqS9g6Y58s2QfgkJlMhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzeD2KSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC2E4C4AF48;
	Sat,  4 May 2024 00:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714782629;
	bh=//miG/cmFa3Qkrdzv/uUfjvfwXWOR92xqs96ca60byI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lzeD2KSDPVBKSFzeKKXcdJJc5r9e90GptDDAPBNGUBEOAla0poBCH1Xqd7RuyzEZo
	 4I9uQeDhF/rKkknDzBY1hHoRUkq8qOAESMZmJYWZJ0xGzKJ9b7RDyz3VNFS3D5q8Wd
	 Ww6Ey/7WgtUd1+7UvoGqtaHR7Aqzk7P2fBOlsAVercB1hGNXwzSNvdG3L7yf7u8UZU
	 rk2YXqNvdFGzer9OITN7j4ewZmgAIlJBnH0XpasefZScuomVbyiRNm2a8uISoUJXaE
	 Sqe5hgD2omn4O1Y4Vi0mEiIa+xVLn2oW9HZHIWTg9z7JJvMZ4VfD0BsyahXmksuH/4
	 14ipf72h2kncg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCBBEC4339F;
	Sat,  4 May 2024 00:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] bnxt: fix bnxt_get_avail_msix() returning
 negative values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171478262983.21471.17879490186087659876.git-patchwork-notify@kernel.org>
Date: Sat, 04 May 2024 00:30:29 +0000
References: <20240502203757.3761827-1-dw@davidwei.uk>
In-Reply-To: <20240502203757.3761827-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 May 2024 13:37:57 -0700 you wrote:
> Current net-next/main does not boot for older chipsets e.g. Stratus.
> 
> Sample dmesg:
> [   11.368315] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): Able to reserve only 0 out of 9 requested RX rings
> [   11.390181] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): Unable to reserve tx rings
> [   11.438780] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): 2nd rings reservation failed.
> [   11.487559] bnxt_en 0000:02:00.0 (unnamed net_device) (uninitialized): Not enough rings available.
> [   11.506012] bnxt_en 0000:02:00.0: probe with driver bnxt_en failed with error -12
> 
> [...]

Here is the summary with links:
  - [net-next,v2] bnxt: fix bnxt_get_avail_msix() returning negative values
    https://git.kernel.org/netdev/net-next/c/5bfadc573711

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



