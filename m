Return-Path: <netdev+bounces-108325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9AE91ED6D
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 05:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA301C21305
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 03:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0358C282E1;
	Tue,  2 Jul 2024 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHCt//Dp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D192722F14
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719890431; cv=none; b=qe7KrRfvYA6DAjgu44jU6WyKxiXjbPGJnn027otFd/0cuOhzzIQSHu9L6tqM1WAQsivLn+E+K/owGwFcb8/cYtUyXZMSxHWHMhJUrC+naRdmzcm4A38+KKg5vOIkPz3KiWxgWU2V+HZkXQ5Eadh42gUtliY9aoH/rs0OG7pHdOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719890431; c=relaxed/simple;
	bh=yB60sJ6WGNu7poLEv2R412rzJlWa/N5dnX8u3Ue9peY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nNjkSOKxTFZmjkGVD3XjDzK/IRQo7XuTegbJgOc65UtuPDpQS1lCSCmpZqMoQmwTrh4pQ2NpJ3MFZYsPxmWRRZSu+22hOGa7WAekRX2nCONnsqCO9fFaGIRduMlzXqUG/3bpw94+GxDWruqXqO7Y+iiaLWXLD05V6Jp973BtyII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHCt//Dp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D47BC32786;
	Tue,  2 Jul 2024 03:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719890431;
	bh=yB60sJ6WGNu7poLEv2R412rzJlWa/N5dnX8u3Ue9peY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QHCt//Dpvpgr7zpT1aEn4c0v8iIb99z4C3Vu/QF7i+Kp9HOSCvvTwsALZEAWyI7bG
	 dWgcj8sY3lHd0dKhqB2HVVU57Pebx2PMq6Cf2RR4/76TsVeNMYAO1+oXDTvydCTyLe
	 Fsx3oD22EJnvG07tBwlq24QD10ZcgVArITdjbYun6DQr/TAjknfIeNcTKEx+UGq/0U
	 zR4RElQ6BFUjrVkD468sN/8oeYhn+JCi52u39MqjTa6w5gWOPveoG5lyTgAmYgiRpe
	 O7hhdG+zEbHoiqnivEhGpwH5tjhW3/5bqqn/omOEH2pKl+SZqvFnSvX1yp/kcuE5WK
	 PdlKbjttCxAzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E4FDC4333A;
	Tue,  2 Jul 2024 03:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phy: fix potential use of NULL pointer in
 phy_suspend()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171989043144.2079.13227859011824046217.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jul 2024 03:20:31 +0000
References: <E1sN8tn-00GDCZ-Jj@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1sN8tn-00GDCZ-Jj@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Jun 2024 11:32:11 +0100 you wrote:
> phy_suspend() checks the WoL status, and then dereferences
> phydrv->flags if (and only if) we decided that WoL has been enabled
> on either the PHY or the netdev.
> 
> We then check whether phydrv was NULL, but we've potentially already
> dereferenced the pointer.
> 
> [...]

Here is the summary with links:
  - [net] net: phy: fix potential use of NULL pointer in phy_suspend()
    https://git.kernel.org/netdev/net-next/c/19e6ad2c7578

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



