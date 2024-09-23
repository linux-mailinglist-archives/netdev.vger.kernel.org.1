Return-Path: <netdev+bounces-129349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDFA97EFA8
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 18:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E724280C3E
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 16:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5D419F111;
	Mon, 23 Sep 2024 16:56:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93953196C7B
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110564; cv=none; b=u3RvKHpB6iVcO2Buj8YXI61RT9FHuHU2jnPOzcnSupGjSNSof6ZHy/8TFInrV32dvQk/s+seRc+FH+EK3uZeg6W3NlT5CQmD1RmUxLleNvELPiuHCYqAYIVt8SDCzpsjnGznAFbxZBO1FBB32oivZ2aZzXl4+ACZ6G+n/1q0Ccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110564; c=relaxed/simple;
	bh=slsbfPrsp+mavVw3ydDVx+HeZBsqOTVKIMmilBsE0Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIVo6JiwPBbNCXxXv+6c8oq6MoteVfTa+kbP5aHKSNuizKOQdkCH681HqpXrBI/9hK3SAzpRNOQyUSpF5CeepbC4+2BWD5QtPgns6rrimoos9GEKDGoKfSAWOR+GJ8DV5yzGK4SAhYHR5Xj1WRg4b66Pe3EVwxfPOehxb5f/8Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1ssmLu-0002ZL-5A; Mon, 23 Sep 2024 18:55:58 +0200
Date: Mon, 23 Sep 2024 18:55:58 +0200
From: Florian Westphal <fw@strlen.de>
To: greearb@candelatech.com
Cc: netdev@vger.kernel.org, dsahern@kernel.org
Subject: Re: [PATCH] Revert "vrf: Remove unnecessary RCU-bh critical section"
Message-ID: <20240923165558.GB9034@breakpoint.cc>
References: <20240923162506.1405109-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923162506.1405109-1-greearb@candelatech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

greearb@candelatech.com <greearb@candelatech.com> wrote:
> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> index 4d8ccaf9a2b4..4087f72f0d2b 100644
> --- a/drivers/net/vrf.c
> +++ b/drivers/net/vrf.c
> @@ -608,7 +608,9 @@ static void vrf_finish_direct(struct sk_buff *skb)
>  		eth_zero_addr(eth->h_dest);
>  		eth->h_proto = skb->protocol;
>  
> +		rcu_read_lock_bh();
>  		dev_queue_xmit_nit(skb, vrf_dev);
> +		rcu_read_unlock_bh();

[..]

> + *	BH must be disabled before calling this.

Can you replace the rcu_read_lock_bh with plain local_bh_enable/disable?
I think that would make more sense.

Otherwise comment should explain why rcu read lock has to be held too,
I see no reason for it.

