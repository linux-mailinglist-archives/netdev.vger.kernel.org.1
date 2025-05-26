Return-Path: <netdev+bounces-193382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50724AC3B9C
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 10:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34BE0174BDF
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CA51DED4C;
	Mon, 26 May 2025 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjUDad0o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ABB1DF97C
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 08:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748247813; cv=none; b=HlIdumvJ58dOKxSElWJHdB6gihmJ+ewOI+Pjm/uDhM/SBzCvktWyWmCY39p8lMsg7uRZZyst6hrh7+bYAatNrsyXgi9L2GUDMk9R/QbjFtrEO75GmnMANS3H7qD3CpNmfqTXoln9oUbfFZTnrZ2t4IHMZM9GL9QH+JgLYHlz0K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748247813; c=relaxed/simple;
	bh=/u2pRKc8DAPwS8qhuBy/bmveBbyD9ydGg17ar/9+9b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OiHAUMhiynENk+RYTPRzd471IRIwJDbD3VfnRCnA39XtaehZxucEliQCA+wP4ktoicJqyo7Q2x1PWFzbNx9pKR17DVGlQ6GFu1rimluYLmlwJ0HTKPioHPrxNSbhw9i/PjfPyab4qzdBMzwp6ps3pvL38bT61fAC3jmTadmJgY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjUDad0o; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6faa543d8bcso11689556d6.3
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 01:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748247811; x=1748852611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84n7LcBHS9qDmuOC4JYR5K/fcw9OQaXEZENkHIEWdts=;
        b=hjUDad0oJMm3HP5dLANnhW0HVdAmQlMGiJfOpGvB9Q0ERZw7Jjoq7HtPNdPpwdijcA
         PLbOuqWAi5tj858jk809NWnt5D50vuWFakh3nIB5xUpUKwzjmW6RChX85HhAWzW36m2j
         Vu6KIf1jHeNrN20/HPUowrPXN87VhIbvRdQJuuOV2o4ARheXkLcJ8ImwhMoWQO8edtwt
         W3qDK6bIMC5LAyHI/h5DQc2ABEEDz+Q//JEABDxOmY/d7NWFhCOEVa4Btra60poDuSLu
         O2P2oN7FhrC1ii49tJT9IJ5uDNocGfgc2Tv6V1GatFZEf9KHhkrRxaWvDhzwxKvVsR5t
         iRgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748247811; x=1748852611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84n7LcBHS9qDmuOC4JYR5K/fcw9OQaXEZENkHIEWdts=;
        b=gCzo7DG2ozZnTT09w9aBJk/rVJHGGHeHX04dl0l8wzBESOLexiIow5oq1R4avUTCH4
         4G1XIpLz29aZyvzgUjbrq1elp3G8jNVrgfP8/gW76Jkjp9bhMPDVVZUdrKk0yOPk8PC9
         YhMzgRjAwa9RXtFk6g2swE9DR1Q1T0euIUbZscO6OUn7ZExY2XOgfFCRQSwu9/n2oEan
         RAEK2Z08kxze8O4NPFqdHBNWOhua9uPDC1nyAeV/k35p1yPlt6uR9Jr0U62UPMOmU76i
         tXxooXx5qJAIIXXL0ivcuPPSWl9YhUYb1Q/8CmltYCD/KWsvTSnbi7B7ipk3g+FDhAhQ
         NunA==
X-Forwarded-Encrypted: i=1; AJvYcCVsygEIGueE6KgEQXgEF++3yEEKJ1hTZGT0lM0rx2bDyc9TQ6hHGz4t3V41KhnjVcUf0eBvyDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaAVUSpF/YkjyC2l7FCA3IQeWRszmKG/Qeyl1kGgp7kbHHCjiS
	WFQfc3oJjMEuF3npHPWFl2l4eZ0cAxVcUx712uzrolo8Zs+kh+0LpQVcZ7bTNYlqYAWv0BbZ/hd
	QiuDEWw6uxHdNhmpjyqNrU9Qt9G/8EE2VnMFe2DzSRwdfoYNNFNlZqLTaElU=
X-Gm-Gg: ASbGncvof9ECmoqn7m8DTj8hQjM3IRAUE8qWztigJg9k/zyi/3lVMZhY/O6SvyfoGki
	speqW6wRXngvkH+uwvsPxkhYD1pQIeVi165BBdVumUc/im7xC65o1Fon+MxR9lo3GiVAK1vlzKL
	CxooSGfmjp3ci0y/lOLqH/IAo5SivudkivoMyHhHE+THI=
X-Google-Smtp-Source: AGHT+IFz/xG46iZgyY9nkIOQGMKaD8FQAKUzqsO5IU1y1cfjSX7dhen3YqdOwADG5Xwcl3WnnR228ADH7WGm2lrkCS8=
X-Received: by 2002:a05:6214:1d0d:b0:6f2:a886:7c6d with SMTP id
 6a1803df08f44-6fa9cfe73a6mr133658476d6.3.1748247810315; Mon, 26 May 2025
 01:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA3_Gnogt7GR0gZVZwQ4vXXav6TpXMK6t=QTLsqKOaX3Bo_tNA@mail.gmail.com>
In-Reply-To: <CAA3_Gnogt7GR0gZVZwQ4vXXav6TpXMK6t=QTLsqKOaX3Bo_tNA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 May 2025 01:23:18 -0700
X-Gm-Features: AX0GCFvV_EHZWs4lMyBGnQsogf2LhjTkEZvKCFQeSXeBo0x4YluhaL7Nf65Jncw
Message-ID: <CANn89iLVq=3d7Ra7gKmTpLcMzuWv+KamYs=KjUHH2z3cPpDBDA@mail.gmail.com>
Subject: Re: [PATCH net] bonding: Fix header_ops type confusion
To: =?UTF-8?B?5oi455Sw5pmD5aSq?= <kota.toda@gmo-cybersecurity.com>
Cc: =?UTF-8?B?5bCP5rGg5oKg55Sf?= <yuki.koike@gmo-cybersecurity.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 10:08=E2=80=AFPM =E6=88=B8=E7=94=B0=E6=99=83=E5=A4=
=AA <kota.toda@gmo-cybersecurity.com> wrote:
>
> In bond_setup_by_slave(), the slave=E2=80=99s header_ops are unconditiona=
lly
> copied into the bonding device. As a result, the bonding device may invok=
e
> the slave-specific header operations on itself, causing
> netdev_priv(bond_dev) (a struct bonding) to be incorrectly interpreted
> as the slave's private-data type.
>
> This type-confusion bug can lead to out-of-bounds writes into the skb,
> resulting in memory corruption.
>
> This patch adds two members to struct bonding, bond_header_ops and
> header_slave_dev, to avoid type-confusion while keeping track of the
> slave's header_ops.
>
> Fixes: 1284cd3a2b740 (bonding: two small fixes for IPoIB support)
> Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
> Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
> Co-Developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
> Reviewed-by: Paolo Abeni <pabeni@redhat.com>
> Reported-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
> ---
>  drivers/net/bonding/bond_main.c | 61
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  include/net/bonding.h           |  5 +++++
>  2 files changed, 65 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
> index 8ea183da8d53..690f3e0971d0 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1619,14 +1619,65 @@ static void bond_compute_features(struct bonding =
*bond)
>      netdev_change_features(bond_dev);
>  }
>
> +static int bond_hard_header(struct sk_buff *skb, struct net_device *dev,
> +        unsigned short type, const void *daddr,
> +        const void *saddr, unsigned int len)
> +{
> +    struct bonding *bond =3D netdev_priv(dev);
> +    struct net_device *slave_dev;
> +
> +    slave_dev =3D bond->header_slave_dev;
> +
> +    return dev_hard_header(skb, slave_dev, type, daddr, saddr, len);
> +}
> +
> +static void bond_header_cache_update(struct hh_cache *hh, const
> struct net_device *dev,
> +        const unsigned char *haddr)
> +{
> +    const struct bonding *bond =3D netdev_priv(dev);
> +    struct net_device *slave_dev;
> +
> +    slave_dev =3D bond->header_slave_dev;

I do not see any barrier ?

> +
> +    if (!slave_dev->header_ops || !slave_dev->header_ops->cache_update)
> +        return;
> +
> +    slave_dev->header_ops->cache_update(hh, slave_dev, haddr);
> +}
> +
>  static void bond_setup_by_slave(struct net_device *bond_dev,
>                  struct net_device *slave_dev)
>  {
> +    struct bonding *bond =3D netdev_priv(bond_dev);
>      bool was_up =3D !!(bond_dev->flags & IFF_UP);
>
>      dev_close(bond_dev);
>
> -    bond_dev->header_ops        =3D slave_dev->header_ops;
> +    /* Some functions are given dev as an argument
> +     * while others not. When dev is not given, we cannot
> +     * find out what is the slave device through struct bonding
> +     * (the private data of bond_dev). Therefore, we need a raw
> +     * header_ops variable instead of its pointer to const header_ops
> +     * and assign slave's functions directly.
> +     * For the other case, we set the wrapper functions that pass
> +     * slave_dev to the wrapped functions.
> +     */
> +    bond->bond_header_ops.create =3D bond_hard_header;
> +    bond->bond_header_ops.cache_update =3D bond_header_cache_update;
> +    if (slave_dev->header_ops) {
> +        bond->bond_header_ops.parse =3D slave_dev->header_ops->parse;
> +        bond->bond_header_ops.cache =3D slave_dev->header_ops->cache;
> +        bond->bond_header_ops.validate =3D slave_dev->header_ops->valida=
te;
> +        bond->bond_header_ops.parse_protocol =3D
> slave_dev->header_ops->parse_protocol;

All these updates probably need WRITE_ONCE(), and corresponding
READ_ONCE() on reader sides, at a very minimum ...

RCU would even be better later.


> +    } else {
> +        bond->bond_header_ops.parse =3D NULL;
> +        bond->bond_header_ops.cache =3D NULL;
> +        bond->bond_header_ops.validate =3D NULL;
> +        bond->bond_header_ops.parse_protocol =3D NULL;
> +    }
> +
> +    bond->header_slave_dev      =3D slave_dev;
> +    bond_dev->header_ops        =3D &bond->bond_header_ops;
>
>      bond_dev->type            =3D slave_dev->type;
>      bond_dev->hard_header_len   =3D slave_dev->hard_header_len;
> @@ -2676,6 +2727,14 @@ static int bond_release_and_destroy(struct
> net_device *bond_dev,
>      struct bonding *bond =3D netdev_priv(bond_dev);
>      int ret;
>
> +    /* If slave_dev is the earliest registered one, we must clear
> +     * the variables related to header_ops to avoid dangling pointer.
> +     */
> +    if (bond->header_slave_dev =3D=3D slave_dev) {
> +        bond->header_slave_dev =3D NULL;
> +        bond_dev->header_ops =3D NULL;
> +    }
> +
>      ret =3D __bond_release_one(bond_dev, slave_dev, false, true);
>      if (ret =3D=3D 0 && !bond_has_slaves(bond) &&
>          bond_dev->reg_state !=3D NETREG_UNREGISTERING) {
> diff --git a/include/net/bonding.h b/include/net/bonding.h
> index 95f67b308c19..cf8206187ce9 100644
> --- a/include/net/bonding.h
> +++ b/include/net/bonding.h
> @@ -215,6 +215,11 @@ struct bond_ipsec {
>   */
>  struct bonding {
>      struct   net_device *dev; /* first - useful for panic debug */
> +    struct   net_device *header_slave_dev;  /* slave net_device for
> header_ops */
> +    /* maintained as a non-const variable
> +     * because bond's header_ops should change depending on slaves.
> +     */
> +    struct   header_ops bond_header_ops;
>      struct   slave __rcu *curr_active_slave;
>      struct   slave __rcu *current_arp_slave;
>      struct   slave __rcu *primary_slave;

