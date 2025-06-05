Return-Path: <netdev+bounces-195286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC487ACF2F3
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 17:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 491357A732C
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995AD1DE2BD;
	Thu,  5 Jun 2025 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nei8dTbo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8591DDC23;
	Thu,  5 Jun 2025 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136807; cv=none; b=hPzSh42hQE3VFomhZGsVTEoy7VaoTgcDrvtuJsr6BX6EI64PicCrAd/HP9+muf2HJdBFaNnxtwOTWkUyBlz577wfK6j/8OKbGbR2Pjp8lUjiEphwr/zCfgCFVVgmnTeaQipJPHWhKQ45yQmg0w9OslERbR5Qx9mC5xIpmHtPOhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136807; c=relaxed/simple;
	bh=y2ZoYLNATdkxiwgHJxpQupkknJu/71YCQZM7Ii78/ys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nG2Zag/7SaI8+3jQsH/a8Aq/2u4OCdCcsejxiinwE6h8Ghl5EngNOh11wjVpFrQOGWrbysO+sUDmhjURCx18FOxpaZ24ZNF21GdID/CPGXE1zA//J7urDUhwznKIsb9RdhmufC50ZpFNL6N5cOIzBZ50WeBfzLgNvgL10jHmPvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nei8dTbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436C6C4CEEF;
	Thu,  5 Jun 2025 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749136807;
	bh=y2ZoYLNATdkxiwgHJxpQupkknJu/71YCQZM7Ii78/ys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nei8dTbonhUVBKVGug/xIzO4h66ywvQhbS0GIsWHMriqDzETE00Mtu6wNcap1JS+L
	 +cVQwHNy7F0EENa4I22YcAzCmpTvQInm5c7xs8nxhM2RSiYkHTsfG45C3O5dhaBCnE
	 9sCApyXU0NFbWY4N/SDyDNEhH8fmgutMumfMCpyGMHxHK+CKGZsRvMLAPAY6wi4fGx
	 CMGNjDCVJn84xUDdC40Sv6Y88Uz7fZmgxPsh+MY9WrDIY313e2iHd9/z0zsQwlDKIH
	 +4wl136uX2CL+P0BVFS5NjJ/sAp+rZRMqqI6vkVdjFOdlCOeGDXL17thKfgNRFfr96
	 9MJzSxpdi9GFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6F33038111D8;
	Thu,  5 Jun 2025 15:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] calipso: unlock rcu before returning -EAFNOSUPPORT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174913683899.3113343.10718879432138633150.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 15:20:38 +0000
References: <20250604133826.1667664-1-edumazet@google.com>
In-Reply-To: <20250604133826.1667664-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 kuniyu@amazon.com, paul@paul-moore.com, linux-security-module@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Jun 2025 13:38:26 +0000 you wrote:
> syzbot reported that a recent patch forgot to unlock rcu
> in the error path.
> 
> Adopt the convention that netlbl_conn_setattr() is already using.
> 
> Fixes: 6e9f2df1c550 ("calipso: Don't call calipso functions for AF_INET sk.")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Cc: linux-security-module@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net] calipso: unlock rcu before returning -EAFNOSUPPORT
    https://git.kernel.org/netdev/net/c/3cae906e1a61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



