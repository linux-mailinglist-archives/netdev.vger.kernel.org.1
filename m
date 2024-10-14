Return-Path: <netdev+bounces-135368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C888E99D9F1
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 01:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DDF282D4B
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 23:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C071C57B1;
	Mon, 14 Oct 2024 23:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nhaE/t44"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8407148826
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728946871; cv=none; b=NfuZlVy40vVX8nuLiaIeEGwg1jYwscFIsXNy5ixYB8RQf6DINJSoCmVDPXtV3SK58aSFMUSz4SN+xvETXOsHrDfRqcMTPnPVs3Pb9gQn8t7/t2NZIKiFB4jsItsqKDxZ1yn/Mkj7zEw3FGKKDxajkV+yhEmyHnZ0Qmk0q+9J9S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728946871; c=relaxed/simple;
	bh=pdm0OrgR020m1wg0Z5PfCUimmSwEKwH8LVeO6mpjzpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=to02iDVysiN0b/+ZKRVR2yV7uxQyRsBYmNuWeHb5EnAjhvh1tRDctqjuhqR0loIbz0S/92+MKzV2WrFv7VRd2Tx1qPxnjoGdxVdefOqL7u+w9feCkVO1LLGTDvgPEg+YvPx3BeqnTYhVLJeOX+quVzwmPK4HWX1ehbRfzMmfrug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nhaE/t44; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so8036184a12.1
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 16:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728946868; x=1729551668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEvhOYbhIILLB1qSYINeHhmw2BARcJ2f8Nui9BVtChY=;
        b=nhaE/t44I9fO4AVQxYIY6EGuYZ1RXOyEw8veMBkCH4Mno7SffuESfJKbP3W/zgSTaL
         tB7iHQvYuheB1RdOZQ3rZTHOdDUygBipctJFDRZkag6JIqO5249Z00fld5NNKMSkX5Ji
         nQJe9P+i8PnOXbGfjKrN/QguQ1HdxTvHBmSfPA6PiJ7PYq7G4xCnNi/KO9jZxRPZvIXE
         NXz9BIxmdscK92emPnUspaYLvZRoC7ROIfyMW5KHxzNwIDMqqcyhETLpjeDfYiso3J6k
         PRRZA9yvAZKXx8knnyrRi5ArPZBh4ZTd5TZbDQNF79+j0g39eNAzVrPT5WQ2tGnpB1g6
         8PTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728946868; x=1729551668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEvhOYbhIILLB1qSYINeHhmw2BARcJ2f8Nui9BVtChY=;
        b=Wh+Jl5npcacUH0CTGeZcfYi+KZXUC2QKPkvDSwxLnQEmO0eOONw4HU7ES+cCgu42iI
         AOHhN1Wat3gJBUXDkEKVLKEX8ahKKEY2u7RZvqUeICRldBJCDgw5n7uCH96lYysOaBSm
         COJqqVkzyzSMDAyb8fOb71O6h+8tgOyjAdzKnEzphgsABM8ylEE8z+dOcxYUYiIIIyV1
         BHUZ2+Z0PnLQZMfLAJxeFjmmaPLb3w7T2RHkBaBDZpHNQPZ9kjtQNeKbjAfNPXRtClwJ
         y9hN2wY0Cc51+1uSK92HqfQlGPqvEqjwVZj9FsRBBfZQ83BzKbcImxlkzD7Z8QJxw3RJ
         g6Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVNth1L8wwvSNE6nkfpfCWeqoZMRu2468R2miGcREyC2CXeA6oLy8/nBRR+op6NBsIaf3bQ8yI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmum2vXkspcg6VaJP0uE9AWYnsa0Wg2Bz8G4YUXvNb9++ogdqy
	B4+BMMRcRFdBXi8fDvkyFEnMg/xfPHNKKnOmco5DAbZpaBPXU2Z/GswA5Szt93ruAbGYdqGz7k8
	I88AUsh1SLrffozNrPTuG0rdYCIHJkmjWsvbD
X-Google-Smtp-Source: AGHT+IEF7BAH7BBqfFSuPVqFExLRaO9MfAeZQxaesgLe9iVoNzAIzQCDm8YKsl92mGXc4xE+dvinxkXcT4d7/GZsF20=
X-Received: by 2002:a05:6402:2352:b0:5c9:813a:b1c1 with SMTP id
 4fb4d7f45d1cf-5c9813ab2e9mr3253152a12.1.1728946867821; Mon, 14 Oct 2024
 16:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829175201.670718-1-oneukum@suse.com> <CANn89i+m69mWQw+V6XWCzmF84s6uQV15m_YdkPDQptoxUks4=w@mail.gmail.com>
 <fd906211-7f31-4daf-8935-2be1378a75f8@suse.com>
In-Reply-To: <fd906211-7f31-4daf-8935-2be1378a75f8@suse.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 15 Oct 2024 01:00:53 +0200
Message-ID: <CANn89iJWATVhMVDgq3fcV9zpZRt8nd_bWp3=qRHo8L3tJP==Kg@mail.gmail.com>
Subject: Re: [PATCHv2 net] usbnet: modern method to get random MAC
To: Oliver Neukum <oneukum@suse.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@kernel.org, 
	John Sperbeck <jsperbeck@google.com>, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 12:24=E2=80=AFAM Oliver Neukum <oneukum@suse.com> w=
rote:
>
> On 14.10.24 21:59, Eric Dumazet wrote:
>
> > As diagnosed by John Sperbeck :
> >
> > This patch implies all ->bind() method took care of populating net->dev=
_addr ?
> >
> > Otherwise the following existing heuristic is no longer working
> >
> > // heuristic:  "usb%d" for links we know are two-host,
> > // else "eth%d" when there's reasonable doubt.  userspace
> > // can rename the link if it knows better.
> > if ((dev->driver_info->flags & FLAG_ETHER) !=3D 0 &&
> >      ((dev->driver_info->flags & FLAG_POINTTOPOINT) =3D=3D 0 ||
> >       (net->dev_addr [0] & 0x02) =3D=3D 0))
> > strscpy(net->name, "eth%d", sizeof(net->name));
> >
>
> Hi,
>
> you need to have a MAC to be an ethernet device, don't you?

Before or after your patch, there was/is a MAC address, eventually random.

The problem is about the test, which is now done while dev->dev_addr
is full of zeroes, which is not a valid address,
as shown by :

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index e4775fb5a2f6..1a316773319f 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1750,7 +1750,8 @@ usbnet_probe (struct usb_interface *udev, const
struct usb_device_id *prod)
                // can rename the link if it knows better.
                if ((dev->driver_info->flags & FLAG_ETHER) !=3D 0 &&
                    ((dev->driver_info->flags & FLAG_POINTTOPOINT) =3D=3D 0=
 ||
-                    (net->dev_addr [0] & 0x02) =3D=3D 0))
+                    (is_valid_ether_addr(net->dev_addr) &&
+                     (net->dev_addr [0] & 0x02) =3D=3D 0)))
                        strscpy(net->name, "eth%d", sizeof(net->name));
                /* WLAN devices should always be named "wlan%d" */
                if ((dev->driver_info->flags & FLAG_WLAN) !=3D 0)

To be clear : We are hitting a regression after your patch was
backported to stable versions.

