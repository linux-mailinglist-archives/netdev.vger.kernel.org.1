Return-Path: <netdev+bounces-69812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A08FD84CAAF
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 13:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48361C20EC5
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 12:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D244758AAA;
	Wed,  7 Feb 2024 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ifi.uio.no header.i=@ifi.uio.no header.b="3tZVme9/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-out01.uio.no (mail-out01.uio.no [129.240.10.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB4858AD0
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.240.10.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308783; cv=none; b=VgcTQfFOddSIgvzoBwefqNT/B1LfYX1JPBOQjYW3a6Af4TDFc93E8suM1An/+pbAHMXizO4TVcv/woEMJ+aIRubwSPiEZlpnwa4vkyuObj8IAhrlxSgzxCFwbcRr8H5n7EaHSCOsWGQcrl+9wD9+DsSk67NqNEnShtIxgVbhxBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308783; c=relaxed/simple;
	bh=Y3EJNb8vlYwryxDxPFMdybtNOuiCzDdq8PBRxb6vGLI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rt87hqHmm+VhEkuidd7amRw/DR7vzQLCRsMsKZM5jphB53MUNLBssc+1ftvgmdTRLhKxfmm0pKhNmuOdMKdI5EjPEeqJAQ8tFerx6qKwgD/bCzdF87HZgqKZzjkK0QerRLiwproLWrtET+K2dT9D00bohCqhJN2HDRrCb0z8Em4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ifi.uio.no; spf=pass smtp.mailfrom=ifi.uio.no; dkim=pass (2048-bit key) header.d=ifi.uio.no header.i=@ifi.uio.no header.b=3tZVme9/; arc=none smtp.client-ip=129.240.10.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ifi.uio.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ifi.uio.no
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ifi.uio.no;
	s=key2309; h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:
	In-Reply-To:From:Subject:Mime-Version:Content-Type:Sender:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
	:List-Post:List-Owner:List-Archive;
	bh=OAnOaiL6Wkk3dvlwtJxxwSf6mNkkcBGOAp7wBOqPlmk=; b=3tZVme9/nkECPMxSKfS5olxEPt
	xaxDGMsDZZQZvBNDQ6HAegD/ZBCIIFOwoJYC/EaNsN9H7TwZs4cDIgX+yOAracUma06cFE8jCHNJS
	gwTMXHMomOtmZ8+Bqw4zry4HE7wo0n9Z+VVXDOgkVMShtCLEQmAO1rMj4CaV2ndhvYxhlFLeRHEU3
	2/svVSeTqX49ZVqP4cLKa7YaD+nrzWFJHf2Kb3ZWeOLFNZBCTZLK0NjfvhR+8egR+yKAX6dxAIFR0
	xma/UOxs1qrNPZFdD3lMOBAZSSMZIty/L9qigYLs840Wz4XEMMb/ym6SqNfU7xQxqLZOHguNqbsBQ
	rotoBqSw==;
Received: from mail-mx12.uio.no ([129.240.10.84])
	by mail-out01.uio.no with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <michawe@ifi.uio.no>)
	id 1rXgjJ-00BYwv-1Y;
	Wed, 07 Feb 2024 13:08:41 +0100
Received: from collaborix.ifi.uio.no ([129.240.69.78] helo=smtpclient.apple)
	by mail-mx12.uio.no with esmtps (TLS1.2:ECDHE-ECDSA-AES256-GCM-SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <michawe@ifi.uio.no>)
	id 1rXgjI-0003b4-2z;
	Wed, 07 Feb 2024 13:08:41 +0100
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [Bloat] Trying to *really* understand Linux pacing
From: Michael Welzl <michawe@ifi.uio.no>
In-Reply-To: <CAA93jw6di-ypNHH0kz70mhYitT_wsbpZR4gMbSx7FEpSvHx3qg@mail.gmail.com>
Date: Wed, 7 Feb 2024 13:08:40 +0100
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
 bloat@lists.bufferbloat.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <B4827A61-6324-40BB-9BDE-3A87DEABB65C@ifi.uio.no>
References: <1BAA689A-D44E-4122-9AD8-25F6D024377E@ifi.uio.no>
 <CAA93jw6di-ypNHH0kz70mhYitT_wsbpZR4gMbSx7FEpSvHx3qg@mail.gmail.com>
To: Dave Taht <dave.taht@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-UiO-SPF-Received: Received-SPF: neutral (mail-mx12.uio.no: 129.240.69.78 is neither permitted nor denied by domain of ifi.uio.no) client-ip=129.240.69.78; envelope-from=michawe@ifi.uio.no; helo=smtpclient.apple;
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.6, required=5.0, autolearn=disabled, KHOP_HELO_FCRDNS=0.4,T_SCC_BODY_TEXT_LINE=-0.01,UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: 2CCAA68EDBB96D2186333327B15102915C74D20E
X-UiOonly: 940DBC83520B41C5D4A4388A9D537D71DCC88203

Whoa=E2=80=A6 and now I=E2=80=99m even more afraid   :-)

My sincere apologies to anyone whose code I may have mis-represented!  I =
just tried to get it=E2=80=A6  sorry if there are silly mistakes in =
there!


> On 7 Feb 2024, at 13:05, Dave Taht <dave.taht@gmail.com> wrote:
>=20
> Dear Michael:
>=20
> Thank you for digging deeply into packet pacing, TSQ, etc. I think
> there are some interesting new possibilities in probing (especially
> during slow start) that could make the core idea even more effective
> than it is. I also tend to think that attempting it in various cloudy
> environments and virtualization schemes, and with certain drivers, the
> side effects are not as well understood as I would like. For example,
> AWS's nitro lacks BQL as does virtio-net.
>=20
> I think the netdev community, now cc'd, would be interested in your
> document and explorations so far, below. I hope for more
> enlightenment.
>=20
> On Wed, Feb 7, 2024 at 6:57=E2=80=AFAM Michael Welzl via Bloat
> <bloat@lists.bufferbloat.net> wrote:
>>=20
>> Dear de-bloaters of buffers,
>> Esteemed experts of low delay and pacing!
>>=20
>> I have no longer been satisfied with high-level descriptions of how =
pacing works in Linux, and how it interacts with TSQ (I=E2=80=99ve seen =
some, in various papers, over the years) - but I wanted to REALLY =
understand it. So, I have dug through the code.
>>=20
>> I documented this experience here:
>> =
https://docs.google.com/document/d/1-uXnPDcVBKmg5krkG5wYBgaA2yLSFK_kZa7xGD=
Wc7XU/edit?usp=3Dsharing
>> but it has some holes and may have mistakes.
>>=20
>> Actually, my main problem is that I don=E2=80=99t really know what =
goes on when I configure a larger IW=E2=80=A6 things seem to get quite =
=E2=80=9Coff=E2=80=9D there. Why? Anyone up for solving that riddle?  =
;-)
>> (see the tests I documented towards the end of the document)
>>=20
>> Generally, if someone who has their hands on files such as =
tcp_output.c all the time could take a look, and perhaps =E2=80=9Cfill=E2=80=
=9D my holes, or improve anything that might be wrong, that would be =
fantastic!   I think that anyone should be allowed to comment and make =
suggestions in this doc.
>>=20
>> MANY thanks to whoever finds the time to take a look !
>>=20
>> Cheers,
>> Michael
>>=20
>> _______________________________________________
>> Bloat mailing list
>> Bloat@lists.bufferbloat.net
>> https://lists.bufferbloat.net/listinfo/bloat
>=20
>=20
>=20
> --=20
> 40 years of net history, a couple songs:
> https://www.youtube.com/watch?v=3DD9RGX6QFm5E
> Dave T=C3=A4ht CSO, LibreQos


