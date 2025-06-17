Return-Path: <netdev+bounces-198381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5DFADBEA1
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F5216B983
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCDA1D619D;
	Tue, 17 Jun 2025 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+1m9PXj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2BE1D54EE
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 01:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750124427; cv=none; b=ZB+P81S3vJkmVngy8fnorGWQLTe9jrdystuRi9XPInHocH91FqnGwndIURz8Ho9EJlboG47EdL2DW04GUqno4xoOtQi//mmsRxLnpFvigmKdGD9XV3rf6cFwnydU9rX6yO1POEAlO4A8yEk1uSiR0KOk3jRPGyXdAhSSIswKfDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750124427; c=relaxed/simple;
	bh=CfAofqgxOGUFO3br8r8DJ3pqctOrenqZQ2j3Skkgjkw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CTWWiyvnK6aDN9eGf+9uwt6IDsXw9kDIYfswqMZq+BnZ9wY6Iy0w/ojRy4C+omx2lYHrDlnEnCyByviFMmfohjJ2ItHVh3hUeDhGLKB7wt0tHU7HDIp/AiamwxTE8zrGWFqrmLi7IA8LEvaWoQrlaNWOP8GVkt4pOfviwIwmHSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+1m9PXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F111FC4CEEA;
	Tue, 17 Jun 2025 01:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750124427;
	bh=CfAofqgxOGUFO3br8r8DJ3pqctOrenqZQ2j3Skkgjkw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p+1m9PXjUL+iL68Lx7jupRNEJWJACaZXuvGdy38sU24UhH/N2sAm4DmfalorCx/4r
	 Qycx7hmglcNfMxHZrGaOYEJ+JNMIdmN1LtzwKfocw2zGzOMnbim7RguObXvA7/AUcu
	 MxHxpN+GQksZrWrqzWki6iXF4K8xACfBLnk/w8H4nJJuD/1/z0DJTTCdj9u6MNrg2z
	 dLyPP4x08FmHxUB2qDVrVsyIqi4IHB5TVkmDjnQB4bKdU03HpHe9o6sjlAlf/0VoIv
	 rt2Zmsti4JCUZDL/2lEwWyV1tNagl9e4uDefBMVRio03aNco3vvOjNfLo0PBMCLZKE
	 Rca3A0D8rZI8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC5B38111D8;
	Tue, 17 Jun 2025 01:40:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: gianfar: migrate to new RXFH callbacks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175012445574.2579607.7186602700396760158.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 01:40:55 +0000
References: <20250613172751.3754732-1-kuba@kernel.org>
In-Reply-To: <20250613172751.3754732-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 claudiu.manoil@nxp.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Jun 2025 10:27:51 -0700 you wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> 
> Uniquely, this driver supports only the SET operation. It does not
> support GET at all. The SET callback also always returns 0, even
> tho it checks a bunch of conditions, and if my quick reading is
> right, expects the user to insert filtering rules for given flow
> type first? Long story short it seems too convoluted to easily
> add the GET as part of the conversion.
> 
> [...]

Here is the summary with links:
  - [net-next] eth: gianfar: migrate to new RXFH callbacks
    https://git.kernel.org/netdev/net-next/c/3b5b1c428260

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



