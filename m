Return-Path: <netdev+bounces-284976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFE3KJx9+2mEbwMAu9opvQ
	(envelope-from <netdev+bounces-284976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 19:42:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BF54DEF28
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 19:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFAC2302BE9B
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 17:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE714A2E3A;
	Wed,  6 May 2026 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J5LcNXTR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8C8494A11
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778089274; cv=none; b=nT0/Uw5CzqMn/RGSXiBCNHpGwDU/y4mRp4nOyuqHRiyLyvajYpZkkz2C+uhPCANxd0ZNXmByehA7SEnfJ0Tk0vO3h3BKojIxM7XMO5BhHhk5YBSKv7AyU2/1B8Cg/0/Yec/4zpe8W/28+FBwBe6C/H1l2QM9iv6P93AQKqXPN2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778089274; c=relaxed/simple;
	bh=CNDVMs2g44OOALJLbhRj4fQcQCZpgA2XFMKIvRoQG1k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ET1i3c3n3XR4skTiWYOg7/+K2Ur9K2FxwRmwEW40A3RNextGvaXXT3WmGT7V+c/pOSFo+ov3bOJaZdUtqi7taXRnggNXha/p40UdogmhoVgI6mI6oLvYgWwNpphVKWpkZB3GLBold5oLQLPW4LHuihBkwHjLxcvRfsEIUlbXbiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J5LcNXTR; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-835444b6ce1so2292627b3a.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 10:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778089272; x=1778694072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EVLRHK5k2sEtaI2YLFXLrFGfYMl/u3dp5VYAJAZSchg=;
        b=J5LcNXTR1TyxVi/GsX2z6DbjtqS4B5lDjXGfZqhy/lEjsap45HaOyZ1gQIuiWJQOXQ
         l0hPW5gRNd2AsvlHnpTslyTN4aigAeKveW8XPY9vsVDXTCJzmJfovtAdg0N4Q6J/6k6T
         bIphMxYmfiKggj56Qij5xCq7pQ9Sc+avGFmwmHztH4ZGHdN0RYd5Z6sgUkC5zfxx0Tst
         S0jWsHgEpFd0Zf/2AgxkX+N+s3Xb4e5rZYuf+Fd61237o3uaXrBceb2T3Ii2ARgbNSL1
         yIjHVjVQz8yG8Y7R5uexWm0yzvjH7td6C9MEilxa95jvkfWsc5CdOxpKIkgIKV+pDgYF
         iWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778089272; x=1778694072;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVLRHK5k2sEtaI2YLFXLrFGfYMl/u3dp5VYAJAZSchg=;
        b=gluf/UNq8pUEc+jgj02Ss8hR7As+D89nNK9P3x9NTqQ5oVabnyVxH63oGGG+gKXnUw
         rHxJdH5kXhb+gcYjCBo8iw7j03zUIoJB8IBo5ks08ppXeRMi3GQSE7qn+YwvFejgBP4P
         oysK6l8bo/s0Eip8bMQuarV2wxIcFSBsmZ3gqEMuoZhM5MgwU6SkKzo2hWvq0SS9H3de
         tdRDGSbX0bPQ77CvqeMeYNJFyOLLqHvT6tBiILF6zlt7hunvEbN8ZfumbtaNyciKN/uM
         Fnpq11OQA7xFMJV/GXlDJQE8yJF91eyEKH7T9qpUNmh9oDtv5iTcgckh1iBd3cZ6o1io
         U1PA==
X-Forwarded-Encrypted: i=1; AFNElJ+llsqfLx9N7xmw50cNfgksF8+HvyvMvirSEOvtnak4Caj5FMCvaZsnlifhcdu3y3wQw8CnX9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfW/NmYzLArrHw7/eKulCb/u84oozhB1XGS/z3ymqw2lr9r8kP
	/QDldY+v1YE/+QCZzD1Wy7aHxqI8kYglVIQw/sSPh7DSz47XpFzbPP7CSf8oq+77OLxpoIu/hiP
	CUv/0gQ==
X-Received: from pfdi19.prod.google.com ([2002:aa7:8b53:0:b0:838:1469:2431])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b48:b0:835:351c:f236
 with SMTP id d2e1a72fcca58-83a5d09a78dmr4187183b3a.29.1778089271899; Wed, 06
 May 2026 10:41:11 -0700 (PDT)
Date: Wed,  6 May 2026 17:41:07 +0000
In-Reply-To: <20260506100107.388184-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260506100107.388184-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506174111.2245555-1-kuniyu@google.com>
Subject: Re: [PATCH] macsec: defer RX SA cleanup from RCU callback to workqueue
From: Kuniyuki Iwashima <kuniyu@google.com>
To: alexjlzheng@gmail.com
Cc: alexjlzheng@tencent.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sd@queasysnail.net, shenyangyang4@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: F3BF54DEF28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284976-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: alexjlzheng@gmail.com
Date: Wed,  6 May 2026 18:01:07 +0800
> From: Jinliang Zheng <alexjlzheng@tencent.com>
> 
> crypto_free_aead() can call vunmap() internally (e.g. via
> dma_free_attrs() in hardware crypto drivers like hisi_sec2), which
> must not be called from softirq context.
> 
> free_rxsa() is an RCU callback and therefore runs in softirq context,
> causing a kernel crash when the underlying AEAD implementation
> performs DMA unmapping during tfm destruction:
> 
>   vunmap+0x4c/0x70
>   __iommu_dma_free+0xd0/0x138
>   dma_free_attrs+0xf4/0x100
>   sec_aead_exit+0x64/0xb8 [hisi_sec2]
>   crypto_destroy_tfm+0x98/0x110
>   free_rxsa+0x28/0x50 [macsec]
>   rcu_do_batch+0x184/0x460
>   rcu_core+0xf4/0x1f8
>   handle_softirqs+0x118/0x330
> 
> Fix this by splitting free_rxsa() into two parts: the RCU callback
> now only schedules a work item, and the actual resource release
> (crypto_free_aead, free_percpu, kfree) is done in a workqueue
> handler running in process context.
> 
> Add a destroy_work field to struct macsec_rx_sa and initialize it
> in init_rx_sa().
> 
> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---
>  drivers/net/macsec.c | 13 +++++++++++--
>  include/net/macsec.h |  2 ++
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index f6cad0746a02..dabd3d2598ae 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -174,15 +174,23 @@ static void macsec_rxsc_put(struct macsec_rx_sc *sc)
>  		call_rcu(&sc->rcu_head, free_rx_sc_rcu);
>  }
>  
> -static void free_rxsa(struct rcu_head *head)
> +static void free_rxsa_work(struct work_struct *work)
>  {
> -	struct macsec_rx_sa *sa = container_of(head, struct macsec_rx_sa, rcu);
> +	struct macsec_rx_sa *sa = container_of(work, struct macsec_rx_sa,
> +					       destroy_work);
>  
>  	crypto_free_aead(sa->key.tfm);
>  	free_percpu(sa->stats);
>  	kfree(sa);
>  }
>  
> +static void free_rxsa(struct rcu_head *head)
> +{
> +	struct macsec_rx_sa *sa = container_of(head, struct macsec_rx_sa, rcu);
> +
> +	schedule_work(&sa->destroy_work);

rcu_work is what you want.

