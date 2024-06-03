Return-Path: <netdev+bounces-100081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 786E78D7C78
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D742C1F22C25
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 07:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84048374FF;
	Mon,  3 Jun 2024 07:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqX2pWYU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF53447A4C
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717399808; cv=none; b=UeZTtKgMZcu9qhZXQx4KJyRSnUiviH/5jqGEdycoM+66VrDJeVRUmKT4lz7jreKR1gcgmrreOEEBG9rWOn+vhxSedmIN0R1KdHGeakH2LP5+cToaA1Rp0WEbydPS/PzeVhXFIDy7lDdIzn1pwf5ukrdQWMvTEmfcfw6xABZN6hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717399808; c=relaxed/simple;
	bh=TBaGszon3mFIeXU68gQM5CDSneTfzPvNaj6TyqTP1Q8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kH5SsVwx4J0uWPrz95iQSBjMRzQABfvAt5bqzelul5KL46rRW9zhlcGnyDwfk3U/0ZBwg/JWWUJ2rLvBFOfI0TFSXlolCORwDfD3WjRwZcpXQ1ODotXwEqhfr5qTR1+ri72Q4y+Nko1B8pbQD4PQ/O8K40HX0JAkRKnv+Te7NNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqX2pWYU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717399805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ouM0sg5bJmUOXnAkDCV0pxODjPk5RxFX/OfwRyv9Vzs=;
	b=fqX2pWYUiIEgFJC7iiDY5wCFXw3/HVv/kHNwIx2yv41Ca4OAUKTS8mBNlxca8eu4j2aQSN
	YqsboQ05NGxghHO+cU+RzsVY+XTecJdAiP90P/q8cEeC8w30XxVIYNEt+EMDl7PRlyXXvR
	PIF0wznjL2dutLqy3sturyWNDIKb8qs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-WpVhBr0lNVq_s_hd1kV90w-1; Mon, 03 Jun 2024 03:30:02 -0400
X-MC-Unique: WpVhBr0lNVq_s_hd1kV90w-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-702543bf7bbso2117540b3a.2
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 00:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717399801; x=1718004601;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouM0sg5bJmUOXnAkDCV0pxODjPk5RxFX/OfwRyv9Vzs=;
        b=Dt2AJsJzC3rvmP+za+4gw8HXzrQ6jL3lJrn5WWOJvfDsfwSntjnKeWBC8SKnYQUaO0
         4senO3kjDiz63HSbDXRPQi7ULHNQGUUQPP6gZ6ZdqrWrvFFAiGRtI8/UBID0ZSMloD1X
         EKQGB+M2Xe/Ub3gdwh9djPJBUCMG5a6lVPIWzo7RM2AmaJQsdCw0/3T0jTsxMPdZTmrr
         A1AJEMJZwsRf6NA+MyEQxVwlNvdIb1yGFcP2hUEXbl3m2Ps4ZFyiirxslGWyEPes2SVu
         PIW3HOtkM6AVzra1OpkGhu6b94KTLJpsFu049ofL4MpAE4vTjK/b1sB31szoMRtZ6ezC
         MqJw==
X-Forwarded-Encrypted: i=1; AJvYcCUzDlYboJzTEXTZUN5RGz7CA2/XK9E0ebLD8eOGBwcgt3IewBCm+Y+qQPWdA8ruGuUYYPYr1FGdKHQ/AG1HNU+7H5uJEzWd
X-Gm-Message-State: AOJu0YxlLa5U26B3Azs1JmTYV+dDdBLgiDp6Nq6wCq7sofs70qzlEM8v
	2lrJ4W2XhQBgcHXKSs2t5VJlO1BY+2BdCMEUb9ebE6OPr/WgjkV6nV5faXWhdvffnTL/RhqNKhB
	fwqOPl5SF7gxldt5vtKWUclAUtGt197jP46V0iuKvNa/zksgc7Nvq6g==
X-Received: by 2002:a05:6a00:98a:b0:702:3a47:2b1b with SMTP id d2e1a72fcca58-7024780ceefmr12740156b3a.20.1717399801185;
        Mon, 03 Jun 2024 00:30:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpkWa3SzJr0Rdd/mO37tXK8peMm9jhly2t+o9IOFzY7JHX4dNSgYjdYw2iplWMW+34Bbottw==
X-Received: by 2002:a05:6a00:98a:b0:702:3a47:2b1b with SMTP id d2e1a72fcca58-7024780ceefmr12740132b3a.20.1717399800748;
        Mon, 03 Jun 2024 00:30:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423cf27fsm5085996b3a.12.2024.06.03.00.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 00:30:00 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 3728113850D8; Mon, 03 Jun 2024 09:29:55 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, David Ahern
 <dsahern@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 2/4] net: ipv4: Add a sysctl to set multipath
 hash seed
In-Reply-To: <CANn89iL8P68pHvCKy242Z6ggWsceK4_TWMr7OakS3guRok=_gw@mail.gmail.com>
References: <20240529111844.13330-1-petrm@nvidia.com>
 <20240529111844.13330-3-petrm@nvidia.com>
 <CANn89iL8P68pHvCKy242Z6ggWsceK4_TWMr7OakS3guRok=_gw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 03 Jun 2024 09:29:55 +0200
Message-ID: <875xuqiivg.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> On Wed, May 29, 2024 at 1:21=E2=80=AFPM Petr Machata <petrm@nvidia.com> w=
rote:
>>
>> When calculating hashes for the purpose of multipath forwarding, both IP=
v4
>> and IPv6 code currently fall back on flow_hash_from_keys(). That uses a
>> randomly-generated seed. That's a fine choice by default, but unfortunat=
ely
>> some deployments may need a tighter control over the seed used.
>>
>> In this patch, make the seed configurable by adding a new sysctl key,
>> net.ipv4.fib_multipath_hash_seed to control the seed. This seed is used
>> specifically for multipath forwarding and not for the other concerns that
>> flow_hash_from_keys() is used for, such as queue selection. Expose the k=
nob
>> as sysctl because other such settings, such as headers to hash, are also
>> handled that way. Like those, the multipath hash seed is a per-netns
>> variable.
>>
>> Despite being placed in the net.ipv4 namespace, the multipath seed sysctl
>> is used for both IPv4 and IPv6, similarly to e.g. a number of TCP
>> variables.
>>
> ...
>
>> +       rtnl_lock();
>> +       old =3D rcu_replace_pointer_rtnl(net->ipv4.sysctl_fib_multipath_=
hash_seed,
>> +                                      mphs);
>> +       rtnl_unlock();
>> +
>
> In case you keep RCU for the next version, please do not use rtnl_lock() =
here.
>
> A simple xchg() will work just fine.
>
> old =3D xchg((__force struct struct sysctl_fib_multipath_hash_seed
> **)&net->ipv4.sysctl_fib_multipath_hash_seed,
>                  mphs);

We added a macro to do this kind of thing without triggering any of the
RCU type linter warnings, in:

76c8eaafe4f0 ("rcu: Create an unrcu_pointer() to remove __rcu from a pointe=
r")

So as an alternative to open-coding the cast, something like this could
work - I guess it's mostly a matter of taste:

old =3D unrcu_pointer(xchg(&net->ipv4.sysctl_fib_multipath_hash_seed, RCU_I=
NITIALIZER(mphs)));

-Toke


