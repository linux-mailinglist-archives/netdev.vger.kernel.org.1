Return-Path: <netdev+bounces-230235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C148DBE5A96
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 00:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 477CA4E6DA5
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AFB2D3725;
	Thu, 16 Oct 2025 22:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkfRktec"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356B6242D95;
	Thu, 16 Oct 2025 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760653222; cv=none; b=G/RJxTDQzkKrPZjhK4iad+oHy9IAd23J8ohnLaFJ6NpXmh6t2Ka6VJ8sTEW0+pcLdFHdXXBhtxqy7wMmdIGYkfnzyC/dNuLA0tIJVFoQtFqcvCvggYZ1/9A/OR8C3TEMmXYdwM2VRbtljmlmGRkm/N+8BwKo9gSOL+ablVCsc9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760653222; c=relaxed/simple;
	bh=s5fu+uXQ5u4l/JEK8DPW0QEVlCFSvZTtTu+d2PH75Y8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KOVtaoMdgEQ3/sSrk8RBBXo74pdtSXPMxkxunmtha1Ph5HICxp2CCala62ehGpg/Rt6OwaIqt5glhlanQ6uUeoSsl2j+zmyO9QAeLyX+J9KFi998c58rBCihRhOISaSQ31ng4Xl+TwW4yJqE/2GRzsv4A9iew7O77YJIAGWHcWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkfRktec; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3458C4CEF1;
	Thu, 16 Oct 2025 22:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760653221;
	bh=s5fu+uXQ5u4l/JEK8DPW0QEVlCFSvZTtTu+d2PH75Y8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XkfRktecNgkxb4dXMFpJAqAefTdY3oJ22/0buu0x2yKqn7zrbC+9wtLPTkZCNelhh
	 55N2RoqHuXbOsf5IBGVczRbwlbhgz9TSXdWizFzcqvNlfRBhkiqeMQQgeG+06VrLNB
	 SS1/sDijQw7LKBTX67RJZNCGIiGVUIdo61clMGpXOl6S65reNKXQ52F7IU+iELngV9
	 LMTHejVgKKr6/UNyBuXQJC9kmQuUpFfQeumOgEPKNGNVwAuZVKvS9iY0yD12CTKFXf
	 IvrfCzg/5JMHJiLeCzgTQZAtsLuF6gCm1Mjjny5pVRvqNmjp08h1mhqCi+Y8I5efrJ
	 apcslkQ9ZYmVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE0139D0C23;
	Thu, 16 Oct 2025 22:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: usb: rtl8150: Fix frame padding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176065320577.1926380.4043534150079861289.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 22:20:05 +0000
References: <20251014203528.3f9783c4.michal.pecio@gmail.com>
In-Reply-To: <20251014203528.3f9783c4.michal.pecio@gmail.com>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: petkan@nucleusys.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Oct 2025 20:35:28 +0200 you wrote:
> TX frames aren't padded and unknown memory is sent into the ether.
> 
> Theoretically, it isn't even guaranteed that the extra memory exists
> and can be sent out, which could cause further problems. In practice,
> I found that plenty of tailroom exists in the skb itself (in my test
> with ping at least) and skb_padto() easily succeeds, so use it here.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: usb: rtl8150: Fix frame padding
    https://git.kernel.org/netdev/net/c/75cea9860aa6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



