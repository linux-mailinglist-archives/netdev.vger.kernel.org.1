Return-Path: <netdev+bounces-252216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMz5Cna3cWmcLgAAu9opvQ
	(envelope-from <netdev+bounces-252216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 06:36:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8186203A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 06:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67011445B25
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0353D648C;
	Thu, 22 Jan 2026 05:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9wo+tJw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MI5R5ep+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889E6478845
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 05:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769060181; cv=pass; b=A7YQkEB8ic6YKzL9ANgYRqfMw9RPaONd0rZFZVIr6cDgpnX3aLWtubNhkP9LTfh1LWQciMIhyAkTC/1xJVNm2w50p/3BJY9q13TYiHoJoPoMNgmLwFu8zGpkhOOBoN6ZRZzfDzOhSVycA6Yo7T3DcD7o2gV+3YZ8wAxG8hix1Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769060181; c=relaxed/simple;
	bh=4u7RqhYyUxDdVXDwJ31YEx+CsrnO+8ttQ47Alq+R+iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pM0Nz2ZwHKZQYakDaKjKKdyDIZ8G6nYcezDOwFpRFI6qh01deseq8TECMZMvhLi29DgeYYxnGWwVda9dEN0+Mx2Yoi0njGjkygw0m6b7YWy+a3XFtcNd1ob7Fru0/F7hkdaF6mMiUXylI9CQTIIvuc2X/F14N+RGkSzQlnmm0NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9wo+tJw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MI5R5ep+; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769060178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ED7l/hs/bCd8Y3NS4tIwlZAqaShpZQlaHK2896w0TZ8=;
	b=I9wo+tJwcXkBUCFa3YS/b485VO6xT4ggH4Wlko8SMshMZ5LASTIJmrdLCKqAe9v0/bKYPA
	DoyF0oo/lP/L8Bg2wIJ6j++xcIN8PHshxohJIqHkx5hhwydUS5LlUqBN2qN6XONKfzcLuY
	KseAGL+ZilZhYU4PpgxyDsJX2MtryS8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-duSF6p9RNbSRv5AqenR22g-1; Thu, 22 Jan 2026 00:36:15 -0500
X-MC-Unique: duSF6p9RNbSRv5AqenR22g-1
X-Mimecast-MFC-AGG-ID: duSF6p9RNbSRv5AqenR22g_1769060175
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34ab459c051so1372392a91.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 21:36:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769060170; cv=none;
        d=google.com; s=arc-20240605;
        b=KP7tzg5HUL8wjXricCjI9wVo0SJnACUR58fW/iOv7Ita6p9Fkb1tR7+oSVJ6rSf/dJ
         RuD0kCjABBbH5zC65wzE3M9/EHYkx98Vm48zQNvn5LXKniWBdEPJb7wdvrCuVAzI1RlA
         yeSRhcQSdyG3npmywOg35k01bb2WqTEeU6RVNLs5CQg3b5Txo4ixnZGVANfpCmxO9J+V
         evT0Xha4vITN+0LPXUHi3zILCim0gieZPP5knAcIA1r+rrdi5vgF6ET/5sIBhcNcw5d5
         SrIREyHwK9rmyN+VCvjO3ZOIvevbdZpVx3Yy5a88Y5MexSSgFMEbueOdlvPDA2eflW4v
         kYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ED7l/hs/bCd8Y3NS4tIwlZAqaShpZQlaHK2896w0TZ8=;
        fh=tM/VJgTt9UWLRvVElL9kAGJxluKpkp0pLvL1FxN4MFs=;
        b=hkf8pO4ae478xz/e9WxA+7IWSle/1NkHEIiFJXzHKk0zGLUkEwoBRciDy8VUA1JqiE
         xnOQScu+iOZs2FuX3B7lNDpweGmykXadvhraaew2awieNoOv6iR9Id2DeAsULm4JAmuz
         JAVNkxtGScH0CFfSPn/u5AltL/KRm/UfdOjDbL6WGxJg+PXjop+HiuhtGJfhrDwziFJa
         4nNLAm3Khd/UEWJkahFBsU+UEatG2F7Y1HlexHUZQ/ztl5CQ9loPPzmDyOdc5n3C06pi
         Sm88WLm3VHNCNgxpUhq9YWlnal68HYAkZO6TVk06/INc1pn+k8pIxkb+/A0kxRnk8tZH
         KvLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769060170; x=1769664970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ED7l/hs/bCd8Y3NS4tIwlZAqaShpZQlaHK2896w0TZ8=;
        b=MI5R5ep+9Ete/kj9kq7iHgcTfeX2mpFQZkZrQj0HQ/JtYPBfUMPv52YXtjP6UkToio
         WUzAC+SGrHSZJ8ygRFcutPIweTTPmyWVOn5aIWkahiWQGrY8ujgukDNBuyqkQFtaERpV
         gk5uMIWVKQ9fmcDvlk8Rqilmr70f0lKBA6XvaXCcya/UMGe7Adc0fMRwJLe3eTaPDOFR
         VrHcl0eB8TLYL2zUnrgs7+Q3+jj1lzHh0plL8HqnvpUMH3+OACnm2R5UMLVJMdbg24rw
         asPSVQPl6hRUuPuR/i6fOgggyHbLAIWGyPRVAnuc/T/b8/UvuYj+UJkP8lfJjoIDEBFL
         uBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769060170; x=1769664970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ED7l/hs/bCd8Y3NS4tIwlZAqaShpZQlaHK2896w0TZ8=;
        b=AJoThKRDTtJaGWYLQwGAQtrkgalsWLSYzThb83ThcW1fQTNK11gwwCIwGZs7oxyPkw
         mQct1mGfIw7eQnmDLRS/gjgjVuMSzal1KkcM2KjRPaXe9vaVHcTYD/OhXEPm0lWya0lr
         jl7JLJ0FsT47H1MenGHGmoU1Y4isOoQfF2fY+iTK/xf9C87E9eXcuy4Ill4kJcjOnxSV
         wqGuuT0jWvqUj4f9vlvxwxNiKB64a2/p7t9g9FR6KFLFpw3wne0DCsXAldUaovgfY3Ta
         7RL4bbiWf6mDf0xtS5Fro1durcdZCEG/e9whpwL0QPhwxy2JuftcKL0GxO7EMa74cyEn
         E4Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVJgKGnCY44c6OATg62JsXStkX0DA9U4euyRlUupaq+XxTJ9G+cdUxhTynVG2uSJhYZme4h/4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ISSElSvgg7+wefv0yvAVqyfNOiYMMN6pBSbbNHKA5v9JdvO6
	M7t8clpxAHHSlFVaJWqlMt0SILS27W3rv72UqUrZFk7xOLDOhdth/bXp5SsTgs52w/PEKcHQLnP
	emyYMKYrs4u9k+6kj1IhY2YdpcQTCTC6hy66XGO7RmAMHTvp2d8dQj5JamJi1/Tj2pZ83iWNGOa
	qvXmXmEPElDAGasf9EEKARzc5hChXsvbRz
X-Gm-Gg: AZuq6aIKJHKBqL0PgUw2dbh9Da0aJjSG/8sANcKJOgIQb0lHLHLUjH/EZX86T1WDtL3
	RHCTEoVlEq1h/PKnbuorA4XTbxTcR/X7o4XdwD6ixRX4bbZ2feFpPTpmz9MlnNk7itt62T/KTta
	gMBAlowfR5Q0wt+WHq4ZzYUX+/kfmQ9MAyEZquDZv+dHd3Dma/OKQYMqLnxXWebzAvIsQ=
X-Received: by 2002:a17:90b:51:b0:353:41e:1f51 with SMTP id 98e67ed59e1d1-353041e787cmr3670061a91.32.1769060170505;
        Wed, 21 Jan 2026 21:36:10 -0800 (PST)
X-Received: by 2002:a17:90b:51:b0:353:41e:1f51 with SMTP id
 98e67ed59e1d1-353041e787cmr3670034a91.32.1769060170061; Wed, 21 Jan 2026
 21:36:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de>
 <20260107210448.37851-4-simon.schippers@tu-dortmund.de> <CACGkMEuSiEcyaeFeZd0=RgNpviJgNvUDq_ctjeMLT5jZTgRkwQ@mail.gmail.com>
 <1e30464c-99ae-441e-bb46-6d0485d494dc@tu-dortmund.de> <CACGkMEtzD3ORJuJcc8VeqwASiGeVFdQmJowsK6PYVEF_Zkcn8Q@mail.gmail.com>
 <afa40345-acbe-42b0-81d1-0a838343792d@tu-dortmund.de>
In-Reply-To: <afa40345-acbe-42b0-81d1-0a838343792d@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 22 Jan 2026 13:35:57 +0800
X-Gm-Features: AZwV_Qj0WIKFoTOn0eU2tLMfUdJil-HIikNxIFlK3wwyEXYRVe6obOMN0rB6aW0
Message-ID: <CACGkMEtxRoavBMTXom8Z=FM-pvu3pHbsuwCs+e450b1B=V7iWA@mail.gmail.com>
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
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-252216-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-dortmund.de:email,mail.gmail.com:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: BD8186203A
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 5:33=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 1/9/26 07:02, Jason Wang wrote:
> > On Thu, Jan 8, 2026 at 3:41=E2=80=AFPM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> On 1/8/26 04:38, Jason Wang wrote:
> >>> On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
> >>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>
> >>>> Introduce {tun,tap}_ring_consume() helpers that wrap __ptr_ring_cons=
ume()
> >>>> and wake the corresponding netdev subqueue when consuming an entry f=
rees
> >>>> space in the underlying ptr_ring.
> >>>>
> >>>> Stopping of the netdev queue when the ptr_ring is full will be intro=
duced
> >>>> in an upcoming commit.
> >>>>
> >>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> >>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> >>>> ---
> >>>>  drivers/net/tap.c | 23 ++++++++++++++++++++++-
> >>>>  drivers/net/tun.c | 25 +++++++++++++++++++++++--
> >>>>  2 files changed, 45 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> >>>> index 1197f245e873..2442cf7ac385 100644
> >>>> --- a/drivers/net/tap.c
> >>>> +++ b/drivers/net/tap.c
> >>>> @@ -753,6 +753,27 @@ static ssize_t tap_put_user(struct tap_queue *q=
,
> >>>>         return ret ? ret : total;
> >>>>  }
> >>>>
> >>>> +static void *tap_ring_consume(struct tap_queue *q)
> >>>> +{
> >>>> +       struct ptr_ring *ring =3D &q->ring;
> >>>> +       struct net_device *dev;
> >>>> +       void *ptr;
> >>>> +
> >>>> +       spin_lock(&ring->consumer_lock);
> >>>> +
> >>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>> +       if (unlikely(ptr && __ptr_ring_consume_created_space(ring, 1=
))) {
> >>>> +               rcu_read_lock();
> >>>> +               dev =3D rcu_dereference(q->tap)->dev;
> >>>> +               netif_wake_subqueue(dev, q->queue_index);
> >>>> +               rcu_read_unlock();
> >>>> +       }
> >>>> +
> >>>> +       spin_unlock(&ring->consumer_lock);
> >>>> +
> >>>> +       return ptr;
> >>>> +}
> >>>> +
> >>>>  static ssize_t tap_do_read(struct tap_queue *q,
> >>>>                            struct iov_iter *to,
> >>>>                            int noblock, struct sk_buff *skb)
> >>>> @@ -774,7 +795,7 @@ static ssize_t tap_do_read(struct tap_queue *q,
> >>>>                                         TASK_INTERRUPTIBLE);
> >>>>
> >>>>                 /* Read frames from the queue */
> >>>> -               skb =3D ptr_ring_consume(&q->ring);
> >>>> +               skb =3D tap_ring_consume(q);
> >>>>                 if (skb)
> >>>>                         break;
> >>>>                 if (noblock) {
> >>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> >>>> index 8192740357a0..7148f9a844a4 100644
> >>>> --- a/drivers/net/tun.c
> >>>> +++ b/drivers/net/tun.c
> >>>> @@ -2113,13 +2113,34 @@ static ssize_t tun_put_user(struct tun_struc=
t *tun,
> >>>>         return total;
> >>>>  }
> >>>>
> >>>> +static void *tun_ring_consume(struct tun_file *tfile)
> >>>> +{
> >>>> +       struct ptr_ring *ring =3D &tfile->tx_ring;
> >>>> +       struct net_device *dev;
> >>>> +       void *ptr;
> >>>> +
> >>>> +       spin_lock(&ring->consumer_lock);
> >>>> +
> >>>> +       ptr =3D __ptr_ring_consume(ring);
> >>>> +       if (unlikely(ptr && __ptr_ring_consume_created_space(ring, 1=
))) {
> >>>
> >>> I guess it's the "bug" I mentioned in the previous patch that leads t=
o
> >>> the check of __ptr_ring_consume_created_space() here. If it's true,
> >>> another call to tweak the current API.
> >>>
> >>>> +               rcu_read_lock();
> >>>> +               dev =3D rcu_dereference(tfile->tun)->dev;
> >>>> +               netif_wake_subqueue(dev, tfile->queue_index);
> >>>
> >>> This would cause the producer TX_SOFTIRQ to run on the same cpu which
> >>> I'm not sure is what we want.
> >>
> >> What else would you suggest calling to wake the queue?
> >
> > I don't have a good method in my mind, just want to point out its impli=
cations.
>
> I have to admit I'm a bit stuck at this point, particularly with this
> aspect.
>
> What is the correct way to pass the producer CPU ID to the consumer?
> Would it make sense to store smp_processor_id() in the tfile inside
> tun_net_xmit(), or should it instead be stored in the skb (similar to the
> XDP bit)? In the latter case, my concern is that this information may
> already be significantly outdated by the time it is used.
>
> Based on that, my idea would be for the consumer to wake the producer by
> invoking a new function (e.g., tun_wake_queue()) on the producer CPU via
> smp_call_function_single().
> Is this a reasonable approach?

I'm not sure but it would introduce costs like IPI.

>
> More generally, would triggering TX_SOFTIRQ on the consumer CPU be
> considered a deal-breaker for the patch set?

It depends on whether or not it has effects on the performance.
Especially when vhost is pinned.

Thanks

>
> Thanks!
>
> >
> >>
> >>>
> >>>> +               rcu_read_unlock();
> >>>> +       }
> >>>
> >>> Btw, this function duplicates a lot of logic of tap_ring_consume() we
> >>> should consider to merge the logic.
> >>
> >> Yes, it is largely the same approach, but it would require accessing t=
he
> >> net_device each time.
> >
> > The problem is that, at least for TUN, the socket is loosely coupled
> > with the netdev. It means the netdev can go away while the socket
> > might still exist. That's why vhost only talks to the socket, not the
> > netdev. If we really want to go this way, here, we should at least
> > check the existence of tun->dev first.
> >
> >>
> >>>
> >>>> +
> >>>> +       spin_unlock(&ring->consumer_lock);
> >>>> +
> >>>> +       return ptr;
> >>>> +}
> >>>> +
> >>>>  static void *tun_ring_recv(struct tun_file *tfile, int noblock, int=
 *err)
> >>>>  {
> >>>>         DECLARE_WAITQUEUE(wait, current);
> >>>>         void *ptr =3D NULL;
> >>>>         int error =3D 0;
> >>>>
> >>>> -       ptr =3D ptr_ring_consume(&tfile->tx_ring);
> >>>> +       ptr =3D tun_ring_consume(tfile);
> >>>
> >>> I'm not sure having a separate patch like this may help. For example,
> >>> it will introduce performance regression.
> >>
> >> I ran benchmarks for the whole patch set with noqueue (where the queue=
 is
> >> not stopped to preserve the old behavior), as described in the cover
> >> letter, and observed no performance regression. This leads me to concl=
ude
> >> that there is no performance impact because of this patch when the que=
ue
> >> is not stopped.
> >
> > Have you run a benchmark per patch? Or it might just be because the
> > regression is not obvious. But at least this patch would introduce
> > more atomic operations or it might just because the TUN doesn't
> > support burst so pktgen can't have the best PPS.
> >
> > Thanks
> >
> >
> >>
> >>>
> >>>>         if (ptr)
> >>>>                 goto out;
> >>>>         if (noblock) {
> >>>> @@ -2131,7 +2152,7 @@ static void *tun_ring_recv(struct tun_file *tf=
ile, int noblock, int *err)
> >>>>
> >>>>         while (1) {
> >>>>                 set_current_state(TASK_INTERRUPTIBLE);
> >>>> -               ptr =3D ptr_ring_consume(&tfile->tx_ring);
> >>>> +               ptr =3D tun_ring_consume(tfile);
> >>>>                 if (ptr)
> >>>>                         break;
> >>>>                 if (signal_pending(current)) {
> >>>> --
> >>>> 2.43.0
> >>>>
> >>>
> >>> Thanks
> >>>
> >>
> >
>


