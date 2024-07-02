Return-Path: <netdev+bounces-108613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59797924945
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 22:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E8B1C213A6
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 20:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B6B1B5813;
	Tue,  2 Jul 2024 20:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rfe3+ivI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232F81CF8F
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 20:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719952261; cv=none; b=us7Q79cpSCyBNKPuhmNjy/3p/0TEbKaGi/YLKeoJ/20w5b5ZRqY9mDaI4MYSgxeThVi1d4lyLku8lbQG2K5Pp4PC+W25ZdoZuLWcxftmHASTrYnNhe5yY8zWQNd2JGQRG1GktitoYdZ4VlqWeEWmpGKsK5WdpJT/rcV+Wg7ycX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719952261; c=relaxed/simple;
	bh=nrGfFOE1zloV3bK+qrmzS+P7ehUz/fvfERYUBKXvXPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aF5EoWTOmHUj9GiquEE1hJxL1y/OWdQb191VX3yjGpl8B3+OYnxE3taN2thYjIwxb3cF8NsqBVgtSQn+BenI2RPzG89xKz9lH53tCgLJrbcbsLvGO+kTXkbPWF7w4oFcwRuD14gHH4g34iw5sRVYdgxCm2YtrmPqiWJjyY5i0lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rfe3+ivI; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3678fbf4a91so329247f8f.1
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 13:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719952258; x=1720557058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrGfFOE1zloV3bK+qrmzS+P7ehUz/fvfERYUBKXvXPY=;
        b=Rfe3+ivIPx8/Db8WctRcsAlUidE89x8PyIg+XqnKiun81xEBEMBP7Qexduhc44kJ95
         pw1ioFgPgXtSYTZzRGgdzHGu37XSdBYHA8eI9UPnEvM9IFeLGCwwGuMR5VqMDRsPoM/Y
         LdU6oDGt5CY16edF07fNCqrPfTQfg1USPY3bIaYUdCOn99bgZw5osE1y10ufAuBlN0AM
         AHC2tl0mAnBpF1aj4v8MWJj4O9fBfu19GmqIP1Pf4p/qx4ZWbtyjH6wug4sajxxtUPdq
         7a9n0PSLHtdAXzGaUDcR10Oq8Y+7PjHp0YBHhZmBRpJP0scCFV9DF5qjr8yjnW9cgHoC
         AFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719952258; x=1720557058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrGfFOE1zloV3bK+qrmzS+P7ehUz/fvfERYUBKXvXPY=;
        b=A14CXWFDmlgnHNUMr+39xIFyENByT4aIHMJmGVBshFZVgO5gDgwiyj2FT8ii8jCSow
         0m3DWBvHw4Qs69bOztcbA7n1Sy+JtXispjzsn9gHkCXFp2MKc9UdE9nJ5P4/lTetFaWs
         3WvVjoixioTrtg+G484yBRBbXHPzwhn++fDYxz2NaxXHjLDz6mRbMgTAJJPxr0P4yGGr
         DJvtJY33xGXchxNuQjdERvZLeTyXVVnQdkSu5GtNO2IYFG3wKWknJuM8R/p9Dnqpoaua
         yuWqBweO/U/sTGrWnuXJ0fVJ2T0BWjW5U0z365c/Q1ivhZsc+06GUrvjkJQorvE8OCta
         0Wtg==
X-Forwarded-Encrypted: i=1; AJvYcCWXK6y3EpqNmfxDddvPCayekiA9pOJiAsRUNkWw4pI8oLqqe1kT/p3X2uoA9Z/AF1rgL57R5ZPgMHxq4szpIMJGtFt9d7fb
X-Gm-Message-State: AOJu0Yy25qbkupNttu4GJNK4MohV/+b7jB0Cug0ei+bEfYFh1mb/WpBD
	WkjIWCUOTeSJ5NGNhmbIUhU3RjcQ1xVisAu9DXIqIcwPHyilo5slgT85naKy7zSeLgGKeLHQzrO
	xI8NQPOXKMXil+nf7k4tuRkKgVFc=
X-Google-Smtp-Source: AGHT+IFBFT8IXlKgVxH07ixYq89qCZDE7E0OHk5uRYUmJlwdTrAsAeA9PcuRxC+4EEh+slriLh5CcMXGcI0UfFIMTyo=
X-Received: by 2002:adf:e9cd:0:b0:367:4ddc:fc53 with SMTP id
 ffacd0b85a97d-3677569eb88mr5980016f8f.14.1719952258258; Tue, 02 Jul 2024
 13:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171993231020.3697648.2741754761742678186.stgit@ahduyck-xeon-server.home.arpa>
 <171993242260.3697648.17293962511485193331.stgit@ahduyck-xeon-server.home.arpa>
 <ZoQ3LlZZ47AJ5fnL@shell.armlinux.org.uk> <CAKgT0UcPExnW2jcZ9pAs0D65gXTU89jPEoCpsGVVT=FAW616Vg@mail.gmail.com>
 <281cdc6a-635f-499d-a312-9c7d8bb949f1@lunn.ch>
In-Reply-To: <281cdc6a-635f-499d-a312-9c7d8bb949f1@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 2 Jul 2024 13:30:21 -0700
Message-ID: <CAKgT0UcAYxnKkCSk7a3EKv6GzZn51Xfrd2Yr0yjcC2_=tk9ZQA@mail.gmail.com>
Subject: Re: [net-next PATCH v3 11/15] eth: fbnic: Add link detection
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@google.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 12:33=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > I was actually going to reach out to you guys about that. For this
> > patch set I think it may be needed as I have no way to sort out
> > 50000baseCR2 (NRZ, 2 lanes) vs 50000baseCR (PAM4, 1 lane) in the
> > current phylink code for setting the mac link up. I was wondering if
> > you had any suggestions on how I might resolve that?
> >
> > Basically I have a laundry list of things that I was planning to start
> > on in the follow on sets:
> >
> > 1. I still need to add CGMII support as technically we are using a
> > different interface mode to support 100Gbps. Seems like I can mostly
> > just do a find/insert based on the PHY_INTERFACE_MODE_XLGMII to add
> > that so it should be straight forward.
> >
> > 2. We have 2 PCS blocks we are working with to set up the CR2 modes. I
> > was wondering if I should just be writing my PCS code to be handling
> > the merged pair of IP or if I should look at changing the phylink code
> > to support more than one PCS device servicing a given connection?
> >
> > 3. The FEC config is integral to the PCS and MAC setup on my device. I
> > was wondering why FEC isn't included as a part of the phylink code?
> > Are there any plans to look at doing that? Otherwise what is the
> > recommended setup for handling that as it can be negotiated via
> > autoneg for our 25G and 50G-R2 links so I will need to work out how to
> > best go after that.
>
> You are pushing the envelope for current phylink. So far, i don't
> think it has been used for anything more than 10G. Although 10GBase-KR
> does have FEC, nobody has needed it yet. So this is something you
> should extend phylink with.
>
> As for multiple PCS for one connection, is this common, or special to
> your hardware?

I would think it is common. Basically once you get over 10G you start
seeing all these XXXXXbase[CDKLS]R[248] speeds advertised and usually
the 2/4/8 represents the number of lanes being used. I would think
most hardware probably has a PCS block per lane as they can be
configured separately and in our case anyway you can use just the one
lane mode and then you only need to setup 1 lane, or you can use the 2
lane mode and you need to setup 2.

Some of our logic is merged like I mentioned though so maybe it would
make more sense to just merge the lanes. Anyway I guess I can start
working on that code for the next patch set. I will look at what I
need to do to extend the logic. For now I might be able to get by with
just dropping support for 50R1 since that isn't currently being used
as a default.

