Return-Path: <netdev+bounces-182436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1009AA88BB8
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0136016E272
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3947727586B;
	Mon, 14 Apr 2025 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m8+64CHq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C58BE4A
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656638; cv=none; b=WGzkrJQ+xDFeVxtgcN30KKukcq4ilXkvs4/kwIFdyexrunOWQMjOMs0bHRAQOAa4effZ2wKA/TzNiaLyEeEsVKLtJdDDeXfhHdgslJLCxWaY3jmplqzO1nttxFsOOTJlLPU4XJXZuzMT57CijZgdEIPCLu/JaXCGBR/Vv6tIwYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656638; c=relaxed/simple;
	bh=jLN0n2xt5CbXqoNpco1LBcazaX1As/MXTlzfsbM/lXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/KNJOyQJhezvFBTIpGBuBLtJRGVTtx/wH6WtZrk2iV+j1HUK1JUp9VDPJvEc0xw3oiiKJnl9sfzTF4Bbcj3SqxOYc8zTQ4drF2EQHe03bhDoB0s2kVw2hdYzJfad5xw75c9/kpl0GfmrUmXWyRRf2fE8K3XONfa410xeuKcwAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m8+64CHq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53E99jnX013541
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	THJt1ysyy4K5ekl/K/EUtMeZx+hNLLdmSYcsttCB3zQ=; b=m8+64CHqMh+Y/M/x
	ksr4ezFJMzi4KzuIJQJ+1XJF8AlzZcZi5tRxSm234G8f1tUIb1M/6y05JDH7Qqev
	7g+ZycmQlWrY8LnSwFz6POV8mvQkvi3wlZnhckeVFFAa2uODi9KaJm3h2W3WOE0W
	02M5kp1g4ybrogbblP3RO+jJVAZwmUcwxkFRej1qTDGIPBRoeQpaebUTGzgV1fw9
	3U2ShEkcaBwvhu+yRhoBGU31MF7DXwnYDQBS1Fg2dnJqh2zJUwwqAAzxMxEXiBl/
	KO+P8Vgc0o1Mj5s5kV0UOXPEXLVt9lumAIP5oP8r78SiDXzfRnWnX+Kk+iRWw9x2
	3BEAwg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhfcwebb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:50:35 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8f9450b19so93520686d6.1
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 11:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744656618; x=1745261418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THJt1ysyy4K5ekl/K/EUtMeZx+hNLLdmSYcsttCB3zQ=;
        b=de1rekj1klh6y2AjqMj7uTZXAgwa8OWDQZUTkOOcZEWdbAP0HsHxOzlzE8TT9qNKAV
         EFliSfw39notiPNJLdF6TdKexgQ5JbwWVMKZ5AvkPehCYBSeos8tVGila1EziaAcLe2W
         GJ/7amN4U2t+yGFwzlHPqBEo66oHRY5JrusN+u6vENRhVKqls6qEQ/ZpFpZaUG5TtOZe
         yNkmBvOZSkyzeNbZE+W9C97Ks2zqV3Jwf1TNaw/uyL1cfqrtA2Mpo1zHGZ4PsPaYyc0t
         28nU4vN/Ll4TCUHnyvh4y9NASCKT3Nf4bsDOm5USZTE3QRjNT7OclkVXAl9HztzTg8Ud
         Fpag==
X-Forwarded-Encrypted: i=1; AJvYcCXOuqoQHlLYeLkXyOqBY66K1rwcbWaTYTlzGO4ndrZ72ZI+8/06oSVV9el5l45h5KfHn+2AM58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCsGHlcCeUz+lTTsvtzqbpsyg5UkjHm2LHA5n5HS6hB5Gpuv+0
	rOunR75UhvRPe3w6XdhCbD/Qbt+DanW/BcYBwZVJM9Zi9AgLF3HUMWqmPRYeoMpjJD27JYebe6N
	XVM4EcOU5MB0cyqlFjbRTx5cCygJ5/o6uYJd8pRBtGbzevtmWkmDzR28ekUYwrfHXJecDhRmYrR
	Z6kPazdu7Qm3ybTNmI4ZlC9SBC+P4AkQ==
X-Gm-Gg: ASbGncvk9CYjBKJ0Egm9vAzoH0mrEJeW77PFmf9bUipdrJfEC3WMa17pok/0YTzNiVt
	bYQBu0ICVVwlM3dMJ7jsRjD3smJH02hBOV3nWJaeF5Eb2KH8JG5MCgdkfR2LKzGHTSXWajig=
X-Received: by 2002:a05:6214:cc1:b0:6ea:ee53:5751 with SMTP id 6a1803df08f44-6f2a187d6a2mr7479036d6.21.1744656618288;
        Mon, 14 Apr 2025 11:50:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErluBWZouUKelRuft9Bk55OO15YgovGljfqK99RJEReA4Gvl5Tg2WhLiePYbBVcXyDbKdOd2DQJAoOiOAZvq4=
X-Received: by 2002:a05:6214:cc1:b0:6ea:ee53:5751 with SMTP id
 6a1803df08f44-6f2a187d6a2mr7478606d6.21.1744656617834; Mon, 14 Apr 2025
 11:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408233118.21452-1-ryazanov.s.a@gmail.com> <20250408233118.21452-3-ryazanov.s.a@gmail.com>
In-Reply-To: <20250408233118.21452-3-ryazanov.s.a@gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 14 Apr 2025 20:50:06 +0200
X-Gm-Features: ATxdqUE2cRwd5TlaGqsGRESqc15AaHJe5katCXRMeavRQ2HBsv42-Wtfnq57rQg
Message-ID: <CAFEp6-0kBH2HMVAWK_CAoo-Hd3FU8k-54L1tzvBnqs=eS39Gkg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] net: wwan: core: split port creation and registration
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=CfUI5Krl c=1 sm=1 tr=0 ts=67fd58fb cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=MYKxjJogAk15MAgVHxkA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: N66ibtR0xIzyPtRxZQK5bKFuZcZAvEO2
X-Proofpoint-ORIG-GUID: N66ibtR0xIzyPtRxZQK5bKFuZcZAvEO2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140137

Hi Sergey,

On Wed, Apr 9, 2025 at 1:31=E2=80=AFAM Sergey Ryazanov <ryazanov.s.a@gmail.=
com> wrote:
>
> Upcoming GNSS (NMEA) port type support requires exporting it via the
> GNSS subsystem. On another hand, we still need to do basic WWAN core
> work: find or allocate the WWAN device, make it the port parent, etc. To
> reuse as much code as possible, split the port creation function into
> the registration of a regular WWAN port device, and basic port struct
> initialization.
>
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> ---
>  drivers/net/wwan/wwan_core.c | 86 ++++++++++++++++++++++--------------
>  1 file changed, 53 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index ade8bbffc93e..045246d7cd50 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -357,16 +357,19 @@ static struct attribute *wwan_port_attrs[] =3D {
>  };
>  ATTRIBUTE_GROUPS(wwan_port);
>
> -static void wwan_port_destroy(struct device *dev)
> +static void __wwan_port_destroy(struct wwan_port *port)
>  {
> -       struct wwan_port *port =3D to_wwan_port(dev);
> -
> -       ida_free(&minors, MINOR(port->dev.devt));
>         mutex_destroy(&port->data_lock);
>         mutex_destroy(&port->ops_lock);
>         kfree(port);
>  }
>
> +static void wwan_port_destroy(struct device *dev)
> +{
> +       ida_free(&minors, MINOR(dev->devt));
> +       __wwan_port_destroy(to_wwan_port(dev));
> +}
> +
>  static const struct device_type wwan_port_dev_type =3D {
>         .name =3D "wwan_port",
>         .release =3D wwan_port_destroy,
> @@ -440,6 +443,49 @@ static int __wwan_port_dev_assign_name(struct wwan_p=
ort *port, const char *fmt)
>         return dev_set_name(&port->dev, "%s", buf);
>  }
>
> +/* Register a regular WWAN port device (e.g. AT, MBIM, etc.)
> + *
> + * NB: in case of error function frees the port memory.
> + */
> +static int wwan_port_register_wwan(struct wwan_port *port)
> +{
> +       struct wwan_device *wwandev =3D to_wwan_dev(port->dev.parent);
> +       char namefmt[0x20];
> +       int minor, err;
> +
> +       /* A port is exposed as character device, get a minor */
> +       minor =3D ida_alloc_range(&minors, 0, WWAN_MAX_MINORS - 1, GFP_KE=
RNEL);
> +       if (minor < 0) {
> +               __wwan_port_destroy(port);

I see this is documented above, but it's a bit weird that the port is
freed inside the register function, it should be up to the caller to
do this. Is there a reason for this?

> +               return minor;
> +       }
> +
> +       port->dev.class =3D &wwan_class;
> +       port->dev.type =3D &wwan_port_dev_type;
> +       port->dev.devt =3D MKDEV(wwan_major, minor);
> +
> +       /* allocate unique name based on wwan device id, port type and nu=
mber */
> +       snprintf(namefmt, sizeof(namefmt), "wwan%u%s%%d", wwandev->id,
> +                wwan_port_types[port->type].devsuf);
> +
> +       /* Serialize ports registration */
> +       mutex_lock(&wwan_register_lock);
> +
> +       __wwan_port_dev_assign_name(port, namefmt);
> +       err =3D device_register(&port->dev);
> +
> +       mutex_unlock(&wwan_register_lock);
> +
> +       if (err) {
> +               put_device(&port->dev);
> +               return err;
> +       }
> +
> +       dev_info(&wwandev->dev, "port %s attached\n", dev_name(&port->dev=
));
> +
> +       return 0;
> +}
> +
>  struct wwan_port *wwan_create_port(struct device *parent,
>                                    enum wwan_port_type type,
>                                    const struct wwan_port_ops *ops,
> @@ -448,8 +494,7 @@ struct wwan_port *wwan_create_port(struct device *par=
ent,
>  {
>         struct wwan_device *wwandev;
>         struct wwan_port *port;
> -       char namefmt[0x20];
> -       int minor, err;
> +       int err;
>
>         if (type > WWAN_PORT_MAX || !ops)
>                 return ERR_PTR(-EINVAL);
> @@ -461,17 +506,9 @@ struct wwan_port *wwan_create_port(struct device *pa=
rent,
>         if (IS_ERR(wwandev))
>                 return ERR_CAST(wwandev);
>
> -       /* A port is exposed as character device, get a minor */
> -       minor =3D ida_alloc_range(&minors, 0, WWAN_MAX_MINORS - 1, GFP_KE=
RNEL);
> -       if (minor < 0) {
> -               err =3D minor;
> -               goto error_wwandev_remove;
> -       }
> -
>         port =3D kzalloc(sizeof(*port), GFP_KERNEL);
>         if (!port) {
>                 err =3D -ENOMEM;
> -               ida_free(&minors, minor);
>                 goto error_wwandev_remove;
>         }
>
> @@ -485,31 +522,14 @@ struct wwan_port *wwan_create_port(struct device *p=
arent,
>         mutex_init(&port->data_lock);
>
>         port->dev.parent =3D &wwandev->dev;
> -       port->dev.class =3D &wwan_class;
> -       port->dev.type =3D &wwan_port_dev_type;
> -       port->dev.devt =3D MKDEV(wwan_major, minor);
>         dev_set_drvdata(&port->dev, drvdata);
>
> -       /* allocate unique name based on wwan device id, port type and nu=
mber */
> -       snprintf(namefmt, sizeof(namefmt), "wwan%u%s%%d", wwandev->id,
> -                wwan_port_types[port->type].devsuf);
> -
> -       /* Serialize ports registration */
> -       mutex_lock(&wwan_register_lock);
> -
> -       __wwan_port_dev_assign_name(port, namefmt);
> -       err =3D device_register(&port->dev);
> -
> -       mutex_unlock(&wwan_register_lock);
> -
> +       err =3D wwan_port_register_wwan(port);
>         if (err)
> -               goto error_put_device;
> +               goto error_wwandev_remove;
>
> -       dev_info(&wwandev->dev, "port %s attached\n", dev_name(&port->dev=
));
>         return port;
>
> -error_put_device:
> -       put_device(&port->dev);
>  error_wwandev_remove:
>         wwan_remove_dev(wwandev);
>
> --
> 2.45.3
>

