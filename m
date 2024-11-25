Return-Path: <netdev+bounces-147248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DAB9D8B10
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 18:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843B8160EF1
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 17:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1E01B6D06;
	Mon, 25 Nov 2024 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ewi0YJiR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B011B0F2E
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732554621; cv=none; b=tCySoFUKEFkZMNMmSC0iMeSXkF6F+C5LZCZUdllMDXTmsDuclHW+aV2aSc2TKJEwBsuJ7TSzZFWmO603r1oGNtjAiz0gTMKXXxkDoX4hZTNtp/wkHrlEeXZzkoC73CCgZf4w1czeyAAUlzcFREUCG+2uP0hNA/GDqnxOE6rezgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732554621; c=relaxed/simple;
	bh=bjKHxwz54tUyZl8fURT0b385yEOtdjV0IDz5YBWI9lA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WLpfqnFy7tUYlZYqdM8ICMp7tMJGQw59Opa7wIYmkiOsqeTFc7498iZ9ulAmNT6lpwBs81fJrpMN1rveE5yBwwbjQE00lAEw1By0VI/2PHyCn731GRv+wrfeDL29AkCccIUkzkr4K7ddPJ/jr9TKBfTV0QovX9edWSRavBBQU0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ewi0YJiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FBFC4CECE;
	Mon, 25 Nov 2024 17:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732554618;
	bh=bjKHxwz54tUyZl8fURT0b385yEOtdjV0IDz5YBWI9lA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ewi0YJiR3nc22KCxpK75NFfn3f+QB+mrNxLbdEuriz8UPFvbTqXYYcAoIUBLPTqVW
	 cLyC8fhD0A9fpbanC2YWyzTqu8hYnT2zQuFujLqxJzCqLF730O9JoI5spjvcDmWBHW
	 PH/cKHh0sLQBfVOeNczQiFdb6+mfISOc/eU1EgevOvcBiKAvJUoz53F8czESc9tTzm
	 dCIDkM0TfH7Vr626eyHIQ8+gwa/9FDkZwzMN+TRc/wHPB73Z0G6BFiVfk7MWoyWia3
	 AZwbarYKNGnu9VtvSDhi3NUSaUM3/uwlrsZxXUyucJM+dw3VtsKPlr/qQuoZY/xu2y
	 WoetRTe+nF4oA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7184B3809A00;
	Mon, 25 Nov 2024 17:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ip: fix memory leak in do_show()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173255463128.3972162.11203994539008156199.git-patchwork-notify@kernel.org>
Date: Mon, 25 Nov 2024 17:10:31 +0000
References: <20241125060848.56179-1-heminhong@kylinos.cn>
In-Reply-To: <20241125060848.56179-1-heminhong@kylinos.cn>
To: Minhong He <heminhong@kylinos.cn>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 25 Nov 2024 14:08:48 +0800 you wrote:
> Free the 'answer' obtained from 'rtnl_talk()'.
> 
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> ---
>  ip/ipnetconf.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - ip: fix memory leak in do_show()
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=0325d98f98ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



