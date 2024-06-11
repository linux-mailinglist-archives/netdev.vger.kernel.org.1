Return-Path: <netdev+bounces-102623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DF0903FC0
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 17:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5271F26831
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 15:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BB71BDD0;
	Tue, 11 Jun 2024 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRmWEaK7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC0418EB1
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118632; cv=none; b=l5ElwKu9JCfLKOp4CzybycRK/Or/0Y2IzhS5ipNQmwBWbO8kg/dn/O05W3mp3E9FJZCM76p54+8sGsBEIxcUi8DkUH3VcDdNxXN6vp8AYhNB+9mKlA56My/0Ucr53V1hEehLtHUluhPQCwVDJWFjMESzkjSO1R9kaaDRhPPbTWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118632; c=relaxed/simple;
	bh=tKUHqFieFIqWeMSSKV7oYNuKyfFxBb2UI8KjHn4g66s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vFbmIMit7tRL4XybgyDvxFeQU2f4PH9+L/oB0ePjg4B2E5OwQqhZ+gs0nU/8v/9jXp784xLiQIb5vkr38RfoSpBMqP7daG2s4/7zWmTUV0Lti2/yrD8Ewrf+qzQTLOTdVGk9BUrHkFZhGEy9RpTl5ks++qp/AK76CSY/I/ogiOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRmWEaK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F9F9C4AF49;
	Tue, 11 Jun 2024 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718118630;
	bh=tKUHqFieFIqWeMSSKV7oYNuKyfFxBb2UI8KjHn4g66s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qRmWEaK7F2aZ0+HNRbAd2+X/X2VkleTt0smpVzM7XL+4B7jUQt+K5NeIoiuT0bqqT
	 BQrgshb2xHfHDM4D6neXJ/wb4jt1BhTcVVisWhZUYceAJVC5xsIwDIfAlLdRkl8CDn
	 NJuffJoqOTwoxMMWLcTY3YzuY0nRiX0tlcLGNkW8wj4MJM2dh3ZkBHFXiO2ai+jgvL
	 wVgKzq0UxxRTedvxPzQk+KyO5sGuBd4eVmtPt6We7SxEpVupZHsktEBsNJcp+cYJQY
	 70FsiBIakC887eh9FA+Qudlox+hdB8szJLc9tVfc6d/9s1rjo93OSq8/Ot9+3Uhcw0
	 roHQUgfTBjIMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C8B6C595C0;
	Tue, 11 Jun 2024 15:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] devlink: Fix setting max_io_eqs as the sole attribute
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171811863049.7300.38950884252778751.git-patchwork-notify@kernel.org>
Date: Tue, 11 Jun 2024 15:10:30 +0000
References: <20240606043808.1330909-1-parav@nvidia.com>
In-Reply-To: <20240606043808.1330909-1-parav@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
 jiri@nvidia.com, shayd@nvidia.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Thu, 6 Jun 2024 07:38:08 +0300 you wrote:
> dl_opts_put() function missed to consider IO eqs option flag.
> Due to this, when max_io_eqs setting is applied only when it
> is combined with other attributes such as roce/hw_addr.
> When max_io_eqs is the only attribute set, it missed to
> apply the attribute.
> 
> Fix it by adding the missing flag.
> 
> [...]

Here is the summary with links:
  - [net] devlink: Fix setting max_io_eqs as the sole attribute
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=c6c39f3c6da4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



