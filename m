Return-Path: <netdev+bounces-56188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B4F80E1E7
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 03:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41832827A1
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 02:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C40A635;
	Tue, 12 Dec 2023 02:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rX4PxeOh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50963625
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 02:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C091C433C7;
	Tue, 12 Dec 2023 02:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702348232;
	bh=vp9OZtxkHOBMawczbgBlIcfs5eItU/SvXYiGN1UuZfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rX4PxeOhikpsA5+G8tRZ4jSgkqNA9A3PMeu4rDbxkILCRkYpiDBYn7QePaL4KYLJr
	 fufd8ZsHHZmSPknRKixNsimN8QwB+PQHdtfOBh72/1fqf8cHiYdb1xBW217Hlsr9Op
	 37mOX04cRnTzyakAWsIZahUpTrIkPn9iJlMLmFURf4t9dUEsRgnGJ1oOHUmLIaE+3M
	 qcWtyjrmiofRtYmltp/bZkzPNG7x7QqfbuPL0/JABgtABz5uN8kzvOwMuObcgS4TbU
	 ddLMznck0fvmm2wMImfVS8XSeL3h2j5867YTNsl0VZJ5+FKqv4xvphOCTNpcuLCTGd
	 eFG6bIiSF5h4g==
Date: Mon, 11 Dec 2023 18:30:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 daniel@iogearbox.net, dcaratti@redhat.com, netdev@vger.kernel.org,
 kernel@mojatatu.com
Subject: Re: [PATCH net-next v3 3/3] net: sched: Add initial TC error skb
 drop reasons
Message-ID: <20231211183031.78f6ffa6@kernel.org>
In-Reply-To: <20231205205030.3119672-4-victor@mojatatu.com>
References: <20231205205030.3119672-1-victor@mojatatu.com>
	<20231205205030.3119672-4-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Dec 2023 17:50:30 -0300 Victor Nogueira wrote:
> +	/**
> +	 * @SKB_DROP_REASON_TC_EXT_COOKIE_NOTFOUND: tc cookie was looked up
> +	 * using ext, but was not found.
> +	 */
> +	SKB_DROP_REASON_TC_EXT_COOKIE_NOTFOUND,
> +	/**
> +	 * @SKB_DROP_REASON_TC_COOKIE_EXT_MISMATCH: tc ext was lookup using
> +	 * cookie and either was not found or different from expected.
> +	 */
> +	SKB_DROP_REASON_TC_COOKIE_EXT_MISMATCH,
> +	/**
> +	 * @SKB_DROP_REASON_TC_COOKIE_MISMATCH: tc cookie available but was
> +	 * unable to match to filter.
> +	 */
> +	SKB_DROP_REASON_TC_COOKIE_MISMATCH,

Do we really need 3 reasons for COOKIE?

Also cookie here is offload state thing right? I wonder how many admins
/ SREs would be able to figure out what's going on based on this kdoc :S
Let alone if it's a configuration problem or a race condition...

