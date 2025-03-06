Return-Path: <netdev+bounces-172548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0246AA55649
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BC83B325D
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1E026BDB5;
	Thu,  6 Mar 2025 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UFXsLot5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58C025A652
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288361; cv=none; b=LWPdQ6zWUY/+39fezYxGGqzQNys5fJoj0oc8gsg9t9i8B9R0zI6t3YY3GrAU4rI/MI/mX/FbzQkvN8RwutoOWCH93UiEIyf5dq9KDQjPq0eWFOckPBTXLxCuPSXVOQQ9Tn5MGVD+z2Pu+LkNhi0hf8dye3aJ9n8JcCSrY1uLTxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288361; c=relaxed/simple;
	bh=0OhKMeGNt5JkkWRnIi9YYp2XUlecu4tHPKBcCgYgFu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ni6Qj9FxpcFqr8RwbiP44Wi2Pwhkj5gejEktRUUoBc/kxaDt6Ove908YEYMKAOBojFGlFQpdzBVWsLh+TNKe4CPsqGi5rCJk7VzjOu3IS3HfW95Lhk47Ptd2KAQsVkeWdhFXgQGLqc1Kw+/7D1vL16FBqIVhYcqfDNygQRXhS3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UFXsLot5; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4751f8c0122so8298031cf.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 11:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741288358; x=1741893158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sOX57mpe/kC/UsW5BE3PIwv5MQIDrTVk7QQWjvZOQA=;
        b=UFXsLot5EoMqpH/zXDx/5jYVpHTFNK/sPf8uUt5Y4py22E9YWcewTfDI5DCUYKwnyo
         TQ7fOaTbouNj7YhS+Cex2ohpXZQLpbe8sRUKNAGYYanmhTDeTsVFgJ5If6ys/tyVwnX4
         5yw5xG48Nbp+7XBvFmKrqbqAQ7qbh3Fr+yKkwF2+Y3NseITM6wUKxW1Eug2Yo9V+xp5x
         mC0SpLJi0Lz1OfWGFT2U2gsxwGQqw1K17HY2ilRzlt/9uui3PXeAMpd4fLlXOXu6O6c/
         YSwG4fqWMPC+2VgjcctMY2VAjm5NGes2FKhT2F55tnKZLgcKrLgwwVpuy+PWTaAg5xii
         PBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741288358; x=1741893158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sOX57mpe/kC/UsW5BE3PIwv5MQIDrTVk7QQWjvZOQA=;
        b=qGLrKM3fZdToDf2eQPbvgLhxH0uXCUGudP/pQADylMoh60Pb+QwRcd9WNOsGXtdIEk
         ctgLikNFVNEiLlrnmp0NN/CR+y605ecz4AdHB5QQmlUStFn8plVQvptKHCEMiYEg2B1F
         M/gnr6lcxvyTcoMVav2cqBrhXeYs5c74EytysMAYWlvLZsBS9pg/L6uWaRVycHAzWq9o
         jBl7YlFJ5V2o/DGIJWGFKPDTzTFL+syvTEG7OESnclUKnc4J6wvLk0wTHcE22fnImEOA
         1eocnd09xUsz1mOy3j/pbH0gu16kNWnHFerOtuwpy2GXexBsGrRnb4i0N2cPVnxJ8EgD
         pbqg==
X-Forwarded-Encrypted: i=1; AJvYcCXX9aUgwl32mfqf0MF2D3IatG6GqOtYn/FyjJB7ROhrDDXwvtZMhjPfLDId6KiKWrqFgTVvvcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtlt0TF7wVeCtNYBNXCMML1CvGBogJ+R3LgBwQpUqI9c3TKzRQ
	3DlJGYqWpJF7zJKLj+vj+zQIYePjriiazfI+tClmiariRfhMkwYx/OJioxW78CCC+23pfpHkxtp
	ouQYs/DLPuIgLjE5uinmOOMVPpwNxex+Aje1B
X-Gm-Gg: ASbGnctWvo7SLDyUSuHfBodbqqE/lJSwDtm/SyJnWZwlsSNUwSFLRnyBdGjvjEkMLTf
	yKL9NfqPrwdnW3jZnHD3eb46UG6dgwAEQxMBg94RRrViujHgzCehUnaR8CZUmyDQlG/eEdKhxHu
	ujLaSRX2mwPXCoPrbjzOa6JK9SkP0=
X-Google-Smtp-Source: AGHT+IHMHIo2D8SY3U3LaYOmdU0JtRkKy4NH9+SVjhPZg8Y+FJg7bO0JfnH3XpvDyDJpWZeHQStEVmSsDVuHRK7DoDA=
X-Received: by 2002:a05:622a:50:b0:472:6aa:d6bd with SMTP id
 d75a77b69052e-4761194a6bfmr3351641cf.41.1741288358413; Thu, 06 Mar 2025
 11:12:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306183101.817063-1-edumazet@google.com> <67c9f10e7f7e8_1580029446@willemb.c.googlers.com.notmuch>
In-Reply-To: <67c9f10e7f7e8_1580029446@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Mar 2025 20:12:26 +0100
X-Gm-Features: AQ5f1JqlclDY_V9sk9F-VHVzlTTWey_x406UKs5soc6M-0wLE0XgmKwL5gh01eI
Message-ID: <CANn89i+QnSwxB33Hp48587EWAX=QYY0Msmv_bkfe_C1amk8Ftg@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: expand SKB_DROP_REASON_UDP_CSUM use
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 8:01=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > Use SKB_DROP_REASON_UDP_CSUM in __first_packet_length()
> > and udp_read_skb() when dropping a packet because of
> > a wrong UDP checksum.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/ipv4/udp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index 17c7736d8349433ad2d4cbcc9414b2f8112610af..39c3adf333b5f02ca53f768=
c918c75f2fc7f93ac 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -1848,7 +1848,7 @@ static struct sk_buff *__first_packet_length(stru=
ct sock *sk,
> >                       atomic_inc(&sk->sk_drops);
> >                       __skb_unlink(skb, rcvq);
> >                       *total +=3D skb->truesize;
> > -                     kfree_skb(skb);
> > +                     kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
> >               } else {
> >                       udp_skb_csum_unnecessary_set(skb);
> >                       break;
> > @@ -2002,7 +2002,7 @@ int udp_read_skb(struct sock *sk, skb_read_actor_=
t recv_actor)
> >               __UDP_INC_STATS(net, UDP_MIB_CSUMERRORS, is_udplite);
> >               __UDP_INC_STATS(net, UDP_MIB_INERRORS, is_udplite);
> >               atomic_inc(&sk->sk_drops);
> > -             kfree_skb(skb);
> > +             kfree_skb_reason(skb, SKB_DROP_REASON_UDP_CSUM);
> >               goto try_again;
> >       }
>
> From a quick search for UDP_MIB_CSUMERRORS, one more case with regular
> kfree_skb:
>
> csum_copy_err:
>         if (!__sk_queue_drop_skb(sk, &udp_sk(sk)->reader_queue, skb, flag=
s,
>                                  udp_skb_destructor)) {
>                 UDP_INC_STATS(sock_net(sk), UDP_MIB_CSUMERRORS, is_udplit=
e);
>                 UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite)=
;
>         }
>         kfree_skb(skb);

Right, I was unsure because of the conditional SNMP updates.

