Return-Path: <netdev+bounces-225677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A8DB96BFF
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCCD4A17B2
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33982E5B1B;
	Tue, 23 Sep 2025 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDAZQFLb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8B26C3AC
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643615; cv=none; b=EPZ6+nB2tQV4tSpmTivkTndPQZqYsySVAxr0HAtvlZRvjHqPNRmFiYoRr7MWv0yS9OZICGWxX7hiBxaKc6vWVB7edSsPpl2r5hdPDUS8be/9STOZOdFnMAYyEFdcpt+VFDRyTl1PHNuiLGYSMZxYlPbz8b+Bsq2Qjrc+YDLLOYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643615; c=relaxed/simple;
	bh=LSZaSxvgiNpblG6l7iGMnvMkhnGQyUdC6rYhgCCt/B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=al3kWsaO1iOGacVVP9eBKFPfvMN7Den1EEO/Ex084EVbaLh+KMyyl3XplA8SjT0+E1qtCYsw1fnR70M0JEVAN59AsV8r/MUh/JblJaNJTb/UMsScgyb192QuxLEUZz72j9mfLtXd3G97r8I5tuXNXFMPgnszb026xRI9cnvyUXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDAZQFLb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-273a0aeed57so265025ad.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758643614; x=1759248414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfZwWS5AXjSjh47+jujhHs0PNbVVMWVBOW1GeBhi9ZA=;
        b=jDAZQFLbYRjypsVLouT9JktzAGT65qfWajmhbBYcLDoe6lf1WQ2s8ns7TuAb+y1buj
         LqfsfmHJg20yW5zp7bsSRORX3VSChltKpnBt9nPYyWTRFw10QImNwec4CSoiif0F0zfN
         qLIZdzu0zDbPAQ2DfoWZjUNgceQiBcRgfQCrZqA8EnyqRAhRg8T2r8HbzDuqtHOyTdEX
         9Ur04TDIpRh71U5BB9NWJwklFZgnOD20VrXv/du4pYv9JCmQaHoAmOvW5ziY7t6Jm1Go
         c7eWs8PU1CoWTtnxPY/yYgFKf++IvfK1o/qJDTg1v1JVWQ13z6J9/CeNpdNd4iVJy3Oj
         kdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758643614; x=1759248414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfZwWS5AXjSjh47+jujhHs0PNbVVMWVBOW1GeBhi9ZA=;
        b=pNdChRH8qX+3KTwk/2bFYAxQe89AFGbmkoLxnKIfJVrS9PY7wp2TsS3XN3H4GfmCo7
         7BKuAEgQmWKEC3R+38uNRAMH4aAzUQDb3hHkGjor2ETmhGMZBXFzchT5l3owcB+veHzD
         FxIL8eYzxJ36mmHWFfyY9tG57J4N8A8zS/jKRq72Ndwq5sV4Gh8n32jZsd6oCKUX9SO3
         BkiMpVuHXzBFkOQbU61r/o1h4NDFWQFeRVEhorSG8zVHS/x+jrhgorng2TOnhKitGfR7
         CkqX8BI6jrgEykPHRJUJl+U6CJzT2QlVwPReqIKQXxKtZV0675W78awJjF30s0OXXqFe
         u7tA==
X-Gm-Message-State: AOJu0Yyy1WlWeunHQeiObHLLG1HVZrJxMkiY2htchec4DCVk5z+lvwUT
	hMvpywmzvZKmw3f/ck3wnXCflgXr8Hnf3S2JPcl0yxnpQSGLlEcf4qIc8G0tlcCtCniqNWZCk10
	Tpkx7QNWER82TBOM43pXgwGc9zRP1E6w=
X-Gm-Gg: ASbGncvvVCEjZ30TreLdTeJL3oSVTICjvBCMlHeuCIUdIdLsCBSCy1MxaceMFtLNLmU
	vw0QP51iopsAiYYm0vuIwFs+yxP1q7q+vF4RJA03iOJib4WJPiTCRvYzPyFGjnHELJXd3y/O5U/
	r4PoFigbHNtFEwE5deHMSDh7U1WRGBJZ3L6RVEvTDJ9xqL3i4MIwoqJ3XfgZstINL5hAeT5SXXU
	MJgHnkkvjGiOar45nIFptna5J7M2cCe1egwCo4D6A==
X-Google-Smtp-Source: AGHT+IElrnbiPc11xcIlgx/7eLp17j7KN5c1/0biJ0i/uJUb0MwRHW0VDJc6A4N7uhdDkUSkX1wG1aPAZnUI5GY+570=
X-Received: by 2002:a17:903:2447:b0:266:3f63:3500 with SMTP id
 d9443c01a7336-27cd7a31339mr34522615ad.12.1758643613364; Tue, 23 Sep 2025
 09:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758234904.git.lucien.xin@gmail.com> <a7fb75136c7c2e51b7081d3bff421e01b435288f.1758234904.git.lucien.xin@gmail.com>
 <871ed254-c3d8-49aa-9aac-eeb72e82f55d@redhat.com>
In-Reply-To: <871ed254-c3d8-49aa-9aac-eeb72e82f55d@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 23 Sep 2025 12:06:41 -0400
X-Gm-Features: AS18NWD1Po0NumxImO775C_7VSP655cJIPbmA0dWx2wuT8JxABkrL-E_ndi5lAw
Message-ID: <CADvbK_e20TrcgprXmnZzvoEO6yzoo4Zx7B0qFS0kQPT8Sf63LQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 03/15] quic: provide common utilities and data structures
To: Paolo Abeni <pabeni@redhat.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Benjamin Coddington <bcodding@redhat.com>, Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, 
	Alexander Aring <aahringo@redhat.com>, David Howells <dhowells@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, John Ericson <mail@johnericson.me>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "D . Wythe" <alibuda@linux.alibaba.com>, 
	Jason Baron <jbaron@akamai.com>, illiliti <illiliti@protonmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Daniel Stenberg <daniel@haxx.se>, Andy Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 7:21=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 9/19/25 12:34 AM, Xin Long wrote:
> > This patch provides foundational data structures and utilities used
> > throughout the QUIC stack.
> >
> > It introduces packet header types, connection ID support, and address
> > handling. Hash tables are added to manage socket lookup and connection
> > ID mapping.
> >
> > A flexible binary data type is provided, along with helpers for parsing=
,
> > matching, and memory management. Helpers for encoding and decoding
> > transport parameters and frames are also included.
> >
> > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > ---
> > v3:
> >   - Rework hashtables: split into two types and size them based on
> >     totalram_pages(), similar to SCTP (reported by Paolo).
> >   - struct quic_shash_table: use rwlock instead of spinlock.
>
> Why? rwlock usage should be avoided in networking (as it's unfair, see
> the many refactors replacing rwlock with rcu/plain spinlock)
Interesting, I thought rwlock works better than spinlock in this case.
I will change back to spinlock.

>
> [...]
> > +
> > +static int quic_uhash_table_init(struct quic_uhash_table *ht, u32 max_=
size, int order)
> > +{
> > +     int i, max_order, size;
> > +
> > +     /* Same sizing logic as in quic_shash_table_init(). */
> > +     max_order =3D get_order(max_size * sizeof(struct quic_uhash_head)=
);
> > +     order =3D min(order, max_order);
> > +     do {
> > +             ht->hash =3D (struct quic_uhash_head *)
> > +                     __get_free_pages(GFP_KERNEL | __GFP_NOWARN, order=
);
> > +     } while (!ht->hash && --order > 0);
>
> You can avoid a little complexity, and see more consistent behaviour,
> using plain vmalloc() or alloc_large_system_hash() with no fallback.
>
I wanted to use alloc_large_system_hash(), but the memory allocated
by it is usually NOT meant to be freed at runtime. I don't see a free_
function to do it either.

If QUIC works as a kernel module, what should I do with this memory
in module_exit()?

>
> > +/* rfc9000#section-a.3: DecodePacketNumber()
> > + *
> > + * Reconstructs the full packet number from a truncated one.
> > + */
> > +s64 quic_get_num(s64 max_pkt_num, s64 pkt_num, u32 n)
> > +{
> > +     s64 expected =3D max_pkt_num + 1;
> > +     s64 win =3D BIT_ULL(n * 8);
> > +     s64 hwin =3D win / 2;
> > +     s64 mask =3D win - 1;
> > +     s64 cand;
> > +
> > +     cand =3D (expected & ~mask) | pkt_num;
> > +     if (cand <=3D expected - hwin && cand < (1ULL << 62) - win)
> > +             return cand + win;
> > +     if (cand > expected + hwin && cand >=3D win)
> > +             return cand - win;
> > +     return cand;
>
> The above is a bit obscure to me; replacing magic nubers (62) with macro
> could help. Some more comments also would do.
>
The code is exactly from the commented doc:
/* rfc9000#section-a.3: DecodePacketNumber()

See:
https://datatracker.ietf.org/doc/html/rfc9000#section-a.3

I will bring some comments from there.

Thanks.

