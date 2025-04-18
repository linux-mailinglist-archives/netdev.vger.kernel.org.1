Return-Path: <netdev+bounces-184039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF19A92FC8
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82DF1B62D64
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80626267B0A;
	Fri, 18 Apr 2025 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECLslSKR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE3B267B00;
	Fri, 18 Apr 2025 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942206; cv=none; b=shqqQrGa5veyc4FkTZT6x0gxDT7s9/JRhh2z4QACl9KkY0b80odfuW3BKdayxREdlvTSf+pRSJfPatlMe8WwyNJwlSJE5eTZ+hPyvK5lQAL/TwiN5iTUducedpRHPRf7iAHI7P/2tb8Ck6tu5MK8YKt9rFhmXEeQcAVg7NKW2Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942206; c=relaxed/simple;
	bh=zJMWKlINLQxoHVInSJ+InJg9/4RqU8iLfjlB3jKpNuc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WYlBcpLXQoMJ7aqCj5kD4qWapcokhtTIjWZq2KqtedDuCAB6DHC/koRUDrxEyGUCuy0N6ALt+F8beO9lG+7HFsqRzRB9YdqliQfIAVzlUskgo8BgQmyVhTHSSXJoJuQjX+Y+6pE/1rNprM2xQeCA3gsWUWbL7kdRXb5Fq2K2I2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECLslSKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D71CC4CEEA;
	Fri, 18 Apr 2025 02:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744942205;
	bh=zJMWKlINLQxoHVInSJ+InJg9/4RqU8iLfjlB3jKpNuc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ECLslSKRbGv0zfdqrE34jhBmJW2hvJsVMMrFLPipIG+IylXOp/BlYig4TKQJNCyPn
	 KgIj4+ewoTMSGeQ3Sl50LL8S20V1IvJEWrpC2CjmiFlrSg4PIHpqHev6grPYcJopvk
	 2xM/g+w1Z2DTGNW79xxAs1EgpWlQVTzkbpUtcSD1sKQ6phKvaP36iES9UBHvzCfMv4
	 DtiR7bPrK/c8HkjwEqb4RGtAdvLzu/nDtjJrGw5V+CpcV4PdbGrZoIeLX3LCayzed8
	 OIGAvDETN5Z3+4xhC1fsGD+fsPfAI9gUbg59eDlFDQxKpoRoZLuDg/deTVLUBBwDNt
	 zM3IovL4KRx0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC8C380AAEB;
	Fri, 18 Apr 2025 02:10:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethtool: Adjust exactly ETH_GSTRING_LEN-long stats to
 use memcpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174494224374.79616.15601499519996041916.git-patchwork-notify@kernel.org>
Date: Fri, 18 Apr 2025 02:10:43 +0000
References: <20250416010210.work.904-kees@kernel.org>
In-Reply-To: <20250416010210.work.904-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
 jeroendb@google.com, hramamurthy@google.com, idosch@nvidia.com,
 petrm@nvidia.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 horms@kernel.org, geoff@infradead.org, wsa+renesas@sang-engineering.com,
 aleksander.lobakin@intel.com, pkaligineedi@google.com, willemb@google.com,
 joshwash@google.com, 0x1207@gmail.com, rmk+kernel@armlinux.org.uk,
 jszhang@kernel.org, petr@tesarici.cz, netdev@vger.kernel.org,
 imx@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, richardcochran@gmail.com,
 jacob.e.keller@intel.com, shannon.nelson@amd.com, ziweixiao@google.com,
 shailend@google.com, yong.liang.choong@linux.intel.com, ahalaney@redhat.com,
 kory.maincent@bootlin.com, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Apr 2025 18:02:15 -0700 you wrote:
> Many drivers populate the stats buffer using C-String based APIs (e.g.
> ethtool_sprintf() and ethtool_puts()), usually when building up the
> list of stats individually (i.e. with a for() loop). This, however,
> requires that the source strings be populated in such a way as to have
> a terminating NUL byte in the source.
> 
> Other drivers populate the stats buffer directly using one big memcpy()
> of an entire array of strings. No NUL termination is needed here, as the
> bytes are being directly passed through. Yet others will build up the
> stats buffer individually, but also use memcpy(). This, too, does not
> need NUL termination of the source strings.
> 
> [...]

Here is the summary with links:
  - net: ethtool: Adjust exactly ETH_GSTRING_LEN-long stats to use memcpy
    https://git.kernel.org/netdev/net-next/c/151e13ece86d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



