Return-Path: <netdev+bounces-214173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF784B286A4
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 21:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43D35E5413
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BB626A088;
	Fri, 15 Aug 2025 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlrriN+4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECFB13FEE;
	Fri, 15 Aug 2025 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755287396; cv=none; b=SXH/gZMgf0U+HQlVo1vs2Ko/NZeaZaE3/7w1jZ55vkPkz43hTAQTSQoRUfMz+ph0PQKeZ/3IQ8nJvWVyOYvMFBMwCtfgqfa4u3ZBMpIj17sf6TuiCi2qQHS/sr7PUaWztra8IkdnKj71rX+vNBOIOJSuDFkhViL/G9qRoxKiqec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755287396; c=relaxed/simple;
	bh=2NBDReFMZPaqYngyq37YoXOx4dlfyV21ybOewgMSFbQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xhi4iUeBGjxntB8bCID1g8ZtKrR7JCG2Lzue604YggZlWkYkMVt+kq+rLHE2Zox6DLLetl/iLzpapPB3ALA2zqH/uwq/moCf0dL5EtNW1Zt21HZpNVGP2H5SvaubkTQTY7JFKrlE6AI0IZft6mO9xD2NQlvroZ4sDjBxtpXPx6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlrriN+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4A5C4CEF1;
	Fri, 15 Aug 2025 19:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755287395;
	bh=2NBDReFMZPaqYngyq37YoXOx4dlfyV21ybOewgMSFbQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hlrriN+4H/nPeRtwK+On2MgdSXGjvH3wCsCxujOvc3UlBDcKfFHwfbtDcwvk3iIX+
	 J98l0PlmG1eLTJHfEeSW2M0q21gwdqmgxfD443t5fJAGl1BkY8G7SGgGYg+cc1vI/7
	 pPKNSOFpRe43tZXwJhCO276WIZmaIXk79YjCwhntZoc0XB7rqDFl5nLsTdVbf72QQo
	 oIKvJcl9kIArjCnSipcXahVU2+ZnsZlmUsf1ZM3vFJbIiS0QEWbk/TXEOH/H9tQsbi
	 rcmrqXZUygbieUg1bPP6Oz3Ge8KmIT0KdS/YOSfNAjSnsg1ZvNqtkrsNoTFFWa3zDy
	 U7CNeGACmSuUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0CC39D0C3D;
	Fri, 15 Aug 2025 19:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: libwx: Fix the size in RSS hash key population
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175528740652.1253623.15402960535177320181.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 19:50:06 +0000
References: <20250814163014.613004-1-chandramohan.explore@gmail.com>
In-Reply-To: <20250814163014.613004-1-chandramohan.explore@gmail.com>
To: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
Cc: jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Aug 2025 22:00:10 +0530 you wrote:
> While trying to fill a random RSS key, the size of the pointer
> is being used rather than the actual size of the RSS key.
> 
> Fix by passing an appropriate value of the RSS key.
> This issue was reported by static coverity analyser.
> 
> Fixes: eb4898fde1de8 ("net: libwx: add wangxun vf common api")
> Signed-off-by: Chandra Mohan Sundar <chandramohan.explore@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: libwx: Fix the size in RSS hash key population
    https://git.kernel.org/netdev/net/c/12da2b92ad50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



