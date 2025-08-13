Return-Path: <netdev+bounces-213277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 399CEB24551
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 11:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811BD189D490
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 09:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03762F2919;
	Wed, 13 Aug 2025 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8v0Ikfy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6492F1FD7;
	Wed, 13 Aug 2025 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077027; cv=none; b=M2XJ2Fap061jIL0+bhwzHMPrr6xglxtGEIA2OqzaMXXg7zKDTWgD5dz7ligq7hMvTOCsaXa0P8oeE3PB3LPhBcT5IApvcT4Ch6u0LVQTCq9dDwdxXaAczUpEWDU4UW1zU2irJJUKNYL4S7M26RlFgrlpW0dasJvy2BEw5PrNdBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077027; c=relaxed/simple;
	bh=E0xYFpZkL457C0Z5HToEfdjLCChdMVI567k28qFYll4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+GMmsxcnrsG5X5t9H7VhKxqFTy2eAVzzF7A1EgrZu2TVxWgszWoizw1rnskZ+MjjLbnSJCVKAs5BtN0DRNMQl6hIk/65CZWdkbkM3tGfWUWtUx/U/reNz1IcsAk584kUoCCv4yre9lJONqljcFXnIMApqZEE+aiujPf3W62h+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8v0Ikfy; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-af98841b4abso1051146866b.0;
        Wed, 13 Aug 2025 02:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755077024; x=1755681824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nt3RxAJI4fKupz8WilY+ZuWni2sRIcUdlVwAYfMMlGU=;
        b=D8v0IkfynAgIumPS1U31XNL33y2/C+SeK9LcpjykteMiF2KO0YEOc0abdqobymEuYD
         MoALA1ZzfOHPl8Aqg5zzufDWHOpKTqrjI4tJWvWardDJLP/uus62vwovS4y9813C2eVR
         yd0T2k+c7p2L9EYtMutnxmhsgWiHcdvMluE8HkoYuFNKuQnp6TVWCA18uyHMyXh0ZVQX
         9pjjl4z8G/CN6EE7c01+2EqZEpmpMPS4nyjbzElfVGUa38oPcqHBXvnwPAAgVDYFAXFU
         i962VFQJzmdl4jlU8PTpHunR4zEXTqDWBLCh8XeLh30z+iNuGbxv/b2Tr22GjvwGQzY/
         Cf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755077024; x=1755681824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nt3RxAJI4fKupz8WilY+ZuWni2sRIcUdlVwAYfMMlGU=;
        b=JsSb4D0nsHdPooXqPKkeGTlpHnH7gfSd2BSfpNTx1E1jam5Ylop481DvVy7SBBeR3o
         40srIdFOFzn1M8JJcZ2EBBNIJPmkoPyGU1BEkH4bDgvTCPgbjCITjB9ACx4udNv+Hnm4
         bgLijEJb0NjIKly7pXdwaFtjz9tdHLge1rUWqe0URprP7lZWvZ2FZYftuHmUb5RcNnEq
         jfrXtSPi+cNXVs6tF8T15MDUPmCOegKAHTX4hfbwUABRJcW2cm2vyMZOaKDEIKCTAI6V
         WwKiRbV+vg+yE1TCgCtLvaveK0H/kefEcuihtnVAmOh8PGEbazjf8y1ubwmb1vv7p3ld
         K6WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUipH13xataUX87ZX4Z8H+XFYxVCns/F9ht7G6WvgrkzEImG8nMoyxjqDnWQAVc17ra9sbaDZHl@vger.kernel.org, AJvYcCXypnmSUCgU25PEyNKNb1qWHPC69mjiI5XASSfIhYbMCaheKZuprYW6jzLZuRASHw5kHz1jIqz8lZJ6S0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz12vugwqJooFi6Rek6k8zF5lsSJdUDYoCfHSbeozs7Y/EZORHl
	9ixUkVD5gLcXsqgk9AK17szfE1SUtVl02YEZnXn7zKTmcabFyxwJ1z50VeMeBMEUzmy+rUKbNvg
	FXFCLk8vPUP77OtPypekenAr9O0wtXb0=
X-Gm-Gg: ASbGnctLoEvTgh/hmLIbnJg9ZyPyWOofKHyC/5y43SDAa93D6QfDj4PigCdyTOoJ4Fb
	ynynoTISIbXAAOE0c1S/BWJIKHynqhrGMM6hYl4CXwP3x0sH3DHcIjajHxVp/dO91bz7uNYbjdu
	tjmmnXVcBslzj/4V0cucL6PsVoJpwqVZ5KIgDa7H7yaakIn/aK2ZFBqRWQcXgYgMHVycvk0GEL0
	IjgBhPyVmQKrytkKylpWgf913pa+1I6L887ve4=
X-Google-Smtp-Source: AGHT+IFWoqZ0GUuQxqb111LCAFrVz98IE+57VOHZdvREo1rpyYl1kzzlNp+a1qY/hqeDh1haW/eWTRkKsAum8Y7HPhk=
X-Received: by 2002:a17:907:3f0b:b0:ae9:c789:13f9 with SMTP id
 a640c23a62f3a-afca4e44435mr212623466b.30.1755077023940; Wed, 13 Aug 2025
 02:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812131056.93963-1-tianyxu@cisco.com> <1940cd0a-f6c5-47ae-abaf-31a5f3579159@molgen.mpg.de>
In-Reply-To: <1940cd0a-f6c5-47ae-abaf-31a5f3579159@molgen.mpg.de>
From: Tianyu Xu <xtydtc@gmail.com>
Date: Wed, 13 Aug 2025 17:23:32 +0800
X-Gm-Features: Ac12FXypgyj_emLqfdF9BnTwWu2UN7VrhA9-QuqJEOoTcIBHQB9cysKCzdD-Mf8
Message-ID: <CAF-tjThBebBj3auCam04nMV44j5LNhXnfRKYy6_jjM49wWCOmg@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2] igb: Fix NULL pointer dereference in
 ethtool loopback test
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, kuba@kernel.org, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tianyu Xu <tianyxu@cisco.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Joe Damato <joe@dama.to>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,
On my board with i210 NIC, "ethtool -t eth0" got the NULL pointer dereferen=
ce.
After the fix, "ethtool -t eth0" works well.

Kind regards,
Tianyu.


Paul Menzel <pmenzel@molgen.mpg.de> =E4=BA=8E2025=E5=B9=B48=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=BA=8C 22:00=E5=86=99=E9=81=93=EF=BC=9A
>
> Dear Tianyu,
>
>
> Thank you for your patch.
>
> Am 12.08.25 um 15:10 schrieb Tianyu Xu:
> > The igb driver currently causes a NULL pointer dereference when executi=
ng
> > the ethtool loopback test. This occurs because there is no associated
>
> Where is this test located? Or, how do I run the test manually?
>
> > q_vector for the test ring when it is set up, as interrupts are typical=
ly
> > not added to the test rings.
> >
> > Since commit 5ef44b3cb43b removed the napi_id assignment in
> > __xdp_rxq_info_reg(), there is no longer a need to pass a napi_id to it=
.
> > Therefore, simply use 0 as the last parameter.
> >
> > Fixes: 2c6196013f84 ("igb: Add AF_XDP zero-copy Rx support")
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Reviewed-by: Joe Damato <joe@dama.to>
> > Signed-off-by: Tianyu Xu <tianyxu@cisco.com>
> > ---
> > Thanks to Aleksandr and Joe for your feedback. I have added the Fixes t=
ag
> > and formatted the lines to 75 characters based on your comments.
> >
> >   drivers/net/ethernet/intel/igb/igb_main.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/et=
hernet/intel/igb/igb_main.c
> > index a9a7a94ae..453deb6d1 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > @@ -4453,8 +4453,7 @@ int igb_setup_rx_resources(struct igb_ring *rx_ri=
ng)
> >       if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
> >               xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
> >       res =3D xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
> > -                            rx_ring->queue_index,
> > -                            rx_ring->q_vector->napi.napi_id);
> > +                            rx_ring->queue_index, 0);
> >       if (res < 0) {
> >               dev_err(dev, "Failed to register xdp_rxq index %u\n",
> >                       rx_ring->queue_index);
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
>
> Kind regards,
>
> Paul

