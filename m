Return-Path: <netdev+bounces-199549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D910CAE0AB9
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656C13B508E
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C4628B7E1;
	Thu, 19 Jun 2025 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkDfUWMk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A71B2367D0;
	Thu, 19 Jun 2025 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347594; cv=none; b=Yw/dLbkTQyPGtsyTLNc9TEEbqrpFoV0CIgJSN7H3ow6nzalrOJ9VebY9ttDr+Xq3HzCasC9Nkc3SgjfSLddKw3MYrFc6Ucl55H4M21Im3BgSQ+Z5FrJO3LSltBAh5SHiv/3ZIgNPJuPMgwdTBzvAy4jBMoBRst42BlyEUuytcdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347594; c=relaxed/simple;
	bh=Gv1esIMNo0uDDw6MYLx1fsJEtQ3q6PwnhdWcl2wQ8Xo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uTLsQGXlnRNfv/Ufszr34lX5dyViykh9ijVjLvdiDzwMe3z5CtKCXOkAWRBJjVG3LVuYugWRfVErFTEiIkiZvIvoxfCgsTmhDpATl7KxKxUbs98UJRCi547urLN20aRDmPIGuI233Nqg13AYicjIV7BAHDT/AfgJJ0f/r1APfxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkDfUWMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C3AC4CEEA;
	Thu, 19 Jun 2025 15:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750347593;
	bh=Gv1esIMNo0uDDw6MYLx1fsJEtQ3q6PwnhdWcl2wQ8Xo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nkDfUWMkK4HeHD8GkipwuTIEWMQxuAocysL8iccJXa2i0x2ZFuQ+pWHhOi2eW66uz
	 /K/nXg2lbTX68D3FzvV/tUyU10EMxbWLN1tx/K94Z6ov1IKu4Xz+JtOuJhMyqZiSgH
	 UR/Od4tVIZ0kXYxCpH9V/EliQBIlmEFXhXP9mITtEbdfHpgnENT6OtqLKePf9FEopb
	 xVV6q+9O1uTwRsSmTLppUbT94TlxXBhvOy5uZts0DvlGboCeh+EfkF+NdL47rrgDvf
	 fSuP1HVUKn3H55bUhh+zfrtTQ/sXpgrJd+80DFMoXvmXI4qoBeAruFtfrzbI+hUCgR
	 cyz0eTeq0eafg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E7438111DD;
	Thu, 19 Jun 2025 15:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] mlxbf_gige: return EPROBE_DEFER if PHY IRQ is not
 available
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175034762174.906129.17201575441243019574.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 15:40:21 +0000
References: <20250618135902.346-1-davthompson@nvidia.com>
In-Reply-To: <20250618135902.346-1-davthompson@nvidia.com>
To: David Thompson <davthompson@nvidia.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, asmaa@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Jun 2025 13:59:02 +0000 you wrote:
> The message "Error getting PHY irq. Use polling instead"
> is emitted when the mlxbf_gige driver is loaded by the
> kernel before the associated gpio-mlxbf driver, and thus
> the call to get the PHY IRQ fails since it is not yet
> available. The driver probe() must return -EPROBE_DEFER
> if acpi_dev_gpio_irq_get_by() returns the same.
> 
> [...]

Here is the summary with links:
  - [net,v2] mlxbf_gige: return EPROBE_DEFER if PHY IRQ is not available
    https://git.kernel.org/netdev/net/c/e7ea5f5b1858

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



