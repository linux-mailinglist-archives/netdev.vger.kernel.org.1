Return-Path: <netdev+bounces-237051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 068CDC43E3A
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 13:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B262E3AD980
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 12:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913EA2F25F6;
	Sun,  9 Nov 2025 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zmac/QXw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5782EBDDC
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762692880; cv=none; b=JTAYOMrE4BXMp68595PZoO+IiZSmJgaqGXQlpV6qPZRPFQqy1pIkSu8jfJqmAFRJSatgZTprizye7ciVbLlRZX0rfJbipXCbgnduBQKR3Zys0SxNOGOaL6jQTaI6CoDpNw+OUUeKxgyidhGTMg2iJ539rN6GXWiqA3pbRTpi1Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762692880; c=relaxed/simple;
	bh=ZPClDyHUowmohhGkWav/u/LrJy4eS94PPaNO8VOAhpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZAcsLEbaOXmdGEDnsDeIazUy3mECa0geGFlAHbvQGww6ouMKA+oIkDvWejl0GdsCiF/9whpaVPReL58IBqZrhAxLwEinUaiOOgf8MOGs5l8tVCz4YIzTRYLt0XtCRt2PfOf0lb7deLjW4vhRW6s0xm+AgkqqC4pMfXhBxh/mmXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zmac/QXw; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ed65fa5e50so11146581cf.0
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 04:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762692878; x=1763297678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCqIZTfX254IvBTWWQpjKZsfwk2La1cDqTNLXnN/Ay8=;
        b=Zmac/QXwAcYKgU2AV2PZtXH+9p8+4M/rpnEJGteJY7IXgUn8KsfDOGQ0kHG5W623kO
         2f+dShu88TQTq2bP/Wr+UZwd/UDPOrEGp1/da3glVQx+BKG89HTceLmZuIHvGPmBEkBq
         gvfs2T4/Sj+FIHOpPYoYSBazTjQjkAvh03LkG2HMsCPQOUCaXq0maA6QsAKM6T8yqhSX
         bwssDZsOxM71BfyVPrRgfPCd0hlxEQKB09IxPYIAHWIqXY3qGa1wENQKnWa0o8rSF6K7
         7fwivbYX2uZKshWN6JspRgOzF2BHqN0RO1mA9GC5GY6HsB+IAOs+nrEfHCNoWeUNoMJ4
         sbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762692878; x=1763297678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iCqIZTfX254IvBTWWQpjKZsfwk2La1cDqTNLXnN/Ay8=;
        b=gvc4uvpHEYX8qt2ZAmnQkSR9Zp41KYw1ym9DcsqQHmaczryciLYUQvC8U56VAsDoOT
         xVgBjTIS8OZpEOj1bW0jhHEpIxJvFq8KzyYvjChzPz9+iHiXIDArHTUgY01f3bKn+svi
         uuAtaD6cSlNFqfgH6yHnnKqn3IabY9wjpr7496gQuZ9lF9jzsH1xBwdfDjdnAzOeH0+w
         0v7ayKEGazPJzYmIsG7BWYiNCDQeyuzR09NoATTWrfYw/Uk6MeDI2N5c2+JxLlNVFmk5
         a3UPaXh/0TjyHbOq3qkwH7t1eD/hP5x4bEYFZutMmXd07tghk9cvTOrqD6eW6IazJQQa
         8DsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNRDdZeUG5YZSfGpjYJeuW1i9CwFUhLumm2KsdVWu6PXgE+wKOX7xZD4QEMBzEBJDL/Pi0kv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiGJqGU4PPzC0cp4K/wrfh13EdhydZSlbT8pL/SzPAfdAeaOg1
	s3icw/RYr5A0IE6ToQwf0uKsVCktFXKimVm+cNltrVq08G0ycYMHO0PM8HarxtmjQVc+yaUjkSG
	hVEkYOqQcipgTxM8v3So/j4mD9lOgImzg9hjpYeWP
X-Gm-Gg: ASbGncucuPJa9c1vj7RMhZsMfVJbzTNRjBy2kKIeJlIqvNWXRhenLNB0mv5Apu9+J1i
	vu5PK4tlhcu4BD4zJ2NuzUyvHx+lCC7gXX2mW5tLfxkFiitVqoOXZhxxzaRdVzHTbkPFHiSH841
	RqKA+BuSIUOoeLEUM1+kSnplNBZ7ML/Gq8F5v1yCr1YCkQLEfuEb+FvQdxhv0iF9V/ujMn6NJ/p
	m6goKHWoP3+D1k9WtWFUSt4QjagJiP5JLkkpnn4SA6rCRuS9eWYJhnV6qBkyukuk3qL8w==
X-Google-Smtp-Source: AGHT+IGY3hG/sJIVPrZRcNzxYmF4q92yRlM1yL9NWPeHIARXj96qdQqKf/b+mQhCvG3YIpTIJrgx5/EqLEHwVEN5JkU=
X-Received: by 2002:ac8:5a92:0:b0:4e8:b812:2e2a with SMTP id
 d75a77b69052e-4eda4e94134mr62615191cf.24.1762692877385; Sun, 09 Nov 2025
 04:54:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013145416.829707-1-edumazet@google.com> <20251013145416.829707-6-edumazet@google.com>
 <877bw1ooa7.fsf@toke.dk> <CANn89iJ70QW5v2NnnuH=td0NimgEaQgdxiof0_=yPS1AnZRggg@mail.gmail.com>
 <CANn89iKY7uMX41aLZA6cFXbjR49Z+WCSd7DgZDkTqXxfeqnXmg@mail.gmail.com> <CANn89iLQ3G6ffTN+=98+DDRhOzw8TNDqFd_YmYn168Qxyi4ucA@mail.gmail.com>
In-Reply-To: <CANn89iLQ3G6ffTN+=98+DDRhOzw8TNDqFd_YmYn168Qxyi4ucA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 9 Nov 2025 04:54:26 -0800
X-Gm-Features: AWmQ_bkPZyh8pfYTW4Ig9DXSHOW6QfVhyquFv_KkZYlMwJpcxFJjW1KeviV8rnE
Message-ID: <CANn89iLqUtGkgXj0BgrXJD8ckqrHkMriapKpwHNcMP06V_fAGQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 5/5] net: dev_queue_xmit() llist adoption
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 2:09=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
>
> This might be something related to XDP, because I ran the following
> test (IDPF, 32 TX queues)
>
> tc qd replace dev eth1 root cake
> ./super_netperf 16 -H tjbp27 -t UDP_STREAM -l 1000 -- -m 64 -Nn &
>
> Before my series : ~360 Kpps
> After my series : ~550 Kpps

Or ... being faster uncovered an old qdisc bug.

I mentioned the 'requeues' because I have seen this counter lately,
and was wondering if this could
be a driver bug.

It seems the bug is in generic qdisc code: try_bulk_dequeue_skb() is
trusting BQL, but can not see the driver might block before BQL.

 I am testing the following patch, it would be great if this solution
works for you.

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index d9a98d02a55fc361a223f3201e37b6a2b698bb5e..e18584604f0faab4e4d86a29565=
d7d982c9eb41d
100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -180,9 +180,10 @@ static inline void dev_requeue_skb(struct sk_buff
*skb, struct Qdisc *q)
 static void try_bulk_dequeue_skb(struct Qdisc *q,
                                 struct sk_buff *skb,
                                 const struct netdev_queue *txq,
-                                int *packets)
+                                int *packets, int quota)
 {
        int bytelimit =3D qdisc_avail_bulklimit(txq) - skb->len;
+       int cnt =3D 0;

        while (bytelimit > 0) {
                struct sk_buff *nskb =3D q->dequeue(q);
@@ -193,8 +194,10 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,
                bytelimit -=3D nskb->len; /* covers GSO len */
                skb->next =3D nskb;
                skb =3D nskb;
-               (*packets)++; /* GSO counts as one pkt */
+               if (++cnt >=3D quota)
+                       break;
        }
+       (*packets) +=3D cnt;
        skb_mark_not_on_list(skb);
 }

@@ -228,7 +231,7 @@ static void try_bulk_dequeue_skb_slow(struct Qdisc *q,
  * A requeued skb (via q->gso_skb) can also be a SKB list.
  */
 static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
-                                  int *packets)
+                                  int *packets, int quota)
 {
        const struct netdev_queue *txq =3D q->dev_queue;
        struct sk_buff *skb =3D NULL;
@@ -295,7 +298,7 @@ static struct sk_buff *dequeue_skb(struct Qdisc
*q, bool *validate,
        if (skb) {
 bulk:
                if (qdisc_may_bulk(q))
-                       try_bulk_dequeue_skb(q, skb, txq, packets);
+                       try_bulk_dequeue_skb(q, skb, txq, packets, quota);
                else
                        try_bulk_dequeue_skb_slow(q, skb, packets);
        }
@@ -387,7 +390,7 @@ bool sch_direct_xmit(struct sk_buff *skb, struct Qdisc =
*q,
  *                             >0 - queue is not empty.
  *
  */
-static inline bool qdisc_restart(struct Qdisc *q, int *packets)
+static inline bool qdisc_restart(struct Qdisc *q, int *packets, int quota)
 {
        spinlock_t *root_lock =3D NULL;
        struct netdev_queue *txq;
@@ -396,7 +399,7 @@ static inline bool qdisc_restart(struct Qdisc *q,
int *packets)
        bool validate;

        /* Dequeue packet */
-       skb =3D dequeue_skb(q, &validate, packets);
+       skb =3D dequeue_skb(q, &validate, packets, quota);
        if (unlikely(!skb))
                return false;

@@ -414,7 +417,7 @@ void __qdisc_run(struct Qdisc *q)
        int quota =3D READ_ONCE(net_hotdata.dev_tx_weight);
        int packets;

-       while (qdisc_restart(q, &packets)) {
+       while (qdisc_restart(q, &packets, quota)) {
                quota -=3D packets;
                if (quota <=3D 0) {
                        if (q->flags & TCQ_F_NOLOCK)

