Return-Path: <netdev+bounces-104390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 052DA90C605
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5834CB2201C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D878B13A89B;
	Tue, 18 Jun 2024 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2IMN/l+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F794137930
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 07:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696335; cv=none; b=JYz3abB7e3/x8otAMgft0mi2+LJ93oXegzQ3NGRPexoTzx4oYjgxELnc+YDVuRaB03XlwcAvGSo7VvgUNILSHMXWm7MlUUTBuaM3uUw5c+9NlG/9I9odLRSYwxh1A5ejXiepbbcLpJqQzIPxp4UJs44uHuh4NgBhZ3/XK3a3AUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696335; c=relaxed/simple;
	bh=M0YJClBO4I10mGGrQvNSUAkg6JBeDSss0hFeaki0ouE=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LN5f4i2FGJ255mgqGwLJW679MqcmsoM3riXv6sSbPbxl55imuA+Gl0TjFEzieov6gTb0MXvhatvzoVZnuMGuaBhe20Zqs5MYdPaLA8VDdJcuNe5S1AkutKNliVn5nWpUeF1WkyPYHVy5p3sb7cYdSdYnZXnbejMTT9pTayvbAwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2IMN/l+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718696333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vS0L8gNZ+c55CBoTy4Q79OS0/z+oWmaelgdSL3NjO84=;
	b=R2IMN/l+j2Q6zuPMBqDrWSQKRTtgHFenK5EoPSuLZwA1n/CxqPJ+8IiYukKYQMfMc5XQ4D
	X9a0vViytzeoCVa98fyybONHivLktJfTPjiRHhkMtrahB0gqqlGnfqaJ1v9WTpBcwdrP6o
	a59po+Fv+6+ouLMtmp25BUIoj0LWnhk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-b_8aNGJWNm-tYg24ghb7Fg-1; Tue, 18 Jun 2024 03:38:48 -0400
X-MC-Unique: b_8aNGJWNm-tYg24ghb7Fg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b4f761c9a6so3724406d6.3
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 00:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718696328; x=1719301128;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vS0L8gNZ+c55CBoTy4Q79OS0/z+oWmaelgdSL3NjO84=;
        b=UVvNWwQvL1+XtPe6Y2Z/V3zSPrzQM98ffmjL++vHklCWL/6Cr24WvVnL7wHHPAjatS
         FPzy0f09ObOssRM5YE41SLAhxkUFgkX1igTSqSZfDFjhWVzh3PRLDQ0VTBY8U1xBmcLf
         qEcEgOzGmfqcta3pVlNZ3gbDGPToIQ1pJJpWgiWrpKuuyEvWH2yUONDMZCxBtDut5wFi
         S3ePixrh6TdWATewntIWg/TN9ihR0D9aHCNIt8utQliEv+gpNVXAcW/ZStUeoyvg27F2
         E9Wuha6UNrW2BFZ78xHrdXP2LJgjFjkcZRClrn9btNVUT638Fik6GYDy7Qn/jCCNOsAx
         UOJg==
X-Gm-Message-State: AOJu0YwxHr2yQDfe3ZKCq611+gRJDdbPnT/zg1TjCRvJQw4iaX3rXVZv
	heDKMiHpvKpfhdJJNST9iDDIKra6DliGRxkm0XL/XpVMlyWrmMV7e4J47aQF/MhMG4/2+AFwhq8
	ON3xjKQdz9qE6Lxv7xq2/KPCfoe0Ct6jWho/s0ktpunIJQNhbinHCFyP+6cGZXi/ngxmlq9pGmA
	PlOt3RlR7/Whf3UyNv/MbYUJHy5Fa9
X-Received: by 2002:ad4:420e:0:b0:6b0:8c25:abfa with SMTP id 6a1803df08f44-6b2afd8571emr104202926d6.57.1718696328423;
        Tue, 18 Jun 2024 00:38:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3F5G/KHtjnRX2STbBX8sqxnLPA6kAkwk3Iqz/SG8R6aigMHaYs3OJzjUa58lLUtE2JyX2Ynuwxi792BgQ1zg=
X-Received: by 2002:ad4:420e:0:b0:6b0:8c25:abfa with SMTP id
 6a1803df08f44-6b2afd8571emr104202876d6.57.1718696328128; Tue, 18 Jun 2024
 00:38:48 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Jun 2024 07:38:47 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com> <20240603185647.2310748-3-amorenoz@redhat.com>
 <282d4b46-70c1-454b-810a-ef3353f1b0f2@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <282d4b46-70c1-454b-810a-ef3353f1b0f2@ovn.org>
Date: Tue, 18 Jun 2024 07:38:47 +0000
Message-ID: <CAG=2xmMqfBLeFjqzzHG3uHLx9d8sDsdbguxZm8cxbR5nEVDZ7Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/9] net: sched: act_sample: add action cookie
 to sample
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	horms@kernel.org, dev@openvswitch.org, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jun 17, 2024 at 12:00:04PM GMT, Ilya Maximets wrote:
> On 6/3/24 20:56, Adrian Moreno wrote:
> > If the action has a user_cookie, pass it along to the sample so it can
> > be easily identified.
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
> >  net/sched/act_sample.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
> > index a69b53d54039..5c3f86ec964a 100644
> > --- a/net/sched/act_sample.c
> > +++ b/net/sched/act_sample.c
> > @@ -165,9 +165,11 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff *skb,
> >  				     const struct tc_action *a,
> >  				     struct tcf_result *res)
> >  {
> > +	u8 cookie_data[TC_COOKIE_MAX_SIZE] = {};
>
> Is it necessary to initialize these 16 bytes on every call?
> Might be expensive.  We're passing the data length around,
> so the uninitialized parts should not be accessed.
>

They "should" not, indeed. I was just trying to be extra careful.
Are you worried TC_COOKIE_MAX_SIZE could grow or the cycles needed to
clear the current 16 bytes?

> Best regards, Ilya Maximets.
>
> >  	struct tcf_sample *s = to_sample(a);
> >  	struct psample_group *psample_group;
> >  	struct psample_metadata md = {};
> > +	struct tc_cookie *user_cookie;
> >  	int retval;
> >
> >  	tcf_lastuse_update(&s->tcf_tm);
> > @@ -189,6 +191,16 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff *skb,
> >  		if (skb_at_tc_ingress(skb) && tcf_sample_dev_ok_push(skb->dev))
> >  			skb_push(skb, skb->mac_len);
> >
> > +		rcu_read_lock();
> > +		user_cookie = rcu_dereference(a->user_cookie);
> > +		if (user_cookie) {
> > +			memcpy(cookie_data, user_cookie->data,
> > +			       user_cookie->len);
> > +			md.user_cookie = cookie_data;
> > +			md.user_cookie_len = user_cookie->len;
> > +		}
> > +		rcu_read_unlock();
> > +
> >  		md.trunc_size = s->truncate ? s->trunc_size : skb->len;
> >  		psample_sample_packet(psample_group, skb, s->rate, &md);
> >
>


