Return-Path: <netdev+bounces-107131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6F291A01F
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 09:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5EC21C210EE
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 07:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9997D47A6A;
	Thu, 27 Jun 2024 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFTlp68b"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2637481BA
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 07:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472444; cv=none; b=e2n0W/r2OmFvr8fwFOOF52Gtno1wkbQ33VBljep/JjZDYOHqTaZuXlv/icQ8YkE4lG6t49Bfcj19BC5ekQynggXeDaGYt9dUXpMaKlmNBqxPSgWpPdBMff2XbO6cDtk6w6T8zsDkrzphcSNlPJM7vnCbOpSLCX1q3Klfx9JJBEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472444; c=relaxed/simple;
	bh=VMJBxQD9REIrxLJDpD4xQrW09qN51w4QiBwEmm1GCu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCkP63pMhcpvFh+B2J6qlo+GgqCJR0t71oD9/H6dM9/zT7WhbAh6Cf7+qOaKsdYA8r05CkBirnqJRWaL039Qsh0ceDLhT+pItd//SsWqg0UU25b1OgUmXVOrVqRZSEyexnM2AOzlNhBXOETyA0ep+mNTkWDcxRkgIUINR7/+Zsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFTlp68b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719472441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMkjE2Y21QEc6G14/ezzQvk/4DCifcPtz9GXgH0AUPA=;
	b=OFTlp68bH+jzH4K6UWtEHV631k/oNeAQj+p194VV3+saK9jEFTqnIbMcd/USfeExFtCsWe
	dkfm5TP8tUTj3Un+JXb2Nw1ucyEe3GO9rO7mWpDOongUZrZOiQ4WtB3a03GC/LgoSKEs4e
	QPpGwR3Hl6fO76Uyf22LLfsNqa/b2v4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-8uhs_ymjPU21uh7htWEU4Q-1; Thu, 27 Jun 2024 03:14:00 -0400
X-MC-Unique: 8uhs_ymjPU21uh7htWEU4Q-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-57d3eca4c01so608158a12.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 00:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719472439; x=1720077239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMkjE2Y21QEc6G14/ezzQvk/4DCifcPtz9GXgH0AUPA=;
        b=EyXyQb9n5eNx89KL9i55w52jDA0mIa/169HsCRumEXjPHHXEMKd4PojatGHFhC8aIJ
         aEX8zKSOOjgXnUa+JUZDZZns4Q+WDMAVZRstoAz7vuMt7Dw6vRbQ3XIvsFzi/z6ex7sO
         pJp7nQeb/odxYJ5+rxQ3f08I0CIslRt7GKuzym8fwdvNBLMyYxmer7FAeuzesmx5iCyM
         I8cYvWab5Gr54twb73NBV44aoUeDGCgn1C3/8NSm2OwtuWHJ65PKP7Flcf04DDx9qjxc
         lJz3Hd5X1tEKis7U6Q6X5EZR7DQKPv0fyGH7eTfksK7xGOKMaq0y13c8sRRkcKv9a2oW
         tvIQ==
X-Gm-Message-State: AOJu0YyzZX11KmWfthYG5DfXbldWm9ubcFq97IGAbhe1iWhH09jSX0ch
	Zv4VS55iVZhQ0Kiui93qEP/ZEaq+ulmjHoM2Ln9oAIGNPkzaoNqq8wZNA+jYlh+1LfZFo7EGvGt
	W+rVzMTE5MUMGM/OIvnLLvUM0Yf5qfPRbfWlA2PcG6xYVKelvIKOBbQ==
X-Received: by 2002:a50:8e14:0:b0:57c:abe1:8266 with SMTP id 4fb4d7f45d1cf-57d4a01f39emr8396886a12.29.1719472439008;
        Thu, 27 Jun 2024 00:13:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTb10kznlY9/AB/ICr9UZqpuzvFp5YRm6rs9v0xk4bJ9mVXiaiHliGX6RnaREtgUwcvhL4fA==
X-Received: by 2002:a50:8e14:0:b0:57c:abe1:8266 with SMTP id 4fb4d7f45d1cf-57d4a01f39emr8396858a12.29.1719472438571;
        Thu, 27 Jun 2024 00:13:58 -0700 (PDT)
Received: from [10.39.194.16] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-584d16bbfc6sm490054a12.51.2024.06.27.00.13.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2024 00:13:58 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: =?utf-8?q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, horms@kernel.org,
 i.maximets@ovn.org, dev@openvswitch.org, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 02/10] net: sched: act_sample: add action
 cookie to sample
Date: Thu, 27 Jun 2024 09:13:57 +0200
X-Mailer: MailMate (1.14r6039)
Message-ID: <99A14DCC-2F9B-4770-927F-075978141D8E@redhat.com>
In-Reply-To: <CAG=2xmNjY8gRwLyoVzSHiU2yOotP7rguOuf4hdTicnCbw=38XA@mail.gmail.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
 <20240625205204.3199050-3-amorenoz@redhat.com>
 <73D32BC8-93A2-455A-AD9D-1FBB17553F8E@redhat.com>
 <CAG=2xmNjY8gRwLyoVzSHiU2yOotP7rguOuf4hdTicnCbw=38XA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 26 Jun 2024, at 22:06, Adri=C3=A1n Moreno wrote:

> On Wed, Jun 26, 2024 at 04:28:01PM GMT, Eelco Chaudron wrote:
>>
>>
>> On 25 Jun 2024, at 22:51, Adrian Moreno wrote:
>>
>>> If the action has a user_cookie, pass it along to the sample so it ca=
n
>>> be easily identified.
>>>
>>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>>> ---
>>>  net/sched/act_sample.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
>>> index a69b53d54039..2ceb4d141b71 100644
>>> --- a/net/sched/act_sample.c
>>> +++ b/net/sched/act_sample.c
>>> @@ -167,7 +167,9 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_bu=
ff *skb,
>>>  {
>>>  	struct tcf_sample *s =3D to_sample(a);
>>>  	struct psample_group *psample_group;
>>> +	u8 cookie_data[TC_COOKIE_MAX_SIZE];
>>>  	struct psample_metadata md =3D {};
>>> +	struct tc_cookie *user_cookie;
>>>  	int retval;
>>>
>>>  	tcf_lastuse_update(&s->tcf_tm);
>>> @@ -189,6 +191,16 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_b=
uff *skb,
>>>  		if (skb_at_tc_ingress(skb) && tcf_sample_dev_ok_push(skb->dev))
>>>  			skb_push(skb, skb->mac_len);
>>>
>>> +		rcu_read_lock();
>>> +		user_cookie =3D rcu_dereference(a->user_cookie);
>>> +		if (user_cookie) {
>>> +			memcpy(cookie_data, user_cookie->data,
>>> +			       user_cookie->len);
>>
>> Maybe I=E2=80=99m over paranoid, but can we assume user_cookie->len, w=
ill not be larger than TC_COOKIE_MAX_SIZE?
>> Or should we do something like min(user_cookie->len, sizeof(cookie_dat=
a))
>>
>
> I think it's good to be paranoid with this kind of things. I do,
> however, think it should be safe to use. The cookie is extracted from
> the netlink attribute directly and its length is verified with the
> nla_policy [1]. So nothing that comes into the kernel should be larger
> than TC_COOKIE_MAX_SIZE.

ACK, confirmed that [1] seems to be the only way to set the cookie. So th=
is patch seems fine to me too.

Acked-by: Eelco Chaudron <echaudro@redhat.com>

> I guess if there is some previous bug that allows for the size to get
> corrupted, then this might happen but doing those kind of checks in the=

> fast path seems a bit excessive. For example, Ilya argued in v2 [2] tha=
t
> we should avoid zeroing "u8 cookie_data[TC_COOKIE_MAX_SIZE]" to safe th=
e
> unneeded cycles.
>
> [1] https://github.com/torvalds/linux/blob/55027e689933ba2e64f3d245fb1f=
f185b3e7fc81/net/sched/act_api.c#L1299
> [2] https://patchwork.kernel.org/project/netdevbpf/patch/20240603185647=
=2E2310748-3-amorenoz@redhat.com/
>
> Thanks.
> Adri=C3=A1n
>
>>> +			md.user_cookie =3D cookie_data;
>>> +			md.user_cookie_len =3D user_cookie->len;
>>> +		}
>>> +		rcu_read_unlock();
>>> +
>>>  		md.trunc_size =3D s->truncate ? s->trunc_size : skb->len;
>>>  		psample_sample_packet(psample_group, skb, s->rate, &md);
>>>
>>> --
>>> 2.45.1
>>


