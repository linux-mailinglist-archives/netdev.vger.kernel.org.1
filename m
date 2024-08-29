Return-Path: <netdev+bounces-123424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F02964D2E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 19:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD14281084
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 17:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FDC1B78FB;
	Thu, 29 Aug 2024 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsqwQ0Qv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC594D8C1;
	Thu, 29 Aug 2024 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953634; cv=none; b=ULwSQAeELjTT5Fbi2AaIMoAk46oMejRyTxqFKx9GjGo5iUeU5949vPJFfYF/i7h/rp1V5901UFaYFeuycsiVcPRGb2iE7TeSqoRSAY8w7ck1jGV20zIl7B6So/mDlXLTZu18/ENyCBYNKvrRoPYfjDOqs6BZ8d+4c7Y52wgKgWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953634; c=relaxed/simple;
	bh=CmJVtsejJR2U2bMeFQyvuS6X7TF7Wgj9D94UVByyyz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Edgqqm6bSoxzuIKp5gB00T1kHz5nu58rz2fHhUpLRm9CeB5hzvULBUNkanW4PSoQBjW7tvtsNtgxAc8TjOGnWNkhwkDexhrWq7eKH0vhsV9EOOYcVUAyqH6PbHuOnFMSfzradBTMsoDrzJD8Rdc2kQq6eUWfIo7r+MHH6oubgtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsqwQ0Qv; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6b6b9867f81so7798697b3.1;
        Thu, 29 Aug 2024 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724953632; x=1725558432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLixMIoBTTrAveSTWYwxxs5otwvP/T2C1DabRuOMDx8=;
        b=UsqwQ0QvY/oCs9zaF5LvARkDxF9xygUNgP9IeXta82kDAgaWS0di1s5udSDKyc+aUy
         /gxUDL+KTOM0YdummwS8j1IO5dtFUGvG1jQWHU7tvdKSquANO22LVESUFQVZ7Xa3EPWK
         XZlRk/iqG/8tVCybFp9/xGkvEs70rSjTnzKhjKPtWg5kcZ3bOa9OWdLKgO7/08feuY8C
         RcEuoV4G1gfNIQ/k8R3+cJaOlFGV3oO6SFkWt/VcaPq32vFWioHxIOHrDt1I7vIhyj/T
         pxaSqHJrWRUljtYpdmFNEHCAxPFdBKOFqEu9G8IzHcT0B+0z0ATq2WcF6XMhfXtgBj8O
         g9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724953632; x=1725558432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLixMIoBTTrAveSTWYwxxs5otwvP/T2C1DabRuOMDx8=;
        b=AjxvPksw+oGz/ossNPtG1CDpBG4Hxsr3B305ysdcwT+MKUjcu0qtUx5SLS5VHpHbAt
         xdxYkO3YlcngQxQg53qhk4BKVVBHD8wGoyTZynRCvEjXQNdTHCyap1pK7MR/AxH6soeM
         EykHwBvcoGjCTpLsNAOV3ZWv565jQ5tiaD1H/VAtjq4ayIW26g7jIFCI1b1b+4y+/+9x
         uSH8xe9eZwBX6mg8GxXJuFfyZpkvx/mhgh32W0PPD4d3RquhDemrDQaPrLYaXYxRTHJN
         /EbRuuhMUDp8Hlvy5jwMO6QGgb7/V+BxDQ1H5TxN5oXhQpoZEMqwVrY2Is0ApD7fBxRu
         jahg==
X-Forwarded-Encrypted: i=1; AJvYcCWBC6sul/zXKkGzQ2LkjUEtAxPc0ApYBPXqghHudksp8KRZjDV9EhZkEJK7NIb0V9fzSV7KwYCemrrx8mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkyacAy+iNmHHmxBHahOBN9iAJ4Fa+OXexRzCjh9Ydf0sjmoYd
	3qsD94EmbyruU2yRHVJ1FlVlrNsCVuQU4irEtWQXQRpZTaBR1i7afjRXN3SgGmFViCh2D8bvqxd
	slfLxvPndE8G8N7HnFq1KcTdM+8U=
X-Google-Smtp-Source: AGHT+IEC/qGd5rTqMheyI8JSH2ICalSWzrh8xBdFCsokE7a5pDeIZzjQgPZpABKUtwMS5MazAtx+g04FM8V3aVEhyyU=
X-Received: by 2002:a05:690c:4603:b0:61b:3364:d193 with SMTP id
 00721157ae682-6d278149504mr32514257b3.40.1724953631710; Thu, 29 Aug 2024
 10:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828223931.153610-1-rosenp@gmail.com> <20240829165234.GV1368797@kernel.org>
In-Reply-To: <20240829165234.GV1368797@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 29 Aug 2024 10:47:01 -0700
Message-ID: <CAKxU2N8j5Fw1spACmNyWniKGpSWtMt0H3KY5JZj5zYaA0c69kA@mail.gmail.com>
Subject: Re: [PATCHv2 net-next] net: ag71xx: update FIFO bits and descriptions
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, 
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de, p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 9:52=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Wed, Aug 28, 2024 at 03:38:47PM -0700, Rosen Penev wrote:
> > Taken from QCA SDK. No functional difference as same bits get applied.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  v2: forgot to send to netdev
> >  drivers/net/ethernet/atheros/ag71xx.c | 48 +++++++++++++--------------
> >  1 file changed, 24 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethern=
et/atheros/ag71xx.c
> > index db2a8ade6205..692dbded8211 100644
> > --- a/drivers/net/ethernet/atheros/ag71xx.c
> > +++ b/drivers/net/ethernet/atheros/ag71xx.c
> > @@ -149,11 +149,11 @@
> >  #define FIFO_CFG4_MC         BIT(8)  /* Multicast Packet */
> >  #define FIFO_CFG4_BC         BIT(9)  /* Broadcast Packet */
> >  #define FIFO_CFG4_DR         BIT(10) /* Dribble */
> > -#define FIFO_CFG4_LE         BIT(11) /* Long Event */
> > -#define FIFO_CFG4_CF         BIT(12) /* Control Frame */
> > -#define FIFO_CFG4_PF         BIT(13) /* Pause Frame */
> > -#define FIFO_CFG4_UO         BIT(14) /* Unsupported Opcode */
> > -#define FIFO_CFG4_VT         BIT(15) /* VLAN tag detected */
> > +#define FIFO_CFG4_CF         BIT(11) /* Control Frame */
> > +#define FIFO_CFG4_PF         BIT(12) /* Pause Frame */
> > +#define FIFO_CFG4_UO         BIT(13) /* Unsupported Opcode */
> > +#define FIFO_CFG4_VT         BIT(14) /* VLAN tag detected */
> > +#define FIFO_CFG4_LE         BIT(15) /* Long Event */
> >  #define FIFO_CFG4_FT         BIT(16) /* Frame Truncated */
> >  #define FIFO_CFG4_UC         BIT(17) /* Unicast Packet */
> >  #define FIFO_CFG4_INIT       (FIFO_CFG4_DE | FIFO_CFG4_DV | FIFO_CFG4_=
FC | \
> > @@ -168,28 +168,28 @@
> >  #define FIFO_CFG5_DV         BIT(1)  /* RX_DV Event */
> >  #define FIFO_CFG5_FC         BIT(2)  /* False Carrier */
> >  #define FIFO_CFG5_CE         BIT(3)  /* Code Error */
> > -#define FIFO_CFG5_LM         BIT(4)  /* Length Mismatch */
> > -#define FIFO_CFG5_LO         BIT(5)  /* Length Out of Range */
> > -#define FIFO_CFG5_OK         BIT(6)  /* Packet is OK */
> > -#define FIFO_CFG5_MC         BIT(7)  /* Multicast Packet */
> > -#define FIFO_CFG5_BC         BIT(8)  /* Broadcast Packet */
> > -#define FIFO_CFG5_DR         BIT(9)  /* Dribble */
> > -#define FIFO_CFG5_CF         BIT(10) /* Control Frame */
> > -#define FIFO_CFG5_PF         BIT(11) /* Pause Frame */
> > -#define FIFO_CFG5_UO         BIT(12) /* Unsupported Opcode */
> > -#define FIFO_CFG5_VT         BIT(13) /* VLAN tag detected */
> > -#define FIFO_CFG5_LE         BIT(14) /* Long Event */
> > -#define FIFO_CFG5_FT         BIT(15) /* Frame Truncated */
> > -#define FIFO_CFG5_16         BIT(16) /* unknown */
> > -#define FIFO_CFG5_17         BIT(17) /* unknown */
> > +#define FIFO_CFG5_CR         BIT(4)  /* CRC error */
> > +#define FIFO_CFG5_LM         BIT(5)  /* Length Mismatch */
> > +#define FIFO_CFG5_LO         BIT(6)  /* Length Out of Range */
> > +#define FIFO_CFG5_OK         BIT(7)  /* Packet is OK */
> > +#define FIFO_CFG5_MC         BIT(8)  /* Multicast Packet */
> > +#define FIFO_CFG5_BC         BIT(9)  /* Broadcast Packet */
> > +#define FIFO_CFG5_DR         BIT(10) /* Dribble */
> > +#define FIFO_CFG5_CF         BIT(11) /* Control Frame */
> > +#define FIFO_CFG5_PF         BIT(12) /* Pause Frame */
> > +#define FIFO_CFG5_UO         BIT(13) /* Unsupported Opcode */
> > +#define FIFO_CFG5_VT         BIT(14) /* VLAN tag detected */
> > +#define FIFO_CFG5_LE         BIT(15) /* Long Event */
> > +#define FIFO_CFG5_FT         BIT(16) /* Frame Truncated */
> > +#define FIFO_CFG5_UC         BIT(17) /* Unicast Packet */
> >  #define FIFO_CFG5_SF         BIT(18) /* Short Frame */
> >  #define FIFO_CFG5_BM         BIT(19) /* Byte Mode */
> >  #define FIFO_CFG5_INIT       (FIFO_CFG5_DE | FIFO_CFG5_DV | FIFO_CFG5_=
FC | \
> > -                      FIFO_CFG5_CE | FIFO_CFG5_LO | FIFO_CFG5_OK | \
> > -                      FIFO_CFG5_MC | FIFO_CFG5_BC | FIFO_CFG5_DR | \
> > -                      FIFO_CFG5_CF | FIFO_CFG5_PF | FIFO_CFG5_VT | \
> > -                      FIFO_CFG5_LE | FIFO_CFG5_FT | FIFO_CFG5_16 | \
> > -                      FIFO_CFG5_17 | FIFO_CFG5_SF)
> > +                      FIFO_CFG5_CE | FIFO_CFG5_LM | FIFO_CFG5_L0 | \
>
>                                                        FIFO_CFG5_LO
>
> > +                      FIFO_CFG5_OK | FIFO_CFG5_MC | FIFO_CFG5_BC | \
> > +                      FIFO_CFG5_DR | FIFO_CFG5_CF | FIFO_CFG5_UO | \
> > +                      FIFO_CFG5_VT | FIFO_CFG5_LE | FIFO_CFG5_FT | \
> > +                      FIFO_CFG5_UC | FIFO_CFG5_SF)
> >
> >  #define AG71XX_REG_TX_CTRL   0x0180
> >  #define TX_CTRL_TXE          BIT(0)  /* Tx Enable */
>
> Please consider a patch to allow compilation of this driver with
> COMPILE_TEST in order to increase build coverage.
Is that just

--- a/drivers/net/ethernet/atheros/Kconfig
+++ b/drivers/net/ethernet/atheros/Kconfig
@@ -6,7 +6,7 @@
 config NET_VENDOR_ATHEROS
        bool "Atheros devices"
        default y
-       depends on (PCI || ATH79)
+       depends on (PCI || ATH79 || COMPILE_TEST)
        help
          If you have a network (Ethernet) card belonging to this class, sa=
y Y.

@@ -19,7 +19,7 @@ if NET_VENDOR_ATHEROS

 config AG71XX
        tristate "Atheros AR7XXX/AR9XXX built-in ethernet mac support"
-       depends on ATH79
+       depends on ATH79 || COMPILE_TEST
        select PHYLINK
        imply NET_SELFTESTS
        help

>
> --
> pw-bot: cr

