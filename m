Return-Path: <netdev+bounces-177089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EBFA6DD21
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46AD63A1DAE
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B076725C6FE;
	Mon, 24 Mar 2025 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PP3Mh425"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F15F469D
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826953; cv=none; b=HIIC+qTek7I4zivClDYCDYbpRCCC4W9WG8o6v/5nirkm9LwbR5cvJ9pYI5bGm2tp+TW/iCcir9qznIIK+q+Fz+JzrYOh2/NaBTRGrI9yCc6c3/X6yZtA0LSEOtO5sQpD6xhYo6xP70OeHGjrpM0kFPD8lXfs4RVBddiNkuSjzhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826953; c=relaxed/simple;
	bh=XM0rcQ0UOVBUXgtviqMq9NTWJ+J3/1fBfkUOQBy6T7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ep8V6UkoOt8no12crdiykyHsnOP1vaa/KDtiUoGD072KW1eXyjkyAM25Lt/D88OZtQkVjNEjE3MvUcPtdWMy5ov+GMmiIKjnYGNF9o7gbPjV0tI2wT+LQcHGOWbu0p+P9hG6S/yDD7uHdgrjbvPTqSO8Y4iQxLor2SpaUdU/HSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PP3Mh425; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-476f4e9cf92so29400131cf.3
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 07:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742826951; x=1743431751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IscyWs4ybX/tP7T/ACjOTDRQv9ZEUJx4fNcIohzunkw=;
        b=PP3Mh425XPaehhajKzw9rV9+xVEkC1E2FYCwLaELpIZeZ4TT0RvYtWPXObrbDIa0SO
         HCVzMChGQJMf4ezmYJPuhO7ZRCOnmfRi9cw3DOoMRub8b6b39avk1MAr4V6XZ4FqSfsn
         p049MrppTa2mfsjgAHpMFbz+Nt8feE3aFEMRZ4ftIouNWpd+n5WJcaB8f9mcsVYy4GfC
         g14ywlo2BFc//SHC7FAPJw7QMSaG1DKUfVMHYDsDdljFgC6aM7MaEdNMweRFyvYyCJW2
         3oIJ60Vl/F0v8VIZDsRG1s2Euhj3VGO9aAdl6B1QtWTMjxFciAmONUE/bYq7qLMmh7Z5
         0+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742826951; x=1743431751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IscyWs4ybX/tP7T/ACjOTDRQv9ZEUJx4fNcIohzunkw=;
        b=NKoZumgWB8dLNCdVbQHNov4MjGEB0Qyefqv5jaqZfNb1cMIPVZxUJqJDnqRRNgO327
         VccsIq54dqvlXgXUHVJzEb67nU2Jpr7kQtj0PBOxL6z71VUCbshlBy/j60iSmWlVxgvt
         vclUkIXe5Lan1J8FbhESIPbhkK/k8OKBjVZx/eQYykj42QGAsMBKQQGXyhcogzaIHEZH
         ixgpShw3iLcjxa69M6ccxS3bYWja3PVquBemYygScFjEBhnjEbmBp6QLS8BsRwwEPcFr
         Qd/BHeyk/w+D9vsfBhs4ccqcwh5516Y6Z1mxo/2HS8X4bgojMUYK0NZ2hEg1CMan7931
         zygg==
X-Forwarded-Encrypted: i=1; AJvYcCVWOQKgGHNvZskZ5r+8jRF5Yivl3B2UDpi0D2ddJPYJYl44A8bWVbz7RhKtNjdc/DVsPyWxlMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK9nn2G23bI2SiZ3arnXYTWnVEZMG6FoOoS9SonHvB2lY9SO05
	luNxOMRv88NJl293ipQGktm3LN3Kn2PqIPHM2IAdXCEa2kRS8wET9est+zCNrDBoGfTHYdNpdUz
	AYc2FrgPl8dCIk5hfapHLlWPSmapqI81PLsWT
X-Gm-Gg: ASbGncu+W/Met0kXQElOpuiiLHPjcnvSuKdqSNmfbRg7k40IGSovsjt/XsnIO+S/BrS
	XuW3h/STbmfDx/BjOYh+AHMcNFed6ZBKOxgPsEdEcPKcvZVKLTjOKmDilAdk3wcuSG5EakitrkW
	wcuVTY4fa1et+06q+nuETJ+1A4g6Y=
X-Google-Smtp-Source: AGHT+IGkKdULcI8sEVvbYW/Bsbwip6N2am+upF7+We7GxBmoqptqHgHumNfm8tc5zvx7cbagcaYxfDayusRRrOwyxuQ=
X-Received: by 2002:a05:622a:2611:b0:476:8cef:4f0e with SMTP id
 d75a77b69052e-4771ddd3896mr181138901cf.29.1742826950508; Mon, 24 Mar 2025
 07:35:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321171309.634100-1-edumazet@google.com> <20250324141619.GE892515@horms.kernel.org>
In-Reply-To: <20250324141619.GE892515@horms.kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Mar 2025 15:35:39 +0100
X-Gm-Features: AQ5f1Joa3l4HveHuKhuHZMETCI_BmZPKW0ex0mUm_p1P7_LpKZaS4ZCBgkK2zcA
Message-ID: <CANn89iKz2PfhP1qdSqaV5bG0YncDFW1s=5MiimUR2TYgKqpZ9w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: rfs: hash function change
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Tom Herbert <tom@herbertland.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 3:16=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Mar 21, 2025 at 05:13:09PM +0000, Eric Dumazet wrote:
> > RFS is using two kinds of hash tables.
> >
> > First one is controled by /proc/sys/net/core/rps_sock_flow_entries =3D =
2^N
> > and using the N low order bits of the l4 hash is good enough.
> >
> > Then each RX queue has its own hash table, controled by
> > /sys/class/net/eth1/queues/rx-$q/rps_flow_cnt =3D 2^X
> >
> > Current hash function, using the X low order bits is suboptimal,
> > because RSS is usually using Func(hash) =3D (hash % power_of_two);
> >
> > For example, with 32 RX queues, 6 low order bits have no entropy
> > for a given queue.
> >
> > Switch this hash function to hash_32(hash, log) to increase
> > chances to use all possible slots and reduce collisions.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Tom Herbert <tom@herbertland.com>
>
> Reviewed-by: Simon Horman <horms@kernel.org>
>
> ...
>
> > @@ -4903,13 +4908,13 @@ bool rps_may_expire_flow(struct net_device *dev=
, u16 rxq_index,
> >
> >       rcu_read_lock();
> >       flow_table =3D rcu_dereference(rxqueue->rps_flow_table);
> > -     if (flow_table && flow_id <=3D flow_table->mask) {
> > +     if (flow_table && flow_id < (1UL << flow_table->log)) {
> >               rflow =3D &flow_table->flows[flow_id];
> >               cpu =3D READ_ONCE(rflow->cpu);
> >               if (READ_ONCE(rflow->filter) =3D=3D filter_id && cpu < nr=
_cpu_ids &&
> >                   ((int)(READ_ONCE(per_cpu(softnet_data, cpu).input_que=
ue_head) -
> >                          READ_ONCE(rflow->last_qtail)) <
> > -                  (int)(10 * flow_table->mask)))
> > +                  (int)(10 << flow_table->log)))
>
> I am assuming that we don't care that (10 * flow_table->mask) and
> (10 << flow_table->log) are close but not exactly the same.
>
> e.g. mask =3D 0x3f =3D> log =3D 6

Yes, I doubt we care.
The 10 constant seems quite arbitrary anyway.

We also could keep both fields in flow_table : ->log and ->mask

I chose to remove ->mask mostly to detect all places needing scrutiny
for the hash function change.

