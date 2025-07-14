Return-Path: <netdev+bounces-206909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D81B04C7D
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 01:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ACC43A787F
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 23:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB0724EAB2;
	Mon, 14 Jul 2025 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srkFQgAh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C624F2309B3;
	Mon, 14 Jul 2025 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752536503; cv=none; b=NtN0nH+LIhkUrveWdEc+q3BBBHN+xKKODFHPjAsftbhzkLB9NUvdoLdllmLFOAQ5gBTx8m6VyVYaKVkXErNhuwPVek7iTq6MIY6mp5PZCh9TjEDaf9rSnQiET71D7XVWRevQu0gxzMDXjU43MxHSl7Zjickh0wfC4te94q0kIy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752536503; c=relaxed/simple;
	bh=xIUNOn1t+fQT5DNVpsJHvckamTi5Ps01Jmf9NjN8B9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8tuEtxXc0eZwFWrcIIK+byeIA2obB2d4yyCZDFBXwCjqt1hqSt9pFqo1Te8j/0Jijbp24IUAZFik9mAvoSDe24abaWmbHtt0hsHBBtwnuDWdLgCO4EagH9RRNQLm7a3Rb971+LtQiNiEqDm3BL+qZ4AiN5eVcGeJAiI2mFoShs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srkFQgAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC96C4CEED;
	Mon, 14 Jul 2025 23:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752536503;
	bh=xIUNOn1t+fQT5DNVpsJHvckamTi5Ps01Jmf9NjN8B9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=srkFQgAhCfg/w7U3mjglziPPAWBejD/ltRnrywhcd/bmWtWj7MgWizmWPde8/FoPc
	 HQfV3tUyXKA8aaTYCZsnrcD4nbUc2/ONyOCerQOZ24qxhCd5ialme4nBKZTyUz4mMO
	 bZYNpwAEmtB9CRoRUxFYoKX8N7pCsppnEjGGJ5b0BQ+60GBGmH/KroPTBLg60PufyG
	 qdG89v6Y0xn+oAOSogNNa9KgSxvYJLurRjQ+Jb7nqFOMofhz/BFceRDi2/aHidmWKP
	 QiY5IO7ERDpaLd59drqe9++c1t7VENU6U8n/KofK1ipFdC/NfHsV8Kzk/pPFvNBhsV
	 XzIfAUraGDIuw==
Date: Mon, 14 Jul 2025 16:41:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v2 1/1] net: selftests: add PHY-loopback test
 for bad TCP checksums
Message-ID: <20250714164142.341e37a2@kernel.org>
In-Reply-To: <20250711072449.802677-1-o.rempel@pengutronix.de>
References: <20250711072449.802677-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 09:24:49 +0200 Oleksij Rempel wrote:
> +			/* To avoid sparse warnings about operating on
> +			 * restricted __sum16/__be16 types, explicitly cast the
> +			 * checksum to a plain u16, perform the manipulation,
> +			 * and then cast the result back.
> +			 */
> +			csum = (__force u16)thdr->check;
> +
> +			/* Mangle the checksum by flipping the LSB. */
> +			csum ^= 1;
> +			/* If mangling resulted in 0, use the raw value for a
> +			 * mangled-zero checksum. We use the literal 0xffff
> +			 * because CSUM_MANGLED_0 has a restricted type.
> +			 */
> +			if (!csum)
> +				csum = 0xffff;
> +
> +			/* Cast the final integer value back to the restricted
> +			 * type
> +			 */
> +			thdr->check = (__force __sum16)csum;

Way to manny lines of code for something this simple.
Can csum_add() help you get rid of all these casts and comments?
-- 
pw-bot: cr

