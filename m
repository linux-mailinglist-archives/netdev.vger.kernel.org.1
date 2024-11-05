Return-Path: <netdev+bounces-141864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EC19BC914
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43CD1C210C8
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8651CFEDB;
	Tue,  5 Nov 2024 09:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ueUscxhA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E071CEAD3
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798751; cv=none; b=Rgw+dl/D79r1R6Lg4kS2zo9YfLWW2QKrzKWP0f2B4MTzOek3OyjAou7klKhNF718z2wLLJumKCSh8fj7oKdYN0lmTDG6XmN+JMapQ3CVS8ikpsfnNAQ+JzYZxl6V1VKOBUA/HJ9pWlRHRu8IXTsBAWhLQxDEwG/4FYw6yZqM8LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798751; c=relaxed/simple;
	bh=KcY42FPvtnq6OFbQUwWWfgE+hW7UfWMrW1tl39zYFaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+Fqe7Su3GyEZyJMo7UGqJNj1v7RCFGQZgBToTidPOeBdQFZfj8yiaff0FlNGKSJhP6JUdrQBQlLCrRNBNQmfEJr0mR9UtP508mzKLIT+YCjHy7O1KUQZeRQRm5D5twpmK0xLEvV7BYvzBaMdnHpzzM5GVaUdFOblBsYbGlJkS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ueUscxhA; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c984352742so6197272a12.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 01:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730798748; x=1731403548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9FPXG1LQELNToyRoGqMx1mS5uhmOWH7uDHaAUOLnUw=;
        b=ueUscxhA8AXkI1svH/2ejX60BzZGbFmong8EFGvvPLIkBckgzXuAVKiSwD75OMO69j
         ZFVubf8p/xOpG9mX4aw5J3fUAsagiGDEIJLfMPAj4JqkAG4cRnyr7JSbtyueBqLa3zpx
         rIx2yY+R3C7OfsIDNJWiiqW/6tVDuiqo+XA4fvkJk7Vfq/pMubb1aJR3bp2a19Tr+BDJ
         W64OSqrYIIv/ynVeGJI64eg9zmrJQE27BfsiSEiDGxoLm0V9d60cSmnQB3lpinlY3VEt
         kdNSfvuNw5tUXbKudC7WgMVa94y6psND9F1cCOByetjLpcjc+7vck4iwWgJlBtJdlOV0
         jUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730798748; x=1731403548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9FPXG1LQELNToyRoGqMx1mS5uhmOWH7uDHaAUOLnUw=;
        b=fJRxkLMVxEEJXcgZ5+NzCW3XnzlGuyFRRho0BE7fsifhPZBNfk3+yMvJ4gBqJ2kxRF
         K2VDRl9PMUkYj8ANALEx61/YTSIp6x3EIt3tI2OcTH6l9WkA6E4T7C0ZbZA2Y6fRHH4+
         ldQB/U653dqrg09tX1SNCqoNqZr9E/4kDiThVbWlQ4G/X7aT/KW2TZ8COLFy0YQG6Oxy
         j2/MjQllIY3AHJqkHeHw38oxWUtVFzDitUD085o9kjGr55sM9PtgdQt5G4c1dPZ9uQFv
         7+3/IsMm/Y9VGqFZzPM0bSEaOG/CfwkxJvX4kJdYPpVduUzaGsdlLWsip9gibgYGRKsv
         LUYw==
X-Forwarded-Encrypted: i=1; AJvYcCV+q0UlsAmw7J1Nfefb6RRD++E6IMHEICD/a+c756rIu9zJFNZySpVkK9St0/v/FJ+L/j0SjTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbiJPtbgW9VZufIGcJCkWfy31G/59W1Pj3K/eH3Hv2ZSOX0+Aw
	UFbi3ZH6TPYzhUA5jd7MFPD2mB1qR1a51t+uJ9/64SWeIOV+wzp3+QAXUD3PoW/IzsENJtl6jrV
	PUVQIMjVNpr193qFbLLzfIsqZtEKI4UN/UVPs
X-Google-Smtp-Source: AGHT+IFWw5e0Lj3WFMEm21UIlPzv+yQa97oWMx8p8bOR9ghoVbBQ1kyOtpJM5Qa+FzaQTbnGQmtSwGG5N1r5PakPfjY=
X-Received: by 2002:a17:907:2cc7:b0:a99:d308:926 with SMTP id
 a640c23a62f3a-a9de632d0a5mr3159772266b.57.1730798747742; Tue, 05 Nov 2024
 01:25:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912071702.221128-1-en-wei.wu@canonical.com>
 <20240912113518.5941b0cf@gmx.net> <CANn89iK31kn7QRcFydsH79Pm_FNUkJXdft=x81jvKD90Z5Y0xg@mail.gmail.com>
 <CAMqyJG1W1ER0Q_poS7HQhsogxr1cBo2inRmyz_y5zxPoMtRhrA@mail.gmail.com>
 <CANn89iJ+ijDsTebhKeviXYyB=NQxP2=srpZ99Jf677+xTe7wqg@mail.gmail.com>
 <CAMqyJG1aPBsRFz1XK2JvqY+QUg2HhxugVXG1ZaF8yKYg=KoP3Q@mail.gmail.com>
 <CANn89i+4c0iLXXjFpD1OWV7OBHr5w4S975MKRVB9VU2L-htm4w@mail.gmail.com>
 <CAMqyJG2MqU46jRC1NzYCUeJ45fiP5Z5nS78Mi0FLFjbKbLVrFg@mail.gmail.com> <CAMqyJG0DYVaTXHxjSH8G8ZPRc=2aDB0SZVhoPf2MXpiNT1OXxA@mail.gmail.com>
In-Reply-To: <CAMqyJG0DYVaTXHxjSH8G8ZPRc=2aDB0SZVhoPf2MXpiNT1OXxA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Nov 2024 10:25:35 +0100
Message-ID: <CANn89iL-r3+HBC10m+QdFVn20DdNH=r5EBQDV=EmewWm6Vsyqg@mail.gmail.com>
Subject: Re: [PATCH ipsec v2] xfrm: check MAC header is shown with both
 skb->mac_len and skb_mac_header_was_set()
To: En-Wei WU <en-wei.wu@canonical.com>
Cc: Peter Seiderer <ps.report@gmx.net>, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kai.heng.feng@canonical.com, chia-lin.kao@canonical.com, 
	anthony.wong@canonical.com, kuan-ying.lee@canonical.com, 
	chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 3:22=E2=80=AFPM En-Wei WU <en-wei.wu@canonical.com>=
 wrote:
>
> > Seems like the __netif_receive_skb_core() and dev_gro_receive() are
> > the places where it calls skb_reset_mac_len() with skb->mac_header =3D
> > ~0U.
> I believe it's the root cause.
>
> My concern is that if we put something like:
> +       if (!skb_mac_header_was_set(skb)) {
> +               DEBUG_NET_WARN_ON_ONCE(1);
> +               skb->mac_len =3D 0;
> in skb_reset_mac_len(), it may degrade the RX path a bit.

I do not have such concerns. Note this is temporary until we fix the root c=
ause.

>
> Catching the bug in xfrm4_remove_tunnel_encap() and
> xfrm6_remove_tunnel_encap() (the original patch) is nice because it
> won't affect the systems which are not using the xfrm.
>

Somehow xfrm is feeding to gro_cells_receive() packets without the mac
header being set, this is the bug that needs to be fixed.

GRO needs skb_mac_header() to return the correct pointer.

For normal GRO, it is set either in :

1) napi_gro_frags : napi_frags_skb()  calls skb_reset_mac_header(skb);

2) napi_gro_receive() : callers are supposed to call eth_type_trans()
before calling napi_gro_receive().
    eth_type_trans() calls skb_reset_mac_header() as expected.

xfrm calls skb_mac_header_rebuild(), but it might be a NOP if MAC
header was never set.

