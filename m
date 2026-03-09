Return-Path: <netdev+bounces-265446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBjpDeSWrmnRGQIAu9opvQ
	(envelope-from <netdev+bounces-265446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:46:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E4023674E
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09C7630073D8
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 09:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2E9377ECC;
	Mon,  9 Mar 2026 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDWEgzDu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC51936BCE6
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773049378; cv=none; b=F1my0p2tkPvOExycUeIrU+D9jj4NghCvJfhyiIwgZUTkKW1bmcvO/tVSMFzlt5x3JWyw09m8Ms5v3MoQl/Aym5IvV9XxyIGh/UOCCNCrcwBSkkGfHM1NHL/Pt5i3xx50FbkF18CeTYLwmhtTJvCFpeOsWV71p4434CEpAk+e4uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773049378; c=relaxed/simple;
	bh=pkydFzExz4VmpYdXrHgKl21IUtCYf2hHYXeNoAbDH94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ObSx1JajgEVKCebej5OI3fsttNBLyPlCtjDF8kPAQrQFBfHHGNErnjo4S2nJ4olsrLVNcMrjJDyAQQBS2/oYPOkAvkrXCysOHdNOo4CQ7ClEVattd6Oh9Fu5Cb+7QSeG3zLz3ezhu7FL3bt1O/fYnVUqGsJNUeeU6W4iOo2hF9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDWEgzDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4477C4CEF7;
	Mon,  9 Mar 2026 09:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773049378;
	bh=pkydFzExz4VmpYdXrHgKl21IUtCYf2hHYXeNoAbDH94=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CDWEgzDuHBfreL7mHfjTW1vU1lkvTSiwMiQECLZYLMgImzCzAPhlaVB7w/NO3gR9u
	 vt5wi+9TdXEWis9ViqWhgf8S/9OlVfVBVP3us2cEbmYlBZEQVovG/PyLL6Rnf+v9K7
	 nrJnqgJPOWiCEuvdTOYTXJ2cgrPA1YmNx12Nq5qDsQyDg15Obn5/b06vspwEfQCRJu
	 CJGpKf0Rb9Un24mc0uVuFNtnMyfcqXpvm+jlR8AQ0neBrJRIiI+wP/qDXQss1N7LzW
	 lJriJ/0OqbY4qFbrJ5sim6h3Pxl+CnhPZAx2c3bapuOSuwVDfymDMhGf0h4+Ha2lQB
	 Acqtsskbru+0g==
Message-ID: <4e45407b-5c6b-4832-b403-ea62b1e4bcb5@kernel.org>
Date: Mon, 9 Mar 2026 10:42:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] page_pool: store detach_time as ktime_t to avoid
 false-negatives
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, ilias.apalodimas@linaro.org
References: <20260307204022.1897614-1-kuba@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260307204022.1897614-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A5E4023674E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265446-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 07/03/2026 21.40, Jakub Kicinski wrote:
> While testing other changes in vng I noticed that
> nl_netdev.page_pool_check flakes. This never happens in real CI.
> 
> Turns out vng may boot and get to that test in less than a second.
> page_pool_detached() records the detach time in seconds, so if
> vng is fast enough detach time is set to 0. Other code treats
> 0 as "not detached". detach_time is only used to report the state
> to the user, so it's not a huge deal in practice but let's fix it.
> Store the raw ktime_t (nanoseconds) instead. A nanosecond value
> of 0 is practically impossible.
> 
> Fixes: 69cb4952b6f6 ("net: page_pool: report when page pool was destroyed")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: hawk@kernel.org

LGTM -- after addressing in build errors... likely a missing include?

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>


> CC: ilias.apalodimas@linaro.org
> ---
>   include/net/page_pool/types.h | 2 +-
>   net/core/page_pool_user.c     | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
> index 0d453484a585..cdd95477af7a 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -247,7 +247,7 @@ struct page_pool {
>   	/* User-facing fields, protected by page_pools_lock */
>   	struct {
>   		struct hlist_node list;
> -		u64 detach_time;
> +		ktime_t detach_time;
>   		u32 id;
>   	} user;
>   };
> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
> index c82a95beceff..fb4ca27358cd 100644
> --- a/net/core/page_pool_user.c
> +++ b/net/core/page_pool_user.c
> @@ -245,7 +245,7 @@ page_pool_nl_fill(struct sk_buff *rsp, const struct page_pool *pool,
>   		goto err_cancel;
>   	if (pool->user.detach_time &&
>   	    nla_put_uint(rsp, NETDEV_A_PAGE_POOL_DETACH_TIME,
> -			 pool->user.detach_time))
> +			 ktime_to_seconds(pool->user.detach_time)))

Hmm.. is this ktime_to_seconds even defined?

A quick look tells me that we could use:

  ktime_divns(pool->user.detach_time, NSEC_PER_SEC)


>   		goto err_cancel;
>   
>   	if (pool->mp_ops && pool->mp_ops->nl_fill(pool->mp_priv, rsp, NULL))
> @@ -337,7 +337,7 @@ int page_pool_list(struct page_pool *pool)
>   void page_pool_detached(struct page_pool *pool)
>   {
>   	mutex_lock(&page_pools_lock);
> -	pool->user.detach_time = ktime_get_boottime_seconds();
> +	pool->user.detach_time = ktime_get_boottime();
>   	netdev_nl_page_pool_event(pool, NETDEV_CMD_PAGE_POOL_CHANGE_NTF);
>   	mutex_unlock(&page_pools_lock);
>   }


