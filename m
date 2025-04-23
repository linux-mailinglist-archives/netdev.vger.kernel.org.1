Return-Path: <netdev+bounces-185251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D5FA9980B
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 20:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00B027AA6E6
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 18:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D6B28CF61;
	Wed, 23 Apr 2025 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ez155eiE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B894B27A12D
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745433543; cv=none; b=WR5yJ8xzmPX/lFnNus7eJVgHvqiZsSQx4iFBTe9TxnUGUKZaR8e5IzAh8+x8NFkNvLScO50KMaJaXUxstg6qJjCafMV8RE0bEFvnPnDSlkE+0syWwys3zZXxssIKSv+vvE6IVMpLRuCmG/zDm+jfwcOvkg/BVS1UGa9tMUfqsQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745433543; c=relaxed/simple;
	bh=BayBn1qOLAKMuTVYVMRIHxi2o/4o5mzsdnmv7Hf81f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSLVlA48KKNfF+bkr9t4YG1/ICseQ5BcjAUG09fpn14dgl92ORoT0QQp+ZwcwvPptdnlw77pHy3Rxy23iGsmtwCNOR3ZC/hTJkcwneMtsu6eJFxkYxTMzHgJhVCSomOKrOW0tCxPPXwd03/uoond46t0KRtYgb/oMEJduVf0BEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ez155eiE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39c266c1389so107107f8f.1
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 11:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745433540; x=1746038340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BayBn1qOLAKMuTVYVMRIHxi2o/4o5mzsdnmv7Hf81f0=;
        b=Ez155eiEcJ5Hz+A1cUHmRm3lSZDVe9z+iFR2nWQaF28ErWFLAoLIdHgLydljTycjOv
         AcYmfghHc/EP1HIYVuaJuKgJ3DAyAptNIynrnq7HzSeHHRZzfs+jc4SZtHq+8z9c9QFF
         mFcnEgoZRBGAOn4BCLs+fwEbrapU/2AvVG2ee1ru6OJuu9uRtiogxABD5ahn/L01dGZ0
         2mvoKqRMEI/ZxJtRLMg5qm1VPuaGRdQhYpblyUlv27m5zNIXyH0qcOuoz+EBdcgG5dGf
         uk0zW7HeOaGHCuC64GNkhQmsBPdTcSzZCZFyf/1GvhlAn+PmYkFYY/av7vOAKvCJ9ghA
         PWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745433540; x=1746038340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BayBn1qOLAKMuTVYVMRIHxi2o/4o5mzsdnmv7Hf81f0=;
        b=Raj7lTjqEbb47PMkGWB/iATWVmx2+ftxTAQCB0zEbEGOgyAvdzzuw+RqZMgm0vOBb0
         /Nkn9yG714fpOUkXbU80jtoue0S/XruOLrIw5Rb7wICa9yeiMlxTtOQ2chwRPQEGUF3a
         2RdV+dooHeXTpsSwGGbPN4w4zJPFUusx056E3DnSYp4TzdgWhy81wWo4tZTr3n5/RGx0
         IOdiVkzXqPfJonPKBs+xc8st1gV6gRQe7xPV09qM/M2a4OLkwwV7xdh4aBkZtmEliZfJ
         TJ5sw1Vwfeh9RLrFOivig8Ae/Dvv91lOzGOHpCMum3VP5sIN1dy3JlgBud4H8zPECPJS
         5rIA==
X-Forwarded-Encrypted: i=1; AJvYcCW8TPiIQU5VNHRvFVnr8Km21obEta9tqQ9nBr1F1l8fdAHUhdPvqCmN/aCqOdYgdF9N1Pc3p3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwU/xJM3+4aGuxpUP4IKNoAi4ifQIcMX2dEgvOkX3aCzzUiI5g
	+vliEgsIusQhM86wBBrJ03nXUBk0mg/hSHN/tAenx8pcn+cAkOutfniOXVUZvGxIEmEBHEuB69e
	kYosursfzd0+J+kgLRKwNCJxwj2w=
X-Gm-Gg: ASbGncsOlsyngRH4E+nhl7NI7ritcp6tL3we6z2ozxjKYSsez1xYL9vCgoyvQ/xenca
	k89WRAgLxVX8dm4Fs1m5rdmsrcYevIxVPvqvuZORTft0xJOYerYmNEQtriHqIbw+Mfpz0AZR3MR
	dQTM9XaZmpgkKndzx6y51DAUpL6hTqzQO4i5K90atBGXbfoX+s3Ct0s44=
X-Google-Smtp-Source: AGHT+IHXjEVmYK4VPPm/IOfki1SvMvkyowTrVKyUg7N1Z8Mwx+aomNZuQFo3OLEDvQrDyMC4JOz5zAq6GsqSusf7VNc=
X-Received: by 2002:a5d:648c:0:b0:39e:cbca:7156 with SMTP id
 ffacd0b85a97d-39efba2ab70mr17605396f8f.1.1745433539762; Wed, 23 Apr 2025
 11:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <de130c97-c344-42ee-b3bc-0ca5f9dc36df@lunn.ch> <CAKgT0UcXY3y3=0AnbbbRH75gh2ciBKhQj2tzQAbcHW_acKeoQw@mail.gmail.com>
 <06490a1a-427c-4e35-b9c3-154a0c88ed60@lunn.ch> <CAKgT0UfeH4orZq5AnHvgeTL3i05fPu-GNmBwTnnrGFWOdU+6Cg@mail.gmail.com>
 <CAKgT0Udw-XQmRan1qBaBEkCOqNd2FRNgPd8E8Au+Wmih7QVsWA@mail.gmail.com>
 <20250421182143.56509949@kernel.org> <e3305a73-6a18-409b-a782-a89702e43a80@lunn.ch>
 <20250422082806.6224c602@kernel.org> <08b79b2c-8078-4180-9b74-7cd03b2b06f7@lunn.ch>
 <CAKgT0UfW=mHjtvxNdqy1qB6VYGxKrabWfWNgF3snR07QpNjEhQ@mail.gmail.com>
 <c7c7aee2-5fda-4b66-a337-afb028791f9c@lunn.ch> <CAKgT0UfDWP91rH1G70+pYL2HbMdjgr46h3X+uufL42xmXVi=cg@mail.gmail.com>
In-Reply-To: <CAKgT0UfDWP91rH1G70+pYL2HbMdjgr46h3X+uufL42xmXVi=cg@mail.gmail.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 23 Apr 2025 11:38:23 -0700
X-Gm-Features: ATxdqUGSL4Whik8YIvWSDO4gPYQWhdfTQw3shl0N5S9m0ymdIkOryehnI4gAvmc
Message-ID: <CAKgT0UfN_WgpwwkQk0iRWhORUYWiRuTedLq-mCvH6gE30Gofqg@mail.gmail.com>
Subject: Re: [net-next PATCH 0/2] net: phylink: Fix issue w/ BMC link flap
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux@armlinux.org.uk, 
	hkallweit1@gmail.com, davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 4:06=E2=80=AFPM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> On Tue, Apr 22, 2025 at 3:26=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrot=
e:
> >
> > On Tue, Apr 22, 2025 at 02:29:48PM -0700, Alexander Duyck wrote:
> > > On Tue, Apr 22, 2025 at 9:50=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> =
wrote:
> > > >

...

> > Or is there always 4 MACs, each MAC has its own queues, and you need
> > to place frames into the correct queue, and with a 2x50CR2 you also
> > need to load balance across those two queues?
>
> Are you familiar with the concept of QSFP breakout cables? The general
> idea is that one end of the cable is a QSFP connection and it will
> break out into 4 SFP connections on the other end. That is actually
> pretty close to the concept behind our NIC. We essentially have an
> internalized breakout where the QSFP connection comes in, but we break
> it into either 2 or 4 connections on our end. Our limit is 2 lanes per
> host.
>
> I did a quick search and came up with the following link to a Cisco
> whitepaper that sort of explains the breakout cable concept. I will
> try to see if I can find a spec somewhere that defines how to handle a
> breakout cable:
> https://www.cisco.com/c/en/us/products/collateral/interfaces-modules/tran=
sceiver-modules/whitepaper-c11-744077.html
>

So I have done some more digging. I'm wondering if the annex 109B,C
and 135A,C,E,G are meant to essentially explain how to hook up a
breakout style connection without mentioning splitting things up or
sharing.

As far as the QSFP cables I was able to find a bit more. Specifically
in SFF-8636 they have a mention of a "Separable module" in Byte 113
bits 6-4 that was added to support breakout cables. Getting into CMIS
(https://www.oiforum.com/wp-content/uploads/OIF-CMIS-05.2.pdf) there
is quite a bit more mentions of partitioning the module to support
multiple "host interface" instances on the same cable, with section
6.2 really getting into the separation of datapaths for "applications"
and how to go about configuring multiple distinct links sharing the
same module.

The only issue is that CMIS doesn't really apply until we get to
QSFP-DD cables, so the QSFP28 and QSFP+ may end up being a bit of a
wild west when it comes to breaking out the connection. That said
though Byte 113 may be enough as it seems like partitioning it is just
a matter of selecting 1/2/4 lanes versus QSFP-DD where we can swap
between different modulation modes and such.

