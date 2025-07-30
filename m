Return-Path: <netdev+bounces-211051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64984B164ED
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 18:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43AD188B536
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 16:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B449A2D838B;
	Wed, 30 Jul 2025 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVrGFOIs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB9F1A4F0A;
	Wed, 30 Jul 2025 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753893954; cv=none; b=H7py4nDDHrTgVisYOj8S97BO2h7chGxdeI4EuE6mRyL4fp6Cxg+G4YtwjAX+yAx90EfOfARYEnbUgBvIBdAWdsD3kclrCQPEN1C7H0dfEJYb1B+4Rl1GrbNMfEbip6mJcN04cqx37z3s6NKRgeiyjz+EiI+abpDGJcX/9V8eHAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753893954; c=relaxed/simple;
	bh=5gIz02rnAb42b1p9cBg+FThC0U29PUwlOovNhPnbVj4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bXH5i0zDAvyUz3bjHhzqueHukPiggcAFymngkabBsNw5Pyji/XogNKQFYvlrI/aN9n8wMywFULwkpN4hDs1KhXkS/AWGEmM64Y0Lv5YWjjJn6Ooiq35aELfN9uhliDe/GrXiDxoDuTRJCkDKS3FQvXWbvoZqHvAiutwhDNRu2tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVrGFOIs; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7183d264e55so173967b3.2;
        Wed, 30 Jul 2025 09:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753893951; x=1754498751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KwYqyq8/GeDTiwgxhq5r9d0jGsySNnWpnQCh6DhsHw=;
        b=SVrGFOIsrl0w3unLJ/2jJc31YU6w9Fswx7SSfqdGN0MfwI+6vxAeo2oYKA0KYBJcE7
         xpAEuTN5kwbKA1T8jT6S8NIO7S6yD3wjJsq8rlK0ArZ5vq5O8YKeZoh10X58l6cdyaGA
         UElUd7ItRPoNxNXx5iXM7wkmtzBXbEmKPdpPKUaor8wXDTzHUdrSRDE0GUGkK1OBkzth
         cxLiETgeTCW/s2pU7Jk4L5agYH5moR41kd7kWuVEl7VyKswvPjL6FHBYkJBnM54rVq/B
         z400gwG9LredBDQg+kl0cGjMgwHKfVSpKoxwIEcr3cY9LsGGofsbL3hB29AfnFU0BqFG
         /vjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753893951; x=1754498751;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+KwYqyq8/GeDTiwgxhq5r9d0jGsySNnWpnQCh6DhsHw=;
        b=vwPgg5+Yj0HPESJqL++Ym0q9zXlaffY2kQi9nyAdK9HfRMbo/KeUKjuLfwl9nBkObR
         +FtnlEb1Zu+r4DQBm1tEAkN8I8v/GUgDes/q9or2oWpJv9hdSeTd14DAijoFTyoGG2jo
         zpM73iV9EHksuZxubr1kKpxEfG43IRJrLDEuDQoT9APdxrYWZAFhWkV8N5LH6YfaOGkZ
         vu6tpTSypfy51yxUY87IfUbDc33oV2Lu0TeQQcU/cFdoQcIXxRAt5yahVjW/32r+8+ph
         lo1artwDJfFqNtw1tH+80y7xx1tZfqp9/2SaMbLxydageT5mklgezi5UcaUZKOgoKpCa
         iCog==
X-Forwarded-Encrypted: i=1; AJvYcCVVMfRkh4ZxmXdqcirX7atoXYPcIYiVEPiKxHj5cpNZEP86eRR9e5KMCvdOVxn5TkQpGv98usdr13D4ZzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUXhaXU8wlUHQ+e0EQrfJIrjeO2ECf6R+SKTzHN1bwxgA117F1
	/zEtFVou/sn97TLnSSmM9FrjS3mmlw3KBD7fP5WAmrk+R8/7NHEYt+G4
X-Gm-Gg: ASbGncvfHDDbr9iZHVVwyZ1PkqosmhAKCSjlgz4LmQ4KOk8N+HEdHJEDy3LWY0t1tx4
	PGP67vke/XpPCfaqc2kfJzxaBwpxIyjTRskgolzdtEToDXKBeD+sdSPcB6fMTav1UD5vfwQ1Y14
	oPPoYFG4CG1WxsJUTLaT8VTwNLq+zfSP3hErBNHzb+y58Hs+GQnJ9VEFh7Itfg67YW9LyMB65Jy
	aDz9T0cpWs8T1paKa5cfZJhnOqXXzOLxICzLB8BssHvs7jPO2GjswOEKd4hk18VRYejETyiJA+9
	b/lwiRs3/YhXYK41VQiz+GdeFVWUmhS4y2w+fLD5Vt7WLrS/ZOKe46drk9gh+1pS4d3xgpqPCIA
	+2/lJ7CT+UopGx9mcIXo4UfvXevGGKB9Y78hv0IVRM9V28mNQD0rc/RCBWcz4dppdfyzsTA==
X-Google-Smtp-Source: AGHT+IHBclhRaerazqNaE2k/PAHPAtsaCjH+bPrNg3pTDsrhpMJ9eHEvg3kdRZnGeb4d6I7Q86DG0A==
X-Received: by 2002:a05:690c:f0e:b0:70c:aa00:e0ec with SMTP id 00721157ae682-71a466680acmr58827397b3.21.1753893950525;
        Wed, 30 Jul 2025 09:45:50 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-719f2961641sm25034617b3.43.2025.07.30.09.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 09:45:49 -0700 (PDT)
Date: Wed, 30 Jul 2025 12:45:49 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: zhangyanjun@cestc.cn, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 zhangyanjun@cestc.cn
Message-ID: <688a4c3dd337_1cb79529426@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250730092940.1439637-1-zhangyanjun@cestc.cn>
References: <20250730092940.1439637-1-zhangyanjun@cestc.cn>
Subject: Re: [PATCH] tap/tun: add stats accounting when failed to transfer
 data to user
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

zhangyanjun@ wrote:
> From: Yanjun Zhang <zhangyanjun@cestc.cn>
> 
> To more accurately detect packet dropped, we add the dropped packet
> counter with the device when kfree_skb is called because of failing
> to transfer data to user space.
> 
> Signed-off-by: Yanjun Zhang <zhangyanjun@cestc.cn>

Net-next is currently closed. For networking patch process, see also
Documentation/process/maintainer-netdev.rst.

> ---
>  drivers/net/tap.c | 14 +++++++++++---
>  drivers/net/tun.c |  9 ++++++---
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index bdf0788d8..9d288a1ad 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -759,6 +759,8 @@ static ssize_t tap_do_read(struct tap_queue *q,
>  {
>  	DEFINE_WAIT(wait);
>  	ssize_t ret = 0;
> +	struct tap_dev *tap;
> +	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  
>  	if (!iov_iter_count(to)) {
>  		kfree_skb(skb);
> @@ -794,10 +796,16 @@ static ssize_t tap_do_read(struct tap_queue *q,
>  put:
>  	if (skb) {
>  		ret = tap_put_user(q, skb, to);
> -		if (unlikely(ret < 0))
> -			kfree_skb(skb);
> -		else
> +		if (unlikely(ret < 0)) {
> +			kfree_skb_reason(skb, drop_reason);

kfreee_skb_reason(skb, SKB_DROP_REASON_NOT_SPECIFIED) is equivalent to
kfree_skb().

> +			rcu_read_lock();
> +			tap = rcu_dereference(q->tap);
> +			if (tap && tap->count_rx_dropped)
> +				tap->count_rx_dropped(tap);
> +			rcu_read_unlock();
> +		} else {
>  			consume_skb(skb);
> +		}
>  	}
>  	return ret;
>  }
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index f8c5e2fd0..eb3c68e5f 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2137,6 +2137,7 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
>  {
>  	ssize_t ret;
>  	int err;
> +	enum skb_drop_reason drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  
>  	if (!iov_iter_count(to)) {
>  		tun_ptr_free(ptr);
> @@ -2159,10 +2160,12 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
>  		struct sk_buff *skb = ptr;
>  
>  		ret = tun_put_user(tun, tfile, skb, to);
> -		if (unlikely(ret < 0))
> -			kfree_skb(skb);
> -		else
> +		if (unlikely(ret < 0)) {
> +			dev_core_stats_tx_dropped_inc(tun->dev);

I don't think counters need to be set in these recv syscall paths,
where an error is communicated through the return vaule.

> +			kfree_skb_reason(skb, drop_reason);
> +		} else {
>  			consume_skb(skb);
> +		}
>  	}
>  
>  	return ret;
> -- 
> 2.31.1
> 
> 
> 



