Return-Path: <netdev+bounces-244219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1784CB28CC
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 10:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A77631BDC54
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 09:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07023164C3;
	Wed, 10 Dec 2025 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQN0zC3S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4EA3161AB;
	Wed, 10 Dec 2025 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765358605; cv=none; b=PDxrmLx97HO5Si8iL25uI28olfCj6cnrUpEO/Cjjzod9FRiXYhld3/hLv8iolgxI9KNtCA8PTHFlJZsKNPTko7J/rB+9X66hPIeCv2QSySB0mEHdLVR9ivf7aRHcKc3mZhDAnOWF6Zhg9hAkigE/oK+5pBb/vIoCVpUB+8nYBlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765358605; c=relaxed/simple;
	bh=yud9d7xRRnKX8Z4cx9pFS4r5N3vOMdRhh2r+w6h4r0g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XkXGVWobTYsZKV9IsqAOnYpBdKplFvqxHo6bISK68/LSHUujzvIVrgtyfn4zVfaI9Afs/szo458EXydvRkNHuFr76QkfzSUAk1jbZV0QQesQ1CdtrcPvenjoFD/Uo69TfLg9buiMfFlvFAlqThcbJFa4hmsIxD4sUvuylh1B99c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQN0zC3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13223C4CEF1;
	Wed, 10 Dec 2025 09:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765358605;
	bh=yud9d7xRRnKX8Z4cx9pFS4r5N3vOMdRhh2r+w6h4r0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pQN0zC3S9zrGrOvf7QUmb3ZzVJ6p8BOktQI4ELDyjoq7LPcyZzc8rwxNW/gNO1mOC
	 //XwugSUqSXGd/76uz1jtXP8y/9CNymj49jIPFz1D74q+l0H7OG/9cDwnYZI/WdaX3
	 9n3QXWHjNC7WhPuJ8Tj/Bs0NiKq8pogEqQv1AHaRZGL88fWNvV9JwKlMSknGJo5HAV
	 cQbG1aPNmVpdh50G7h7CDlm7R0M7UbmiOIE+FI/PMAa+xCOLLssRSxvQ9EGc1T19Zn
	 pYTV9wxN8UwCQuvsaY5dNAnmJNETXBABMNwfZXVD9m8M5hV0GOSM5R088m1gj2lKBa
	 O9QCqdk0u6Q2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F38F03809A18;
	Wed, 10 Dec 2025 09:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] broadcom: b44: prevent uninitialized value usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176535841952.523551.15948127440248355186.git-patchwork-notify@kernel.org>
Date: Wed, 10 Dec 2025 09:20:19 +0000
References: <20251205155815.4348-1-bigalex934@gmail.com>
In-Reply-To: <20251205155815.4348-1-bigalex934@gmail.com>
To: Alexey Simakov <bigalex934@gmail.com>
Cc: michael.chan@broadcom.com, andrew+netdev@lunn.ch, jonas.gorski@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linville@tuxdriver.com, mb@bu3sch.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew@lunn.ch

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Dec 2025 18:58:16 +0300 you wrote:
> On execution path with raised B44_FLAG_EXTERNAL_PHY, b44_readphy()
> leaves bmcr value uninitialized and it is used later in the code.
> 
> Add check of this flag at the beginning of the b44_nway_reset() and
> exit early of the function with restarting autonegotiation if an
> external PHY is used.
> 
> [...]

Here is the summary with links:
  - [net,v3] broadcom: b44: prevent uninitialized value usage
    https://git.kernel.org/netdev/net/c/50b3db3e1186

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



