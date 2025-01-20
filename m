Return-Path: <netdev+bounces-159850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C035EA172A5
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 19:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D409B3A4B42
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 18:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359A91EC01B;
	Mon, 20 Jan 2025 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="UetI3pAF"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF46C7DA82;
	Mon, 20 Jan 2025 18:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737397311; cv=none; b=BNMbjG4NrlHP/B2h56p4YCreRHWvMJ8CWotWShl7ky679zzj4pd+RTm3VnODjNZIJPQ/WgpB3Xv/R1twqQXCcCcgne2izWQc2AM3siYMYrN1/ikZB4QSXaUy8JYQFxcYVJDQAo166Rf1h7lMSthOYYbPPlRM7fAQhOLW1HGpFxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737397311; c=relaxed/simple;
	bh=75+y9VRI0AcjFYRn142inkgb2Cf5kwS6s6t3LjvJwxg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FHIj0YQrfdzBxp11WAYBRsYqhV/pqBMkLGz7V3giamk7m9h9IJIIoxW9emWR1RKStGi0FsIbBcqsFFhJYPy4PPT1lH+8EvMikHjpLs130haZBQXFz+eXXyP4ApuxdqxjPDa0icWDLyzNpIQ4LpmVvzO0eS26uW9OcpFfb84D1fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=UetI3pAF; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=UetI3pAF;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10de:2e00:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 50KI6qLF544745
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 18:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1737396412; bh=QT48Yp+2YKfpBOx4u4hbSOgzHHfcz0yJPq8nWCTQky0=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=UetI3pAFyIIwtPJAZkLncqRhLPDFAkRMiFu5mtktHcprfPQRzDd2+lJYlt6ab8HpM
	 kJOdQQ19RJH7goe/nm4OJpZXUX8gAKVLAIhMz+Wf8U2AzA3tJh86frUhj3Mok0ypv2
	 GdhAJeJAA8aNXiasFJWrjlHLDAqae3GI5jRD87hw=
Received: from miraculix.mork.no ([IPv6:2a01:799:10de:2e0a:149a:2079:3a3a:3457])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 50KI6q2R1765217
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2025 19:06:52 +0100
Received: (nullmailer pid 1023790 invoked by uid 1000);
	Mon, 20 Jan 2025 18:06:52 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Jakub Kicinski <kuba@kernel.org>, Daniele Palmas <dnlplm@gmail.com>,
        Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] net: usb: qmi_wwan: Add error handling for
 usbnet_get_ethernet_addr
Organization: m
References: <20250120170026.1880-1-vulab@iscas.ac.cn>
Date: Mon, 20 Jan 2025 19:06:52 +0100
In-Reply-To: <20250120170026.1880-1-vulab@iscas.ac.cn> (Wentao Liang's message
	of "Tue, 21 Jan 2025 01:00:26 +0800")
Message-ID: <87y0z52wcj.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.0.7 at canardo.mork.no
X-Virus-Status: Clean

Wentao Liang <vulab@iscas.ac.cn> writes:

> In qmi_wwan_bind(), usbnet_get_ethernet_addr() is called
> without error handling, risking unnoticed failures and
> inconsistent behavior compared to other parts of the code.
>
> Fix this issue by adding an error handling for the
> usbnet_get_ethernet_addr(), improving code robustness.
>
> Fixes: 423ce8caab7e ("net: usb: qmi_wwan: New driver for Huawei QMI based=
 WWAN devices")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/usb/qmi_wwan.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
> index e9208a8d2bfa..7aa576bfe76b 100644
> --- a/drivers/net/usb/qmi_wwan.c
> +++ b/drivers/net/usb/qmi_wwan.c
> @@ -779,7 +779,9 @@ static int qmi_wwan_bind(struct usbnet *dev, struct u=
sb_interface *intf)
>  	/* errors aren't fatal - we can live with the dynamic address */
>  	if (cdc_ether && cdc_ether->wMaxSegmentSize) {
>  		dev->hard_mtu =3D le16_to_cpu(cdc_ether->wMaxSegmentSize);
> -		usbnet_get_ethernet_addr(dev, cdc_ether->iMACAddress);
> +		status =3D usbnet_get_ethernet_addr(dev, cdc_ether->iMACAddress);
> +		if (status < 0)
> +			goto err;
>  	}
>=20=20
>  	/* claim data interface and set it up */



Did you read the comment?

This intentinonally ignores any errors.  I don't know how to make it
clear anough for these AI bots to understand.  Any advice there?


NAK

(and why weren't I CCed?  Noticed this by chance only...)


Bj=C3=B8rn

