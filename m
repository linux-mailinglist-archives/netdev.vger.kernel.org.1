Return-Path: <netdev+bounces-144306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48429C6851
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30424B26A77
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 05:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03799175D45;
	Wed, 13 Nov 2024 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+zBV3B0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4921175D39
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 05:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731474026; cv=none; b=PKM6TI0mo94hn9ZiJkRRnyogTNjGMQCbf8Pks4p5E7wyWZU9vVZqBt/Wj60aIyn4hrJacyv6okPjgLVkmBeX1ZEnq06h28SNsa3upVoy2CfpE5TJ67ZcHDzXPNso5s8T23J3RcswEHCuhZ+B3kzbS1vxteU6SY4GRnlK1F5F504=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731474026; c=relaxed/simple;
	bh=ASWObKzC1Nx3cn3QPT9eHJiyd6xFB3gr4sXPv3rLMmc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B99KWMjMvUuZcBOf06oYy11sdytDgg0ljNi7A864mWr0e3AqW/U7TobWw8qd1qDr3d8dZTm7/oSRfL+TzrkiQHYltSyteR7fZ/fS4aqilxSbiV5kC1wIs6u/1e3N0m7uQZmxXUy5uvFd9+kHQGgkQ9UpJlqUQ7Xq59gBGZHCjp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+zBV3B0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679C5C4CECD;
	Wed, 13 Nov 2024 05:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731474026;
	bh=ASWObKzC1Nx3cn3QPT9eHJiyd6xFB3gr4sXPv3rLMmc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p+zBV3B0IKxO/P5MHzZGuN/TRz+wjxDwaXesaHeRSRGegWjaMg8r+yUu6H1/pzaV3
	 6kbx0Xi7byoZ5x2e9TY2FHot2ZYenJ8V8OzMK54873CTOmcrU+mMYnLcB9DZPQqSUY
	 HpdEaKGpp0S41odNx9CnqeCpqN3bLbW4xFk6rZWIH5cYo0HRReyWEjhABEUkM6OlXQ
	 EZty6zKv24YNm6jRRTB84GhR3AgTJ1ZFEp7uwDtPzN0LryRyTilNwSCotJ5Dozgya+
	 pu3y/p5XXFmfdc1M3noI6sBRnswtcjND9bhcT5Tc16dNU/ZR7Y3AVjVwfcrrli86YR
	 LrXzCg1VPAo0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC943809A80;
	Wed, 13 Nov 2024 05:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: bnxt: use page pool for head frags
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173147403650.787328.13748437765054715783.git-patchwork-notify@kernel.org>
Date: Wed, 13 Nov 2024 05:00:36 +0000
References: <20241109035119.3391864-1-kuba@kernel.org>
In-Reply-To: <20241109035119.3391864-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, michael.chan@broadcom.com, ap420073@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Nov 2024 19:51:19 -0800 you wrote:
> Testing small size RPCs (300B-400B) on a large AMD system suggests
> that page pool recycling is very useful even for just the head frags.
> With this patch (and copy break disabled) I see a 30% performance
> improvement (82Gbps -> 106Gbps).
> 
> Convert bnxt from normal page frags to page pool frags for head buffers.
> 
> [...]

Here is the summary with links:
  - [net-next] eth: bnxt: use page pool for head frags
    https://git.kernel.org/netdev/net-next/c/7ed816be35ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



