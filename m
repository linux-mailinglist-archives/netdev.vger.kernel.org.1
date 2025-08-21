Return-Path: <netdev+bounces-215678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5F5B2FD97
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 17:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 584FA7AB0F3
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15C12FB61B;
	Thu, 21 Aug 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERP61Fag"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998B62FB60F;
	Thu, 21 Aug 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788406; cv=none; b=Y5khZ4uATHgN6Omma6rS3nN/WZdrdMkvDD9UHkrhNfOxna8GhkOjDgvrkt6gvVyrkNRhEvzDPXWclo2TNk1itgwkC6FsxymXCPaQOSt5pVqyNPxBNNKrHz2FqKEayZrSKKO5p0myOSxxuOscvOh11dUgBhZ5+FisyWf7OHY8y7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788406; c=relaxed/simple;
	bh=SRdzXGPCQTxMn6thdVtSbClJhpRHSXOF84U3YcXYtk8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gg+gQjS5v/Jo7NlrTha5Byz3NTi9/Zz5WM+PatTT7Am79mM6yoMOVHchG3hw3+sWDxs52fmBLqw48OjWNTR/tBepd/fZQcV02AJf8j3tIr35sv/fGfqQOWfaZmxkiWyuJXE7ir48G33iT+6606ADPnM5tyVAjrpoCC4d1jRwa7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERP61Fag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28051C2BC87;
	Thu, 21 Aug 2025 15:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755788406;
	bh=SRdzXGPCQTxMn6thdVtSbClJhpRHSXOF84U3YcXYtk8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ERP61FagQX3FcpIiIIl+NEYlB0CqJeWkrg4chQJKb7H5/No4mwAzEpkf9Lb30THAU
	 7A/c9/u/xT3UBIs45kkfYV2blbtKurJA9JCeLcT3YKFsQ9ghu+g7ZmlL1Sjl+vwpAU
	 VpvksL/qwbnwj6BF+uS6rO96hnhsGSIun3+SB4TMj9JZ/YYnwq4YQ5oa1+Lue74AQf
	 D6EB6N1jTKFbBctmCbtvKuc/2U8Faxp8h+HpPSUgL1LlcnqqEwLOBY2wW1L07SGdix
	 SMazeVV3oP7LmHgBahYvipO6vzj6amazwrtiyWWRztcDluLWS4B/fRTxm5mUq1xnLe
	 FN0DasqoVdIcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CE1383BF5C;
	Thu, 21 Aug 2025 15:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: pse-pd: pd692x0: Fix power budget leak in
 manager
 setup error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175578841499.1075387.3252832210144588018.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 15:00:14 +0000
References: <20250820132708.837255-1-kory.maincent@bootlin.com>
In-Reply-To: <20250820132708.837255-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: kuba@kernel.org, o.rempel@pengutronix.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 Aug 2025 15:27:07 +0200 you wrote:
> Fix a resource leak where manager power budgets were freed on both
> success and error paths during manager setup. Power budgets should
> only be freed on error paths after regulator registration or during
> driver removal.
> 
> Refactor cleanup logic by extracting OF node cleanup and power budget
> freeing into separate helper functions for better maintainability.
> 
> [...]

Here is the summary with links:
  - [net] net: pse-pd: pd692x0: Fix power budget leak in manager setup error path
    https://git.kernel.org/netdev/net/c/1c67f9c54cdc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



