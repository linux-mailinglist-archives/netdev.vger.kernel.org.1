Return-Path: <netdev+bounces-161591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 805DDA227C9
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 04:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D711886D20
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 03:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952571494B2;
	Thu, 30 Jan 2025 03:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDynxUzf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A0A148FE6
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 03:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738206612; cv=none; b=EaMJmLzkh1yZ2DSRbTFWEgRF33Ki+sg7JNLuzE8lmOOOw44NKe838ExRxpPm4Mq8NGaVMwP5Vp3gV70EQovbzqLPuSZAlLTS/8X705lqh+5qqnCAMHPXjiNaSh+6tIxmRUjsf2iesNY48JO93oJW1IuWD51j25cfLAJPPezIXj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738206612; c=relaxed/simple;
	bh=McN2GEcVhIZ14GUuz8FioT7LeLoacv9tH0nd2DPuqxA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e8+EZ8zM8c0usBhiFnEAx3pnzAViIXCnbHU+Uym8Qq341gK0rfc0S/d08OpbIsENOEoogM1cJp/C1oRp9XbvurHs+BjCCeVVVFUfKkbT0wXXEIJHs75pijW8V2x/iqm7m4g+xOAbjVyfsrHKoe8hQSDV/0a1LgSMGYDpeSnkSLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDynxUzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D605CC4CEE2;
	Thu, 30 Jan 2025 03:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738206611;
	bh=McN2GEcVhIZ14GUuz8FioT7LeLoacv9tH0nd2DPuqxA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cDynxUzfim84+UmwbO6WQpf3QFb2hxbBlCzO3xfyH1EHo3eTj39KohUERkjoM53OD
	 3YrZDUDTwLSifxZij7UnyLeT1nUkQKH5Qmzd6R8ddz2PiuyYhMQfZUL3pSApDQSurc
	 Stc8FTBdV5LeFSnVAzVuxqJwaVP8dZc3TLe9kOeoDNELdE+xA7c/L+lY7F6+m7MrAg
	 IMcULfHROxakfKiWAq5CxQIN7IMe6FYK+7pO4uC/j513oCHzvOq3h3mxCaU1Fy2bWr
	 HsHfO/2k4ayLG/5xrqTMIZlVc+O0Gg0bqDAQ0G286QdpI7Q5J1hH5ExK+8eURrIxYn
	 iY4gfRHfQQK+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3663F380AA66;
	Thu, 30 Jan 2025 03:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net,v3] tcp: correct handling of extreme memory squeeze
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173820663775.510125.11642724100877791726.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jan 2025 03:10:37 +0000
References: <20250127231304.1465565-1-jmaloy@redhat.com>
In-Reply-To: <20250127231304.1465565-1-jmaloy@redhat.com>
To: Jon Maloy <jmaloy@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com,
 dgibson@redhat.com, memnglong8.dong@gmail.com, kerneljasonxing@gmail.com,
 ncardwell@google.com, eric.dumazet@gmail.com, edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jan 2025 18:13:04 -0500 you wrote:
> From: Jon Maloy <jmaloy@redhat.com>
> 
> Testing with iperf3 using the "pasta" protocol splicer has revealed
> a bug in the way tcp handles window advertising in extreme memory
> squeeze situations.
> 
> Under memory pressure, a socket endpoint may temporarily advertise
> a zero-sized window, but this is not stored as part of the socket data.
> The reasoning behind this is that it is considered a temporary setting
> which shouldn't influence any further calculations.
> 
> [...]

Here is the summary with links:
  - [net,v3] tcp: correct handling of extreme memory squeeze
    https://git.kernel.org/netdev/net/c/8c670bdfa58e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



