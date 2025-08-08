Return-Path: <netdev+bounces-212162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1FEB1E7FA
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0A01886A98
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 12:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125AD273D76;
	Fri,  8 Aug 2025 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ARApjKpk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A12A2367B6
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754654792; cv=none; b=alStC7BwTMkIY8u7BU/MubqZ7N3Ts64ePBrP3H4fHrlrDxvqZw+i86NMToz2eZfR99UBXjvhTq4M/9AEyvMAKQw6iYv+BcAJFeLquayGNerImhiGPKiZ9fnYozm2LhmSKhjqXMKVajX521JjUFiP3i2w1ZsEl9Iieay7BcgCUYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754654792; c=relaxed/simple;
	bh=9iX/2zD8IZ81LXy32+nDxaJNS7D8NeL+z01yIP2uNfE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UQWsm8rGPOimDuyWRiLA5cL625tedqAJrM8UAthXfFwyfNhzzl86fUYfTSgosv3DtQU3t230cAvnYGsY1nyJeunrD6WQ9SWl55PJTDBaZcbmvD6A0o2tIZcq8OUVrndRdcSD0K80xme1op4O8lzHCqU6b0GtwqGQ+pMp8JXw3KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ARApjKpk; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-718389fb988so21497827b3.1
        for <netdev@vger.kernel.org>; Fri, 08 Aug 2025 05:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754654789; x=1755259589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvaZlLzP+vvkpSEZHVakEZfieqU9bOniFnZQL558zxE=;
        b=ARApjKpk/BfeNWfxCUKe6CNbimLSMGJsnDdkQKKoQKJtyR4Ht0UYoN8JaEAMgJVqXy
         STo9yfAHibHWLaTQE60Y5tuBpLfhKAoM0QzE+4ejXBukMLuBCTJfdSNJ3Z7ephPvZUjX
         3Zqug9aKgcESYNy7lmN0huhINAmDg851KntOHrf7QuuNxinsWUwfG8EQ+5JwJNuG8Rzu
         cskG0vGLK5uTpMy5GT0zr+c+U/DdSdenocgHwOMacfEslZublcjMdD/5GSUj8rD0bu/l
         YxTtXui0Uc5VggMzL0WTFeoMNg4fYAb/XaAiAm7IyEqQsXjfWbNToXCA0rK4uFPvthXa
         Od9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754654789; x=1755259589;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvaZlLzP+vvkpSEZHVakEZfieqU9bOniFnZQL558zxE=;
        b=cf2iBehQO0wtqwOeHYC+BrouU+xle1bh6kExwOBqDuSzhAG7UN94Iwveuxzqv+Teah
         FJKGB1aNvcjWj/++sPKud6HecIQv81aqKCj30v7/Ij0GIBBgPlV8FhnHXAxlN8I4pGJK
         QBUJDhw34MI/wxDSlFzDSo9j7z0OcgbtjYttgIIEJiXLT0aS7FrcjadSrymjqFHY4GVj
         2MkbzWWNUu88mzd4oXnjI75urDn1iD6Ge9u17BmaiO1caeP04OIrvtOQp1LFSSNOKF4S
         svvL07yW8ZF3ns33trJe9uVEMB299W/okdd+8vtf+CwRqzZSuJApmyy9c7ErrLF9GnD6
         JzUA==
X-Gm-Message-State: AOJu0YyaTFsCnM67Cyn6g06sd2rIvrBRkhn6Fu3CCpOAK5Ph/DisKIxN
	lgqrTRVfD1QMvwVddzat62KDjLicLMYdG2S0q9/dFLhkXHFv7FBQwRcrNk6Ffpk+L0k=
X-Gm-Gg: ASbGncu+tCl9+5EWjZdoG10QCk54s+tfjoex/N1tfAgP9SjvIFwPo80ukj/mjgU3tkX
	XUXoEgqrtoAfo1p1+o9noqPSAhfvz9H2U8vMjgIPN5U01vLySrujaQtcJ2U3rQP8Wd+FVfC/+tz
	MZPn7/DsRZVMkAH2o7LEkodHkbopTRklmK5eJLgW+Oh1KScKwyjQxoX1xPRIg08PihsSrnn3k/o
	fzJhMcE0HBioaOC4sR1yIuY7wxWEHVnsmsKnbErMkz6g7uYZidri1KQjA/9JXciN5qsAD9QitkJ
	a1fcHtHBoZRNUUx5iRoBB7JQZjs69SMK7x4GDcFcxx+oJP9RiMTR3QZWv8gqg2pyhkszzvUZiUS
	aaJUR0KhbOR+FCis=
X-Google-Smtp-Source: AGHT+IEsUP0CS551X+aKkksDkIKHQ4zufnsa8wtb1RB/2n6bAhz7yIvoRZ3309/Nr/g85HA80vOuKQ==
X-Received: by 2002:a05:690c:6488:b0:70e:2d30:43d6 with SMTP id 00721157ae682-71bf0ef4141mr32331187b3.38.1754654789185;
        Fri, 08 Aug 2025 05:06:29 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:9d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71bf6c00033sm2275197b3.17.2025.08.08.05.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 05:06:28 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Jakub
 Kicinski <kuba@kernel.org>,  Kuniyuki Iwashima <kuniyu@google.com>,  Neal
 Cardwell <ncardwell@google.com>,  Paolo Abeni <pabeni@redhat.com>,
  kernel-team@cloudflare.com,  Lee Valentine <lvalentine@cloudflare.com>
Subject: Re: [PATCH RFC net-next 1/2] tcp: Update bind bucket state on port
 release
In-Reply-To: <CANn89iJd1Wsc552rYjSQSKXMZ92PmU0NczJp+Y-0n07Njaoc8A@mail.gmail.com>
	(Eric Dumazet's message of "Fri, 8 Aug 2025 04:43:57 -0700")
References: <20250808-update-bind-bucket-state-on-unhash-v1-0-faf85099d61b@cloudflare.com>
	<20250808-update-bind-bucket-state-on-unhash-v1-1-faf85099d61b@cloudflare.com>
	<CANn89iJd1Wsc552rYjSQSKXMZ92PmU0NczJp+Y-0n07Njaoc8A@mail.gmail.com>
Date: Fri, 08 Aug 2025 14:06:25 +0200
Message-ID: <87cy9681by.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 08, 2025 at 04:43 AM -07, Eric Dumazet wrote:
> On Fri, Aug 8, 2025 at 2:10=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.c=
om> wrote:
>>
>> Currently, when an inet_bind_bucket enters a state where fastreuse >=3D =
0 or
>> fastreuseport >=3D 0, after a socket explicitly binds to a port, it stay=
s in
>> that state until all associated sockets are removed and the bucket is
>> destroyed.
>>
>> In this state, the bucket is skipped during ephemeral port selection in
>> connect(). For applications using a small ephemeral port range (via
>> IP_LOCAL_PORT_RANGE option), this can lead to quicker port exhaustion
>> because "blocked" buckets remain excluded from reuse.
>>
>> The reason for not updating the bucket state on port release is unclear.=
 It
>> may have been a performance trade-off to avoid scanning bucket owners, or
>> simply an oversight.
>>
>> Address it by recalculating the bind bucket state when a socket releases=
 a
>> port. To minimize overhead, use a divide-and-conquer strategy: duplicate
>> the (fastreuse, fastreuseport) state in each inet_bind2_bucket. On port
>> release, we only need to scan the relevant port-addr bucket, and the
>> overall port bucket state can be derived from those.
>>
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  include/net/inet_connection_sock.h |  5 +++--
>>  include/net/inet_hashtables.h      |  2 ++
>>  include/net/inet_sock.h            |  2 ++
>>  include/net/inet_timewait_sock.h   |  3 ++-
>>  include/net/tcp.h                  | 12 ++++++++++++
>>  net/ipv4/inet_connection_sock.c    | 12 ++++++++----
>>  net/ipv4/inet_hashtables.c         | 31 ++++++++++++++++++++++++++++++-
>>  net/ipv4/inet_timewait_sock.c      |  1 +
>>  8 files changed, 60 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_conne=
ction_sock.h
>> index 1735db332aab..072347f16483 100644
>> --- a/include/net/inet_connection_sock.h
>> +++ b/include/net/inet_connection_sock.h
>> @@ -322,8 +322,9 @@ int inet_csk_listen_start(struct sock *sk);
>>  void inet_csk_listen_stop(struct sock *sk);
>>
>>  /* update the fast reuse flag when adding a socket */
>> -void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
>> -                              struct sock *sk);
>> +void inet_csk_update_fastreuse(const struct sock *sk,
>> +                              struct inet_bind_bucket *tb,
>> +                              struct inet_bind2_bucket *tb2);
>>
>>  struct dst_entry *inet_csk_update_pmtu(struct sock *sk, u32 mtu);
>>
>> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables=
.h
>> index 19dbd9081d5a..d6676746dabf 100644
>> --- a/include/net/inet_hashtables.h
>> +++ b/include/net/inet_hashtables.h
>> @@ -108,6 +108,8 @@ struct inet_bind2_bucket {
>>         struct hlist_node       bhash_node;
>>         /* List of sockets hashed to this bucket */
>>         struct hlist_head       owners;
>> +       signed char             fastreuse;
>> +       signed char             fastreuseport;
>>  };
>>
>>  static inline struct net *ib_net(const struct inet_bind_bucket *ib)
>> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
>> index 1086256549fa..73f1dbc1a04b 100644
>> --- a/include/net/inet_sock.h
>> +++ b/include/net/inet_sock.h
>> @@ -279,6 +279,8 @@ enum {
>>         INET_FLAGS_RTALERT_ISOLATE =3D 28,
>>         INET_FLAGS_SNDFLOW      =3D 29,
>>         INET_FLAGS_RTALERT      =3D 30,
>> +       /* socket bound to a port at connect() time */
>> +       INET_FLAGS_LAZY_BIND    =3D 31,
>
> I am not a huge fan of this name. I think we already use something
> like autobind.

Now that I think of it - it is just another autobind path. Will change.

> I have not seen where you clear this bit, once it has been set, it
> sticks forever ?
>
> Perhaps add in the selftest something to call tcp_disconnect() :)
>
> fd =3D socket()
> connect(fd ...) // this sets the 'autobind' bit
> connect(fd ... AF_UNSPEC ..)  // disconnects
> // reuse fd
> bind(fd, .... port=3DX)
> connect(fd ...) // after this point 'autobind' should not be set.

You're right. That's not handled correctly at all. The bit should be
cleared on disconnect. Completely missed that scenario.

Thanks for reviewing!

