Return-Path: <netdev+bounces-247468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 561BCCFAF7E
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 21:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56EAA3012662
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 20:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0F233BBBA;
	Tue,  6 Jan 2026 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nHBbw8Ac";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QZVEKZH2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFAC33B97E
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731695; cv=none; b=iFcWLQyNnuiiFbS2guz7KCwCFRmDirYYU5GlsAI5qt/cMb4ZYQZfgdjINOkRCOM8ydCC02l0uhYcNTpayKxa0BoXqZdk+vX1hDYlK0Q000BnBiOIxPdScqGrP20jVDVVkDpOzy0WwppGebVKkqTkUYIjlMFCTh0LJxwnGrNK9v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731695; c=relaxed/simple;
	bh=Kr+ZHAb31rqyQqRaMb6PhKWTykzNMrz7kw/Z1kLJf1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npC8dIUfh2buODP7G/KELMjyiFgO0GcFrPTWh31E2wdKHqXBzmcK/LreX+BgQUzxuFu3tPpAykbBBqwd7ydR/DZINwP28xXiCcY0Y8vqgDvraK22C+p1j9f3KC1Sl3RioSVcclDejwMd4ijvVo5KiOy5z7gayC0F/UjpyfVjNhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nHBbw8Ac; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QZVEKZH2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606GqKk13888906
	for <netdev@vger.kernel.org>; Tue, 6 Jan 2026 20:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7GWEgDBOt7oywOLpQl2zTO0yeiujdDL1SAVtSIuNYWM=; b=nHBbw8AcAIpQmfhK
	IY9nGeUSF7uKX6Pb/sO33a6Voy2eBDBOd6SXPLxCH0qhOYct7yVZjYZPGIhYGSNx
	wX/aURFnfaTC3FHqX4Witz9JsU5oyD/egNHtV0r9sqy8Kg+5v+qnzkoFVFC69wHh
	jVNzegOvV5MTIfm4fd1TjbOYGdK7DooALhQzFMlsuKO1kExR1OehsgQJBJOX04Yy
	6ACRbbs72xQ8KJOfmAh4bYiWHahN4Sb10xdDCEuUN4MzTzozepG7zeydcBNqkIvC
	R1uRqNkpkta4VFFRsRhGdvsf45dJCRZK0BPJ34lP78HhB0yHp7ytB/Rb+t+vjB4p
	2Gn8gw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh6a0gnnd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 20:34:52 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-88a43d4cd2bso19257366d6.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 12:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767731692; x=1768336492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GWEgDBOt7oywOLpQl2zTO0yeiujdDL1SAVtSIuNYWM=;
        b=QZVEKZH27o52DO4362qEBxAQr/JJYtjQD8LNOEFvCrdXU9dX5BhOmUr7tJkDeejqTd
         20Zv7NW3zVG6LRKSrm9GlPe1bvjBLW1cYAx9igubUHLuJzQQgJdQvbbfDcggK0hscE0K
         GhoXKjhHWQiR6xrSKGOvyLEDb8RyIjnVBA+8mz6jOU+FBkh3zs84355V6Vu1i90cFs9m
         +bePMXOaPIXxLup3XSfbdydxHUjeRJP38QyrafGNWJkBK3esFJdwDIjOF6HH69bVywBE
         S35MS/ypxAe8Q9q/p5hFC4UKO6mR4Y/FulJeM9P9ByD3DoERDg5cJS9fuQwmD3KsluSv
         W0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767731692; x=1768336492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7GWEgDBOt7oywOLpQl2zTO0yeiujdDL1SAVtSIuNYWM=;
        b=AJwhHvG7O2RyqCcbU/t78awb3cB7WTDgRoRHTUIQjorR4t0fBkLUC3sxl2KjO9lRul
         jGC6ilJBskr0zu91H6QeHipQQN2dwhf5rLZVZe1sPYySW70WQ6QTCkLVzaAav4CV7jph
         xY+ZqmZszAAdGUwtCHdihrq3sboIzmSZry1sIB+/MrIXyv0/poEq6fGhjxkaNgXx5eka
         wHeopb//GAkLLvPmYLokmYKOYweBmbyAj8voSzXh5bVd0rCBkHuTahSwUWclhlVp8DZT
         irWro9doB3GQvh/GpQh2XIqqAdA6MLlZiQkx2l7iiDnp0koCpui8WBRFyCWjfTVh0jLh
         7cAw==
X-Forwarded-Encrypted: i=1; AJvYcCXCiqoIZatszOXwoyOoXAWICXHsxPLf3e92QXQNF1hGM4DJsorfXk/jvnr6YZ+h6SZoX2fYWAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJSJ+WJ3orQdV3SF7EPkgiIVHFZ0O5V/K6mec73vjEDLWl+WY/
	uRHIW91TKCMoF/fcx1wHYG4ncCi+D78olyI1Q5VWQw6aJMefx9mBv1marYybE/CnpZdyDMSrxok
	pjrT5JWVgAqLlOLsgl96sDoLnTmI3hAhuXwuVQQG7MMjOaCPRG730ScLFD4Eq9zR7sJB/e2o8yG
	UD/D4d41YfQagYQetHao0CgF4nu+VRxQCWhA==
X-Gm-Gg: AY/fxX6bD9LaQFbpsf9b+2l6V8FIza4FnfrU8dUDVfgrLqq03HVJEGY/5HjLhgWOwdm
	sarNj9dWyk+0ezkChXAOwR4WMY75tWwha/qcDvwmnAHtDqtAq1WxWHL9SmP1qBeb9vU9rjoOXEM
	/VCjO7uIOSDY/eA74ZFWEcRMxmzXZi6ZMbucZ+nuWBEARMktW0KOM72kepAU0Swdm1PMkOV51Ej
	HIOhHTgLNPZiaV/johB/fXJELI=
X-Received: by 2002:a05:6214:21c7:b0:888:fc37:f9b7 with SMTP id 6a1803df08f44-890841b8743mr3656966d6.25.1767731692304;
        Tue, 06 Jan 2026 12:34:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEw89F+yDCQhGhVnO1BrOeG0X886BgepD3D9Qy4BwYqUIw4n5p4QkP6CjA8nlcQ85XllDnnVHF8lnwQQBvkSw4=
X-Received: by 2002:a05:6214:21c7:b0:888:fc37:f9b7 with SMTP id
 6a1803df08f44-890841b8743mr3656736d6.25.1767731691831; Tue, 06 Jan 2026
 12:34:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105102018.62731-1-slark_xiao@163.com> <20260105102018.62731-4-slark_xiao@163.com>
In-Reply-To: <20260105102018.62731-4-slark_xiao@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 21:34:40 +0100
X-Gm-Features: AQt7F2oHRro97cu0VBQZCuQkvHjzoByxC3jq2abZNXwWHPaqXPbEAZ8nKwOgscc
Message-ID: <CAFEp6-3Ctq5h2r-grJ4UGW-EZnkaM0s_AtsAQjH=pe8XabRH1A@mail.gmail.com>
Subject: Re: [net-next v4 3/8] net: wwan: core: split port unregister and stop
To: Slark Xiao <slark_xiao@163.com>
Cc: ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mani@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: NgTR76uHPy979t2P3yE5FrYhRj1q0nyA
X-Proofpoint-GUID: NgTR76uHPy979t2P3yE5FrYhRj1q0nyA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE3OCBTYWx0ZWRfX+7wEP9RFTyN6
 FDDLxxkyaYQrdiR4kAy0NleF0xmHqLuRYczy8V3bIkhDCXQWnMd0lLfLMC1FzOGnAk2LGUTSCrx
 QEWEGnIOFhlgyMsJ7vL2ET5b5/+7TvAcyjOrkb12jaKMCapIXYGy3bRmbpM7cvN/uGmXpG1s4bv
 39l9XZCosGVorfD664fThWls2DBbVePIAt7r4KXVqSHJRvVwuxU1eyPZnAb2IFP3Mrz2fzF9fOv
 /ymqj/y3eR6rsgCSrtynMXYU5ELJta5PcS+Y6sjau9zFpRPsAw2mZFylbRyihcjyh5xIb7HVrNl
 Pin6E73gfiwYKLXNaoeeDR5JJvm6b7Tid6s16TgY8i+GhkCNa+nPfphLga9k2kjPHadN1k9qYsN
 GH0Ud73ZC4ths0Gh1KGNaewMYOBI7UYfMYsZdMK5TEtWLAPlNUHzFnwpcoI6Um69PIupSjmnoZW
 Cl7vsYtyKtfUiPxl2pg==
X-Authority-Analysis: v=2.4 cv=MtdfKmae c=1 sm=1 tr=0 ts=695d71ec cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Byx-y9mGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=ai5p6xNhIYTwrweCe2kA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601060178

On Mon, Jan 5, 2026 at 11:21=E2=80=AFAM Slark Xiao <slark_xiao@163.com> wro=
te:
>
> From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>
> Upcoming GNSS (NMEA) port type support requires exporting it via the
> GNSS subsystem. On another hand, we still need to do basic WWAN core
> work: call the port stop operation, purge queues, release the parent
> WWAN device, etc. To reuse as much code as possible, split the port
> unregistering function into the deregistration of a regular WWAN port
> device, and the common port tearing down code.
>
> In order to keep more code generic, break the device_unregister() call
> into device_del() and put_device(), which release the port memory
> uniformly.
>
> Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>


> ---
>  drivers/net/wwan/wwan_core.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index edee5ff48f28..c735b9830e6e 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -476,6 +476,18 @@ static int wwan_port_register_wwan(struct wwan_port =
*port)
>         return 0;
>  }
>
> +/* Unregister a regular WWAN port (e.g. AT, MBIM, etc) */
> +static void wwan_port_unregister_wwan(struct wwan_port *port)
> +{
> +       struct wwan_device *wwandev =3D to_wwan_dev(port->dev.parent);
> +
> +       dev_set_drvdata(&port->dev, NULL);
> +
> +       dev_info(&wwandev->dev, "port %s disconnected\n", dev_name(&port-=
>dev));
> +
> +       device_del(&port->dev);
> +}
> +
>  struct wwan_port *wwan_create_port(struct device *parent,
>                                    enum wwan_port_type type,
>                                    const struct wwan_port_ops *ops,
> @@ -536,18 +548,19 @@ void wwan_remove_port(struct wwan_port *port)
>         struct wwan_device *wwandev =3D to_wwan_dev(port->dev.parent);
>
>         mutex_lock(&port->ops_lock);
> -       if (port->start_count)
> +       if (port->start_count) {
>                 port->ops->stop(port);
> +               port->start_count =3D 0;
> +       }
>         port->ops =3D NULL; /* Prevent any new port operations (e.g. from=
 fops) */
>         mutex_unlock(&port->ops_lock);
>
>         wake_up_interruptible(&port->waitqueue);
> -
>         skb_queue_purge(&port->rxq);
> -       dev_set_drvdata(&port->dev, NULL);
>
> -       dev_info(&wwandev->dev, "port %s disconnected\n", dev_name(&port-=
>dev));
> -       device_unregister(&port->dev);
> +       wwan_port_unregister_wwan(port);
> +
> +       put_device(&port->dev);
>
>         /* Release related wwan device */
>         wwan_remove_dev(wwandev);
> --
> 2.25.1
>

