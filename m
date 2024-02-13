Return-Path: <netdev+bounces-71165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F40852891
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1532817BE
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 06:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A01125B2;
	Tue, 13 Feb 2024 06:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZAGO/2mQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD15429A9
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707804521; cv=none; b=BDPD+p/ww2rfLjnlYGwM3gHkE0CZfjLH2ao2sYy/tAIPi5UcqSF1Ey/pTRjgbRWTJTEg6UKtHZ1fNP+cwPIg4vwQh4QVu2SOnxRtNfKNfU7Zln8YCS4JSPUhw4OvUGcCpvN1X6Lmw9xwH8PYOTWhWJx6zW3CLOzgLftS0A9hExo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707804521; c=relaxed/simple;
	bh=HsvApL4NJgpVi1/bxgY0oH2l725a4FPceKak6s1n8fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/4KbxVynMgA8rq7TRz4C7Tj3BtxJn1UM42CafQTIMpJTAU2Hv5F/SlTx1zlnPVpVfyN5pAWqxkG2qcE8W0Vd8W3Cx8lNNHUEnpomaPbO8IUmbc2kb/V+MSD/blcNN3ScHyg5wiC+ln6MCOMEIV220lxcR549b6y+3WeLjJEN+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZAGO/2mQ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso4515a12.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707804518; x=1708409318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PfXVRVtdirJEsN9yyc/bgnnALf89nk9t69DaL5EPSw=;
        b=ZAGO/2mQ0XrB3I0LRuFDvgBMCpt639CPV6pysy9t/F/Sg7MVIGnCo953w6+55MP0j2
         xDfC14nGx08aKG9X0QqORJW/UlsckJzxpy7NiYj8OoIJT2lPpp8ogKhWMumbCGwaQbej
         RddUJbrns8BgBhdMePawwfN958cPtl/4hlvyF/usbH4QYa4uo+sYLKPs8cIBhz7sV77p
         /vwGBvdh1EeALH3HL8CciomBVqSbYs6xK9XPu7SwTTKAJ0SpY4NWiKvG02hjLPJ53J2d
         SvdLUcu51EuG1epYKtSYhTkjAS5hw4UzMX9MzP1Gwm+QmFRHWH7/J3Tk7DePz+G5pq7x
         8WHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707804518; x=1708409318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PfXVRVtdirJEsN9yyc/bgnnALf89nk9t69DaL5EPSw=;
        b=VnWywlQqnvoaylGuiJ+2ohkQ+1cAWARj7YE6nF3ERArQypaJ2L6es9HyTpRklDyu9o
         Et1eDZnttgVYl8n8ynLa4LeHZWckxSwbZKbAvV4SzY11TfRB98bZO26jpTWMywWjCrOt
         kmevPo3jhV5JAw/2nebgghXBTx9vLlRDjylVOLaVRp4wmhpHzvfblPdgFlC426ErK0Ga
         ZMDTsbNRiofhGHS0uH3bdZN29apKG25hp41WYD6pDhVvtT3vlkhpHBL5ijUibSzlUkjC
         67MDB0t9cg84KjIaSs7Ty02cVhhQz5QXYzt1tODppqtPevgUk3TIjPIGWvDebSbgutBL
         m92w==
X-Gm-Message-State: AOJu0Yzd6U1Ap4H0NwKDfUPbmdcagRmuzu8lRhIMcNjEZ2slc0r5RN5S
	Q0Xs8aNREVpDhTZPIbu6lWi6ITxXRJ37cluOZlBF9bw+PGBworm+stThZwQvi8RgdK+VESfh78o
	8rCPiW4N6EUo19HMEP0ia4MhgpVYXQ6maY9nMBjXKXALE2QHWhg==
X-Google-Smtp-Source: AGHT+IHieFiznCsDrRELh0V5sXxbt5idALztSaH8Rzkf3XaXDKHn/+mUhc2WubcKxRjsXpTNlxF0wgRCCXxYOxDlTFQ=
X-Received: by 2002:a50:cd59:0:b0:560:e82e:2cc4 with SMTP id
 d25-20020a50cd59000000b00560e82e2cc4mr41041edj.3.1707804517719; Mon, 12 Feb
 2024 22:08:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209203428.307351-1-edumazet@google.com> <20240209203428.307351-7-edumazet@google.com>
 <20240212175845.10f6680a@kernel.org>
In-Reply-To: <20240212175845.10f6680a@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 13 Feb 2024 07:08:23 +0100
Message-ID: <CANn89iKnMiAcp2h=RWjp52ucXkDMRJ7kbiiKqJ0iD_akVt3RCA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 06/13] net-sysfs: use dev_addr_sem to remove
 races in address_show()
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 2:58=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri,  9 Feb 2024 20:34:21 +0000 Eric Dumazet wrote:
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 24fd24b0f2341f662b28ade45ed12a5e6d02852a..28569f195a449700b640300=
6f70257b8194b516a 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -4031,6 +4031,7 @@ int dev_set_mac_address(struct net_device *dev, s=
truct sockaddr *sa,
> >                       struct netlink_ext_ack *extack);
> >  int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *=
sa,
> >                            struct netlink_ext_ack *extack);
> > +extern struct rw_semaphore dev_addr_sem;
>
> nit: this could potentially live in the net/core/dev.h header?

SGTM, I am taking a look.

>
> I could not spot any real problems but the series seems to not apply
> to net-next because of 4cd582ffa5a9a5d58e5bac9c5e55ca8eeabffddc

Right, of course, I will rebase and send v4, thanks !

