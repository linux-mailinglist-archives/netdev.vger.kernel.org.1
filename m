Return-Path: <netdev+bounces-182576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD4DA89286
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 05:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BAA3B6FE3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 03:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A96205AA3;
	Tue, 15 Apr 2025 03:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjOYJVfR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6108C6FC5
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 03:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744687763; cv=none; b=Hxm6i2NIJhM3eP4Nejs0lFL7UIA68l8h+W6b3KEdMw22LRvjwvm3pNJDjtWHUH9enEbssHFUDul7FJy3JC6iGw8naERdSz2oPfAKMGyznQr15dVe8SF3PunXZViERAaRfW0ni7k4mGfe7gQakqAySwSkqHlPw7zma9TSrQXFKno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744687763; c=relaxed/simple;
	bh=u6cZJ9xixxnt0EVCdJDIunJT8bN4LJIL4NeGO4z2Owk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSSc18DX2pnZqZ2natZzw/sl47RhfDv30OFIZ0T87EBdGtO6OHmfUyzIYKxFKMzJ8MNxJLyeMSg+aZaLBqo0YMFLkvV1IZed2HG/yloIJ/zVm2snEIut/f1LXCnHKxbJ0dMeryg9SejdWzXej7l0lwqoriihUiS0ERFXDrDYC38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjOYJVfR; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e686d39ba2so9123843a12.2
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 20:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744687760; x=1745292560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfS/ot8w3THdLEeWxcT0uMmpu6PfgU6SFgo9CWuAeFE=;
        b=OjOYJVfRTsGrdMpw8ebN39vbpvp0QmHE/PInUME88lVUwZNtLzmcoQnleXtfduAT9D
         BvyM/UUtRpZ1VjMPZaAeFOTK6UkiHEJ80xgzjN+VN1RZMcTJ0umF4v0FNOUq7skUkaOc
         Vo/f6THuOdfnLRiE5xeQmKlChvdPBja7Fy9RAMlB4nREDIXzeZCyIun7V/A/6LG8LfzH
         WsKAq6rzN+LAe2qerx3mwYxdzGFvovwnN1/YltlAwOXTcZscb9gT+S/dr0b0asj7r3wa
         mwNBflvSnj6lln/zV22VzWiKt7hWUhS/BjavwKQM7J9L0D7s/0BE+78cFPM8eNt5saaJ
         d1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744687760; x=1745292560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfS/ot8w3THdLEeWxcT0uMmpu6PfgU6SFgo9CWuAeFE=;
        b=QmNH/lyJ5G50Tz/YL2nix88v/arM+5LNfIbuSPC/fMR7SXHgT7gcU4EEMlUmrWpJ1W
         5S/l7B+ujnuEYFU85WEI+KO8Yp8qeWCIp/LmTrR2kBBOxEViz4f0Exps8KEGwStbZJqw
         xcRa6LBE+3ib9YrxdgAt4gpO+2gP7as89otwYVAtkKpn1UsIEHTcJL7k5drHVutMpqox
         Ap15fV8XbBO6OhxsPAcieVMj3KWAmMYuSmvBwvPtrU82hHoihl+sCx4qBHFocS0llkh6
         VP65EmAOe237/ZAaV4NLdP100lgffyE7y45M9tcU7/b4CTuPRpV47FJyO8d+5JgkEM5V
         M6BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc1XLnacQQsdCRNMKcowVGyETiKHTqaL+hMQ3cmmfMKeT9G0PCB/a2TZvzgH/h/p7Y1OYPjDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbDmVBL3yv8YXL/5zF0Xhaba4QH+/H6rv8bxxk/62XGwIEZSTr
	n0KXJj0+YdDshvwnOdVpnyWx2u49i7jk+HPiyWxs0NGDMJK020hZtdOMYm9wc5XKxewp+ekna+F
	/nNgFKPtQd0GCAe2iXBnvcI2D7O0=
X-Gm-Gg: ASbGnctM/ZtlsVt/mi4+/Bm1rAq1SOE8cXz9GMOVqwTjaXXp2R5gRg7Mpc7aHI0sqwT
	XsN8O05UALpGI3aALZgYj3I2efxC6kOfs8KIPCWjeiWtriElIAKMePFCgTfyEpFUNODGEbkqQiW
	9t9yy/iPWrDj0dg4PRtuXIRUlp
X-Google-Smtp-Source: AGHT+IHmzV8TQjfCI0We5gHxN5EBW+2/rz/G0zagz1jHfJv/6yGkQojBQVNqE2UBVj3WtwaXZxldQryaiYTbJDyNNWU=
X-Received: by 2002:a05:6402:2685:b0:5e4:cfe8:3502 with SMTP id
 4fb4d7f45d1cf-5f36fede97bmr13371092a12.17.1744687759408; Mon, 14 Apr 2025
 20:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410074351.4155508-1-ap420073@gmail.com> <20250414154716.67412a8d@kernel.org>
In-Reply-To: <20250414154716.67412a8d@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Tue, 15 Apr 2025 12:29:07 +0900
X-Gm-Features: ATxdqUE9iMy-A_kGogU99KejUJJ8PN0S0md4QHeDieTLXHoK5tcxvZi-YP564Q0
Message-ID: <CAMArcTVWM8uY3-pmn4Qoy4rujjxrEQXJoF2C9bAXNH9_OJFZMA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] eth: bnxt: add support rx side device memory TCP
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	netdev@vger.kernel.org, dw@davidwei.uk, kuniyu@amazon.com, sdf@fomichev.me, 
	ahmed.zaki@intel.com, aleksander.lobakin@intel.com, 
	hongguang.gao@broadcom.com, Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 7:47=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>

Hi Jakub,
Thanks a lot for your review!

> On Thu, 10 Apr 2025 07:43:51 +0000 Taehee Yoo wrote:
> > @@ -1251,27 +1269,41 @@ static u32 __bnxt_rx_agg_pages(struct bnxt *bp,
> >                           RX_AGG_CMP_LEN) >> RX_AGG_CMP_LEN_SHIFT;
> >
> >               cons_rx_buf =3D &rxr->rx_agg_ring[cons];
> > -             skb_frag_fill_page_desc(frag, cons_rx_buf->page,
> > -                                     cons_rx_buf->offset, frag_len);
> > -             shinfo->nr_frags =3D i + 1;
> > +             if (skb) {
> > +                     skb_add_rx_frag_netmem(skb, i, cons_rx_buf->netme=
m,
> > +                                            cons_rx_buf->offset,
> > +                                            frag_len, BNXT_RX_PAGE_SIZ=
E);
>
> I thought BNXT_RX_PAGE_SIZE is the max page size supported by HW.
> We currently only allocate order 0 pages/netmems, so the truesize
> calculation should use PAGE_SIZE, AFAIU?

Thanks for catching this! I will fix this in the v3 patch.

>
> > +             } else {
> > +                     skb_frag_t *frag =3D &shinfo->frags[i];
> > +
> > +                     skb_frag_fill_netmem_desc(frag, cons_rx_buf->netm=
em,
> > +                                               cons_rx_buf->offset,
> > +                                               frag_len);
> > +                     shinfo->nr_frags =3D i + 1;
> > +             }
> >               __clear_bit(cons, rxr->rx_agg_bmap);
> >
> > -             /* It is possible for bnxt_alloc_rx_page() to allocate
> > +             /* It is possible for bnxt_alloc_rx_netmem() to allocate
> >                * a sw_prod index that equals the cons index, so we
> >                * need to clear the cons entry now.
> >                */
> > -             mapping =3D cons_rx_buf->mapping;
> > -             page =3D cons_rx_buf->page;
> > -             cons_rx_buf->page =3D NULL;
> > +             netmem =3D cons_rx_buf->netmem;
> > +             cons_rx_buf->netmem =3D 0;
> >
> > -             if (xdp && page_is_pfmemalloc(page))
> > +             if (xdp && netmem_is_pfmemalloc(netmem))
> >                       xdp_buff_set_frag_pfmemalloc(xdp);
> >
> > -             if (bnxt_alloc_rx_page(bp, rxr, prod, GFP_ATOMIC) !=3D 0)=
 {
> > +             if (bnxt_alloc_rx_netmem(bp, rxr, prod, GFP_ATOMIC) !=3D =
0) {
> > +                     if (skb) {
> > +                             skb->len -=3D frag_len;
> > +                             skb->data_len -=3D frag_len;
> > +                             skb->truesize -=3D BNXT_RX_PAGE_SIZE;
>
> and here.

I will fix this.

>
> > +                     }
>
> > +bool dev_is_mp_channel(struct net_device *dev, int i)
> > +{
> > +     return !!dev->_rx[i].mp_params.mp_priv;
> > +}
> > +EXPORT_SYMBOL(dev_is_mp_channel);
>
> Sorry for a late comment but since you only use this helper after
> allocating the payload pool -- do you think we could make the helper
> operate on a page pool rather than device? I mean something like:
>
> bool page_pool_is_unreadable(pp)
> {
>         return !!pp->mp_ops;
> }
>
> ? I could be wrong but I'm worried that we may migrate the mp
> settings to dev->cfg at some point, and then this helper will
> be ambiguous (current vs pending settings).

I agree with you.
This helper is ambiguous for getting mp_priv.
The mp_priv metadata is page_pool's metadata, so a page_pool-based
helper should be needed instead of a device-based helper.
I will change it in the v3 patch.

>
> The dev_is_mp_channel() -> page_pool_is_readable() refactor is up to
> you, but I think the truesize needs to be fixed.

Thanks a lot!
Taehee Yoo

> --
> pw-bot: cr

