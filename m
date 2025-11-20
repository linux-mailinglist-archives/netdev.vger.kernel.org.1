Return-Path: <netdev+bounces-240342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2A4C73827
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 11:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 988BB354AB2
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 10:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A797B307499;
	Thu, 20 Nov 2025 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Af2Z4mrj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDpUylQz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F0D26E6F7
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763635442; cv=none; b=sW/j6ef0JFC6SnOY77Od03f7MN7XcQWnRGjka2RJ44n6gyUBIqBCEutPSKAKoo+oVeYwQlWvgW9cfvkGndQ+RxWyEYtdar5GJ0nIZaup06zGmP8Ijtmb714ovvGloRlwnx5D4eUK3bE0vKJEFjBajwx2AG406mOqxH6Yl0AEUhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763635442; c=relaxed/simple;
	bh=0CiiO9j0xkb0mo5fLo8ag9H5ivXz95o7qymjM9S+1jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbWS+iQT7BgX9cmt+nrrL3C+1fqFNly3TDfzmWffp4RmFLgHZrvPPW9AgUhDW2vbIbKrvVm4uqzO8Kc+ZVTX8+qHkXNIp2MAGylEn3EpmToyG245jDdcI1YQmWQQ8EtKy2iMXVZCq14JyBLsAzdf5HObPge+kVIDk4WFlcdOy/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Af2Z4mrj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDpUylQz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763635435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8y1jPHiAwVo3dkS7PWUJ32CmlpzzI2xRMMetRTLKqec=;
	b=Af2Z4mrjgLiecTLOJG7G+smTb6E70Rb/kL39tX8iUVGRLMO9JLvtFL2gGyg/su5X3lAIso
	iBAyJXiPm6AIONtFQlH3KUXoNL05G/ANR2jhHT20LUKra9t8e4JesOPEU7wuoZOW6ifDIA
	ZIrIVqAwWiIgTdgXZ3EtPtWFKmwptlc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-xto0pqeXO-uSNFTkhSOFdw-1; Thu, 20 Nov 2025 05:43:53 -0500
X-MC-Unique: xto0pqeXO-uSNFTkhSOFdw-1
X-Mimecast-MFC-AGG-ID: xto0pqeXO-uSNFTkhSOFdw_1763635432
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779981523fso8892675e9.2
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 02:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763635432; x=1764240232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8y1jPHiAwVo3dkS7PWUJ32CmlpzzI2xRMMetRTLKqec=;
        b=MDpUylQzcUQLl5LJ15FssQue3sv+OWkcdzZngyrvSkPAVgr/i5PkgsCKjTI/kr+BvA
         3prBObj17KkdQRTSoHs/pW3N87WQunaADAB6W+p+Y2c6jTbshj05N8FopJre0s5KJ6Zh
         fBeUak1yNQNOrMaJOAteYAFn/u9qSYVG3KLFRIZSd/IoQIy3+mC9yynmZFd5oWvTG6KY
         nEavtO0bkBTLwP9c6Zo3Gnzyt/ftVmmz8hdw+b4V2dh1TNjGS2OhRnblQC0UZIpxbMbC
         0CsqAImZSXeHoQFoUFd9n8qsJuNQMmD1iTue+0wWZ8pUcFp3XMEdBBS108Nu4rQLuF/Y
         AghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763635432; x=1764240232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8y1jPHiAwVo3dkS7PWUJ32CmlpzzI2xRMMetRTLKqec=;
        b=mfH1QSBPifYoVKRWzPDl22Sg7+RKgjOVrKeO6O/ykDsqjustoJ+NiaDdoSBH7RVEtx
         SeNI1GsAAD4OgtlIOcu8IgMy3psHDjq+y4t1x1PDvhuPO3aDFafYnv9xIDZiBb9eLKIh
         1+PQsAc0ps305+SdIj/IVhrbed6QyK1SRgO/oqrBNKCH5KWdkag6el84ecUs31p38B25
         837ssLESkUmsIVHL4HMNrc5bVPUYoeq5MKY8oM3qm37nQ0/mrFdxoLYVAkL5JOIFIdyd
         Wc4aOuTj6zuHvpxbRDP6ep61zqVI5O78mvg9IuYer8cZerxEwQb35uw3X43zQZIT+K8H
         CL5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+fyEJToSAKGc7abRLi1++3xH8HjHmODUxpfi6+szY2lo9/028RLQRQFigBtUidUUHPSw3XKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe2Zo6Opg0NrbVKh40Yi5/B2yWdCE+hXa7ViMEmtQEy+/dNBo/
	4d9O9+ogsR2pXpshHc8Ka2FHf2o6lvWeSJfo+5Ib6QXT9/YPkU5NTXO9gApsr/MHl9tslb/6vPC
	MLFZU9CrzR1ESaHbGjYn88iN0p3p4wfsOAIQjpNs6adI6lIP9D4G34XbTDQ==
X-Gm-Gg: ASbGncuUUdHxzgpEVY/Sd829LeBiWff0/EbvmZX4Z66jFyXsgN/2nVP5ytlWUjLmu3t
	KB1SoRXPj86t8lpV7Z3t2gMHst1kK9vG68orHlpCloFweaaM+b2nlMeLYSU+z/Voxp6q7idxvSV
	Kdaz9df36TsJOP+TmEnCmIcd1KSj+3oyzOLtQZTIexGpZYjA7GE57jULbeTbsuQxreyLXmOxzoH
	UQAENxqMFdz+/UXYXg7EXbJ3n6uRVP1U2YQajl5NCvQdfKX/PFi9B8/pMwN73GtYt1rtNqxUIk6
	EsfrVJCQoHaPyWFJHMLVulsOgHNl0qaCxvDfpPn2ogv30b5SFItT1HxREWLapMM9HpDLFtjk279
	QstGoxhzothPK
X-Received: by 2002:a05:600c:4449:b0:477:abea:9023 with SMTP id 5b1f17b1804b1-477b8953f82mr21394935e9.9.1763635432117;
        Thu, 20 Nov 2025 02:43:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGR1Ruk2Gj51suzzS5y4BcXGGtt9pWyX/QRlRypsMh/5NKSs6sTrfUKJWhyNZl7GGOZM7Fmcg==
X-Received: by 2002:a05:600c:4449:b0:477:abea:9023 with SMTP id 5b1f17b1804b1-477b8953f82mr21394645e9.9.1763635431713;
        Thu, 20 Nov 2025 02:43:51 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b8314279sm41801585e9.11.2025.11.20.02.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 02:43:51 -0800 (PST)
Message-ID: <98bbac96-99df-46de-9066-2f8315c17eb7@redhat.com>
Date: Thu, 20 Nov 2025 11:43:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net/rds: Give each connection its own
 workqueue
To: Allison Henderson <achender@kernel.org>, netdev@vger.kernel.org
Cc: edumazet@google.com, rds-devel@oss.oracle.com, kuba@kernel.org,
 horms@kernel.org, linux-rdma@vger.kernel.org
References: <20251117202338.324838-1-achender@kernel.org>
 <20251117202338.324838-3-achender@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251117202338.324838-3-achender@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/25 9:23 PM, Allison Henderson wrote:
> From: Allison Henderson <allison.henderson@oracle.com>
> 
> RDS was written to require ordered workqueues for "cp->cp_wq":
> Work is executed in the order scheduled, one item at a time.
> 
> If these workqueues are shared across connections,
> then work executed on behalf of one connection blocks work
> scheduled for a different and unrelated connection.
> 
> Luckily we don't need to share these workqueues.
> While it obviously makes sense to limit the number of
> workers (processes) that ought to be allocated on a system,
> a workqueue that doesn't have a rescue worker attached,
> has a tiny footprint compared to the connection as a whole:
> A workqueue costs ~900 bytes, including the workqueue_struct,
> pool_workqueue, workqueue_attrs, wq_node_nr_active and the
> node_nr_active flex array.  While an RDS/IB connection
> totals only ~5 MBytes.

The above accounting still looks incorrect to me. AFAICS
pool_workqueue/cpu_pwq is a per CPU data. On recent hosts it will
require 64K or more.

Also it looks like it would a WQ per path, up to 8 WQs per connection.
> So we're getting a signficant performance gain
> (90% of connections fail over under 3 seconds vs. 40%)
> for a less than 0.02% overhead.
> 
> RDS doesn't even benefit from the additional rescue workers:
> of all the reasons that RDS blocks workers, allocation under
> memory pressue is the least of our concerns. And even if RDS
> was stalling due to the memory-reclaim process, the work
> executed by the rescue workers are highly unlikely to free up
> any memory. If anything, they might try to allocate even more.
> 
> By giving each connection its own workqueues, we allow RDS
> to better utilize the unbound workers that the system
> has available.
> 
> Signed-off-by: Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>
> Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
> ---
>  net/rds/connection.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/net/rds/connection.c b/net/rds/connection.c
> index dc7323707f450..dcb554e10531f 100644
> --- a/net/rds/connection.c
> +++ b/net/rds/connection.c
> @@ -269,7 +269,15 @@ static struct rds_connection *__rds_conn_create(struct net *net,
>  		__rds_conn_path_init(conn, &conn->c_path[i],
>  				     is_outgoing);
>  		conn->c_path[i].cp_index = i;
> -		conn->c_path[i].cp_wq = rds_wq;
> +		conn->c_path[i].cp_wq = alloc_ordered_workqueue(
> +						"krds_cp_wq#%lu/%d", 0,
> +						rds_conn_count, i);
This has a reasonable chance of failure under memory pressure, what
about falling back to rds_wq usage instead of shutting down the
connection entirely?

/P


