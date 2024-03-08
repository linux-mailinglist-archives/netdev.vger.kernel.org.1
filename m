Return-Path: <netdev+bounces-78847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D5F876C54
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 22:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9504B1F21EED
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 21:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D14F5FB81;
	Fri,  8 Mar 2024 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3PpnPy2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDEA5F578
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709932836; cv=none; b=as/qyJFCRen9ERvCUcKSB2HJON/dKrVFp5PmQdCivxS3tQKyXDVBkh8u7volxLpFfmmP4eiJujYktMPpXgz5vxAz1abPgbiUgVGlvfGulr5WD5GJZIw2/MfPhRzjLEnCd2aP5CRQFFXxnjpDPsv3m+eGcKKvAB++92nI1y06t/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709932836; c=relaxed/simple;
	bh=mgpj47l9dP6rOPTZFmS78m0X7C+1L9KTxI3SUtfsw8Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dVyZYkRl5wFOl8kJJwNsf/dT3ogo3O/44wpCkTGoxXBXNPs+fXGmwxPSdNBXCslUAIAPM39jMu+XJYbcsGNFwlhIhJ2GwhXJmFxK3WfIP3XH7yZDwfgVD/tPBgWVCdA8ja1IlHzDTaIqHr2MVLza+ypU/FO/uiGi2bAZk8inKbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3PpnPy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91710C43390;
	Fri,  8 Mar 2024 21:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709932835;
	bh=mgpj47l9dP6rOPTZFmS78m0X7C+1L9KTxI3SUtfsw8Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l3PpnPy20tojD5mIzvVoOasL3kzv15llMAktAfGN/hE6P8OAHgLI1FRVMX9n6ClLb
	 UYduQ6A3j7R0izQJWj4/7+pFmTPD4CBRbRLdGSttsiAHr/6TqAKsxgHCau7fYs1QI1
	 VQ/WMQKcMgIJUz8C13jvjq4mDAPGcHPHb4/TH2Tp24Ojxysz17AMGe0uHBOIwjBg0b
	 Q0ODNDUKptn6+VogCaflEVjPH1UQ/bqFbauB1ToGnJKjmIETx9PKnkJfWqCKzqa2ns
	 bobTMCSpNsosPMwfb1pmBrPHLia0GN72mvw8RIgGZuQokKKlA/HcxceAI6KoDSQ0Vj
	 C1iw7ZSqCz5hA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FBA6D84BDA;
	Fri,  8 Mar 2024 21:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: raw: check sk->sk_rcvbuf earlier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170993283545.29743.10069195737602380066.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 21:20:35 +0000
References: <20240307162943.2523817-1-edumazet@google.com>
In-Reply-To: <20240307162943.2523817-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Mar 2024 16:29:43 +0000 you wrote:
> There is no point cloning an skb and having to free the clone
> if the receive queue of the raw socket is full.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/raw.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Here is the summary with links:
  - [net-next] ipv6: raw: check sk->sk_rcvbuf earlier
    https://git.kernel.org/netdev/net-next/c/026763ece881

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



