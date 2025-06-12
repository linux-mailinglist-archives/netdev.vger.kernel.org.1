Return-Path: <netdev+bounces-196794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9358AD660F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 05:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7D777AA9F6
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 03:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21C21DDC07;
	Thu, 12 Jun 2025 03:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ekU8C/ws"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5081E18D;
	Thu, 12 Jun 2025 03:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749698054; cv=none; b=F4kpoKsEWsrPFVZ3KWdikDHuT9C1axn2x0GxVgJcNIoLfSJ6JwnfMg2bQU4geAOUQJxnc9/V5vP52pwC1exXP9EFQDohkh1Tvnfi5qwce/pIlWAgny1MuKcahPhQ6cJ3T8hKcflI/mGFDOsQ+TN3AVO1D0CaVjFKyVJSTm+6yic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749698054; c=relaxed/simple;
	bh=tF98iIuxDOq4aFCTGkMt7XE4xgsy5S6eAFSZibVgTk4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nleLjdbvuhGf27CP912uL8JO9sDBw+g8ujIC3I10PmneQRtDemC44VhCqHqX29aflVCLCmGpwjzyQGgzzItvoMen1V4kYJT6hThO0nRR1+aE/gZPjNt9tNuwUqu3NAAGU9aAD4MAHRQZE92XKJElNqNKE82GqWxKLVGJOZVNL40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ekU8C/ws; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55C3DXvzC1825952, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749698013; bh=ILkh8wYA5EhlBYGr8kJIxUe2DIRkeTB38TC7zInjTJE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ekU8C/wsb2pGdiZyTjL6638gyXFQJeVj7I5lVx7T5UEWegwavo3jK+lls1CmupRIo
	 zAoGaCFYEafJFjbpLZwghUGoJdt4PTOuRJ/TPW2xUP1DdV0xAB5HzusLlR6ooAz2gE
	 Oh8X3Cfx4QtZUjsZ94kgREDndnSTQU1mSPPJT4236SQhJg7nYpCU8meW1OO4QTzfRL
	 ZuYKg1XtSB02GSJux9OHzdBsaZ7JR1CqynqtNmb+YdNIxFRPY92HYm450AzP0m+BR3
	 VLySGTpgNVEVasZbd5rXh8BF3tFcih8fAlRGXdtiV140YfEYTddYwxvfkp0vuN1ZQS
	 F25/JAkfmak+w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55C3DXvzC1825952
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 11:13:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Jun 2025 11:13:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 12 Jun 2025 11:13:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 12 Jun 2025 11:13:32 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Joe Damato <joe@dama.to>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "horms@kernel.org" <horms@kernel.org>,
        "jdamato@fastly.com" <jdamato@fastly.com>,
        Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next 1/2] rtase: Link IRQs to NAPI instances
Thread-Topic: [PATCH net-next 1/2] rtase: Link IRQs to NAPI instances
Thread-Index: AQHb2fM5jESWV4w0S0S8H02icTqIGrP9dfaAgAFlkYA=
Date: Thu, 12 Jun 2025 03:13:32 +0000
Message-ID: <72547c5443424151860d808616fdcc23@realtek.com>
References: <20250610103334.10446-1-justinlai0215@realtek.com>
 <20250610103334.10446-2-justinlai0215@realtek.com>
 <aEmJ-b8ogdb3U5M4@MacBook-Air.local>
In-Reply-To: <aEmJ-b8ogdb3U5M4@MacBook-Air.local>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> On Tue, Jun 10, 2025 at 06:33:33PM +0800, Justin Lai wrote:
> > Link IRQs to NAPI instances with netif_napi_set_irq. This information
> > can be queried with the netdev-genl API.
> >
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > ---
> >  .../net/ethernet/realtek/rtase/rtase_main.c   | 20 +++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > index 4d37217e9a14..a88af868da8c 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > @@ -1871,6 +1871,18 @@ static void rtase_init_netdev_ops(struct
> net_device *dev)
> >       dev->ethtool_ops =3D &rtase_ethtool_ops;  }
> >
> > +static void rtase_init_napi(struct rtase_private *tp) {
> > +     u16 i;
> > +
> > +     for (i =3D 0; i < tp->int_nums; i++) {
> > +             netif_napi_add(tp->dev, &tp->int_vector[i].napi,
> > +                            tp->int_vector[i].poll);
>=20
> Maybe netif_napi_add_config can be used either in this patch or in an add=
ed
> 3rd patch to this series to support persitent NAPI config?
>=20
> Otherwise:
>=20
> Reviewed-by: Joe Damato <joe@dama.to>

Hi Joe,

Thank you for your suggestion. I will make the change in this patch in v2.

Thanks,
Justin
>=20
> > +             netif_napi_set_irq(&tp->int_vector[i].napi,
> > +                                tp->int_vector[i].irq);
> > +     }
> > +}
> > +
> >  static void rtase_reset_interrupt(struct pci_dev *pdev,
> >                                 const struct rtase_private *tp)
> { @@
> > -1956,9 +1968,6 @@ static void rtase_init_int_vector(struct rtase_priva=
te
> *tp)
> >       memset(tp->int_vector[0].name, 0x0,
> sizeof(tp->int_vector[0].name));
> >       INIT_LIST_HEAD(&tp->int_vector[0].ring_list);
> >
> > -     netif_napi_add(tp->dev, &tp->int_vector[0].napi,
> > -                    tp->int_vector[0].poll);
> > -
> >       /* interrupt vector 1 ~ 3 */
> >       for (i =3D 1; i < tp->int_nums; i++) {
> >               tp->int_vector[i].tp =3D tp; @@ -1972,9 +1981,6 @@ static
> > void rtase_init_int_vector(struct rtase_private *tp)
> >               memset(tp->int_vector[i].name, 0x0,
> >                      sizeof(tp->int_vector[0].name));
> >               INIT_LIST_HEAD(&tp->int_vector[i].ring_list);
> > -
> > -             netif_napi_add(tp->dev, &tp->int_vector[i].napi,
> > -                            tp->int_vector[i].poll);
> >       }
> >  }
> >
> > @@ -2206,6 +2212,8 @@ static int rtase_init_one(struct pci_dev *pdev,
> >               goto err_out_del_napi;
> >       }
> >
> > +     rtase_init_napi(tp);
> > +
> >       rtase_init_netdev_ops(dev);
> >
> >       dev->pcpu_stat_type =3D NETDEV_PCPU_STAT_TSTATS;
> > --
> > 2.34.1
> >
> >

