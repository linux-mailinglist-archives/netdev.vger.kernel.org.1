Return-Path: <netdev+bounces-120384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F20959187
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 02:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D814B23FCA
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AA8139CF2;
	Wed, 21 Aug 2024 00:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gzbh7R1C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307D113633B;
	Wed, 21 Aug 2024 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198437; cv=none; b=HknEqr4kyEj3w9o5uaDn25J/PamKOb70/W7n5zO4r0um4TugBqR+wK8dvAl7psOMFlDCtT7pB06lqd0G4B0badY59tur7WAMFjjWefLwwVPjqaQ8ueOc2cCw2JtUWd2vOcdL9bzneo/d1QPmYEC+ISe0w+8arjOkef8rXyf7pms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198437; c=relaxed/simple;
	bh=rv8CVtxB8ClMdwtUWvYhj1jRphSibm/w96AKebWZWGg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FHhQq7GqB9kngslB/SrLDbxTgHJ/wFmxe6cqa4zvb49ZKRK1WF0QqrYXrBPYu4ovGBlZDtjo76CJPHAAkzliqC+sFXOrwNGYTmCpHXEZdHx5gJlUYnpN+7EGpJcZmA1aEapeYEw0mAia5tJSarZlKLNcqUQjI/3MRjMoZ9mGC90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gzbh7R1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47B1C4AF0B;
	Wed, 21 Aug 2024 00:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724198436;
	bh=rv8CVtxB8ClMdwtUWvYhj1jRphSibm/w96AKebWZWGg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gzbh7R1C21W+rSGp0sIkdobG0xlRYwstAb3noBVV9XsMs1Vj9Eyrj3ryLJCABaHve
	 UtX9rwywe4b4P28uDBxnCypkTiEMXHpofg8f++vDmYz77jM2i8hoTGluZyAHlLzJ+F
	 L/WiD49W3GO781aWP7ZprykRp5Bfery3cuxJfN9akQ3FlMY4oZbmoteWERJPwMidNf
	 ktMfboEqlTpyXhekgfHMMfC07H1uDiA90QkHu2CeC3k6vfHEvJxIg7+Up8intSN2Lb
	 Aot36pSM1RB+6JBlpaoy5yS5S1NJJUP4ImjzB4H+Eww2lrgNSbtO9rUF/huMG4oc+j
	 nNNAvQfQIi7ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713083804CB5;
	Wed, 21 Aug 2024 00:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 1/1] net: dsa: mv88e6xxx: Fix out-of-bound access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172419843617.1275153.920131046855794024.git-patchwork-notify@kernel.org>
Date: Wed, 21 Aug 2024 00:00:36 +0000
References: <20240819235251.1331763-1-Joseph.Huang@garmin.com>
In-Reply-To: <20240819235251.1331763-1-Joseph.Huang@garmin.com>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Aug 2024 19:52:50 -0400 you wrote:
> If an ATU violation was caused by a CPU Load operation, the SPID could
> be larger than DSA_MAX_PORTS (the size of mv88e6xxx_chip.ports[] array).
> 
> Fixes: 75c05a74e745 ("net: dsa: mv88e6xxx: Fix counting of ATU violations")
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
> v1: https://lore.kernel.org/lkml/20240819222641.1292308-1-Joseph.Huang@garmin.com/
> v2: Use ARRAY_SIZE instead of hard-coded SPID value.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/1] net: dsa: mv88e6xxx: Fix out-of-bound access
    https://git.kernel.org/netdev/net/c/528876d867a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



