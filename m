Return-Path: <netdev+bounces-249713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 650D9D1C4B1
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 04:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CAD9302570C
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CA061FCE;
	Wed, 14 Jan 2026 03:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2FPd9Zw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qB5jq3mX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B0214A8E
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 03:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768362481; cv=none; b=MjmAU3di7VNiCMMRhKnYfbw73qp4BVILYH7WVNiUogNkAO/3SnrBgA7H6nHWgRL/t2oDTx0gp9ooqkONbxMENHwVHPSzlJ6R6myP2agnt9SpQ98kFHNVGmKVsW1ZnfnQ73t4M3Z5KC1+Qw5+PdxBDpmdHA45Tu9gO0iYtn9O3dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768362481; c=relaxed/simple;
	bh=f1XtAQhu69jWBhv9fknFzEfPNLJbkWU7GjkDx8JZZmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdLvgbwARatcoRXFBw8UKdWfd9GFUa+JHb1cw9UBS0XhdH5USDDuNolfJXjmfj4iKDJ8f18yL3mBGxMpclJZq7cgGfoydorXf69flw0HrGrgBHFYdQ2QtV0UrNgeZ6VBR9GW/MfeMUS3I2neSWJtuNLOrASAQEsMHdirElTKOw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2FPd9Zw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qB5jq3mX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768362479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2simHl/yq/0aAfe32CsDuUSVTOgAQmNmUouFvIcZBI=;
	b=a2FPd9ZwCkInRCWBy4O/9p23SM00x2t0STeBmSRilK4NnUXi+8tAPAy36OTKGOh7sZocvp
	bJBO+/6OtxmoKKxHop4b8mVeZoBZ0EwiVoFP6tsHyy2gF/0d7C4/ev5NSFSKs8tD//8F+s
	IoN7eRBH/QbbUkwCVMKTpYMya+J9p1I=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-yXMhtAhKOdiTIj7hsCeuzQ-1; Tue, 13 Jan 2026 22:47:57 -0500
X-MC-Unique: yXMhtAhKOdiTIj7hsCeuzQ-1
X-Mimecast-MFC-AGG-ID: yXMhtAhKOdiTIj7hsCeuzQ_1768362477
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0c495fc7aso87296935ad.3
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 19:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768362477; x=1768967277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2simHl/yq/0aAfe32CsDuUSVTOgAQmNmUouFvIcZBI=;
        b=qB5jq3mXXYfYJ4lwsxuPi4/YAJFfrKUj3gI6Cl93p5CmasIewcJDI4Q8QpNOMJwPf/
         z3CNze/AxIApNccrGdLwHI+9Y6Oe92rTzlG4J3UqjkoYXVV2QzEuWDxbfjlI1XveQN1G
         i8sXgySP/9vBhqe6WkwFYuoBY3a00b5aMK/l14yLO9yCVB2aBUa+91yaHg5CC9sUIsHd
         Sjb65+7M7R2WdswqMOgWPcfVJxA/Hs6qvPHkCqZTYEASz9dxTPWYhgzQBoAI5gSh6dcG
         5JNbWrbBI8mzlv3o6m0vQxPpoK2Dp9ytPjXtw2/OgZ6Y6TweJ+JFeFVZteRhUKm0wHg9
         y7Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768362477; x=1768967277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z2simHl/yq/0aAfe32CsDuUSVTOgAQmNmUouFvIcZBI=;
        b=fuTkB9AuvxHnJF3Uo0GYG0S1C5b9+5oxTlsnBNr/fTHsEmGQv8zG03pOrFVMya4uMg
         P8FZ46DYDMqkzBgqEn0Gs0IrWnKocoC+tJI5DwexHgqa+0MjvFGI5bkqKskccYrEoUuD
         vniTtKxvoxwCW4FoU4clsJPk93s67exvub8pjm4RCKzBmtgaw7vlAPbkE8UxmooSg11D
         1U18Hy6rL2PVdoikoIUqLkMdh3cMuUqM590FTTtV4oVya5t/ChS/V7u9P6hlo5Ferz0Y
         Q22tBlkxu6f9h5a/rZbNgXZ0mr2vFQK2ayVG7YhSDoKGIusEiJkIY4zyT4pYgl2nzDM4
         +nJw==
X-Forwarded-Encrypted: i=1; AJvYcCW8VQ1RmqeOz3bq1GU4JLSQYY7p/j1dV0PQh93obw/Arx1Ct8uRXFTuxiTm6+DLxa+Eqv4LFtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnmsA2c+X5Ph/uLtg6Y5vz/IV1LSH3e56Z4NCcm+Z6QPvAFxP7
	8ccoyoMpu3Kx/c6Etcp16v27W6fmupNtTBUgLSlmnt+1PCnUAWn9y8FZ13J8bDWJRBVKquFtyK5
	Eb34ygDFEu0XwY/pkT8df3LLX7fVQrv/baK5YAUS273JkxAZmt8J0y/Q+nc357U86c7TKJwPzTW
	B6S/drRqZUMTfRnzLwwIjRCTx43mUbJLLL
X-Gm-Gg: AY/fxX7Hi5kHoRuHU3DGJWQ42+fjoQBpUXcQ7smQLZmAqfmZTVtDP0+pzxK+c9uPtgJ
	ImE+Dzodb+jxjKHbpqg5IPi47zLz/8Qbk3+kjrlSqaZQ4rMTjqPXhmhgPidaKAr5pM7bzlk6uZ4
	6XVNv7y3L6qeYh9gepvvvX0CMiIe3UgjMoit24HqH7DYWivK2dvxPQGGINg9fAJzaNGhk=
X-Received: by 2002:a17:902:d2c9:b0:2a5:8e98:1b44 with SMTP id d9443c01a7336-2a599e7718fmr12856885ad.31.1768362476710;
        Tue, 13 Jan 2026 19:47:56 -0800 (PST)
X-Received: by 2002:a17:902:d2c9:b0:2a5:8e98:1b44 with SMTP id
 d9443c01a7336-2a599e7718fmr12856635ad.31.1768362476291; Tue, 13 Jan 2026
 19:47:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106095243.15105-1-maklimek97@gmail.com> <20260106095243.15105-2-maklimek97@gmail.com>
 <a9dcc27d-521e-44b0-b399-c353ef50077a@redhat.com> <55e12beb-758c-4f82-992e-e07c9c300d4b@redhat.com>
In-Reply-To: <55e12beb-758c-4f82-992e-e07c9c300d4b@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 14 Jan 2026 11:47:45 +0800
X-Gm-Features: AZwV_QgtHM-TqiAEUiyMvb1YhPmz0oILmnlwozHYmLoZnlKE_ZvDb1KsEFf_lZI
Message-ID: <CACGkMEubbV8Pe7w7weke_RZqdYR3U+wrC2iKV5_RXCAfwFw9Jg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] net: gso: do not include jumbogram HBH
 header in seglen calculation
To: Paolo Abeni <pabeni@redhat.com>
Cc: Mariusz Klimek <maklimek97@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 9:51=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 1/13/26 9:40 AM, Paolo Abeni wrote:
> > On 1/6/26 10:52 AM, Mariusz Klimek wrote:
> >> @@ -177,8 +178,13 @@ static unsigned int skb_gso_transport_seglen(cons=
t struct sk_buff *skb)
> >>   */
> >>  static unsigned int skb_gso_network_seglen(const struct sk_buff *skb)
> >>  {
> >> -    unsigned int hdr_len =3D skb_transport_header(skb) -
> >> -                           skb_network_header(skb);
> >> +    unsigned int off =3D skb_network_offset(skb) + sizeof(struct ipv6=
hdr);
> >> +    unsigned int hdr_len =3D skb_network_header_len(skb);
> >> +
> >> +    /* Jumbogram HBH header is removed upon segmentation. */
> >> +    if (skb_protocol(skb, true) =3D=3D htons(ETH_P_IPV6) &&
> >> +        skb->len - off > IPV6_MAXPLEN)
> >> +            hdr_len -=3D sizeof(struct hop_jumbo_hdr);
> >
> > IIRC there is some ongoing discussion about introducing big tcp support
> > for virtio. Perhaps a DEBUG_NET_WARN_ON_ONCE(SKB_GSO_DODGY) could help
> > keeping this check updated at due time?
> >
> > @Jason: could you please double check if I'm off WRT virtio support for
> > big TCP?
>
> Reconsidering the above, I think the mentioned check could be added
> separately, if and when virtio big TCP will come to life.

I agree. BIG TCP support for virtio requires spec features like
tso_max_size/segs advertisement, jumbogram head flags. And if I am not
wrong, HBH header is probably not needed at that time.

Thanks

>
> /P
>


