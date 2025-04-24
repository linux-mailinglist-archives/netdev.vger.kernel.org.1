Return-Path: <netdev+bounces-185438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22719A9A5A4
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 10:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBC5E7A58A2
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 08:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E4F205AB8;
	Thu, 24 Apr 2025 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWHuAb9Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB497433B1
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745482765; cv=none; b=kiRDOkVfG3zgEhSBi81JbGkIYSGLFAzJHyA8zuGXKVyDSwf1njLsTWOthLKK4GedtAsD0aiINgiaMgUqDxDh6zBOO/7v4cYUafct+vFMPr56RATBrn66+MBmG7hZ7l5CRksMdt+02EHOykxkQfK3D/kYKQSyjbwdNiXJsBpzCpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745482765; c=relaxed/simple;
	bh=T1P9KHALcew+oOqvMsQQkORuKuaJPN7vZ+RkUBItKjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ybh+pK04eznOngEIggbmKjY9SHp1loA6TcVPwp2QgutfjJyqoDUUfS4JEZZPEhBAeCn46vWIvHeXYs9tluJBnfFwogj1fg/oLUT4mh82ws8Bv8rpMzSsoPoDy1dRaFiVCX6D4IbEYbv7ZZMHqbrgxu+noBzjhU9Rz8fuLjWrSWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PWHuAb9Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745482762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J86L4XEnzWVJkJPwDZWkHeRr4Qb0DDaXdtDrfn90t4U=;
	b=PWHuAb9QUCEkPLtqVBN+VX/AmTi+HoR4+OcuR0g3flJGsuuMRmfV7FHuQEG+hiHLU0oEVf
	kfCLISBSzp1F7gacB9nu5bjOXRIakxg63sQBfaX5Darvo6gPQtWhP+UPa/ahV2B4awp3h/
	dSofudBEiX34i4lq+9WLdPz+KnSGx28=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-m90Sl7bsMbqvHWwICsI_eg-1; Thu, 24 Apr 2025 04:19:20 -0400
X-MC-Unique: m90Sl7bsMbqvHWwICsI_eg-1
X-Mimecast-MFC-AGG-ID: m90Sl7bsMbqvHWwICsI_eg_1745482759
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43f251dc364so3753135e9.2
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 01:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745482759; x=1746087559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J86L4XEnzWVJkJPwDZWkHeRr4Qb0DDaXdtDrfn90t4U=;
        b=OS1tFPzAgvLnWtIPRftl4e4NpNFSQA2pa2hx0Tm3jvdtsZjgqSao0pVbyn+sMH27L+
         AAsd4vM8BFkoV5tntnsK0qPROHEoqOPP2Kzwneycvbr5VQw8sFC2PKU9oY5zkK3blDT5
         BwbBecgzRE/X++hSvdaQX0miT+Gwic6G7qAp60TAZSdzi38lPpQnJ7zY+A7EYBUvE4gb
         lpGfvo7OD9h/jFo4phxIutted7mQ7lUOe2XH9ftrKVEp7MiPMQIRzHaLYr/JUPwtqc1W
         81Fd3GXPzgeAm7al9NRbDhFkwoodH6XdJg4gtPCnFkmKW65LmLUTe8MjA4wOvCC/YrLd
         9jBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK0cV70W1ieUGyFAlp8FGXBGGhPFyJXgU6roND5sE69ya57q6z1Rpo8LWMkNCDJveceU2Cf/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdtzrw9tn5LKxrhWzEwhH2Y+lA8WDbq4QGrdRaqdOOp5xwwVRW
	dp40DtmNNZvs+0SDlJkImoevMCO5p/8EtSBjeMYW57OM/Ac+kCj2pauI85Qe0mh3J65xgf65h9m
	SgYBJClc3OULMZcZ64oBw6WEcJyDFmq02ppag9qJSQcbTuawudyjrvg==
X-Gm-Gg: ASbGncuNPZgfsKqh0+rdZu51XG5ru01JBJt3oy1vBdolFdqzlg4LXtL3FoSoU1zGEXr
	Twd+jV5mIEgLRGIPy8eeCYIMRuRt3SlMiJ9PkF8jHCAYtyRV16EiTjJkd2BED4bxV8RNLG2bIBO
	0YL6gqME2sGVvoG1lEjnxYyMmbVnqlhHeEuH1+tKKFH0XxZA86HP1SAgyKeuHNMNIOxNY5d8yBe
	YTfguHj3SGbkEI/JO6+/ZDALXqvsxqB2aF8DGW47MRjHwIGFdYB3eRk6aJHtWK6keQuJ2k8FIFp
	GEoR2p+r9OhmV4mTqxe20WHs+WK4pqiv7g7/6xQ=
X-Received: by 2002:a05:600c:a47:b0:43d:4e9:27fe with SMTP id 5b1f17b1804b1-4409bd10250mr12185465e9.8.1745482759175;
        Thu, 24 Apr 2025 01:19:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx8gELt+RPS2i7N/C3QjHHPWA6nc1Yuy7RRy+sscqwT+pL9+ZUnq0XzkC4Utjo/QQbfCpMQw==
X-Received: by 2002:a05:600c:a47:b0:43d:4e9:27fe with SMTP id 5b1f17b1804b1-4409bd10250mr12185235e9.8.1745482758799;
        Thu, 24 Apr 2025 01:19:18 -0700 (PDT)
Received: from [192.168.88.253] (146-241-7-183.dyn.eolo.it. [146.241.7.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d4c30e2sm1234755f8f.48.2025.04.24.01.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 01:19:18 -0700 (PDT)
Message-ID: <bc67444d-3311-43b0-8f68-131e1ef490c7@redhat.com>
Date: Thu, 24 Apr 2025 10:19:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 6/7] neighbour: Convert RTM_GETNEIGHTBL to
 RCU.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250418012727.57033-1-kuniyu@amazon.com>
 <20250418012727.57033-7-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250418012727.57033-7-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/25 3:26 AM, Kuniyuki Iwashima wrote:
> neightbl_dump_info() calls neightbl_fill_info() and

AFAICS neightbl_fill_info() is only invoked from neightbl_dump_info()
and acquires/releases the RCU internally. Such lock pair should be dropped.

> neightbl_fill_param_info() for each neigh_tables[] entry.
> 
> Both functions rely on the table lock (read_lock_bh(&tbl->lock)),
> so RTNL is not needed.
> 
> Let's fetch the table under RCU and convert RTM_GETNEIGHTBL to RCU.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/core/neighbour.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index ccfef86bb044..38732d8f0ed7 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -2467,10 +2467,12 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
>  
>  	family = ((struct rtgenmsg *)nlmsg_data(nlh))->rtgen_family;
>  
> +	rcu_read_lock();
> +
>  	for (tidx = 0; tidx < NEIGH_NR_TABLES; tidx++) {
>  		struct neigh_parms *p;
>  
> -		tbl = rcu_dereference_rtnl(neigh_tables[tidx]);
> +		tbl = rcu_dereference(neigh_tables[tidx]);
>  		if (!tbl)
>  			continue;

Later statements:

		p = list_next_entry(&tbl->parms, list);
		list_for_each_entry_from(p, &tbl->parms_list, list) {

are now without any protection, and AFAICS parms_list is write protected
by tbl->lock. I think it's necessary to move the
read_lock_bh(&tbl->lock) from neightbl_fill_param_info() to
neightbl_dump_info() ?!?

Side note: I guess it would be to follow-up replacing R/W lock with
plain spinlock/rcu?!?

Thanks!

Paolo


