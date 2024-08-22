Return-Path: <netdev+bounces-120767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 015C495A8FA
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 02:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349C31C21BCC
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 00:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF15E4C74;
	Thu, 22 Aug 2024 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlD1GcE0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA51C1D12E0
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724287232; cv=none; b=OgJFiPVqPgo8quv5U4j15KYyzC6/TK1yhc3vnkimkPMkR1yo7UrdwPLDVEJpxyKFL5cCiJ8s3gg0frM1V3y2fPtE5kliwpBtua14T8nkm16M058DSi5IKGnAgnabCwI8uw6RrKO4rWbLG0NGbkk/bs4zvATBZMHAObLo4A5fWwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724287232; c=relaxed/simple;
	bh=VzDl4n8YK3ikZwn4zNB8XpOZL+ibht3ScqKd5kLTScE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dDPEzQwyZixULUrlbhbLBlLKjPHrGPsVbQgigXcYSWXD5F6uFJEej4rbNaFT59uPStklMqTRWSuAkaBEurBwLcXgJrU7fiTAuDUqtBYTVWtUc4wz4NMemwh652fR7RyShPAyOwrJaxW7oD5ZSnhcxhPPk0MT4P8ZxAed4aHrONw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlD1GcE0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23000C32781;
	Thu, 22 Aug 2024 00:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724287232;
	bh=VzDl4n8YK3ikZwn4zNB8XpOZL+ibht3ScqKd5kLTScE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XlD1GcE0xb4I8ysbmkY6HBuf51q3qbgMT6+pDtlKyb94UIpTgcv9XUAf/F/RDNgoe
	 AGoRHTkbms8OZg3YaeUK+KBC4fILRavFfYsWSFwVUq0+apeuImPS422RTW++X8OzGR
	 r8X+UleMok6Xy8Ort535mXEC7mwurD+0a6CsSsv7u3fIl30jznCCeFdMb8MCLzRbCI
	 P1UZ2RFBVIdpEs2J6AmLySMBzBYDancnfc4+pGvJwdTdSdfgv9O0g6cX2hieCS+wRI
	 m6LwANk93pAbsxG/DFsIxDbNGsIi+4/BU+xAcxToE73vT2dtCCGFE5B8pXdrU2evk3
	 1VwKd+sMNS1jg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEEB3804CAB;
	Thu, 22 Aug 2024 00:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/3] ipv6: fix possible UAF in output paths
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172428723176.1872412.5018355084822439757.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 00:40:31 +0000
References: <20240820160859.3786976-1-edumazet@google.com>
In-Reply-To: <20240820160859.3786976-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Aug 2024 16:08:56 +0000 you wrote:
> First patch fixes an issue spotted by syzbot, and the two
> other patches fix error paths after skb_expand_head()
> adoption.
> 
> v2: addressed David Ahern feedback on the third patch.
> 
> Eric Dumazet (3):
>   ipv6: prevent UAF in ip6_send_skb()
>   ipv6: fix possible UAF in ip6_finish_output2()
>   ipv6: prevent possible UAF in ip6_xmit()
> 
> [...]

Here is the summary with links:
  - [v2,net,1/3] ipv6: prevent UAF in ip6_send_skb()
    https://git.kernel.org/netdev/net/c/faa389b2fbaa
  - [v2,net,2/3] ipv6: fix possible UAF in ip6_finish_output2()
    https://git.kernel.org/netdev/net/c/da273b377ae0
  - [v2,net,3/3] ipv6: prevent possible UAF in ip6_xmit()
    https://git.kernel.org/netdev/net/c/2d5ff7e339d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



