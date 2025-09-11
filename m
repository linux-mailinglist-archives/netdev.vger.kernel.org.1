Return-Path: <netdev+bounces-222340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4592CB53F13
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 01:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA2C1CC097A
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0852F4A11;
	Thu, 11 Sep 2025 23:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b="BmH3q/J0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0602F39B8
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 23:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757633153; cv=none; b=Nb1asa9OEnrsOaRv3n8hJsNAWGKHp1lqbQjaccujEuYcoumtS5Spt7U3zjAeHC9cKu7UprU5S9X+P8WgMJayj9zFcqb1sW5b9q/PabU6VQhLeFyxmuZK84GwU+U5wGZECoJbMSi09QYIDGBd0oIw2EtvKQ1f8FRsz0vJpI28/LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757633153; c=relaxed/simple;
	bh=QIgQsG9hXEvtDeGxu404HBKnXjn9yy5gNu9MfpTYVJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNl92pcSzmL9Z8ImtuEgt0Vba6wL/jHUedBek6zcCjS6zZ8xiha0lpqagRp5XoUTncwQdGH4UPdIxlwi8t0jiYylJj5Wbc2SKWuQN1Cc34xSa6kvjfu3my+6YK8TqVCfxwTexPTNp+Dvo+YQkjS/UNx34vw+z2QN4tbr0TuHkcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com; spf=pass smtp.mailfrom=allelesecurity.com; dkim=pass (1024-bit key) header.d=allelesecurity.com header.i=@allelesecurity.com header.b=BmH3q/J0; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=allelesecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=allelesecurity.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-544aeeb296aso753364e0c.2
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 16:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allelesecurity.com; s=google; t=1757633151; x=1758237951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NE65i/k0hkXWkFlEDsXbUH+FzjlIcD4HZlC6Q0BdSAc=;
        b=BmH3q/J0aMVASHf5PqoJFI/kd2giYVLTAfw+5CxOBIfG62ozAd4Y9PStDANNdLEswR
         VUVGkCeA+1bBBjCthhCix9JRDO6DagOVBWDYvsUtonWmge4Zx0hRT6ju5ZwP8pIo9GDk
         cObAIidb+5yIKhqFmHv+r9HfGVc56/d0pTi50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757633151; x=1758237951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NE65i/k0hkXWkFlEDsXbUH+FzjlIcD4HZlC6Q0BdSAc=;
        b=BRQ5gQTJw1ZnorudTB2E6C/dhkn/ychuH3aeV4V4VLGyVzLGVthmvnikgQ3CUD08DY
         IWDYHhULFrQxajyFUHfsY6gFB4M7hRxH+F20RnVYVDy9Tb2L9A7JshLbOjIRawZGQtrb
         x1j6rGGo6bUrEPF0ewy66LGh8Jok9+6w9MBsOfQGWisn0tKQSDonKC6ZbYeJKe0ga58y
         hMoOrZXS9A0C9uNLX3FePgM5mBs2T3im8/0VpHL8zkNVwP8ZBrg+71jxg8Den5mM5w6u
         dnvYb1jyE+3PQoSIZ62Sll8L266XahG7A62o6n4cTCsiGgZiR54fWnuh/zUHntfdDzv8
         VytQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc/XDCbqM/997daLduhz4rKoFhdj8AaiZfILJaJ/3+kMh58OrCXxW8fXTAmecU57fA9DWYNm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnNWSQkQRegdrl2rxK6MIFZw6TaZSrKV9d5pfb9j9OhfLw56mQ
	qd+qUaRGw1Y/L61wJldmotubU3d2TySipMS9nhyjHU2bxvXJaXv/JHBr1mrNqTfNpzslUmnPzol
	xEwJnBXmgVsRErkxyqiA5Ai0NMnJKuK+lZerMkO50Gg==
X-Gm-Gg: ASbGnctktp8IPv31yYgZeZXWGz0WG+/fK39D4mvWhfHi0qc7PDOrQMGPo6TCtBuTHo+
	2LTzn7PD//mwWhQtpqUrBYH9rZl6RJQm66BqFyNCxFPW3d16OkntKp+vDINMHzd8tFHtKJLhtsu
	uUNDTZvXbV/E3YCixncSsyo93IkyRlZISlQoKCptf0Vxgr5h5Sud/vHNN+8biByXhpvsV4m9kXI
	C4Oa5Bo
X-Google-Smtp-Source: AGHT+IGy0o+sPFpXib6yHdR7WGyrmzjYx4mFz0tnIFDFn7KQNih+dVyk4rvY5Jt+JRh/3BfuratYJjCKxy9hxE/XQEc=
X-Received: by 2002:a05:6122:ca5:b0:545:ed72:fdf6 with SMTP id
 71dfb90a1353d-54a16b0c776mr419490e0c.1.1757633151034; Thu, 11 Sep 2025
 16:25:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911034337.43331-2-anderson@allelesecurity.com>
 <CANn89iKUKof727RDZkbfA-Q3pbV0U-pTH19L-kSvhhhtkKYGTA@mail.gmail.com> <CAJwJo6astnZxqkpikp4OtatHLMTq8-j35nRWYcq3HjX4eH0VuA@mail.gmail.com>
In-Reply-To: <CAJwJo6astnZxqkpikp4OtatHLMTq8-j35nRWYcq3HjX4eH0VuA@mail.gmail.com>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Thu, 11 Sep 2025 20:25:40 -0300
X-Gm-Features: Ac12FXwroVjeIwMWjfHSW-XyPlys1ueyV3e65cEGvRZZ3ObIx8VRayfW-2Nxbgk
Message-ID: <CAPhRvkzeYFbbZwr52kSzXMOX9Z=2ab6Y4NPUBYhWrTKJRFVO-w@mail.gmail.com>
Subject: Re: [PATCH v2] net/tcp: Fix a NULL pointer dereference when using
 TCP-AO with TCP_REPAIR.
To: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 11:23=E2=80=AFAM Dmitry Safonov <0x7f454c46@gmail.c=
om> wrote:
>
> Thanks for copying on the thread,
>
> On Thu, 11 Sept 2025 at 14:15, Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, Sep 10, 2025 at 8:49=E2=80=AFPM Anderson Nascimento
> > <anderson@allelesecurity.com> wrote:
> > >
> > > A NULL pointer dereference can occur in tcp_ao_finish_connect() durin=
g a
> > > connect() system call on a socket with a TCP-AO key added and TCP_REP=
AIR
> > > enabled.
> > >
> > > The function is called with skb being NULL and attempts to dereferenc=
e it
> > > on tcp_hdr(skb)->seq without a prior skb validation.
> > >
> > > Fix this by checking if skb is NULL before dereferencing it. If skb i=
s
> > > not NULL, the ao->risn is set to tcp_hdr(skb)->seq. If skb is NULL,
> > > ao->risn is set to 0 to keep compatibility with calls made from
> > > tcp_rcv_synsent_state_process().
> > >
> > > int main(void){
> > >         struct sockaddr_in sockaddr;
> > >         struct tcp_ao_add tcp_ao;
> > >         int sk;
> > >         int one =3D 1;
> > >
> > >         memset(&sockaddr,'\0',sizeof(sockaddr));
> > >         memset(&tcp_ao,'\0',sizeof(tcp_ao));
> > >
> > >         sk =3D socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
> > >
> > >         sockaddr.sin_family =3D AF_INET;
> > >
> > >         memcpy(tcp_ao.alg_name,"cmac(aes128)",12);
> > >         memcpy(tcp_ao.key,"ABCDEFGHABCDEFGH",16);
> > >         tcp_ao.keylen =3D 16;
> > >
> > >         memcpy(&tcp_ao.addr,&sockaddr,sizeof(sockaddr));
> > >
> > >         setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &tcp_ao,
> > >         sizeof(tcp_ao));
> > >         setsockopt(sk, IPPROTO_TCP, TCP_REPAIR, &one, sizeof(one));
> > >
> > >         sockaddr.sin_family =3D AF_INET;
> > >         sockaddr.sin_port =3D htobe16(123);
> > >
> > >         inet_aton("127.0.0.1", &sockaddr.sin_addr);
> > >
> > >         connect(sk,(struct sockaddr *)&sockaddr,sizeof(sockaddr));
> > >
> > > return 0;
> > > }
> > >
> > > $ gcc tcp-ao-nullptr.c -o tcp-ao-nullptr -Wall
> > > $ unshare -Urn
> > > # ip addr add 127.0.0.1 dev lo
> > > # ./tcp-ao-nullptr
> > >
> > > BUG: kernel NULL pointer dereference, address: 00000000000000b6
> > >
> >
> > CC Dmitry Safonov <0x7f454c46@gmail.com>
> >
> > <cut many useless details>
> >
> > Really I do not think you need to include the crash in the changelog.
> >
> > Just mentioning a possible NULL deref should be enough, it seems
> > obvious skb can be NULL here
> > now you mention it.
>
> > -       WRITE_ONCE(ao->risn, tcp_hdr(skb)->seq);
> > +       /* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connec=
t */
> > +       if (skb)
> > +               WRITE_ONCE(ao->risn, tcp_hdr(skb)->seq);
> > +       else
> > +               WRITE_ONCE(ao->risn, 0);
>
> I think we don't need 'else' here with 0-write. It may overwrite a
> value previously set. The allocation of ao_info is kzalloc() so even
> if it wasn't - we don't leak kernel memory contents here.
>
> > Real question is : can a TCP-AO socket be fully checkpointed/restored
> > with TCP_REPAIR ?
>
> Yeah, I've missed that skb can be 0 for TCP-REPAIR on connect().
> I have selftests to checkpoint/restore a socket, but they all
> checkpoint/dump an existing tcp-ao established connection, rather than
> set TCP-REPAIR before connect().
>
> > If not, we should just reject the attempt much earlier, and add needed
> > socket options to support it in the future if there is interest.
>
> The restoration of TCP-AO state is done with TCP_AO_REPAIR
> setsockopt(), the corresponding Initial Sequence Numbers (ISNs) should
> be set by tcp_ao_repair::{snt_isn,recv_isn}.
> So, I think at this moment it's fully possible to checkpoint/restore
> AO sockets (albeit, I haven't yet spent time to add support in CRIU).
> The only thing I've missed was connect() under repair-enabled.
>
> Thanks,
>              Dmitry

Thanks Eric and Dmitry. I've just sent a v3.

https://lore.kernel.org/all/20250911230743.2551-3-anderson@allelesecurity.c=
om/

Regards,

--=20
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com

