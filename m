Return-Path: <netdev+bounces-137414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA269A62A4
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332C41F214DE
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD191E4106;
	Mon, 21 Oct 2024 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7DcycQb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511F41E3776
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506040; cv=none; b=Pv01YeY6qhcbbMZL0Mc3qSoHsLL9gRZf05h4t2nVUICCBdWSIzUi63WkPLEUJgTnvvw0jDdY5XxLOJ0O1sRiKY9/Zx1TBJzzujCEUKUDbO1NuW//q6azP0SMjNbRbYlxfOmSRhuFp4fWxYa2M70MF4l5u+tuTe+hudR1mHnEZIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506040; c=relaxed/simple;
	bh=5zHelJe1bDK28iLwFY1cCNY4u2Gkk8i8u7Slp0npj9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rqRX+cM357ec9VetlH5D1aDL6NxP4ovJLgwP68lZdytaYXvXjKN2Qrn6D8v0Ud/+LupjNQ2y5nDX9Jy3ai3ENoXE7qdSTDJMqTxUpoEpAZiGEHqHgpTXAKbOrnfjGEc3SY9eKakQkonsrD5asIpgvvsph4MhIx2pF9lTIZ0J5Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7DcycQb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729506037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aa4j0hvqQ8YIdEGwaAmQadfFJ+eIOZ3R8RkFSPeDBa4=;
	b=g7DcycQbnUMHj9fQP562o0aMfTDmtJSAxLZFGCBbR3OL5SWjGZsAi1qdzHLDK37ryuChNZ
	3vqUM/aHcUXCp7kr66/1FnzxFrnbrB7c6efTdHrh6wg7Yi1xmlZKhAVl6YEU6rzvEJ0zW6
	nPqy3JA9/rTtjrMKNmVNGs0elY/kBW8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-Knp44OaLMompCvjKH9P_eA-1; Mon, 21 Oct 2024 06:20:35 -0400
X-MC-Unique: Knp44OaLMompCvjKH9P_eA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d4d51b4efso2090558f8f.3
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 03:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729506035; x=1730110835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aa4j0hvqQ8YIdEGwaAmQadfFJ+eIOZ3R8RkFSPeDBa4=;
        b=vogEyX3m88jzoycZDWUau9qH70ThWiwHOoXP5lgfnPPZaXQR76a7GuUUu7HtcOjzcg
         cWmyRFLBIp3srdZGnZVzfQWmZtML8Xh7Iedf/t1qtVZyJsuK7qMFbyGcVdRYohLIcz0Z
         lmD+tZlLhAooRQklj2ts95BznKIUAvnHaOLh9kirBS2BIcKO3MWj+lWfovqL0OYOmac7
         KeE7vQDJv/3xZvEBEF+fp63KPkRsQDRvCJ10LyRMQ/wqt94E5kjZ0wJ3THKigk760SUX
         RXF1/j6KOJ9QLcDESgolyyxpYTeBmNU9LKE8MA6i0zqYJ6ZsddXfTYqul+07PPzeup/r
         6jcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAECWgpTQ9H4IDpXxoXD7S4j3d77JpwExEjZxSlQHRh1LQOP23f2PhmUxzvbKJWvvF5gID4Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDbLVphQTdIUhIFTv1QrqVhxSamRgR/4l+EjcAb31iSi/MeKKz
	1Hv1Pjwz0tlc7qtCP7IzEjrtyrLqrr0lM6BC/kY4EA9j9BzuCTT6H/HyTylqHkMxkPNvlSqifwo
	0bWEXzCRDbvBZUHhjAneFnuIkao3Ov21tSHdbwDTDF3b+nVJK1vx3Aw==
X-Received: by 2002:adf:e948:0:b0:37d:4846:42c3 with SMTP id ffacd0b85a97d-37eab6e36f4mr7408555f8f.22.1729506034692;
        Mon, 21 Oct 2024 03:20:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNHYycRfxM/0v/040xU61cqanOhA3NX8yirVsJjQsqWI4Oasit0M3UBZJ+KkxPthi+0+9uLg==
X-Received: by 2002:adf:e948:0:b0:37d:4846:42c3 with SMTP id ffacd0b85a97d-37eab6e36f4mr7408539f8f.22.1729506034334;
        Mon, 21 Oct 2024 03:20:34 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bb42sm3917637f8f.98.2024.10.21.03.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 03:20:33 -0700 (PDT)
Message-ID: <71a20e24-10e8-42a8-8509-7e704aff9c5c@redhat.com>
Date: Mon, 21 Oct 2024 12:20:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 02/10] net: ip: make fib_validate_source()
 return drop reason
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com,
 bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org,
 dongml2@chinatelecom.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, bpf@vger.kernel.org
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
 <20241015140800.159466-3-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241015140800.159466-3-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/24 16:07, Menglong Dong wrote:
> diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
> index 90ff815f212b..b3f7a1562140 100644
> --- a/include/net/ip_fib.h
> +++ b/include/net/ip_fib.h
> @@ -452,13 +452,16 @@ int __fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
>  			  dscp_t dscp, int oif, struct net_device *dev,
>  			  struct in_device *idev, u32 *itag);
>  
> -static inline int
> +static inline enum skb_drop_reason
>  fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
>  		    dscp_t dscp, int oif, struct net_device *dev,
>  		    struct in_device *idev, u32 *itag)
>  {
> -	return __fib_validate_source(skb, src, dst, dscp, oif, dev, idev,
> -				     itag);
> +	int err = __fib_validate_source(skb, src, dst, dscp, oif, dev, idev,
> +					itag);
> +	if (err < 0)
> +		return -err;
> +	return SKB_NOT_DROPPED_YET;
>  }

It looks like the code churn in patch 1 is not needed??? You could just
define here a fib_validate_source_reason() helper doing the above, and
replace fib_validate_source with the the new helper as needed. Would
that work?

> @@ -1785,9 +1785,10 @@ static int __mkroute_input(struct sk_buff *skb, const struct fib_result *res,
>  		return -EINVAL;
>  	}
>  
> -	err = fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(*res),
> -				  in_dev->dev, in_dev, &itag);
> +	err = __fib_validate_source(skb, saddr, daddr, dscp, FIB_RES_OIF(*res),
> +				    in_dev->dev, in_dev, &itag);
>  	if (err < 0) {
> +		err = -EINVAL;
>  		ip_handle_martian_source(in_dev->dev, in_dev, skb, daddr,
>  					 saddr);

I'm sorry for not noticing this issue before, but must preserve (at
least) the -EXDEV error code from the unpatched version or RP Filter MIB
accounting in ip_rcv_finish_core() will be fooled.

Thanks,

Paolo


