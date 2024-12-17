Return-Path: <netdev+bounces-152509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5263F9F45CC
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5FD188EF06
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1419D1DC999;
	Tue, 17 Dec 2024 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fstwhbm+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30321DC18F
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734423317; cv=none; b=H0vUr9P/iY2QEJnQnW3hLMX6E3md67CGJa3HF7hpH1Tjv7tjbEgLKjbNE+10HMOku2uAP74tCr0oOUo3Cui41k+ZGOzUol/Cp06RwCCb9lJP19rVtgQ9mhZp4dCiwNcNEfAzKkhfB2auf2tiqlagGnO232OVFrfQ7qb6+LUmqF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734423317; c=relaxed/simple;
	bh=ednP/HLnZgVv9AJP0B+LX0Us9kaeezSBv7lU66tOAsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDSVP6eZE2C/Ruy8njV8YVYhXpsMA+iiev4zbFy/TBj9LyPfKnDAMiydHIkgtfH1Q9YPXckQlPc7SxlCTdZ8pTCrmxp2Fpl3um20J1Ta1s+oC58GOU8j7MreEgh7GRDybbE6gj4OIDD55RQEDXJGmSVfI71naP0mZUnNOZHrIlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fstwhbm+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734423313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1304INXJlKxeszjZopUKk2IwFQ6dEioACNxOGYzxn+o=;
	b=fstwhbm+QrwAf6NDX35f8TSzVVZZxRKChujm15Rnz2gs+RWkTFL/cT0XE//3PEn8xz4/nJ
	/+pASYAVN0vmc/uGcsPX0NSuLWx6+BfOl7Zf63Gi4TAIHc2q2Ocm0l/BQ0FxZPUD+yER2S
	aInlPWLA8jN2uDvbk7pQq7/C3upZu7E=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-EKY3_27hP26JfrqT2ESGmA-1; Tue, 17 Dec 2024 03:15:12 -0500
X-MC-Unique: EKY3_27hP26JfrqT2ESGmA-1
X-Mimecast-MFC-AGG-ID: EKY3_27hP26JfrqT2ESGmA
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6e1b0373bso630754185a.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 00:15:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734423311; x=1735028111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1304INXJlKxeszjZopUKk2IwFQ6dEioACNxOGYzxn+o=;
        b=GSFaDBHQS7+GpkmDV0CJfXtKA7zS2EuC+SQBnRFVIqMEtB+fPExfAHNpUXGavnDmgD
         DUBNNPfPGHweeWw6K14efM6ohUJH8sJmOE9i/mQmOmTth8xlgg9DN05Zh0GxaxTJmJ1o
         dQOLIxtuT/is4zaM+vunnkmrP9+q9o1R6AIebA7zQfoq+IVb3iu+Dxp62VexUFZ2L67i
         hruUUtUqrvBs4ZM1bwcI6Am5CrKCjDPXO6T/dvUPBFEpW1UIispuvARhH43pZtXrBEzL
         xqUdTfUUh3TaxwpgdBu8ZzMzpAdLLyrJcx7xkL3CR+kxuukNmVbmvOGVONBENpRnxVKT
         GaaQ==
X-Gm-Message-State: AOJu0YwDfEH00B628NZTk7jroIuxmG2xutBnpviutJUlDZq0vTxEK1Pq
	hbojzAkvUzT/7hZ+9JMlEs/VRpD7U2bj+vwmYFQWjiefuR7dztYCfPDVKDgdtILU9ktWWgpjV9u
	mSIW63RAwZTW7a/NoWP760EHcCdNLs4mTw4kE80lbcsFN4nRNt3T5rQ==
X-Gm-Gg: ASbGncud+uKHr/V43RL3FTX0StUy7GfQsdOdmhqzkoo0o2nvxGM4J7qcaJMIc1MjZqn
	l/GefTJOMe+k5C3jhhHQkNXthanfuSpdJA1XYC2L9MAeSqiOaA1uickB8J4p9LCblT3myW+0Xvj
	bVcJFqug8iysZ++jHJaAwQ6iwb0LgePQHtN55WwpPtU7id2KThEDNC0E3ADVuGUKWkqYBEnkMca
	pbpuQ4juvcELl+xd/dPEFY8XFIUG5zJioo2tRJvKWLWwyXDRXR7VkCjBg2nG8WKsHDm9iSZ00c2
	QRJGttS+Ng==
X-Received: by 2002:a05:622a:548:b0:468:f80b:c5d7 with SMTP id d75a77b69052e-468f80bc995mr40213671cf.1.1734423311558;
        Tue, 17 Dec 2024 00:15:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0ZE72DesppFN4SiAwmUB+o5/5EGW7XoOs8QyTNoMPSw5pQ2WWL4AlN3DQLIbQ5ghKBmcMig==
X-Received: by 2002:a05:622a:548:b0:468:f80b:c5d7 with SMTP id d75a77b69052e-468f80bc995mr40213501cf.1.1734423311257;
        Tue, 17 Dec 2024 00:15:11 -0800 (PST)
Received: from [192.168.88.24] (146-241-69-227.dyn.eolo.it. [146.241.69.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2ca267esm36556831cf.24.2024.12.17.00.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 00:15:10 -0800 (PST)
Message-ID: <f3dba541-8880-4a03-b0c9-e7b9b552b8f3@redhat.com>
Date: Tue, 17 Dec 2024 09:15:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: mctp: handle skb cleanup on sock_queue
 failures
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
References: <20241211-mctp-next-v1-0-e392f3d6d154@codeconstruct.com.au>
 <20241211-mctp-next-v1-1-e392f3d6d154@codeconstruct.com.au>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241211-mctp-next-v1-1-e392f3d6d154@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/24 06:56, Jeremy Kerr wrote:
> Currently, we don't use the return value from sock_queue_rcv_skb, which
> means we may leak skbs if a message is not successfully queued to a
> socket.
> 
> Instead, ensure that we're freeing the skb where the sock hasn't
> otherwise taken ownership of the skb by adding checks on the
> sock_queue_rcv_skb() to invoke a kfree on failure.
> 
> In doing so, rather than using the 'rc' value to trigger the
> kfree_skb(), use the skb pointer itself, which is more explicit.
> 
> Also, add a kunit test for the sock delivery failure cases.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Why are you targeting net-next for this patch? it looks like a clean fix
for net, and follow-up patches don't depend on it.

> ---
>  net/mctp/route.c           | 38 +++++++++++++-------
>  net/mctp/test/route-test.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 112 insertions(+), 12 deletions(-)
> 
> diff --git a/net/mctp/route.c b/net/mctp/route.c
> index 597e9cf5aa64445474287a3fee02ba760db15796..49676ce627e30ee34924d64fe26ef1e0303518d9 100644
> --- a/net/mctp/route.c
> +++ b/net/mctp/route.c
> @@ -374,8 +374,13 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
>  	msk = NULL;
>  	rc = -EINVAL;
>  
> -	/* we may be receiving a locally-routed packet; drop source sk
> -	 * accounting
> +	/* We may be receiving a locally-routed packet; drop source sk
> +	 * accounting.
> +	 *
> +	 * From here, we will either queue the skb - either to a frag_queue, or
> +	 * to a receiving socket. When that succeeds, we clear the skb pointer;
> +	 * a non-NULL skb on exit will be otherwise unowned, and hence
> +	 * kfree_skb()-ed.
>  	 */
>  	skb_orphan(skb);
>  
> @@ -434,7 +439,9 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
>  		 * pending key.
>  		 */
>  		if (flags & MCTP_HDR_FLAG_EOM) {
> -			sock_queue_rcv_skb(&msk->sk, skb);
> +			rc = sock_queue_rcv_skb(&msk->sk, skb);
> +			if (!rc)
> +				skb = NULL;
>  			if (key) {
>  				/* we've hit a pending reassembly; not much we
>  				 * can do but drop it
> @@ -443,7 +450,6 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
>  						   MCTP_TRACE_KEY_REPLIED);
>  				key = NULL;
>  			}
> -			rc = 0;
>  			goto out_unlock;
>  		}
>  
> @@ -470,8 +476,10 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
>  			 * this function.
>  			 */
>  			rc = mctp_key_add(key, msk);
> -			if (!rc)
> +			if (!rc) {
>  				trace_mctp_key_acquire(key);
> +				skb = NULL;
> +			}
>  
>  			/* we don't need to release key->lock on exit, so
>  			 * clean up here and suppress the unlock via
> @@ -489,6 +497,8 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
>  				key = NULL;
>  			} else {
>  				rc = mctp_frag_queue(key, skb);
> +				if (!rc)
> +					skb = NULL;
>  			}
>  		}
>  
> @@ -498,17 +508,22 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
>  		 */
>  
>  		/* we need to be continuing an existing reassembly... */
> -		if (!key->reasm_head)
> -			rc = -EINVAL;
> -		else
> +		if (key->reasm_head)
>  			rc = mctp_frag_queue(key, skb);
> +		else
> +			rc = -EINVAL;

This chunk just re-order existing statement, it looks unneeded and I
would remove it from 'net' fix.

> +
> +		/* if we've queued, the queue owns the skb now */
> +		if (!rc)
> +			skb = NULL;

Possibly:
		if (rc)
			goto out_unlock;

		skb = NULL;
		if (flags & MCTP_HDR_FLAG_EOM) {

is simpler/clearer

Thanks,

Paolo


