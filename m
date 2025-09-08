Return-Path: <netdev+bounces-220775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B01E0B4899D
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 12:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B1617A1D5E
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 10:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5672ED141;
	Mon,  8 Sep 2025 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i6XAmI5K"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08212222BF
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326153; cv=none; b=mfDMe2z5JFfl+spTbecKFa/qyuE/x6kXDbT4/q4jGTTYYcb9F2zVwH8z8Fd/3ZhNOZJtcbcuZoAMOgPmkSW6f40QeooZM86DMmatCZfsQjPN0c7arcCraAoL57qek61X5JHdmjI4OnEQ8VA5sk91pBRTLzCr8Xoi6KoLUA7GApM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326153; c=relaxed/simple;
	bh=6vXzUx0+1ZzfBqFBrlFHluVd96S1M8OJgxh7q39xvbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rz1VcwFRYGTpDXivBQWpwYpy342Y2qqBEXnv6gY8dWa2419tUyXX/YvMat1rOqvwNk01BZ92LymN3higbSSs+ZCxY9ufyq2bZo2oZOJGOJbAjRtEbVX0eHkHpVsxfI1fpRbEfieEM39xFhTTWEIzHYeS6e+AWebhM4yNEnCj06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i6XAmI5K; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <69cc98e9-0110-4e0d-97a2-b874f876f8d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757326147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKIfr3yz0P4omfZ4OHSE2XNuLb3fPnniT0lD857JD4s=;
	b=i6XAmI5KoOcNSoe7Gy1KsOtjXNpRWO8PO9P4voq8H+m2zMOgNVZoP1aMsKDHad0OPwAWFf
	Ir6v9BN6Y9zRo3vj5PQGFbf1llf7LTW+0itfX+T4rNuxYt8tjxj0kARe4/f1+CsAk6HTCy
	2dlBqIZ1wpdjb24aDsg6+si2EVSYqaw=
Date: Mon, 8 Sep 2025 11:09:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: ipv4: Potential null pointer dereference in
 cipso_v4_parsetag_enum
To: Chen Yufeng <chenyufeng@iie.ac.cn>, paul@paul-moore.com
Cc: davem@davemloft.net, dsahern@kernel.org, netdev@vger.kernel.org
References: <20250908080315.174-1-chenyufeng@iie.ac.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250908080315.174-1-chenyufeng@iie.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/09/2025 09:03, Chen Yufeng wrote:
> While parsing CIPSO enumerated tags, secattr->flags is set to
> NETLBL_SECATTR_MLS_CAT even if secattr->attr.mls.cat is NULL.
> If subsequent code attempts to access secattr->attr.mls.cat,
> it may lead to a null pointer dereference, causing a system crash.
> 
> To address this issue, we add a check to ensure that before setting
> the NETLBL_SECATTR_MLS_CAT flag, secattr->attr.mls.cat is not NULL.
> 
> fixed code:
> ```
> if (secattr->attr.mls.cat)
>      secattr->flags |= NETLBL_SECATTR_MLS_CAT;
> ```
> 
> This patch is similar to eead1c2ea250("netlabel: cope with NULL catmap").
> 
> Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>
> ---
>   net/ipv4/cipso_ipv4.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 740af8541d2f..2190333d78cb 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -1339,8 +1339,8 @@ static int cipso_v4_parsetag_enum(const struct cipso_v4_doi *doi_def,
>   			netlbl_catmap_free(secattr->attr.mls.cat);
>   			return ret_val;
>   		}
> -
> -		secattr->flags |= NETLBL_SECATTR_MLS_CAT;
> +		if (secattr->attr.mls.cat)
> +			secattr->flags |= NETLBL_SECATTR_MLS_CAT;
>   	}
>   
>   	return 0;

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>


