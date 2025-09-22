Return-Path: <netdev+bounces-225158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE08B8FA3F
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 10:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40F297AF43A
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 08:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18C0182B4;
	Mon, 22 Sep 2025 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T5vJxRAN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0646618A6A5
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758530842; cv=none; b=USScFl1692hsPlPvmHEOkB7A1iXeRMA1lEIZnarzVJViPbUwZZQ5CbCJn3kppMpLYizkjYNVwhayGkGri10tHMnJ7ETomPjO9ThOdbVlk2301A88qSZcXFHxLidPbcaLevuDcQ2tcjehDxLAgUent+2L6GjXtlSByQal+ok1Mtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758530842; c=relaxed/simple;
	bh=JvtiBkBgE4kAlDsKITe1J4w1OXcyFK3I4P2bWswDQzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FrI4diAu5e7hmoTsDL9GP7lYJCeaOO2KP0PP2Tg+hiO1TzQDR+JMfz7pVmlpFaWeIKG4hslaVpgiPO6ZVzI+HpcCdpFtC1t8HpVmdErl8p1eMEEkVF5V3VufRwSRGbInTqWxPek0DgVooNcwMyuPBuFx8AN+hMnU47N6KCulIg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T5vJxRAN; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b5d5b1bfa3so38584831cf.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 01:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758530840; x=1759135640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCfMj/xHVZ+NH6jebTpeuRUo1Azho8R7JEFgy/IGiXw=;
        b=T5vJxRANEH1Sp/Ux6DmRg1axOYxljQEb9zTnObwJvbKFSKYcfOcxa468IA0VLntmjf
         dqYqh6cynSTNm1dbIVJiuPobfAwWwsKJ3F0eFly5RSyBs+oU3SdXIQP7dovKKPEAKjbT
         dB9EfFnEKoPEBIJkKNPKWr9+2QaWjRdKXvdEcyjjfhh2iJawj0Fz5oisJkmG8dSDkEkI
         XAHKPfSCUlOW/XJc0p/Xxd2pHJt7nRE34o+cd71yjvK7Lzr56By+UltAbwelEf3Kufsp
         k12KNj5zCHeSuuY6UXLDZVBFWC5GERSPxU1J7aLRsAAw71CFoxlJAVpanH3imyzdmxm1
         aoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758530840; x=1759135640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCfMj/xHVZ+NH6jebTpeuRUo1Azho8R7JEFgy/IGiXw=;
        b=OOOm/f3iRA/54yTF84TetNp/JzItEA+usHHw5pX8/owkMAh12ltiAOWhtjIx5t+yDn
         Il29ozBRMLgTnLBl3av68kDRzXQNvAfbD4Cls26bfuo1jLsmvnERFcVuMLaBQAm9hRz7
         RtTsQ/Ab2n2misHPwCgdmnZvbiIl6MRwrq8tlWuQ0nMYb+uJO5jUP1WYmxRqHEvtT72w
         adb3D8hoZtRrn1aMx6J13EK4hWtZKWT26hiHQj0IMUML+yvXVNYTIxNoPo5kdCmm8zj5
         /tTPFEEzwq9CtJxv0bN4bUsEe+VBqAqJi3HLSBK9ewsLlu12hdOAmJ/CsweltHo2DeFP
         J+Wg==
X-Forwarded-Encrypted: i=1; AJvYcCURpBrO/DWiJJBZrexl4bJq8Zs/d5PYgNLuhqLQjqt9hKAdXCHgsdUZZywCnhsJwKwll7jIsq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbl0VO6x9XHrYzHVxCbg9sq7fWAT7i52MpSdqCNRoDSpSO/MKz
	KWtn1ZhXctHrWcazJgfI6krYrzMJiNs9sGho+bXhCaUdcap/6Trde0T/lYtNEW+DofrgBjoVxCM
	CSqWJf2HpAY/MrRACpRxJiGEbPDRUp5tQCUM5Dtpb
X-Gm-Gg: ASbGncuzDNjs2uUA3P5/iRyk0CQUB3fd79b2ll7htuk9p7hDV1YQb8YOpnUFUjzpk8f
	8FoQBLSEEjfyc9oQES/XfWv+lAnuwnZknw2wg0rXpfiV88Phcql31EghpH3E44nNpqEWUsJg1HE
	wCPhhy+ZjARNHP9W259DouXX594f5e7wlj/cSBBGKvqPGRuLz6LIyREFqSO7NTsMOeIEwpddtW7
	Q36iW4=
X-Google-Smtp-Source: AGHT+IEeHFFn6mLwBrVaNAaWuuEF6KfRcvKNW+yUQpmYxM+Bwi6mHA0VvKKRz8pj1aceOfaGSyR3MIPZyrs+dmIPk6A=
X-Received: by 2002:a05:622a:1c12:b0:4cf:b74b:e1b6 with SMTP id
 d75a77b69052e-4cfb74be6b0mr5981391cf.74.1758530839297; Mon, 22 Sep 2025
 01:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921095802.875191-1-edumazet@google.com> <3fbe9533-72e9-4667-9cf4-57dd2acf375c@redhat.com>
In-Reply-To: <3fbe9533-72e9-4667-9cf4-57dd2acf375c@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Sep 2025 01:47:08 -0700
X-Gm-Features: AS18NWCdB0mBWiIgGPDHJ8SwR_BGooDsDk_7HYcgi5sJXc_UsnWkNnoqczO_9eg
Message-ID: <CANn89i+RbuL9oknRn8uACRF-MMam=LvO6pVoR7BOUk=f5S6iVA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] udp: remove busylock and add per NUMA queues
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:37=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
>
> On 9/21/25 11:58 AM, Eric Dumazet wrote:
> > @@ -1718,14 +1699,23 @@ static int udp_rmem_schedule(struct sock *sk, i=
nt size)
> >  int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
> >  {
> >       struct sk_buff_head *list =3D &sk->sk_receive_queue;
> > +     struct udp_prod_queue *udp_prod_queue;
> > +     struct sk_buff *next, *to_drop =3D NULL;
> > +     struct llist_node *ll_list;
> >       unsigned int rmem, rcvbuf;
> > -     spinlock_t *busy =3D NULL;
> >       int size, err =3D -ENOMEM;
> > +     int total_size =3D 0;
> > +     int q_size =3D 0;
> > +     int nb =3D 0;
> >
> >       rmem =3D atomic_read(&sk->sk_rmem_alloc);
> >       rcvbuf =3D READ_ONCE(sk->sk_rcvbuf);
> >       size =3D skb->truesize;
> >
> > +     udp_prod_queue =3D &udp_sk(sk)->udp_prod_queue[numa_node_id()];
> > +
> > +     rmem +=3D atomic_read(&udp_prod_queue->rmem_alloc);
> > +
> >       /* Immediately drop when the receive queue is full.
> >        * Cast to unsigned int performs the boundary check for INT_MAX.
> >        */
>
> Double checking I'm reading the code correctly... AFAICS the rcvbuf size
> check is now only per NUMA node, that means that each node can now add
> at most sk_rcvbuf bytes to the socket receive queue simultaneously, am I
> correct?

This is a transient condition. In my tests with 6 NUMA nodes pushing
packets very hard,
I was not able to see a  significant bump of sk_rmem_alloc (over sk_rcvbuf)



>
> What if the user-space process never reads the packets (or is very
> slow)? I'm under the impression the max rcvbuf occupation will be
> limited only by the memory accounting?!? (and not by sk_rcvbuf)

Well, as soon as sk->sk_rmem_alloc is bigger than sk_rcvbuf, all
further incoming packets are dropped.

As you said, memory accounting is there.

This could matter if we had thousands of UDP sockets under flood at
the same time,
but that would require thousands of cpus and/or NIC rx queues.



>
> Side note: I'm wondering if we could avoid the numa queue for connected
> sockets? With early demux, and no nft/bridge in between the path from
> NIC to socket should be pretty fast and possibly the additional queuing
> visible?

I tried this last week and got no difference in performance on my test mach=
ines.

I can retry this and give you precise numbers before sending V4.

