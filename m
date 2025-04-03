Return-Path: <netdev+bounces-179211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEB9A7B236
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 01:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B016D189B89B
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA321C6FE4;
	Thu,  3 Apr 2025 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8gL8VkO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B161A5BB3
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743721796; cv=none; b=bF6eJ6UfIeV750/TF7l/QqVG8ivKZlfJNMb5wsfIj353u8V4HLrsurTSb0MgfSKTYQW1PnlQ6+PQp39nYC433uX5D8qYjcjLTfTy2OLSPIOtLC+TseXMRJmAtPF6c+31qfSIMNxmYSw8hXR0iPTs4CH7ACvSFkU40eZxj1R9pdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743721796; c=relaxed/simple;
	bh=uDMpjrtIqi4ZTyAcVqd7QR6qEdd/pgZ+9jsRVaoQnLQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GhmdLiXAIkqex8QapUbd50u2MKdm9fSe/OkV64asSq4c7euP6fcVnWpoQGYHUVtxYiANZ7qFM8NmqCNTW0Ce0o4KZ6TUKW1pYku4F4b8pFlxFNzRT/BYHFILiQLgAB7qSAZOs0+MbRt9GxK6TDR4OHDo1RbbdNGGul8Ve9GPbKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8gL8VkO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C121C4CEE9;
	Thu,  3 Apr 2025 23:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743721796;
	bh=uDMpjrtIqi4ZTyAcVqd7QR6qEdd/pgZ+9jsRVaoQnLQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M8gL8VkOBzwhg0B3YNUIrceNOWxWKn9im4p+AlFvmKp6HmVldkUVU2hwhtUkx5J7w
	 uSQLtDnUQeA5DvOv4rZCSp0QzJG7+8yREkRrJ1cDD/O1rgEq10oSprXtqxDG0S7qXK
	 XDBOD9JxtcA7CHF96femlFW16lDy53MjLrRDyAIuEN1N6JIspyEf8HpM4gn+X9Hwqd
	 W+CtAK/uJRnx/wSulrWhW+pXNwR8IJyKiJv1GiYK2FSbe4AACHGISoMB2wnAAzTyS+
	 QedTX3ussUchRBlfUzh3+6Gc9NNhwpIk7Txy2QEnwOVbZcLG9JN309sV6QWqIzLFx2
	 BK4xF0UZrI6tQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E3D380664C;
	Thu,  3 Apr 2025 23:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fix geneve_opt length integer overflow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174372183324.2713510.1369193781290801733.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 23:10:33 +0000
References: <20250402165632.6958-1-linma@zju.edu.cn>
In-Reply-To: <20250402165632.6958-1-linma@zju.edu.cn>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, pablo@netfilter.org,
 kadlec@netfilter.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, lucien.xin@gmail.com, pieter.jansenvanvuuren@netronome.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Apr 2025 00:56:32 +0800 you wrote:
> struct geneve_opt uses 5 bit length for each single option, which
> means every vary size option should be smaller than 128 bytes.
> 
> However, all current related Netlink policies cannot promise this
> length condition and the attacker can exploit a exact 128-byte size
> option to *fake* a zero length option and confuse the parsing logic,
> further achieve heap out-of-bounds read.
> 
> [...]

Here is the summary with links:
  - [net] net: fix geneve_opt length integer overflow
    https://git.kernel.org/netdev/net/c/b27055a08ad4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



