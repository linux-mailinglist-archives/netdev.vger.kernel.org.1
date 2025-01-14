Return-Path: <netdev+bounces-158264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6F0A11439
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F243A4BAF
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 22:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2E52135B0;
	Tue, 14 Jan 2025 22:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRnXpfT0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573C81D5142;
	Tue, 14 Jan 2025 22:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736894243; cv=none; b=AmuRl4phvyl6VxxkqGNGTAoqgIgDDVJMyBirE+luT9lRye/QFfKiFvYWUcSSNnp6tSkdps992HjDRDaVQ3oVSCjQ6ta5GULNEsONtp6+aF8e2HV+3OEN+vIZuHVkFgGZ6teEK3w7l3UbOKlfprAj8X8pvKq9VAERkgmNJHTPHLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736894243; c=relaxed/simple;
	bh=yMPYs++stY3gvyXFUbrvXA6cbguqF4Tl9CT1RDVOttc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=assI/do4InTXH5/4ZG6KTwecCnb/eQwQ6kutxSYpMRvanXvAqJz5tKjuo4FoDEMCk8Yzaa/QaQdjWG23ceL5qpqSsY4r/yBWP93TWIqQoA6ugCQArRbaGvYV/ke5KeN+246vjUzgU+xbFh3W8nj6B2rDYhJEFvqZ+g2F+BKJtlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRnXpfT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92676C4CEDD;
	Tue, 14 Jan 2025 22:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736894242;
	bh=yMPYs++stY3gvyXFUbrvXA6cbguqF4Tl9CT1RDVOttc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nRnXpfT0+WTbvfyZdaDROvqgmMdx522sqmOuBXfqZ3tw3MDlROJhJrRd0SmL3l+Wx
	 AyMHTDqYs/cb6y0D09Drhk5LkHF/yXsePT3PX30FKEHM0PJ3D0yTDWBTwTEO/9xXdQ
	 VSS5V3ZA2JNfLO/UjN+qzx8SKVoecXjwpvpBNL+H3VGFPPIkrmrCWRBhL93i/tvwXw
	 UIvcCfOFK5OUEps/jdGeeK8AVT2YowHTxvEhV0HrLOD9Lvbzz5FoKvU/8Z88RR4fhO
	 d8Kv3XgXJUfXTbh+EbE1jbq9F8HtCwZRgsejbx00xarTgjooAiGRSE3cWufkCDRZub
	 fOOyiEWifJ2mg==
Date: Tue, 14 Jan 2025 14:37:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xiangqian Zhang <zhangxiangqian@kylinos.cn>
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com
Subject: Re: [PATCH v2] net: mii: Fix the Speed display when the network
 cable is not connected
Message-ID: <20250114143721.670ee406@kernel.org>
In-Reply-To: <20250111132242.3327654-1-zhangxiangqian@kylinos.cn>
References: <b80d02e7-3eae-4485-bf54-84720dbb6a5d@lunn.ch>
	<20250111132242.3327654-1-zhangxiangqian@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jan 2025 21:22:42 +0800 Xiangqian Zhang wrote:
> Two different models of usb card, the drivers are r8152 and asix. If no
> network cable is connected, Speed = 10Mb/s. This problem is repeated in
> linux 3.10, 4.19, and 5.4. Both drivers call
> mii_ethtool_get_link_ksettings, but the value of cmd->base.speed in this
> function can only be SPEED_1000 or SPEED_100 or SPEED_10.
> When the network cable is not connected, set cmd->base.speed
> =SPEED_UNKNOWN.
> 
> Signed-off-by: Xiangqian Zhang <zhangxiangqian@kylinos.cn>
> ---
>  drivers/net/mii.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/mii.c b/drivers/net/mii.c
> index 22680f47385d..297a0cc3682f 100644
> --- a/drivers/net/mii.c
> +++ b/drivers/net/mii.c
> @@ -213,6 +213,9 @@ void mii_ethtool_get_link_ksettings(struct mii_if_info *mii,
>  		lp_advertising = 0;
>  	}
>  
> +	if (!mii_link_ok(mii))
> +		cmd->base.speed = SPEED_UNKNOWN;

Maybe you could use the already read value of bmsr?

	if (!(bmsr & BMSR_LSTATUS))
		cmd->base.speed = SPEED_UNKNOWN;

When you post a v3 please added a link to v2:

---
v2: https://lore.kernel.org/20250111132242.3327654-1-zhangxiangqian@kylinos.cn

but do *not* post it in reply to this thread.
-- 
pw-bot: cr

