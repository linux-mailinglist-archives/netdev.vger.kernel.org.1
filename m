Return-Path: <netdev+bounces-106577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DABB1916E27
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1941F21C5B
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EC4172BB5;
	Tue, 25 Jun 2024 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bm3mfkmh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E190816FF59
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 16:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332981; cv=none; b=Yy6QpFGMzISr0jbm2OQJNiy5JiN5ykxoAOdodFO9dSz7Mp0qUgaWyzqlx2ZHY0a9CXBgOUbrjVaeXXv8HAtiqqm0fIenuMkGBedJGCZw72vjghwGvUEsamNeMhexSWm2Pa5oKqlKHO3yVC5kGBCMNx0quIlbI2z8rUnRQVaG46Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332981; c=relaxed/simple;
	bh=voLilfGiSwPwQ0lsD/Gbu80QhEeOvi7XOzqXovcyFjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tx0Tn8ZOc/SWWf7BwxZTnGaQIzYYpJ6iDiwH2KxEmOG/Ud19Z/L95RIzHy032MhQbcHuP6pMfNWprXyPGFQ2wkodltYZ5jb818tLMf9Mwvxh2p2b1j+mIscX8hNTB5PH4zWQTln4PNjhK3U3SJKbtpVOiiNRPVNtn44HMqfXYrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bm3mfkmh; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-424a2ad06f1so6564855e9.1
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 09:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719332978; x=1719937778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJ3Zxl7/u9c9tYtNwxgLaSlLEpQytxXDrQTT6SFRVB8=;
        b=Bm3mfkmhq5CZXDPlb+6TWzgPdJS8rYM2xXXBfBLhj1OuzxvPWWj/QZ+S7TBtnEeHrD
         TwShOf2U5OjELgU8h4dwMbI0R5KRvTFwtrPvbtWVjWm6+BRRQx4ZkLYvpLCM1fKFXBJY
         KBgODenOQNuzxwNk7nm+Df4AzAzXOss6pwVJdeaPP4ItQh2Nkb2KWDFPmLb4OTDJJJzW
         yGd/0EVz4IVLdRVtU/fpI844blrMFdqJy8cdvyVY2T0ok88jdicqgGrKKo4CeRNCaowk
         mmXwUvhK9UpQ2donEmMHVfONgFW3x1TqIABlZzS7ztjO070xN8VY1tdwYSEUbvNLXuYT
         nCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719332978; x=1719937778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJ3Zxl7/u9c9tYtNwxgLaSlLEpQytxXDrQTT6SFRVB8=;
        b=PLLnCyc+wiXU3M3qLvQLO2CNNei08sZQ23cMWnD3EOhS6PBvdQ8Wi8RrWjsJbLcylQ
         pxvz/OyvHEB1W0uTdbvzFlpvj1D6GIKRRFzl3q4aocAiyALD5LHku7usdmz7EHj7YGz+
         t48Cb2RMfJgSXC/0iC9WzbIvz2qkNfAcwVV9q8VPJAqcASIVn9JH5mUXhiZ+15YPNvSX
         X6IU9SyknBxC90SeIV2CzWLcUDMYOubHRkHVZ1ozErusfXrWOdr1It5dlEX+fHZ3gmRB
         UQzkcyb9+RqXgi+S2RM6FdiPX/76qEdnYdw+dyRigEtjtWW5C64PDXg8a7tKI6261Gts
         b5KQ==
X-Gm-Message-State: AOJu0YxBpr7YVo9dsPN/s2RlSnlnVpk4Aq3G1A/yvCEy8P6sKhkBJrqQ
	/S+t8DiJp/9clFbYNG8LP6NlG6IVq5XoaKynRjJ2KQUMxqLiqM+m9MFVL6WIBlS388/EuityQaF
	v/MLpLrAkTk4i5FRlXpJQVz2YBDY=
X-Google-Smtp-Source: AGHT+IGblRxb+zHjY9NPu6h/Nyz2PK/nCzxpxud5UvNf72SEZp1h9mhu28fHV4gUpRw3AZgFR+eZU7Jtu8p50S/kNys=
X-Received: by 2002:a5d:59a4:0:b0:366:f6bd:a544 with SMTP id
 ffacd0b85a97d-366f6bda67cmr4827924f8f.71.1719332977884; Tue, 25 Jun 2024
 09:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
 <171932617837.3072535.9872136934270317593.stgit@ahduyck-xeon-server.home.arpa>
 <6971f7ce-8514-4da5-afc9-764c0da289c0@lunn.ch>
In-Reply-To: <6971f7ce-8514-4da5-afc9-764c0da289c0@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 25 Jun 2024 09:29:01 -0700
Message-ID: <CAKgT0UfTAk=tNejVLSFth6aSeUhHYSmAErc84mQojXtT9n2GDg@mail.gmail.com>
Subject: Re: [net-next PATCH v2 11/15] eth: fbnic: Add link detection
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 8:25=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +     /* Tri-state value indicating state of link.
> > +      *  0 - Up
> > +      *  1 - Down
> > +      *  2 - Event - Requires checking as link state may have changed
> > +      */
> > +     s8 link_state;
>
> Maybe add an enum?

Doesn't that default to a 32b size? The general thought was to just
keep this small since it only needs to be a few bits.

> > +static irqreturn_t fbnic_mac_msix_intr(int __always_unused irq, void *=
data)
> > +{
> > +     struct fbnic_dev *fbd =3D data;
> > +     struct fbnic_net *fbn;
> > +
> > +     if (!fbd->mac->get_link_event(fbd)) {
> > +             fbnic_wr32(fbd, FBNIC_INTR_MASK_CLEAR(0),
> > +                        1u << FBNIC_MAC_MSIX_ENTRY);
> > +             return IRQ_HANDLED;
> > +     }
> > +
> > +     fbd->link_state =3D FBNIC_LINK_EVENT;
> > +     fbn =3D netdev_priv(fbd->netdev);
> > +
> > +     phylink_mac_change(fbn->phylink, fbd->link_state =3D=3D FBNIC_LIN=
K_UP);
>
> Can fbd->link_state =3D=3D FBNIC_LINK_UP given that you have just done:
>     fbd->link_state =3D FBNIC_LINK_EVENT ?

My bad. I will need to fix that. I think that was some fallout from an
earlier refactor.

> > +static u32 __fbnic_mac_config_asic(struct fbnic_dev *fbd)
> > +{
> > +     /* Enable MAC Promiscuous mode and Tx padding */
> > +     u32 command_config =3D FBNIC_MAC_COMMAND_CONFIG_TX_PAD_EN |
> > +                          FBNIC_MAC_COMMAND_CONFIG_PROMISC_EN;
> > +     struct fbnic_net *fbn =3D netdev_priv(fbd->netdev);
> > +     u32 rxb_pause_ctrl;
> > +
> > +     /* Set class 0 Quanta and refresh */
> > +     wr32(fbd, FBNIC_MAC_CL01_PAUSE_QUANTA, 0xffff);
> > +     wr32(fbd, FBNIC_MAC_CL01_QUANTA_THRESH, 0x7fff);
> > +
> > +     /* Enable generation of pause frames if enabled */
> > +     rxb_pause_ctrl =3D rd32(fbd, FBNIC_RXB_PAUSE_DROP_CTRL);
> > +     rxb_pause_ctrl &=3D ~FBNIC_RXB_PAUSE_DROP_CTRL_PAUSE_ENABLE;
> > +     if (!fbn->tx_pause)
> > +             command_config |=3D FBNIC_MAC_COMMAND_CONFIG_TX_PAUSE_DIS=
;
> > +     else
> > +             rxb_pause_ctrl |=3D
> > +                     FIELD_PREP(FBNIC_RXB_PAUSE_DROP_CTRL_PAUSE_ENABLE=
,
> > +                                FBNIC_PAUSE_EN_MASK);
> > +     wr32(fbd, FBNIC_RXB_PAUSE_DROP_CTRL, rxb_pause_ctrl);
> > +
> > +     if (!fbn->rx_pause)
> > +             command_config |=3D FBNIC_MAC_COMMAND_CONFIG_RX_PAUSE_DIS=
;
>
> Everybody gets pause wrong. To try to combat that it has mostly been
> moved into phylink. When phylink calls your mac_config() callback it
> passes const struct phylink_link_state *state. Within state is the
> pause member. That tells you how to configure the hardware. phylink
> will then deal with the differences between forced pause configuration
> and negotiated pause configuration, etc. Your current mac_config() is
> empty...
>
>         Andrew

So the pause setup for now is stored in fbn->[tr]x_pause. So if we
were to configure it via the mac_config call and then likely call into
this function. We end up having to reuse it in a few spots to avoid
having to read/modify the MAC register and instead just set the data
based on our stored config. Although I think we might be able to pare
this down as the command_config is the only piece we really need to
carry. The rest of this setup is essentially just a pause config which
could be done once instead of on every link up/down transition. I will
look at splitting this up.

