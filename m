Return-Path: <netdev+bounces-195606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7643AD1685
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 03:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 101257A392B
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 01:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066342BAF9;
	Mon,  9 Jun 2025 01:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ll551tlN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45514EAC7
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 01:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749432874; cv=none; b=iwbhk8WIy60dukSnW6EBSV7UzHhutwRl/hFnOTH8MY/vcRI8K2NBW7uI1MeUhY1e8tAvxU6Ry0FWukh4hVP6XJ/EqMapAnvM8ovUsBLppuJ2uyKSoNpEJb+tLwE6oK4zn8UK8g45xvutjfJK3ZYUhcMLl0Vz6iB8qsUb5UmpIqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749432874; c=relaxed/simple;
	bh=xTdHJZd2Xwctjcehy1yhu09ha3blTAVii5lobiEHbWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orKW8LQurs9V1lhBysa3cxiQnBdBZie72STQCBajfM9j+02nbwekzNvxaU/prCzoq795DLoNZyOgpIkt5gfTHU067bLPYVCZL049KgG/y2pfKUBkY663JO26u6GGqaBbGyx2pF3cSDUeNuphsGYJOfinJVHmvwCt4HNQXhK/TG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ll551tlN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749432871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QIXozl9i22f1l5b4YXx/XsCGXqFA1sz1MPal6Mu+QO4=;
	b=Ll551tlNFFd0rorwXlyUaNyKVnmbv291V2mfOCX2+S4Tdmucxf71SgOaTdX5yErU267qbj
	hXQTYXRbVHwdaQ3QZ5HWn71gL1yHdU/XEvTun0u2PWxNIZHaRUShbrkQRq29PrjnO3CAAF
	Z12UbT/UcDIbaFAOvYJhYQnwyj60y9I=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-DZ1RvpgdMk6IdxlUScb7BA-1; Sun, 08 Jun 2025 21:34:27 -0400
X-MC-Unique: DZ1RvpgdMk6IdxlUScb7BA-1
X-Mimecast-MFC-AGG-ID: DZ1RvpgdMk6IdxlUScb7BA_1749432865
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-55338ad830bso1558507e87.0
        for <netdev@vger.kernel.org>; Sun, 08 Jun 2025 18:34:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749432864; x=1750037664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIXozl9i22f1l5b4YXx/XsCGXqFA1sz1MPal6Mu+QO4=;
        b=czpQasoJM7ZFVgDP9QYhO8lp9ykCIwz3DEZRzcUtd7MKahBF8dBwZxoDThVZA9oUjF
         7b/XOLn4ZZmnjFLIAbkSXqSQVmkkwZU/brsGnBb2BQ4Q48xke3l5oCaA6Ylv0733U9YZ
         V1Ap4hYIba+Tkw7MDsoD/kmhytkjv55GwYTpBwEhnzXAzbLgugvEDoVqxwrK3GaQBWAl
         DkGSUuBbWhdf+nw9jRaexp4eIh/i6rKcDWQHWQO1L0imh0GEo2BulNCQ+kPmw7322oWD
         yvXyye7jk46E0xoJ7NIW4UlzGUCs7fV5oSXWctE4b9JQazgreauk4IdFAPJ2HgS2W6Wi
         pTYg==
X-Forwarded-Encrypted: i=1; AJvYcCUdFzDP8XaRiLSduzRtYoPvnhI6u274Kw9M9+lr86b1ZwRTiZTzgoNOAc06dlIZX/csrKNH4z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcWyHFoinHzmL/Er/wKG0wGowbjG9aiugyWol8g+uCe6P6aHkF
	WklPDWguvsHwc6FYMoU8EmK3BYdhctkGhLNjNZH6luWH9xGeMsoAKRJSoUw1/N0EPrPwCXGUKps
	HnV7M6giPiUc5+9M2o9KkH5EPD+kfRtE6QwuokIsAlYDDiO/8f+zoOeJ/RoG1ykh7s62uEkhRjg
	LzA7sHPVtB5BWwWToJqyrw1cmk/EIOGzmn4iV7OYIxHjw=
X-Gm-Gg: ASbGncsKe63+6fClqr2E67twNTbA7t8fAsbyK0EvI+95uh+aYLyQrlABdK6ELTd2APS
	yIsD9yTnYG1ipRKMsMwvke0bEwJkNiixTm0ZBPeHdXP/sFEq+7KrsjWsh4alPqsKzxaHfd8LuJb
	qGAJLd2NmVA97rkXlsWxJGqLL4s4M=
X-Received: by 2002:a05:651c:1a0a:b0:32a:9a0b:4697 with SMTP id 38308e7fff4ca-32adfb4a3aemr30083091fa.21.1749432864365;
        Sun, 08 Jun 2025 18:34:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5pTuxyNyzvC9lrWI0UvhIiyp0TcZueIavNYcRIZ+PjdvK2gwjGIBMYUxKqZFqZoEFcvuZUb06180+AYR6W80=
X-Received: by 2002:a05:651c:1a0a:b0:32a:9a0b:4697 with SMTP id
 38308e7fff4ca-32adfb4a3aemr30082981fa.21.1749432863938; Sun, 08 Jun 2025
 18:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608164724.6710-1-ramonreisfontes@gmail.com>
In-Reply-To: <20250608164724.6710-1-ramonreisfontes@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Sun, 8 Jun 2025 21:34:12 -0400
X-Gm-Features: AX0GCFtx4f9miKgxpJ6-L9HGx8wJe5tmQHbP_mngKaZoGAgnWWQgfuWjkCKB9vs
Message-ID: <CAK-6q+i+Feb9+_S_yF9h1+bezyfkCh-qrNXcQjsiXjrLHnwLmg@mail.gmail.com>
Subject: Re: [PATCH] mac802154_hwsim: allow users to specify the number of
 simulated radios dynamically instead of the previously hardcoded value of 2
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 12:47=E2=80=AFPM Ramon Fontes <ramonreisfontes@gmail=
.com> wrote:
>
> Add a module parameter `radios` to allow users to configure the number
> of virtual radios created by mac802154_hwsim at module load time.
> This replaces the previously hardcoded value of 2.
>
> * Added a new module parameter `radios`
> * Modified the loop in hwsim_probe()
> * Updated log message in hwsim_probe()
>
> Signed-off-by: Ramon Fontes <ramonreisfontes@gmail.com>
> ---
>  drivers/net/ieee802154/mac802154_hwsim.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee8=
02154/mac802154_hwsim.c
> index 1cab20b5a..8fcf8a549 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -27,6 +27,10 @@
>  MODULE_DESCRIPTION("Software simulator of IEEE 802.15.4 radio(s) for mac=
802154");
>  MODULE_LICENSE("GPL");
>
> +static unsigned int radios =3D 2;
> +module_param(radios, uint, 0444);
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

%u ?

- Alex


