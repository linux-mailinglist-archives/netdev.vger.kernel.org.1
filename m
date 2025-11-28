Return-Path: <netdev+bounces-242608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE4EC92CBE
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 18:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B24484E1882
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 17:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078262F25F0;
	Fri, 28 Nov 2025 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IP7LF5Tr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n1Ym+1d2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5FF32E6B1
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764350718; cv=none; b=nmgpBETwzDZauU2DnyO3p+i5B2H2bAdv1pJh7JVa5lWugtgy8ZO0l4gkluQnUNfXt5UACcDMf1/2Cg6n2aM/BhzihmA3Rq+1uKzs4pdfn/Aa/Nt2mhK2rfwJ8Qm510kcjuj7uSmZPTvB7RjR+SAxl03Se8mO6tZFaK/HyFLynR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764350718; c=relaxed/simple;
	bh=IDOen+zp+MZ2o9Zal7G8NLw4+m88M9NJ3+ryz7+6A0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hD3VusSvHjAzEtauW1JxhAFb1CywEKFkueqpLYAsKGoWWV0qEkp4csaOiyLn2Ba8QEbXZIUhqBA8YqxPwjARx7pZZBv7eqVmsIcdsu2v/0F5AarutJosulBGd0ZSjql4/VrB437uhYVxpQuuq4eZzxOgBmnNE99wMBAudVwZjoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IP7LF5Tr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n1Ym+1d2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764350715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d+6FGgGTpCWQIjPM0Fz8eUK8BxZno3Aj2TgFR0GgPXM=;
	b=IP7LF5TriUFyLgAyDsq1JucDLS0aQivNZqrGZXG20FCZrqqzinjMqgWF6wFLV5IR2ZYiuK
	lmEgKmK2+/585FU1UWIHmFQfSOleQd1McC4DVHxFI7CooRSu2B7GTqd5+xEbemYed5V0H7
	nZKs6XnP/pGjZFbDeuMxMGoqY/PCjSU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-30k2l6HrPDiTr_yGOe_Ngg-1; Fri, 28 Nov 2025 12:25:14 -0500
X-MC-Unique: 30k2l6HrPDiTr_yGOe_Ngg-1
X-Mimecast-MFC-AGG-ID: 30k2l6HrPDiTr_yGOe_Ngg_1764350713
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477cabba65dso12791735e9.2
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 09:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764350713; x=1764955513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+6FGgGTpCWQIjPM0Fz8eUK8BxZno3Aj2TgFR0GgPXM=;
        b=n1Ym+1d29NJLVgk5EN9nwoLyuQQW6Ra/HBrrONtYQLtdQ/5Ba66o0+TcrfaWkv4zS6
         oQYmUL3Xu5EHIOpmdfPZ7HFvTfmfvUu7+QiNxBfgNzbcFpijJePuP/UG/VuigHFVJZZr
         c9OOQw/lCKCeLtA7Eq6j77Cq1NGslUxPu4VOZTWgIaVmEi7UQYtytTv/0GVAD10baxh9
         bdl8ZeyyI/Jd8jrH2Pce14r24r5E3OTjV/UPIit0sy2YEQMKgLYgIfvj1+rRiWJBciDu
         o2orsG0ne4fxO8VUHJljz2VqU3G/AT8Cq6XmkOOeypxvaHLTQ9D2wsNlGtPCx5j2/yQi
         N23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764350713; x=1764955513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+6FGgGTpCWQIjPM0Fz8eUK8BxZno3Aj2TgFR0GgPXM=;
        b=dopwxF/Y2iDsZ2bGICeMgtmiMpxH2GYVtkSKv2ratgOlXKMurDuiDU4QfN3hcWZ8ME
         Wg3fJkdO1xMGPWklJAgVqNTAHmeyqbujmjOmNPuXTJhDdWJUU1J37oN1/gC4C8tEu4i0
         cOPUtoDOVERtHLENbrdLIdVnWA+3S7MyTQL5bu9j8ucJhsTn8869zpi9ZbTpAGpcWaqO
         WiziGcsKEtTI1VsQlCSpG5jZsp9li1EC2cg2edYM77tlER9SanMwV6K4WeOwPdGWsSur
         BEbprZ/XW8Sh676QYYy2Nzm+CoyBPNlk4d0vgqNe9fnU4vDhek/+rrO6frw3Sy46WpNE
         3uag==
X-Forwarded-Encrypted: i=1; AJvYcCX3cdv/11te86CBXIMd8khv3FMlcjBVm8F67qaf0mHuCKnNLfB2gqeNDfke2ZHAQrXIJVSeRg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcgc33X/RI/kBRWGp2TimUXymsDQ/ap8xGS9VNIfuf1FyNggH+
	E6xNn4tOFPNOnCSWj87cdCcU18iiLJX6OReC8Mk84lqALI5mGpze7E4wvvsu+8dDce3GvrLVREz
	bbAaG+eXaxVppNxkjNL4AgmKNJYUp9LwKM+gLUl4arImuLNQX/UI6HM/eEQ==
X-Gm-Gg: ASbGnctdAxh2LueH2dKfb2QWln9b09AFRsJAYbMD9AVil0Wn8dGW4/a0S4OdUX7eKj7
	V/S9EOoYjrdtjKfdEImR2yxjXRqZZtL5k+RqTq+SlPSOkqvArz3Wi/IMo8IlYooDtl3ct6+BvUI
	hc7kdXU89ptpbho59czQZfLXATdVGUpY6Kv2gtbV1puYZb/gKXijjC7UVqMWRHLurRIrBNuzLNT
	eDuOyzxYntcN/t8cneRuvpM8W2iheh+ghOVjWxQPWVEXEGb8YXfN7kVAYg0VW/KEdlZynmIMcsj
	viYC57XZTx9i1xECF7NpMnid/0YENauRPrANSTUU/iVnzMn6PD9b+DecHeKEyzwr5I4ppiJx/Df
	XX5087JA=
X-Received: by 2002:a05:600c:190a:b0:477:76cb:4812 with SMTP id 5b1f17b1804b1-477c00ef528mr348180555e9.0.1764350713002;
        Fri, 28 Nov 2025 09:25:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2yi88Vj3eck9wTHa76To0MCRdTO84c+KdcMzvMB6gS4bHEQ3Pdsxqj8G1RhEpeLuMBx+oZA==
X-Received: by 2002:a05:600c:190a:b0:477:76cb:4812 with SMTP id 5b1f17b1804b1-477c00ef528mr348180175e9.0.1764350712425;
        Fri, 28 Nov 2025 09:25:12 -0800 (PST)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790b0c3a1dsm166595915e9.10.2025.11.28.09.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 09:25:11 -0800 (PST)
Date: Fri, 28 Nov 2025 18:25:10 +0100
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	netdev@vger.kernel.org, horms@kernel.org,
	zdi-disclosures@trendmicro.com, w@1wt.eu, security@kernel.org,
	tglx@linutronix.de, victor@mojatatu.com
Subject: Re: [PATCH net] net/sched: ets: Always remove class from active list
 before deleting in ets_qdisc_change
Message-ID: <aSna9hYKaG7xvYSn@dcaratti.users.ipa.redhat.com>
References: <20251128151919.576920-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128151919.576920-1-jhs@mojatatu.com>

On Fri, Nov 28, 2025 at 10:19:19AM -0500, Jamal Hadi Salim wrote:
> zdi-disclosures@trendmicro.com says:
> 
> The vulnerability is a race condition between `ets_qdisc_dequeue` and
> `ets_qdisc_change`.  It leads to UAF on `struct Qdisc` object.
> Attacker requires the capability to create new user and network namespace
> in order to trigger the bug.
> See my additional commentary at the end of the analysis.

hello, thanks for your patch! 

[...]

> 
> Fixes: de6d25924c2a ("net/sched: sch_ets: don't peek at classes beyond 'nbands'")
> Reported-by: zdi-disclosures@trendmicro.com
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/sch_ets.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> index 82635dd2cfa5..ae46643e596d 100644
> --- a/net/sched/sch_ets.c
> +++ b/net/sched/sch_ets.c
> @@ -652,7 +652,7 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
>  	sch_tree_lock(sch);
>  
>  	for (i = nbands; i < oldbands; i++) {
> -		if (i >= q->nstrict && q->classes[i].qdisc->q.qlen)
> +		if (cl_is_active(&q->classes[i]))
>  			list_del_init(&q->classes[i].alist);
>  		qdisc_purge_queue(q->classes[i].qdisc);
>  	}

(nit)

the reported problem is NULL dereference of q->classes[i].qdisc, then
probably the 'Fixes' tag is an hash precedent to de6d25924c2a ("net/sched: sch_ets: don't
peek at classes beyond 'nbands'"). My understanding is: the test on 'q->classes[i].qdisc'
is no more NULL-safe after 103406b38c60 ("net/sched: Always pass notifications when
child class becomes empty"). So we might help our friends  planning backports with something like:

Fixes: de6d25924c2a ("net/sched: sch_ets: don't peek at classes beyond 'nbands'")
Fixes: c062f2a0b04d ("net/sched: sch_ets: don't remove idle classes from the round-robin list")

WDYT?

-- 
davide


