Return-Path: <netdev+bounces-252623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGCoHYXlcmlzrAAAu9opvQ
	(envelope-from <netdev+bounces-252623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 04:05:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B7E6FE59
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 04:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 728683013B4C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 03:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E35D37C10B;
	Fri, 23 Jan 2026 03:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dg2YGc+O";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SESdrP1P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3493624C2
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 03:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769137535; cv=pass; b=LundATc5ri6e9q+t29c6SoKH7vaSFNMD437l5KosMHNblOA6Nj4wN1Q3Ib5m3x7qGjDai8loIlqx232kbo98YSPSLtVdQgjsQuf1aetZeXlVwe/nsxhXQY4VJVnzkWYISuZygpn7IVSrOo8YwAaOTXKS0erBCEwarAgdi2NTiuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769137535; c=relaxed/simple;
	bh=aHgjChBg5ZuuLmXn1MuuJOyiw447ndFIGhoil8tVmQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r32R4xsdOA/NzLS2oxwJrXIiSIKzwg+OsRERVtt39qZsOqEduWjm686iXWvM0MAEMecNzadpDjr3CurmX2GeyC+4nFPlVkyMQoufBK8+cLdUaHXcTqYlnlyZij6IfG/P0pnZQ2xn/FhkNRl9KA1PSZefsezOq1s0u9mANi4q+Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dg2YGc+O; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SESdrP1P; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769137517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jlpwSkdal7tGYPivZ2DxNYklI4++k5PPeAgE7brzBDw=;
	b=Dg2YGc+OfIpE+JM6rt1Is17wtZ9eA7dyldzNhdXqGYTe+qLQJ3B4GUByq8HvKlo3VWLPH2
	Mf6eL4oAsq0hTYXbS1+MGwGF6C/BPYzBhyKVrm8Xfnu5+SeyGsigfUIvUXLXdgvg27XnFw
	nX43h0GdCijim0VcctUAq/QUQTKmYZ8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-puqA_uFcO2aikQABROQv4w-1; Thu, 22 Jan 2026 22:05:15 -0500
X-MC-Unique: puqA_uFcO2aikQABROQv4w-1
X-Mimecast-MFC-AGG-ID: puqA_uFcO2aikQABROQv4w_1769137515
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a07fa318fdso14073375ad.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:05:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769137513; cv=none;
        d=google.com; s=arc-20240605;
        b=Ck6AwfoNDsUgkfGz4AsfhqDKKbO0ePOLy4NGc171zxMFQqIE5GuRL7x5Kwr2dk6MH9
         y2364QtP70mkHOF1RooMattchvKpQsc7Uk07fr6GtG6oc06GtBTMY/pHdVa3Uvq2/zat
         bdqCtXOOI1Wfs3UvIu80zvdf2OY1T2E5gH2YuORvrr02Ig5oOgGHtKi59Uwv0dyONgnA
         s28/ckxK1lCgGwWSs+GJF8qpBZVtykRkHy2WAxsQr0Wj4VHPwPnSZrtSdxrDuembIpoC
         NG/4qcs8qtNRmRIyIUzTdsA8y2z3zrNROPMZ0Q3L5aDiL+cpbr+82ZtzZrM1NvMxgyc5
         4ubw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jlpwSkdal7tGYPivZ2DxNYklI4++k5PPeAgE7brzBDw=;
        fh=EA24cDH3C24J2Sll3oSXGtVKXQ5ozz7yJQoOVkXGSns=;
        b=Q3krIYT8Oh1ZxXKQKH5ZsWZZzxFvXMPhN00u4I6WnIR2Mp3LeLwqXlAqgFkZv7cgF+
         L/+rf3UlzxsOZlmnAxjFDbBhov3Zl5ASVKn+Dvy34tBpgTa5SWmP+lxx2Z8HfgzsQnkc
         XIrW62D8AlbWHY781oTKXgqBRCBkrMOC80EK2/aXtXyTNr09W79GvQt5NGCbg5zkbqlr
         4kiDlcbnlY1+pMZOpwMI/ngfaGB19utOmJZ2h0FmAdVBz7EPTsxqMvtAfIpYEry6LosB
         Ao8GkW2ZrwNWM2UsGO9YnxUO7e6yA+LNRoQUGeNnRP+Hvrj6B7VCUSkuBR0jIFmgasp4
         UOUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769137513; x=1769742313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlpwSkdal7tGYPivZ2DxNYklI4++k5PPeAgE7brzBDw=;
        b=SESdrP1PrdU8OnLntpzShjknAxBmHMp+xk9wfTUVYpVr2L1sjazvwmXM3RdGvOeqV1
         UvgHpDMcrDnP/cqQry+G8Mdr50juggRsB4GC5jlpI355tSGhPNFLm/nPG2vsx8SyKJiK
         0guMyp/Flhdn6EB7QKNOJiU+WRGFjZ1LwZgYPgQDKB5oVGYfc+BiqN89VboS6j3w2BYs
         B1PhlwELxVRbh+QIqtJ9GkkY62MeVNbttLYOEU9jTdX+kwApIvzCGm5f9OBPO1noCWBX
         O4ZukmHDParuIa6nh21u3JN5+ipwnhJE9CQwWVMYN3iNfsKca0eJsXa8NHRrXmHpWHDc
         EV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769137513; x=1769742313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jlpwSkdal7tGYPivZ2DxNYklI4++k5PPeAgE7brzBDw=;
        b=EyySmM8oiP6QzIZs3ju5ZdkFYQ6bsZNM+Pv1ufNsr7VhjMKnmttmy5rFPA6KyhDrKf
         bYYmuLFKagqzH7BGYAWnjekFg0SbcLrPV1webjEp4vzfLtjSaVHfyZRzvV4Jj4JmQ58s
         Q+SD1YCDRuUf+1AimyHq5qen5jwinqHbw8JHZIUeZAWBe3g/ymZbVHQbTCYX89F3mKc3
         lc6yo9Q8s0pKO2I4HvYZviRUDerHSpCKE6DywtOcBnG08+sxOUANOGS8ut0uA8FlUQ0c
         yRqM7l19ivPtsQAxR3jO//2anqN7VBWH8uTUh7K791kowX0Q74IhIQJ07fq8p3YDR1s9
         BFvg==
X-Forwarded-Encrypted: i=1; AJvYcCWfMtqdq8wkdUkhab/4MgbvACkgyXxTtU399p+rIkBto5kbMFEQGC2uId04afOIoWKKxP5sQXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDwXVKlw+v7P2VqIYSnrRtre2qgYxNddpTN/1jgTmoyWqEZybk
	OrVjPMGtpi1J9uooygUwJgSDVBye/qKykOM3QMms6e1QFsSwtBouSuFpeBG9ERBKtEQ2S8cv2OJ
	WxOvs179v4nOanuSyI//MaRopMe1afJaVH3iEMZFX//Zo109O3KdIq1uBkso0P44MwS8OpmYGWZ
	GPLZS8dffRs3c1jK4VdYzce8HPVYc4bqar
X-Gm-Gg: AZuq6aJblenBFsjUYM48NzBidB9Gevj2mZqssQr8C4nXGF24C7r2goAgixiJ0EaoPBq
	Iy9rqy8FuXMbtkbkbrRelQ/PVlL4wMEKmp122FZhFGkjqsOsfa9dRIP46hCfkrkASSrkctMYwuD
	4xmL9R7x7ktBcPbecLSRm6sOmjOOhpuSCB2KSLKVNQFk5f5qqVwcmu3zbHDOynTpvOMNk=
X-Received: by 2002:a17:902:f745:b0:2a7:afca:fd1d with SMTP id d9443c01a7336-2a7fe57ddc8mr14979995ad.14.1769137512993;
        Thu, 22 Jan 2026 19:05:12 -0800 (PST)
X-Received: by 2002:a17:902:f745:b0:2a7:afca:fd1d with SMTP id
 d9443c01a7336-2a7fe57ddc8mr14979705ad.14.1769137512538; Thu, 22 Jan 2026
 19:05:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-4-simon.schippers@tu-dortmund.de> <CACGkMEuSiEcyaeFeZd0=RgNpviJgNvUDq_ctjeMLT5jZTgRkwQ@mail.gmail.com>
 <1e30464c-99ae-441e-bb46-6d0485d494dc@tu-dortmund.de> <CACGkMEtzD3ORJuJcc8VeqwASiGeVFdQmJowsK6PYVEF_Zkcn8Q@mail.gmail.com>
 <afa40345-acbe-42b0-81d1-0a838343792d@tu-dortmund.de> <CACGkMEtxRoavBMTXom8Z=FM-pvu3pHbsuwCs+e450b1B=V7iWA@mail.gmail.com>
In-Reply-To: <CACGkMEtxRoavBMTXom8Z=FM-pvu3pHbsuwCs+e450b1B=V7iWA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 23 Jan 2026 11:05:01 +0800
X-Gm-Features: AZwV_QhfJpNa-qyRW4HkPU0pltcsmh5NSX3tjMBQH3mbBHwnwdX2N3ZeHrsOtZM
Message-ID: <CACGkMEsJKeEsH=G8H5RzMNHY4g3HNdciMDMhciShawh-9Xb9hg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 3/9] tun/tap: add ptr_ring consume helper with
 netdev queue wakeup
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252623-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.987];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,tu-dortmund.de:email]
X-Rspamd-Queue-Id: 35B7E6FE59
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 1:35=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Jan 21, 2026 at 5:33=E2=80=AFPM Simon Schippers
> <simon.schippers@tu-dortmund.de> wrote:
> >
> > On 1/9/26 07:02, Jason Wang wrote:
> > > On Thu, Jan 8, 2026 at 3:41=E2=80=AFPM Simon Schippers
> > > <simon.schippers@tu-dortmund.de> wrote:
> > >>
> > >> On 1/8/26 04:38, Jason Wang wrote:
> > >>> On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
> > >>> <simon.schippers@tu-dortmund.de> wrote:
> > >>>>
> > >>>> Introduce {tun,tap}_ring_consume() helpers that wrap __ptr_ring_co=
nsume()
> > >>>> and wake the corresponding netdev subqueue when consuming an entry=
 frees
> > >>>> space in the underlying ptr_ring.
> > >>>>
> > >>>> Stopping of the netdev queue when the ptr_ring is full will be int=
roduced
> > >>>> in an upcoming commit.
> > >>>>
> > >>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > >>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> > >>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> > >>>> ---
> > >>>>  drivers/net/tap.c | 23 ++++++++++++++++++++++-
> > >>>>  drivers/net/tun.c | 25 +++++++++++++++++++++++--
> > >>>>  2 files changed, 45 insertions(+), 3 deletions(-)
> > >>>>
> > >>>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> > >>>> index 1197f245e873..2442cf7ac385 100644
> > >>>> --- a/drivers/net/tap.c
> > >>>> +++ b/drivers/net/tap.c
> > >>>> @@ -753,6 +753,27 @@ static ssize_t tap_put_user(struct tap_queue =
*q,
> > >>>>         return ret ? ret : total;
> > >>>>  }
> > >>>>
> > >>>> +static void *tap_ring_consume(struct tap_queue *q)
> > >>>> +{
> > >>>> +       struct ptr_ring *ring =3D &q->ring;
> > >>>> +       struct net_device *dev;
> > >>>> +       void *ptr;
> > >>>> +
> > >>>> +       spin_lock(&ring->consumer_lock);
> > >>>> +
> > >>>> +       ptr =3D __ptr_ring_consume(ring);
> > >>>> +       if (unlikely(ptr && __ptr_ring_consume_created_space(ring,=
 1))) {
> > >>>> +               rcu_read_lock();
> > >>>> +               dev =3D rcu_dereference(q->tap)->dev;
> > >>>> +               netif_wake_subqueue(dev, q->queue_index);
> > >>>> +               rcu_read_unlock();
> > >>>> +       }
> > >>>> +
> > >>>> +       spin_unlock(&ring->consumer_lock);
> > >>>> +
> > >>>> +       return ptr;
> > >>>> +}
> > >>>> +
> > >>>>  static ssize_t tap_do_read(struct tap_queue *q,
> > >>>>                            struct iov_iter *to,
> > >>>>                            int noblock, struct sk_buff *skb)
> > >>>> @@ -774,7 +795,7 @@ static ssize_t tap_do_read(struct tap_queue *q=
,
> > >>>>                                         TASK_INTERRUPTIBLE);
> > >>>>
> > >>>>                 /* Read frames from the queue */
> > >>>> -               skb =3D ptr_ring_consume(&q->ring);
> > >>>> +               skb =3D tap_ring_consume(q);
> > >>>>                 if (skb)
> > >>>>                         break;
> > >>>>                 if (noblock) {
> > >>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > >>>> index 8192740357a0..7148f9a844a4 100644
> > >>>> --- a/drivers/net/tun.c
> > >>>> +++ b/drivers/net/tun.c
> > >>>> @@ -2113,13 +2113,34 @@ static ssize_t tun_put_user(struct tun_str=
uct *tun,
> > >>>>         return total;
> > >>>>  }
> > >>>>
> > >>>> +static void *tun_ring_consume(struct tun_file *tfile)
> > >>>> +{
> > >>>> +       struct ptr_ring *ring =3D &tfile->tx_ring;
> > >>>> +       struct net_device *dev;
> > >>>> +       void *ptr;
> > >>>> +
> > >>>> +       spin_lock(&ring->consumer_lock);
> > >>>> +
> > >>>> +       ptr =3D __ptr_ring_consume(ring);
> > >>>> +       if (unlikely(ptr && __ptr_ring_consume_created_space(ring,=
 1))) {
> > >>>
> > >>> I guess it's the "bug" I mentioned in the previous patch that leads=
 to
> > >>> the check of __ptr_ring_consume_created_space() here. If it's true,
> > >>> another call to tweak the current API.
> > >>>
> > >>>> +               rcu_read_lock();
> > >>>> +               dev =3D rcu_dereference(tfile->tun)->dev;
> > >>>> +               netif_wake_subqueue(dev, tfile->queue_index);
> > >>>
> > >>> This would cause the producer TX_SOFTIRQ to run on the same cpu whi=
ch
> > >>> I'm not sure is what we want.
> > >>
> > >> What else would you suggest calling to wake the queue?
> > >
> > > I don't have a good method in my mind, just want to point out its imp=
lications.
> >
> > I have to admit I'm a bit stuck at this point, particularly with this
> > aspect.
> >
> > What is the correct way to pass the producer CPU ID to the consumer?
> > Would it make sense to store smp_processor_id() in the tfile inside
> > tun_net_xmit(), or should it instead be stored in the skb (similar to t=
he
> > XDP bit)? In the latter case, my concern is that this information may
> > already be significantly outdated by the time it is used.
> >
> > Based on that, my idea would be for the consumer to wake the producer b=
y
> > invoking a new function (e.g., tun_wake_queue()) on the producer CPU vi=
a
> > smp_call_function_single().
> > Is this a reasonable approach?
>
> I'm not sure but it would introduce costs like IPI.
>
> >
> > More generally, would triggering TX_SOFTIRQ on the consumer CPU be
> > considered a deal-breaker for the patch set?
>
> It depends on whether or not it has effects on the performance.
> Especially when vhost is pinned.

I meant we can benchmark to see the impact. For example, pin vhost to
a specific CPU and the try to see the impact of the TX_SOFTIRQ.

Thanks


