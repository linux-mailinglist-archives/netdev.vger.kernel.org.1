Return-Path: <netdev+bounces-106951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF85918421
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF062882CE
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9B9187345;
	Wed, 26 Jun 2024 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qctz0S2B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37A318733F
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412088; cv=none; b=qvk5DFq/WqJdu7PuguIwVwU/KKcHNJSGytpB1S3X1CurIwvwzUniYsurU0EGvFtedWgfZ+hO7ZxmRmQhddpIOwbW8GOcVYYrYay8H5H4YtWqCbTn88kS+8RALwnxf58AepB0C8hXSHyEtI9VdxKHs2XcMEGD6QzQAeSCXPIXgqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412088; c=relaxed/simple;
	bh=dF3nJbyec7aUYb31LCk5J9ZCr9e/ue/Sn4wrfJGLEL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usyk1qCcqHKVJnGP5dghiOjiVDJBS4xsbOZ5yhFgZZK8bamCBwvtKEYaVoGH6zOmYcP7karXOFRETiHO6v757sF3elc9H1ectv4TDTLPmxHxM9z6LMsMOwM51Q3npxV2ZnyvZRJ3rHnztr+533dplqNZFuUKajY2D3ZBrAwhJbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qctz0S2B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719412085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8jPj0J2+6kTJRu0AxJQgSeG+pEmf65j6Ho29vmPBJDU=;
	b=Qctz0S2Bx34Zfnx9Uv+rEh5Es7kBcnvQCAMvysrg1dJGa+0Xdz2IuNLkvHef26uKXUva5S
	njG9850vMWoQHw9jKW2dodWdqoCVT+lDL4QGRbhj85y0itD4QOBFZw4TmhcstpydI/6J8f
	V72rsOK9KRBjGULJivr+CLGszOZ1IFI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-XgH3wPpXP4yxyN4miuLWkQ-1; Wed, 26 Jun 2024 10:28:04 -0400
X-MC-Unique: XgH3wPpXP4yxyN4miuLWkQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a72423fa3dcso246971366b.3
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 07:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719412083; x=1720016883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jPj0J2+6kTJRu0AxJQgSeG+pEmf65j6Ho29vmPBJDU=;
        b=IRmCZydZoaDEN8y+ogJaxFj3t5fN+QFOSmbXd1Qq36boBxb9viB5JFEKcg9SgJXA42
         OeTkGn5DWoEm9hQ19/7+z10FMxAx07qOPKVd8RNZnr33gSkZkHZKV+8a+Nu/L0Qv7L0/
         vUTPEfeOryKPqw5hrb5gxl5XK/r4Er6xz2LOg0MrUz55V35XIsUH/XmOGfHqF1Xr19uT
         ERcoZWn/4UuDssa0uGwJ8lYN89VTmdxDjRHU+4DMNV/XsQMOsdLOKUGJUx7xLQhsx9it
         g6FUnRXflxbT7ZzUrS+0vIOeTW01O37wpRub2upnYPkyWe57IIS4Ie7gnxZMu2Om0b6L
         SGXQ==
X-Gm-Message-State: AOJu0YzQ61K6L8v0C23y1VIQk0qq9Vx/OVtuao9NvzMJNKP/0xjZDvWr
	DWBoFWG6J6lVT6K42TCL4xRGtEfh10x0kwYNLHRfEmQmV3H20yni2LUzeZsuSqPAdBoWCgldpzE
	ArU5xnv1AzOs6XIBTcPtkEqH0xIV7ZTCM7XNDgcwnOKCECb74E9rBYw==
X-Received: by 2002:a17:906:c014:b0:a6f:af8e:b75d with SMTP id a640c23a62f3a-a7245b851d1mr961471766b.8.1719412083055;
        Wed, 26 Jun 2024 07:28:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRwKHSPitdNxRFuz2PdFIYEAZOxC++8wpkD/ze8BDJXhQooiarqlGFh2Bq7AH3sSiyJanfKw==
X-Received: by 2002:a17:906:c014:b0:a6f:af8e:b75d with SMTP id a640c23a62f3a-a7245b851d1mr961470266b.8.1719412082642;
        Wed, 26 Jun 2024 07:28:02 -0700 (PDT)
Received: from [10.39.194.16] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724ae806dbsm383611766b.41.2024.06.26.07.28.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2024 07:28:02 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, horms@kernel.org,
 i.maximets@ovn.org, dev@openvswitch.org, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 02/10] net: sched: act_sample: add action
 cookie to sample
Date: Wed, 26 Jun 2024 16:28:01 +0200
X-Mailer: MailMate (1.14r6039)
Message-ID: <73D32BC8-93A2-455A-AD9D-1FBB17553F8E@redhat.com>
In-Reply-To: <20240625205204.3199050-3-amorenoz@redhat.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
 <20240625205204.3199050-3-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 25 Jun 2024, at 22:51, Adrian Moreno wrote:

> If the action has a user_cookie, pass it along to the sample so it can
> be easily identified.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  net/sched/act_sample.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
> index a69b53d54039..2ceb4d141b71 100644
> --- a/net/sched/act_sample.c
> +++ b/net/sched/act_sample.c
> @@ -167,7 +167,9 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff=
 *skb,
>  {
>  	struct tcf_sample *s =3D to_sample(a);
>  	struct psample_group *psample_group;
> +	u8 cookie_data[TC_COOKIE_MAX_SIZE];
>  	struct psample_metadata md =3D {};
> +	struct tc_cookie *user_cookie;
>  	int retval;
>
>  	tcf_lastuse_update(&s->tcf_tm);
> @@ -189,6 +191,16 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buf=
f *skb,
>  		if (skb_at_tc_ingress(skb) && tcf_sample_dev_ok_push(skb->dev))
>  			skb_push(skb, skb->mac_len);
>
> +		rcu_read_lock();
> +		user_cookie =3D rcu_dereference(a->user_cookie);
> +		if (user_cookie) {
> +			memcpy(cookie_data, user_cookie->data,
> +			       user_cookie->len);

Maybe I=E2=80=99m over paranoid, but can we assume user_cookie->len, will=
 not be larger than TC_COOKIE_MAX_SIZE?
Or should we do something like min(user_cookie->len, sizeof(cookie_data))=


> +			md.user_cookie =3D cookie_data;
> +			md.user_cookie_len =3D user_cookie->len;
> +		}
> +		rcu_read_unlock();
> +
>  		md.trunc_size =3D s->truncate ? s->trunc_size : skb->len;
>  		psample_sample_packet(psample_group, skb, s->rate, &md);
>
> -- =

> 2.45.1


