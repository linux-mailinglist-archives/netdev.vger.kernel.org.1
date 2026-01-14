Return-Path: <netdev+bounces-249715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D57D1C82D
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 05:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C40E531420DA
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 04:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C78633B6E7;
	Wed, 14 Jan 2026 04:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HRWqUjCX"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC9A3148A7;
	Wed, 14 Jan 2026 04:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768365529; cv=none; b=CtVG+qRqJTCD2pFfKS0rqDIswbfiu29Aoe3sw31wOe68xs+T5NNON1mftpplHoGubZAyaai2Vla1U2XOeSdFn0eVqZxkojsP0QlTXujwU9M41i070oxgFj+VOY0PLK0nOxPPqm1UtZgWWSFe1eC+yI4EPfmFEMIjs+TQyQTWSV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768365529; c=relaxed/simple;
	bh=waGktRynmEAKPxPGyRZhdS4wyYXoYm1+orS9JkhrGtc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iOFGpTMnzDTh4PmxxbVk4ksiOlzaj31TjOJnY2uMyTCB3sfXYMEXfTsxU7DgZmDB0zDlnjkO1dR0e6W5rCCUyBtaBRn1BZQzYB4Ltjt4Ycf3WNT/KZ0juNYm7Em9oq5gPVmyqhGSrJSZSljNsm299P3T36q5hfuTJHziPdKN77A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HRWqUjCX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60E4cHydD246023, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768365497; bh=N9qECJelHclNik9YaZMGBY0BoSqKv1hRKOPBoa0z8Ns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=HRWqUjCXUstnUM/T3d3qkBxSWlhLFgNVrsxo5+tQUza5zyB9BIJEQgAfnCS+Wkius
	 EyvzXbuesrorKzM0GoSILcECyvfDQtGXzOm3suxL+x72f5Q89ed19DRML08nwlNplZ
	 SPwZVJVZWDFoe1dsENe310gIlTiDH9hed8FnTVKrUE08mboHjCP+2TQsuY607JbBFm
	 KGGN+nmnWI+v1fOctKX4GCPBMhdZ/tGz28eu6hBnz06l+E5D9bDiLOm8QJaT542COd
	 Xrq83YnMx8JtMI+Fv6voqIL84P293XEAPb323tSy/lH4u+G0xzRTHy/zeqjmMqEfxM
	 7iMtqNh2OXOzA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60E4cHydD246023
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 12:38:17 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 12:38:16 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([fe80::8bac:ef80:dea8:91d5]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::8bac:ef80:dea8:91d5%9]) with mapi id
 15.02.1748.010; Wed, 14 Jan 2026 12:38:16 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: insyelu <insyelu@gmail.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        nic_swsd <nic_swsd@realtek.com>, "tiwai@suse.de" <tiwai@suse.de>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: usb: r8152: fix transmit queue timeout
Thread-Topic: [PATCH] net: usb: r8152: fix transmit queue timeout
Thread-Index: AQHchQGLBs/iMEigv0CwXIii7EgMTLVRErBA
Date: Wed, 14 Jan 2026 04:38:16 +0000
Message-ID: <3501a6e902654554b61ab5cd89dcb0dd@realtek.com>
References: <20260114025622.24348-1-insyelu@gmail.com>
In-Reply-To: <20260114025622.24348-1-insyelu@gmail.com>
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

insyelu <insyelu@gmail.com>
> Sent: Wednesday, January 14, 2026 10:56 AM
[...]
> When the TX queue length reaches the threshold, the netdev watchdog
> immediately detects a TX queue timeout.
>=20
> This patch updates the transmit queue's trans_start timestamp upon
> completion of each asynchronous USB URB submission on the TX path,
> ensuring the network watchdog correctly reflects ongoing transmission
> activity.
>=20
> Signed-off-by: insyelu <insyelu@gmail.com>
> ---
>  drivers/net/usb/r8152.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index fa5192583860..afec602a5fdb 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -1954,6 +1954,8 @@ static void write_bulk_callback(struct urb *urb)
>=20
>         if (!skb_queue_empty(&tp->tx_queue))
>                 tasklet_schedule(&tp->tx_tl);
> +
> +       netif_trans_update(netdev);
>  }

Based on the definition of netif_trans_update(), I think it would be better=
 to move it into tx_agg_fill().
Such as

--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -2449,6 +2449,8 @@ static int r8152_tx_agg_fill(struct r8152 *tp, struct=
 tx_agg *agg)
        ret =3D usb_submit_urb(agg->urb, GFP_ATOMIC);
        if (ret < 0)
                usb_autopm_put_interface_async(tp->intf);
+       else
+               netif_trans_update(tp->netdev);

 out_tx_fill:
        return ret;

Best Regards,
Hayes


