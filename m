Return-Path: <netdev+bounces-306526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lbybHrnYUGrc6AIAu9opvQ
	(envelope-from <netdev+bounces-306526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:34:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E4873A497
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:34:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=GzcaPLYd;
	dkim=pass header.d=redhat.com header.s=google header.b="U/KvVqan";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306526-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306526-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D05C9304CA4B
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17923A451E;
	Fri, 10 Jul 2026 11:25:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546AF416D19
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 11:25:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682757; cv=none; b=TQfFm+zsBUDwQC2Lj85dqxuLikydGfc35l4EKTKHPZzuDxtQegXukkSuHbm7YKFoMT6uKzkca9zYAP6GgO0/bHMZq/hOBdrF3QhenTqEX/MdQp5+OfV9IZaNcaVkCzPUitSXvngl6IYUPnVVBnne9lqsv6UcYeTHPn5d5BGq1A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682757; c=relaxed/simple;
	bh=+O+11YFkdR9m/DePEM0XGB3bOHAzHPG87B7si8jQV+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHEn6yVfyOP6g7ToRrn/fDxG6UrT4HRqKQXVvVZRDPsa+i4IivRqSDgyM31TDuC1TRCT+GJMk/CxApBbUc4H4XjpBLNYf5vwm6qoIc/d0o+nMkATWyWisGBn+RVurnbbw1VoVrgor2HlyLKZIaaq1DDC/6t01AMVzeuXA/zU6Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GzcaPLYd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/KvVqan; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783682750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GnpNr4qDyHoNfCA9ul8yyjujzs6stkD93LOWV1wBtX4=;
	b=GzcaPLYdk8gWU6NHu4Ga3NABE6sGenZl+2wRYIXJK4mUrDlxcrS+wOyWWLagycwQnxzEPQ
	dMr5s1rBx5Q1Uz5e1KjTNASaWPihY+shC9l0t8uFrMd4tzjdE/2hjYEZgBmRik80jF0Rzz
	AEtBhagqXwpoEZatLUOort3pHcCrBy0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166--tdvSjwLMTGqsjDr2-OD-w-1; Fri, 10 Jul 2026 07:25:49 -0400
X-MC-Unique: -tdvSjwLMTGqsjDr2-OD-w-1
X-Mimecast-MFC-AGG-ID: -tdvSjwLMTGqsjDr2-OD-w_1783682748
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4729d2a64efso1100490f8f.0
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 04:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783682748; x=1784287548; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GnpNr4qDyHoNfCA9ul8yyjujzs6stkD93LOWV1wBtX4=;
        b=U/KvVqanNrJvUDoGPkv6jPbxvd9cenAPVqwmR41CQlt1xPFWD6t22GK6q7mA2fC2zz
         wkT7CMlIrjsDgQj9jqnIXgtDGD1XbG9hXWzmfL7zyu/DaX0fYCi2WWa1Oi+AFT0aNyi3
         CKb0sxctn+8K3mUILhDuoAv8xvOFq3Z8wD8NWC+k4sYZB3EnC/kdxQ5S3Feo7lqoCc/N
         U2V+dJrcSxuYQ2womTf4h2b/GAoGd7Ryga/lsqs1IDxkztE1h8yeGz4Lh/xaJNAgYnuM
         MfGWDlYapVbpIixP6VTYD1hnO5x+QPnFAKrWAoJjl1pBlBo2YqR43hh5d8IvNHqRAR5g
         F7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783682748; x=1784287548;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GnpNr4qDyHoNfCA9ul8yyjujzs6stkD93LOWV1wBtX4=;
        b=swyesOOXjqb4YVgWPLZSiK+jSHM6obHis9XLm87XwuDJI0/dDgEeeEyOIwwbTlhGLM
         TWWsmcCAmfSfMdwGElQMixNn3oNZlvBWR214EPEYMfS7t6etgJw13GTg47KNcYz+skJG
         oEEHuPeezB0RRarro5oTDlFtZXZf87uHFU8MQioKNOMJEJ3lGo7hzTLgxBOXoKIOz0XL
         9EbPpEnRvjykRO8rcRBS0u4/cS+7XTyWuLk/CU1DV2/gsZO3MALVp3tXfu2ffISJDjY/
         qX3Y4hrGX0SuVr5CcmoCkGJ6GSOUaLqx6nb+bGfEop0nMvAXhs7uHakL74K9NrUNEGcQ
         hjFA==
X-Forwarded-Encrypted: i=1; AHgh+RqU+rSO2W8JbvQkHqJG3Sr98t3Rlpyp0ap/UyIZ4Dm07frfKsADWGzurbLN2BDm+sXwZV2bhwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoqUdn0sKoHI3YQPn9awsB722oRhklMbnUdqayXtiRWZk4RhAN
	9y82RPLTRZehIPSkzhd9bptEjTJ7qysdso3AeGLWrN7HsdH+lHthe8IdyC+uWx3AB1t0IJlPvaV
	kbGgLNTZJHC+RQLALJyCWDdiiTPhI2KFnmGcaakEIEq86f8VETqpuljfDWg==
X-Gm-Gg: AfdE7ckMqxyvUnZI761ATfr94sjeVlMhhllxId5Kwu2T/yvjW6OR0beN1eVhBmEHqBW
	4oar1+S04RtkmELqfgKi51zYU6jln19IGUvT+qunXAGMwzEEr/68x+MzBEorZa8OmL/x4iSUnlk
	yalPihTLpso6aY1RE/UXBcdjDAAZKCeEjw/TJp1ruwfIsB3nVu/Zu3L0DSGj7f3X/aNQzsfN4Zj
	yMkuaV4HDFZ0HQiceg0ftJQyFw5tgwrQckHeLPoHTWxF7KRc506+4ZMrCwUPPJNB7Os7cfEsAk3
	1jqsEo8BknfBuwL1GZsE2dmvg/Tek5CbosL58yQqwSIKLkFxvpSz3sGn6PNQ7sP7ywDMpiiF0VC
	Jx0cJBnlOUvZ3zeUDT5S4q9fZiqE38JBIr0ijYjrLtGN62thhg9Ye1m3cFr8ksMoA5uzWNtGXWs
	xrRTAB09YRcPOd
X-Received: by 2002:a05:600c:3115:b0:493:b4a3:5ab0 with SMTP id 5b1f17b1804b1-493f2b3fe2amr28786255e9.13.1783682747893;
        Fri, 10 Jul 2026 04:25:47 -0700 (PDT)
X-Received: by 2002:a05:600c:3115:b0:493:b4a3:5ab0 with SMTP id 5b1f17b1804b1-493f2b3fe2amr28785735e9.13.1783682747323;
        Fri, 10 Jul 2026 04:25:47 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6d4f9fsm131494035e9.4.2026.07.10.04.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 04:25:46 -0700 (PDT)
Message-ID: <9e4e455b-c10b-447e-9fe6-80672f26fd8a@redhat.com>
Date: Fri, 10 Jul 2026 13:25:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/mlx5: free mlx5_st_idx_data on final dealloc
To: Zhiping Zhang <zhipingz@meta.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Saeed Mahameed Michael
 <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260702222507.1234467-1-zhipingz@meta.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260702222507.1234467-1-zhipingz@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306526-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:zhipingz@meta.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:saeedm@nvidia.com,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:michaelgur@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76E4873A497

On 7/3/26 12:24 AM, Zhiping Zhang wrote:
> Workloads that repeatedly allocate and release mkeys carrying TPH
> steering-tag hints (e.g. churning RDMA MRs) leak one
> struct mlx5_st_idx_data per cycle; kmemleak flags it as unreferenced
> and the kmalloc slab grows over time.
> 
> When the last reference to an ST table entry is dropped,
> mlx5_st_dealloc_index() removed the entry from idx_xa but the backing
> mlx5_st_idx_data allocation was never freed.
> 
> Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> struct matches the lifetime of the ST entry it tracks.
> 
> Cc: stable@vger.kernel.org
> Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> Reviewed-by: Michael Gur <michaelgur@nvidia.com>
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
@Leon, @Saeed, @Tariq: just in case this fell under the radar, it's
waiting for your ack.

Thanks,

Paolo


