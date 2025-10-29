Return-Path: <netdev+bounces-233737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0FBC17DB9
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28173AF62D
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38581EEA55;
	Wed, 29 Oct 2025 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KERYJLS8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1DE2DC76A
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700847; cv=none; b=OIgn8TMRyfvtC8nsfZxYLakvuTLVjyUyS6FxAcyLuoHHfCXh+gzrjhaBUvwdq9s6MniWk71qp8sJhw4HoFiMcc+9LWhNEHrNO/kL98gwNh/j58uFuzcb5/5ASPwlID4oIK0H/m/Sbg9YEcIB7hV3s+FmkWFeAKcwSfOnIhqeUMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700847; c=relaxed/simple;
	bh=4PgOq90aC0TH/w6I2pK+7y3unti8WUBKlKAyt3ZUNiU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GJTCRWjqWW7/UyPNG4jBYwm6ec1Aqitcl6mmYKZFUIvuW7yRMDcLS/9E7piCCK5lGoSUkOFq0U6jZ1hDMoayBm6U8y+548CR+QrlL71IYoUGNEjZJx1fU46If97UXhbD5sVYk6dMXWaeOpFKR8DPp5wi5OIpzIBeLFnzujsqcXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KERYJLS8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CCFC4CEE7;
	Wed, 29 Oct 2025 01:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700847;
	bh=4PgOq90aC0TH/w6I2pK+7y3unti8WUBKlKAyt3ZUNiU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KERYJLS8EgVpk6I+muSNxS2EfqOKMN+5Imzy/cnFE551MQHdRWvYj8pxxc0ZGQ88s
	 1DuD7p5m0Ilow/NK4oxmGknIiauIgbrFIlLSKLd/KjaWSdDSg0QHyXkohk85oWynRC
	 X+f7V2kEx+MSp/Xy+pU5gg4fdd17esJTGxkfPF6r2wrEhPsF6ENZKlfnfl2v/m9m7d
	 41djzR1+W53Piu6ndUHrOurX3En5eWQqJ7DRqCNbZrSarxS6/9L86Hgs4dVaUJcpHm
	 DBvt4cxYPncdqw5VCb+ediHRSVYTdaDcWwQpaVhhYp39NDCt5tKMRJbe6Hd+0MiVoY
	 gc81mqHR5Vphw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD9639FEB6D;
	Wed, 29 Oct 2025 01:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: rps: softnet_data reorg to make
 enqueue_to_backlog() fast
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176170082449.2452213.5683780364535363411.git-patchwork-notify@kernel.org>
Date: Wed, 29 Oct 2025 01:20:24 +0000
References: <20251024091240.3292546-1-edumazet@google.com>
In-Reply-To: <20251024091240.3292546-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Oct 2025 09:12:40 +0000 you wrote:
> enqueue_to_backlog() is showing up in kernel profiles on hosts
> with many cores, when RFS/RPS is used.
> 
> The following softnet_data fields need to be updated:
> 
> - input_queue_tail
> - input_pkt_queue (next, prev, qlen, lock)
> - backlog.state (if input_pkt_queue was empty)
> 
> [...]

Here is the summary with links:
  - [net-next] net: rps: softnet_data reorg to make enqueue_to_backlog() fast
    https://git.kernel.org/netdev/net-next/c/c72568c21b97

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



