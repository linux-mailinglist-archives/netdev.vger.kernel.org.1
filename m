Return-Path: <netdev+bounces-212158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B8CB1E796
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8D9A012B0
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 11:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB692749D6;
	Fri,  8 Aug 2025 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GtZE8/J2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDDE274676
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653452; cv=none; b=lVzQLo3leaMl5byFg9E1v73RJVQtXUtX56rwoIaSfzaG1NgcSkLPAiEkt5z3cn9c+IqKGO6nDahJFHvm4JMVW5UzZwizvvZb1mw80FGeWExZhfiUwqLgmweeA4hb5v8P31MptvIyTl+LRKFFMKJqU2XJMm3s3+pN58Zn+SDSAtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653452; c=relaxed/simple;
	bh=+UfPqL7EFNIBA+nx/Qbu5ELmtpfN7roIFNjy6oZ6+bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2oTm7v65yTQgs+tOKP7tN2iWGhkTT77qhKIK2OfGvJdKp+1i7Rn30+GICl07h8Domk77AurLML0aYKjOOc4BLdpBlTc02Oue1g72U5evu3r+v0Kq1oSIUN3yTZfca2qLnmeWBkVUYqQpwsrhvwF1WbJ29v5dlDOAQq/B9Xskxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GtZE8/J2; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4af1c1b5b38so25206081cf.1
        for <netdev@vger.kernel.org>; Fri, 08 Aug 2025 04:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754653450; x=1755258250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8DcQ4j7SNAfgEAF6DGiSr/WH/RqRi9GH9ldtZKZRfc=;
        b=GtZE8/J2wEf0bjSpMyPhbEqfm1XI8dbT4MXsUunkxL57rRi3KUDrtrzriaZpvRCo/e
         3NB03cUapnTGLVfDIWVP2UKla7KikTpGe+pEu+DthGcZSL8ukmF5L83Ku1+mqxH2nbO2
         0q3QitzwuunFDaWwWPUN5Zn9RuKIhIi+PXTV4b14u+gZYDdMi5IjW6gQY6A3BstejLjr
         yVy8TUP2mu5CcUS2mJRxOneDHJBS3sI4Ejm0YVln0CiI9A8TqZkYAMhrTcvHWdYUhhUf
         OCX+DCm6Snq0fNPFrnA2+HQRBdc9OxXdghEF5l9pkNagkreEXjEVbGarXfiSrEfqmLp5
         nlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754653450; x=1755258250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8DcQ4j7SNAfgEAF6DGiSr/WH/RqRi9GH9ldtZKZRfc=;
        b=sKgIlzXKlIs/eYSu3W7VFBjQDmeeHOWzKbD6EaKgs6NPSp4gNdCgJ3hJlDXKikcK/y
         zY7zhwNZhgYG/p4ba2vEC0bO00irwPMjohloesCbUu9MUL8UBP5ayBkWJ9Gt9/RJhr0N
         EeKKbGr87AvS6k5RML/LisZyMz7WfDSvfDLvSyVyYTUN3a8GePpv3yDiPyd1gh08QVh+
         URiA2u6e6i+FpMZ3DXJJVJPh/eg9rkDBWcAqYpqPvEODCK9yOuVn3MWltq3aqK/UEQ8u
         wGwIBpR6Bd/qcVElz/Z3Vjfl0Kq4F13tH7dUNkSVyUTZk4WLxFW3vqiU4GT54SFsP7RY
         SVVw==
X-Gm-Message-State: AOJu0YydOCi2KBTyvYDbk4c8f3Gc0lqB+ohzgNei6SlBEROYCK6OS6jH
	4R1um/99qQExMkeOduhReg4zqtqGZRXpVdXEqFmzyBHirTTgN+c1pQKzzplR2OQAMPr7rYFZuwm
	FT7WZ15ZKxYlZ8rqJ94Ek89U+reWlrgI7tiCgMNHf
X-Gm-Gg: ASbGncueHqrMNTRzKd1VStjiZh2gSIxSVtaaRlik6tcwvdaONDzJNJ+JsUlZo8YhE53
	qwpJuHELslALMAXmoRmKKBwPYR4Y93REPVvOwSPigHduG4XVdyRtd54tTctaXy/L8sHLB6GrEyA
	W+1RQhlitWTm6BCx+jwyUDYzc14px6/vWUblzPsndYnsqfyQluLBRM/TLKLcga6H6BsuqPeajpO
	xXeCmWM3VFGANs=
X-Google-Smtp-Source: AGHT+IGd8s2t6j3AEJSmBMNQVOBMOpVZ7fxgbcTwAYOTlIzFgHEdghi9oHJSA2K9Td1NN24wHWCQE/1MwtyNyoJIwkY=
X-Received: by 2002:ac8:7e91:0:b0:4a4:3a4e:b77c with SMTP id
 d75a77b69052e-4b0aec7e800mr40205511cf.17.1754653449402; Fri, 08 Aug 2025
 04:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808-update-bind-bucket-state-on-unhash-v1-0-faf85099d61b@cloudflare.com>
 <20250808-update-bind-bucket-state-on-unhash-v1-1-faf85099d61b@cloudflare.com>
In-Reply-To: <20250808-update-bind-bucket-state-on-unhash-v1-1-faf85099d61b@cloudflare.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Aug 2025 04:43:57 -0700
X-Gm-Features: Ac12FXxK7DGOwWI6uvVttV1FAA-Q1P4sCTziYx5h2iMUSNuGir_vQjDABhupIH0
Message-ID: <CANn89iJd1Wsc552rYjSQSKXMZ92PmU0NczJp+Y-0n07Njaoc8A@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 1/2] tcp: Update bind bucket state on port release
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, kernel-team@cloudflare.com, 
	Lee Valentine <lvalentine@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 2:10=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:
>
> Currently, when an inet_bind_bucket enters a state where fastreuse >=3D 0=
 or
> fastreuseport >=3D 0, after a socket explicitly binds to a port, it stays=
 in
> that state until all associated sockets are removed and the bucket is
> destroyed.
>
> In this state, the bucket is skipped during ephemeral port selection in
> connect(). For applications using a small ephemeral port range (via
> IP_LOCAL_PORT_RANGE option), this can lead to quicker port exhaustion
> because "blocked" buckets remain excluded from reuse.
>
> The reason for not updating the bucket state on port release is unclear. =
It
> may have been a performance trade-off to avoid scanning bucket owners, or
> simply an oversight.
>
> Address it by recalculating the bind bucket state when a socket releases =
a
> port. To minimize overhead, use a divide-and-conquer strategy: duplicate
> the (fastreuse, fastreuseport) state in each inet_bind2_bucket. On port
> release, we only need to scan the relevant port-addr bucket, and the
> overall port bucket state can be derived from those.
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  include/net/inet_connection_sock.h |  5 +++--
>  include/net/inet_hashtables.h      |  2 ++
>  include/net/inet_sock.h            |  2 ++
>  include/net/inet_timewait_sock.h   |  3 ++-
>  include/net/tcp.h                  | 12 ++++++++++++
>  net/ipv4/inet_connection_sock.c    | 12 ++++++++----
>  net/ipv4/inet_hashtables.c         | 31 ++++++++++++++++++++++++++++++-
>  net/ipv4/inet_timewait_sock.c      |  1 +
>  8 files changed, 60 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connec=
tion_sock.h
> index 1735db332aab..072347f16483 100644
> --- a/include/net/inet_connection_sock.h
> +++ b/include/net/inet_connection_sock.h
> @@ -322,8 +322,9 @@ int inet_csk_listen_start(struct sock *sk);
>  void inet_csk_listen_stop(struct sock *sk);
>
>  /* update the fast reuse flag when adding a socket */
> -void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
> -                              struct sock *sk);
> +void inet_csk_update_fastreuse(const struct sock *sk,
> +                              struct inet_bind_bucket *tb,
> +                              struct inet_bind2_bucket *tb2);
>
>  struct dst_entry *inet_csk_update_pmtu(struct sock *sk, u32 mtu);
>
> diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.=
h
> index 19dbd9081d5a..d6676746dabf 100644
> --- a/include/net/inet_hashtables.h
> +++ b/include/net/inet_hashtables.h
> @@ -108,6 +108,8 @@ struct inet_bind2_bucket {
>         struct hlist_node       bhash_node;
>         /* List of sockets hashed to this bucket */
>         struct hlist_head       owners;
> +       signed char             fastreuse;
> +       signed char             fastreuseport;
>  };
>
>  static inline struct net *ib_net(const struct inet_bind_bucket *ib)
> diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
> index 1086256549fa..73f1dbc1a04b 100644
> --- a/include/net/inet_sock.h
> +++ b/include/net/inet_sock.h
> @@ -279,6 +279,8 @@ enum {
>         INET_FLAGS_RTALERT_ISOLATE =3D 28,
>         INET_FLAGS_SNDFLOW      =3D 29,
>         INET_FLAGS_RTALERT      =3D 30,
> +       /* socket bound to a port at connect() time */
> +       INET_FLAGS_LAZY_BIND    =3D 31,

I am not a huge fan of this name. I think we already use something
like autobind.

I have not seen where you clear this bit, once it has been set, it
sticks forever ?

Perhaps add in the selftest something to call tcp_disconnect() :)

fd =3D socket()
connect(fd ...) // this sets the 'autobind' bit
connect(fd ... AF_UNSPEC ..)  // disconnects
// reuse fd
bind(fd, .... port=3DX)
connect(fd ...) // after this point 'autobind' should not be set.

