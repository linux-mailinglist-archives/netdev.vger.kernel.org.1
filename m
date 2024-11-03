Return-Path: <netdev+bounces-141328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D4E9BA7AD
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 20:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB2B1F211CD
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 19:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F5E1865FC;
	Sun,  3 Nov 2024 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IT/XYN0/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706B6158A36;
	Sun,  3 Nov 2024 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730662542; cv=none; b=k1RKShEz3WcduBw1Awbw8/HeKHdxDMT5zyHu5qI1RFuhbAIQjORNeWJd407AokD/h5qwWJcr4D8K5AXSj70l6IqFotL0Pe8Kzemc7HgLkAxeF2nhAzRy1Y3FGgGHAQRHNDHzJSbq781MrDAzKFWxgq2NzpIBtALjr0CYu4c4I28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730662542; c=relaxed/simple;
	bh=3i37xFenKWA+UPTJ/JRCjAHQUph/DlCbchQdJRAm2Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYyEXs2H2bBMYTiw765Ugz71xBlz84+ZEWPVUMrZOLSrfc/Pone0RpR8D3vzhKJ6xOMXcr1OOzD8nw9U7mvlfzOoxAQVTXQvFPl8RqElNJzuA8dMxGVSpiNGLTsPv5VDTmfv0mldnfWbdyOHOWUxDEIVNwGLutkOr4YXfJqDuXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IT/XYN0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42280C4CED0;
	Sun,  3 Nov 2024 19:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730662542;
	bh=3i37xFenKWA+UPTJ/JRCjAHQUph/DlCbchQdJRAm2Ko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IT/XYN0/vNmWjmug2f4sIF9BgAsftD4S0acy9xQR8uujZm8AGZh1ZcYWnj2MqVQNx
	 huxP0QL+qHId8Bt7f5mqpBl67Zq04eZF3PNprlmoUFqlVd60RXPIYXw2vNbKsOXw37
	 14D/i2qniQHuwb9NvhJY1aFJiuYjkloiW5G0242xPNTdTgfULIq5Eo/GD276JD2D/P
	 EP8YeOZIIGPr36oad6LDRqSlgi89+k5vrJanzDTXMOdO9b47KLspgnFAfgj/PpuNF8
	 DRORpjSwYFEhJYh+W3pv9aYVNW+x1K3LAjHW5k+Fxs445cR3PTvs286mwTGDX2qfbG
	 ERaFUcY5j72LA==
Date: Sun, 3 Nov 2024 11:35:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, Julian.FRIEDRICH@frequentis.com,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 upstream+netdev@sigma-star.at
Subject: Re: [PATCH] net: dsa: mv88e6xxx: properly shutdown PPU re-enable
 timer on destroy
Message-ID: <20241103113539.7b44e4f3@kernel.org>
In-Reply-To: <20241029124332.51008-1-david.oberhollenzer@sigma-star.at>
References: <20241029124332.51008-1-david.oberhollenzer@sigma-star.at>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 13:42:45 +0100 David Oberhollenzer wrote:
> The mv88e6xxx has an internal PPU that polls PHY state. If we want to
> access the internal PHYs, we need to disable it. Because enable/disable
> of the PPU is a slow operation, a 10ms timer is used to re-enable it,
> canceled with every access, so bulk operations effectively only disable
> it once and re-enable it some 10ms after the last access.
> 
> If a PHY is accessed and then the mv88e6xxx module is removed before
> the 10ms are up, the PPU re-enable ends up accessing a dangling pointer.
> 
> This is easily triggered by deferred probing during boot-up. MDIO bus
> and PHY registration may succeed, but switch registration fails later
> on, because the CPU port depends on a very slow device. In this case,
> probe() fails, but the MDIO subsystem may already have accessed bus
> or the PHYs, arming timer.
> 
> This is fixed as follows:
>  - If probe fails after mv88e6xxx_phy_init(), make sure we also call
>    mv88e6xxx_phy_destroy() before returning
>  - In mv88e6xxx_phy_destroy(), grab the ppu_mutex to make sure the work
>    function either has already exited, or (should it run) cannot do
>    anything, fails to grab the mutex and returns.
>  - In addition to destroying the timer, also destroy the work item, in
>    case the timer has already fired.
>  - Do all of this synchronously, to make sure timer & work item are
>    destroyed and none of the callbacks are running.

Looks good, AFAICT. Could you repost with a Fixes tag added?
To make the job of the stable team easier?

