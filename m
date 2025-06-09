Return-Path: <netdev+bounces-195900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31933AD2A41
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 01:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E927A18925C3
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B1D226CF9;
	Mon,  9 Jun 2025 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3kdc0vK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5966C226CEF
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 23:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749510266; cv=none; b=kUyXpVzkIpqODtEHl5cHXkiqGkiCLrOaZAIX47aclf4LM3l1Wda2SwfL7elD+ln8D8MspfItLley5gp8dJsgNeY1tHpUNPaShEvPwx+MHbo6du6o7XqaNniSjCl++lbcZmpwC/gopUZa1sJQMxEt+qharRHzlqNAiytUKvqY/iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749510266; c=relaxed/simple;
	bh=PcBDmqXyBhXKkjWPy1J7wSgj1WZqkZ+VKxDTSGH0MJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZ+kTM8t/Zc/L1G5Q4OcxznAvPIBX750cLKQ7hkwMrlopV1MYSgqWoHK5RlY4qGQEi367QAOqfpZE7cs6raiZOU13USF0qDSjtIaTOMf05ODZDIKumCwvp7yKyWp594RkcpWA2v8qdH3jUcGZxTgZ7qIWMigSDZkWbhr4xrtRLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y3kdc0vK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749510263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eMqPz5T5ms2+Vuv/P7AkLmCC+Jeyi+hIZycmP47qQCI=;
	b=Y3kdc0vKbLlcIDNvrZwgZfZh460vdMWmkbZKlNJ5VQE8nzGdywraDaCYoOq7nAQOC0Xr6C
	s/+MbQxGIUcYfLVxWjlUXxpgC0CBZc68rcOgipwdHfGAyPNzNY76KXydzLp3Ei5BQHOeom
	kLXFHx/+7SC6HzstOwVvoPWfhNbPTWY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-_LbqyJTuOTOUGamIwakelg-1; Mon, 09 Jun 2025 19:04:22 -0400
X-MC-Unique: _LbqyJTuOTOUGamIwakelg-1
X-Mimecast-MFC-AGG-ID: _LbqyJTuOTOUGamIwakelg_1749510261
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-32a6c3d3a75so14908121fa.3
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 16:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749510260; x=1750115060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMqPz5T5ms2+Vuv/P7AkLmCC+Jeyi+hIZycmP47qQCI=;
        b=iG4/A6BWvhABY0LIOQE4QvpTJbjD5DLY4h+ODwx1Nf/VXJptm1XXA1qdfRvPPwY9VU
         BeHdi/W7/QarSIgvGokT+iJpYKuUYUC0RhcwgU81GMvYm5NMehDwThm0TQNT93ki12rM
         FzMS+diI77v5WTjxVoNbgqPiLUYMDVmxnC1PIOOan2EwnkmI5ieGHmsdPTIe6bUT2uzP
         /hjvgAhOeDp6jmSwe/1fgO5Lmlhjr4d6icGoBoxJWJQRXOLSDR2ZxueKLDKKt7WyEkcN
         vz02yTpVMIuTXLJCMLmJp+4QHEKpeMknLRw39QGbG2IWzFbXFx6Xcy2sP16uGbDbpt90
         e7Hw==
X-Forwarded-Encrypted: i=1; AJvYcCULHN49oKt/3VkDWFkrCW2bVCmUZpb56R7RI8g1muOyWY5zGeB4F586i8NFTyEB+lcWN2vMPww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs6YMN+cQk7sbCjC9ihg5Iu77mp93DL96dM1QAmPIaKl8r0gpi
	iMi/bMZRhS2CzQfluiClruOaiRvqisjtGDcZHmNefmaRJT+Lv4xPjX5WxflbB08D+Vw4XirAdYP
	XUJ1FkMhbSRscDI6yYZN0IPXUR8VTvhwHIGZxEoKuxGY/N0FEb6T8He/O8bAuHnDgQ4sneOyC8T
	TCS9dXOJZDl1EpYWHoLBSYgM19+CJgoiTau0QnnX08kUU=
X-Gm-Gg: ASbGncunJaH26/a8qpcH2MBeaQhwtgoqJGBBZ3bWEoiAwCVRgtkCb/YHuEyvFViHlbC
	1aAbmMkOWajRXF/S7j4dCelTjq7bE9Duxd5UmZxZ1cs6UJK6ncbhOcss13T0opV0y2aMGiP5Z0k
	w3HEU+XXGL5ArN4wNkgiMNUnM2tL1n40ClqyXX6A==
X-Received: by 2002:a2e:b892:0:b0:32a:778d:be86 with SMTP id 38308e7fff4ca-32adfe270f1mr37092641fa.31.1749510260231;
        Mon, 09 Jun 2025 16:04:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMfqTSlst8c6suWs1k0ndLs7U+aVZ5OFmK6rcE8gYx6tuiEl6hKJ7ceS8cdacI2w9LKaXptFQyHzlKjkLaOZE=
X-Received: by 2002:a2e:b892:0:b0:32a:778d:be86 with SMTP id
 38308e7fff4ca-32adfe270f1mr37092581fa.31.1749510259818; Mon, 09 Jun 2025
 16:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609094628.6929-1-ramonreisfontes@gmail.com>
In-Reply-To: <20250609094628.6929-1-ramonreisfontes@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 9 Jun 2025 19:04:08 -0400
X-Gm-Features: AX0GCFu1jQFWpnoMMyFRZstITGxwEgNzEuhvf1aY2fE4abY6GozoHKv5DIDedbE
Message-ID: <CAK-6q+g3ns4BvZhgtzH6a6gDrEGpPmpugQki86fmbKxgHi51Aw@mail.gmail.com>
Subject: Re: [PATCH] mac802154_hwsim: allow users to specify the number of
 simulated radios dynamically instead of the previously hardcoded value of 2
To: Ramon Fontes <ramonreisfontes@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, alex.aring@gmail.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 9, 2025 at 5:47=E2=80=AFAM Ramon Fontes <ramonreisfontes@gmail.=
com> wrote:
>
> Add a module parameter radios to allow users to configure the number
> of virtual radios created by mac802154_hwsim at module load time.
> This replaces the previously hardcoded value of 2.
>
> * Added a new module parameter radios
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
> index 1cab20b5a..1740abe1a 100644
> --- a/drivers/net/ieee802154/mac802154_hwsim.c
> +++ b/drivers/net/ieee802154/mac802154_hwsim.c
> @@ -27,6 +27,10 @@
>  MODULE_DESCRIPTION("Software simulator of IEEE 802.15.4 radio(s) for mac=
802154");
>  MODULE_LICENSE("GPL");
>
> +static unsigned int radios =3D 2;
> +module_param(radios, int, 0444);

uint? I can swear I saw that in an earlier patch.

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

The iterator needs to be unsigned now?

- Alex


