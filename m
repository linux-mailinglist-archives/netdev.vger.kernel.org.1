Return-Path: <netdev+bounces-176420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB15A6A325
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 11:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A8D8A68D9
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 10:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB93224885;
	Thu, 20 Mar 2025 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7xCSoK+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA5122425B;
	Thu, 20 Mar 2025 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742464798; cv=none; b=hYH7UgOCb+jZGq62ox3lBIPP+5wXfayWmQz+Wt1/sZIwdahPJRgy7vUmB4kEw5DXOqBjJXRM/qLQkd/elADvgAbS2T8IBDv2Hu09HWSmthiCT4vOj+/kcz9uekd7Kc1jQ1oxJWe8Un6/wuMHERvIgqvjXAdfkqwhpOTdV9WMaHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742464798; c=relaxed/simple;
	bh=JHVPGjbrK99QJOWfsmyy8xMj7QmPUXBvpiMALzqWhIY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q8Im5EFuTaFj7ZfQ7MPBEWexR+g6UIOx6lduFsQ/dVu5EeNfmUTe4tOnPEpvqW/iuXYfqcgVZtbV1eMQOkjxPpq93eaUXh36yDxcR3tsdxEgnATw5M3i3YNBdHY/ggWctV1GP/Ktn4hIbmMq4u83iMRiw36vCOHY29Hr/ZT3wjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7xCSoK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6A7C4CEE8;
	Thu, 20 Mar 2025 09:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742464797;
	bh=JHVPGjbrK99QJOWfsmyy8xMj7QmPUXBvpiMALzqWhIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S7xCSoK+SKBqe+ug07/ECujXSW3vvgvduMfZ6ZwlgbWKzJaCseyW7eqGsELOq7xVY
	 vRf7ZB+zyIJmEZxxJ4sYJ+PiHnCt6COK6uuZNwTcqcnvb3ZrnEE35/e3Swp3JEs/Kc
	 R0+MVtSJg96namWwECGei9E3K/rVeSzp2if+hLjyWqtUQeQhjL5GpDTkAXUY7tFmu0
	 jtoGVzSSR4rjleWI0YygW/wQFLZZ0D5oMQkNZMudcUiZpt36SmKrFSq6id0av3YID5
	 ErlagU2x5DTDLJ9vE1MWSfxeWEJgaCQu3xzJPrZ3ahraAlYNkvwj60PfRJxq7oNHY3
	 3I+L4HKSU+HfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 728653806654;
	Thu, 20 Mar 2025 10:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: atm: fix use after free in lec_send()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174246483327.1379185.13947915144750276532.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 10:00:33 +0000
References: <c751531d-4af4-42fe-affe-6104b34b791d@stanley.mountain>
In-Reply-To: <c751531d-4af4-42fe-affe-6104b34b791d@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Mar 2025 13:10:57 +0300 you wrote:
> The ->send() operation frees skb so save the length before calling
> ->send() to avoid a use after free.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  net/atm/lec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net] net: atm: fix use after free in lec_send()
    https://git.kernel.org/netdev/net/c/f3009d0d6ab7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



