Return-Path: <netdev+bounces-195353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F174CACFD4B
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 09:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDC43A82AE
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 07:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72075149C7B;
	Fri,  6 Jun 2025 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b="UXBatLuy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC5D3596A
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 07:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749194207; cv=none; b=r7i3vEMYjWbBp0KQdwKHYPQ8XVm8askyvH+dfGt5+PrMxLpjPkharnKJa0ak+00gbTwMtUwAU5J4fLyuE/cNwnpQ6EaMh/mR96EHzOyOqB95yobCokPhYxTWPXgtHlS+AQO8TTMv1DfF4CLn94DZM3ajiphqyG7J5Y2M/X/kuBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749194207; c=relaxed/simple;
	bh=cAJrkKXG09xOhd2Hzr+C5E4wIGGeJl26deIYWukEoLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQ2/iYoWVwTC/PFEmI1Nlpf36R+fDbNxFF0fB07aNP7C/+D+ZsrUs9lFyylcmeyh/YkKRnrm+FGcLXLkuDlQWbL1W282UTr1xQJam7ptb3vx8dXqzK2THKdUyeByxqDS7aOM7kzYw2hwj+O6VNQhWV6rsiZe9kJU2VSAI6Z5+lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com; spf=pass smtp.mailfrom=gmo-cybersecurity.com; dkim=pass (2048-bit key) header.d=gmo-cybersecurity.com header.i=@gmo-cybersecurity.com header.b=UXBatLuy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmo-cybersecurity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmo-cybersecurity.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so14415855e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Jun 2025 00:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmo-cybersecurity.com; s=google; t=1749194203; x=1749799003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XMi5+8eZH1IMFT7aIIxuzqoktYcarPLjPOsXqsdoW0=;
        b=UXBatLuy9FR+dbtuBtJlT2cpTWlw9nh0lfnPueOdY586OZlNETOlN3JLHU/qXWm9ub
         BVXcS0MC4rfWfWcn1TwcCmRjg7s/kKeuveT2vtTmkSI/cF/Wl7coxXv8yWHCzfz38sgm
         MI+h+qU9XsktNbRu+iehVVvoy9/zk/ZclP2fweNa1GLVw9Do+vcwMJjj1vP+2MTrBgE5
         SyXnwS/aiwOowu6zoxwzyFOYnNqjc9168UYW6l4pudCTZHEtq2bDgPWaYSoEPhb4jAvd
         npNyQQEUw6JWfVIHijWVpldBwT47I/bghBMY++9WnJvCbNwfDhexzTEkvqhk3arOCbeE
         EJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749194203; x=1749799003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XMi5+8eZH1IMFT7aIIxuzqoktYcarPLjPOsXqsdoW0=;
        b=CiGKfUp49vGZU/kHhxEVEwWxAVGhpi5LwYBF6dU593NB1NLFWZWF22iC+T1duweE8s
         NXczXwMZzRNvP2YN5CKtVZhPqCFEeevOBb8iZCplibZRID0TfUjE2NtHW98fQFICF+D9
         1PA7TPphYykR3gpH0wNFKwBF1+RRYlWexZlFVBSUDrPw9z3ppCbL0dN6C9n4O4u8asT6
         mrXx82UfEAbnBbLspaVrsCokRyH4CqdSmzpujHBWTZ7NhJOf5/cJklKhg4VPJoluWj1b
         u5NtzQzk8r5shrKVS2hDoiUgvqJkcvPrXPF/pIWKkPAIc0CGdL6hGAgtapAvjhzlXxtH
         vXKg==
X-Gm-Message-State: AOJu0Yxzy2fbBIatFBr5ieJZpXTp3cRSGTUB7QNk3cuikk4UsXli/KYF
	O1vHHE01gX6Ys6BjXqoMk4wwnmnnVBPfWx6m+sl91i0a/RCk2YB8W4tOL9bZ7AQrTbNdgpk3B5J
	WBVsFIEsCb1O63L3YOzY6GN1w4ZmP7pr8L/mURKszZg==
X-Gm-Gg: ASbGncvIuFB1nJOjiNnsTb//EXS6y0t4ozzI+zuh1LAabVs1OHDA5m5nrEg6gwAMEAE
	h354z3Na/P+K959St7IfNy8s7AxNvBrcYZRsp0vqoeliAaEZ6KFHT1i940njYNEYGKQcEIr7bk0
	hAwXz8VWJ+H91yr2FDhPKBfG7jEYN4jKM/Nm0=
X-Google-Smtp-Source: AGHT+IFbp+79x8nHQ+OULHJyBDfxZG/qTcxnaYx6r++2repCfOCP6My7PuJtJ4f7O4onCD/EyLM6Nt3of8iU/1n4iUE=
X-Received: by 2002:a05:600c:8b8b:b0:451:df07:d8e0 with SMTP id
 5b1f17b1804b1-452015832f0mr22700445e9.11.1749194202956; Fri, 06 Jun 2025
 00:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA3_Gnogt7GR0gZVZwQ4vXXav6TpXMK6t=QTLsqKOaX3Bo_tNA@mail.gmail.com>
 <CANn89iLVq=3d7Ra7gKmTpLcMzuWv+KamYs=KjUHH2z3cPpDBDA@mail.gmail.com>
 <CAA3_GnrVyeXtLjhZ_d9=0x58YmK+a9yADfp+LRCBHQo_TEDyvw@mail.gmail.com> <CANn89iJN-fcx-szsR3Azp8wQ0zhXp0XiYJofQU1zqqtdj7SWTA@mail.gmail.com>
In-Reply-To: <CANn89iJN-fcx-szsR3Azp8wQ0zhXp0XiYJofQU1zqqtdj7SWTA@mail.gmail.com>
From: =?UTF-8?B?5oi455Sw5pmD5aSq?= <kota.toda@gmo-cybersecurity.com>
Date: Fri, 6 Jun 2025 16:16:31 +0900
X-Gm-Features: AX0GCFt4wB4HZLPyKUDTkRdMREAP3Zt6ZcM3tUJZen_xiATXlJ5q5OVPx5uS9_Y
Message-ID: <CAA3_GnqOnsOXHk-x4gKKe7MFmS0WQsXmMp6XoQc+fR3gmZVQEQ@mail.gmail.com>
Subject: Re: [PATCH net] bonding: Fix header_ops type confusion
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, 
	=?UTF-8?B?5bCP5rGg5oKg55Sf?= <yuki.koike@gmo-cybersecurity.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2025=E5=B9=B45=E6=9C=8829=E6=97=A5(=E6=9C=A8) 0:10 Eric Dumazet <edumazet@g=
oogle.com>:

>
> On Wed, May 28, 2025 at 7:36=E2=80=AFAM =E6=88=B8=E7=94=B0=E6=99=83=E5=A4=
=AA <kota.toda@gmo-cybersecurity.com> wrote:
> >
> > Thank you for your review.
> >
> > 2025=E5=B9=B45=E6=9C=8826=E6=97=A5(=E6=9C=88) 17:23 Eric Dumazet <eduma=
zet@google.com>:
> > >
> > > On Sun, May 25, 2025 at 10:08=E2=80=AFPM =E6=88=B8=E7=94=B0=E6=99=83=
=E5=A4=AA <kota.toda@gmo-cybersecurity.com> wrote:
> > > >
> > > > In bond_setup_by_slave(), the slave=E2=80=99s header_ops are uncond=
itionally
> > > > copied into the bonding device. As a result, the bonding device may=
 invoke
> > > > the slave-specific header operations on itself, causing
> > > > netdev_priv(bond_dev) (a struct bonding) to be incorrectly interpre=
ted
> > > > as the slave's private-data type.
> > > >
> > > > This type-confusion bug can lead to out-of-bounds writes into the s=
kb,
> > > > resulting in memory corruption.
> > > >
> > > > This patch adds two members to struct bonding, bond_header_ops and
> > > > header_slave_dev, to avoid type-confusion while keeping track of th=
e
> > > > slave's header_ops.
> > > >
> > > > Fixes: 1284cd3a2b740 (bonding: two small fixes for IPoIB support)
> > > > Signed-off-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
> > > > Signed-off-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
> > > > Co-Developed-by: Yuki Koike <yuki.koike@gmo-cybersecurity.com>
> > > > Reviewed-by: Paolo Abeni <pabeni@redhat.com>
> > > > Reported-by: Kota Toda <kota.toda@gmo-cybersecurity.com>
> > > > ---
> > > >  drivers/net/bonding/bond_main.c | 61
> > > > ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > > >  include/net/bonding.h           |  5 +++++
> > > >  2 files changed, 65 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/=
bond_main.c
> > > > index 8ea183da8d53..690f3e0971d0 100644
> > > > --- a/drivers/net/bonding/bond_main.c
> > > > +++ b/drivers/net/bonding/bond_main.c
> > > > @@ -1619,14 +1619,65 @@ static void bond_compute_features(struct bo=
nding *bond)
> > > >      netdev_change_features(bond_dev);
> > > >  }
> > > >
> > > > +static int bond_hard_header(struct sk_buff *skb, struct net_device=
 *dev,
> > > > +        unsigned short type, const void *daddr,
> > > > +        const void *saddr, unsigned int len)
> > > > +{
> > > > +    struct bonding *bond =3D netdev_priv(dev);
> > > > +    struct net_device *slave_dev;
> > > > +
> > > > +    slave_dev =3D bond->header_slave_dev;
> > > > +
> > > > +    return dev_hard_header(skb, slave_dev, type, daddr, saddr, len=
);
> > > > +}
> > > > +
> > > > +static void bond_header_cache_update(struct hh_cache *hh, const
> > > > struct net_device *dev,
> > > > +        const unsigned char *haddr)
> > > > +{
> > > > +    const struct bonding *bond =3D netdev_priv(dev);
> > > > +    struct net_device *slave_dev;
> > > > +
> > > > +    slave_dev =3D bond->header_slave_dev;
> > >
> > > I do not see any barrier ?
> > >
> > > > +
> > > > +    if (!slave_dev->header_ops || !slave_dev->header_ops->cache_up=
date)
> > > > +        return;
> > > > +
> > > > +    slave_dev->header_ops->cache_update(hh, slave_dev, haddr);
> > > > +}
> > > > +
> > > >  static void bond_setup_by_slave(struct net_device *bond_dev,
> > > >                  struct net_device *slave_dev)
> > > >  {
> > > > +    struct bonding *bond =3D netdev_priv(bond_dev);
> > > >      bool was_up =3D !!(bond_dev->flags & IFF_UP);
> > > >
> > > >      dev_close(bond_dev);
> > > >
> > > > -    bond_dev->header_ops        =3D slave_dev->header_ops;
> > > > +    /* Some functions are given dev as an argument
> > > > +     * while others not. When dev is not given, we cannot
> > > > +     * find out what is the slave device through struct bonding
> > > > +     * (the private data of bond_dev). Therefore, we need a raw
> > > > +     * header_ops variable instead of its pointer to const header_=
ops
> > > > +     * and assign slave's functions directly.
> > > > +     * For the other case, we set the wrapper functions that pass
> > > > +     * slave_dev to the wrapped functions.
> > > > +     */
> > > > +    bond->bond_header_ops.create =3D bond_hard_header;
> > > > +    bond->bond_header_ops.cache_update =3D bond_header_cache_updat=
e;
> > > > +    if (slave_dev->header_ops) {
> > > > +        bond->bond_header_ops.parse =3D slave_dev->header_ops->par=
se;
> > > > +        bond->bond_header_ops.cache =3D slave_dev->header_ops->cac=
he;
> > > > +        bond->bond_header_ops.validate =3D slave_dev->header_ops->=
validate;
> > > > +        bond->bond_header_ops.parse_protocol =3D
> > > > slave_dev->header_ops->parse_protocol;
> > >
> > > All these updates probably need WRITE_ONCE(), and corresponding
> > > READ_ONCE() on reader sides, at a very minimum ...
> > >
> > > RCU would even be better later.
> > >
> > I believe that locking is not necessary in this patch. The update of
> > `header_ops` only happens when a slave is newly enslaved to a bond.
> > Under such circumstances, members of `header_ops` are not called in
> > parallel with updating. Therefore, there is no possibility of race
> > conditions occurring.
>
> bond_dev can certainly be live, and packets can flow.
>
> I have seen enough syzbot reports hinting at this precise issue.

Hi Eric, Thank you for reviewing the patch.

At the beginning of `bond_setup_by_slave`, `dev_close(bond_dev)` is called,
meaning bond_dev is down and no packets can flow during the update of
`bond_header_ops`.

The syzbot report (you mentioned in the conversation in security@) indicati=
ng
`dev->header_ops` becoming NULL should be resolved by this patch.
I couldn't find any other related syzbot reports.

