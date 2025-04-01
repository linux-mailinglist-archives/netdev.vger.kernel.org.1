Return-Path: <netdev+bounces-178470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D1AA771AE
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 02:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E703AB763
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 00:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF5328E0F;
	Tue,  1 Apr 2025 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRBNqk/D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B678249EB
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743466212; cv=none; b=F5t19RdulTPJmS2k2LOVA3yXp+CkbvYlevPALAauZ9o8JjX4YiiPcMfrshd8q5lQAR8Srs2FIIDUCfJCTq28KheICElEWCj2AdM8PewLZKTED0s5wwA3tx0QRYoATP6iGvA16BafgfQvZD/vaHHk6wGx3gCG6NEjcOYPaOItSv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743466212; c=relaxed/simple;
	bh=zvRYdZqvpGVZGLE7cTcHQ0HM0oNkaScB++N6pnV8sNw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qV9B9qB3a6JJygXPgQNDVadSj/7wQewQs+PB2ekOaBZy0cBUhxVBUcXroLL3tAz0BLwsgY1JBMLpx+bALIUbuk43sLFNKo/CvHCFqp4L3tm85IfBGoe3s4QFjWc5LZERCf/zdZS+Wwkq0AIK0SSBX+Dr0TcQQKGbxtzzKH470Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRBNqk/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42408C4CEE5;
	Tue,  1 Apr 2025 00:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743466212;
	bh=zvRYdZqvpGVZGLE7cTcHQ0HM0oNkaScB++N6pnV8sNw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cRBNqk/DMcd41cJaaqHgjGW5zkiAyuRvNXaP8IzHWinfnIPDUWoB4AejT3cVbOF3T
	 WVOJ+ImqhP1CTbW4KOHm1lH+S41aSgCzheus5nc2JhuphGyaRqz+Wz8cb5CC3ccaGz
	 sKCZf2+m1SRCZmW+eQW63MS/ObeB/lu2P54Td1nUUyA9Nb0pUXuVYpqDnCA1/ITg/S
	 mZDHz0KXy3wAEK2QiFz4QAkgzpBwkOkEdGxS+/R/Dqu2RHTFz+vgW5Ob6iQBnjV5vJ
	 B7MKYZyaWGVpTZVGWicMegFnvwAa6Net1Uy3GjYI2EiQbEtljEuhyed9zD9nAjyWTK
	 dULcov6GuCD8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D69380AA7A;
	Tue,  1 Apr 2025 00:10:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: gve: add missing netdev locks on reset and shutdown
 paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174346624875.178192.5531320772340432352.git-patchwork-notify@kernel.org>
Date: Tue, 01 Apr 2025 00:10:48 +0000
References: <20250328164742.1268069-1-kuba@kernel.org>
In-Reply-To: <20250328164742.1268069-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jeroendb@google.com, hramamurthy@google.com, pkaligineedi@google.com,
 willemb@google.com, shailend@google.com, joshwash@google.com, sdf@fomichev.me

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Mar 2025 09:47:42 -0700 you wrote:
> All the misc entry points end up calling into either gve_open()
> or gve_close(), they take rtnl_lock today but since the recent
> instance locking changes should also take the instance lock.
> 
> Found by code inspection and untested.
> 
> Fixes: cae03e5bdd9e ("net: hold netdev instance lock during queue operations")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] eth: gve: add missing netdev locks on reset and shutdown paths
    https://git.kernel.org/netdev/net/c/9e3267cf02c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



