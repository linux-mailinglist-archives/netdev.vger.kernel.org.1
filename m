Return-Path: <netdev+bounces-84649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51160897B7C
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 00:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6636B2132C
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC53156965;
	Wed,  3 Apr 2024 22:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4rpuTf/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38635138494
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 22:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712182564; cv=none; b=lxcUkAZ9NZJxr2Db0nsgnonAPzxRWq0a7z9VooAEqttVHFHFnaV585dKcVtbfaRzm5m1q0WX/Ni6/SJGNkBBNs4zluQd71lbH0RE4uuNX8lPXRBB4qPxmiAo9tfON7fj3Kk6ZLZKV1yVYxnr3nfz6MaADzkwMhnOKLrPdg6l/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712182564; c=relaxed/simple;
	bh=WqNrU7EaM47EAipbU9TtkJx+7wcKDH6mC9rbcixBLQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uzVJMC8ers8YSVCYHudU6dAGd4kUhd0pwVXFZffJ8/+H7S9ivkRmY1BsqHV0LyzsJ3C/0azW8RWRjknkhvIdLi0pQAXo2UfIJ8vjPP0WS32/z7AEb1zZmLLwDyQnimirARBse+2sKp1ZmBj085gdorshQl2G1ZYYrG3sAWTH0Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4rpuTf/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41569865b2fso2573825e9.3
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 15:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712182561; x=1712787361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7B19uHx+AxfwMezcloUsVyxYqe4WFB5lcQgQyKkWtg=;
        b=b4rpuTf/OGUJw27iArfHMyYs6y0wy1TlxG/1uh9h5JFG+J0OD/lnOi6TT3DiRcOv8p
         R6XYAtOi7hSVmSXatkzcySdM69zCD6ROhJoJK4Md7qIN+ivmPDm8I5Y0BP4hXObfETCh
         BF8fL9U03/JzSLRHXGqi3Ht/8T5jitHtik7LAYg/7zRSWgh2ebI6kECEwnLbtzzVFHVm
         zBuGDxThSo1mcg0aKZAl874r1M0xJ5le3+esfsDQTvujBlAt0nOsQAILwEGUJPYjLRBn
         FdsjxtJbKX8ZhDfz9stZsS0s6ejMmKvJuRCT+fhNvwYo2yywg+KEf7SY4qg7gc/NEaBH
         az7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712182561; x=1712787361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7B19uHx+AxfwMezcloUsVyxYqe4WFB5lcQgQyKkWtg=;
        b=DrIHsg2OI6buacQiDW65+qPhLL+z2MwyY8XW6zpiWIDUyvJsfTc7H1i9mS7pZ9yBlX
         kNSzEle5/eDeBkoKNlw56lpGM1NeqjNrQE7kO2Y/RLn4O7Y+gusJrsVaIlnh2qZ45mt1
         CEOpLsBppJVysOPRWK/daFlKgTy8SiBab0wke30BtLc3ez+Lb3tzcRwgrFdMT6zDTnXU
         +gXLh3oMoFnDGIJjZSiU+C4mhSRXP/A55Tkp3dhSkhQFUit2XOXNUHKT3ADLztfGeq/R
         mn5Z8dRvcuuc9Q4C0qkTgkfdbI22N96p9XU1Hkb6cVy3p7s5Gnb9IQJlKKMw0jw9PIxg
         iQTw==
X-Gm-Message-State: AOJu0YzB0PlM+pGptsMVtpSrHxkedZSj+hF6rRWaBmzmsGkVdVL8i+MR
	2/GsVEacWs2BSGberU19YZ7c087vc+pqJPj4n5fdApKE4hx3+VVIc8G19imkkHfathNQ1A2vrox
	Za2++mPH0FXRaWVW45KoIdbya/Fo=
X-Google-Smtp-Source: AGHT+IGWwHragMj8T9mer01PC4NkXuBDmJIotE7JBuwglGeGvxY25qeA0ROHRF5mJU2sLEo/jgE5w0FOYv/n8HHRAT8=
X-Received: by 2002:a5d:6b92:0:b0:343:41ba:bc68 with SMTP id
 n18-20020a5d6b92000000b0034341babc68mr525016wrx.32.1712182561299; Wed, 03 Apr
 2024 15:16:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217493453.1598374.2269514228508217276.stgit@ahduyck-xeon-server.home.arpa>
 <8b16d2b4-ef5c-4906-b094-840150980dc1@lunn.ch>
In-Reply-To: <8b16d2b4-ef5c-4906-b094-840150980dc1@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 3 Apr 2024 15:15:25 -0700
Message-ID: <CAKgT0UeO-Bv5twdgts0gSaO1qjd_Ze5ax5k0XYUPTeDcsDuyQA@mail.gmail.com>
Subject: Re: [net-next PATCH 07/15] eth: fbnic: allocate a netdevice and napi
 vectors with queues
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 1:58=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +static int fbnic_dsn_to_mac_addr(u64 dsn, char *addr)
> > +{
> > +     addr[0] =3D (dsn >> 56) & 0xFF;
> > +     addr[1] =3D (dsn >> 48) & 0xFF;
> > +     addr[2] =3D (dsn >> 40) & 0xFF;
> > +     addr[3] =3D (dsn >> 16) & 0xFF;
> > +     addr[4] =3D (dsn >> 8) & 0xFF;
> > +     addr[5] =3D dsn & 0xFF;
>
> u64_to_ether_addr() might work here.

Actually I think it is the opposite byte order. In addition we have to
skip over bytes 3 and 4 in the center of this as those are just {
0xff, 0xff } assuming the DSN is properly formed.

> > +
> > +     return is_valid_ether_addr(addr) ? 0 : -EINVAL;
> > +}
> > +
> > +/**
> > + * fbnic_netdev_register - Initialize general software structures
> > + * @netdev: Netdev containing structure to initialize and register
> > + *
> > + * Initialize the MAC address for the netdev and register it.
> > + **/
> > +int fbnic_netdev_register(struct net_device *netdev)
> > +{
> > +     struct fbnic_net *fbn =3D netdev_priv(netdev);
> > +     struct fbnic_dev *fbd =3D fbn->fbd;
> > +     u64 dsn =3D fbd->dsn;
> > +     u8 addr[ETH_ALEN];
> > +     int err;
> > +
> > +     err =3D fbnic_dsn_to_mac_addr(dsn, addr);
> > +     if (!err) {
> > +             ether_addr_copy(netdev->perm_addr, addr);
> > +             eth_hw_addr_set(netdev, addr);
> > +     } else {
> > +             dev_err(fbd->dev, "MAC addr %pM invalid\n", addr);
>
> Rather than fail, it is more normal to allocate a random MAC address.

If the MAC address is invalid we are probably looking at an EEPROM
corruption. If requested we could port over a module parameter we have
that enables fallback as you are mentioning. However for us it is
better to default to failing since the MAC address is used to identify
the system within the datacenter and if it is randomly assigned it
will make it hard to correctly provision the system anyway.

> > @@ -192,7 +266,6 @@ static int fbnic_probe(struct pci_dev *pdev, const =
struct pci_device_id *ent)
> >
> >       fbnic_devlink_unregister(fbd);
> >       fbnic_devlink_free(fbd);
> > -
> >       return err;
> >  }
>
> That hunk should be somewhere else.
>
>      Andrew

Good catch. That wasn't supposed to be there. Must have accidentally
dropped that line.

Thanks,

- Alex

