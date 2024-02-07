Return-Path: <netdev+bounces-69810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8B384CA9E
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 13:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DED01C2097D
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 12:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBDC14A90;
	Wed,  7 Feb 2024 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkOB+7AP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F21B59B74
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308456; cv=none; b=m99AHVEBjnrlSRJY/XHf4Fyoi1hSp12GiSBfWTl4GBLKS8FSR79IaHPzXaMfMlu0ufR1CEk7OX3YzWEYX1go0uRI98VagJh2SDUad+MN0OpMvKVl3RcoerYg/BhzonGADH0Yj+aUHouvnyu9VZ2oxA07+mAlHkNB+EfARblichQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308456; c=relaxed/simple;
	bh=t84M7lNxT113PkRxCW5cR8RdFf7pszpmvmuZUQSO+NY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZjYfLr1wMShN1Q8zYvB/RjCLRrnRjHIpx938v2NMfphRV9ydzpBq2OZeapaytXIQBRPzS8xcdXOgt6bv6GYhwi6iEMjwoqygRMyae4e/IjkC/cxdGx5dcx77qpfpFkCXtYsAlie4IEgSeiBM+cPWHSah4hSXC4miAo+iJGokTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkOB+7AP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d731314e67so3919835ad.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 04:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707308455; x=1707913255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MW3mQvoNAIiaB+NF1H7wN6KhqXR+qUuE98hWJIntemo=;
        b=fkOB+7APq0S3JG7jwErZE0jXr7gWjIlWDNOpuXQoEr/rwsLpIY1uIhZpmvfrmzLUK9
         N54rGVNJUkvW+5x+Cw2uD2I9BpvR4XzlMWPeTZegqYlkwnCy9Qktm+oUDF6HjnFxd2X2
         IE8nOWKCc56TasozWVh5aiosmn29Fb8nCrAq5dPC4AsGvRBSBxys1Nkp9JePe8bPpipa
         lI9GVSQo/iIujHp9JT5OS2IadvLELjMz2tueBRFwIa5ptMCovQd0FQdvyF9Er/bzBDdr
         Z7N9ayQzArJSPBkSjeqJOLCk2gSIYRGVbZlNBDWo/dOVVHaRnOsJbySFtSGEfR594GyW
         Zagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707308455; x=1707913255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MW3mQvoNAIiaB+NF1H7wN6KhqXR+qUuE98hWJIntemo=;
        b=k7RhQYBQLfSc/TldlUrmpZqKF5By00Ke1lEy0uks3/5MW0BQN9GdDq8vfIOkdfpNg+
         czx4xuPGB4GxJAIK2V/r6Eb3m77RPSyy0cUtTLl2qqEGSrGhNyW3GPO5pszxRnw8Bf05
         tmNzUQcoEKHBiTwdpJZ10G3fN/lHvo7glQHw5NpqFlOAmSCxaAGtDVUtAHw1pAWDc1qT
         jPd/V5aKl0imptnCWFPuBXWAYGx1q/C7+tThqIzuV+zZwY7MWo9aNoVwt5zBIPtwgJE7
         wAtrlgOInqOVYNnasv9DC3j/AZdG8subDU5zw9SFBYaCDGG0yL8DcJo1rbJDG4AojneR
         R1NQ==
X-Gm-Message-State: AOJu0YzL+eJzsvwQueixO+6qa+jlXNlKT7TxdAiGOtZ0j64dQf0rW1th
	sk6pNAYgj8hgTwbZjAgHW54vZhzvsOjgyocePWQL33o7z4dUXPBdqSlCGYBvjPgi1G2COK2WpSi
	s0jgOcM+GnMfS8giZ8Xk/xN+wkpk=
X-Google-Smtp-Source: AGHT+IFCRBcM7xWtFY+ASji36VEM4u38Gghbgddyb8etSqZQgsml1u+CSvYoUoEleTLLtsShNJbRUw3nxXytt1sBiPM=
X-Received: by 2002:a17:90a:3182:b0:296:cca0:ee34 with SMTP id
 j2-20020a17090a318200b00296cca0ee34mr2429239pjb.31.1707308454458; Wed, 07 Feb
 2024 04:20:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1BAA689A-D44E-4122-9AD8-25F6D024377E@ifi.uio.no>
 <CAA93jw6di-ypNHH0kz70mhYitT_wsbpZR4gMbSx7FEpSvHx3qg@mail.gmail.com> <B4827A61-6324-40BB-9BDE-3A87DEABB65C@ifi.uio.no>
In-Reply-To: <B4827A61-6324-40BB-9BDE-3A87DEABB65C@ifi.uio.no>
From: Dave Taht <dave.taht@gmail.com>
Date: Wed, 7 Feb 2024 07:20:42 -0500
Message-ID: <CAA93jw5vFc6i8GebrXCXmtNaFU03=WkD6K83hgepLQzvHCj6Vg@mail.gmail.com>
Subject: Re: [Bloat] Trying to *really* understand Linux pacing
To: Michael Welzl <michawe@ifi.uio.no>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, bloat@lists.bufferbloat.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 7:08=E2=80=AFAM Michael Welzl <michawe@ifi.uio.no> w=
rote:
>
> Whoa=E2=80=A6 and now I=E2=80=99m even more afraid   :-)
>
> My sincere apologies to anyone whose code I may have mis-represented!  I =
just tried to get it=E2=80=A6  sorry if there are silly mistakes in there!

I think his invention of packet pacing alone, of Eric Dumazet's many
inventions, deserves him a place in the Internet Hall of Fame. It make
short buffered switches saner, allows interactive traffic to fit in
between other traffic (essentially host based FQ), and as the Linux
default, has helped power the expansion of ever more bandwidth to ever
more people without overloading the edges far more, than his fq_codel
did. I also love, that by making it just work, he thoroughly disproved
a formerly influential paper on it, circa 2004 or so.

And I do not understand the implementation either, and have been
trying to come up with ways of improving slow start by varying it. I
hope more enlightenment spreads, and your attempt to document it
improves.

https://docs.google.com/document/d/1-uXnPDcVBKmg5krkG5wYBgaA2yLSFK_kZa7xGDW=
c7XU/edit#heading=3Dh.7624xn94jzf6

>
>
> > On 7 Feb 2024, at 13:05, Dave Taht <dave.taht@gmail.com> wrote:
> >
> > Dear Michael:
> >
> > Thank you for digging deeply into packet pacing, TSQ, etc. I think
> > there are some interesting new possibilities in probing (especially
> > during slow start) that could make the core idea even more effective
> > than it is. I also tend to think that attempting it in various cloudy
> > environments and virtualization schemes, and with certain drivers, the
> > side effects are not as well understood as I would like. For example,
> > AWS's nitro lacks BQL as does virtio-net.
> >
> > I think the netdev community, now cc'd, would be interested in your
> > document and explorations so far, below. I hope for more
> > enlightenment.
> >
> > On Wed, Feb 7, 2024 at 6:57=E2=80=AFAM Michael Welzl via Bloat
> > <bloat@lists.bufferbloat.net> wrote:
> >>
> >> Dear de-bloaters of buffers,
> >> Esteemed experts of low delay and pacing!
> >>
> >> I have no longer been satisfied with high-level descriptions of how pa=
cing works in Linux, and how it interacts with TSQ (I=E2=80=99ve seen some,=
 in various papers, over the years) - but I wanted to REALLY understand it.=
 So, I have dug through the code.
> >>
> >> I documented this experience here:
> >> https://docs.google.com/document/d/1-uXnPDcVBKmg5krkG5wYBgaA2yLSFK_kZa=
7xGDWc7XU/edit?usp=3Dsharing
> >> but it has some holes and may have mistakes.
> >>
> >> Actually, my main problem is that I don=E2=80=99t really know what goe=
s on when I configure a larger IW=E2=80=A6 things seem to get quite =E2=80=
=9Coff=E2=80=9D there. Why? Anyone up for solving that riddle?  ;-)
> >> (see the tests I documented towards the end of the document)
> >>
> >> Generally, if someone who has their hands on files such as tcp_output.=
c all the time could take a look, and perhaps =E2=80=9Cfill=E2=80=9D my hol=
es, or improve anything that might be wrong, that would be fantastic!   I t=
hink that anyone should be allowed to comment and make suggestions in this =
doc.
> >>
> >> MANY thanks to whoever finds the time to take a look !
> >>
> >> Cheers,
> >> Michael
> >>
> >> _______________________________________________
> >> Bloat mailing list
> >> Bloat@lists.bufferbloat.net
> >> https://lists.bufferbloat.net/listinfo/bloat
> >
> >
> >
> > --
> > 40 years of net history, a couple songs:
> > https://www.youtube.com/watch?v=3DD9RGX6QFm5E
> > Dave T=C3=A4ht CSO, LibreQos
>


--=20
40 years of net history, a couple songs:
https://www.youtube.com/watch?v=3DD9RGX6QFm5E
Dave T=C3=A4ht CSO, LibreQos

