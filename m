Return-Path: <netdev+bounces-229774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E19AEBE0AB3
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDBE44E5C94
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 20:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8583090FD;
	Wed, 15 Oct 2025 20:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lqAhSq63"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B190303C97
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760560886; cv=none; b=sCsmtZitxHHDw3sgPF0tOpnwjSCRL2qu7fGY3Hk5YKqcVvjHPUsbzAdnevRpdJHk85u2yHI23meFH+kHOqRuOHV4olKHVD3TKZZqMJbgXLnup2iXI48hbBqOWFfYfOjTJVwC89bC9JBv8KA27rBVh7wweIk3WbO42R4PAiv+01c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760560886; c=relaxed/simple;
	bh=TO62kgHWAJogfqthzQuEdhjyqSf0Knw+0u56RFKCWLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=enu5mq5Q6qunDEapQYWu7uaLEr4uaS2mjq57Y9H1+YRexpMRv2Qk4+tA85G54uBflCY9nOMCSQDZDFhVaRWUlqxEeSiuBv5MCFSYfsXQ+wcovtSYuvgNxxTdTxfAb/1czJbgPLT83smcAOoBXCvR0oK4qUDhdmP7b+Tkn5RhAuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lqAhSq63; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-631df7b2dffso3240906a12.1
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 13:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760560883; x=1761165683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4SkHnSxaTY1A0hm6Dgf/9uSLFR76gbsoH7lLnef4XM=;
        b=lqAhSq63bYQ3yZeHYZ/UfaN2cSYM083VsgyBMdXdoSzo29raRd6Dvtqp7E2CrTC3Vm
         oPVqhJD4SZQZhc7LXJF1u81GOt6vI8GJN6QVkUnAWD53NcgI29QedZlbECL5kyCySAOL
         aCmFmg/QGIIM0sy/UzadyF9M3Wr9IuMT+ynyD0YOJ++H3nimDPau+NDfnvwc8wDTp3hk
         x8IYdzx+rgfA3CTS0UzTzmecu36NocmOJonWT8e+nfFC7XeH8199uZsLgvQ7e6KcbRT4
         BkSrrgTI4O++v+aHu5zWvt1ie5La4+Og7seNYTj/Nk5z9Zp9cW8/7TWL0jzzaVUSD+Fx
         BjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760560883; x=1761165683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4SkHnSxaTY1A0hm6Dgf/9uSLFR76gbsoH7lLnef4XM=;
        b=Dj/i+Js7NFSwwkZ2e9rNFv3OVYucMdWpNiLezRjzpyT3t3ND3MoGCOYRtx/WPgURta
         HF2pNTbXTQlsaGIBxlv8Xld1Ocyijnk/G8dtHpZ6p2Y/nWV+/OOgWQ0ExxriiZpr1HY2
         lKC+3SIYc8tPatOf0ePJ4QiFJQlVxZf5JXcgGx/wlMW18IZ4GK6UMcBQngPRljjqxxwe
         wY0/Px+3nggWHyFtDm3yGNzy05acUG1OCf9HRFEKZKKh5wIikFKtrDD4s6IRs8x4Z3RA
         HRLXYdTrMfOZzb80ZSgt2VaZDtpzEyo+JDXviZMjfaCcHBHWRsn53BZa7MN9fBm/kS0W
         mSuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFZA4dHSOVpc5bk0pZcpVKWWbJDRbS1mx3StW/UYh2BSEqWv59wulZc6S+E+TUBniSMx9T25E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmFwUOFFcbPtG7ywW8VeWtka+uNQDhwC3YDDqky2bFttKWRS66
	BhZpl/TznLkRal5sfGHDx+vEx+Fxq0btrxBRe5I4LCJJ3o9xc317PCpzABZXIH9sZkpNyrw8Tj8
	zYHODtefRAqHs7KYu6AmJ5BDvAq993wZ3gStbamQQ
X-Gm-Gg: ASbGnctrwZ8MXNOIc45k0i9l/a8nP32rhJB3JIkFJdQI2DbR5PdsDfrvkq3oMtq4Muf
	/CYIpTVf9aKf/pb1kDx58NYMO40w3vzmX8Qwpv3AqsmQunulq9Olp3qXauZlu1zc4T8NVS5xFq4
	KwMtDoQOjo1Erpj5QZ9mFNJyrWYM66On0BttzSL+GK7c243+sWfBNtG3FjfcU+C1ok2N9qwEIIP
	7mXPI8I+LmMpYmAU4iOtw1ftRoO6ZY1+sdjvnyeGgEYHDhLwKMBEQVoX+1hP0s=
X-Google-Smtp-Source: AGHT+IEyIxFaGj5K0QoKX1UlKomoKcT+vrcyw05X0GgkG4XlTuFiMLuSu0Z3D0b7QJBSsC9LXmWhsW3j6bf7UAc7IMk=
X-Received: by 2002:a05:6402:8cb:b0:634:9acf:f33f with SMTP id
 4fb4d7f45d1cf-63bfde982b0mr1073168a12.16.1760560882454; Wed, 15 Oct 2025
 13:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014235604.3057003-1-kuniyu@google.com> <20251014235604.3057003-7-kuniyu@google.com>
 <fa80d5a7-790d-4f10-bef3-f5c708218f83@linux.dev>
In-Reply-To: <fa80d5a7-790d-4f10-bef3-f5c708218f83@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 15 Oct 2025 13:41:09 -0700
X-Gm-Features: AS18NWDyZRhG6Af-rwDk7wCdbtSwcuv6uguz17phGgky8w6XA8MQHqsYXcH-7qw
Message-ID: <CAAVpQUB_ME3bteNW07gCz-Ao3jZ7HzsLY9FiSy9TWecF7LiUOQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next/net 6/6] selftest: bpf: Add test for sk->sk_bypass_prot_mem.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 12:07=E2=80=AFPM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 10/14/25 4:54 PM, Kuniyuki Iwashima wrote:
> > +static int tcp_create_sockets(struct test_case *test_case, int sk[], i=
nt len)
> > +{
> > +     int server, i, err =3D 0;
> > +
> > +     server =3D start_server(test_case->family, test_case->type, NULL,=
 0, 0);
> > +     if (!ASSERT_GE(server, 0, "start_server_str"))
> > +             return server;
> > +
> > +     /* Keep for-loop so we can change NR_SOCKETS easily. */
> > +     for (i =3D 0; i < len; i +=3D 2) {
> > +             sk[i] =3D connect_to_fd(server, 0);
> > +             if (sk[i] < 0) {
> > +                     ASSERT_GE(sk[i], 0, "connect_to_fd");
> > +                     err =3D sk[i];
> > +                     break;
> > +             }
> > +
> > +             sk[i + 1] =3D accept(server, NULL, NULL);
> > +             if (sk[i + 1] < 0) {
> > +                     ASSERT_GE(sk[i + 1], 0, "accept");
> > +                     err =3D sk[i + 1];
> > +                     break;
> > +             }
> > +     }
> > +
> > +     close(server);
> > +
> > +     return err;
> > +}
> > +
>
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
> > +     for (i =3D 0; i < ARRAY_SIZE(sk); i++) {
> > +             if (sk[i] <=3D 0)
>
> Theoretically, 0 is a legit fd. The tcp_create_sockets above is also test=
ing
> ASSERT_GE(sk[i], 0, ...). I changed to test "< 0" here and initialize all=
 sk[]
> to -1 at the beginning of this function.
>
> > +                     break;
> > +
> > +             close(sk[i]);
> > +     }
> > +
> > +     return err;
> > +}
> > +
>
>
> > +struct test_case test_cases[] =3D {
>
> Added static.
>
> Applied. Thanks.

Thank you for fixups, Martin !

