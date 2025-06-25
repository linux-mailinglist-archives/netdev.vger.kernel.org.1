Return-Path: <netdev+bounces-201363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DCAAE92F2
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 01:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7BCF5A453F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 23:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0D5287251;
	Wed, 25 Jun 2025 23:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eb1o+Qsk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB502F1FFD
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 23:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750895380; cv=none; b=diriWXbW0YE3hyAtNyryQrbDZAZE14B6UphDBZKcxc3phDD6RwhvMANnTw5xVW+jWuMZA5/ZqE9kGJ3puZGY0aa2+t9a6vRVDkvn1iheyg6bi1+GsHjCjg6kiQZVKyZFUx8bdlKQ+Dh+/ubY+tPn5JHf6fej7+DVbLCDKdBoPzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750895380; c=relaxed/simple;
	bh=Xub2LmQQy3iGcX9y6PIZsj8szM23e6F6hvYCo9mVPyw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=suNIg79ATYEIymbxAmWbTexTK5hW/mwemJcAcqQiG6IkCL81gGIDrjnWi27J0DSho/huLF1uKwGO7Et1+1or0rMYaTAgb4OlHn8+A4WHQj6WnaAF1/P9Le/sT3usg6olvJAq9y9VTGiP2SLhzNt460BOuOmJar6KGnxTA/9/F3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eb1o+Qsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E91C4CEEA;
	Wed, 25 Jun 2025 23:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750895380;
	bh=Xub2LmQQy3iGcX9y6PIZsj8szM23e6F6hvYCo9mVPyw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eb1o+QskC/tj9uvYHh3cycIJXR92QV98Jl5068tZUdd5kU2tljcjL3/gJT2txO9bc
	 JSi3tlgHoyysUshWKhESYIEB0X5u+2SdST3wUXMSv1gz2uQ9p3N0yCMzXYA6ciOnUM
	 CwpsgcEXLAMrm/f7/FYq1wnvKytPFpaWz7MKaFM50E/NdhcmyTKt393tmJDxks6DMc
	 kcF7RZkwWM2SXKEg7C9rU3YCKH7duGmOd8lOkeNkFl6LIqw+n8x+KQspFIwdkJc5ZB
	 XiBr972/lveBpAqL97xdqp22tcUwdydyc53nzu5mqzYX8V5SkoPH9qdSoGbGn3N6b8
	 SumpYAOALiFTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0DE3A40FCC;
	Wed, 25 Jun 2025 23:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] atm: Release atm_dev_mutex after removing procfs
 in
 atm_dev_deregister().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175089540576.663311.15028077302318464200.git-patchwork-notify@kernel.org>
Date: Wed, 25 Jun 2025 23:50:05 +0000
References: <20250624214505.570679-1-kuni1840@gmail.com>
In-Reply-To: <20250624214505.570679-1-kuni1840@gmail.com>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, stf_xl@wp.pl, chas@cmf.nrl.navy.mil,
 kuniyu@google.com, netdev@vger.kernel.org,
 syzbot+8bd335d2ad3b93e80715@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Jun 2025 14:45:00 -0700 you wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
> 
> syzbot reported a warning below during atm_dev_register(). [0]
> 
> Before creating a new device and procfs/sysfs for it, atm_dev_register()
> looks up a duplicated device by __atm_dev_lookup().  These operations are
> done under atm_dev_mutex.
> 
> [...]

Here is the summary with links:
  - [v1,net] atm: Release atm_dev_mutex after removing procfs in atm_dev_deregister().
    https://git.kernel.org/netdev/net/c/a433791aeaea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



