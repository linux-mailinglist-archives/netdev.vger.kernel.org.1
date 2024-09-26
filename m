Return-Path: <netdev+bounces-129916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96085986FE0
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 11:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70FB1C20380
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 09:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB8E1A4F18;
	Thu, 26 Sep 2024 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y97r/nIz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C621A4E9A
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342399; cv=none; b=T/AwHXWQsNhHpFW1Y24aHiaXxICQOc1xEd/r4hrWb9L+3E4EUy+ugPIBIEE7KinTTNLfAcIKWbGivC0IyWLdk8Q8MkaGd9geVocpGpYmzRccJwTDTMZs9HCAk0wWxA3UYvwZs/Bm3jV2a+p+q4hJs9eOwxYpaoDQYArgd9VKQCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342399; c=relaxed/simple;
	bh=DvDFTPz/i5rugDCoQq2HmgdqlkGLW0BZ7eDwMdp7K9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBIN3QAceiaPKgoP8jeCQbMp5u5RC5WTdkM61wLZaK/NayJ7npW9sJ36fy79HuxGNiP/JXf8amdUXDyllZCoP/09FXnHMxdEnfWUsca5d4HbJWLRSGRtIyw+dxRtWM9NXDKHweJpLbrzvvhn5DV/Do/JMronHdBIeOJ/LgdPgfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y97r/nIz; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c8784e3bc8so719201a12.1
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 02:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727342396; x=1727947196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6o0ZPPqNs5OKEvE6LJy16ez0xt1FXRTxMU/UK1sI/E=;
        b=Y97r/nIz2f5APCkFQ6NJgdIu/E4k2FMY9ZsIawRee/qiq9kWF2D6MV1ob4PnrOg6vR
         cwsVh8pmoi5ohsyIvp46Tu6q1IhZa74OA0knryP+Vwbi9AAvgphZeXJsYZmsR0pa6BD1
         H3KJzsmsWHgjhB5eKZRUsQaOzZcGwIxRR+M0o47efw5GdBc0wYdUNY7rFzgvXaMDxqfA
         xyJWbIDXn6ShZdd9iJg9QZfgjfi1Qz3jr6xrubTS+bF86Khfj+sLRKdnc0YVlN033xZd
         p+1xnbjmQ8W7WlRGPFJ0qu1K4ySwTCVXoQyEzBt3kc9LcAFPKM8N3Y60N55s22+jEE3w
         HA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727342396; x=1727947196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6o0ZPPqNs5OKEvE6LJy16ez0xt1FXRTxMU/UK1sI/E=;
        b=RzmSjk9PMjPrsLj3a75tUjf1W0a+5K3Y/pKgZ6/cWg+PyfZx/l2Ie2TaS1wFMUksQs
         VJPfjYCZ6DCzGi237z4OfnO9aLmnvn1oOwsqMqCTJNur4Py1DJ1+T/DzbGNBOhOyXeNS
         n89rU0Hs1FCECp3bwOuvXSzrl94K8dxTyxf56Wny87c9kD9+txDD8/towvECeq5xNFUw
         g4HAzEwQLF+WNUZ0FQDEXrSD05IIVNsBUq8D0xFNIyR9rV7iI658G/qnK0vwXD0Ydf/d
         BHzgQYgeTF4eoisk32HIsgjGjP5bh2GS5uuweSuc91WBIVqHxv/6esmEKV/4sL9qRIYm
         UtSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBK7EFQRawRtNaL9U1QZz9SJTz0rVFfU6mZ3FyhTdd1Uols9K651OMooxTg7MAZAPDP6J4Ld8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq6u2/wW0eHKX5a2LKG9N+0kyrzrZZTbuKCMVX8dnyQl8oe6w+
	WM9r9IV/c6P0Cfr+7GQxRGT7F8BTSQ0cE+nX935+nBzwYov6IhNiiqVUv2fBuYg3OVG50gH3VwW
	B4Ly+t6fGtfzSOmshJ4IriRZ3CwyH1DGG9e9/
X-Google-Smtp-Source: AGHT+IG6ogNq8IXQ6XBSyy7WlpEV0RW/9q/ds6DRJeV3YZsjG8wLdD7czlVCG8Kb/uXbpjHgzIXEe36sqcVcND8PpBM=
X-Received: by 2002:a05:6402:518b:b0:5c5:b84a:8156 with SMTP id
 4fb4d7f45d1cf-5c72062506bmr4200236a12.17.1727342395446; Thu, 26 Sep 2024
 02:19:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924150257.1059524-1-edumazet@google.com> <20240924150257.1059524-3-edumazet@google.com>
 <66f525aab17bb_8456129490@willemb.c.googlers.com.notmuch> <66f526c06b0fa_851bd294af@willemb.c.googlers.com.notmuch>
In-Reply-To: <66f526c06b0fa_851bd294af@willemb.c.googlers.com.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Sep 2024 11:19:44 +0200
Message-ID: <CANn89iKTN0NgEcUAhBf19siC2FJ9hGpQppHf4wKmH7HgAtkn9g@mail.gmail.com>
Subject: Re: [PATCH net 2/2] net: add more sanity checks to qdisc_pkt_len_init()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Jonathan Davies <jonathan.davies@nutanix.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 11:17=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Willem de Bruijn wrote:
> > Eric Dumazet wrote:
> > > One path takes care of SKB_GSO_DODGY, assuming
> > > skb->len is bigger than hdr_len.
> > >
> > > virtio_net_hdr_to_skb() does not fully dissect TCP headers,
> > > it only make sure it is at least 20 bytes.
> > >
> > > It is possible for an user to provide a malicious 'GSO' packet,
> > > total length of 80 bytes.
> > >
> > > - 20 bytes of IPv4 header
> > > - 60 bytes TCP header
> > > - a small gso_size like 8
> > >
> > > virtio_net_hdr_to_skb() would declare this packet as a normal
> > > GSO packet, because it would see 40 bytes of payload,
> > > bigger than gso_size.
> > >
> > > We need to make detect this case to not underflow
> > > qdisc_skb_cb(skb)->pkt_len.
> > >
> > > Fixes: 1def9238d4aa ("net_sched: more precise pkt_len computation")
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > ---
> > >  net/core/dev.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index f2c47da79f17d5ebe6b334b63d66c84c84c519fc..35b8bcfb209bd274c8138=
0eaf6e445641306b018 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -3766,10 +3766,14 @@ static void qdisc_pkt_len_init(struct sk_buff=
 *skb)
> > >                             hdr_len +=3D sizeof(struct udphdr);
> > >             }
> > >
> > > -           if (shinfo->gso_type & SKB_GSO_DODGY)
> > > -                   gso_segs =3D DIV_ROUND_UP(skb->len - hdr_len,
> > > -                                           shinfo->gso_size);
> > > +           if (unlikely(shinfo->gso_type & SKB_GSO_DODGY)) {
> > > +                   int payload =3D skb->len - hdr_len;
> > >
> > > +                   /* Malicious packet. */
> > > +                   if (payload <=3D 0)
> > > +                           return;
> > > +                   gso_segs =3D DIV_ROUND_UP(payload, shinfo->gso_si=
ze);
> > > +           }
> >
> > Especially for a malicious packet, should gso_segs be reinitialized to
> > a sane value? As sane as feasible when other fields cannot be fully
> > trusted..
>
> Never mind. I guess the best thing we can do is to leave pkt_len as
> skb->len, indeed.
>

It is unclear if we can change a field in skb here, I hope that in the
future we can make virtio_net_hdr_to_skb() safer.

Role of qdisc_pkt_len_init() is to set a private skb->cb[] field for
qdisc layer.

Thanks !

