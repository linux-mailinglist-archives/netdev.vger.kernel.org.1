Return-Path: <netdev+bounces-144304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 570519C684F
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C0F1F23D21
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 05:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4293E433CE;
	Wed, 13 Nov 2024 05:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDu3PvPN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D01B33DB
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 05:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731474024; cv=none; b=jUs75lfT595Aif9/71JUSwzMRMSPaRIAVHs9Gl0wKmpVrJVH94Ulk+1Jtyiymn77FZ4t3fI2w1HhATOYLvzi1sDVgNRfFVIT3xNp08Radauwtd3CnXLncX4lr/dJm0fIt5RIPU4qxRhc9LmWmbqB5SNVIrPrLf+6iiJWxurzo9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731474024; c=relaxed/simple;
	bh=R5CJhgTZuNJRvc010IxiGynLbPvFxscPM9CZwPh/p/M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bUg0EeG2/BkHB182waBOuLLtWmaof7tQJifYyTEp2EFjjKuxue7NOsGdDTIu34Blg3fBzrCFJOLtO5o4pSMuUWd8nLjzpAB2yAJBlt2dxDNruzz4iWKBChLTx7WF6AckChQJsgHEES8voNatERddE+kwPZlU5vr/H+g19I+kduM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDu3PvPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8744C4CECD;
	Wed, 13 Nov 2024 05:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731474023;
	bh=R5CJhgTZuNJRvc010IxiGynLbPvFxscPM9CZwPh/p/M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pDu3PvPNXRvYkGjekm+Xq6n3hG0P2cphgq67zJlfYchD8Yuv2iHtzFZnOVacVvzu8
	 9jMDmeJw3D9P3DCRhve+mblEvle8w51P3KQzBbkbtl1RYBtVFtyQMKyx+YysJd0BqP
	 QHK6yaDnUAl/gGCY80vLZoxpeZdMHlFe/h9ZSR5sG479MP+zZh4Ih0bABal0o//ycF
	 5DjOSb+AD75bbDYixnTYH/kMz8BBShe2sillW9y/fYa7My+C66bMARZNUgb85pA9V3
	 XZ1lEmFqaZF63Li87FxOzRNmPQl18RkFfb9HLkx1l0BD7g/AceTluLcLr/KRvDEWqG
	 HsODudC5QoT6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340213809A80;
	Wed, 13 Nov 2024 05:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] dsa: qca8k: Use nested lock to avoid splat
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173147403374.787328.15079173493934720967.git-patchwork-notify@kernel.org>
Date: Wed, 13 Nov 2024 05:00:33 +0000
References: <20241110175955.3053664-1-andrew@lunn.ch>
In-Reply-To: <20241110175955.3053664-1-andrew@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, netdev@vger.kernel.org, ansuelsmth@gmail.com,
 vladimir.oltean@nxp.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 10 Nov 2024 18:59:55 +0100 you wrote:
> qca8k_phy_eth_command() is used to probe the child MDIO bus while the
> parent MDIO is locked. This causes lockdep splat, reporting a possible
> deadlock. It is not an actually deadlock, because different locks are
> used. By making use of mutex_lock_nested() we can avoid this false
> positive.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> [...]

Here is the summary with links:
  - [net-next,v1] dsa: qca8k: Use nested lock to avoid splat
    https://git.kernel.org/netdev/net-next/c/078e0d596f7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



