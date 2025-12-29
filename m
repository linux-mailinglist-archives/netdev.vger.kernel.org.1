Return-Path: <netdev+bounces-246276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFA4CE8057
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 20:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BC3A3019BE1
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 19:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49BE296BBC;
	Mon, 29 Dec 2025 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GZWn1gzl"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5947D1624DF
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035636; cv=none; b=Yd8LXg6J7y94nOItlZUDfwSpqOoNjg1Z7eNefBTZqTQZsWLGbQOT13yNGKZU1GeZS8OFqhPugtmtynitte5Wn4x8O5AJ1sednl1GjnH9a7KT6Y0v81kwZVf+lLlsurhts6wAgfRytd6Cmr/b1docPrJo0xI3tHLM3yUpnwLGwRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035636; c=relaxed/simple;
	bh=EK/+O9yl5IbSz8rcHjiPTrZAiSKgUnBZAFjxMYcrSrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2HEn3nlmEw0UsPW/oEpxF48Xgs58oMKr3x7yycbFBa2nKDjWt4b2LNsNWVLKqUEJ4rgyeabPOTDBtkrtMsX8NPlU1SLif8kArNjET/eKrZdW7mNl/au5FQHg3f21yN9ws/J/YdCkmAlr7smDAOjjYwSIOAloV2OzX9yUVVhbMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GZWn1gzl; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f04e466b-8b8b-466e-a67c-d7fbfea2fbfd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767035631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGq0enpk6EouHOWyVwThBC2qEmxZcwXmTedHH69aDgQ=;
	b=GZWn1gzlLjMbDM/EcHOTxeg2b+ppWyJftSxCC6sczW0xb1+XHhYita5Syb/uQZepnxF4Az
	1GMUhICdvDxc5sG8jh727qB8zo3HF+hQ174gZkAH8V5/dDVC2fNztuwbcgoSB6QVpYqAks
	Vt1nuwonB4qpDcHLH+sXO+wtD7ckf0Q=
Date: Mon, 29 Dec 2025 19:13:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Fix PTP driver warnings by removing settime64 check
To: Tinsae Tadesse <tinsaetadesse2015@gmail.com>, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251229173346.8899-1-tinsaetadesse2015@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251229173346.8899-1-tinsaetadesse2015@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/12/2025 17:32, Tinsae Tadesse wrote:
> Signed-off-by: Tinsae Tadesse <tinsaetadesse2015@gmail.com>
> ---
>   drivers/ptp/ptp_clock.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index b0e167c0b3eb..5374b3e9ad15 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -323,8 +323,7 @@ struct ptp_clock *ptp_clock_register(struct ptp_clock_info *info,
>   	size_t size;
>   
>   	if (WARN_ON_ONCE(info->n_alarm > PTP_MAX_ALARMS ||
> -			 (!info->gettimex64 && !info->gettime64) ||
> -			 !info->settime64))
> +			 (!info->gettimex64 && !info->gettime64)))
>   		return ERR_PTR(-EINVAL);
>   
>   	/* Initialize a clock structure. */


Could you please tell us a bit more about reasoning for this patch?

