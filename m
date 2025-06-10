Return-Path: <netdev+bounces-196388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849E7AD46FF
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472A3179441
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5266260599;
	Tue, 10 Jun 2025 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7uewQ8p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3051E835D
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 23:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599421; cv=none; b=QVvv04w9hE67ua2T+IHRANdK/QXwAIAU3laaDxQLqkvxCC3S/8MgPmn7h42ErqbWQaxzz6ilLmW5x2YTgOcIqplHoXXRTmQcCh6webMUXvJf9fKRKAod1QhVKVPHLgQm4RyoNzg2TO+g6/MPhyrSCbkv6BHclKBTeie50aswTwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599421; c=relaxed/simple;
	bh=QolIHXb+EkXNMU3v3f9OAa0FqwSoiNxvBPWx0uOrui8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m4g8Sry/lms5B7esyJUISOugFArj/kvNi5VBAr+65ay9ppt9FACP7lIXrHHH6dHHnmMdt6/kxjK4oyk0JMld8E4mEhHwNtceqmmyNf/sl3c2OnHHEBcOJHvZg069/JyFwZ8iVPcyDL5wA4mnhCqns615gw2qC7DHvooZFUls76o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7uewQ8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2076FC4CEED;
	Tue, 10 Jun 2025 23:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749599421;
	bh=QolIHXb+EkXNMU3v3f9OAa0FqwSoiNxvBPWx0uOrui8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X7uewQ8ppAh3J0C7U2AGW4huWbqYiaRDaxf94fmMM3cj4IGl2292X3bIPXT6/Omds
	 MTT2bDdHdOqQhhkLD0li6pwqXx8o7cXPvSqKz2XIa2rvfqPnRr+yb2UX/QFLDOJXG/
	 YdK4QXB3lQ0YnQkJ0FjFuB3tv4okXXyxvVrM1axPGt9qFC0gaJ4DCts0qmT3rb59s7
	 6jhd+mVEEJUQwStbfDEfx2IGSmsN97NIZzqxHfoBQdEVRS2xnfASipi900LhpPeIHJ
	 UVIHmHk1s7+jHwFGghcKQViQVLxbf3bV9bl3/qGxoCAf9U7fNFxRuCGHUEpFOlJXhH
	 8cl5xuzYlmCOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD6538111E3;
	Tue, 10 Jun 2025 23:50:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] common: fix potential NULL dereference in
 print_rss_hkey()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174959945123.2737769.14443818617306779815.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 23:50:51 +0000
References: <20250518130828.968381-1-ant.v.moryakov@gmail.com>
In-Reply-To: <20250518130828.968381-1-ant.v.moryakov@gmail.com>
To: Anton Moryakov <ant.v.moryakov@gmail.com>
Cc: mkubecek@suse.cz, netdev@vger.kernel.org

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Sun, 18 May 2025 16:08:28 +0300 you wrote:
> From: AntonMoryakov <ant.v.moryakov@gmail.com>
> 
> 
> Static analyzer (Svace) reported a possible null pointer dereference
> in print_rss_hkey(). Specifically, when the 'hkey' pointer is NULL,
> the function continues execution after printing an error message,
> leading to dereferencing hkey[i].
> 
> [...]

Here is the summary with links:
  - common: fix potential NULL dereference in print_rss_hkey()
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=f111e854d99e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



