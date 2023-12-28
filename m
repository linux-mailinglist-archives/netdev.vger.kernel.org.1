Return-Path: <netdev+bounces-60445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D29FF81F5D6
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 09:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A7D1C21CDE
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 08:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985C64411;
	Thu, 28 Dec 2023 08:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ8y2jdm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021CB522B
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 08:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-554cffbad2fso3227952a12.1
        for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 00:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703751035; x=1704355835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZC/z8cldylp371oBNRFbQFI/QxYIEbRw9rFd4XSkacU=;
        b=QJ8y2jdmUKZut7H1zyvHZpzFYUPkSznOnyDofxyio1FaSQ6jDlEvt61QSuxh+JtynK
         n/6wklHxNF9gL2UCQm2EvT88Zbc1OVO5vhuBgzmY6lESlQIGTjMd7f1S5VRl9WhMZM8K
         n6G2ETvHpm3hOdedDTumQg+tgFEwH4eg3ZMY5GxrasjYgKDC4PxmpK+dLKzFkqvabipQ
         Ajm9xvIR05Zrq88UkYXoRLvplEw194eCMzWz6DjsH/GFl+TZPvkXVXOTffuYJeEJuhQl
         heaJJM9sVjh0io/woFZSKPgNKddJ0JTvesDJpLQtl0Zdym/zRLFNtd3FQs5G8MvMAWaG
         wxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703751035; x=1704355835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZC/z8cldylp371oBNRFbQFI/QxYIEbRw9rFd4XSkacU=;
        b=bpKziVZJ9tp1EHWxrNS0P1iYnmdV2z0nhsXwBMpIdIrxTm7bpDbLXqhhqo+fGmH7PK
         9rRWPiClpAq7MGACHj16hnc2t3TG2t9cDp0z12cu4KsDCeg1YXB1foRC/EW6zx14k3cT
         iggGcC34EQaMwcU8Qu75oGJncfJnM4+mnA8cBsNP5vfm2Xk1VMrew8byCTwVhf5noXUB
         jun/a4dP7gnqL8IeO20ALk5XdWGYUfIMHu+CS3F2YnJxf3vPEYlWrAwosGCJS7tnDoPT
         RcKsM+r1pe+hjQiy9CwvD+KMpotVOHZPlu0mgFit7DIatrvHvW1/wBCPSpH8wySl0CQY
         HQjg==
X-Gm-Message-State: AOJu0YyOIikVE8peZJjvijiKg4kHViPNUAWsphTKHAM0cUfxIovhXAZQ
	Hmuf+b2gmalHpBX6uXc67xQYTPoCcXn+o+xoZLo=
X-Google-Smtp-Source: AGHT+IGlQcFSG/INAGbdv/l1oie6h0gkx3vWBv+rQdUcFs40egJyvkp4/rz41CJgeOoa6BXtx7/obE8fm9g7u69aYMQ=
X-Received: by 2002:a17:906:281:b0:a26:e230:3b4f with SMTP id
 1-20020a170906028100b00a26e2303b4fmr2207933ejf.181.1703751035081; Thu, 28 Dec
 2023 00:10:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <55c522f9-503e-4adf-84cc-1ccc1fb45a9b@broadcom.com>
 <20231227120601.735527-1-adriancinal1@gmail.com> <4b3d4c59-70d8-41b7-954e-8f7294026516@gmail.com>
In-Reply-To: <4b3d4c59-70d8-41b7-954e-8f7294026516@gmail.com>
From: Adrian Cinal <adriancinal1@gmail.com>
Date: Thu, 28 Dec 2023 09:10:25 +0100
Message-ID: <CAPxJ3Bd1hPpAMXs1-o3CQcQ2H3XTaH_Z4GEpfvAa-0XnZMS0Xg@mail.gmail.com>
Subject: Re: [PATCH v2] net: bcmgenet: Fix FCS generation for fragmented skbuffs
To: Doug Berger <opendmb@gmail.com>
Cc: netdev@vger.kernel.org, florian.fainelli@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Dec 2023 at 21:39, Doug Berger <opendmb@gmail.com> wrote:
>
> On 12/27/2023 4:04 AM, Adrian Cinal wrote:
> > The flag DMA_TX_APPEND_CRC was written to the first (instead of the last)
> > DMA descriptor in the TX path, with each descriptor corresponding to a
> > single skbuff fragment (or the skbuff head). This led to packets with no
> > FCS appearing on the wire if the kernel allocated the packet in fragments,
> > which would always happen when using PACKET_MMAP/TPACKET
> > (cf. tpacket_fill_skb() in af_packet.c).
> >
> > Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
> > Signed-off-by: Adrian Cinal <adriancinal1@gmail.com>
> > ---
> >   drivers/net/ethernet/broadcom/genet/bcmgenet.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> > index 1174684a7f23..df4b0e557c76 100644
> > --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> > +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> > @@ -2137,16 +2137,16 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
> >               len_stat = (size << DMA_BUFLENGTH_SHIFT) |
> >                          (priv->hw_params->qtag_mask << DMA_TX_QTAG_SHIFT);
> >
> > -             /* Note: if we ever change from DMA_TX_APPEND_CRC below we
> > -              * will need to restore software padding of "runt" packets
> > -              */
> >               if (!i) {
> > -                     len_stat |= DMA_TX_APPEND_CRC | DMA_SOP;
> > +                     len_stat |= DMA_SOP;
> >                       if (skb->ip_summed == CHECKSUM_PARTIAL)
> >                               len_stat |= DMA_TX_DO_CSUM;
> >               }
> > +             /* Note: if we ever change from DMA_TX_APPEND_CRC below we
> > +              * will need to restore software padding of "runt" packets
> > +              */
> >               if (i == nr_frags)
> > -                     len_stat |= DMA_EOP;
> > +                     len_stat |= DMA_TX_APPEND_CRC | DMA_EOP;
> >
> >               dmadesc_set(priv, tx_cb_ptr->bd_addr, mapping, len_stat);
> >       }
> Hmm... this is a little surprising since the documentation is actually
> pretty specific that the hardware signal derived from this flag be set
> along with the SOP signal.
>
> Based on that I think I would prefer the flag to be set for all
> descriptors of a packet rather than just the last, but let me look into
> this a little further.
>
> Thanks for bringing this to my attention,
>      Doug

Hello,

I confirm that it works just as well when the flag is set for all
descriptors rather than just the last. Tested on a BCM2711.

Adrian

