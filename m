Return-Path: <netdev+bounces-229409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C92F2BDBC80
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 01:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1141218A7A04
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 23:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152512E0B74;
	Tue, 14 Oct 2025 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N8BCHx81"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D7D2C029D
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 23:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760484220; cv=none; b=MZGUtV2NIjUtNjZoEC4ayYckrigSWeTO4VTkNaKK04/FZiH2xlyimFrIsSbrWU6yzyFttTFzqIheM4mu59O61vgJxoxuIECOq7d93CoN9fn1S/aTXbWyxFZscfnrCcHcybboCUVeyMfpXtKun3MHUxewZsZAwbWFiHsgx0CJgZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760484220; c=relaxed/simple;
	bh=EV6OaZhgS/SIETnFdeWG8j8iBvNcratwBbzhbBqtdb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbvFqOzCBORd7dSFpuUsCi+8tIV8y3jmjb0h/gyrlVzWDwUVOfc1/eS7lCbYnb971OfW0romVMsCbxzuVK/PatuOy3uJXZcEWPDMPAxNOhL12v/+HzhXhwgNyuMHV7MxBMz2EHFvyV3Td/HC7D4/KDoSfdwUMjb6mDiJeFj0kfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N8BCHx81; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b67ae7e76abso2465356a12.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 16:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760484218; x=1761089018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZjv9KBITKQcv0ZIeqP4Ek0tD0Aff7HcQ0/WLkHk1kQ=;
        b=N8BCHx81tJ02DN3Brv6VahbF18mnDoq0bIMilaj6J/hxWlWC/ZFEoY2ZspIxFmHO7q
         VbLowkS7XpoayHRlxnzTE/7l8GFsc0njiWxgURYv2A2gecp3nhS+XejjoKbubqGOP3pH
         kK8dml5ioLUNZB4v93qvsWmJQoP9MDdFAz5BDUCmFpChytphFQGiUNkb9tWdVKl6209p
         kowc1HRW0F364sxG2sj9/+jTbmmzUEq/2833USmZJgTv3IiE3fWsGzrZGQHP0TqRIXn5
         hFKDDxrbJpW7TfhIuOtRkVspeQYUUTnfqJpDx9nyUZGQe/6Cj0Hf029QFXgIEKIWsZ6S
         J3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760484218; x=1761089018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZjv9KBITKQcv0ZIeqP4Ek0tD0Aff7HcQ0/WLkHk1kQ=;
        b=BUgWWEtotTfaHcVIbAlJsdHojSLj3OrM3siaGFZKb8VnK0Xy/okRo9c7+Oepw6YOUH
         y7TEHAJRuvzF70l9dZ5Ox6R/IhTxfr9iUvQyK54x9wzaFKU5X3rPOcMnsfF19PazNujQ
         eCYhrjh+dlJRPXabFmKjZj8o/PQgRXDvaN2s1GdHDYF42mVYZaMKI6AI5xuxZKh/y256
         SYonN8tb4f2s6T0XXxwwsvzyzNBUqtX0gsqXUVsYsn7M1tIVSADU0Xe5f+PJazQfFdL4
         q4TDgM0qX4S9EMUb3LSxtjdefiAl+0rdxGHgNKbFW937QPTdpNdu8TXXACyKhzhtysDP
         xF3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmbP5ugeNhrMqlrUA3SK9IM9nOmtEaauCd7QSv2CdF7u7NMAC75vhnb1g1wsGfdqz75UG6jPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9qqHhDK1LDhV/3zrYszoHVN0ES+CgHTRP6Y9A+iDIU2hb+oN8
	6uXBuk1vDU/cBp3vtODBXsefByN5H7ce2t7yrLzJOd08OS1j1aQ5ktq2xAx19ELsGvNegStC34c
	hr+1I9IySA077ZGQQvdoOvrXuA3w5jFm59AX3OP8V
X-Gm-Gg: ASbGnctIcBIXBT8PESdGwbmkS/r/5tCe95zl4D03ilQrksSGwCO2frBDl7kyw91Asin
	3NWg0xOF2m0I7OoVC+9kHswUPZmX6/kdkEi/k9LhM8lvrwZJqR23ZW+TGu7hVykBio1lk1uBkbI
	U6bYNY2RTPVKwac99hVepVX8a3oyWyRmCoBrabEbLdrV1vc9WFU6kIzmPoVO8SShubBZlnG3O6q
	bI7ncyAu9ZZB8vl98JnPX9FQ3vY6jdMUh7Xo/pj1hV/VUNvy90jyn+/F6QnAw==
X-Google-Smtp-Source: AGHT+IFqNCb7TypgZ0uy64FT7m8XzkXvUTt7Y6UKvHQhcLiyOfMdpqpbckNwf4fJMcABt3Reqx7DXmmpXkCYOPaMmtM=
X-Received: by 2002:a17:903:244c:b0:27e:dc53:d222 with SMTP id
 d9443c01a7336-290273713c8mr312310665ad.44.1760484217422; Tue, 14 Oct 2025
 16:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007001120.2661442-1-kuniyu@google.com> <20251007001120.2661442-7-kuniyu@google.com>
 <6e790a70-bb02-47d2-9330-f2eb9078c671@linux.dev>
In-Reply-To: <6e790a70-bb02-47d2-9330-f2eb9078c671@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Oct 2025 16:23:26 -0700
X-Gm-Features: AS18NWALXWQWAbldCnjAbCBw9uODUJkqYMlGrvmybNxtehGRL_qHX3_Gq2tHXbE
Message-ID: <CAAVpQUCowciRU-ES3tzr-m=UXZviLAhd-JC-5NLOOaO5kX6+8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next/net 6/6] selftest: bpf: Add test for sk->sk_bypass_prot_mem.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 4:09=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/6/25 5:07 PM, Kuniyuki Iwashima wrote:
> > +static int tcp_create_sockets(struct test_case *test_case, int sk[], i=
nt len)
> > +{
> > +     int server, i;
> > +
> > +     server =3D start_server(test_case->family, test_case->type, NULL,=
 0, 0);
> > +     ASSERT_GE(server, 0, "start_server_str");
> > +
> > +     /* Keep for-loop so we can change NR_SOCKETS easily. */
> > +     for (i =3D 0; i < len; i +=3D 2) {
> > +             sk[i] =3D connect_to_fd(server, 0);
> > +             if (sk[i] < 0) {
> > +                     ASSERT_GE(sk[i], 0, "connect_to_fd");
> > +                     return sk[i];
>
> The "server" fd is leaked, and...
>
> > +             }
> > +
> > +             sk[i + 1] =3D accept(server, NULL, NULL);
> > +             if (sk[i + 1] < 0) {
> > +                     ASSERT_GE(sk[i + 1], 0, "accept");
> > +                     return sk[i + 1];
>
> same here.

Will fix them by err =3D sk[x] and break;.


>
> > +             }
> > +     }
> > +
> > +     close(server);
> > +
> > +     return 0;
> > +}
> > +
> > +static int udp_create_sockets(struct test_case *test_case, int sk[], i=
nt len)
> > +{
> > +     int i, j, err, rcvbuf =3D BUF_TOTAL;
> > +
> > +     /* Keep for-loop so we can change NR_SOCKETS easily. */
> > +     for (i =3D 0; i < len; i +=3D 2) {
> > +             sk[i] =3D start_server(test_case->family, test_case->type=
, NULL, 0, 0);
> > +             if (sk[i] < 0) {
> > +                     ASSERT_GE(sk[i], 0, "start_server");
> > +                     return sk[i];
> > +             }
> > +
> > +             sk[i + 1] =3D connect_to_fd(sk[i], 0);
> > +             if (sk[i + 1] < 0) {
> > +                     ASSERT_GE(sk[i + 1], 0, "connect_to_fd");
> > +                     return sk[i + 1];
> > +             }
> > +
> > +             err =3D connect_fd_to_fd(sk[i], sk[i + 1], 0);
> > +             if (err) {
> > +                     ASSERT_EQ(err, 0, "connect_fd_to_fd");
> > +                     return err;
> > +             }
> > +
> > +             for (j =3D 0; j < 2; j++) {
> > +                     err =3D setsockopt(sk[i + j], SOL_SOCKET, SO_RCVB=
UF, &rcvbuf, sizeof(int));
> > +                     if (err) {
> > +                             ASSERT_EQ(err, 0, "setsockopt(SO_RCVBUF)"=
);
> > +                             return err;
> > +                     }
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
>
>
> > +
> > +static int check_bypass(struct test_case *test_case,
> > +                     struct sk_bypass_prot_mem *skel, bool bypass)
> > +{
> > +     char buf[BUF_SINGLE] =3D {};
> > +     long memory_allocated[2];
> > +     int sk[NR_SOCKETS] =3D {};
> > +     int err, i, j;
> > +
> > +     err =3D test_case->create_sockets(test_case, sk, ARRAY_SIZE(sk));
> > +     if (err)
> > +             goto close;
> > +
> > +     memory_allocated[0] =3D test_case->get_memory_allocated(test_case=
, skel);
> > +
> > +     /* allocate pages >=3D NR_PAGES */
> > +     for (i =3D 0; i < ARRAY_SIZE(sk); i++) {
> > +             for (j =3D 0; j < NR_SEND; j++) {
> > +                     int bytes =3D send(sk[i], buf, sizeof(buf), 0);
> > +
> > +                     /* Avoid too noisy logs when something failed. */
> > +                     if (bytes !=3D sizeof(buf)) {
> > +                             ASSERT_EQ(bytes, sizeof(buf), "send");
> > +                             if (bytes < 0) {
> > +                                     err =3D bytes;
> > +                                     goto drain;
> > +                             }
> > +                     }
> > +             }
> > +     }
> > +
> > +     memory_allocated[1] =3D test_case->get_memory_allocated(test_case=
, skel);
> > +
> > +     if (bypass)
> > +             ASSERT_LE(memory_allocated[1], memory_allocated[0] + 10, =
"bypass");
> > +     else
> > +             ASSERT_GT(memory_allocated[1], memory_allocated[0] + NR_P=
AGES, "no bypass");
> > +
> > +drain:
> > +     if (test_case->type =3D=3D SOCK_DGRAM) {
> > +             /* UDP starts purging sk->sk_receive_queue after one RCU
> > +              * grace period, then udp_memory_allocated goes down,
> > +              * so drain the queue before close().
> > +              */
> > +             for (i =3D 0; i < ARRAY_SIZE(sk); i++) {
> > +                     for (j =3D 0; j < NR_SEND; j++) {
> > +                             int bytes =3D recv(sk[i], buf, 1, MSG_DON=
TWAIT | MSG_TRUNC);
> > +
> > +                             if (bytes =3D=3D sizeof(buf))
> > +                                     continue;
> > +                             if (bytes !=3D -1 || errno !=3D EAGAIN)
> > +                                     PRINT_FAIL("bytes: %d, errno: %s\=
n", bytes, strerror(errno));
> > +                             break;
> > +                     }
> > +             }
> > +     }
> > +
> > +close:
> > +     for (i =3D 0; i < ARRAY_SIZE(sk); i++)
> > +             close(sk[i]);
>
> It could close(0) here depending on how the "->create_sockets()" above ha=
s
> failed. The fd 0 could be something useful for the test_progs.

Will add if (sk[i]) guard here.


>
> Other than that, the set lgtm. Please re-spin and carry the review/ack ta=
gs.

Thank you, Martin!

>
> pw-bot: cr
>
> > +
> > +     return err;
> > +}
> > +

