Return-Path: <netdev+bounces-193833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86634AC5F95
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 04:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912694C1A83
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 02:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FBE1DE4EF;
	Wed, 28 May 2025 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8w1BoSR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D98F1DE3A4;
	Wed, 28 May 2025 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748399403; cv=none; b=mYrX2ur86lW+8/AOsjcfWeCIOAbCMNwXbgEjpRSAt2lPofDbaiIFMWLw9BGPP83rP+aoIRG2txM109b7KbfDUMogj/3aWSo+sZfM02JRZh8xVk42jjYSy0je9xg+yXeK/EQ8j3seFjUYAIAZWouC/AEUuymEnwLl3YGhbAHgmyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748399403; c=relaxed/simple;
	bh=4aOTZR6sBzl1F4lchzxw3b6kURa/QodcelE0rGzK69I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gBgLzK7hiSjyPQ7VfWPiI1JGXsXkqKIebRXRDtggIAhdo8LO4DfHuIsRbkIDJxC2Sy2M6bvFrUtaP1i5clJrjPsM45hNIGnI+eflEEsdf6a8eeMG4YxxU2QylFqwsKaz67V2osou+I0cvE2FZR2hNWN1c7etzaIBwn8ullB9Oa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8w1BoSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FEDC4CEEA;
	Wed, 28 May 2025 02:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748399402;
	bh=4aOTZR6sBzl1F4lchzxw3b6kURa/QodcelE0rGzK69I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H8w1BoSRwYbyinQ4snWfjt6MLnfTnubr2sRn1nNS6bT0OGjgjZQyJNEp452llfxMj
	 JN7LEs1IW3DSKOOq2d8DIA0XlWHQ7hPgQmr23lTElAEg15dG3BkDh4wJqMhagPigTM
	 jAtRFhoFNALPv8OhjTEereUpOesbUUcxktQO4ddpNfy7pxt4i2ptwLF6QB8lAsZwPR
	 F7xvoaDBteEUICMx5LKypuRw2xgiQOUd06lj9I6XNAhrlVpZ8pYcK6gJjXpa82GLOM
	 dBKkhy97/f7ENg/DHOYPgmlsOZoa+gqnNaNpcpLW+y238U2CKkuzyN30bBQWkkh8tx
	 1OpjODI3juvLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D3C3822D1A;
	Wed, 28 May 2025 02:30:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: phy: mscc: Fix memory leak when using one step
 timestamping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174839943674.1866481.1704860946542275477.git-patchwork-notify@kernel.org>
Date: Wed, 28 May 2025 02:30:36 +0000
References: <20250522115722.2827199-1-horatiu.vultur@microchip.com>
In-Reply-To: <20250522115722.2827199-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, kory.maincent@bootlin.com, shannon.nelson@amd.com,
 rrameshbabu@nvidia.com, viro@zeniv.linux.org.uk, quentin.schulz@bootlin.com,
 atenart@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 May 2025 13:57:22 +0200 you wrote:
> Fix memory leak when running one-step timestamping. When running
> one-step sync timestamping, the HW is configured to insert the TX time
> into the frame, so there is no reason to keep the skb anymore. As in
> this case the HW will never generate an interrupt to say that the frame
> was timestamped, then the frame will never released.
> Fix this by freeing the frame in case of one-step timestamping.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: mscc: Fix memory leak when using one step timestamping
    https://git.kernel.org/netdev/net/c/846992645b25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



