Return-Path: <netdev+bounces-102774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7D5904902
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 04:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A39B1C21750
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 02:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDCDB65F;
	Wed, 12 Jun 2024 02:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKWIx0A8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE945244;
	Wed, 12 Jun 2024 02:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718159431; cv=none; b=AjTAiPHfVdyAvSYbr/ZJNhjvVi9NQ4lO5nTILcYMUZ441xP0ZK5G7ie10kAD/yJAdJESJefzxtIDVgVScieaG+5ntchLcdvGKNeiPgeZOKh9DXmfz9l8d0Q0UqXzPJUB0SnkDmahYfucnANFqukFF0lr7RPww9zIEWSBVSOwjnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718159431; c=relaxed/simple;
	bh=ymZIzggPzpPdbd4eu9RGzGKeWRgxnwghFicO76JSJUk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sjoy72AkR2PlGSG72vpKYz8ArzjBAq62Z91K83gZtu4Z9oVle/opeK2x0aklT9tnZ1Bndg1IJ25sj4EnxXOPjFQzBEGyvKFHxizNJOxFL2wcDkqEMc9g6ynoNW4/gVwDTZzoBdRxZwN5SRrXUvD45mh5sSHqzHPxh2dhvo2bw3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKWIx0A8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29173C4AF1C;
	Wed, 12 Jun 2024 02:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718159430;
	bh=ymZIzggPzpPdbd4eu9RGzGKeWRgxnwghFicO76JSJUk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VKWIx0A8J8yq0EG5NmAkW+azZDhnQ9WsASLSdbtKhUmPyCtFHYy6x6a5fjpYLMx3+
	 FMIX54NOyc8dwYMCLv0sfj/KymSFW6oJfN2t9nByOMj0Iz1w0JL9VczpKwxjOdtNfz
	 b3rs57OM7uHWEDihq007h5vE5hlJ5eDTCJFLqoOHQ5oMmTka0J4hDbGZ4hSqswfami
	 9IsQ6Cwdnud/divCAmJlgFZrgSvhURTnc1b3/2+86LkjkG9jN6mpqIqPxhBRIimqNG
	 HCkgreRnmKyKWVFJHWfgjw2Dbn+eg+KKeje8E0TUKsGaEQ79xxYUKjBXU2WSGe+exz
	 xUDNbrbCM4TFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16FA1C54BB2;
	Wed, 12 Jun 2024 02:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ip_tunnel: Move stats allocation to core
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171815943009.29023.2489778135306981095.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 02:30:30 +0000
References: <20240607084420.3932875-1-leitao@debian.org>
In-Reply-To: <20240607084420.3932875-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
 sbhatta@marvell.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Jun 2024 01:44:19 -0700 you wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core instead
> of this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> [...]

Here is the summary with links:
  - [net-next] ip_tunnel: Move stats allocation to core
    https://git.kernel.org/netdev/net-next/c/45403b12c29c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



