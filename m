Return-Path: <netdev+bounces-155645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BF5A03419
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 01:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70BE47A129C
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 00:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E55208A9;
	Tue,  7 Jan 2025 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Um+qS9Ly"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1451D2594A4
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 00:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736210411; cv=none; b=fzhg0w3YqH6e41YPY7z7EhjLzkgt7yLxTx83TCGtkbbAY8JsVai5l8LNtVsGVAgTns5YYu/kA383oj2QiMuexKjY7kaZLH91MAzIdRbQduL0ERAKZqoj8dFG8PPmD0e1FpkN2MPWgacA06/BoPhLHHliII59fuNzOqQldeOCfhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736210411; c=relaxed/simple;
	bh=a0P9PXv3fgpQbl9GRqNC+d6KNY7M9TQPoMM5wvt3gzw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GRdxZxB32xUFGGkQQ7QhqlH0Dh44El/7ROUWwmPZ7hK7mW019MS5SfLIst3iO80zdbSEsqUETe8nP4eGrpu50IGIEITZnVhdqIINeV5B/3ZfBajPUwG2rtmuB4ilJe61FTLyil+MrzZGcgYacP0Rra9HCrZMIPunGqrKUXNX7co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Um+qS9Ly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7987C4CED2;
	Tue,  7 Jan 2025 00:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736210410;
	bh=a0P9PXv3fgpQbl9GRqNC+d6KNY7M9TQPoMM5wvt3gzw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Um+qS9LyiUV7v23G0Du0q6Ka49nrAH+24Jux7Xc6jr3+tMuHtQk8NQX9WTRD7WrpN
	 qY6crtLNtoplZQSWNfhxYZfTfluNTaDp6UjZKCnMy+VUe4OB9OU6pneoTr4Qv2dX3X
	 LXCsNbSVu9RQpM/vU277WOn8Fp3kxeGYHENPzJ/rdSPsreH68LObrYy0VNu1rIbKyl
	 tdKiaUuR/ILSmrkZOgvXe1aSnQ4JHwtVpNEwriyesHsQDTJw1eWALcLEG5V7LIp8Wu
	 iToPHYwt0dWw1NQ2xiaEheek7lhV6fb9wuy0PkX5XXWU2HxQxe0PucjNoo4e/Jd8/i
	 ZN4GN2Sh/kytQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EA9380A97E;
	Tue,  7 Jan 2025 00:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] pds_core: limit loop over fw name list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173621043203.3661002.5240370095816016455.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jan 2025 00:40:32 +0000
References: <20250103195147.7408-1-shannon.nelson@amd.com>
In-Reply-To: <20250103195147.7408-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 jacob.e.keller@intel.com, brett.creeley@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 3 Jan 2025 11:51:47 -0800 you wrote:
> Add an array size limit to the for-loop to be sure we don't try
> to reference a fw_version string off the end of the fw info names
> array.  We know that our firmware only has a limited number
> of firmware slot names, but we shouldn't leave this unchecked.
> 
> Fixes: 45d76f492938 ("pds_core: set up device and adminq")
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> [...]

Here is the summary with links:
  - [net] pds_core: limit loop over fw name list
    https://git.kernel.org/netdev/net/c/8c817eb26230

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



