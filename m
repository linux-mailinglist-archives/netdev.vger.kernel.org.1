Return-Path: <netdev+bounces-180269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2A0A80D76
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0601B64085
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6051DDA39;
	Tue,  8 Apr 2025 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUFQoBU5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F333817E00E;
	Tue,  8 Apr 2025 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744121019; cv=none; b=c+Ra2hUQbP3z8vNa5P+xQThzENYiA9pm2dEzgjahaC347TN0j1+K3jhf5ZxPB4WJjdMmfOhZtNQjKxOa06P6HuFW3jAusSU0vKhDH8kU8ZyxvZs0sHPEZlhm+179r3qqc98ntW78ZvUPomymnVzit+CxG16tAxS7x0mvpRXyEOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744121019; c=relaxed/simple;
	bh=p3IVzob9u3/boVP5crlJ8wFVi3dNbct56hn9wbds+wU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Mn+ffALr47fR8nGmREvtVRO8wDMucL94r+OPoeC8Iq9LIqlgvY4pFSQdYLCOKH96VRMzMzzSpRgmH9K0ADkLImaWij2X07S7gEte6M4mCwvBfHoK8upms6jsiZArcY9wDLjeJ9aH14uYrXYpViFJWluO8ea22srcZBY4MXI6UP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUFQoBU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60136C4CEE5;
	Tue,  8 Apr 2025 14:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744121018;
	bh=p3IVzob9u3/boVP5crlJ8wFVi3dNbct56hn9wbds+wU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BUFQoBU5s+rRllDzsyCO42UKQpjipU6Mc11iFy+zulBOIjmaHYaPQgRPBfPpdNJv9
	 7rGBysW08k3zacndMJ4292Uq1skheeQ2WHwJ/qAuvur36E0wcbwx0tsVdNIdWiCYSj
	 tWLh5iOFm066Wl0Y/KSPW4kzGsgU7z//NbSAuhVOQ2bYN+/cqgM5hllQXqPy402Mto
	 dSZEJImgLcsuv/QH98DB34apM05Z9AMTr3Qs9Oh0BVmAIscf9hTZyxawUv72pokI6D
	 rV+x6tto/eVPcJt+yaoBRNTLq7R0rR0plizblwcZNiRi/6daePtjZNuCV3syuqLzbr
	 Ctcx45f5cUBGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB31238111D4;
	Tue,  8 Apr 2025 14:04:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethtool: Don't call .cleanup_data when
 prepare_data fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174412105573.1926106.14278610870424397090.git-patchwork-notify@kernel.org>
Date: Tue, 08 Apr 2025 14:04:15 +0000
References: <20250407130511.75621-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20250407130511.75621-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, horms@kernel.org, mkubecek@suse.cz,
 f.fainelli@gmail.com, kory.maincent@bootlin.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  7 Apr 2025 15:05:10 +0200 you wrote:
> There's a consistent pattern where the .cleanup_data() callback is
> called when .prepare_data() fails, when it should really be called to
> clean after a successful .prepare_data() as per the documentation.
> 
> Rewrite the error-handling paths to make sure we don't cleanup
> un-prepared data.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethtool: Don't call .cleanup_data when prepare_data fails
    https://git.kernel.org/netdev/net/c/4f038a6a02d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



