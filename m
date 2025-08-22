Return-Path: <netdev+bounces-216035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B160B31A06
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D86C1883A9E
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 13:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB742E8B74;
	Fri, 22 Aug 2025 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="F439YTXq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B356227462
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869860; cv=none; b=no6g2LUU1lgVs7kIlJBV8kYLM4LVO1XBHk0pTJBpMsT/Kv1as1Pk8/BsGkwF/uogHNh07Y5mTZmlrJ3U+2Z+LAPlhtYsilGexkYvLPLk8YJupD5rYxZHrg7nXdTJ5f2rnwUd1cAxdvtRe8ehVIJg8ycq1ZIApU6dMeORAoh8E5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869860; c=relaxed/simple;
	bh=p6XX1Tnj9dmfUetQROoUojZBCLHmfObVv+567t0SItQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nBKheUN2I5JmvEc4NC2ZFyhCF534rHH8u3tfVEY3aLCip/EETZBEn2Ct9+GBObakxCBXhxbce37AqaoMFibru3OqPlEoSlOkxbYMs2gy91IVcMS6PILAxra1ESVIfjQ0bbGdx8cNbRNWd4cZvTT9qTwOOH5GQcqBiz5zq43biiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=F439YTXq; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6188b7532f3so3758256a12.2
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 06:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755869856; x=1756474656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vXf6mWkbeyOBa9S/1o8kNu3nI3wKSF0zoeDWc5txDO8=;
        b=F439YTXqJZcApiNe+PL7NE7j1WJ4kh45JkoswYrWCgCuybcnE97FD/tNAoFjm6+lQz
         0773zWl45n/99JN+qoz8d78LVmiygaXmKLddMweRK9TmjxVPsBKOFMLcg2EsAaWhm2ad
         ajO3ZsxpGVwrGtKpabUa6Dd3zczQDMID83LqaJQhyuctCRArCGBbl42srryPT6nW2Cc2
         LxJJ3cGixu6PA8Rh/7Nkxz5t7CRi1/nG59cc35t80Zc0zNTMdLlZXlzGqdJ73Gn16x90
         HNA8a4WxDGlhYrb75Q6gGTLjWBr6hs0CcqXfIoEphAe215pQsoA6v+bwribpHSsA8O1m
         NxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869856; x=1756474656;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXf6mWkbeyOBa9S/1o8kNu3nI3wKSF0zoeDWc5txDO8=;
        b=dbFULg7PKgwFmJCdfNSIaJ8XealkCSv0vKIk8p3+n1UzY7wHNqaGxxXKVuAKH+Fju8
         dZTHWWEzen/pCs94WYjMOgPQRgr1Vof2LOBur08g860C1dqnGZa3NSK1fCk9YSEdTiTE
         NLYkMDxiI3I05c4Rq1x3aVcpnPrJocyFVoOxZQ4kmEm7IEoSqvNGK38vN0B3jIUHQgBE
         S3Grcav/s8wDiHrTrUTHtzL1Rhq4Pn5PDv+fKHOIEmcDyVVYar0uUCYK0pReUYNQpP7k
         LxKM75z9cj4Y+dhrEzJBc8HwsEph9kUqPXKTNFwPl262y6Z0qFA+iUVngnmn9SGGzx8H
         9X4g==
X-Gm-Message-State: AOJu0YyZUcdGP7L6LcbjWB9K+nLSl6Kerz+UXjc+LhwMN47qK3wvO3bU
	PD7v/R5+8shg2OehX3nP/d4wgraVDAH1Rey75G4n5MhS0e2u0M5uSecDm5yMfEs5MwI=
X-Gm-Gg: ASbGncuYbEH4uy/fBONTb6HmB4hI2rF7E8imIkaOhd40T80arDT2Evj4195b4EoGklZ
	jyjAdrZA9tMUvY1bDRljcG5RrBNfoEm/2cg3I2ViTTmbnGepITWc0GJX8K8uFOvRLMllaGJ7RCE
	OsDYZ6NCnqnvSEC2pgUUaXJrCBBH3iv4fvtImLG9i3g2KutkCYircIqVlcgF4lnzpFUiyzdobJC
	DJumt7GtJ8jvGSSaRE/gcva0AQf60EBp9cfw9pakwrA8E5I7n3QQQBU0hNYzL4mKaCCs11JshOu
	Bo3XQ86vjDmqmGWSYFM+F2vLC9gMdaJQCE6aTjzIVijROj+ORYRf1tnw4KaUk6yg0UBx3aohTXr
	YO407+UWA3WRmDg==
X-Google-Smtp-Source: AGHT+IGOIBDuMIIBd1uyJ5C2pSFwV3+vI5mCtqpPyRDDb83o+UNAXgcBgsWHcj7AcT16o1pyBKcYfw==
X-Received: by 2002:a17:907:d93:b0:afe:23ef:2206 with SMTP id a640c23a62f3a-afe295c074cmr280085666b.46.1755869855746;
        Fri, 22 Aug 2025 06:37:35 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded478d69sm603265066b.73.2025.08.22.06.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:37:34 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Neal
 Cardwell <ncardwell@google.com>,  Paolo Abeni <pabeni@redhat.com>,
  kernel-team@cloudflare.com,  Lee Valentine <lvalentine@cloudflare.com>
Subject: Re: [PATCH net-next v2 1/2] tcp: Update bind bucket state on port
 release
In-Reply-To: <CAAVpQUAV8KnFOxr61Qmb2grsd=CYP_aakP5XApis_Od424xM+g@mail.gmail.com>
	(Kuniyuki Iwashima's message of "Thu, 21 Aug 2025 20:58:52 -0700")
References: <20250821-update-bind-bucket-state-on-unhash-v2-0-0c204543a522@cloudflare.com>
	<20250821-update-bind-bucket-state-on-unhash-v2-1-0c204543a522@cloudflare.com>
	<CAAVpQUAV8KnFOxr61Qmb2grsd=CYP_aakP5XApis_Od424xM+g@mail.gmail.com>
Date: Fri, 22 Aug 2025 15:37:33 +0200
Message-ID: <874itzzdcy.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 08:58 PM -07, Kuniyuki Iwashima wrote:
> On Thu, Aug 21, 2025 at 4:09=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
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
>>  include/net/tcp.h                  | 15 +++++++++++++++
>>  net/ipv4/inet_connection_sock.c    | 12 ++++++++----
>>  net/ipv4/inet_hashtables.c         | 32 +++++++++++++++++++++++++++++++-
>>  net/ipv4/inet_timewait_sock.c      |  1 +
>>  8 files changed, 64 insertions(+), 8 deletions(-)
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
>> index 1086256549fa..9614d0430471 100644
>> --- a/include/net/inet_sock.h
>> +++ b/include/net/inet_sock.h
>> @@ -279,6 +279,8 @@ enum {
>>         INET_FLAGS_RTALERT_ISOLATE =3D 28,
>>         INET_FLAGS_SNDFLOW      =3D 29,
>>         INET_FLAGS_RTALERT      =3D 30,
>> +       /* socket bound to a port at connect() time */
>> +       INET_FLAGS_AUTOBIND     =3D 31,
>
> AUTOBIND sounds like inet_autobind() was called.

That was intentional. I was going for an analogy to
inet_dgram_connect->inet_autobind, but I see how it can also be
confusing.

> __inet_bind() saves similar flags in sk->sk_userlocks and
> it has 3 bits available.
>
> How about flagging SOCK_BINDPORT_CONNECT in
> sk->sk_userlocks ?

I was on the fence whether to put the bit flag in sk_userlocks or
inet_flags. Treating it as a variant of BINDPORT lock also makes sense.

>>  };
>>
>>  /* cmsg flags for inet */
>> diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewai=
t_sock.h
>> index 67a313575780..ec99176d576f 100644
>> --- a/include/net/inet_timewait_sock.h
>> +++ b/include/net/inet_timewait_sock.h
>> @@ -70,7 +70,8 @@ struct inet_timewait_sock {
>>         unsigned int            tw_transparent  : 1,
>>                                 tw_flowlabel    : 20,
>>                                 tw_usec_ts      : 1,
>> -                               tw_pad          : 2,    /* 2 bits hole */
>> +                               tw_autobind     : 1,
>> +                               tw_pad          : 1,    /* 1 bit hole */
>>                                 tw_tos          : 8;
>>         u32                     tw_txhash;
>>         u32                     tw_priority;
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index 2936b8175950..c4bb6e56a668 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -2225,6 +2225,21 @@ static inline bool inet_sk_transparent(const stru=
ct sock *sk)
>>         return inet_test_bit(TRANSPARENT, sk);
>>  }
>>
>> +/**
>> + * inet_sk_autobind - Check if socket was bound to a port at connect() =
time.
>> + * @sk: &struct inet_connection_sock or &struct inet_timewait_sock
>> + */
>> +static inline bool inet_sk_autobind(const struct sock *sk)
>> +{
>> +       switch (sk->sk_state) {
>> +       case TCP_TIME_WAIT:
>> +               return inet_twsk(sk)->tw_autobind;
>> +       case TCP_NEW_SYN_RECV:
>> +               return false; /* n/a to request sock */
>
> This never happens.  Maybe remove the case
> or add DEBUG_NET_WARN_ON_ONCE(1) ?

Will probably just remove it.

Thanks for reviewing!

>> +       }
>> +       return inet_test_bit(AUTOBIND, sk);
>> +}
>> +

[...]

