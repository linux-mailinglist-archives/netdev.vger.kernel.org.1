Return-Path: <netdev+bounces-132342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4BC9914D2
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 08:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E551F22A43
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 06:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E073F9D5;
	Sat,  5 Oct 2024 06:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1gVVH64"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401C025761;
	Sat,  5 Oct 2024 06:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728108699; cv=none; b=iVW8ZGxgc0IWUeI/g3fPhMOIOOHk6ouT38v+A5E53dNGXdADpOTFFv1KNiEID/PxfjLJ+VXe2zF2QPJA1F0dTcPYKwS+NWG1js/qEgupT0vEXzn8L4LQXO60xerVfQbgUo+veTX5F2vsd4vfcPI/zMt56r9PkSuV4s76Qk2Jir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728108699; c=relaxed/simple;
	bh=ATt7P8kWar3VOe/NiggIMKAMgRS+W4H0CAGY6Ui03Ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pD1QP3FB27lQ2ho7QOp9LVUDs+8WdfIIRv5WA0xS5BWcBQP3nPRCOC4hU9igepq9G6Hwrr0QdB4h6fednGNn6qnDS7CeGautMs1qQ0UH3p3YLoqCNlYdN6hZ5D5Mgb6iAKj7iDMnYYj4xcteqzaSva6o91pFgcZ1V0T3zT3G+QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1gVVH64; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8a837cec81so200024166b.2;
        Fri, 04 Oct 2024 23:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728108696; x=1728713496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATt7P8kWar3VOe/NiggIMKAMgRS+W4H0CAGY6Ui03Ek=;
        b=a1gVVH64kf4eisp/AkljUpwoy+PjYirJ1zxzEGXYIiAc3pUzgGzB8axw9/nTH3Ap2G
         Vwgy1u/v+9gZxWk+HbDd6Q9huOxhB/cFAYbszJjJXsglWLYXUYH9FNbPvLWoXfWLIneq
         dL+s4J0L8IGI9RHaPP2P7+Kx2KIsTiAspGH08apdQxrB5FWtWD/bxGPYe5VA3KJijgST
         t30jMMzGelTldKDUnEx7uXILS4o83fDfdsyhCd0sKr3HtDSCaOAk8PaLS4+9xb3P25IA
         vBS0Y9MJ3GcVmdDxUyv/ZNo+emdjK8barDowgFTVoRAknxVZtv9c24FqWX/6oGOwvkMs
         QUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728108696; x=1728713496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATt7P8kWar3VOe/NiggIMKAMgRS+W4H0CAGY6Ui03Ek=;
        b=Kd8B4XZfcOEgmXG/NKZgpVq6h8EuHZlbpwceIUzPtDqLjNAWnaNFUWQrVoN+ZD17Uw
         zz/0fCqiqyfgxXjgknf0N4N9SIkdenzSkrMmLv/3h3/DsVo8zPKci1A/LpHd/wRqokJI
         YqPJ1zbUgjdUjhJe719TT2mUueWBvSo3QvaD1dxDN0yDYsoPuimZ/8iJ10uIOhyUXDsQ
         tBeyW6GKR8LnhYCzn9Sx2z3OZCVRs4hsQ9mgaQpyCkgwCNdw/kH/weyVGTpRZssUEhnr
         ZE0bFictQzQ0QVXvw+WMF3dLPhrzT962CUOuuePedyFJV054p0TMuKNUlCmKHWfONy/p
         3aQw==
X-Forwarded-Encrypted: i=1; AJvYcCVyPGjPtS25v1W3mzFtqOsSrqk4obL2J+9mORU+p5n4GZE2j2toN5/NHz+bUTTRMZP64rUE7fgK@vger.kernel.org, AJvYcCXVhWLepDjV/JLosIZM6BPtJ2CJUPJWC4fb/IcFYPNb7FjB3wUghWl3WOh4SDEQfIIhCXS1Bty2wRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5iKTatL4oF05VJJU2PvojQwp9SmQ3e91ktsV8Z34+OBZhI6WO
	lIJnykcchKkbpZRc8aHO7QDZnCkja6U694fP9Qw8uEjnt8y1XHHEZMmLNUqkOXDD2CTNKTLPZqs
	963sm5GKpbRbMf+z7yoCM5TDACcw=
X-Google-Smtp-Source: AGHT+IEimMdyQn202h3hCNekjvakythlnkkM28AoIlAUtbAaV5+2aaPSdQLT0PAB0WI5LqfYjdomMmj4YjdiTsv3AJ8=
X-Received: by 2002:a05:6402:5210:b0:5c8:967d:cf47 with SMTP id
 4fb4d7f45d1cf-5c8d2e4754emr4815442a12.19.1728108696196; Fri, 04 Oct 2024
 23:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-4-ap420073@gmail.com>
 <CAHS8izM1H-wjNUepcmFzWvpUuTZvt89_Oba=KaDpeReuMURvQw@mail.gmail.com>
 <CAMArcTX0sD9T2qhoKEswVp3CNVjOchZyEqypBcjMNtQRHBfk5w@mail.gmail.com> <CAHS8izNZhr6=82Piv74V1HuVT1X+OEEyxUXs-VU46KJt3Fu5mA@mail.gmail.com>
In-Reply-To: <CAHS8izNZhr6=82Piv74V1HuVT1X+OEEyxUXs-VU46KJt3Fu5mA@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sat, 5 Oct 2024 15:11:24 +0900
Message-ID: <CAMArcTUDDw5+AmydzmERpxWofWKPhF5mw2Ch9T0g3a6E9LgYUg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/7] net: ethtool: add support for configuring tcp-data-split-thresh
To: Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com, 
	kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com, 
	danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com, 
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com, 
	paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com, 
	aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com, 
	bcreeley@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 10:47=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> On Thu, Oct 3, 2024 at 12:33=E2=80=AFPM Taehee Yoo <ap420073@gmail.com> w=
rote:
> >
> > On Fri, Oct 4, 2024 at 3:25=E2=80=AFAM Mina Almasry <almasrymina@google=
.com> wrote:
> > >
> > > On Thu, Oct 3, 2024 at 9:07=E2=80=AFAM Taehee Yoo <ap420073@gmail.com=
> wrote:
> > > >
> > > > The tcp-data-split-thresh option configures the threshold value of
> > > > the tcp-data-split.
> > > > If a received packet size is larger than this threshold value, a pa=
cket
> > > > will be split into header and payload.
> > >
> > > Why do you need this? devmem TCP will always not work with unsplit
> > > packets. Seems like you always want to set thresh to 0 to support
> > > something like devmem TCP.
> > >
> > > Why would the user ever want to configure this? I can't think of a
> > > scenario where the user wouldn't want packets under X bytes to be
> > > unsplit.
> >
> > I totally understand what you mean,
> > Yes, tcp-data-split is zerocopy friendly option but as far as I know,
> > this option is not only for the zerocopy usecase.
> > So, If users enable tcp-data-split, they would assume threshold is 0.
> > But there are already NICs that have been supporting tcp-data-split
> > enabled by default.
> > bnxt_en's default value is 256bytes.
> > If we just assume the tcp-data-split-threshold to 0 for all cases,
> > it would change the default behavior of bnxt_en driver(maybe other driv=
ers too)
> > for the not zerocopy case.
> > Jakub pointed out the generic case, not only for zerocopy usecase
> > in the v1 and I agree with that opinion.
> > https://lore.kernel.org/netdev/20240906183844.2e8226f3@kernel.org/
>
> I see, thanks. The ability to tune the threshold to save some pcie
> bandwidth is interesting. Not sure how much it would matter in
> practice. I guess if you're receiving _lots_ of small packets then it
> could be critical.
>
> Sounds good then, please consider adding Jakub's reasoning for why
> tuning this could be valuable to the commit message for future
> userspace readers that wonder why to set this.

Okay, I will add an explanation of this feature to commit message in v4 pat=
ch.

Thanks a lot!
Taehee Yoo

>
> --
> Thanks,
> Mina

