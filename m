Return-Path: <netdev+bounces-225460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13695B93CA5
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 03:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FCE41901F1F
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 01:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FFA14C5B0;
	Tue, 23 Sep 2025 01:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8JgcCZ+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8B7A932
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 01:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758589818; cv=none; b=sfyQhgP7eTOzk8wndtyCHfKdBDLRIWBYoSCvF7BHS4lrsUC44qSZFsFThQiczir/+RVvOR0XzCVsAMbns7k69mGkyPvioSX0G9i5PfyFJFHGq0DezwFJYG2U+AeCwMWVgoJMQVziIjnJmvK1K8rqjCoiuT4x2LhOAAaxG5watDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758589818; c=relaxed/simple;
	bh=PN84DbJ7IGPdc2PEmDevngWdFiYBFFE9zdlMLKcv1w0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r5YE7PjwRecy00dTKoIVjOXnOBf6/a+pHUnKjechX8iI4IWhqdxmp9a+iQ437xig8nA/9jh64tzdrChIqoO2iBs/wJRunwucv2bzT02lOiROZcYNu2HRHhP/fKpDvE/JFvs9tJ2E0N2D7FhkF5WNwDTSF4skSTyN8IIGe7xxBGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8JgcCZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F431C4CEF0;
	Tue, 23 Sep 2025 01:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758589818;
	bh=PN84DbJ7IGPdc2PEmDevngWdFiYBFFE9zdlMLKcv1w0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R8JgcCZ+lATLbJLt5easU+nrB5Pt8qEEqdf3fLQWlqZ5vTZvn6tf+4UJo6uDPb0wU
	 Q+C1qtFEYgVOBSKuNHk01jVstOkNu/DNICtdvFP+FmPxLs/dxGKX+sE55uAtJHHSRW
	 i8rbsYxy1Z3wZo/0T16jPkijyPqvZRTHdND6DIQ7rEmLzmYiOM1YrqzQbYBZ6vTlD+
	 ZGj3fiE/yLya2060CS3DB2tfDDsqVgG/GW0lWCx8QjWmYYPRzUegOkUBfOHpO2+kuI
	 JTLIMj1+hnmnICAjaBRGA8AnTCHA1iNn+Ae37u8Lr+Pvu+VijObDiFEL2eIHsvhSZQ
	 HShmZ+ZqF/zCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACBE39D0C20;
	Tue, 23 Sep 2025 01:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/8] tcp: move few fields for data locality
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175858981575.1215353.10545225007396760049.git-patchwork-notify@kernel.org>
Date: Tue, 23 Sep 2025 01:10:15 +0000
References: <20250919204856.2977245-1-edumazet@google.com>
In-Reply-To: <20250919204856.2977245-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, willemb@google.com, kuniyu@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Sep 2025 20:48:48 +0000 you wrote:
> After recent additions (PSP and AccECN) I wanted to make another
> round on fields locations to increase data locality.
> 
> This series manages to shrink TCP and TCPv6 objects by 128 bytes,
> but more importantly should reduce number of touched cache lines
> in TCP fast paths.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/8] net: move sk_uid and sk_protocol to sock_read_tx
    https://git.kernel.org/netdev/net-next/c/17b14d235f58
  - [v2,net-next,2/8] net: move sk->sk_err_soft and sk->sk_sndbuf
    https://git.kernel.org/netdev/net-next/c/9303c3ced111
  - [v2,net-next,3/8] tcp: remove CACHELINE_ASSERT_GROUP_SIZE() uses
    https://git.kernel.org/netdev/net-next/c/e1b022c2bdf1
  - [v2,net-next,4/8] tcp: move tcp->rcv_tstamp to tcp_sock_write_txrx group
    https://git.kernel.org/netdev/net-next/c/1b44d700023e
  - [v2,net-next,5/8] tcp: move recvmsg_inq to tcp_sock_read_txrx
    https://git.kernel.org/netdev/net-next/c/969904dcd77d
  - [v2,net-next,6/8] tcp: move tcp_clean_acked to tcp_sock_read_tx group
    https://git.kernel.org/netdev/net-next/c/a105ea47a4e8
  - [v2,net-next,7/8] tcp: move mtu_info to remove two 32bit holes
    https://git.kernel.org/netdev/net-next/c/31c4511bbb0c
  - [v2,net-next,8/8] tcp: reclaim 8 bytes in struct request_sock_queue
    https://git.kernel.org/netdev/net-next/c/649091ef597b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



