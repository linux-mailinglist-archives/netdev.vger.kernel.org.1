Return-Path: <netdev+bounces-182467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0815A88CDA
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 22:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE17317BCD0
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF45E1DE4C3;
	Mon, 14 Apr 2025 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsrnUEHY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1F51DDA2D
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 20:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744661492; cv=none; b=FidmOx2RKdXDZX2hn3x85mOUYWtcp9fnX6RPM740/NO+ECpzqsEqMkAbTU8HOqYrOqhS8ha0jysq00X9tg5OB0W49NLCWGkC296BZdLBZF2nh48/pHwLUlsIksqqAGyw/LGXCXTxsQBMB9VffIxD8Se0xsS5bbbecAYJmwrKAtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744661492; c=relaxed/simple;
	bh=VEs9DpuTUMML3FoZ1Xp6HNR8FbDMkLKE/5JCRvx0KjA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lRiaeZlwCKdUSebZNpHXk6jKr7j09fVyAsarJk7OER8kgyylBNPE0RUIEowhzRtnGHB3Qg3jXnP75/4rw1QCEGycds6Xy0sNtm7oaXGc4sc8pmkLl+ok16/b+NBd99NIobRBGYMu2mQ1uA+fYKmxs1siFKmtcuYAK4EGg7xrdNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsrnUEHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AABC4CEE2;
	Mon, 14 Apr 2025 20:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744661492;
	bh=VEs9DpuTUMML3FoZ1Xp6HNR8FbDMkLKE/5JCRvx0KjA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QsrnUEHY4OfSCI0A9T8a8BBVoYK4JaJqujR0JRgRjBkMh57/xz7FnAsewYsiXOIdp
	 SP5odTRXdyfQaHPvzTcsUUcHfCg7C7PFe9jhR6eIK4Obm0r3f6vvn6xJLOXWYz9U3p
	 agdFL20CLOtXoYnYYdtvm3bhxRGPROEJhsjDIZJuQaMFGejAMf7mUU8zp3JadSbhUU
	 ByxjArnl+8kVpKJ/M0R/X3lrKHH1E7z3KG/dDTRo5yTOP8PdPDJtoFHQ4x35LeqQBA
	 Awv4YfE2/B4HfZUQI+4nk5Sk+unbAmaGHnM/CrGLeu6HPAA1tjcJVTsv+oHHXZLvib
	 juSnCnMjLsZYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D4E3822D1A;
	Mon, 14 Apr 2025 20:12:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: don't mix device locking in dev_close_many() calls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174466153001.2024730.15950175413577520889.git-patchwork-notify@kernel.org>
Date: Mon, 14 Apr 2025 20:12:10 +0000
References: <20250412233011.309762-1-kuba@kernel.org>
In-Reply-To: <20250412233011.309762-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 syzbot+6f588c78bf765b62b450@syzkaller.appspotmail.com, sdf@fomichev.me

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Apr 2025 16:30:11 -0700 you wrote:
> Lockdep found the following dependency:
> 
>   &dev_instance_lock_key#3 -->
>      &rdev->wiphy.mtx -->
>         &net->xdp.lock -->
> 	   &xs->mutex -->
> 	      &dev_instance_lock_key#3
> 
> [...]

Here is the summary with links:
  - [net] net: don't mix device locking in dev_close_many() calls
    https://git.kernel.org/netdev/net/c/f0433eea4688

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



