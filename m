Return-Path: <netdev+bounces-122049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 740AD95FB43
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 23:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F296AB22C7F
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 21:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913EB13B58F;
	Mon, 26 Aug 2024 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQLHXrln"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C214881E
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 21:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706626; cv=none; b=LEtg44/wLrB/PafjtOZdzBqv53JRVSBo8k2pxO/yVYu3GjMPNfl0kZ2288tVUu8BnmmWJ+TJe2GMbZecHAb7Q9BA16nf7QR8R6Ix3XkO1LbsxPKBQ5fOss+v/fZ7QUWEaMzJtyW7MrVky5Fh4HDHHavbBoYxZ+naHpiapjQG0fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706626; c=relaxed/simple;
	bh=G5j9fxZb1dK5dEETYx05cTaAYBT01g/NYCR3IiIUBZU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F2pFpM+qnl3sttOPQlHoU0UH9IlP2DcRATfZjGVKQVgc1JNr6GZScV8qevpj+JP4fx57tc/sqFm9sk2Rg4x4llCzcKw26A66ipSBBB30jvxBtuaiW0fIDhKOO3NibZWjIRdv723+JIM81P6ZS8ARz+vT+6alx8BCCh26GYHE7ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQLHXrln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3449C8B7A3;
	Mon, 26 Aug 2024 21:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724706625;
	bh=G5j9fxZb1dK5dEETYx05cTaAYBT01g/NYCR3IiIUBZU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lQLHXrlnhRuC6RWxZOMo3bkXO8ZhZDuF+AfhD83ygGvTTp/fy3LMxSTFfog6kGAKX
	 MnS/9KUTiRg6UQo1h9Yf6SFpPqPxCPw4KMFnX0lT4rv1GQnz5YaOqKeOdk0SoLanfv
	 5dbQj0wLh4n5hNREM2F9VpGWRqFpi6jC5wOEsB/AAwlkNFc95aNH9QFt5Z8DbvRN+D
	 K1sfhqLYA8C6vsZ/Jj4P2XzbH17df3iGtb2e35UXDnsHmICHfCIZr6sh+Worw+CLQi
	 ONyNeNAWqbwo7tn0FzmrWJ0lTvrvYMzZvcKK2jMQrTXJaLPPqCQfrLucoFYOHTXSOK
	 Uu7pHCn/hEB6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B7E3806651;
	Mon, 26 Aug 2024 21:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next] tcp: avoid reusing FIN_WAIT2 when trying to find
 port in connect() process
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172470662501.127664.3509173405619700960.git-patchwork-notify@kernel.org>
Date: Mon, 26 Aug 2024 21:10:25 +0000
References: <20240823001152.31004-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240823001152.31004-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, kuniyu@amazon.com,
 netdev@vger.kernel.org, kernelxing@tencent.com, jadedong@tencent.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Aug 2024 08:11:52 +0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> We found that one close-wait socket was reset by the other side
> due to a new connection reusing the same port which is beyond our
> expectation, so we have to investigate the underlying reason.
> 
> The following experiment is conducted in the test environment. We
> limit the port range from 40000 to 40010 and delay the time to close()
> after receiving a fin from the active close side, which can help us
> easily reproduce like what happened in production.
> 
> [...]

Here is the summary with links:
  - [v4,net-next] tcp: avoid reusing FIN_WAIT2 when trying to find port in connect() process
    https://git.kernel.org/netdev/net-next/c/0d9e5df4a257

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



