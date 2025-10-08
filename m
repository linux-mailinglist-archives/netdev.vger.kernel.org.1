Return-Path: <netdev+bounces-228160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F134BC31F3
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 03:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C304334E14D
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 01:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3851829AAF8;
	Wed,  8 Oct 2025 01:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hebHTTnu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100E229AAE3;
	Wed,  8 Oct 2025 01:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759888221; cv=none; b=gR4oTgfXinzzhLWpriMozKEa08hK4mTHjYB4ElGZoCN0xFyQq5XDYZPB8Q4/mWRjOs01oTpH4JKXWIUtgVXwWyRztsJXx0Ji5wCO2Asveas0Jcgzqf5Blvm8AmZOH9Y9cs5/4335WhBqVKKW8JZ6csl3xGAVossi+zOrJtM8nT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759888221; c=relaxed/simple;
	bh=QZXy8dlct/WPHLAKNbbYXegvOdtTHdI+EiGzBdA6RHA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UrFLVKpD0bMXZ/w2n7Rb3tB2rKHkOOQaO9p5Xs6CAsvWGehKIMtmb0QQ0SMBWFDdIL5DtGD6VkCrCkzwrh/RWCRMm0TxNc5nE+rirTA+JeGS6ctBUybJJ8m4J7YSQyZvih8P6PgtaNH0YGhzREsQXQHNhlKS4DT2ivLufmAvb8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hebHTTnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A334C4CEF1;
	Wed,  8 Oct 2025 01:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759888220;
	bh=QZXy8dlct/WPHLAKNbbYXegvOdtTHdI+EiGzBdA6RHA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hebHTTnu0hHXlN+d/F1AP0PGHDHHpM21JY3sleJ1CqYkb/kdMEEpxIsSb8B3KCTqU
	 abaBlRGEpKJroZITG2t+OFGK/SZRb8TK2ExMv1J/Ic2Acbs85Te3J0WWSitsz3LQzm
	 qB7j5R3IvnoZ3hVpZvPvjJro+duuObF54LDOzLw2C9OSpH87/cS8dkjKi92SDAkQto
	 Wf7RXwPfipMPqbCMnz46sxKuxxAHRuoEOulqOS+Pm5pMWqjFVjLWLh8TlvKmGp+uA7
	 qfxbEa82uIRJRWt7vszFxCBwYiRbrFfMHROiBDhDrnvu+tOMDSnCnxDsZr9mR8LNKs
	 Vi6EHKE5qrSYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC5839FEB7E;
	Wed,  8 Oct 2025 01:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: pse-pd: tps23881: Fix current measurement
 scaling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175988820916.2858427.9845864213512629527.git-patchwork-notify@kernel.org>
Date: Wed, 08 Oct 2025 01:50:09 +0000
References: <20251006204029.7169-2-thomas@wismer.xyz>
In-Reply-To: <20251006204029.7169-2-thomas@wismer.xyz>
To: Thomas Wismer <thomas@wismer.xyz>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 thomas.wismer@scs.ch, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 Oct 2025 22:40:29 +0200 you wrote:
> From: Thomas Wismer <thomas.wismer@scs.ch>
> 
> The TPS23881 improves on the TPS23880 with current sense resistors reduced
> from 255 mOhm to 200 mOhm. This has a direct impact on the scaling of the
> current measurement. However, the latest TPS23881 data sheet from May 2023
> still shows the scaling of the TPS23880 model.
> 
> [...]

Here is the summary with links:
  - [net] net: pse-pd: tps23881: Fix current measurement scaling
    https://git.kernel.org/netdev/net/c/2c95a756e0cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



