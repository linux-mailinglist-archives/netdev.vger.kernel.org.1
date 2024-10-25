Return-Path: <netdev+bounces-139173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D35D9B0A76
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 19:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF3D1C22758
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 17:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3967515ADAB;
	Fri, 25 Oct 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwlLTg8x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DBB21A4BF
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875630; cv=none; b=uEjlLhZAAHCI5avSkdLHW9ytGiNp8RBp9JLLkerbVFAwbV1wfRlKOmozatqoiCOmBAChURC7VULQcJtgEYeptbLW2Y4bxSi03k7gksR46JPWiwAjHqqH/WMgfh46SBhe7NaqUddVAuPZoGuAGrC66y8pw4wJn8bdGWvytnJ7c3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875630; c=relaxed/simple;
	bh=EopJK2lV0W/HX89r7AZCyf/FBSf8FnKNogIfmh1oUXg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CrwUE81aWriP2+ABpMkhposATPBTSFF1B7TH+Cvbb2+y5c1uaQTd4mIAbpvWfRzDH3FrzI4p5pRmuCxgSQnTxAIC23c6j87PXxDg8QlXbGg1MpU0LFTTp+xXMh81VLmhwI53wUPT9znf0V7iNF3byNukUcFFq9obtCyn3l9DLmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwlLTg8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9652EC4CEC3;
	Fri, 25 Oct 2024 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729875629;
	bh=EopJK2lV0W/HX89r7AZCyf/FBSf8FnKNogIfmh1oUXg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nwlLTg8xPG6HgFpIivxaBB5YdpH27thTNl6EzxHUrNg/MCzGk52Os1TArIbLmXfN6
	 CsrkShuImgEP1BVzzgalh4kK3B/quA9TyWgA4fGHjIKSdtMf5aj3v0iMBqaoCOUHgd
	 wEVyWjCZ+deBeufywY2TuV0cLJdokiqFPNUkzLH3QraI7uF6rEx2Yd/IdESvM/RdkY
	 ZeTTM1HecWyUlXG70qaiPWCTVvPmVi7T7c0fliEx9ELsLanQYBRNp2zmTBAz0E1b+X
	 UI362xnBg0X0YUZP3HHTxGQNJm54IVpAOW/WZzQNbZhWJSUt7gji//rxD6j+oZ/JVR
	 7OecEta8DHQ8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE8063809A8A;
	Fri, 25 Oct 2024 17:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ip: Add "down" filter for "ip addr/link show"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172987563651.2975656.1895518927691000910.git-patchwork-notify@kernel.org>
Date: Fri, 25 Oct 2024 17:00:36 +0000
References: <20241013185308.12280-1-yedaya.ka@gmail.com>
In-Reply-To: <20241013185308.12280-1-yedaya.ka@gmail.com>
To: Yedaya Katsman <yedaya.ka@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Sun, 13 Oct 2024 21:53:08 +0300 you wrote:
> Currently there is an "up" option, which allows showing only devices
> that are up and running. Add a corresponding "down" option.
> 
> Also change the usage and man pages accordingly.
> 
> Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
> 
> [...]

Here is the summary with links:
  - ip: Add "down" filter for "ip addr/link show"
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=9953ebde0cff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



