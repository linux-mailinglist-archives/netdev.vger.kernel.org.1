Return-Path: <netdev+bounces-144307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C199C6852
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790231F23CB9
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 05:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D27417624D;
	Wed, 13 Nov 2024 05:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uopi7cfJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E09176227;
	Wed, 13 Nov 2024 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731474028; cv=none; b=i9hKXnbLctdSxv4uS4wqsSG3Ni+dg3ZvvEx/zEo0CqKTAVrC5m6I4TUb/FPtNM5sloJtwjDxRhn59RquGEDUDYbS7EuL56jpEAqPtLJ4DmzNYXs/eVZUsngvJ3+sR8to+6GK/djCbsHhvsAkg0bzojJLqupIzIWxHHowpwOyLg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731474028; c=relaxed/simple;
	bh=Z9eYVY2vdewrh0pTpQiuKoGCOKjkEvsy8120cNOY/ZA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C0KZqRzwJCUBwwhBOTbJLHbUQqMod1KQQViaeDEg+9CckhhGqti9toEEBWYDZVSN91wp/noNhvk5VAx5jhMLpwHDS5Yx4CasGjeLCOrQsAr+ocXGLz8xXa8MP+rFhlKK+HAzSy4MASSTSPFj8W+f/8LSv2Sg/fiCdQvIDQ/6QPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uopi7cfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EC7C4CED2;
	Wed, 13 Nov 2024 05:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731474027;
	bh=Z9eYVY2vdewrh0pTpQiuKoGCOKjkEvsy8120cNOY/ZA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Uopi7cfJA15cmN9CZXz/xrBP34RWe6N7ftFmh4kVz/0ucrCRdZgEZfh+/hk2MPX0i
	 LUGVNh44Wdh7B0NB9WKrXwTCaCPnT11ExWo42+U442he0ZrUwLIhATQw/o8AMoV5SH
	 ne6sBdplH6hwQWmQyPQkkrEnQ/0/RGaUM3df29rOGmLtSB9U83KToLgfA52WbX6wWf
	 urwHiWYdcHuRgwkE2cMJPgEMy2yrFIB/eHbVpbWcLO1Mv4hOPkmbwbBOEmD/tGfikL
	 XZ6YWIcvsoM0IScY7z3/nK2loEBOMkR1v26uxvH1RdjkQiGqMR3aYFj6ToYcxz2caq
	 tASggXlEZcdBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EEA3809A80;
	Wed, 13 Nov 2024 05:00:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mptcp: fix possible integer overflow in
 mptcp_reset_tout_timer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173147403799.787328.7140723008412111256.git-patchwork-notify@kernel.org>
Date: Wed, 13 Nov 2024 05:00:37 +0000
References: <20241107103657.1560536-1-d.kandybka@gmail.com>
In-Reply-To: <20241107103657.1560536-1-d.kandybka@gmail.com>
To: Dmitry Kandybka <d.kandybka@gmail.com>
Cc: matttbe@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
 lvc-project@linuxtesting.org, dmantipov@yandex.ru

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Nov 2024 13:36:57 +0300 you wrote:
> In 'mptcp_reset_tout_timer', promote 'probe_timestamp' to unsigned long
> to avoid possible integer overflow. Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
> 
> [...]

Here is the summary with links:
  - mptcp: fix possible integer overflow in mptcp_reset_tout_timer
    https://git.kernel.org/netdev/net-next/c/b169e76ebad2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



