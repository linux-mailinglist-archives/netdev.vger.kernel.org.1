Return-Path: <netdev+bounces-227339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 297BABACB7B
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 13:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6223D1C7C83
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 11:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613F226561E;
	Tue, 30 Sep 2025 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rj6SuZ+K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE84260586
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232416; cv=none; b=LL4URUdNspckSX4FHfvM1qEZ25V9L7TxYVYgm6JSNiTDbQRNdTjJiiYHh++o5Zkbe8M2vslHbJt6nIdCAEDzP3nzqS0fu7ngU1H3VuoQQmlJBkavLDCJvhMJebtqcv7CDZbLf48nvLbzpQ/H9tqRDYTwbQeYSQeHiyQbsrywxwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232416; c=relaxed/simple;
	bh=73lTHkqpoSy7WnLQS9lbnrmJOFsGYoETaxjhLpXfs9I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sqdyQvX5OdIr2T3WBLZCYsP2nTRCsamJF4WgEC71000ngx0i9snUFFV5VbqwSmKIVLKR0KZG+7CIbDnZ5oARFdtf2OSffK/1Fmn5hxU4psBjAWUxeSr8XOroUs8xu+f30/u8cwZmv84/95iP0CuDYJt6O92s5W0LULGeVJfd9Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rj6SuZ+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB68C4CEF0;
	Tue, 30 Sep 2025 11:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759232414;
	bh=73lTHkqpoSy7WnLQS9lbnrmJOFsGYoETaxjhLpXfs9I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rj6SuZ+K+Y8EoiHI6/0+S+djPDUIxysEFjtBWpVLFaJgV4f/4sLOI0WhjuQCoJdbx
	 I2nhl4236j5tgDR6M2Bf62Z88kzW7xUlAPzjjsiWUkoAOkEg6GaV6ViSUSk/IJBdOb
	 v2bkvnca9FCO12eJUtwKRVlKBwSiuMwSZrv1HXCGU1MxrCJ3wtgPf8m+f99vD9JFwC
	 FJX9bkKIya0gu1pBis4f6rHppCBEJw1gj8Lgim4KrRbsawZS5XD4xM5Aj7lcpru5Er
	 P8yO6diEhbIys7Slrw880y4CWHKRel+yMdf4pz258u7Tnfx5IuQQ2V4ngdOju8va+H
	 +3EuHu8RpqhnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E0139D0C1A;
	Tue, 30 Sep 2025 11:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: sfp: improve poll interval handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175923240800.1954979.18052350684886550886.git-patchwork-notify@kernel.org>
Date: Tue, 30 Sep 2025 11:40:08 +0000
References: <b8079f96-6865-431c-a908-a0b9e9bd5379@gmail.com>
In-Reply-To: <b8079f96-6865-431c-a908-a0b9e9bd5379@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, linux@armlinux.org.uk,
 pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 27 Sep 2025 22:23:19 +0200 you wrote:
> The poll interval is a fixed value, so we don't need a static variable
> for it. The change also allows to use standard macro
> module_platform_driver, avoiding some boilerplate code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/sfp.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)

Here is the summary with links:
  - [net-next] net: sfp: improve poll interval handling
    https://git.kernel.org/netdev/net-next/c/9ebef94cf679

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



