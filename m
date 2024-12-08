Return-Path: <netdev+bounces-149947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541E29E830A
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 02:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A72165CFC
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 01:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0D9EEBD;
	Sun,  8 Dec 2024 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuPsRohz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED82C8F0;
	Sun,  8 Dec 2024 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733622614; cv=none; b=GAssPFOHLFfjnyuoCBm9855+ahPkKIs5zjqAMFiuN2rCaS76A2vDSBuXr6VDref3M61dfy0UlOMKZ7KDykm2tHQs+TJoDja8J1fp9EI223VPm0XwyNN5+N94ik1GoKwiB3DGKaF4LIbq7CRxhYLG6/Mxf8ziZ+3Cbbe125xWq50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733622614; c=relaxed/simple;
	bh=ONydhHmHYwk0vrQTNKWQj6U9mb6dVZo/RS4CFwzvlDY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OaYs7LYJ6/PaIr4HIIBKwNu597anJvcqO5RGfORT8EV+fcsBGBu2Y7OGZnG782WjHy3G/vjuYlpVe3tmtiIdOXDmboM2pOYJ6LslF2aplJWQUPC2XJmkk3n4vXxnoxLXiSK0fDQ8OJlgXEULKwTfKUizgFQkN94iHn6oRpGVkFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuPsRohz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04164C4CECD;
	Sun,  8 Dec 2024 01:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733622614;
	bh=ONydhHmHYwk0vrQTNKWQj6U9mb6dVZo/RS4CFwzvlDY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cuPsRohzEIoX+Qw18pim665pm7hBgwyGmLjRZPVkhJA9uQTg91gL1y77gd8Ob9DvA
	 PkB/Sf/2pNzuffNbMpWsxE7aygW7NOcQyzSlg2g8We/2ycRQ0LHvBtt/YZlsyMRbvD
	 IobX9jlhPcxJYSe9q/iMnDYMV5FETdAMmjplFvZ69SZG3qNS83ovF95KYfc4y9uD9G
	 Pp0SEtcvCr63DqcqGnChBzy0+MBZtdUabyyRaDtdPg5iuHQGPq3RAyI/kcPIhBBaEQ
	 TUeuJkJ2YrX2G1i62ZU+ZUSSI5x7tSjX9/eo3MYjoDAuDpZivS/fx6tiokkm9JClhS
	 ZUwvEAp9JV5Lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 712EE380A95D;
	Sun,  8 Dec 2024 01:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tun: fix group permission check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173362262925.3130221.16243033138491486291.git-patchwork-notify@kernel.org>
Date: Sun, 08 Dec 2024 01:50:29 +0000
References: <20241205073614.294773-1-stsp2@yandex.ru>
In-Reply-To: <20241205073614.294773-1-stsp2@yandex.ru>
To: Stas Sergeev <stsp2@yandex.ru>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Dec 2024 10:36:14 +0300 you wrote:
> Currently tun checks the group permission even if the user have matched.
> Besides going against the usual permission semantic, this has a
> very interesting implication: if the tun group is not among the
> supplementary groups of the tun user, then effectively no one can
> access the tun device. CAP_SYS_ADMIN still can, but its the same as
> not setting the tun ownership.
> 
> [...]

Here is the summary with links:
  - [net-next] tun: fix group permission check
    https://git.kernel.org/netdev/net-next/c/3ca459eaba1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



