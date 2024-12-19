Return-Path: <netdev+bounces-153193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0ED9F7250
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CDF16B8EA
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 01:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8C11993B7;
	Thu, 19 Dec 2024 01:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3YBCLt/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE1E3D3B8;
	Thu, 19 Dec 2024 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734573015; cv=none; b=I9gk5iS3ZpkXUUWVDhPxyqE0iz+F+hODxixDwSHtyo69bGUyiSuuMOjJcsROHzKdrOV2SUFAkBnggklVJr7Rfa0j8QKzBCQhrVHXAwNMeNzBh5drLtpIl6p2Ejss7NPi6FDVoTE5Zj6T88cWQ7cgCV00M91rKhno0xnKpqgycCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734573015; c=relaxed/simple;
	bh=g43r67CLbzbyphpm0uCVndf140riwvVqeOZJt3xJap4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=isum21pLESs0C2eC7kUcCJ46ZROgQWUda/IxmdFRur4foBSKbQ4Tmq8y3JV1N89NXRL3iP0etm6/nqrz0oG/UF7LXSSOH2oiOYiTtRfCL4Zomm8n10qoE1OIYxeJ0V2OYH6K9t0LvJE4tRt4gHFOqNQEYv0dhSOkkRNQeWKao8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3YBCLt/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E69C4CED4;
	Thu, 19 Dec 2024 01:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734573014;
	bh=g43r67CLbzbyphpm0uCVndf140riwvVqeOZJt3xJap4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k3YBCLt/K748usilZgZJb0nd/yDNgci6tVVuzJO1d0twLko3/48EdlKQtWYQdYIfe
	 mDgb3hYz6ry/dGT+9TmOXZKHuY2p4O56sSvRsVBp5XnSUn0fIvJD8UG8ycYq1vBHWF
	 UhOrzdEsUnxSPtuFuCgOsUAkCqIj+MzjnZDx9o3pB3fj4Qhr4PIVJb3twQNbuL3aPQ
	 tkBb1NvtDz6lp2FBkXxiKifMFF9EloB2flcHRABeW4EKfd2qvFJHpYOd0bBzilEb2V
	 xW1jUwRumKiyNKHzNTqRShRgbPOQiAPI0yX5QM26jBGVhx+IlOMn82ZS/W6dIj8b9m
	 5oemtZ/MKSbGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C083805DB1;
	Thu, 19 Dec 2024 01:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: avoid undefined behavior in *_led_polarity_set()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173457303199.1788421.4938838581958535465.git-patchwork-notify@kernel.org>
Date: Thu, 19 Dec 2024 01:50:31 +0000
References: <20241217081056.238792-1-arnd@kernel.org>
In-Reply-To: <20241217081056.238792-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, lxu@maxlinear.com,
 daniel@makrotopia.org, jpoimboe@kernel.org, peterz@infradead.org,
 arnd@arndb.de, Raju.Lakkaraju@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Dec 2024 09:10:34 +0100 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc runs into undefined behavior at the end of the three led_polarity_set()
> callback functions if it were called with a zero 'modes' argument and it
> just ends the function there without returning from it.
> 
> This gets flagged by 'objtool' as a function that continues on
> to the next one:
> 
> [...]

Here is the summary with links:
  - net: phy: avoid undefined behavior in *_led_polarity_set()
    https://git.kernel.org/netdev/net/c/cff865c70071

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



