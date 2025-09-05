Return-Path: <netdev+bounces-220199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0AEB44B91
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 04:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255A11C81E3F
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 02:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693D221ADA7;
	Fri,  5 Sep 2025 02:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IH+jId1Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4246D218821;
	Fri,  5 Sep 2025 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757038813; cv=none; b=mBRJ8Vb5WolLpaND3v0TBvYkGd7DvStH+jBRdrTMskk3Ye4gf8ZUqvAt3s1TsmhKO12j5Ci5pTHjpkkusJnA/SO1PAw3UXUKMfUDrOiz2scrXrHKFBF7YpuC+fFYas54HcCt5ynl5FaAn/Xn4Yyhxkorz+jgo+IHcvRLVJLdaEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757038813; c=relaxed/simple;
	bh=NQeqXSGHxNiqCEfgRJgAesFD+d8QEi5gq3w6IAOgTyw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FPSV0o0nnmWwRJRljW5rjPl0tGlzlx238VRTbOXoKXUd4darTlfFMtVzP2V3KnyMA+GiTWvvF9XQGbciY8Ug5WbUHfmKxyZHGSm8vOGN7N9KLiEvVbBAqyix5PQd0neTG9mBxovJMBGtN0CRuqvofKhxEd8GlbmSY1V2qqA4UVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IH+jId1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3099C4CEF0;
	Fri,  5 Sep 2025 02:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757038812;
	bh=NQeqXSGHxNiqCEfgRJgAesFD+d8QEi5gq3w6IAOgTyw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IH+jId1QXQhN1YnO1hieajIWvIQpr0WHIxVW0Sx40qknMWF6plsTYHimVlcrIBOI8
	 AP834k7L4RjbpJXK4fIkOIGwPiwrR2+2YadOmFS1UEbmsKahjOALsoGJN8Cs7/TVhF
	 uQVims9/UWI+Ok5himAJEypZa0bDvE6RSwmfzZLjKC85T0aEI43hKYlQlSOgm1+MUc
	 nLL3eGewYteRIid7jUsQaWi/MizCttwSSSG10bCE721+CoUAmtcal0+eHcy/JdvARb
	 G1YZFdh4+fAt97SFYB1nvubunG6BGupa/s1WZxFhgtp10cf4i7AWUcoxDQO3AplN2Z
	 1OUgyOyUp8tKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCF1383BF69;
	Fri,  5 Sep 2025 02:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] smsc911x: add second read of EEPROM mac when possible
 corruption seen
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175703881737.2010527.10246096285437788190.git-patchwork-notify@kernel.org>
Date: Fri, 05 Sep 2025 02:20:17 +0000
References: <20250903132610.966787-1-colin.foster@in-advantage.com>
In-Reply-To: <20250903132610.966787-1-colin.foster@in-advantage.com>
To: Colin Foster <colin.foster@in-advantage.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 steve.glendinning@shawell.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Sep 2025 08:26:10 -0500 you wrote:
> When the EEPROM MAC is read by way of ADDRH, it can return all 0s the
> first time. Subsequent reads succeed.
> 
> This is fully reproduceable on the Phytec PCM049 SOM.
> 
> Re-read the ADDRH when this behaviour is observed, in an attempt to
> correctly apply the EEPROM MAC address.
> 
> [...]

Here is the summary with links:
  - [v2] smsc911x: add second read of EEPROM mac when possible corruption seen
    https://git.kernel.org/netdev/net-next/c/69777753a891

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



