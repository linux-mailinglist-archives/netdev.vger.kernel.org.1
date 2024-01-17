Return-Path: <netdev+bounces-63934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ED4830388
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 11:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99EE31C20CC3
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 10:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541021429E;
	Wed, 17 Jan 2024 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nYaMv6s8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA86314291
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705487321; cv=none; b=R7s81I+YnB4iUHJS8nPrG+loyfWn/xRsofW912RD0+WVklYIowDLD0n2HdpVyFdAnKdWHGWqI9F5eYyWk4ifiXudL0PbQsnUBwAkaF6OlWE1/yFtPbM0xZAzohOUubY13t29pJ0t73lpT5eVGukbQykBEf0sddtsbJOYNoPIZ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705487321; c=relaxed/simple;
	bh=MzaQmpwxXfJWcTn1i9rnsyGskfro+cR4g5c2yWWXKyo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=BJU78HswTxQewPy1G0fPzCa+TddBk3jllPxoGuZg56ei4VUp8Wv6H13NABw9sF9doss80TIKZZXhk45otBFYc+CKlxGJKr8p58DoS7suyTS8zDddv89hfa0paZCZ08ZeO5LTAOgL0TAl/a0Tb3DqJ5W0IPt+PHSzkEr11L1Skro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nYaMv6s8; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso10018a12.0
        for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 02:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705487318; x=1706092118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbYEKzdv6eYgpStfAgjTRarpKc22/sSfYZBD5CzbXt8=;
        b=nYaMv6s8PCt0MAvwDxnXqVy5OHYGcDgBRpkTKds+iogK/hB6jvmnhuNwps5cJXtKv6
         Kgdrh/EGGsYzXwZNyRJoDauJ2YO+aeIHdipxgkIvqq+w7/tJFQMZwWlpJmfqJs2H4woY
         Nixof0YgfuDYi+WTZSAvbmXVWbLkiJOHAOwIscdWwhKEQv7SLR2eEAof3PeR1kMTnJFR
         tB8xc4EXL83v0TGBwkflZh693J2M0zWc+lwx4BJEY9qxnKrCaMXlKu4uroCjLess9dWF
         Wc0ICCSNN3+t5BFpEwgd3N1qDljI5ei541rZizDdJ5WWuxh8dh7VDjsSme43u6NZDsMf
         M8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705487318; x=1706092118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbYEKzdv6eYgpStfAgjTRarpKc22/sSfYZBD5CzbXt8=;
        b=kn/UmCOT1lIIedISxx3mR9L5AMaoXvZ+QXhXnnyQeLxyMGeQ60encmu2kKO76/7aqA
         R403Bzieerpt/912LBT8uGzYrkeJM5Jlc3E56o+fGrWwiclDGx+nHuHTwsI49R4pL0BD
         7jjO5zhf4z8Cs5+ziCqj39LetHoOK9ddwYVuCEUsTPkZYwIqkCutOJ5jd20BHnMNzrfF
         49K9mJl4fC1QoYZ2zW10SJQeWu9pBE27cxdFdS0RJxlqOF0/JpxQjZSzI58H/BEfLtwZ
         m7NoWqJ5jqfjeKV23zw8bOisC2QhF6EbGwIPV1iQpwqTM2f0mRt5WP0351QulXv42pXX
         3NyQ==
X-Gm-Message-State: AOJu0YxfRf78Ib72OA0Mg0te0m6kVGX6YRmnEka4q3meZ4GaSMriA+xB
	FyBJG0EbvWVZxAC/knVxjw1XKpR+RPACUFiGkc9EQ2hYCTHP9fyXT7sBGmm/tDeVDiVi4BHh4XS
	txZzWKeOYfxacDThSl4GGAuQoV+wzvWryGw775uT22HzdePRsnPee
X-Google-Smtp-Source: AGHT+IFPPE4hs65ecEAyaQAe/NTaIl/AE7+XT32+yNeNSYDyGPT+RKaVVFELrvItQ87Y8fBM/myRtDehbdKGY9TUjBM=
X-Received: by 2002:a05:6402:3551:b0:559:b668:90b5 with SMTP id
 f17-20020a056402355100b00559b66890b5mr147022edd.2.1705487317727; Wed, 17 Jan
 2024 02:28:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117083715.7800-1-ayano2023th@gmail.com>
In-Reply-To: <20240117083715.7800-1-ayano2023th@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Jan 2024 11:28:24 +0100
Message-ID: <CANn89iKjRpfDY=7CVdudHp8hMveqnq4zrQGw_AXhAcnPheOZBw@mail.gmail.com>
Subject: Re: [PATCH] netlink: fix potential race issue in netlink_native_seq_show()
To: nai lin <ayano2023th@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Anjali Kulkarni <anjali.k.kulkarni@oracle.com>, 
	Li RongQing <lirongqing@baidu.com>, David Howells <dhowells@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 9:38=E2=80=AFAM nai lin <ayano2023th@gmail.com> wro=
te:
>
> Access to the nlk group should be protected by netlink_lock_table() like
> commit <f773608026ee> ("netlink: access nlk groups safely in netlink bind
> and getname"), otherwise there will be potential race conditions.
>
> Signed-off-by: nai lin <ayano2023th@gmail.com>

OK, I think you forgot to include this tag I suggested earlier to you.

Fixes: e341694e3eb5 ("netlink: Convert netlink_lookup() to use RCU
protected hash table")

> ---
>  net/netlink/af_netlink.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 4ed8ffd58ff3..61ad81fb80f5 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -2693,6 +2693,7 @@ static int netlink_native_seq_show(struct seq_file =
*seq, void *v)
>                 struct sock *s =3D v;
>                 struct netlink_sock *nlk =3D nlk_sk(s);
>
> +               netlink_lock_table();

netlink_lock_table() is heavy weight, appropriate for contexts where
we might sleep.

We could instead use a helper to acquire the lock for a very small period.

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 4ed8ffd58ff375f3fa9f262e6f3b4d1a1aaf2731..c50ca0f5adfb9691e6df37b4ac5=
18b95c2d7908f
100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1136,6 +1136,18 @@ static int netlink_connect(struct socket *sock,
struct sockaddr *addr,
        return err;
 }

+static u32 netlink_get_groups_mask(const struct netlink_sock *nlk)
+{
+       unsigned long flags;
+       u32 res;
+
+       read_lock_irqsave(&nl_table_lock, flags);
+       res =3D nlk->groups ? nlk->groups[0] : 0;
+       read_unlock_irqrestore(&nl_table_lock, flags);
+
+       return res;
+}
+
 static int netlink_getname(struct socket *sock, struct sockaddr *addr,
                           int peer)
 {
@@ -1153,9 +1165,7 @@ static int netlink_getname(struct socket *sock,
struct sockaddr *addr,
        } else {
                /* Paired with WRITE_ONCE() in netlink_insert() */
                nladdr->nl_pid =3D READ_ONCE(nlk->portid);
-               netlink_lock_table();
-               nladdr->nl_groups =3D nlk->groups ? nlk->groups[0] : 0;
-               netlink_unlock_table();
+               nladdr->nl_groups =3D netlink_get_groups_mask(nlk);
        }
        return sizeof(*nladdr);
 }
@@ -2697,7 +2707,7 @@ static int netlink_native_seq_show(struct
seq_file *seq, void *v)
                           s,
                           s->sk_protocol,
                           nlk->portid,
-                          nlk->groups ? (u32)nlk->groups[0] : 0,
+                          netlink_get_groups_mask(nlk),
                           sk_rmem_alloc_get(s),
                           sk_wmem_alloc_get(s),
                           READ_ONCE(nlk->cb_running),

