Return-Path: <netdev+bounces-211429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5ACB189CA
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 02:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB19AA65E6
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 00:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A93A4C8F;
	Sat,  2 Aug 2025 00:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVOaxC2V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57621FB3;
	Sat,  2 Aug 2025 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754093639; cv=none; b=by7q8XAW5l6l3JFsA6rNferlZjKIyRUH4S4kDpCQisBFlMDyLvlmvRsaP1NZE7N6T0Oh5CcJpQyBWvfaSyw0eUo/Lyw9/dCL80lWGx4qjEpGK0T30La56ke1fH2L2MCtZsfq/B7n0S5PUmIImVORXhWNnnhd+gcxKYYpt9hl3g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754093639; c=relaxed/simple;
	bh=+OPsfH+01e+g9QAEyPv+zTkPj6qetBDP9qRMpTKiuP4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cnvtWF0OQlIOijEWRCO+NbXnLao45MX14Ony3GsLQp/ps262takPW94W+Nu7F1/bkJG43u7v4F0SBMGdyuw5SM3IENHrGnbJr9kH3Ira9MfwAidYi9Uw4aweWXxAlFq6Hp00gVtKD4+tsdo/R1hjDyVCaecQs85Uh3z/9PRl0hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVOaxC2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3ADC4CEE7;
	Sat,  2 Aug 2025 00:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754093638;
	bh=+OPsfH+01e+g9QAEyPv+zTkPj6qetBDP9qRMpTKiuP4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aVOaxC2VKfPiDWVp6LoATipL+DLMXyQnBVXmlTF+u5qWIy+mRumjkSeZ9nzT1fqkl
	 SY0zOerz9LJeL/5oxSMR8A+RQdz7lOPYnsfqsw1MXHYsh9uBMcLJdVD8YuPrKVu1eM
	 75ZhQTYBPeX8o7fkUKjW1c9raxO7t1oyzX9R3+i6DWJ+Znsmx8sHtanuqiqnfR5BRM
	 kvpP2DxglRcO8jv/6JJJu5mnktM2dLRGqMHczKCqC2TGpGjTdWbqdKzRTxJ7Hc/mdl
	 TkectVDb+x1G2ygOB3hfkSp15hhaQVErCRvAf+KTTuyyau8JldRdkn+kQ3vrfuUid5
	 8Y664UaM3dlfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BA1383BF56;
	Sat,  2 Aug 2025 00:14:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: mdio: mdio-bcm-unimac: Correct rate fallback
 logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175409365375.4093813.8768013399045659560.git-patchwork-notify@kernel.org>
Date: Sat, 02 Aug 2025 00:14:13 +0000
References: <20250730202533.3463529-1-florian.fainelli@broadcom.com>
In-Reply-To: <20250730202533.3463529-1-florian.fainelli@broadcom.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, opendmb@gmail.com, f.fainelli@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jacob.e.keller@intel.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Jul 2025 13:25:33 -0700 you wrote:
> When the parent clock is a gated clock which has multiple parents, the
> clock provider (clk-scmi typically) might return a rate of 0 since there
> is not one of those particular parent clocks that should be chosen for
> returning a rate. Prior to ee975351cf0c ("net: mdio: mdio-bcm-unimac:
> Manage clock around I/O accesses"), we would not always be passing a
> clock reference depending upon how mdio-bcm-unimac was instantiated. In
> that case, we would take the fallback path where the rate is hard coded
> to 250MHz.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: mdio: mdio-bcm-unimac: Correct rate fallback logic
    https://git.kernel.org/netdev/net/c/a81649a4efd3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



