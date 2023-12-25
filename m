Return-Path: <netdev+bounces-60204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFD881E1AA
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 18:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735421F221C2
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 17:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A3A1F18C;
	Mon, 25 Dec 2023 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQ+LvyyV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB5F52F65
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 17:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A54BC433C8;
	Mon, 25 Dec 2023 17:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703523758;
	bh=tzaqSi9HzfDRPD7kdKCHTXBG1tpSOTKCmKCaijMpxgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dQ+LvyyVD4Q4ciDVz0lFjDGhM6wwS7mZj/SFj58Tn0ehIKJgSyAvLJTKtoy/bpGcP
	 faC/g0Ksq4ye+EOrS6OphFGaFEEz6wW5ReEdjs4xFc3w2DBwl3K5QAdIzi5iwT8hqC
	 kjv5LAYK3AGDcvAhPwOUsSfcbXPbipWWmNlmFpz8bNk9Zw8KdQLjz3m7wuMoY3HJwY
	 jlsaxpc6OD20AaMNtvc8C2amxKXXd84p3XU1eJC/8ZVWwGD+gMndYR4alCnbxnLjri
	 cB+7ARPSgIfTm+q26W2x4kILLgb5gENkhP08AnovF+kuQoA581h824Mfw8mdrf42e4
	 GeCTcOOINW7Qw==
Date: Mon, 25 Dec 2023 17:02:33 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net-next v2 07/13] bnxt_en: Add new BNXT_FLTR_INSERTED
 flag to bnxt_filter_base struct.
Message-ID: <20231225170233.GI5962@kernel.org>
References: <20231223042210.102485-1-michael.chan@broadcom.com>
 <20231223042210.102485-8-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223042210.102485-8-michael.chan@broadcom.com>

On Fri, Dec 22, 2023 at 08:22:04PM -0800, Michael Chan wrote:
> Change the unused flag to BNXT_FLTR_INSERTED.  To prepare for multiple
> pathways that an ntuple filter can be deleted, we add this flag.  These
> filter structures can be retreived from the RCU hash table but only
> the caller that sees that the BNXT_FLTR_INSERTED flag is set can delete
> the filter structure and clear the flag under spinlock.
> 
> Reviewed-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

...

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 3f4e4708f7d8..867cab036e13 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -1348,7 +1348,7 @@ struct bnxt_filter_base {
>  	u16			vf_idx;
>  	unsigned long		state;
>  #define BNXT_FLTR_VALID		0
> -#define BNXT_FLTR_UPDATE	1
> +#define BNXT_FLTR_INSERTED	1

Hi Michael,

a minor nit from my side, which I don't think you need to bother with
unless you need to create v3 for some other reason.

I think that either the hunk above should be squashed into patch 1 of this
series. Or, better IMHO, BNXT_FLTR_UPDATE should simply be dropped from
patch 1.

>  
>  	struct rcu_head         rcu;
>  };

