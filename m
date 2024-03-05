Return-Path: <netdev+bounces-77417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF7F871BE8
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5BB284E10
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 10:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D490626C7;
	Tue,  5 Mar 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyCOjxaf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3EA626A4
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634629; cv=none; b=L1ideZc/NyhXh7G89x6LI2eEDpsZlOVpC7hwLUmwF2WpnxyuFk2iK+ROzIfvrXYn16bwXvyLEy65j8+Zzx8FIRDWG58px9/MGv+/xuGC9wDDpcmYDRLct4Sry4141zxaGvWQziPdfjmHH3CMSX08/Ve11/Q3S7hs9EZTG/OHswA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634629; c=relaxed/simple;
	bh=SCanNYW4I7VuTdfG3zvshwXYuYCsD2xP2spt58I6ESM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U8VIOKp62vtLlYkPC5fIt44ZIW861YG/v7bMYpi4su5GrD7faruIed0U1OFGp94BHBYxs7yMQl7MiDmrkzRanWXLhPlI1gJ958ieK3W9T1j7XkhGfvIuRsCd1RN6ej/R/NSVG2qYaK5I362vCGskvbBnfQ4Wc7I6QASjadOuv3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyCOjxaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAB9EC43394;
	Tue,  5 Mar 2024 10:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709634628;
	bh=SCanNYW4I7VuTdfG3zvshwXYuYCsD2xP2spt58I6ESM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LyCOjxafSg/awJj961Tde+UZPcBTagb0VHnZ9cETwSVb7H/hQgmLT+zPumV4aMq7p
	 OYg7705mRBwRvZe2r7JAq4tuOIaxGMLg210+0kamT10G0zahdVwHRuMVtOALFsfyF1
	 0ha1AD11AYDKBTHNvJXXf16awjvm2NxyE1xkTXPA1Wax4qKHZrLrxj7Jx0rYpT/I/0
	 GcDy7ZJg8gsCdYUhjVJG5qCr3r6OjxEO4WpoPEU2FdBv/hVcqucpDbkQAL7R687vme
	 TYO5PQ7s9poYehtNjme94b6ffTT63Z/v4B6m+JWuNni7faXo31mifFMIUY1RCrEUOb
	 X62rpygRq9Azg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F878D9A4BB;
	Tue,  5 Mar 2024 10:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] net: txgbe: fix GPIO interrupt blocking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170963462864.18478.3377016857113661016.git-patchwork-notify@kernel.org>
Date: Tue, 05 Mar 2024 10:30:28 +0000
References: <20240301092956.18544-1-jiawenwu@trustnetic.com>
In-Reply-To: <20240301092956.18544-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, horms@kernel.org, andrew@lunn.ch,
 netdev@vger.kernel.org, mengyuanlou@net-swift.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  1 Mar 2024 17:29:55 +0800 you wrote:
> The register of GPIO interrupt status is masked before MAC IRQ
> is enabled. This is because of hardware deficiency. So manually
> clear the interrupt status before using them. Otherwise, GPIO
> interrupts will never be reported again. There is a workaround for
> clearing interrupts to set GPIO EOI in txgbe_up_complete().
> 
> Fixes: aefd013624a1 ("net: txgbe: use irq_domain for interrupt controller")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> [...]

Here is the summary with links:
  - [v3,1/2] net: txgbe: fix GPIO interrupt blocking
    https://git.kernel.org/netdev/net-next/c/b4a2496c17ed
  - [v3,2/2] net: txgbe: fix to clear interrupt status after handling IRQ
    https://git.kernel.org/netdev/net-next/c/0e71862a20d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



