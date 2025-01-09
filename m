Return-Path: <netdev+bounces-156862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A064EA080CF
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 20:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 193757A3F97
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 19:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73BA204F83;
	Thu,  9 Jan 2025 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O1LETRJf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBD92046B4
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736452118; cv=none; b=Pdy2avzkZtouS74ITu6gg4+y22E+jBn6/eNa6ryt5nDZU13tfX1a1xoC8wTaZ7qpzlSiSrmANvWUvG1ng67qAh2WtAelEWaPTmhzxIWVX8IY6eShQzyxjAcks4oTdJqhEdHbf0cskbK2h74VKlOY8XzDSs3HzFWupdzAEAfZ3Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736452118; c=relaxed/simple;
	bh=A1ZSHCYJmXkn/CmQy4S67LM7KhhQej4dgSmnf6OI8JE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5WX2Qdf6KlwvM34kSAU41GNh/7lNEjhgYJCGQaIlKufKIGXBWQ0us+dXEByFuBp6IIgvmtQ4FXNunr5I2LBiVgpxEUbvtANfOwHT30kM2Jlaz/ZomV2XvieJKdVuKdWVD8XwPLQuLUyz1WGYgILixqQUQPC11+YRFGctDV5hmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O1LETRJf; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30227ccf803so10873341fa.2
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 11:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736452115; x=1737056915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nASWSc319MsBi8srS8z1TIiC4jReGLISSvwvsA4in0=;
        b=O1LETRJfXp3Sd5OzsKrqd0+WVwlMgvyoWe8xEDTTGbVskwa9HE9vsSmFNnh4tGDiDV
         gpHWKYgtDzWFq5zBkVEkjfXcJPr7PjZm6cSIUwlCEXL8bxm8J9b5OIxYDpPrK41UuuHc
         SX+OBHytxbd2Ws77nL3NmH8tJafHIQAPQ7TFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736452115; x=1737056915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nASWSc319MsBi8srS8z1TIiC4jReGLISSvwvsA4in0=;
        b=qe2z5Th+Y0cDE0Im8ncRRnXhOzjJFaPLj23JDsXoiiGInmDV/Ud0Yh8SSamVje1/3L
         qZVgKDh2U14uEFEGRhpNX2t3uiANwz7ov22H58vcl0NIpk0X4xq1Re2pZMvM/cYlWjrm
         pdTTCfC5uUbd23R4o1cDgpD4GsbbnFT8GQM7pWlYZqLscUMHlUwGj3rCTqIPcG8ESUAD
         +q1RlP62G5D0l2l6qvS10e3EwkaxB9phVbjlfpMeNAm8P6othvSgN05nlTMMHp8bcW0l
         jp2W87drCLSEQ4rgJBcs7+gA638fmq1RjvPPElpPJi1otsX26RibweB04LhM8VT/NyhA
         f9Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWmrFIJp8kfoLEsDmrxgqLtbi0RSAFBBYqUZGug6hqrdiEn0R/gpfN5XfbhIHHoH54syjiZhoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk+X6ytAs3/NUbMLRG5f6NGPjXKsPyAs4cT27wSLr/YdWHCqwC
	unXOZokCpfkXJzvGUGEl/uyg/+zpVpCGkUvmpXHuFwM5+ooKwGR5nFP3PTZBmlmKmsUaK25wBhe
	AizCtJapDMxqaM2Vh0+QB7w6B7I+/4SR0eZB4
X-Gm-Gg: ASbGncuA1nUhVAE+hz1Bcj4oefuvc54yfg+d2cBISBhk6+z438S1t3SVVqwOv6daqAW
	0zTHJu6VTZ0oGTnOCZkFc/+NdprJjTAB8nZsHtw==
X-Google-Smtp-Source: AGHT+IE2pUxNr9y8auDkQkOmn0RFC0afiW6kU6wLyV8qzA0mGIOwVF43JjW+X9L5FohPrZsluloTiO1+i+5PG9bHCLc=
X-Received: by 2002:a2e:bea4:0:b0:302:4a4e:67da with SMTP id
 38308e7fff4ca-305f45d63c1mr22909751fa.36.1736452115272; Thu, 09 Jan 2025
 11:48:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218203740.4081865-1-dualli@chromium.org> <20241218203740.4081865-3-dualli@chromium.org>
 <Z32cpF4tkP5hUbgv@google.com> <Z32fhN6yq673YwmO@google.com>
 <CANBPYPi6O827JiJjEhL_QUztNXHSZA9iVSyzuXPNNgZdOzGk=Q@mail.gmail.com>
 <Z4Aaz4F_oS-rJ4ij@google.com> <Z4Aj6KqkQGHXAQLK@google.com>
In-Reply-To: <Z4Aj6KqkQGHXAQLK@google.com>
From: Li Li <dualli@chromium.org>
Date: Thu, 9 Jan 2025 11:48:24 -0800
X-Gm-Features: AbW1kvYT36YsREJhGRA4AjMBM6CD1GV5E-7pI5qOkbX1jFhtIZzRamOCWqsWipg
Message-ID: <CANBPYPjvFuhi7Pwn_CLArn-iOp=bLjPHKN0sJv+5uoUrDTZHag@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] binder: report txn errors via generic netlink
To: Carlos Llamas <cmllamas@google.com>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	donald.hunter@gmail.com, gregkh@linuxfoundation.org, arve@android.com, 
	tkjos@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, surenb@google.com, arnd@arndb.de, masahiroy@kernel.org, 
	bagasdotme@gmail.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, netdev@vger.kernel.org, hridya@google.com, 
	smoreland@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the suggestion!

Cleaning up in the NETLINK_URELEASE notifier is better since we
register the process with the netlink socket. I'll change the code
accordingly.

On Thu, Jan 9, 2025 at 11:30=E2=80=AFAM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> On Thu, Jan 09, 2025 at 06:51:59PM +0000, Carlos Llamas wrote:
> > Did you happen to look into netlink_register_notifier()? That seems lik=
e
> > an option to keep the device vs netlink socket interface from mixing up=
.
> > I believe we could check for NETLINK_URELEASE events and do the cleanup
> > then. I'll do a quick try.
>
> Yeah, this quick prototype worked for me. Although I haven't looked at
> the api details closely.
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 536be42c531e..fa2146cf02a7 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> +static int binder_netlink_notify(struct notifier_block *nb,
> +       +       +       +        unsigned long action,
> +       +       +       +        void *data)
> +{
> +       struct netlink_notify *n =3D data;
> +       struct binder_device *device;
> +
> +       if (action !=3D NETLINK_URELEASE)
> +       +       return NOTIFY_DONE;
> +
> +       hlist_for_each_entry(device, &binder_devices, hlist) {
> +       +       if (device->context.report_portid =3D=3D n->portid)
> +       +       +       pr_info("%s: socket released\n", __func__);
> +       }
> +
> +       return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block binder_netlink_notifier =3D {
> +       .notifier_call =3D binder_netlink_notify,
> +};
> +
>  static int __init binder_init(void)
>  {
> +       int ret;
> @@ -7244,6 +7259,8 @@ static int __init binder_init(void)
> +       +       goto err_init_binder_device_failed;
> +       }
>
> +       netlink_register_notifier(&binder_netlink_notifier);
> +
> +       return ret;
>
>  err_init_binder_device_failed:
>
>
> With that change we get notified when the socket that registered the
> report exits:
>
>   root@debian:~# ./binder-netlink
>   report setup complete!
>   ^C[   63.682485] binder: binder_netlink_notify: socket released
>
>
> I don't know if this would be the preferred approach to "install" a
> notification callback with a netlink socket but it works. wdyt?
>
> --
> Carlos Llamas

