Return-Path: <netdev+bounces-172583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590ACA55734
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720B13A8862
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0F32702CF;
	Thu,  6 Mar 2025 19:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLesiv/z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15869DDA8
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741291054; cv=none; b=SNHKUGU9ZdyVIWefUFHUDwg4QGuR+jTzDMDw82tVdKEXWZZ5ButlVMLTWif5HLr+x6p0WvKWKf2/y+YmVB1Ua0lZzNam6XLoPPAt4HliUeUuSfk/eB0lEAhOlAG6WUDovwk6yhqcQwYMckYRHfDtHynG77t3PSvN5+j2Kqz9zlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741291054; c=relaxed/simple;
	bh=u+8ZBDTvjgIGKVgXIkpl33y54B6y7BXQzI86vIc0ovY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jSDzUxCEhCTUP6CNvlfFAvf3uTOrCD5L9wsplpHDc5/yr69Hc9kgdfTaI2rNr4Jz9lEeAgdPe9UmUW9Q+keaQmT3AfykhY6/gFhTV7l7oGlUTD5IzgVoazwan6LO/hlbO82zVaToTNMnz/Je5ctShMPFnpu+4wYHmjq96VYXboE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLesiv/z; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47520132245so7498151cf.2
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 11:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741291052; x=1741895852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdSjtrzKMft12FSxpZnaTvxOWuB5HQQvSzB0pWT7z1k=;
        b=hLesiv/zJNuzkMebxycjtuQ1Qe752YGqXQa7+beFyeKlLlWBOtS2xL2/s80C0z+rbJ
         X33Wu45RITfDUua742eUjdx2zCtofQ+Rk94fUqJ+/hcv/Ty68dlbTjU7XbOZcWJkidgW
         OjJP9A762qc4kh3JTv2fY24sWjF1jUa9+ENt05u/mbaOhF+BvqoqDoMBvTh7MoUuOcKv
         LVQU9XBmc5TQRlns71aywikdM0PTfq1LTO/PZDQ1phM/7dkpMLydDvmgGj/lKvGtfkoD
         JB/jDS53g8yOKQCYJvEf3ESQhph5ElQR2gYa36YuAkb11ogt0ho4Ug7E6V9WxFDo3mpX
         fQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741291052; x=1741895852;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RdSjtrzKMft12FSxpZnaTvxOWuB5HQQvSzB0pWT7z1k=;
        b=Yd8dNjELOHOBLBpWLlLVF0drsuXLQK3L/r+Srl2io1Cbulgc1SwjX7IQYhfQh1i4cE
         3c/bHspEbMgaeU3Kmkx3LV3GKefFch5fWysyHBCaUN4BnYSK2DhFJQYtXAOWLCK7S+ld
         yjPGLAEM8Jh4luGSJUEq8vOeeoJQXD40JIjJ8jBQcdQ/cgqAV7YX7Wm9NXNze8U0dQ6v
         JXzYoUo/x3ktWEYRIMGcznDfGLcbGGLRdo+LEUoXxNjIJ+6lBX0MWbYITxsVlFPOL1p3
         K1uQshc5lEZNwWzvivRg0XAHkz9pAgkMUZ6nAgVwcW4lzwoJgixeiSul129mR9/JXl8K
         bSAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPZEpjQRO25SjN3uXiqwpFYf8xpGSsMxfSqll9GKUNy74zUBXswFRjscKu4wUHZXkg5HS3qqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhzNr7kBTej6c05/yqdzDZqT79/pbju0Wa1LqnOpUJwkNKPK0h
	hWsoN27v/Nouix9R5lmJlQMPVfeTgNU+mEX/CGgDNPK9AftrsXBg
X-Gm-Gg: ASbGncvipVLU61sxcVni2tlxc8n9sPst441+YuvggJrX4nGwCSOOC1NAatb4twbs2c7
	Rp4n+dQw5WRHbvIlMRKWKl7vPFTgTcVVrpVuBvyB9iXVtbtpWsoawLdbGZfCqTtkBiBPwwPsUSj
	6gWbKl3s/FOftZxxVu+tUszXE4JcDPIVefUsufNkrya1jHJvyEOX9A4KJm94SMsr/ZGstLQSPVI
	hATqfjpUqczp5otKymzi2KLNwwld48wOJgdV2hkUcRB1l/33znDtvX7d7+X50gnCzn4xbVWGYf2
	yhVwAY7SVb89NJj8cx8tF7Dv5rsAT92WeItShw7GS74UO9wFSP82h59mAAQ5GhM2TrgM1PeE9h0
	6n5oIX2TwknYrRLqrJlh0vg==
X-Google-Smtp-Source: AGHT+IFh6s2B32dGCZbrmBwTL6h8kBMVKVgTji+uITQw9P1pD1YWa//5Eid/fCZL/2EhUXeUAdkr5A==
X-Received: by 2002:ac8:7f50:0:b0:475:1734:296b with SMTP id d75a77b69052e-476109b174cmr5140871cf.25.1741291051807;
        Thu, 06 Mar 2025 11:57:31 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751db379a4sm10848931cf.50.2025.03.06.11.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:57:31 -0800 (PST)
Date: Thu, 06 Mar 2025 14:57:30 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com
Message-ID: <67c9fe2af078b_1bb0a2942a@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANn89i+QnSwxB33Hp48587EWAX=QYY0Msmv_bkfe_C1amk8Ftg@mail.gmail.com>
References: <20250306183101.817063-1-edumazet@google.com>
 <67c9f10e7f7e8_1580029446@willemb.c.googlers.com.notmuch>
 <CANn89i+QnSwxB33Hp48587EWAX=QYY0Msmv_bkfe_C1amk8Ftg@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: expand SKB_DROP_REASON_UDP_CSUM use
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet wrote:
> On Thu, Mar 6, 2025 at 8:01=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Eric Dumazet wrote:
> > > Use SKB_DROP_REASON_UDP_CSUM in __first_packet_length()
> > > and udp_read_skb() when dropping a packet because of
> > > a wrong UDP checksum.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  net/ipv4/udp.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > index 17c7736d8349433ad2d4cbcc9414b2f8112610af..39c3adf333b5f02ca53=
f768c918c75f2fc7f93ac 100644
> > > --- a/net/ipv4/udp.c
> > > +++ b/net/ipv4/udp.c
> > > @@ -1848,7 +1848,7 @@ static struct sk_buff *__first_packet_length(=
struct sock *sk,
> > >                       atomic_inc(&sk->sk_drops);
> > >                       __skb_unlink(skb, rcvq);
> > >                       *total +=3D skb->truesize;
> > > -                     kfree_skb(skb);
> > > +                     kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSU=
M);
> > >               } else {
> > >                       udp_skb_csum_unnecessary_set(skb);
> > >                       break;
> > > @@ -2002,7 +2002,7 @@ int udp_read_skb(struct sock *sk, skb_read_ac=
tor_t recv_actor)
> > >               __UDP_INC_STATS(net, UDP_MIB_CSUMERRORS, is_udplite);=

> > >               __UDP_INC_STATS(net, UDP_MIB_INERRORS, is_udplite);
> > >               atomic_inc(&sk->sk_drops);
> > > -             kfree_skb(skb);
> > > +             kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
> > >               goto try_again;
> > >       }
> >
> > From a quick search for UDP_MIB_CSUMERRORS, one more case with regula=
r
> > kfree_skb:
> >
> > csum_copy_err:
> >         if (!__sk_queue_drop_skb(sk, &udp_sk(sk)->reader_queue, skb, =
flags,
> >                                  udp_skb_destructor)) {
> >                 UDP_INC_STATS(sock_net(sk), UDP_MIB_CSUMERRORS, is_ud=
plite);
> >                 UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udpl=
ite);
> >         }
> >         kfree_skb(skb);
> =

> Right, I was unsure because of the conditional SNMP updates.

That seems to only suppress the update if peeking and the skb was
already dequeued (ENOENT).

Frankly, we probably never intended to increment this counter when
peeking, as it is intended to be a per-datagram counter, not a
per-recvmsg counter.

I think ever erring on the side of extra increments in the unlikely
case of ENOENT is fine.

Cleaner is perhaps to have a kfree_skb_reason inside that branch and
a consume_skb in the else.


