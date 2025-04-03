Return-Path: <netdev+bounces-179203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2290A7B1F9
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 00:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22043BA162
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 22:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0344D1DD9D3;
	Thu,  3 Apr 2025 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h443Jxbq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDAF1A83E2;
	Thu,  3 Apr 2025 22:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743718800; cv=none; b=imgxVrqfzXBd5hpgO1sVSfHuE4xMu3UISmpV4S6EOUEuPCdIvQxfTnmWwuUnNJr1IUUO9Q/6oZuVU+RRngHQ8wBZeP0OtLP3dL7m36sWMX6vQfdu05SzYe0CpsH3F1j52A8Pgu9z3iB0/r+u7hg2cAptW0q47ZuEtsMrxNs137A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743718800; c=relaxed/simple;
	bh=0sWnk2DoVQ9pROgDQR4uYnx/4NK2XpAdbm+4WZXb+bY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W+XnztxSnYfhMnWuhq+tbeflkigQc4DrTseXPbZj5gDyn4DMRZ5Asy1vJnz5noOwTLXWXb52N65KdJkdhtwPThXcvuz4QsJZsEsiK4pUJctJa57g+5of5OvgXEDtLmjB+mRwSGuMzmRJjHbJx5glpB08FPzeodJRgDa6kvJmqvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h443Jxbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401A0C4CEE3;
	Thu,  3 Apr 2025 22:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743718800;
	bh=0sWnk2DoVQ9pROgDQR4uYnx/4NK2XpAdbm+4WZXb+bY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h443JxbqzTgsJsQFLPGnG9pi185gCsCb89dlP+56JGSRXIclGrVKzTunLjaxrsVA5
	 Pkj6YbCTDvYabqmZbi0HbvwV/DiJM9pWvVCRAR35zw/GgM5sauyNr98L/0F5umEDPA
	 5QbcadhTEogR2LMFfaFZoqE8p56lmpRg6nMocGRRTLD7cYP4JBVEVDFU1Hyto05ol8
	 k/azFVSEA3li8635eKebNmWGxf3xm3Jnp5iPpVOumdnQbaZOA/Ci+xYvQ+V/FPex3c
	 d2X4YK80Cf9yFVVo1TKQpkaPl55q1AJPgyoAFxdYO2YfcWuqrnp/Tyn959zvCEJOC1
	 9KVv9NN4u4B6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D2E380664C;
	Thu,  3 Apr 2025 22:20:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] net: dsa: mv88e6xxx: propperly shutdown PPU re-enable
 timer on destroy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174371883723.2702664.483595535919896131.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 22:20:37 +0000
References: <20250401135705.92760-1-david.oberhollenzer@sigma-star.at>
In-Reply-To: <20250401135705.92760-1-david.oberhollenzer@sigma-star.at>
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, Julian.FRIEDRICH@frequentis.com,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, upstream+netdev@sigma-star.at

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Apr 2025 15:56:37 +0200 you wrote:
> The mv88e6xxx has an internal PPU that polls PHY state. If we want to
> access the internal PHYs, we need to disable the PPU first. Because
> that is a slow operation, a 10ms timer is used to re-enable it,
> canceled with every access, so bulk operations effectively only
> disable it once and re-enable it some 10ms after the last access.
> 
> If a PHY is accessed and then the mv88e6xxx module is removed before
> the 10ms are up, the PPU re-enable ends up accessing a dangling pointer.
> 
> [...]

Here is the summary with links:
  - [v4] net: dsa: mv88e6xxx: propperly shutdown PPU re-enable timer on destroy
    https://git.kernel.org/netdev/net/c/a58d882841a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



