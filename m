Return-Path: <netdev+bounces-123724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7351966479
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 16:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0901F201A0
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2CD192D77;
	Fri, 30 Aug 2024 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcY/IeFf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8D214EC41
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029402; cv=none; b=e3kK6FNFvQVa9e1Am6lLnWuXsj3qFbngjpXxr2yvo8AULXaa/cqYU/GF1XWWCAOn1UtuDF4msfrrEVNjzZ+5xJ+3I7dsndOBQYmIstEfU46jSfml5EshjUbKC+/fZvHbOi08eLEgFQSe4KFQkoVnWAuUMPKI0in/PmZEvYUHc70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029402; c=relaxed/simple;
	bh=vyUFDYmNVP2r1o1LnJlGBDsnYPQHy5xIbVN18Da7/Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSFQM6MZmineVk2Rpr3G7RrEyflZcdmCzV/QPta+QhtuSovD/Kmk/HfMi5O9h/xsSK+Up4gzorNapVy30T92TW54hEKL1qUFzvIv1DkH4gLQucoQogvbXpKcChHUfaayflwQ3lexRSkWLr+iV19JNmbLhR6um30EQfj7jZbrB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcY/IeFf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42812945633so16924595e9.0
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 07:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725029399; x=1725634199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x1cmeyfDlCTmx42KZ+TLH6aNSgXWVjelWB/1RusNH5w=;
        b=TcY/IeFf3kivy7XQsiOkaqdfwKp9tljXCiQygNdgeGITa2KUNsai5A6oKrCSdy5ISW
         C/v+HmuB/P3fD8YLgDEuVk+Xm7Y4yTKeDpN+SBzBkfC4ZsiMQwhDf2Qq2Q5RbkLl612O
         eoHwzGkt9CA5z+83uzTyJWHZDWgdLfr3l2jPaBYVWhRXRdG/klAlXtBOShskqZlQ+24X
         IK8mvSVYND83gvesSV91YaaE4ZaViJ07ViqvAeQhncuUMoZjNTZrzECGsRCRlfpPYMr2
         kzTTKCSEeHavleQ3bR3ZH+EV9zWEC5Jx63tVVjmN6W49Pbn3I5iYvEW7CucnaJax8fGk
         7LJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725029399; x=1725634199;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1cmeyfDlCTmx42KZ+TLH6aNSgXWVjelWB/1RusNH5w=;
        b=r+AAU8kiMg/MQGL5zH4XdzxAJYd8ACSX4cMppcddam074X1GNUaigw5E56sU/DcbQa
         CaKe6S2BvNbw8MQYtNUsQ7jgU+L82CBie4Y7TqxgX2fRiijCwjkA6iFwCz8cmaZ/u7HA
         IPnlnTuBDcldgxAXCOI3HdgP80faF9ySHLgbv3/mjcHhXGR4IqXUNHj01WI+Mh6WYund
         rlZN6NsFbtvFBEqI2LVtKwHS68rrnv+xGCIpZ/7AszzPkdVrgN3VqAhars9S8RgFjLqn
         VhJZWbsBqAzXoLhsLpB1RmMVvrFyma6C3iJ12N4IpjGGA2ly59kmXcizqNn8Owsb0/yu
         heog==
X-Forwarded-Encrypted: i=1; AJvYcCWEN+mqXL3oSb+ENAV0iDz++7V3aluj3t3bxULWX7QAFP/fJpXdAN8MdWtdrepaohzjwSlfaGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCMExd40H+7y1oCTaI5nsxwaAiDW3duaWwyzicbYajMW2220Zt
	vS9QblYLaycTpIac7297lMlkmk7CU2drN55julTU3DFIIQ/Ey4GArUEe0Atq
X-Google-Smtp-Source: AGHT+IEoUQrXdQJ0TsdKFRMdtYDgF1+TVZo/XuPMVd3AcF/P1lu8l2tjuE9e8uywbSLSCv7QaZwwpQ==
X-Received: by 2002:a05:600c:4fd3:b0:428:14b6:ce32 with SMTP id 5b1f17b1804b1-42bb024d773mr52917465e9.9.1725029398942;
        Fri, 30 Aug 2024 07:49:58 -0700 (PDT)
Received: from [172.18.193.130] (ip-185-104-138-49.ptr.icomera.net. [185.104.138.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e33f5esm47910835e9.39.2024.08.30.07.49.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 07:49:58 -0700 (PDT)
Message-ID: <06dc2499-c095-4bd4-aee3-a1d0e3ec87c4@gmail.com>
Date: Fri, 30 Aug 2024 17:49:50 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ipsec-next 3/4] xfrm: switch migrate to
 xfrm_policy_lookup_bytype
To: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Cc: herbert@gondor.apana.org.au, steffen.klassert@secunet.com,
 noel@familie-kuntze.de, tobias@strongswan.org
References: <20240822130643.5808-1-fw@strlen.de>
 <20240822130643.5808-4-fw@strlen.de>
Content-Language: en-US
From: Julian Wiedmann <jwiedmann.dev@gmail.com>
In-Reply-To: <20240822130643.5808-4-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian,

On 22.08.24 16:04, Florian Westphal wrote:
> XFRM_MIGRATE still uses the old lookup method:
> first check the bydst hash table, then search the list of all the other
> policies.
> 
> Switch MIGRATE to use the same lookup function as the packetpath.
> 
> This is done to remove the last remaining users of the pernet
> xfrm.policy_inexact lists with the intent of removing this list.
> 
> After this patch, policies are still added to the list on insertion
> and they are rehashed as-needed but no single API makes use of these
> anymore.
> 
> This change is compile tested only.
> 

[...]

>  
> -	spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
> +	pol = xfrm_policy_lookup_bytype(net, type, &fl, sel->family, dir, if_id);
> +	if (IS_ERR_OR_NULL(pol))
> +		goto out_unlock;
>  
> -	return ret;
> +	if (!xfrm_pol_hold_rcu(ret))

Coverity spotted that ^^^ needs a s/ret/pol fix-up:

>    CID 1599386:  Null pointer dereferences  (FORWARD_NULL)
>    Passing null pointer "ret" to "xfrm_pol_hold_rcu", which dereferences it.


> +		pol = NULL;
> +out_unlock:
> +	rcu_read_unlock();
> +	return pol;
>  }
>  

