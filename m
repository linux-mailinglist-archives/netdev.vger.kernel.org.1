Return-Path: <netdev+bounces-23037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6604876A753
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 05:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484C61C20E10
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 03:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA501375;
	Tue,  1 Aug 2023 03:10:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E486A7E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 03:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40A1C433C8;
	Tue,  1 Aug 2023 03:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690859400;
	bh=X6Z9QOKzikJGxKFX2tBf3wIQdI88JGKWEXi24Ybq4MA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iIfIeVSu/c4UcRznqKtcdxa18wlnj6ChVSHG7EctmvUsjFt5BapHNNtlwbkJMhOfi
	 idGdgH3pQzvmNXj7OI9N9IWV8kI1hur293KpzgusRRmQ08/0nsVuHciWtiIPdUKwNI
	 +SKstyRjcz6u6KKccx3JDeD/FdwgkvcrX7qnj89BqtETiNd5ojEXD8Y8VEY4reu64B
	 enGGr8yrpHakvkmIrapnuPG2KAYSrOB+XnBCBuVadIIVvP0RddBYDKdjJxj7iP7K5h
	 yjRjLmYzhAGFHk4YbcdYWREx+KXVt9c9RN7Phj/XTW9qIWUrrE7eZG/61ZSpxT0Xbj
	 oAZcdQLNpr8fA==
Date: Mon, 31 Jul 2023 20:09:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <yoshfuji@linux-ipv6.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <simon.horman@corigine.com>
Subject: Re: [PATCH v2] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
Message-ID: <20230731200959.2019cb9c@kernel.org>
In-Reply-To: <20230728121703.29572-1-yuehaibing@huawei.com>
References: <20230728121703.29572-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jul 2023 20:17:03 +0800 Yue Haibing wrote:
>  #ifdef CONFIG_IPV6_PIMSM_V2
> +	int nhoff = skb_network_offset(pkt);
>  	if (assert == MRT6MSG_WHOLEPKT || assert == MRT6MSG_WRMIFWHOLE)
> -		skb = skb_realloc_headroom(pkt, -skb_network_offset(pkt)
> -						+sizeof(*msg));
> +		skb = skb_realloc_headroom(pkt, -nhoff + sizeof(*msg));

These changes look unnecessary. You can leave this code be (as ugly as
it is)...

>  	else
>  #endif
>  		skb = alloc_skb(sizeof(struct ipv6hdr) + sizeof(*msg), GFP_ATOMIC);
> @@ -1073,7 +1073,7 @@ static int ip6mr_cache_report(const struct mr_table *mrt, struct sk_buff *pkt,
>  		   And all this only to mangle msg->im6_msgtype and
>  		   to set msg->im6_mbz to "mbz" :-)
>  		 */
> -		skb_push(skb, -skb_network_offset(pkt));
> +		__skb_pull(skb, nhoff);

.. and just replace the push here with:

  __skb_pull(skb, skb_network_offset(pkt));
-- 
pw-bot: cr

