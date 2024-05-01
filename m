Return-Path: <netdev+bounces-92712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7131C8B85CD
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 08:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287012847BB
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 06:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AC045000;
	Wed,  1 May 2024 06:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xR0JG0mM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE174F613
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 06:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714546626; cv=none; b=l1kyQFT79vTxa87sgXSVnb7CTCs08QJxDfTe5EodIeFwJ+VT1iWiEZQjuA1Icby47nMfCNQZpTFQ+OCNfT/Mhiu46+fWAxNa8YYTMVN1aOArDjuPoWDx9fpRuHjMBefuPU4jjVv99DRYRPMBRZUq9wBQx+LwCYC2/a/YFyaJEUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714546626; c=relaxed/simple;
	bh=lNNQJO2IQYuk1cdzYlwwWOpI+gzLor51gFMdGqMFOf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JC4y6QvHIUWe5VJJMH7G6Y0CTR6wIVlWrT6bp848vobDQqiKAdfhmAHTHdqf+7rXem8U/M3bnh+SPySWsCUTXVsCcdIYiy3juehmprViQll5kUwB4dlJI/1LVNL8QctHwXUDDVxWEEAkV1zAm2PEp41hrEhyPGT6RdUN54il9Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xR0JG0mM; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso5606a12.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714546623; x=1715151423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnkfA9ju/DXxIK7KBqIm3z3HvOYluERJN3eBxEOOU7A=;
        b=xR0JG0mMM1gRVOLdNdwIqBYEWQKNzkeqyQO2oi0WVDcIA1m0jvWGPlBrbkAB0OsVpc
         8+JqzLL2ZwNOGCnHj5h1s7uRRJcteErRBR4S1ifTjz3K25WBwc/czHCGn8pPvo6TJktK
         tm3UCbAtebxSge5Q4TA3D+jF5W6a1j3qmE5z6GQTD69TuM8vpNeQ508El3eZSwgXLrGT
         pBAkWsJpgq5YvYwkvmto/dHDOwa1XbMmutdBVlfUodPQEIcFudNCw9LeYEJIQ28A6qbF
         7lqtw5ZCWp7xsw3kVUpgd6GQLSqand1wCAO4q3maPjfrB1h/NSsgaIjyo5bhTnmfUXfZ
         F2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714546623; x=1715151423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FnkfA9ju/DXxIK7KBqIm3z3HvOYluERJN3eBxEOOU7A=;
        b=O2tvWh5Biny3OaRTxhGK0czfCJDg7+LOgb1vNQBqsmKNBXbMyDrIxn1wqZ4JFv1zSS
         iGQBCqeAmRov+uOWrXA6aNTBkxivBfoXDduQIT2c5qAsyfSBCufE2oaq0yoniBJEQcV0
         o5eEgu1MtDFXczK8aMulswbi5Z26ssUFm6+I2/5GBtoZBK8nsxRDB+UqablW1Ubp4JXZ
         KDYK1UzEHJBv2sKeiZKLh59x/C7I+rXY539LT218mBbxkW1OGoaBUeHm+7ZFFXbC0R2F
         EcQQt5vBMNaLtC0z7lEM+xbRG0NuwDh6vFSmGFdzam/ulUgObz4rr0rC3/uBa5JqMzc+
         NENQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8C2dNvzAz3ymegYzldkH/w5UilLKGoNttXtFsdLShQOy7FGo8XQ+24A/FEF7WWWy2ueMIcZ3Sj6m1Sc0XflAxwlHkJils
X-Gm-Message-State: AOJu0YzNdlqB6C/z0ZpO4rQZiIb0XUEBM2F4ew5eqdDuASYteElEJF+3
	1D9PlqReGVXQ6YBYCqhDGe93jFCLtyPOx9k/E2gujzrA7OX1iYEqD+vznFRf1q/dlMk0f7N+6OB
	yHT3zVX4YwFJsD62hZWAY9veAbGMQp3uhS9fJoXklbZNX2JTnaQsV
X-Google-Smtp-Source: AGHT+IF8mwiFwMpx208Ze0w/INLVH1ymZrhVWBi6DYIOOSORf91t1jDcG90rRBJuJdj21fGFQWPF+qGNEJ+DRYBeyeg=
X-Received: by 2002:a05:6402:1d1b:b0:572:583f:cc4c with SMTP id
 dg27-20020a0564021d1b00b00572583fcc4cmr92268edb.5.1714546622661; Tue, 30 Apr
 2024 23:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <37a477a6-d39e-486b-9577-3463f655a6b7@allelesecurity.com> <20240501002212.20110-1-kuniyu@amazon.com>
In-Reply-To: <20240501002212.20110-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 May 2024 08:56:51 +0200
Message-ID: <CANn89iJk5RJR=ex6t3-hzpo=08_+RMQJD5NL3-RzTyK_FutAMQ@mail.gmail.com>
Subject: Re: use-after-free warnings in tcp_v4_connect() due to
 inet_twsk_hashdance() inserting the object into ehash table without
 initializing its reference counter
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: anderson@allelesecurity.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 2:22=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> +cc Eric
>
> From: Anderson Nascimento <anderson@allelesecurity.com>
> Date: Tue, 30 Apr 2024 19:00:34 -0300
> > Hello,
>
> Hi,
>
> Thanks for the detailed report.
>
> >
> > There is a bug in inet_twsk_hashdance(). This function inserts a
> > time-wait socket in the established hash table without initializing the
> > object's reference counter, as seen below. The reference counter
> > initialization is done after the object is added to the established has=
h
> > table and the lock is released. Because of this, a sock_hold() in
> > tcp_twsk_unique() and other operations on the object trigger warnings
> > from the reference counter saturation mechanism. The warnings can also
> > be seen below. They were triggered on Fedora 39 Linux kernel v6.8.
> >
> > The bug is triggered via a connect() system call on a TCP socket,
> > reaching __inet_check_established() and then passing the time-wait
> > socket to tcp_twsk_unique(). Other operations are also performed on the
> > time-wait socket in __inet_check_established() before its reference
> > counter is initialized correctly by inet_twsk_hashdance(). The fix seem=
s
> > to be to move the reference counter initialization inside the lock,
>
> or use refcount_inc_not_zero() and give up on reusing the port
> under the race ?
>
> ---8<---
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index 0427deca3e0e..637f4965326d 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -175,8 +175,13 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sk=
tw, void *twp)
>                         tp->rx_opt.ts_recent       =3D tcptw->tw_ts_recen=
t;
>                         tp->rx_opt.ts_recent_stamp =3D tcptw->tw_ts_recen=
t_stamp;
>                 }
> -               sock_hold(sktw);
> -               return 1;
> +
> +               /* Here, sk_refcnt could be 0 because inet_twsk_hashdance=
() puts
> +                * twsk into ehash and releases the bucket lock *before* =
setting
> +                * sk_refcnt.  Then, give up on reusing the port.
> +                */
> +               if (likely(refcount_inc_not_zero(&sktw->sk_refcnt)))
> +                       return 1;
>         }
>

Thanks for CC me.

Nice analysis from Anderson ! Have you found this with a fuzzer ?

This patch would avoid the refcount splat, but would leave side
effects on tp, I am too lazy to double check them.

Incidentally, I think we have to annotate data-races on
tcptw->tw_ts_recent and  tcptw->tw_ts_recent_stamp

Perhaps something like this instead ?

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 0427deca3e0eb9239558aa124a41a1525df62a04..f1e3707d0b33180a270e6d3662d=
4cf17a4f72bb8
100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -155,6 +155,10 @@ int tcp_twsk_unique(struct sock *sk, struct sock
*sktw, void *twp)
        if (tcptw->tw_ts_recent_stamp &&
            (!twp || (reuse && time_after32(ktime_get_seconds(),
                                            tcptw->tw_ts_recent_stamp)))) {
+
+               if (!refcount_inc_not_zero(&sktw->sk_refcnt))
+                       return 0;
+
                /* In case of repair and re-using TIME-WAIT sockets we stil=
l
                 * want to be sure that it is safe as above but honor the
                 * sequence numbers and time stamps set as part of the repa=
ir
@@ -175,7 +179,6 @@ int tcp_twsk_unique(struct sock *sk, struct sock
*sktw, void *twp)
                        tp->rx_opt.ts_recent       =3D tcptw->tw_ts_recent;
                        tp->rx_opt.ts_recent_stamp =3D tcptw->tw_ts_recent_=
stamp;
                }
-               sock_hold(sktw);
                return 1;
        }

