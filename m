Return-Path: <netdev+bounces-199664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD61AE146F
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 08:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38B83AE86B
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 06:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E33A224B06;
	Fri, 20 Jun 2025 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="m+/I4wZR"
X-Original-To: netdev@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4706017E;
	Fri, 20 Jun 2025 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750402743; cv=none; b=JRLNJRmlvjOhTWk6JhvS+WEMLm2l5b+reJoNMtOJjje0LYbCx1OKaXSpGVZPQBt/Gea2kPv8xTWskYUTW42vJNEBdKXCan9Tp2YiXyNB/PFZfevAwadoIGTP9NPR6v67JfhnjScbu7Nc+z791Sbj0EsL6uSIeJonx7k/ZxUjY8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750402743; c=relaxed/simple;
	bh=xvmfCr3MUimdze413yuYKOxxXmtG+gIayHmwTGC81cs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=nKDVwGZ4LoSfDTLd5PWkLzJZLesPHhCq/MiJ80n5oqDdfJ5UItu5m3YNJKA3OpZGqomO29a9LxyLXMID985W3n1IGYeuJ8FDxQsSJWyahjDRqtOlcZrjVVesQnah6p8tzTCjx36PoS32lj8R4dFj3HoOeBorlXYmUJK4hha3X84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=m+/I4wZR; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=m+/I4wZR;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10de:2e00:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 55K6kPYe3551040
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 07:46:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1750401985; bh=DceUHKn3HLA3crwE6S+F2oi2qQFk/ihZKyh0elu8AMs=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=m+/I4wZRvYpRVt7T8KzqnUKiivmtuetSXwtmVOcB1jEGwWth87arW4uOLfvc8LcCb
	 ePPg9Kr+pYcm4Wf4AqXeO47UlDuLypkRO+HVANJwX1d36b+Ca3TWWVY58E3ewMQNB7
	 Cw51fHVCcDXCzgh93sXMclUcBVBxsRgk37il4ITg=
Received: from miraculix.mork.no ([IPv6:2a01:799:10de:2e0a:149a:2079:3a3a:3457])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 55K6kOmr3974318
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 20 Jun 2025 08:46:25 +0200
Received: (nullmailer pid 136670 invoked by uid 1000);
	Fri, 20 Jun 2025 06:46:24 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: dataonline <dataonline@foxmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, Xiaowei Li <xiaowei.li@simcom.com>
Subject: Re: [PATCH] net: usb: qmi_wwan: add SIMCom 8230C composition
Organization: m
References: <tencent_21D781FAA4969FEACA6ABB460362B52C9409@qq.com>
Date: Fri, 20 Jun 2025 08:46:24 +0200
In-Reply-To: <tencent_21D781FAA4969FEACA6ABB460362B52C9409@qq.com>
	(dataonline@foxmail.com's message of "Fri, 20 Jun 2025 10:27:02
	+0800")
Message-ID: <87cyayuczj.fsf@miraculix.mork.no>
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

dataonline <dataonline@foxmail.com> writes:

> From: Xiaowei Li <xiaowei.li@simcom.com>
>
> Add support for SIMCom 8230C which is based on Qualcomm SDX35 chip.
> 0x9071: tty (DM) + tty (NMEA) + tty (AT) + rmnet
> T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D05 Cnt=3D02 Dev#=3D  8 Spd=3D480  =
MxCh=3D 0
> D:  Ver=3D 2.00 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D1e0e ProdID=3D9071 Rev=3D 5.15
> S:  Manufacturer=3DSIMCOM
> S:  Product=3DSDXBAAGHA-IDP _SN:D744C4C5
> S:  SerialNumber=3D0123456789ABCDEF
> C:* #Ifs=3D 5 Cfg#=3D 1 Atr=3Da0 MxPwr=3D500mA
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3D30 Driver=
=3Doption
> E:  Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D00 Prot=3D00 Driver=
=3Doption
> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 2 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3D40 Driver=
=3Doption
> E:  Ad=3D84(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D32ms
> E:  Ad=3D83(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:  Ad=3D03(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 3 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3D50 Driver=
=3Dqmi_wwan
> E:  Ad=3D86(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D32ms
> E:  Ad=3D85(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> I:* If#=3D 4 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D42 Prot=3D01 Driver=
=3Dnone
> E:  Ad=3D05(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> E:  Ad=3D87(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
>
> Signed-off-by: Xiaowei Li <xiaowei.li@simcom.com>
> ---
>  drivers/net/usb/qmi_wwan.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
> index b586b1c13a47..f5647ee0adde 100644
> --- a/drivers/net/usb/qmi_wwan.c
> +++ b/drivers/net/usb/qmi_wwan.c
> @@ -1426,6 +1426,7 @@ static const struct usb_device_id products[] =3D {
>  	{QMI_QUIRK_SET_DTR(0x22de, 0x9051, 2)}, /* Hucom Wireless HM-211S/K */
>  	{QMI_FIXED_INTF(0x22de, 0x9061, 3)},	/* WeTelecom WPD-600N */
>  	{QMI_QUIRK_SET_DTR(0x1e0e, 0x9001, 5)},	/* SIMCom 7100E, 7230E, 7600E +=
+ */
> +	{QMI_QUIRK_SET_DTR(0x1e0e, 0x9071, 3)},	/* SIMCom 8230C ++ */
>  	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0121, 4)},	/* Quectel EC21 Mini PCIe */
>  	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0191, 4)},	/* Quectel EG91 */
>  	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0195, 4)},	/* Quectel EG95 */

Acked-by: Bj=C3=B8rn Mork <bjorn@mork.no>

