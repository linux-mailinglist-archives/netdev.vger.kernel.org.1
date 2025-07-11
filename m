Return-Path: <netdev+bounces-206283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A1BB02777
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 01:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50B387B00BC
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 23:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669522253EB;
	Fri, 11 Jul 2025 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAuqkovB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F482248B5
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752275408; cv=none; b=q4YmabKOB1Pl2StfyBf6IkW5UrNimtmnwClyG/hT0Q1whuNC4Qy2AZseGiWaqZdkwPThUQo2+JHUfB5HwCtMbd7XIK8mqs4rgqj3NFkoQ1Rtz1ILJH03DMsMdXuCjYrW7952W1V4sQiA/A4SeZkRDo4nQhxDuYiJrRlFFwbCvog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752275408; c=relaxed/simple;
	bh=7FozfwUy33AZvJjlg6caBgtdo8gCMV/LB8ctOu3ny9s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kZbCQKr8JsRzhTGXdvPCWV2zv8u4SfS7zZFC9ljZ9L3Q9KxJ41tp6dKVc+21TF5JXc2eMzGbP82gLduIZsH/+shccSgGzKqD+0yefoN/vLCV+YDCv0cqikGHgDTx34XMOKJ6D2e3QLH5CgR58YJ7zrvUwwmyDIh6adsKAcOkR1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAuqkovB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD20C4CEF4;
	Fri, 11 Jul 2025 23:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752275407;
	bh=7FozfwUy33AZvJjlg6caBgtdo8gCMV/LB8ctOu3ny9s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qAuqkovB1abOBZZRphr+HSan4A7L+Um+q26r1NRrDC35dLWZWf0y03wV6XSDDCBRM
	 UCJL2zjubitgXqG1ue5yNW3h4NLxi5dl2Z96Ww7ZkFBSSD1J+INoguXPT80zM5C0E2
	 e68qPdLvPGDGf8Ge4MgaZJ7XcwujAcxtY0/YkCJZF1i2PRRfZTfZHkXXbo5L1mu3VF
	 QNzYodmE97yb/c/gbThgYgehQw53A9J0nF8sgn4dEp2t9IjjFFb8nmMFQRFrswML7v
	 upNPzdC65LiKJ6I293sYlH8mSQUyT1ADBMyvkYqSyLav2FsUA+SrS8/FVInUDtgQMn
	 Zc9AOoUdnCH4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC54383B275;
	Fri, 11 Jul 2025 23:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: fbnic: fix ubsan complaints about OOB
 accesses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175227542949.2429127.4875665902471663608.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 23:10:29 +0000
References: <20250709205910.3107691-1-kuba@kernel.org>
In-Reply-To: <20250709205910.3107691-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 alexanderduyck@fb.com, jacob.e.keller@intel.com, lee@trager.us

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Jul 2025 13:59:10 -0700 you wrote:
> UBSAN complains that we reach beyond the end of the log entry:
> 
>    UBSAN: array-index-out-of-bounds in drivers/net/ethernet/meta/fbnic/fbnic_fw_log.c:94:50
>    index 71 is out of range for type 'char [*]'
>    Call Trace:
>     <TASK>
>     ubsan_epilogue+0x5/0x2b
>     fbnic_fw_log_write+0x120/0x960
>     fbnic_fw_parse_logs+0x161/0x210
> 
> [...]

Here is the summary with links:
  - [net-next] eth: fbnic: fix ubsan complaints about OOB accesses
    https://git.kernel.org/netdev/net-next/c/0346000aaab8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



