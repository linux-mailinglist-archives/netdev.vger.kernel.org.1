Return-Path: <netdev+bounces-49595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C757F2A4C
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 11:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C2F8B21A9C
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 10:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD9446521;
	Tue, 21 Nov 2023 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcMo4c7D"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6B9F4
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 02:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700562315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kv793GlpUAibpHSviUbIOlEfqFoGFgwrV0FjBE/F+mY=;
	b=LcMo4c7D4Q30BsqeI0HSIdtwmMDEVDuyZTTxIux7PuxNTL9l2tTnwd0WGQBEwyryJmA28h
	EjSR/7GdQjfD6Hbpe9rVS6OKlaTqnp0Wqi+FWiMMzoPj0GMk6Fj1TGvhwgQzoFRZS/ZGgs
	dy7dnt/y9PF15A32Wxgq6GVl+Mvvtck=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-wnunOsq4Pt-2sZGhETXKUQ-1; Tue, 21 Nov 2023 05:25:13 -0500
X-MC-Unique: wnunOsq4Pt-2sZGhETXKUQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ff9b339e8cso15800866b.1
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 02:25:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700562312; x=1701167112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kv793GlpUAibpHSviUbIOlEfqFoGFgwrV0FjBE/F+mY=;
        b=e262vUVGx5EEzc9EmtvaHzYxarNwNq1AWmBD1pk4YtN/IXIjCsf84QKh7RxIw4qtJ2
         FhlMViA8WJt0WBJxfUdh2A6SGIDjz2RBueqA4Y37y4wbyfmbTehDUyTF3+00sWPWZLFM
         M7qkeGJlyQ4DN92U/3T+uzc6pNiNBWG3o3g6sMymwTQXSSGm0L03DGw1e20YKXQZU8a+
         084yvfCcpu/QNa3wUZuEFabPqVy4HvObopxAFqxiwbZ5+tkyCXKKOGK5QcVsBJHbfid5
         ygOaTsZ5BVyDRVMjY96uMIukL6Whshy4AKX0i9v1dkgYTcef4fI1SA8JUobd6taLnRpn
         X94w==
X-Gm-Message-State: AOJu0YyVDPeqdw9aEkLBrUskqLS59NnWhMr9D4eF6mlQOjNHhd8BH81+
	axq+ITM8/owuzrqVXR5HPjy0VNPTbB7piaPPNlOT65mnWRym107z5aodKsCTUxxLdV1YAPapq9i
	vIVz4j4RbCSQ2gKuW
X-Received: by 2002:a17:906:20d7:b0:9b2:bf2d:6b65 with SMTP id c23-20020a17090620d700b009b2bf2d6b65mr6470909ejc.4.1700562312009;
        Tue, 21 Nov 2023 02:25:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+UJk+zZlK5NUPrng8ZM0MjQUSFGh7RXz8MfiFQKiFHg+caQVnu7yUEILkX7uCjm3wmWC4VA==
X-Received: by 2002:a17:906:20d7:b0:9b2:bf2d:6b65 with SMTP id c23-20020a17090620d700b009b2bf2d6b65mr6470882ejc.4.1700562311351;
        Tue, 21 Nov 2023 02:25:11 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-234-2.dyn.eolo.it. [146.241.234.2])
        by smtp.gmail.com with ESMTPSA id i26-20020a170906a29a00b00a01892903d6sm866248ejz.47.2023.11.21.02.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 02:25:10 -0800 (PST)
Message-ID: <f8c1979e2c71d871998aec0126dd87adb5e76cce.camel@redhat.com>
Subject: Re: [PATCH 1/2] r8152: Hold the rtnl_lock for all of reset
From: Paolo Abeni <pabeni@redhat.com>
To: Douglas Anderson <dianders@chromium.org>, Jakub Kicinski
 <kuba@kernel.org>,  Hayes Wang <hayeswang@realtek.com>, "David S . Miller"
 <davem@davemloft.net>
Cc: Grant Grundler <grundler@chromium.org>, Simon Horman <horms@kernel.org>,
  Edward Hill <ecgh@chromium.org>, linux-usb@vger.kernel.org, Laura Nao
 <laura.nao@collabora.com>, Alan Stern <stern@rowland.harvard.edu>,
 =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,  Eric Dumazet
 <edumazet@google.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Tue, 21 Nov 2023 11:25:09 +0100
In-Reply-To: <20231117130836.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
References: 
	<20231117130836.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-11-17 at 13:08 -0800, Douglas Anderson wrote:
> As of commit d9962b0d4202 ("r8152: Block future register access if
> register access fails") there is a race condition that can happen
> between the USB device reset thread and napi_enable() (not) getting
> called during rtl8152_open(). Specifically:
> * While rtl8152_open() is running we get a register access error
>   that's _not_ -ENODEV and queue up a USB reset.
> * rtl8152_open() exits before calling napi_enable() due to any reason
>   (including usb_submit_urb() returning an error).
>=20
> In that case:
> * Since the USB reset is perform in a separate thread asynchronously,
>   it can run at anytime USB device lock is not held - even before
>   rtl8152_open() has exited with an error and caused __dev_open() to
>   clear the __LINK_STATE_START bit.
> * The rtl8152_pre_reset() will notice that the netif_running() returns
>   true (since __LINK_STATE_START wasn't cleared) so it won't exit
>   early.
> * rtl8152_pre_reset() will then hang in napi_disable() because
>   napi_enable() was never called.
>=20
> We can fix the race by making sure that the r8152 reset routines don't
> run at the same time as we're opening the device. Specifically we need
> the reset routines in their entirety rely on the return value of
> netif_running(). The only way to reliably depend on that is for them
> to hold the rntl_lock() mutex for the duration of reset.

Acquiring the rtnl_lock in a callback and releasing it in a different
one, with the latter called depending on the configuration, looks
fragile and possibly prone to deadlock issues.

Have you tested your patch with lockdep enabled?

Can you instead acquire the rtnl lock only for pre_reset/post_rest and
in rtl8152_open() do something alike:

	for (i =3D 0; i < MAX_WAIT; ++i) {
		if (usb_lock_device_for_reset(udev, NULL))
			goto error;

		wait_again =3D udev->reset_in_progress;
		usb_unlock_device(udev);
		if (!wait_again)
			break;

		usleep(1);
	}
	if (i =3D=3D MAX_WAIT)
		goto error;

which should be more polite to other locks?


Thanks,

Paolo


