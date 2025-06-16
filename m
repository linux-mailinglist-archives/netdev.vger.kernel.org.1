Return-Path: <netdev+bounces-198210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 673D4ADBA4C
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 21:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21C71890351
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 19:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3AB288C0E;
	Mon, 16 Jun 2025 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP8SAiWV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBDE136347
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750103082; cv=none; b=EwVuQQjAYWn7SyrYrTC7c4sdEieEmcjYV/+0xikVN/I9xCGoJj9fWMQxfGcgooIbDQ/9H1t7MV4DpnAOq6LWZwRNbM0FoBQXdtDH2NC3kqtiZOaZADf0tvdW2LqlDYXgQTQh7lANtCwVcg27kjhpOHhz4xd14YLbP2zYbkkY8H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750103082; c=relaxed/simple;
	bh=xL+2PjRQFVByGkyoBnq9GjT7WCYlz93y2EiY1b3ggPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2gVQFXl/LaB72MdVFkjCphmwloumGa4FwWb0vz92GWOxPPkMvuh05HFhPMkMifWOnaF5UteqWxs+rwtleEe1hPVxZq50y8hs9xxU1Uko5o3t07+xfzF60ejsz3bbVzfHLlTFo3VfnjbgybyYQwLaL21omFbdVNmxj0GvYIZR7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OP8SAiWV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234b440afa7so49461465ad.0
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 12:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750103080; x=1750707880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UAmIHgQwXzJ/qZVS5iJNNAHTJXQ5DtUTs2VyAV8aSQ=;
        b=OP8SAiWVpcOHQ0MYAF33VkTMXXGqpeudXww59l/pG2WPw20/HYYWxVuVbfcXgHRg6W
         4M47E8rYq7vftlJWZkPzplB26hPddsgbQ9SaJ/BzfqgMZ/NOUmZ/a1bIeS1OXG8PcHfB
         5CG1y/2oczv9Pz+YgVq6rpnNtGJ9QriLDCA2/FohezkuUKj6gtLJ7uzbl4h5ha+x37FL
         usvbYDGLbb3s1fxTKIvR++wV+Oq6CX3Nlmqks1GobTjQwwa503VO/wCju4BCE5MxbZC7
         hJ7WGzvWvkeatluNLFEpvQFvJHaqdkht0Fand5s1kGaXfemdwfpjdqjoRQ4TvnS9M+aQ
         P6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750103080; x=1750707880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UAmIHgQwXzJ/qZVS5iJNNAHTJXQ5DtUTs2VyAV8aSQ=;
        b=LISL1b8AyDAxERtYTfu3989v0QJqpFEWKAV3NqVN6ZZhl/bFHjNcC5gSeAyUAVR/a/
         SRJMJL+EE5eUE8UBhHsmTMEkbZx1a9xRdfj64U9y5XYi5Hh9RnfBwI+MIu3Co3VQIgI1
         sKuhMueIZMjJGFyO7vwpRr47+7IBVUoWDGaeyJUCabLdPDYRzboyTT+FhRFwGNMmf1Is
         G24pZ3MlbHJm/LRuKDfpj5qbSOTSIj+UEbIzEjXL6kIUzAt1eXU7psqFopaqRb3eeJZT
         24MgjxsPJmxvpMI6V2yqeuhJc5skBapWafr4qy8RJukiocwE1TvdhH4K+/FV++9KYv/g
         XcdA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ2cVWMnKBFN0EVZK9fHuxPSUWpKAESdLlXemYIYdIyt3KMaL29DF4E4qtLUwQCOymbhQ8mog=@vger.kernel.org
X-Gm-Message-State: AOJu0YygWGdfuaDTOxtsRq5IFDEYSGSYKBsSWZJh56UYXsIqw5O6smmV
	plFjJIiyz43FNECWLy6+Ct6fJ6alkCrjGO4L+6/k4kQxqwHC5/wBtsA5pd1oGrAMmaYV
X-Gm-Gg: ASbGncuObydr7+s1JngdUonFntWtGXoCQB9fjZT/hKoKGAGPxDk26yBKJrsPVTK5Zrz
	c7Gv6nkTBuRBtR4LYVKTnssac/MkeDuadx8dIOsQAiBskM+dBd7dnPfHvNPLh1XO102yrwNEegd
	eoUBAH0rlIJWmGiYvuoEUDRBO4AYTJyQ+v1NTdHCPZg05O5yjXgBZ9t+Ds4D1+DGD6C48mUlxxN
	CszngB/QqQ+IE9CldSjPZXpThkJq+ZWpFS3BzAuk4MiZKCRdIP/dqcIytaruUDYrnjxLBm5+nPx
	Xn/25XHQFQoWVgwfO5xzhVz2QWWQ84Vs4r87Wno=
X-Google-Smtp-Source: AGHT+IFKMwj5EbVNH2hrYf74WGgSzjJzAQbYl8C+boLjtgr0qpsuLm7EhSUPCNxHp1NUs1AkghbIsA==
X-Received: by 2002:a17:902:708a:b0:236:6f43:7051 with SMTP id d9443c01a7336-2366f4372d9mr109287785ad.23.1750103080240;
        Mon, 16 Jun 2025 12:44:40 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de7836dsm65444915ad.136.2025.06.16.12.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 12:44:39 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: dw@davidwei.uk
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Subject: Re: [PATCH net v1 4/4] tcp: fix passive TFO socket having invalid NAPI ID
Date: Mon, 16 Jun 2025 12:44:29 -0700
Message-ID: <20250616194437.1017381-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616185456.2644238-5-dw@davidwei.uk>
References: <20250616185456.2644238-5-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Wei <dw@davidwei.uk>
Date: Mon, 16 Jun 2025 11:54:56 -0700
> There is a bug with passive TFO sockets returning an invalid NAPI ID 0
> from SO_INCOMING_NAPI_ID. Normally this is not an issue, but zero copy
> receive relies on a correct NAPI ID to process sockets on the right
> queue.
> 
> Fix by adding a skb_mark_napi_id().
>

Please add Fixes: tag.

> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  net/ipv4/tcp_fastopen.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index 9b83d639b5ac..d0ed1779861b 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -3,6 +3,7 @@
>  #include <linux/tcp.h>
>  #include <linux/rcupdate.h>
>  #include <net/tcp.h>
> +#include <net/busy_poll.h>
>  
>  void tcp_fastopen_init_key_once(struct net *net)
>  {
> @@ -279,6 +280,8 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
>  
>  	refcount_set(&req->rsk_refcnt, 2);
>  
> +	sk_mark_napi_id(child, skb);

I think sk_mark_napi_id_set() is better here.


> +
>  	/* Now finish processing the fastopen child socket. */
>  	tcp_init_transfer(child, BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB, skb);
>  
> -- 
> 2.47.1
> 

