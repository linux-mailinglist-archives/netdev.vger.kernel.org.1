Return-Path: <netdev+bounces-246340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E670CE96A7
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41256300DC96
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CC82E7F25;
	Tue, 30 Dec 2025 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po9DcAYw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D745D2E6CDB;
	Tue, 30 Dec 2025 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767090806; cv=none; b=kSeSGKtlE4T3tzdUS+dhxmawVYcdVvjH1jwliPOV0V4VAzLU6h2NZ2WUxOQ0w0lAGEDPw+GNUTVTza8hrCXW8RJ17bkv+wPz31gQBtIRZkw3bMWFYlEj1B47Xno+3PiNECgfA138Zk1s4RepGyTQCu7KE/Gw0NshUqnqq7hkbJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767090806; c=relaxed/simple;
	bh=NjopScScNjiTaDj0Pt/NIrfapPm/FVFgEDlh1wyz6rE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VCMHz8Y3KYO358+6kgIRC+On178nKwpTuuIuXwm8JOUnZPoT6UX8PnW6Kue3N/tfFZUz5WlQrlMqJsRNQsv9hj9k721tJRInskEsook6Q6UZecMOv38I4FjW4ZapZLPb30pxUGQ9CmEoYBPoWVE9CrDN4oc/MpXM8WzJAXpkRsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po9DcAYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB30C4CEFB;
	Tue, 30 Dec 2025 10:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767090805;
	bh=NjopScScNjiTaDj0Pt/NIrfapPm/FVFgEDlh1wyz6rE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Po9DcAYwY5tIE4dEQ86vPWJZaTUjXFQR1kHTj2umcizKxLAAH1ps5b3JH3h6/UiLf
	 6AEczmi3teGvrkym2s8rhCqVGEyZXNpHCenWNaBpObeFSE8LnPNp8FIgO4NpDys/2x
	 hgVnFGM+IBTvcts62LHn79uM4Mi6jvthKt3dSkqeNXFsXvLkWA7PUqYAN8gEJ1aVNk
	 IK6gQpdZsvzr5jlwwC1NCM3l6Y4ouyGQjbEzkjhLjIIv+IC103pfqjhk+MPQPOogqL
	 oLyELfnV57TqFukcx9F7Y+Z9mJRXu9DTsdqF/Zyo+uXt0S7ZMIrXu93hwYbsPMi/lF
	 AXcYTXzKEIRZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B59753808205;
	Tue, 30 Dec 2025 10:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: enetc: do not print error log if addr is 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176709060754.3205848.10930624411819154546.git-patchwork-notify@kernel.org>
Date: Tue, 30 Dec 2025 10:30:07 +0000
References: <20251222022628.4016403-1-wei.fang@nxp.com>
In-Reply-To: <20251222022628.4016403-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 22 Dec 2025 10:26:28 +0800 you wrote:
> A value of 0 for addr indicates that the IEB_LBCR register does not
> need to be configured, as its default value is 0. However, the driver
> will print an error log if addr is 0, so this issue needs to be fixed.
> 
> Fixes: 50bfd9c06f0f ("net: enetc: set external PHY address in IERB for i.MX94 ENETC")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> 
> [...]

Here is the summary with links:
  - [v2,net] net: enetc: do not print error log if addr is 0
    https://git.kernel.org/netdev/net/c/5939b6dbcda8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



