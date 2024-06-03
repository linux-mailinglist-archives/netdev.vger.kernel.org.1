Return-Path: <netdev+bounces-100102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFF58D7DF3
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 10:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3185280D5F
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 08:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DD274E0C;
	Mon,  3 Jun 2024 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNfIUPAj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A254D5AB
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405106; cv=none; b=GOYBapZxDrvWBEa95jHHCU0DIM/TNwOfjFDzBhA1X6zb++/yFDMo7Xvbk3w0yGrJQ49/irFu/L96btG9HRS/UfHbOGELnr9EOIrxGsXa4uU2LA6H7BDH90hxOuu0uVwS3+d07ucNEL9sreVKDiHJG+Zn5MmUtkf3zJ5sXfUUoL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405106; c=relaxed/simple;
	bh=3i3E8RRKap5CWomximA2ZEYLluwcbVjp7hbN04PsZPM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QMRoTGe4xgt6/uIZBhW5vtYkgkUYfwsTTwIhus6ZuOBlA1MsnjYjuos4PFXNZBD5n5TC0HLUR7SZ3qIzFxQv8vUqlREDv7C734CSyxxKEWibKlnJo7jlVmTsbi2k06lWeHi9kZzN0nJnPqPs3Ipj1Gk1JDaMEsvwL0nlbVGIox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cNfIUPAj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717405103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Bhn4LN4Utz6rMqbLj5uOU8MQzPT/pjrzVh2Wyx//Rg=;
	b=cNfIUPAjXzxEzDg+Hg5d+QTNQ8VfmOdD962jAfjzN54xnrfe1U/gsog4IHQsijNNKzgSq2
	QAOuHHfjPXV35Z+NCpla2/fFWaC2DnpfvE6IISeIkMmbOGcxB/QAfFP/br8k6troCk+sWx
	Pxuj2Yx2Y/aY90VB0RIltyzZjsvlc+Y=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-9HYUyGz_Op-pNFqd5eCOdQ-1; Mon, 03 Jun 2024 04:58:21 -0400
X-MC-Unique: 9HYUyGz_Op-pNFqd5eCOdQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ea9429e1deso22953621fa.2
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 01:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717405100; x=1718009900;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Bhn4LN4Utz6rMqbLj5uOU8MQzPT/pjrzVh2Wyx//Rg=;
        b=ZgRLA5SrbRZaipk7evdt4uq2DITgM6DonOZoCiQXXfKX5/T3ljUwUPNTncMI8T704u
         F3up8kSNgmB7HSadMn68p7/lnYeAiYJBWfHDbWCZuYw88/zO/0jUanSukr6WBcqY/AS5
         3M+D7aZpXBEj6HSy30ZPMHi7ROEWLze87eA63tNH5SYq/lNujlk+REtUwGIDz9XCIjtA
         WQqJxDC07iTc8SOY88HEO47vrntpPDbQVaGwVfFqUZYp4NWCePpHljQvVWzBNcEr4aCE
         B68cTILebWE2AZVL4tCmsGG0tT2bt6Zrg8O2hqqvOqB+6GVrxAAkLM0LmzHrN+FOgxlp
         qDXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/XTeJmf4GfO1i9O7w+OCNeM6dFsPS9Zld/1dZpwONkT4BOZ60jlIEIwwipsEE4uBtqPvHH3NVNhfrRJHglLp1BVGiKlBj
X-Gm-Message-State: AOJu0YwqZzeFvNpNRtLBTjgFAO9+0qAG9/dEftQesmU9qSabi8vZe66M
	Zu0sGT55mKKBO2ZlbXMT4CgA5O5NrP3JZLuA4AVb5JWVs76edWq+Yztv+A8dlZpDwEA8qdJfMEj
	IuZLIT/rhA+EVJiB+vGUx+UCcE+r3SPrD0pI9ACLQ6RdP+Cx5akx+VQ==
X-Received: by 2002:a2e:838a:0:b0:2ea:81b9:e153 with SMTP id 38308e7fff4ca-2ea950c8d73mr63251231fa.2.1717405100068;
        Mon, 03 Jun 2024 01:58:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeF+uk7RZx6wHXhL3Soq6lZ5NSqBDYCLsmw6e7dg2mCDH7a/XE5YREzi/jJNw+L+rI7UCMrA==
X-Received: by 2002:a2e:838a:0:b0:2ea:81b9:e153 with SMTP id 38308e7fff4ca-2ea950c8d73mr63251041fa.2.1717405099580;
        Mon, 03 Jun 2024 01:58:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b2bc975sm111649235e9.29.2024.06.03.01.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 01:58:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 454B61385112; Mon, 03 Jun 2024 10:58:18 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "Paul E . McKenney"
 <paulmck@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Ido Schimmel
 <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next 2/4] net: ipv4: Add a sysctl to set multipath
 hash seed
In-Reply-To: <CANn89iJ5UzQGBMNvZJqknuTCn13Ov4pXp7Rr+pq0G+BkJ53g7Q@mail.gmail.com>
References: <20240529111844.13330-1-petrm@nvidia.com>
 <20240529111844.13330-3-petrm@nvidia.com>
 <CANn89iL8P68pHvCKy242Z6ggWsceK4_TWMr7OakS3guRok=_gw@mail.gmail.com>
 <875xuqiivg.fsf@toke.dk>
 <CANn89iJ5UzQGBMNvZJqknuTCn13Ov4pXp7Rr+pq0G+BkJ53g7Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 03 Jun 2024 10:58:18 +0200
Message-ID: <8734puies5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> On Mon, Jun 3, 2024 at 9:30=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
>>
>> Eric Dumazet <edumazet@google.com> writes:
>>
>> > On Wed, May 29, 2024 at 1:21=E2=80=AFPM Petr Machata <petrm@nvidia.com=
> wrote:
>> >>
>> >> When calculating hashes for the purpose of multipath forwarding, both=
 IPv4
>> >> and IPv6 code currently fall back on flow_hash_from_keys(). That uses=
 a
>> >> randomly-generated seed. That's a fine choice by default, but unfortu=
nately
>> >> some deployments may need a tighter control over the seed used.
>> >>
>> >> In this patch, make the seed configurable by adding a new sysctl key,
>> >> net.ipv4.fib_multipath_hash_seed to control the seed. This seed is us=
ed
>> >> specifically for multipath forwarding and not for the other concerns =
that
>> >> flow_hash_from_keys() is used for, such as queue selection. Expose th=
e knob
>> >> as sysctl because other such settings, such as headers to hash, are a=
lso
>> >> handled that way. Like those, the multipath hash seed is a per-netns
>> >> variable.
>> >>
>> >> Despite being placed in the net.ipv4 namespace, the multipath seed sy=
sctl
>> >> is used for both IPv4 and IPv6, similarly to e.g. a number of TCP
>> >> variables.
>> >>
>> > ...
>> >
>> >> +       rtnl_lock();
>> >> +       old =3D rcu_replace_pointer_rtnl(net->ipv4.sysctl_fib_multipa=
th_hash_seed,
>> >> +                                      mphs);
>> >> +       rtnl_unlock();
>> >> +
>> >
>> > In case you keep RCU for the next version, please do not use rtnl_lock=
() here.
>> >
>> > A simple xchg() will work just fine.
>> >
>> > old =3D xchg((__force struct struct sysctl_fib_multipath_hash_seed
>> > **)&net->ipv4.sysctl_fib_multipath_hash_seed,
>> >                  mphs);
>>
>> We added a macro to do this kind of thing without triggering any of the
>> RCU type linter warnings, in:
>>
>> 76c8eaafe4f0 ("rcu: Create an unrcu_pointer() to remove __rcu from a poi=
nter")
>>
>> So as an alternative to open-coding the cast, something like this could
>> work - I guess it's mostly a matter of taste:
>>
>> old =3D unrcu_pointer(xchg(&net->ipv4.sysctl_fib_multipath_hash_seed, RC=
U_INITIALIZER(mphs)));
>
> Good to know, thanks.
>
> Not sure why __kernel qualifier has been put there.

Not sure either. Paul, care to enlighten us? :)

-Toke


