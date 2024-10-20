Return-Path: <netdev+bounces-137281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001699A549E
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FC5CB21FF5
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 14:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEF2194C6B;
	Sun, 20 Oct 2024 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPoG6UBF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F74D194C62;
	Sun, 20 Oct 2024 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729435835; cv=none; b=YIig/Tpt6e3FbcbVGEtEOMBdgv2fn+HINMV2OnyelPuVvBU62clKP4fgoyNcRBlBItIg2EfkQCXqTaY/tKfkUsBy4gRYb9bGLrvAHWQ3onju3YcXWLjYArJlXn9S9HF0/JNAjWbUwn4QVV7CMgrQiWIv7AYFacnaFb9tOEESxxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729435835; c=relaxed/simple;
	bh=OV58zMahopYdwo0F34FJLli1rHSXfWV7zzQzhFSAylc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=He8v3kIaZz75xaPP7U1jk7MTzA1lhVPr2kWGNixOhERKzVWpY9tO9dmooSTfVA3D5OfznnQ89XIj/3u6o7FsHZgpTBuT4a22wYHyaotqRyMdsQfkJ/SrHDfb0nf7DZJQfHEsW7+0HvvpC900608cyYsr5eHbQmWPWBLUVM+7qog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPoG6UBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966E5C4CEE9;
	Sun, 20 Oct 2024 14:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729435834;
	bh=OV58zMahopYdwo0F34FJLli1rHSXfWV7zzQzhFSAylc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VPoG6UBF72dAoG4wLJqIXTR+Pxgjdt+eqa3LaKZN7HMFizbnFjBmGME5wCTS0oSTm
	 E0j8UBeVCwuDvrxZac+cLvQI5kK/tqKWfdGA+XVXMNLIy4gLSNBCBJt0pPNwHpO+/3
	 75YyldgEw7jUzZMP0IVkK9D8o6HhTw0mqzPQVD642kQzWhYVceTUWie5QUL/Sh9gep
	 0mGA1qtNaJMTGcZY9Q94vj/kYGJu3I26yBPKBocArCmsBGbeJGnQunrcck+Z124Ghk
	 h9m3itH7u+WeVlbFwWPhyLy+gy8Nl9w5bK7rgvfsM2Gn1jKhcraiZffBTkrbcMCZSr
	 v0bg21KNZ6AaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCB33805CC0;
	Sun, 20 Oct 2024 14:50:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: pse-pd: Fix out of bound for loop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172943584049.3593495.1897023109009616224.git-patchwork-notify@kernel.org>
Date: Sun, 20 Oct 2024 14:50:40 +0000
References: <20241015130255.125508-1-kory.maincent@bootlin.com>
In-Reply-To: <20241015130255.125508-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: andrew@lunn.ch, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kyle.swenson@est.tech,
 thomas.petazzoni@bootlin.com, o.rempel@pengutronix.de, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Tue, 15 Oct 2024 15:02:54 +0200 you wrote:
> Adjust the loop limit to prevent out-of-bounds access when iterating over
> PI structures. The loop should not reach the index pcdev->nr_lines since
> we allocate exactly pcdev->nr_lines number of PI structures. This fix
> ensures proper bounds are maintained during iterations.
> 
> Fixes: 9be9567a7c59 ("net: pse-pd: Add support for PSE PIs")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [net] net: pse-pd: Fix out of bound for loop
    https://git.kernel.org/netdev/net/c/f2767a41959e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



