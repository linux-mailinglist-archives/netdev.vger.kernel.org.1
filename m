Return-Path: <netdev+bounces-206005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AA8B010B6
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 03:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CCE7654FB
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 01:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24AF713774D;
	Fri, 11 Jul 2025 01:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HD5kFV9N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF03812CD88;
	Fri, 11 Jul 2025 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752196810; cv=none; b=plPiGr5VrY4dvcEzXlcPs7tdCRQFkWUr0V0TD5+LXlTagUGhHltayCo4AqO1kNqEXou80vPZ39EzHcCxO7YBFM6etNL6gYJcnmo1O+UuA2W1OVEMs1sQOI1raLvM43dPnQrZX0y3PUkCsOQipoiQg69SFS8Bqkos6R2Kjon7Rvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752196810; c=relaxed/simple;
	bh=pMpEh5uBvXU09/7ECEriFU/SvagO9Vw1RdKHYbKGwCY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o7MHboODlM0xr00HrqU1GrfMnpX7cIzMFBmdAq2lormKbHgb/Zegm9MtcCaRO1hz7kj8+lxtUO0l26wl3K7qqmqOF+Nd9hYBb+p/lveaVIAU6pO7MrEvzYoxKyhxKF7tk5bAo4cU0xTCld1pslvP9XMVg5TkfkvAUfJYZP7kYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HD5kFV9N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC152C4CEF5;
	Fri, 11 Jul 2025 01:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752196809;
	bh=pMpEh5uBvXU09/7ECEriFU/SvagO9Vw1RdKHYbKGwCY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HD5kFV9NGW+bzMgzU77ue26m/dOLAah6wdWCNZUnMGzvAntTiAyVZjoeuZp6oHtHK
	 icQOP3WhOTQxRGcqWNZlBUEJHOD8j0NZ7szWOMF1Y5rp2S04AHhMr2G1GGEn0/ZVpW
	 EFM4R3oqC+mBwrtGFv3R5ZU96b2UA5XG0h5iGvUAtuELNPDDHHCK4nGI9eeVz0oN7A
	 zi+r1lK23QVKGXTpFJp50x2IRdTKMGFugERltwZePTjExOn+gWDvPdKOX3ZzP8JLVi
	 I3QkyGepJbkhbSeoa9NK8vmC+HGhN8evXDPS7VSM35g+uEIOp/G2QkUAqyW28DJZAr
	 wnoHzDLiQMd0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C85383B266;
	Fri, 11 Jul 2025 01:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: pse-pd: pd692x0: reduce stack usage in
 pd692x0_setup_pi_matrix
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175219683175.1724831.12946136584483725397.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 01:20:31 +0000
References: <20250709153210.1920125-1-arnd@kernel.org>
In-Reply-To: <20250709153210.1920125-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 arnd@arndb.de, colin.i.king@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Jul 2025 17:32:04 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The pd692x0_manager array in this function is really too big to fit on the
> stack, though this never triggered a warning until a recent patch made
> it slightly bigger:
> 
> drivers/net/pse-pd/pd692x0.c: In function 'pd692x0_setup_pi_matrix':
> drivers/net/pse-pd/pd692x0.c:1210:1: error: the frame size of 1584 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]
> 
> [...]

Here is the summary with links:
  - net: pse-pd: pd692x0: reduce stack usage in pd692x0_setup_pi_matrix
    https://git.kernel.org/netdev/net-next/c/d12b3dc10609

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



