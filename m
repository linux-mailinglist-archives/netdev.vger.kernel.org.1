Return-Path: <netdev+bounces-88301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855308A6A0E
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 14:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D5D1C20D83
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2A9129E94;
	Tue, 16 Apr 2024 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbMakYq3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360A4129E8A
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713268829; cv=none; b=PXATX2rxtR3jrzuT2bgOpTuzxohibtFggGvha8Xjd+dou5feuT94q0VT0pIMbJ/ftROu4j6T+fLG4h5/QReKkxOuUiSGjp/CwlkhNPplUb1dxDXF642cqJ3EvkriAc4eNYVoj3YwSjYZDPMz1BtC27vSWy7mtjptZOD1z3V0DNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713268829; c=relaxed/simple;
	bh=B21NExIxiaAFGziDO4gJ6cOYj/67G0NxNvx7RSnWpm8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TWBbonRNiL6zDB5otleEPORDUW1sf3Qil25sUgHBiQn0sCpVAtPAhU0LIoHOQH8Ca8BMygQ/TQOZyNkcNLsvY4QTSrT2bpV4Cudy/tapBTxecKACqZ3ptCefQIYqc8ItnCwuv792S+gEHTbd8aGYtEVU9VPuvUOqjLdKQ53KQPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbMakYq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5FC2C2BD11;
	Tue, 16 Apr 2024 12:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713268828;
	bh=B21NExIxiaAFGziDO4gJ6cOYj/67G0NxNvx7RSnWpm8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MbMakYq3tr8aP1pVqYKUu/JodVpR0jK0soFjZBiEMx+39Km/bzWwVmTN3ssR7jGin
	 RoM2lwuUgykn40r7hnyV1l7TfDC5Z33DPCzHUngknHRms91cbXu8aZODgLZUkBbY1S
	 b8f7nh1yyUNErLXm6XyhARr4flDUvnuYB85pg79r7ZukvdAfquNvhTxot5EyMEzJbH
	 OrgkhqmzN/YWEm1U1YngJTLiY4KGaI4jQM+PjL3b7UzwFjStFWoeMeQ4M/7Z+5wHfR
	 iz5sDR+PmzQeQ2jh4/nPfnCfVD87MGjrDBEOT2z0UwKtCc6ltAltPYZyYtgn855oID
	 sNaTpz5AftAyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9265DC395EC;
	Tue, 16 Apr 2024 12:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] af_unix: Try not to hold unix_gc_lock during
 accept().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171326882859.28194.17780379532860600908.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 12:00:28 +0000
References: <20240413021928.20946-1-kuniyu@amazon.com>
In-Reply-To: <20240413021928.20946-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 oliver.sang@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 12 Apr 2024 19:19:28 -0700 you wrote:
> Commit dcf70df2048d ("af_unix: Fix up unix_edge.successor for embryo
> socket.") added spin_lock(&unix_gc_lock) in accept() path, and it
> caused regression in a stress test as reported by kernel test robot.
> 
> If the embryo socket is not part of the inflight graph, we need not
> hold the lock.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] af_unix: Try not to hold unix_gc_lock during accept().
    https://git.kernel.org/netdev/net-next/c/fd86344823b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



