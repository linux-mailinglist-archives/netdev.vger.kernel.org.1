Return-Path: <netdev+bounces-122499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A1D96185C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 22:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0618EB22CB5
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958151D3656;
	Tue, 27 Aug 2024 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/IeVmoc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD581D3650;
	Tue, 27 Aug 2024 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724789431; cv=none; b=cFrAJ483LdZmb2r2bYcIL7hseVGylKEzmGwQATFKe6orl6JpSdqRRDyNPoDk4mCW/0yt6WWteOlj10zBiTPZl7HusNiBsB09LM0Vu+y7+zDTVYNi3z53hewF6A97tXfIRXYyp1Hun6PpW6MVevDrIx1zqFRTcSmiMnyLvTloueo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724789431; c=relaxed/simple;
	bh=g9+JaWQzq04HRwzWnA0ZxOYgqdZ9Sk8D15Zt3La1uOA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cfYzvDIATDD1yn5M2ubJYXJXILDpk+PhSQGknTpl6U/y/74jlzN4AdTuCyD5O45T+GjuI/G1ggTlPEDxSrMyXSNTcjiZ0Iw9F7AjECgpOCvkgZaKskA5d5h1qP0IHMzDbQT99k1V7pVbwSDMH9walF6HRzr03Xe0K0lm9xZzfgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/IeVmoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2A8C4DE1B;
	Tue, 27 Aug 2024 20:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724789430;
	bh=g9+JaWQzq04HRwzWnA0ZxOYgqdZ9Sk8D15Zt3La1uOA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t/IeVmocZWPHRwqnA9ybmu+s1u9rTWdBOARqTzzlxX5aqVsVFYC5+FaOOnKj1bSTs
	 PYhybSpQUowEYfoO5Jwu/GZ3rhHYLlTkuIAVIj6/KG5vn1cxRk/oGrehAHRBIwCh9F
	 HnM1r058vjeCboN0NYXvXbWzyunv/AOIuOIQaujD0HlSCwJESchm7IxzOJimS+PaaF
	 RImiHwolchtf/QyzN8ohBPoR/KJp79cnWndqPpvFl//Phn65/OQ0AnqZiSzlkVfDfx
	 T4lwndYRWj0zI27MRXzQ3D4lcYZtw6oHv/uNb2A9hdnQ3wYTJUbl6hvBaBYzAz7L25
	 F+0HkwDAbYJAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C2F3822D6D;
	Tue, 27 Aug 2024 20:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net-next v2] net: fix unreleased lock in cable test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172478943074.751194.1705934546816050259.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 20:10:30 +0000
References: <20240826134656.94892-1-djahchankoike@gmail.com>
In-Reply-To: <20240826134656.94892-1-djahchankoike@gmail.com>
To: Diogo Jahchan Koike <djahchankoike@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, christophe.leroy@csgroup.eu,
 maxime.chevallier@bootlin.com,
 syzbot+c641161e97237326ea74@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Aug 2024 10:45:46 -0300 you wrote:
> fix an unreleased lock in out_dev_put path by removing the (now)
> unnecessary path.
> 
> Reported-by: syzbot+c641161e97237326ea74@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c641161e97237326ea74
> Fixes: 3688ff3077d3 ("net: ethtool: cable-test: Target the command to the requested PHY")
> Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: fix unreleased lock in cable test
    https://git.kernel.org/netdev/net-next/c/3d6a0c4f4552

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



