Return-Path: <netdev+bounces-213523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A728B25826
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 02:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36EC65A14B3
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 00:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BD02FF657;
	Thu, 14 Aug 2025 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVJQWAVI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C98A2FF64C
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755130794; cv=none; b=fkV4oGJUFIS+BuwNfL/r8O7UM988EDEmtFSCEU/YWLzoRCq9U1+lag2Tk0bsvRTpyoD7SMRPaK9nnBO6PFMuBK5YRxqDoqSJ3y9+DnJQT1xKAEZYfe5cHw3XWt8olggttWE8AF0IOsyi+J+W9ivCBZ3gc3Xa5dZ7/UBrL33VtMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755130794; c=relaxed/simple;
	bh=/jXdd/Wgx52wkOLoFX3uQ9Soi1CVYMhxmFzTWj5/OSI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UsBN9NvPDIiDBiez+7HBc7o8/baCBLkT0lP1XNg8gbeP9zGoFUOd6ziQXT4RBU3KG0J187b2hKU5DCtizyOJHRjdyin8PXsEFOCizejxN2bacAOCv92CM2U0HV65o22mLXtJ3Mtfjt7UBEs0RaGrPhTrZetcZ/zb5opIL+hJg74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVJQWAVI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E468EC4CEED;
	Thu, 14 Aug 2025 00:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755130793;
	bh=/jXdd/Wgx52wkOLoFX3uQ9Soi1CVYMhxmFzTWj5/OSI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QVJQWAVInXCvLvPHgFsV9Zr0ztcUmiWKS8zhLPBxUTyiYUdBpi7uFI2007uitGN9r
	 5/OK0C5f+A4dW3pHuWWpI+wU7C3WEt8TbrxSys0eCohZ/kaNCrRdAGtRV0EUvMlGSr
	 4/+js43Fh1R11dzDbVPakmHPQmf3xgqfVxRBONNh92NnbGhfsUr9dfJiXheRXWNqsF
	 Px13WcxwDb7vnXCy0szmPKx93NB5CbJtxKxGCf/xMYgDIjp60jQnZPc9aOLvtZN9AN
	 qQLth7kOof2ymnKuXz50iJDgJ9fxyQN9jLjBtKn5oPITkqYtLO5Peg1l3aAA56KEyS
	 xhPX8U4hhHxEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD2839D0C37;
	Thu, 14 Aug 2025 00:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mctp: Fix bad kfree_skb in bind lookup test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175513080550.3827563.1315593994852851350.git-patchwork-notify@kernel.org>
Date: Thu, 14 Aug 2025 00:20:05 +0000
References: 
 <20250812-fix-mctp-bind-test-v1-1-5e2128664eb3@codeconstruct.com.au>
In-Reply-To: 
 <20250812-fix-mctp-bind-test-v1-1-5e2128664eb3@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: jk@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 alex@ghiti.fr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Aug 2025 13:08:58 +0800 you wrote:
> The kunit test's skb_pkt is consumed by mctp_dst_input() so shouldn't be
> freed separately.
> 
> Fixes: e6d8e7dbc5a3 ("net: mctp: Add bind lookup test")
> Reported-by: Alexandre Ghiti <alex@ghiti.fr>
> Closes: https://lore.kernel.org/all/734b02a3-1941-49df-a0da-ec14310d41e4@ghiti.fr/
> Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
> 
> [...]

Here is the summary with links:
  - [net] net: mctp: Fix bad kfree_skb in bind lookup test
    https://git.kernel.org/netdev/net/c/a58893aa1739

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



