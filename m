Return-Path: <netdev+bounces-137052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5939A423B
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 17:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6B4281BC0
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 15:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DF7200C8A;
	Fri, 18 Oct 2024 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ex7sTEWR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2001FF60E
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264978; cv=none; b=ODQ8v/zIUytEL4mu5ImGZz2mkvUMEQyENVCdMjKstfB2raiylM26dkmOvqSAcqA88xYn2mSjYm7b/vEQHkyOXBIs2hZMb984o2od5u6ZeVogJGKK6N3vVVbXqyZL2Wh7uMTR0E7LrQcb408Q3UVB45A8w+HYHPhB37dJQVMS49s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264978; c=relaxed/simple;
	bh=ppghXajr7mhEOYXY5xWy2NDJw6Rv7mCbsa8gnAaqBBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gFuTEi7D42f0gk7/yimuq313jpFOOYWt9rsfAfIuaDHkFvstkI5vIZa8zrlGrfhWWIUs9QlmOTwCxgjwG5/0pO0zSt2B0epm0mqH4r8aPLuwVXIZQSDlXO4l1lIwL2pNx3k2Vb0NABGHuxhkhPylR6DWPaBuXXqe2lQnYlJmd5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ex7sTEWR; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539e4b7409fso2275714e87.0
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729264974; x=1729869774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvYOf2b92tGv/0UJsbZFFQLBbdVKWDuRIravkxYfymw=;
        b=ex7sTEWR7kMY4kp4SMCdopAiWpmUWFf4b/J7yH7vEPlSNc97MPoIMzyIfonhHjax5e
         kVAFXz0vuODKPwWNivFDsW0EGfAcqhOrSTpg/uMkg/Z6v1p216yD3dal6QJ9M2i8ozjz
         MM3+iW4NfIcIYENqAU6umA+lrSVPImWsMIYHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729264974; x=1729869774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvYOf2b92tGv/0UJsbZFFQLBbdVKWDuRIravkxYfymw=;
        b=lHhgOmEIHeZa9+uKzSH7nxd7/pINBvKYa2k1sSi/yVHPI6qxJ5MrExZ0ndcT1Jld1b
         1/C1dnezOkw7PgvLy6LWtWqIvZqB7x6+FKErcUeyHMUZWwvkNAk6vuGs4YoOdlVXznF6
         SRh64mTHZR5NYO8Q5wCIrLhnSK889/hYQKQM4UTMWkdQ9ijBRYrz7Q9SqakuyO2uM97E
         VWm+s4uszlhjjKDovnDKv5SpTLpsFsn0/V0nj8/d5UfVkxCwI0vEWXQMvTu8GMCSaAHv
         Io8ihfHfdD+zjtM8omYdW4Dk4jh7IgbKWYctsNC+unnv0EjPTWu8CfCZLc4jcQEaw4LP
         lipQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGBMuaXscTJeNSr7hCHoSSTvnYDUaN0o4HhEnHgglJtEl7e4KCtW3KzbznTNVmXSixA2PimxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsTWcsowzQR7fdaZaONPuiZLkbXWV3ZW/Q/0MkZaiCiQxiT5IT
	5ebaAEmylcUtfOxVNRrnhnL1Ia1a+glJxiD03Njy09RVI/z8LLUxOSyvgkD5hxKTODOVkh3kLOI
	+GeZc
X-Google-Smtp-Source: AGHT+IH3A85/KATihzZM47/R/yOlLhhPEPO9/KIlAzGZj63LdTDQ7Lw00TQVQ5r2eUwvNVUAIDgX7g==
X-Received: by 2002:a05:6512:3985:b0:539:fc50:915f with SMTP id 2adb3069b0e04-53a0c6a58a4mr2497078e87.2.1729264974152;
        Fri, 18 Oct 2024 08:22:54 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151aff00sm241020e87.5.2024.10.18.08.22.52
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 08:22:52 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539e4b7409fso2275663e87.0
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 08:22:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWYuhWf3En/ouvvU5L0pzKCGRreyrUmNUKKeJNxpwFdpBjY08T5N05dU+QsBUANkOf42Qxka+Y=@vger.kernel.org
X-Received: by 2002:a05:6512:39cd:b0:539:ea33:c01b with SMTP id
 2adb3069b0e04-53a158456e9mr874666e87.9.1729264972196; Fri, 18 Oct 2024
 08:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018141337.316807-1-danielgeorgem@chromium.org>
In-Reply-To: <20241018141337.316807-1-danielgeorgem@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 18 Oct 2024 08:22:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XNTgzccjkQOnuTcYtaUK+ZRU1DbqYdnNOOD+TrVGn9xA@mail.gmail.com>
Message-ID: <CAD=FV=XNTgzccjkQOnuTcYtaUK+ZRU1DbqYdnNOOD+TrVGn9xA@mail.gmail.com>
Subject: Re: [PATCH] r8152: fix deadlock in usb reset during resume
To: George-Daniel Matei <danielgeorgem@chromium.org>
Cc: "David S. Miller" <davem@davemloft.net>, Hayes Wang <hayeswang@realtek.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Grant Grundler <grundler@chromium.org>, linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 18, 2024 at 7:13=E2=80=AFAM George-Daniel Matei
<danielgeorgem@chromium.org> wrote:
>
> rtl8152_system_resume() issues a synchronous usb reset if the device is
> inaccessible. __rtl8152_set_mac_address() is called via
> rtl8152_post_reset() and it tries to take the same mutex that was already
> taken in rtl8152_resume().

Thanks for the fix! I'm 99% certain I tested the original code, but I
guess somehow I ran a different code path. I just put my old hacky
test patch [1] back on and re-tested this to see what happened. OK, I
see. In my case dev_set_mac_address() gets called at resume time but
then the address hasn't changed so "ops->ndo_set_mac_address()" (which
points to rtl8152_set_mac_address()) never gets called and I don't end
up in the deadlock. I wonder why the MAC address changed for you. In
any case, the deadlock is real and I agree that this should be fixed.

BTW: it would be handy to include the call stack of the deadlock in
your commit message.

[1] https://crrev.com/c/5543125

> Move the call to reset usb in rtl8152_resume()
> outside mutex protection.
>
> Signed-off-by: George-Daniel Matei <danielgeorgem@chromium.org>

Before your Signed-off-by you should have:

Fixes: 4933b066fefb ("r8152: If inaccessible at resume time, issue a reset"=
)


> ---
>  drivers/net/usb/r8152.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index a5612c799f5e..69d66ce7a5c5 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -8564,19 +8564,6 @@ static int rtl8152_system_resume(struct r8152 *tp)
>                 usb_submit_urb(tp->intr_urb, GFP_NOIO);
>         }
>
> -       /* If the device is RTL8152_INACCESSIBLE here then we should do a
> -        * reset. This is important because the usb_lock_device_for_reset=
()
> -        * that happens as a result of usb_queue_reset_device() will sile=
ntly
> -        * fail if the device was suspended or if too much time passed.
> -        *
> -        * NOTE: The device is locked here so we can directly do the rese=
t.
> -        * We don't need usb_lock_device_for_reset() because that's just =
a
> -        * wrapper over device_lock() and device_resume() (which calls us=
)
> -        * does that for us.
> -        */
> -       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> -               usb_reset_device(tp->udev);
> -
>         return 0;
>  }
>
> @@ -8681,6 +8668,19 @@ static int rtl8152_suspend(struct usb_interface *i=
ntf, pm_message_t message)
>
>         mutex_unlock(&tp->control);
>
> +       /* If the device is RTL8152_INACCESSIBLE here then we should do a
> +        * reset. This is important because the usb_lock_device_for_reset=
()
> +        * that happens as a result of usb_queue_reset_device() will sile=
ntly
> +        * fail if the device was suspended or if too much time passed.
> +        *
> +        * NOTE: The device is locked here so we can directly do the rese=
t.
> +        * We don't need usb_lock_device_for_reset() because that's just =
a
> +        * wrapper over device_lock() and device_resume() (which calls us=
)
> +        * does that for us.
> +        */
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> +               usb_reset_device(tp->udev);

You seem to have moved this to the wrong function. It should be in
rtl8152_resume() but you've moved it to rtl8152_suspend(). As you have
it here you'll avoid the deadlock but I fear you may end up missing a
reset. Maybe you didn't notice this because commit 8c1d92a740c0
("r8152: Wake up the system if the we need a reset") woke us up
quickly enough and the previous reset hadn't expired yet?

In any case, please move it to the rtl8152_resume() function, re-test,
and post a new version.

-Doug

