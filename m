Return-Path: <netdev+bounces-125294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758CC96CADD
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 01:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A51C1F253DD
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 23:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCD714A4E0;
	Wed,  4 Sep 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVhzZZaL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F4947F4D
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493232; cv=none; b=A1NAcck1SuPlwcatOTDcbMkFrokNywWU9+vJH7zQvmzywF4BSlVoNFTcVVkbRkUqkHL7rt6vVltVWCqFtKon+CPhosY4NwG68I3YuQq985w6NulF5JrGoZRQP7ctO9lJnDCqVShAwvfFAvmfm/+s63OfDVcDiWRDNQZHbjCpXIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493232; c=relaxed/simple;
	bh=ksWMw12cVsor6F4dwVJAW0xjPNdGthh8IwQMxz7qlas=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l6m1a8P+6oLDjHPoA4rcQ0lUm1xzkiuPHSJ3dCVznyLPxOsJzGkUuKriSNgXQ7xF0WW7dSmE1T1XpSvlA69EeLtwNZpKPz6buaPSjJCBxDefjfVrK4HOyQGEqxdTK1PU+NIBCi20CdvbALuyWQ8oFMHEK6MSNMGsgrCU8bbUwaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVhzZZaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D92C4CEC2;
	Wed,  4 Sep 2024 23:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725493232;
	bh=ksWMw12cVsor6F4dwVJAW0xjPNdGthh8IwQMxz7qlas=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tVhzZZaLw4S6HdM/VTbv7NYBUMToi4qSkEfzbEhsjuBAOI2k1t2Ss1y5oC5vL4B9W
	 JpZo1cZBqha0cxOT9jiAGhlaUhUCV0vAQkIAdPlrNy2FXfympiOY//lpA9fSrSKAfg
	 9VUFRjvY88pryXbh+99iHfx4ZBxfOnQOTdES1r4pFWSxkotUd/xTv9NJmShCqNMDuU
	 VsY57/fEwYZYhD94EbEjzeGoUAfZhZ0AYQPdVnuF6aCWVrUTv5J0KZBd5e8YS60S/j
	 jDUYyvhTPLoxpX5yj4IWhgztYTKTH89QTNJbpu2i+/UhFfDQQLKjrb8+3tUeNejLc+
	 NsY9jXFt/hcKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 349283822D30;
	Wed,  4 Sep 2024 23:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] fou: Fix null-ptr-deref in GRO.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172549323302.1198891.1143973524818862490.git-patchwork-notify@kernel.org>
Date: Wed, 04 Sep 2024 23:40:33 +0000
References: <20240902173927.62706-1-kuniyu@amazon.com>
In-Reply-To: <20240902173927.62706-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, tom@herbertland.com,
 kuni1840@gmail.com, netdev@vger.kernel.org, alkurian@amazon.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 2 Sep 2024 10:39:27 -0700 you wrote:
> We observed a null-ptr-deref in fou_gro_receive() while shutting down
> a host.  [0]
> 
> The NULL pointer is sk->sk_user_data, and the offset 8 is of protocol
> in struct fou.
> 
> When fou_release() is called due to netns dismantle or explicit tunnel
> teardown, udp_tunnel_sock_release() sets NULL to sk->sk_user_data.
> Then, the tunnel socket is destroyed after a single RCU grace period.
> 
> [...]

Here is the summary with links:
  - [v2,net] fou: Fix null-ptr-deref in GRO.
    https://git.kernel.org/netdev/net/c/7e4196935069

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



