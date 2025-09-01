Return-Path: <netdev+bounces-218938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5F5B3F0E5
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 00:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A38206BB0
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35AD2820D1;
	Mon,  1 Sep 2025 22:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="gZvO6XlZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F37C32F75D
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756764790; cv=none; b=sB/PihRWb+6RgWTP1IxuPzCeGSQsFoHymCoCM7fLbe8iZExtkIqWk3nq6d30/3PR5G4Xo1HiWvI1mk4kf2sfM9FS1dQH2ygNKGNc8ImpskEciIaTeqe8761KEypRWRxjouWrrrKhT6ceu/iKbammXw7osVBMCZOy3t009YcNg/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756764790; c=relaxed/simple;
	bh=GgP4Peo/fE5SRVaKq9ijaoqIwz0hAcUEgWgqdFmTZk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KA6lj+lCTGUk8c5qigBZB3f6ZzP8kkF7xl46rQqISDp8MkW16nB9UCVcD4KJUQfe3Zg1yRoGawhqxZZGpmWw9TceERSSvAKZ5USm0mDJxw6gJmJb3hDBzWKUewTYb9LvsMohjieYCr6aaJBr78TjfNE7xoRXh9jPGDFBrOOfNx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=gZvO6XlZ; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UEmqyaXVMqU6OOVFG1Ed4ymyK46sxb2kNwvczgJVUHI=; t=1756764789; x=1757628789; 
	b=gZvO6XlZz9kx3ihrC4ZskHF637ws1n374UEe5L92GFJN8sKPdx0mif/hUPY8aM7dlqTlRDciQsK
	6W8opovxM7Fn6xyWG/Tu8DlCqYLhJSXds/Sb2DI+q/jzkF+afSzq3B0+j+MaQlreDo6T+0q1zoNRm
	hhAnbScT0kxgmXxIb/X6Vub8GrpOb+g1phsl7SE6VOj3vP+ziLEhXKCiACHRajsnZiiwCh30oW9zj
	+uUZvvSFLMBopHPncWL9cNhfD/GAlzWakrTVqa9cB7E1mTpyY4VWPbEnmyF7DW54f/yBtkUxh1r6r
	RbW15hN3SQYBMDyWvDHkI2REZoD7SH+zZVBQ==;
Received: from mail-oi1-f180.google.com ([209.85.167.180]:43360)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1utClv-00044F-Ao
	for netdev@vger.kernel.org; Mon, 01 Sep 2025 15:13:08 -0700
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-435d3a45a3fso2385914b6e.1
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 15:13:07 -0700 (PDT)
X-Gm-Message-State: AOJu0YyGPARAku8oGxsMOelPPqAo0uA8tuYGQBzOTk4GetSMl1H4k8UE
	0woINBR0LF7g6Hb4J4dT/68Z8B2FrKo+zOJMNryUrF9H/OfL23nfqbig8LBbgWnSGSfYvGcVgrX
	I1ejZOx6e2VBmTo8wLV4k4yZTw9TgWJI=
X-Google-Smtp-Source: AGHT+IHNC/BUrdC8LZ5sH3Xa97FIsW5j3w8+e4T3prU+gMsNedP5gg+TEGkqQj8pO5VNFpuPuok7jn/JVE+PqXLA6uI=
X-Received: by 2002:a05:6808:178e:b0:437:e490:6a17 with SMTP id
 5614622812f47-437f610b64dmr4317465b6e.16.1756764786723; Mon, 01 Sep 2025
 15:13:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818205551.2082-1-ouster@cs.stanford.edu> <20250818205551.2082-13-ouster@cs.stanford.edu>
 <e3d43c09-7df2-4447-bcaa-7cec550bdf62@redhat.com>
In-Reply-To: <e3d43c09-7df2-4447-bcaa-7cec550bdf62@redhat.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 1 Sep 2025 15:12:31 -0700
X-Gmail-Original-Message-ID: <CAGXJAmzngowSPJOx1Dg9=on++HX7E_bYVNv_Fy6GLQUSb-_BRw@mail.gmail.com>
X-Gm-Features: Ac12FXyZ66oRlzuo6ff0DZxPlOhClpAbS-ZBz6pc1oMkJW-n2JqFskMj9-jf_yE
Message-ID: <CAGXJAmzngowSPJOx1Dg9=on++HX7E_bYVNv_Fy6GLQUSb-_BRw@mail.gmail.com>
Subject: Re: [PATCH net-next v15 12/15] net: homa: create homa_incoming.c
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Scan-Signature: ee5a8a2ba51c5094c3d10c175eb088a4

On Tue, Aug 26, 2025 at 5:05=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 8/18/25 10:55 PM, John Ousterhout wrote:
> > +/**
> > + * homa_dispatch_pkts() - Top-level function that processes a batch of=
 packets,
> > + * all related to the same RPC.
> > + * @skb:       First packet in the batch, linked through skb->next.
> > + */
> > +void homa_dispatch_pkts(struct sk_buff *skb)
> > +{
> > +#define MAX_ACKS 10
> > +     const struct in6_addr saddr =3D skb_canonical_ipv6_saddr(skb);
> > +     struct homa_data_hdr *h =3D (struct homa_data_hdr *)skb->data;
> > +     u64 id =3D homa_local_id(h->common.sender_id);
> > +     int dport =3D ntohs(h->common.dport);
> > +
> > +     /* Used to collect acks from data packets so we can process them
> > +      * all at the end (can't process them inline because that may
> > +      * require locking conflicting RPCs). If we run out of space just
> > +      * ignore the extra acks; they'll be regenerated later through th=
e
> > +      * explicit mechanism.
> > +      */
> > +     struct homa_ack acks[MAX_ACKS];
> > +     struct homa_rpc *rpc =3D NULL;
> > +     struct homa_sock *hsk;
> > +     struct homa_net *hnet;
> > +     struct sk_buff *next;
> > +     int num_acks =3D 0;
>
> No black lines in the variable declaration section, and the stack usage
> feel a bit too high.

I have eliminated "acks" and "num_acks" (there's a cleaner way to
handle acks now that RPCs have real reference counts).

> > +     /* Each iteration through the following loop processes one packet=
. */
> > +     for (; skb; skb =3D next) {
> > +             h =3D (struct homa_data_hdr *)skb->data;
> > +             next =3D skb->next;
> > +
> > +             /* Relinquish the RPC lock temporarily if it's needed
> > +              * elsewhere.
> > +              */
> > +             if (rpc) {
> > +                     int flags =3D atomic_read(&rpc->flags);
> > +
> > +                     if (flags & APP_NEEDS_LOCK) {
> > +                             homa_rpc_unlock(rpc);
> > +
> > +                             /* This short spin is needed to ensure th=
at the
> > +                              * other thread gets the lock before this=
 thread
> > +                              * grabs it again below (the need for thi=
s
> > +                              * was confirmed experimentally in 2/2025=
;
> > +                              * without it, the handoff fails 20-25% o=
f the
> > +                              * time). Furthermore, the call to homa_s=
pin
> > +                              * seems to allow the other thread to acq=
uire
> > +                              * the lock more quickly.
> > +                              */
> > +                             homa_spin(100);
> > +                             homa_rpc_lock(rpc);
>
> This can still fail due to a number of reasons, e.g. if multiple threads
> are spinning on the rpc lock, or in fully preemptable kernels.

Yes, but that's not a problem; working most of the time gets most of
the benefit.

> You need to either ensure that:
> - the loop works just fine even if the handover fails with high

I've already done this: earlier versions of Homa had no handover at
all and the system worked fine except that tail latency was higher.

-John-

