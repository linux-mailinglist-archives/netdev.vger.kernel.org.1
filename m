Return-Path: <netdev+bounces-100544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D158FB0F2
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42AF81F230F3
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2F7144D3A;
	Tue,  4 Jun 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/Ct0UOp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F831420D7
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717500028; cv=none; b=j0+OB3xJUHqASJrWo6CWZVxmSXmBUMFyWZfdV66xvYu7USb25A9plwqll4LcLo5Rdsrv9NlLtTe7r42XGyDqPIWyynTGrBNEpMi1Nj6FodM4UJ1qz/tHV27mtADjv0mN5XejWmU8VdQB7S0bauUk5y8GpTZKoXVvamjjaiiLg2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717500028; c=relaxed/simple;
	bh=cIkgOPBPBXV0L09HZ0nfqkUPKEBCVUQiwvDhIWbcvAU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jtaQT1Yy+/INXia0d3/+Ig9DbdV6O69xe4/MEqUJX9oODpMyhnC6ypOUZhhivksMWZsTPXf5D1yaY4Aqa/hMc4mxgiDnBCVfWpE104b1isjM3W+EPD1tn2kJxbQQjxfx18VMXcq7obVu9zoLvXZ6P7gy5dYCOWz4QK5Xpc23i+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/Ct0UOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66BCBC4AF07;
	Tue,  4 Jun 2024 11:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717500028;
	bh=cIkgOPBPBXV0L09HZ0nfqkUPKEBCVUQiwvDhIWbcvAU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C/Ct0UOpmmBNSwC025zk4qTwX8RugFZIynzlxdP5TgMD5MMV1qhH8nMMUy+ijRf5a
	 ZOjyUrvFa7DcbC0ECB0pvl1S94A079kEFRJ1qr59Wbtgq2vq5Zl8FJUquUUHZYKPhF
	 5UJE/JpUvDDDVXGD6bfDq97ghw+IdAqU5NTKfFIDmkNXy25IbLUVWlwibV/R4fb45p
	 wfwpILPeXavYnewT7dgZSjr3oI9iQ2InRgL32fAGJ4eac5RUq2+HvOWVLSjVaA6Vkt
	 ztpIiieKK9ZKeQq18+IKhZW4PONeI1fOGKlZDqZD/0PyeT7+aS/PsVy1968jvS2bNr
	 3jLdoSl5Mf1lA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 556D8DEFB90;
	Tue,  4 Jun 2024 11:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: tls: fix marking packets as decrypted
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171750002834.2984.5798468091342409300.git-patchwork-notify@kernel.org>
Date: Tue, 04 Jun 2024 11:20:28 +0000
References: <20240530232607.82686-1-kuba@kernel.org>
In-Reply-To: <20240530232607.82686-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, sd@queasysnail.net, dhowells@redhat.com,
 borisp@nvidia.com, john.fastabend@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 30 May 2024 16:26:07 -0700 you wrote:
> For TLS offload we mark packets with skb->decrypted to make sure
> they don't escape the host without getting encrypted first.
> The crypto state lives in the socket, so it may get detached
> by a call to skb_orphan(). As a safety check - the egress path
> drops all packets with skb->decrypted and no "crypto-safe" socket.
> 
> The skb marking was added to sendpage only (and not sendmsg),
> because tls_device injected data into the TCP stack using sendpage.
> This special case was missed when sendpage got folded into sendmsg.
> 
> [...]

Here is the summary with links:
  - [net] net: tls: fix marking packets as decrypted
    https://git.kernel.org/netdev/net/c/a535d5943237

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



