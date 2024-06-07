Return-Path: <netdev+bounces-101621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B016C8FF97D
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 03:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9E3286F21
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 01:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B54C8CE;
	Fri,  7 Jun 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q36cn4kf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F91748D;
	Fri,  7 Jun 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717722628; cv=none; b=T1Btk/MwXiLQ3EapMAiz1cOamUqYbYMSsmro3jQ/dFVMvyMEcvRz3AccCsRxoAMfS/3iIoy9TQrb+73z1fUxjH1w/8HIEBkGm6zwc5e4uS06tzknv9/2oo+a6//HHZ+WZ6F3EFmbq9PK5dm8GyTbaJSL1T1WI2YrOf6itJDF0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717722628; c=relaxed/simple;
	bh=+SA/XZGJxt1q4mpqLZLD9MrkyATNY6ZwcG5N3n0oO2Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rh5WVTKMWDnTaI0DYGAbHJylFtYijMN1/+xg5yzLFnCSie7+kkPjUN8cNtYURO2zKa18mdZ+bIhceubFbvPS8db8y2r5mzbp13Su5u/mGQrZZSgROUHUALAtwXBkqSEUeMpSXLYbJ3zQW+abgr2wvzqw4dqKnuPFMck1EjDDDbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q36cn4kf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE991C32786;
	Fri,  7 Jun 2024 01:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717722627;
	bh=+SA/XZGJxt1q4mpqLZLD9MrkyATNY6ZwcG5N3n0oO2Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q36cn4kfYbpzN726bC9sx0oQ/PqrnjCm50ZpEcOeNGljJaD0ZAx7VaYz7chG9GacG
	 Tf6JzF2g+kT6T0mqGeXpz2nJHofLLREajVZpVO23pogRBsjtqOt/drtywLIF3Kx7JF
	 eGITafgVVgrm49pGIx4F+6B7Xvex/qS5svYu8fUC7DgaJoaD3xf3u5ZuY/6NG0Q98G
	 dFfH5nGjo5XNn4YlFARz8ynrKx/DluSD2UL0fMoXVfDvuqhXjt9rxOgzpVm3b8uXXx
	 NIWLAkEsK50mJI6QBhe36Yqk7c0l+Y+Y3qEijji5AT2H66Rw+S614k2hjQtN3QXHNS
	 KQmlZxKQ3De1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86178D20380;
	Fri,  7 Jun 2024 01:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sfp: Always call `sfp_sm_mod_remove()` on remove
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171772262752.19610.14331926871757735956.git-patchwork-notify@kernel.org>
Date: Fri, 07 Jun 2024 01:10:27 +0000
References: <20240605084251.63502-1-csokas.bence@prolan.hu>
In-Reply-To: <20240605084251.63502-1-csokas.bence@prolan.hu>
To: =?utf-8?b?Q3PDs2vDoXMsIEJlbmNlIDxjc29rYXMuYmVuY2VAcHJvbGFuLmh1Pg==?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 5 Jun 2024 10:42:51 +0200 you wrote:
> If the module is in SFP_MOD_ERROR, `sfp_sm_mod_remove()` will
> not be run. As a consequence, `sfp_hwmon_remove()` is not getting
> run either, leaving a stale `hwmon` device behind. `sfp_sm_mod_remove()`
> itself checks `sfp->sm_mod_state` anyways, so this check was not
> really needed in the first place.
> 
> Signed-off-by: "Csókás, Bence" <csokas.bence@prolan.hu>
> 
> [...]

Here is the summary with links:
  - net: sfp: Always call `sfp_sm_mod_remove()` on remove
    https://git.kernel.org/netdev/net/c/e96b2933152f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



