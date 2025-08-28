Return-Path: <netdev+bounces-217658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB501B3973B
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032E81C25CA3
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 08:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A9D2EBDE3;
	Thu, 28 Aug 2025 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EO1UwsTi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D22F2E1F0B;
	Thu, 28 Aug 2025 08:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370399; cv=none; b=jey0FiM+bNwMFwKOXHQIRGENW5lJc/ncBU7u46lUvniN0BLEKPM+dvF6R/DOye9JUPVy3RkQzL5KYacl5R7efisV0t2UqQZMYxj4GxjNFPn3L7loSlCvVrcwuqvIiJC/ySB8Gh7GTvjdkwoTmViEaOy4jRleMus9YaozcSbkd+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370399; c=relaxed/simple;
	bh=t8u2AeLj+nVRCv+SE0yp9+jho+NkSP9HP03oSFsz230=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=He9LQ+PvzQh71hI97O1x+fmtw0ubI6MK6Bjc1Yycg26aOWnVPn4cnnr5Y2BXfrUOsmFGVGbEJXlK67uewGI/wEr14jNjhi6z/6qTbr7OD0SoKY4lSr6Hl17+dudFFC17d6LeCl/ESHkCRHCUjWWSgMAPXXUHslshndea0VY0g8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EO1UwsTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE43C4CEF4;
	Thu, 28 Aug 2025 08:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756370399;
	bh=t8u2AeLj+nVRCv+SE0yp9+jho+NkSP9HP03oSFsz230=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EO1UwsTi5jtUM+kAG+R2Trr00+yxUR2jrYoFHdH/ltO2MPMsz8JZGbSglwzRNPHWx
	 qbPnQJWkeVQAsBMMKyFTfz8eBRwp0zK5VXRfXEuy8ZNXXElQXH4dzBMlev1XK5//x5
	 iZAXa0gcwLtXe12nqJUZk+S0QknlagIOhMU9fmt1t4GSHYle5VaKThewJTZLgwHPSE
	 je5NEai+uwx8aSC5aFrJHS58LVHIjl9Mm5CNxfEEx4Fj7IW0qhObL/de24d3otZ7vN
	 /JtUjF0sE99PC7dEtcuc+OJQ1QNYimRolTdPZA4myUeyZj+P0rfp4TF8T5Lid8H2je
	 gBaQTqq/yaK7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D48383BF70;
	Thu, 28 Aug 2025 08:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: macb: Disable clocks once
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175637040625.1362868.4424023735390845788.git-patchwork-notify@kernel.org>
Date: Thu, 28 Aug 2025 08:40:06 +0000
References: <20250826143022.935521-1-sean.anderson@linux.dev>
In-Reply-To: <20250826143022.935521-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 shubhrajyoti.datta@xilinx.com, neil.mandir@seco.com,
 linux-kernel@vger.kernel.org, harini.katakam@xilinx.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 26 Aug 2025 10:30:22 -0400 you wrote:
> From: Neil Mandir <neil.mandir@seco.com>
> 
> When the driver is removed the clocks are disabled twice: once in
> macb_remove and a second time by runtime pm. Disable wakeup in remove so
> all the clocks are disabled and skip the second call to macb_clks_disable.
> Always suspend the device as we always set it active in probe.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: macb: Disable clocks once
    https://git.kernel.org/netdev/net/c/dac978e51cce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



