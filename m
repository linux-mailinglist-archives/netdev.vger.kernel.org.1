Return-Path: <netdev+bounces-144511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC0D9C7B18
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA293B30C05
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B802038DD;
	Wed, 13 Nov 2024 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dSAefPK+"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096CA1632CC
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520869; cv=none; b=ifb7uymGNtjHxqmZkFUPgsMWKOox53YKpJUJVOz3FTmmAQZwy85wT/ZnpKpOaH181NEwJCjk286UlTOZYkYkYRuRn5rV1vawNHJ9kC8xGXEVG5mRlQQgsYr1fteReHkneT2FAB5Sz8ZJmYgNqAesKV0kwjpdxUcd8WPO1fdel1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520869; c=relaxed/simple;
	bh=aN7q4d/XN77AVLrpWcVztkWzLpZPfIHT5SFangX1NpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=go2I3pQXCaT5pm/j7ur4xm4YE2szmVig0r24ijpkGLpCzKG74mt3El3deMkSMscY4HawsJ9d2t5cAQQXciH0mcpRBcDt2e4/7KpP6INpxz9X4IiF7lzSo8aWPrqgq6xE2Y1Wi6yJ9k90QiL7VdHfJk1gHOnRGM5wIhN/nokk17A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dSAefPK+; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0545b4a3-8c71-4cc1-9678-51460ad8852b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731520865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zvASPav+w4dEoKPTtpzV2bPL5vaiFXp57uusYkQ0ojs=;
	b=dSAefPK+5Y/l5meYoKgZjh2bBTwhPn3myigWIA3MHG0Wl0aCyCYsLPF31R/xp0mQB9+h9G
	CZCLRa/RHg50Mwi6dWsbAotd8QW1dqeKNst1n3WGhdpjv4J7lmC5Dl0Gx29cYN4Nttn6Zi
	7atYKEv1rD7kMhiycHXngzxWqxtNRtM=
Date: Wed, 13 Nov 2024 18:01:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4 4/7] octeon_ep: add protective null checks in napi
 callbacks for cnxk cards
To: Shinas Rasheed <srasheed@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: hgani@marvell.com, sedara@marvell.com, vimleshk@marvell.com,
 thaller@redhat.com, wizhao@redhat.com, kheib@redhat.com, egallen@redhat.com,
 konguyen@redhat.com, horms@kernel.org,
 Veerasenareddy Burru <vburru@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20241113111319.1156507-1-srasheed@marvell.com>
 <20241113111319.1156507-5-srasheed@marvell.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241113111319.1156507-5-srasheed@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2024 11:13, Shinas Rasheed wrote:
> During unload, at times the OQ parsed in the napi callbacks
> have been observed to be null, causing system crash.
> Add protective checks to avoid the same, for cnxk cards.
> 
> Fixes: 0807dc76f3bf ("octeon_ep: support Octeon CN10K devices")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V4:
>    - No Changes
> 
> V3: https://lore.kernel.org/all/20241108074543.1123036-5-srasheed@marvell.com/
>    - Added back "Fixes" to the changelist
> 
> V2: https://lore.kernel.org/all/20241107132846.1118835-5-srasheed@marvell.com/
>    - Split into a separate patch
>    - Added more context
> 
> V1: https://lore.kernel.org/all/20241101103416.1064930-3-srasheed@marvell.com/
> 
>   drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
> index 5de0b5ecbc5f..65a8dc1d492b 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
> @@ -638,7 +638,14 @@ static irqreturn_t octep_rsvd_intr_handler_cnxk_pf(void *dev)
>   static irqreturn_t octep_ioq_intr_handler_cnxk_pf(void *data)
>   {
>   	struct octep_ioq_vector *vector = (struct octep_ioq_vector *)data;
> -	struct octep_oq *oq = vector->oq;
> +	struct octep_oq *oq;
> +
> +	if (!vector)
> +		return IRQ_HANDLED;

The same comment as for the previous patch - this can never happen, the
check is meaningless

> +	oq = vector->oq;
> +
> +	if (!oq || !(oq->napi))
> +		return IRQ_HANDLED;
>   
>   	napi_schedule_irqoff(oq->napi);
>   	return IRQ_HANDLED;


