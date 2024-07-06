Return-Path: <netdev+bounces-109651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29439294C8
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 18:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8711F21591
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 16:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153957172F;
	Sat,  6 Jul 2024 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOa1RKdj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BC0C8E1
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720284515; cv=none; b=U4MbFoBgCS0gu+BMPbs+0PGhi9wibH7kx+z7lItKTCuRm74mSLKyeCmVZaRT8AAGR0M+yTEulljbW8xIN6PjRSG+6BhXrspKYxc37ucSwv0BRKJ79X1XCGZZ3y7JON1p5XG/3bC5axw28Wxxy1DpGfG3N4xxDosiV64sjDLkdhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720284515; c=relaxed/simple;
	bh=+xNMV8tbE9ghTRtpssHOlfarJJ1m/ghQqww+NxBpHbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkdd81d9NB+BK6lvNpjTXMNbYNfLdCRkPdooJLEJRJsZmf0yAkD78g3U9AY85+Ox82FjwttK5zf0nfwRMRP/7FfiMl8SWd5Px3VDH1qzhOeTZNOVI0TR905BBMUB7AUeqwjoKCT2Fv7Q4bio3mF4bKYUiBrLJ3oOISyqo2ipCuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOa1RKdj; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so34312491fa.3
        for <netdev@vger.kernel.org>; Sat, 06 Jul 2024 09:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720284511; x=1720889311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUPXvQpJen0lN1xAyXT1R92f680GKn6rKxdtB9rMRZM=;
        b=OOa1RKdjvi3+SpJFLtMdnErmCXUFq7PRh17xh/k/DkO4flTgxKTZFuonNCglx1xhg7
         ChZ5PVxPE3RJPn3lGCO+8oBBCb+ua+Cri8fd6KblbPoRZ/QtR3CmeoTR1JeIhxUaYAyz
         BhSYMiZw8mvHoo8HjYSeyNQZvpV6V99FnBLImbifjcDLbw+CDPS2zbMPuoB4uAx1iGJ4
         CrQeW6HTLzpUV//0K5r//lW2hiqSvb4A2YJniNZPpCmyoeJbG5M8dRQa78QQ1gw/50MD
         /IrnAGbEN6eCx8NiYkp1fHsXzAKsn1+7Kjj+C6+nhiFShcTx07S8WqxocE/yh7LpuoU+
         W48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720284511; x=1720889311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUPXvQpJen0lN1xAyXT1R92f680GKn6rKxdtB9rMRZM=;
        b=YLja7edl5R7RyJUDdJkdSyNGNB8aPvMR4H2k7lp1t/iHpx7u1KeyuDfuj6P63P6SnR
         LeE5At3kb+4aY41cnvy2rFH09R4rxyNb23nmkUxtasxJn47jMqes6iv+qtZF63G9EUSe
         lHd2z/8r597cITQ1W5oduxMXRSSZ7LIXqDYRCwljPVJPJXoBalTd+2i/ScrYCxCA+wtG
         WpiLHhO4eqQ3MCRyiPlRiidNpdYmp0UA+Oan38r7+2lKi7HkDu9nKqdt4KOpFtB8N9Eh
         zxVeuVpcSV2Xq44pkIff1Lxb/9NMr/KGJcAkV9Izq3oq40AEZd+uJTvo3oUu23WY7iws
         N2lg==
X-Forwarded-Encrypted: i=1; AJvYcCXjq+4rl/lOyRheJIWB645HlXT0PxtDWLmG48iO+ZQ3/AA71j/ha0bKHW22zOJlru5+/ezr/anX7LfnUW36XbmejRvVzdo9
X-Gm-Message-State: AOJu0YxOG7klkhWTn1DUgzCCRrP4263BIMCYBJiBS9/QMCSIyN89w8vM
	BWDO7L5b6huHC01fBBAq4umbHeRy+AjFWfnpWJmCqX9DNIMbkEzFstKnaTi1eN75KOOoNpN58ho
	WNkRJS61G17lcOwPvV/pcUaQL/ZQ=
X-Google-Smtp-Source: AGHT+IEic34icDRawiIyTkDdxkoBIbsrGgnaaqV6rFQzmC90XsOKTDOch8mOWJIbTie9q1acWJ6sMic7hnOs3WGRswA=
X-Received: by 2002:a2e:3309:0:b0:2ec:2314:3465 with SMTP id
 38308e7fff4ca-2ee8ed66c1cmr48388011fa.11.1720284511143; Sat, 06 Jul 2024
 09:48:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171993231020.3697648.2741754761742678186.stgit@ahduyck-xeon-server.home.arpa>
 <171993242260.3697648.17293962511485193331.stgit@ahduyck-xeon-server.home.arpa>
 <ZoQ3LlZZ47AJ5fnL@shell.armlinux.org.uk> <CAKgT0UcPExnW2jcZ9pAs0D65gXTU89jPEoCpsGVVT=FAW616Vg@mail.gmail.com>
 <281cdc6a-635f-499d-a312-9c7d8bb949f1@lunn.ch> <CAKgT0UcAYxnKkCSk7a3EKv6GzZn51Xfrd2Yr0yjcC2_=tk9ZQA@mail.gmail.com>
 <e7527f49-60a2-4e64-a93b-c72ad2cc4879@lunn.ch> <CAKgT0UfbUrVR6U-cbNxufQ0MN9Cna0tdC6dPMBJRAHSdj5=C8Q@mail.gmail.com>
 <d2bb35c5-8c88-4d59-9e6f-4f49625317b5@lunn.ch>
In-Reply-To: <d2bb35c5-8c88-4d59-9e6f-4f49625317b5@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sat, 6 Jul 2024 09:47:54 -0700
Message-ID: <CAKgT0Ue5D8_75DOTbJtSgbGoGExt5P=K4PBNfzy1LNM_7q+MYg@mail.gmail.com>
Subject: Re: [net-next PATCH v3 11/15] eth: fbnic: Add link detection
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 6:27=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Jul 02, 2024 at 01:59:41PM -0700, Alexander Duyck wrote:
> > On Tue, Jul 2, 2024 at 1:37=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wro=
te:
> > >
> > > > > As for multiple PCS for one connection, is this common, or specia=
l to
> > > > > your hardware?
> > > >
> > > > I would think it is common. Basically once you get over 10G you sta=
rt
> > > > seeing all these XXXXXbase[CDKLS]R[248] speeds advertised and usual=
ly
> > > > the 2/4/8 represents the number of lanes being used. I would think
> > > > most hardware probably has a PCS block per lane as they can be
> > > > configured separately and in our case anyway you can use just the o=
ne
> > > > lane mode and then you only need to setup 1 lane, or you can use th=
e 2
> > > > lane mode and you need to setup 2.
> > > >
> > > > Some of our logic is merged like I mentioned though so maybe it wou=
ld
> > > > make more sense to just merge the lanes. Anyway I guess I can start
> > > > working on that code for the next patch set. I will look at what I
> > > > need to do to extend the logic. For now I might be able to get by w=
ith
> > > > just dropping support for 50R1 since that isn't currently being use=
d
> > > > as a default.
> > >
> > > So maybe a dumb question. How does negotiation work? Just one perform=
s
> > > negotiation? They all do, and if you get different results you declar=
e
> > > the link broken? First one to complete wins? Or even, you can
> > > configure each lane to use different negotiation parameters...
> > >
> > >     Andrew
> >
> > My understanding is that auto negotiation is done at 10G or 25G so
> > that is with only one PCS link enabled if I am not mistaken.
> >
> > Admittedly we haven't done the autoneg code yet so I can't say for
> > certain. I know the hardware was tested with the driver handling the
> > link after the fact, but I don't have the code in the driver for
> > handling the autoneg yet since we don't use that in our datacenter.
>
> So you currently always force the pause configuration? Or is pause
> negotiation not supported in these link modes? What about FEC, is that
> negotiated?
>
> I suppose i should go read 802.3.

In our setup nothing is really negotiated. Basically we set the speed
and FEC based on the configuration of the NIC EEPROM and as far as
flow control we just default to accepting pause frames, but not
transmitting them as we don't negotiate it.

Thanks,

- Alex

