Return-Path: <netdev+bounces-231967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27938BFF0AE
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 05:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B5D05353113
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 03:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EA22E5D2A;
	Thu, 23 Oct 2025 03:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmrkr7Ns"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D002E2EF3;
	Thu, 23 Oct 2025 03:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761191196; cv=none; b=AR9GasZ4CD7y6K44NrUwtLhg8grggXFRvMDAEnfsVknhQtpOsREJGCwcwhdTosgBrBlsrE45cQ+TljLz7PPET0BykHK2Tk0y2SGxGphh4Vx3imBgxYti7f/72X3qbP7Amg48C9rSApYHrg4WacBM4IHb3ceqKcnzILDG5aiquKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761191196; c=relaxed/simple;
	bh=F9SWjrb1CQ0a0RkDQmktXYjIX9Z7TMwqsasaeOEVCGs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PEnEVyHe/hnwECC7KLUVRkluFbksAuELXsjOcXiNWdz7ocl3ia1rubzSp5JwU1foS62t8EaAmAQHo+CBQSc7qswJKF3Ci01dJ2hNY8GPaJNI12jdB3eKDdg5E/pzSGtRjWlr+MsH8SDQW1NzGEJ9D+RQachlSCjdlieBR1SPPyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmrkr7Ns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF0EC4CEF7;
	Thu, 23 Oct 2025 03:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761191196;
	bh=F9SWjrb1CQ0a0RkDQmktXYjIX9Z7TMwqsasaeOEVCGs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fmrkr7NscNmMP7NN3Vla9VKhJnEZWY9k9SOWeHB3gmxknifHgH6Ozy1JXcWZlIah9
	 c3UAvPFG1VPRQ4ekVY+rK7nMBQ29RGB7R0ZWSUXY00A8P10ub9+iEdgsrQFIm3iz3I
	 PKj5pw4JHR555krjZ3FEgybq3Ib/zaE0Cse2+Tt/+hlZD/yoxmrBhs+YBZS5azsZ6Q
	 kLaXFASCOXCUd/CZ7fQeoE3ur6QxYFlsPLPQEF8i9ZEzgsaShP+2FvBdEKocAZAveT
	 ZJSPhpqvBcbXp150T1sLg8I/4SPYuUvHKIb73m081M2Hi4aF9v9QY2zEAd2mZmt/JP
	 OdhMGpNRmOVSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341A83809A04;
	Thu, 23 Oct 2025 03:46:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] eth: fbnic: fix integer overflow warning in TLV_MAX_DATA
 definition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176119117676.2145463.10144749814100093339.git-patchwork-notify@kernel.org>
Date: Thu, 23 Oct 2025 03:46:16 +0000
References: 
 <182b9d0235d044d69d7a57c1296cc6f46e395beb.1761039651.git.xiaopei01@kylinos.cn>
In-Reply-To: 
 <182b9d0235d044d69d7a57c1296cc6f46e395beb.1761039651.git.xiaopei01@kylinos.cn>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: lkp@intel.com, alexanderduyck@fb.com, kernel-team@meta.com,
 netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org, lee@trager.us,
 linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Oct 2025 17:42:27 +0800 you wrote:
> The TLV_MAX_DATA macro calculates (PAGE_SIZE - 512) which can exceed
> the maximum value of a 16-bit unsigned integer on architectures with
> large page sizes, causing compiler warnings:
> 
> drivers/net/ethernet/meta/fbnic/fbnic_tlv.h:83:24: warning: conversion
> from 'long unsigned int' to 'short unsigned int' changes value from
> '261632' to '65024' [-Woverflow]
> 
> [...]

Here is the summary with links:
  - eth: fbnic: fix integer overflow warning in TLV_MAX_DATA definition
    https://git.kernel.org/netdev/net-next/c/d550d63d0082

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



