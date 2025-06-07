Return-Path: <netdev+bounces-195520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C17AD0EC0
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 19:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C243A59ED
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 17:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9B31EE033;
	Sat,  7 Jun 2025 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+64PQlc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D851F1C1F05
	for <netdev@vger.kernel.org>; Sat,  7 Jun 2025 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749317674; cv=none; b=YVelpng4YvTOAAfr+SO4dT8lW1KS8+KJxNXrQeuKTyUw4pQhjWJbtzR0OlGakhIIfapJ8AAtolJsTJ+LZwYuLkNiMToKv80KFKrxW+LNUsWxYr3oybhfJlq6bDhwSa+XUl8Z8xwBgjKeHCoIhmlkOYwQRznv/XCZUqN2tA28SE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749317674; c=relaxed/simple;
	bh=Khy63nd1RGiALdVp3OZyYI1Xjdnf94tL0g0gM86xV24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Scx+oDwt96YwCVvUPzZvLLWVPVUKenzQY3Ewt239yjU5QpcdV5EhQpGpW9hiETW9YoygKlRguEDOgs/UWqJdmlsuZxCjFTyA/oWxTOIMTzYLkpstUw5TOK5PTK9fe2GfEDbSP0b8oPhabmLjAaeAnKfl2ktBPGC/xZy48YG2JRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+64PQlc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749317671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZnUegQI509/idcGeE7W1jddXf341qwR1ZMf5fTzdFVA=;
	b=i+64PQlcFvCjg6CSSRfS2TKuagEYAAWYQhW6KUoRvSrfaysgcIEaJPcGZhkUUmS/R0N4FW
	F++skXGFDbcqPvNk+8dnn0TeM5ARaZAhsufB75Q4X2AazablQDhzLcxBBpp3eM1UerjN1C
	a2nej9rRqL6Zj9egZjB0QiOsu1CPqCc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-bD7t5GQrNQO9ZrzXIn2Slg-1; Sat, 07 Jun 2025 13:34:30 -0400
X-MC-Unique: bD7t5GQrNQO9ZrzXIn2Slg-1
X-Mimecast-MFC-AGG-ID: bD7t5GQrNQO9ZrzXIn2Slg_1749317669
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-32a71048a07so11903491fa.1
        for <netdev@vger.kernel.org>; Sat, 07 Jun 2025 10:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749317668; x=1749922468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnUegQI509/idcGeE7W1jddXf341qwR1ZMf5fTzdFVA=;
        b=nwcOX3wSfTCRxSIFA6M8Fx/EjMvarMblnZuOgSzV/CyNLKEXy1yTLVdXbklSknMiUO
         NhcSY0LXpLV+zgQ7swMhSIhO0yJKZJO+cQE1ufbQiQjd9Pyt+tQ24+Y3iOf4i//djqS8
         FeUQo4c7dAoDp4OfsqgA4e6oGJiHlmgW/ggShs51gQOMqkokF9s1fjWbisgQzIwVOheb
         yBmFReONKPJpSdt7ip/9/gV08/k94VFVDjRyeNx9PnY3+2P2U9PcKYDNDgrQCv20bRNh
         55xDIUVWaZA5W8cu9khbBjKG9BxgL04hVFkuUtme3gQVycglP2v8JgV5CQs0Th1hdozv
         PUrw==
X-Forwarded-Encrypted: i=1; AJvYcCVUv+CYGf4ac/BMOPo5CAO3e4L5FnkPZdx5eSuVv4J9rkHsofmu11aKAxEIR4PP/sID9p7ziRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCEg6mzam2CFmNhgUIqQWmvowrdcc258zln6wdL/CVmwRudBnn
	TsZ7U67wjjL16DkOw8G5SdAzdptTsDxvt6Duq74cM0dk/5nXaIq6U6bEuo2iYgkKwiOoi2z3hrg
	WAiaxnmqXRFx9ikrJHiXjEbo7ZYM/iij+nWRZgeVx3EFN0yJJQsCmNumwA5F37rTmK9dUX+aT51
	fPqnEGO08YzPEhJCkOpRHxAKn9eUeyS7m4
X-Gm-Gg: ASbGnctpDcoE6MhXhGUScKq84jZ9aVvUqtVXqkQqQqGcEV5KZJxwbG03cg6QWz1+tJu
	Ei/CfZxeariHvB4homYycOufIQnngYx7RpnHSmmb7nCH9z7tDILz6FuvcPGJ8wJZ+yADuI4ZilT
	/YxnEZuCQQFYFisJaY6+x1Hw9V23g=
X-Received: by 2002:a05:651c:a0b:b0:32a:82d7:6d58 with SMTP id 38308e7fff4ca-32adfb42ff9mr16778941fa.12.1749317668562;
        Sat, 07 Jun 2025 10:34:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtC3c93aA7ULuZgbCwIO/dGKD+fgOTRSOTT0EmvA3/tCTSJg/zgm8NZrjrYEwlOXupRC69VDK+VG5Uv3CJm7U=
X-Received: by 2002:a05:651c:a0b:b0:32a:82d7:6d58 with SMTP id
 38308e7fff4ca-32adfb42ff9mr16778921fa.12.1749317668128; Sat, 07 Jun 2025
 10:34:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603183321.18151-1-ramonreisfontes@gmail.com>
In-Reply-To: <20250603183321.18151-1-ramonreisfontes@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Sat, 7 Jun 2025 13:34:16 -0400
X-Gm-Features: AX0GCFuAPUGHT9bEhzv0LiVRX1BItG95qelZs8iFBI33oWtprASD4D0WSvG0igw
Message-ID: <CAK-6q+i1BAtsYbMHMBfYK89HfiyQbXONjivt51GDA_ihhe4-oA@mail.gmail.com>
Subject: Re: [PATCH] mac802154_hwsim: allow users to specify the number of
 simulated radios dinamically instead of the previously hardcoded value of 2
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 3, 2025 at 2:33=E2=80=AFPM Ramon Fontes <ramonreisfontes@gmail.=
com> wrote:
>
> * Added a new module parameter radios
> * Modified the loop in hwsim_probe()
> * Updated log message in hwsim_probe()
>

no problem with this patch, just a note see below.

Acked-by: Alexander Aring <aahringo@redhat.com>

> Signed-off-by: Ramon Fontes <ramonreisfontes@gmail.com>
> ---
>  drivers/net/ieee802154/mac802154_hwsim.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee8=
02154/mac802154_hwsim.c
> index 2f7520454..dadae6247 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -27,6 +27,10 @@
>  MODULE_DESCRIPTION("Software simulator of IEEE 802.15.4 radio(s) for mac=
802154");
>  MODULE_LICENSE("GPL");
>
> +static int radios =3D 2;
> +module_param(radios, int, 0444);
> +MODULE_PARM_DESC(radios, "Number of simulated radios");
> +
>  static LIST_HEAD(hwsim_phys);
>  static DEFINE_MUTEX(hwsim_phys_lock);
>
> @@ -1018,13 +1022,13 @@ static int hwsim_probe(struct platform_device *pd=
ev)
>         struct hwsim_phy *phy, *tmp;
>         int err, i;
>
> -       for (i =3D 0; i < 2; i++) {
> +       for (i =3D 0; i < radios; i++) {
>                 err =3D hwsim_add_one(NULL, &pdev->dev, true);
>                 if (err < 0)
>                         goto err_slave;
>         }
>
> -       dev_info(&pdev->dev, "Added 2 mac802154 hwsim hardware radios\n")=
;
> +       dev_info(&pdev->dev, "Added %d mac802154 hwsim hardware radios\n"=
, radios);
>         return 0;
>
>  err_slave:
> @@ -1057,6 +1061,9 @@ static __init int hwsim_init_module(void)
>  {
>         int rc;
>
> +       if (radios < 0)
> +               return -EINVAL;
> +

handle as unsigned then this check would not be necessary?

- Alex


