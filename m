Return-Path: <netdev+bounces-225216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796E8B9000F
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 12:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5934418A1302
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 10:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BF9287244;
	Mon, 22 Sep 2025 10:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cKbzjI03"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D91D182B7
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 10:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536971; cv=none; b=jkbbDpOVUIDeEHdCjch0MHfu1c7y7bBB8TTzCj0BDB4jKiueHjsp6eQ5DS/A/TbOOrA8GL0+99KV13fCfjkRYcqIhdpoFS/RcJQ7A3VMUXDf+Vmy+GyK56/QqD30OqkK9FCt31vJw6ha1bfNnfPQeeXFiApznj1XAMATbLF6b6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536971; c=relaxed/simple;
	bh=rHeBGeR0CylYwkba3GVbQAq+WpKlshVlcqH3lzrXuFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2houWQ+edWkcKtmXrG5mAlZzQ74thKXfq5V4DyxTJZro1igBBKlkGRcCERvev+LfklzHDicZvF1iG/iNHBzM36mFOIZ2ukqbI4Mczb6SxGjPcCKs8aIJb3zWlsaHezbAdp2fvHWtFkgBCpGYFNJ1+4YkG8SquKOeQZqCSc4lTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cKbzjI03; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4d10f772416so1146711cf.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 03:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758536968; x=1759141768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UwEaQVU7bjQdJmjSl9MEBLY5nQHHDFmN43ne1DeMWs=;
        b=cKbzjI03ugyQmCShN7fWtjDH6tYZWcSntcIQMwTe+ESMJPjtAUJhHTRiJwS6eeLam3
         PGA72VVFGQqG8pm7SwgUV8/BpAQUYg192waj3aWRnqxzETs7xiIx7k9JF5gpEiCR9DNo
         iPRuHLpAyHakv+0VM5oAIeVIwjfGuVaTnXcpDbasvdnMiumuB+LKRBHHpHxn2WusJR5x
         c2WgOZkU9RV9xUQoy7dOHs868TmHo//aVNlK1w0+ueJ0rAW8Ws6YJBqxZL1TgAyK7CEd
         eIGbiTDB3u8WDFvVyBofDxAeaUpIPnmx5dxgzbds+H7j31YP+KfP2H3ZSqU/7+7LNY5a
         Gw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758536968; x=1759141768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UwEaQVU7bjQdJmjSl9MEBLY5nQHHDFmN43ne1DeMWs=;
        b=EsHicQeMHjX7MYsrhWMK5aH+d+X8eoPDBm/5LvRGE4aJ7gwVw1S4GpFdfMs9hiZvO0
         12Sj7LMeM+fXJkCUTx+WblqSY3JUZJtv3T5uzHeD3pommhvbaVKtXvZyTsxiQjnBF8c8
         8DzdVb2MIar8xdnunvNvDUXzXHcqrDWJV8nzOuDUy1GtwgFX3hWHrEuGNP2qdhoUT70h
         eurx1/NwwQF9VZzNS4JYe9OE5xBtfsgqdrLEDfKjlFb+WDSnh9kSv3h1jmPCFkLmUPM2
         keb4HtDNYqPrklcyWEI7ajS6o6bRkVTsT1AY+nX+Tb2yG5jYqUi7BDCLpt2rU2T6eJNl
         AAFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgFx2VmJgWNRWQiXwAf1S056zyxJtUZfc+eftMLYfa7FToKe1mcF+NmrWkxWhGF1rnnX9tg7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9o8aQEaIxQv9kAkewwPJPwg27aaBLJ0bMHf0/osKyHX8U4eBD
	jgYpiX11whX8oWI5/jpIOTyyIi6C+XLx1npVW4KbLURrdAe3qvFfLjrq7Vw1+4gW7tfKy/RgDVY
	jYWb0S8CXZo1hRwyVOfA3wfq0+tBshZOGeN1tEdlf
X-Gm-Gg: ASbGncvhn8VcJZNw1ylbklSJE9wVHXHY7+W1DorV7GaHAJPJaZIUTELM4J5YF8GFmOi
	RjvgM+GQy+0p2NB44qLnZD3hz/16Mk8IRC0e2K1gRC7Nh7WiYLv/xle+3y+flZKH2EM25tYWvKJ
	5L5FYT8nH11sTy67HmJ+VcPWlFHZsYwZO0Y0GqDKCsxa/HY+BX2eWJwq9sNA5RDfDfIQRzt7uGq
	BSAv6o=
X-Google-Smtp-Source: AGHT+IHnLoKvNTbS4QOIKyval0lCysJnLf9BXpwBn194Ex/+BTndUkU+yL6NHeenFDhcYPoT1fOpeYwFBcraF+FKQ2k=
X-Received: by 2002:ac8:5a0c:0:b0:4cd:ff33:1ce7 with SMTP id
 d75a77b69052e-4cdff51a4eemr14140281cf.3.1758536967964; Mon, 22 Sep 2025
 03:29:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921095802.875191-1-edumazet@google.com> <3fbe9533-72e9-4667-9cf4-57dd2acf375c@redhat.com>
 <CANn89i+RbuL9oknRn8uACRF-MMam=LvO6pVoR7BOUk=f5S6iVA@mail.gmail.com>
 <CANn89iKcye6Zsij4=jQ2V9ofbCwRB45HPJUdn7YbFQU1TmQVbw@mail.gmail.com> <221b8f60-0644-4744-93dc-a46a68411270@redhat.com>
In-Reply-To: <221b8f60-0644-4744-93dc-a46a68411270@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Sep 2025 03:29:16 -0700
X-Gm-Features: AS18NWDkGLkNks_HQVp6xOmirZ4MG7R-LUY5D3CY98_KZFzhIuJ5qjnprZpVABs
Message-ID: <CANn89i+s3kAc_h0kP=enN4jEp1x0HCLaAX4H+X3P=LBGjzjZTw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] udp: remove busylock and add per NUMA queues
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 2:41=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 9/22/25 11:34 AM, Eric Dumazet wrote:
> > On Mon, Sep 22, 2025 at 1:47=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> >> On Mon, Sep 22, 2025 at 1:37=E2=80=AFAM Paolo Abeni <pabeni@redhat.com=
> wrote:
> >>> On 9/21/25 11:58 AM, Eric Dumazet wrote:
> >>>> @@ -1718,14 +1699,23 @@ static int udp_rmem_schedule(struct sock *sk=
, int size)
> >>>>  int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb=
)
> >>>>  {
> >>>>       struct sk_buff_head *list =3D &sk->sk_receive_queue;
> >>>> +     struct udp_prod_queue *udp_prod_queue;
> >>>> +     struct sk_buff *next, *to_drop =3D NULL;
> >>>> +     struct llist_node *ll_list;
> >>>>       unsigned int rmem, rcvbuf;
> >>>> -     spinlock_t *busy =3D NULL;
> >>>>       int size, err =3D -ENOMEM;
> >>>> +     int total_size =3D 0;
> >>>> +     int q_size =3D 0;
> >>>> +     int nb =3D 0;
> >>>>
> >>>>       rmem =3D atomic_read(&sk->sk_rmem_alloc);
> >>>>       rcvbuf =3D READ_ONCE(sk->sk_rcvbuf);
> >>>>       size =3D skb->truesize;
> >>>>
> >>>> +     udp_prod_queue =3D &udp_sk(sk)->udp_prod_queue[numa_node_id()]=
;
> >>>> +
> >>>> +     rmem +=3D atomic_read(&udp_prod_queue->rmem_alloc);
> >>>> +
> >>>>       /* Immediately drop when the receive queue is full.
> >>>>        * Cast to unsigned int performs the boundary check for INT_MA=
X.
> >>>>        */
> >>>
> >>> Double checking I'm reading the code correctly... AFAICS the rcvbuf s=
ize
> >>> check is now only per NUMA node, that means that each node can now ad=
d
> >>> at most sk_rcvbuf bytes to the socket receive queue simultaneously, a=
m I
> >>> correct?
> >>
> >> This is a transient condition. In my tests with 6 NUMA nodes pushing
> >> packets very hard,
> >> I was not able to see a  significant bump of sk_rmem_alloc (over sk_rc=
vbuf)
> >>
> >>
> >>
> >>>
> >>> What if the user-space process never reads the packets (or is very
> >>> slow)? I'm under the impression the max rcvbuf occupation will be
> >>> limited only by the memory accounting?!? (and not by sk_rcvbuf)
> >>
> >> Well, as soon as sk->sk_rmem_alloc is bigger than sk_rcvbuf, all
> >> further incoming packets are dropped.
> >>
> >> As you said, memory accounting is there.
> >>
> >> This could matter if we had thousands of UDP sockets under flood at
> >> the same time,
> >> but that would require thousands of cpus and/or NIC rx queues.
> >>
> >>
> >>
> >>>
> >>> Side note: I'm wondering if we could avoid the numa queue for connect=
ed
> >>> sockets? With early demux, and no nft/bridge in between the path from
> >>> NIC to socket should be pretty fast and possibly the additional queui=
ng
> >>> visible?
> >>
> >> I tried this last week and got no difference in performance on my test=
 machines.
> >>
> >> I can retry this and give you precise numbers before sending V4.
> >
> > I did my experiment again.
> >
> > Very little difference (1 or 2 %, but would need many runs to have a
> > confirmation)
> >
> > Also loopback traffic would be unprotected (Only RSS on a physical NIC
> > would properly use a single cpu for all packets)
> >
> > Looking at the performance profile of the cpus
>
> [...]
>
> Indeed delta looks in the noise range, thanks for checking.
>
> Just in case there is any doubt:
>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Thanks for the review Paolo, I will include your Acked-by to V4.

