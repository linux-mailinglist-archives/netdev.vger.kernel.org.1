Return-Path: <netdev+bounces-103189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F2C906C47
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74019B24121
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 11:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72307145B1F;
	Thu, 13 Jun 2024 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hjeVHFqO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8020A144D21
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279233; cv=none; b=BkJu06p6mYyCgamV1Er11tNakKqyL/UqBVt3w8vfKbW/9iAGVIPgt3qBkFlZWAmKcFLXmGwUIvK3v4TNplJlg+JCv3CUgmJGSV4UgLFe1tXzZ0sKE4XA6N00QL715jpzNi5dL+P+INdpbjw1H590C82mLzhKcJ+hpLB6YXb7z3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279233; c=relaxed/simple;
	bh=u8uqNXfneUxeojJqX6uW43gawvkWd/SVV0l8sqbDYiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojwzKrrf+BYn06Ce13Fp+h94KZBNEOPRWtloVCo/ee8ACGnI5BH4XZl1f64SOrIKYb+2Mg1ZjIAwjvPZ4F2+tNNMJcnLBSMHwEqYGcto6f77rRVoU+GglkE83N0MjS/hF12DqNELeeFSkGVumvllENoqtQQW8iDNAXd9H8pwqBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hjeVHFqO; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dfef552d425so1164891276.0
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 04:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718279229; x=1718884029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LOKAxIeKteFuhp7/Gqn9TPI7GSn3AjIAgrQwVRNEFU=;
        b=hjeVHFqOks17mJr5ZOK3MfW+jrYXcZYEDqkvr5Cp+D6iEZmVOwIjLMVwcCJhE434Im
         myUPaK2lB7bPK14p+MVgCMvoZMQEpJ+aRuO3SNDE729WXwxjQ/jk33RPjeuS8k8jcZq2
         xufjyQeOl/dTSN5mjnJJoyo9cjJHu06XHIDJ0lYtOx9584059S1sYeDvV1F5m90PcZnW
         9oQNfwtYojMh2ubIVFrehDoErOZlXKoHG6CsNKmsL7a7iRDcGFJjnR3OGnhor5BqV3Ab
         c/mwm7AKeDXITNkjX8cjSV8p3H2MctJZSyapjdXWxxLI+sdOwzFJbrKmluJpjJlmb1+A
         sJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279229; x=1718884029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LOKAxIeKteFuhp7/Gqn9TPI7GSn3AjIAgrQwVRNEFU=;
        b=SInkt3JOh5kQMcOeqjEY7/twoCImEOkkGrY7u/l0Ng93cJP/V5iVjkkOtqXL10gD6D
         Qp+H+CjYWxi7VBI6c25wnGIR300G3umNrYCh/UNeXtDUWc8epzcqq4zXk+csZQq8ZRve
         SEvqKtR3Z7kvazvr9m4EFgMHx5T49Z8KU1WCoDXH6LpyygW5AouD4SREEBK3i87tiBcF
         /ZiMBcYm03wH2iCeKqZL4H2b5c8s2FHDj5aJEWjR5TIhHL+wzuGLS5a9aDMZWeLmYuHa
         92NgZ3lAWgT7WJUe6GmGhX4Xnmu35a29N0m8ozzMUJv2CchTLwzpZETU3Y8VveqTl0jc
         jBYw==
X-Forwarded-Encrypted: i=1; AJvYcCVxttECYfzaAx+2JL3RwvP7cc6NZEtu7+/xfgDF0uNWWOVEHuzoLMHWefwTnPWQQ6Usgk+96+PvWKxiddCm2gna3HqIIN46
X-Gm-Message-State: AOJu0YwMmv1QKFw1lPzVkpzzYElvmneUBhfeTazWEhhSUZwo83ZXRobZ
	JqxC4lAiuN8wlyUxvQU8EP2AA0NBGAXBeyXRJOtwxKahKmGlA6HlbYL0k5eWZFFlvR1MISy9YXV
	jHUI1W6xc5iKjuOEPMsy09rlOVCXnYLeBXtG0rg==
X-Google-Smtp-Source: AGHT+IHFpink+Q293EhYr5U3tq2VDPbFBHBjghBbhVxgaG4IqWejDV0X1BOwqLDyC7goxOFASWf1sJs6gdyGUmv2tSI=
X-Received: by 2002:a25:aca8:0:b0:dfb:25ba:4390 with SMTP id
 3f1490d57ef6-dfe66d5a5e0mr4339265276.36.1718279229482; Thu, 13 Jun 2024
 04:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMSo37U3Pree8XbHNBOzNXhFAiPss+8FQms1bLy06xeMeWfTcg@mail.gmail.com>
 <20240613095901.508753-1-jtornosm@redhat.com>
In-Reply-To: <20240613095901.508753-1-jtornosm@redhat.com>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Thu, 13 Jun 2024 19:46:57 +0800
Message-ID: <CAMSo37UzU9WrQOQVo=Bb-LfOwS=GJrsSLMgGAwLY7JoGQ9ap7g@mail.gmail.com>
Subject: Re: [PATCH] net: usb: ax88179_178a: fix link status when link is set
 to down/up
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: amit.pundir@linaro.org, davem@davemloft.net, edumazet@google.com, 
	inventor500@vivaldi.net, jstultz@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	sumit.semwal@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jose

On Thu, 13 Jun 2024 at 17:59, Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> Hello again,
>
> There was a problem copying the patch, sorry, here the good one:

Thanks very much for the work!

I will test it tomorrow, and let you know the result then.

Best regards,
Yongqin Liu
>
> $ git diff drivers/net/usb/ax88179_178a.c
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178=
a.c
> index 51c295e1e823..60357796be99 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -174,7 +174,6 @@ struct ax88179_data {
>         u32 wol_supported;
>         u32 wolopts;
>         u8 disconnecting;
> -       u8 initialized;
>  };
>
>  struct ax88179_int_data {
> @@ -327,7 +326,8 @@ static void ax88179_status(struct usbnet *dev, struct=
 urb *urb)
>
>         if (netif_carrier_ok(dev->net) !=3D link) {
>                 usbnet_link_change(dev, link, 1);
> -               netdev_info(dev->net, "ax88179 - Link status is: %d\n", l=
ink);
> +               if (!link)
> +                       netdev_info(dev->net, "ax88179 - Link status is: =
%d\n", link);
>         }
>  }
>
> @@ -1543,6 +1543,7 @@ static int ax88179_link_reset(struct usbnet *dev)
>                          GMII_PHY_PHYSR, 2, &tmp16);
>
>         if (!(tmp16 & GMII_PHY_PHYSR_LINK)) {
> +               netdev_info(dev->net, "ax88179 - Link status is: 0\n");
>                 return 0;
>         } else if (GMII_PHY_PHYSR_GIGA =3D=3D (tmp16 & GMII_PHY_PHYSR_SMA=
SK)) {
>                 mode |=3D AX_MEDIUM_GIGAMODE | AX_MEDIUM_EN_125MHZ;
> @@ -1580,6 +1581,8 @@ static int ax88179_link_reset(struct usbnet *dev)
>
>         netif_carrier_on(dev->net);
>
> +       netdev_info(dev->net, "ax88179 - Link status is: 1\n");
> +
>         return 0;
>  }
>
> @@ -1678,12 +1681,21 @@ static int ax88179_reset(struct usbnet *dev)
>
>  static int ax88179_net_reset(struct usbnet *dev)
>  {
> -       struct ax88179_data *ax179_data =3D dev->driver_priv;
> +       u16 tmp16;
>
> -       if (ax179_data->initialized)
> +       ax88179_read_cmd(dev, AX_ACCESS_PHY, AX88179_PHY_ID, GMII_PHY_PHY=
SR,
> +                        2, &tmp16);
> +       if (tmp16) {
> +               ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_STATUS_MOD=
E,
> +                                2, 2, &tmp16);
> +               if (!(tmp16 & AX_MEDIUM_RECEIVE_EN)) {
> +                       tmp16 |=3D AX_MEDIUM_RECEIVE_EN;
> +                       ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_MEDIUM_S=
TATUS_MODE,
> +                                         2, 2, &tmp16);
> +               }
> +       } else {
>                 ax88179_reset(dev);
> -       else
> -               ax179_data->initialized =3D 1;
> +       }
>
>         return 0;
>  }
>
> Best regards
> Jos=C3=A9 Ignacio
>


--=20
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

