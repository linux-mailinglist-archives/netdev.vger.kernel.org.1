Return-Path: <netdev+bounces-183906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42112A92C59
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 22:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2173189D8AC
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 20:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8680E2066C3;
	Thu, 17 Apr 2025 20:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lpmW0C9A"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD8241C63
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 20:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744922488; cv=none; b=cWMM+9rSVJa5eBHOZfpKqg8ggofdw5sXvD84BTbZuI8L/2ZzD12mUBHVwV75UHdnmz2Lt579ZBLi/d/FMPDUF1rvj17yIuav0YdsQAfo3jk3yhgKXNfneqSdZ9Fw3LfPwV7GC7KHH3iQgK19ol76c4GX7Fz8dz4O6d/1EgNAlVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744922488; c=relaxed/simple;
	bh=YV0j+2940rNbrDxs2aoJb2yIy53XY8OFt1FayGZbZpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFxu7zUaiQYaroGtv8A+b6Q4ErxDY03XNyHesEtdB/MBDeJEzQYldEcZ0ftGPsdt3i+22bIQXbwtVkJJ+K6h990RFmbnIKVg240FcrQGLpSBftJ5pof22hI/1LWyomWZHFrnLOOsOBECgRRrVCQ/0+321vbkBjlSwO3ECQJQfjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lpmW0C9A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HClJAg015469
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 20:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	87q4nGDDK9iMB8VIjTydhljXRNdE9XU/HwYUra0UGao=; b=lpmW0C9AuqHT6gcG
	ei67odV7YCEFdlTdVIV0e6fDukHGEkiC8POlcKmrgU9PSQYUGMEV/2oUBEmOf85+
	zMVktPn0kGx88nVZAZJCE+zYOkXHq9Ppvl0fx+LSmobELlyvFrTVqrbgXtuOGK5I
	yOkGXY/UbcHbtcsjYCTo7dHR8qyAf41osS2PkPFixogh9dZ6UOmFtah5y45mqajb
	gbEIdCEU1IXUn5iaEBg+8zSDJQ4W29ei/XFQCfa4VP1PuAbn2VGNBnh70canFXrE
	+SSYcN6mTnmejAUJVhAVaO7rm9QQ64pSvo4VwunvYDJ5mW95bnBqwt417KEy5Ehq
	069ZKA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ydhqgdun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 20:41:25 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e91ee078aaso19503226d6.3
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 13:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744922484; x=1745527284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87q4nGDDK9iMB8VIjTydhljXRNdE9XU/HwYUra0UGao=;
        b=CKMxmre3rdkWEJf39N4TlEGlgtwkwRdohzMWSDzQjN+IoyjUJ0GTW21h0gNB9nabXQ
         LOB2Rj4Z2Fk6h50GMZPNlwDVB5Y8wVmJkF8O7DCSXUmxmbclbMjAIQo1L7oJj0hsTLvq
         r/O6UGVpigLXuqk8E0HZpppekisL+umbHe5lyjerFma5u8XspUx+UCYPCOsM/m1zS2l0
         +xATq2Z5x/6YRWBF3fUiuTmIOuV5hDeLx+Yo68QLchyfvq6c5U4cbjsBcAuH6a8T6AI7
         /mzbZaY1+J3fnnWf8F3KxVvmd1kKOD4PtCH5vtNTS0xISSjrTcMVQnyxJpTuH5mYOWOX
         390A==
X-Forwarded-Encrypted: i=1; AJvYcCVNjYgs2Ah8hBawz2oDYvbUX2trSA3W2CTemuv4xIzx0sUstVWAI9VWC6iGSibC1gqU7CzSUqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8etVgk6qW5q9iVMxan+4EqQmp7UZaR2mQJfVnEmpdYCgQ8T1B
	kwD2flh9FAG8qNYzpczFnAM1wdrfv6s5Q8T/uXgtATczDveW8low1KtJclk1ukneMnxKPD9U9hm
	Ij9RaKqVOP7sAeJac+xTC/aCC4UQtjrPLse4quu1aYDfpYN0/dwl8Jm5ohuLeYnVS/tKhgHaYOM
	7YieqReCL7ab2bJb+RmzekDxDX/gqHCA==
X-Gm-Gg: ASbGncuC05QPZDZKd+hiLkaolHJJH+3hL0CdA2p93DsgmLU2no/bR8QOIShpRTO4h8C
	Bb2n+Hdz4MDF2bewGXwvY1XzX1znL2RAOSnhb2nSSP8hpSnnFdvvYA8SUZ20hpLGpHiYDqA==
X-Received: by 2002:a05:6214:20a8:b0:6e6:9ce0:da9d with SMTP id 6a1803df08f44-6f2c45c16cbmr7787466d6.27.1744922484512;
        Thu, 17 Apr 2025 13:41:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM9KLWiXss4PZ0j+1axYjEMMjruwRe//wUCG0+98dPYBlIEY3S4xcpZyw8o19U+9ZylE7ohCeElm8jte4bmvE=
X-Received: by 2002:a05:6214:20a8:b0:6e6:9ce0:da9d with SMTP id
 6a1803df08f44-6f2c45c16cbmr7787026d6.27.1744922484189; Thu, 17 Apr 2025
 13:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408233118.21452-1-ryazanov.s.a@gmail.com> <20250408233118.21452-5-ryazanov.s.a@gmail.com>
In-Reply-To: <20250408233118.21452-5-ryazanov.s.a@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 22:41:12 +0200
X-Gm-Features: ATxdqUF7uKY6kCY3rHE2Z6p2CHbBySjq3f39LUO405mdoQI4PiXmVFn_7tfr7wQ
Message-ID: <CAFEp6-2cfVnpr9A6YOjLO-tpPTs-5jdifHOmHupc83KFZ=8UcQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/6] net: wwan: add NMEA port support
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, Slark Xiao <slark_xiao@163.com>,
        Muhammad Nuzaihan <zaihan@unrealasia.net>,
        Qiang Yu <quic_qianyu@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: zHdk6rlzNOz1ooZV-o5YH7zuEp-IOET6
X-Authority-Analysis: v=2.4 cv=C7DpyRP+ c=1 sm=1 tr=0 ts=68016775 cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=Byx-y9mGAAAA:8 a=mThdVl9iAAAA:8 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1QFdTqWNd3_e8Pa_3EkA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=GbkGdI2Iuv6_No-W-q0B:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: zHdk6rlzNOz1ooZV-o5YH7zuEp-IOET6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170152

On Wed, Apr 9, 2025 at 1:31=E2=80=AFAM Sergey Ryazanov <ryazanov.s.a@gmail.=
com> wrote:
>
> Many WWAN modems come with embedded GNSS receiver inside and have a
> dedicated port to output geopositioning data. On the one hand, the
> GNSS receiver has little in common with WWAN modem and just shares a
> host interface and should be exported using the GNSS subsystem. On the
> other hand, GNSS receiver is not automatically activated and needs a
> generic WWAN control port (AT, MBIM, etc.) to be turned on. And a user
> space software needs extra information to find the control port.
>
> Introduce the new type of WWAN port - NMEA. When driver asks to register
> a NMEA port, the core allocates common parent WWAN device as usual, but
> exports the NMEA port via the GNSS subsystem and acts as a proxy between
> the device driver and the GNSS subsystem.
>
> From the WWAN device driver perspective, a NMEA port is registered as a
> regular WWAN port without any difference. And the driver interacts only
> with the WWAN core. From the user space perspective, the NMEA port is a
> GNSS device which parent can be used to enumerate and select the proper
> control port for the GNSS receiver management.
>
> CC: Slark Xiao <slark_xiao@163.com>
> CC: Muhammad Nuzaihan <zaihan@unrealasia.net>
> CC: Qiang Yu <quic_qianyu@quicinc.com>
> CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> CC: Johan Hovold <johan@kernel.org>
> Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> ---
>  drivers/net/wwan/Kconfig     |   1 +
>  drivers/net/wwan/wwan_core.c | 157 ++++++++++++++++++++++++++++++++++-
>  include/linux/wwan.h         |   2 +
>  3 files changed, 156 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
> index 410b0245114e..88df55d78d90 100644
> --- a/drivers/net/wwan/Kconfig
> +++ b/drivers/net/wwan/Kconfig
> @@ -7,6 +7,7 @@ menu "Wireless WAN"
>
>  config WWAN
>         tristate "WWAN Driver Core"
> +       depends on GNSS || GNSS =3D n
>         help
>           Say Y here if you want to use the WWAN driver core. This driver
>           provides a common framework for WWAN drivers.
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index 439a57bc2b9c..a30f0c89aa82 100644
[...]
> +static int wwan_port_register_gnss(struct wwan_port *port)
> +{
> +       struct wwan_device *wwandev =3D to_wwan_dev(port->dev.parent);
> +       struct gnss_device *gdev;
> +       int err;
> +
> +       gdev =3D gnss_allocate_device(&wwandev->dev);
> +       if (!gdev) {
> +               err =3D -ENOMEM;
> +               goto error_destroy_port;
> +       }
> +
> +       /* NB: for now we support only NMEA WWAN port type, so hardcode
> +        * the GNSS port type. If more GNSS WWAN port types will be added=
,
> +        * then we should dynamically mapt WWAN port type to GNSS type.

typo: mapt

