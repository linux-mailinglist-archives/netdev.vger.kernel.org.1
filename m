Return-Path: <netdev+bounces-205621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9584FAFF6CE
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BF3584CD2
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59CB27FB2D;
	Thu, 10 Jul 2025 02:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0EXEXk/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5D927FB2B;
	Thu, 10 Jul 2025 02:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752114591; cv=none; b=JCKrk2Im93NHvmbrsdN6x37RLcCHQML+QQOu9hgfVg2dcPq3Enhw3ktSybuc9F6ptBJdShsIPIxFuLwFKVcnhvAlxBfvPw4IgJR5syiaLSIbDYK+R6ORrEpeYeinDhD43X8SVJrSBkC/gNIRuN3c8sXfeVYVRjld0yZakvEM+sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752114591; c=relaxed/simple;
	bh=xXT4x4JaFjSeep/Mbd917xNGkwFl5LwRQcGW2dS7HC8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kF8xs9OIGqVVHi2DlSQOqDYNiustYwRQs5DoUTyEyWVUcAJEdnEq2CgAy0CulKjJ+8yKMiyXN1AOE26LhknH43/K8QzS4/pdg3kT1szMZjZ5ovpDJ0W0Jgup9bc7UJHPahIdtHGg+jnGs5zcgx2Z2X6fBrIdVd9REEzmFMGXGEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0EXEXk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D850C4CEEF;
	Thu, 10 Jul 2025 02:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752114591;
	bh=xXT4x4JaFjSeep/Mbd917xNGkwFl5LwRQcGW2dS7HC8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q0EXEXk/OPCEnCIfL1at2SfcbHc/XVDpGRJmLK9giQP6n+JX3ktQr8QELcBEnCGNK
	 TwN/gcI31nVAcH1HecE8626G4LBn4EoEBg0PXWzrrEnUDqsftFiLxv+eVuquveUvKp
	 VeEer/1AfJtBIjSdTuIZsic65zrcpq3jEx++h9hGNmLFjqni+6BJAoVN5ybCyw34q5
	 /LkApYW/XJKmeuGp3ZieyBs/Hk+Arp/tUReN3uCkK+67AMvZo8xDIpdf34I/klunjz
	 qHIe12ZxQ1G8eOp5AYFTCGUaSVep+QefC9X7mKmymhkXYSKnLUzMkZJNqAtbrlutKw
	 qBuzl+6yx58IA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB44B383B261;
	Thu, 10 Jul 2025 02:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: thunderx: avoid direct MTU assignment after
 WRITE_ONCE()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175211461350.963219.17128181938751055078.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 02:30:13 +0000
References: <20250706194327.1369390-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250706194327.1369390-1-alok.a.tiwari@oracle.com>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: sgoutham@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 darren.kenny@oracle.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  6 Jul 2025 12:43:21 -0700 you wrote:
> The current logic in nicvf_change_mtu() writes the new MTU to
> netdev->mtu using WRITE_ONCE() before verifying if the hardware
> update succeeds. However on hardware update failure, it attempts
> to revert to the original MTU using a direct assignment
> (netdev->mtu = orig_mtu)
> which violates the intended of WRITE_ONCE protection introduced in
> commit 1eb2cded45b3 ("net: annotate writes on dev->mtu from
> ndo_change_mtu()")
> 
> [...]

Here is the summary with links:
  - [net,v3] net: thunderx: avoid direct MTU assignment after WRITE_ONCE()
    https://git.kernel.org/netdev/net/c/849704b8b211

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



