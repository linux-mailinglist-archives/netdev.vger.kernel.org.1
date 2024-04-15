Return-Path: <netdev+bounces-87816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9478A4B77
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACACC1C2088E
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 09:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23453D969;
	Mon, 15 Apr 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThPfXDe1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4B53A1B9
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173430; cv=none; b=Vhl86E8elrGdiuu+V3Tf/q50J5c0HBp/NFKwRA9049DU9L+d3voYcY3KYCYAI0xBxgEtGgtooADHH0zSRzZo6G4ZX03hCK6JqoR1aB/ftagwSvBHBMI4ozhS/au6K1VjKhuICpRhnpgeN+SkF9aROtX1ghkPUIQipPTq0+96FhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173430; c=relaxed/simple;
	bh=4Bd+Ikgc2vK0jJVSEtGoLA3f67gmTDCiQTX+iVkKivY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=haj08ghVnh00nR/nD1Rh8u4xrAE/JMsnAnpBWdKJj6YSi9Y0mj8OIBXXP/1Fon/hGU+rFH2DhCRdCHLIl2zKCKCAQzikC2qp9T/wsCkJQT4Nol14xlPDvbaiHNxcxAZTtbRbrat6xN61LllVCTG/XXaxrWFh4Wkgxa0W41kGvis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThPfXDe1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65906C2BD11;
	Mon, 15 Apr 2024 09:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713173430;
	bh=4Bd+Ikgc2vK0jJVSEtGoLA3f67gmTDCiQTX+iVkKivY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ThPfXDe19e6tYRtCerc1uh7nSQzHrAVKv/ewzOi+e7Zj/XUx2Fzmcl1Z/oy1IPrrQ
	 O+0v31scUdtGxITYdTH63e5+Y10kzSUj2rdMJ2MzeN4FXAzI8kd5V2N4c852ANOr04
	 0nJWnKczp8VNSx1D3hI1EYdDG50YVRjc9k76+MAU508jvwj964UIS74518bhcoGer9
	 p6lSEiwai3UVanCVklNBah7H19CdSZmDbcsTqJTSvucoHRlO2JiP+TYz3okwv++UWX
	 XRz5mRzBiAJL6hokOMhEBOVxTGbrizBt1ZDWCgQyM6FHyOoTOv/faPiqtVDjw1JEf9
	 +y70rDB5SMtCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56795C54BB2;
	Mon, 15 Apr 2024 09:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dev_addr_lists: move locking out of init/exit
 in kunit
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171317343035.4489.13927722462831378141.git-patchwork-notify@kernel.org>
Date: Mon, 15 Apr 2024 09:30:30 +0000
References: <20240411183222.433713-1-kuba@kernel.org>
In-Reply-To: <20240411183222.433713-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux@roeck-us.net, o.rempel@pengutronix.de

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 11 Apr 2024 11:32:22 -0700 you wrote:
> We lock and unlock rtnl in init/exit for convenience,
> but it started causing problems if the exit is handled
> by a different thread. To avoid having to futz with
> disabling locking assertions move the locking into
> the test cases. We don't use ASSERTs so it should
> be safe.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dev_addr_lists: move locking out of init/exit in kunit
    https://git.kernel.org/netdev/net-next/c/3db3b62955cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



