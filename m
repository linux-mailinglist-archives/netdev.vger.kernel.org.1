Return-Path: <netdev+bounces-220527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3A9B467AD
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 03:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4E83A82BE
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 01:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C3D19ADBA;
	Sat,  6 Sep 2025 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHl6u2AI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9EA18C008;
	Sat,  6 Sep 2025 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757120405; cv=none; b=PC12I4lLiH8wMnqboyKpnWHKHLnRAz7z+lDFPcaLQs75JGb9I/47NAEiHQIyqoC5INCSe/bCbze997WopRhx+YB2FReNibgy8XHAjwQ1MDWMq2Y+9CrbSB9wwGJHBwWAqWt6RTTcKXnx7WiNpGD2cuSGaihieW0qm8f9pkGC0kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757120405; c=relaxed/simple;
	bh=NRSbfI/9EKQbo1xdcbysVooeD8BSmynAtf0nPWPpjDQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=udar9aMvtJji8yQskz9vZv4Y7ABC55VA0ok42Hz21jLDrbYOQwiHoiEbrOwdHc9BvwSYPMhIHyMCErEIjEXAQWkqFe8ratneNr9mv2OWxUUXOqpSR4EJWnZhEwjAOcqMa1LxXxHK9B7fIZFqnXD/QhfxWYxNFHX/yB4Gexa2ygU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHl6u2AI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DB6C4CEF4;
	Sat,  6 Sep 2025 01:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757120405;
	bh=NRSbfI/9EKQbo1xdcbysVooeD8BSmynAtf0nPWPpjDQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LHl6u2AIWvzQoeky2Xe7fhPpF5xtxyytNxQUZaMOVxT0hepZLcqNArImOL2GVYwxJ
	 OXU+TSzPGl4J+DPOA442zXJtc2KZb/JhZqtMlS755F1A766SzZXYZ1yzAehdCSButI
	 UBXvCi6LbaRF+k5S1Rfn0XPvvJOu1aGztM1KdJRN5ePPdzXpCJv9/++JF5NDIViQHE
	 p1u7ySOo9qhGAZPBYrvJ8tRF6Hw2L2MrA08Rm1kgcbSIB1W0K8pyNW6XTsCWqaEB/i
	 +S7/sjmPAKzikmKHle0QUS+v7eHtcaJAbjC4145njoEDWp39C642JfgIg1m3XjwqBt
	 vL2wK1QO9A6SA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C2CD9383BF69;
	Sat,  6 Sep 2025 01:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fec: Fix possible NPD in
 fec_enet_phy_reset_after_clk_enable()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175712040949.2733722.8310220266633070351.git-patchwork-notify@kernel.org>
Date: Sat, 06 Sep 2025 01:00:09 +0000
References: <20250904091334.53965-1-wahrenst@gmx.net>
In-Reply-To: <20250904091334.53965-1-wahrenst@gmx.net>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, cniedermaier@dh-electronics.com,
 richard.leitner@skidata.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Sep 2025 11:13:34 +0200 you wrote:
> The function of_phy_find_device may return NULL, so we need to take
> care before dereferencing phy_dev.
> 
> Fixes: 64a632da538a ("net: fec: Fix phy_device lookup for phy_reset_after_clk_enable()")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: Richard Leitner <richard.leitner@skidata.com>
> 
> [...]

Here is the summary with links:
  - [net] net: fec: Fix possible NPD in fec_enet_phy_reset_after_clk_enable()
    https://git.kernel.org/netdev/net/c/03e79de4608b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



