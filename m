Return-Path: <netdev+bounces-132916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BBF993B85
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 02:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4873C1C23137
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 00:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A9742AB9;
	Tue,  8 Oct 2024 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5+U+R+n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D78633997
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728345629; cv=none; b=Z3+DIX919LMpERbMmwz1WUW7SHU3SZBsolOBuYhfePm5y9WdO2i7PN2CUa2aQhCWVaCCOPgniQmcAWstQnocHzZPjS1WDGMk/DN77g8ADUdWE4ycQvoSpx5aE+pULyjeRNxnVveb0whlPF1ihPq+QtIek25h2e43tME2py9f1qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728345629; c=relaxed/simple;
	bh=ZtKGbLTs9dR+H3qROSp8GGVC6daF8qlKfF2fJdH6uoQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ttbZimohigq9YG+IOS03GVMjACFLihyqF7vW0wfk6QBOxOS1822S4cd2p6sTsYBroskCom3Qhhfoqx2X8I44izJ5CsN6MuyWoTUYouEZPuYE3OUJILdwqe1dhl2TAI/IH04QF9KSD22TPvZyASXF1AZhwhZsufelqw0/fc99xCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5+U+R+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F50EC4CEC6;
	Tue,  8 Oct 2024 00:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728345628;
	bh=ZtKGbLTs9dR+H3qROSp8GGVC6daF8qlKfF2fJdH6uoQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A5+U+R+n4kx0VpVKlKTCo5vjkHxCR2Hr2RX6j7Qjv3GA136uuqu4HlutqXDRp2Zsc
	 wfjW+leR2AUKl1qJMWCDImll7epTjBH/AeQJHL7Ba9DmMZ0w6w8TbITYzwZeFJtMYf
	 qrwybN0HIltY7DCYE/nR6GHR8EdpPbJg8IH194A1Vaq+4MiCMETPX1kQbmMrxV9VHU
	 KgNSIkpS0QBFrGZYf6tgkrsDIfVgsM3ret7vuhw5hhRZ1E/DVWj2Z4ubND7twQgItq
	 JgPCZLUbLR8Xse6xRPHOiAwR1xMEyQ/JyVx0GCCRIQMNmbucgOnBrlqeVs323kZr1F
	 uVaq4mmRhICbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFBE3803262;
	Tue,  8 Oct 2024 00:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: dsa: lan9303: ensure chip reset and wait for
 READY status
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172834563274.23025.4578043543403301514.git-patchwork-notify@kernel.org>
Date: Tue, 08 Oct 2024 00:00:32 +0000
References: <20241004113655.3436296-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20241004113655.3436296-1-alexander.sverdlin@siemens.com>
To: Sverdlin@codeaurora.org,
	Alexander <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, agust@denx.de, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  4 Oct 2024 13:36:54 +0200 you wrote:
> From: Anatolij Gustschin <agust@denx.de>
> 
> Accessing device registers seems to be not reliable, the chip
> revision is sometimes detected wrongly (0 instead of expected 1).
> 
> Ensure that the chip reset is performed via reset GPIO and then
> wait for 'Device Ready' status in HW_CFG register before doing
> any register initializations.
> 
> [...]

Here is the summary with links:
  - [net,v4] net: dsa: lan9303: ensure chip reset and wait for READY status
    https://git.kernel.org/netdev/net/c/5c14e51d2d7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



