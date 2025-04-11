Return-Path: <netdev+bounces-181789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA999A8679C
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E14B1785D5
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE2A2857E3;
	Fri, 11 Apr 2025 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asciiwolf-com.20230601.gappssmtp.com header.i=@asciiwolf-com.20230601.gappssmtp.com header.b="dEM8MgPn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329E11F1906
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404540; cv=none; b=kIAcQ3cmYO1QPdGPVVPr8ntsvDTrzfkrvkoijSmn7TJ90DiCiidqTXWznEzrOoGI5/s023nykUogDgmdXC69fNrQFRcVXd8yyF6G1idz4vx40WiLiF27z2sJu/1RE7KEJim0nNclKPgAS7GB5J6XIsZ3of68Zy8ZjbHniy7ZVhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404540; c=relaxed/simple;
	bh=S3mOv0HbZuYwmeOFKXA2Uk0X//Rg4s1cC43uSRaS0Gk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwDCKFPh7tWwNQqOBSiizhgRT2uwfKn4ZRaYnURxy2fP9QouJTP/FJgpmhSws7k8s+voFiuhKLjAww5ng73Zt8+KCRbzjzLy6YGfIjfP33oByPYwwgRj/WeH6+YMiv3rhJc8FfbWkMpSAlM+099y9z/oCbaNAIhP196J0qbRIeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asciiwolf.com; spf=none smtp.mailfrom=asciiwolf.com; dkim=pass (2048-bit key) header.d=asciiwolf-com.20230601.gappssmtp.com header.i=@asciiwolf-com.20230601.gappssmtp.com header.b=dEM8MgPn; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=asciiwolf.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=asciiwolf.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2c663a3daso454120866b.2
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 13:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asciiwolf-com.20230601.gappssmtp.com; s=20230601; t=1744404536; x=1745009336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvBWz+D9vIrTOM6eWeZXwohp3MwMCbnAoF6fNzENyC4=;
        b=dEM8MgPnwCXCIXpdEQTnfRIpFWSjZq4SATPF5ysJHuNk779vKaXrx2VUWGpGstl+us
         J7mK6RrA7G6BWfPIztYnZMwOIsSPsSy+cDhPwqReZb/A2HBaKQaRQAFLxmD816KlVctk
         b6VA9v2pr8+QdAxDofvd0GW78Nv1C75/8jrrD3dv5038YBIRosGMW8YRS3zlOMTxBUHo
         c9kJ3e0UVUfqjP8equPhPtHCvkUtUTIIJGFe34jKfGj7SUlAe0G3Ker3XW+AdGZhAN0H
         sX1+Ur8mFiFm0uN/0BIvx/j0fu5I9MMMbeEPbGEyZEOGV3rqK54c0WduecA267myIldl
         ryqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744404536; x=1745009336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvBWz+D9vIrTOM6eWeZXwohp3MwMCbnAoF6fNzENyC4=;
        b=WuLO95g478/SqMIgLuvxYuIJQZvR662XVjqT8ldNR+kaE16T12//p2EaHdUIyHzJ+H
         eqKuscqtqQ2ugkvG7CDqfiOB1ePAHaPnBeoD7Esn+EFO+IJh/hInpEUZuW/7Kb3IHwFH
         sKMEN7Dc+U5Y64uNl12naQe62dZ+GJ+I0v42LiZlQ1r5kh8U8t26ecy7c/VUOyuMDLs6
         86TLzEqfOViwLsY2owWbucioGh9j59+xLpkLU84aaBTUC8Yn8f4yfxTpowV50JB8ttYy
         t6dLkzYkAXkuPUiw8bn6Q5KWiGnwbe4HgQi1/Lzirz77GQdT+GpWhd2Ta+9GvdbdZxIT
         q9Nw==
X-Forwarded-Encrypted: i=1; AJvYcCULu+hGBXgNS9MxV/327wZRd29VdUzRDvd/sij7aR/M5KkWS8GdQwwTrBjbvryzQ3sNuwyscgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0RXX8YKvL7CdnfhdIDNpTP42Kdc4vwDnyhxWMzgKledRhEjhl
	5RNxf18L1BEEQjOefhc1wksNqKwTbQCr2cfaLSgOP6SZmbhdMu57rRICsnuG/kWe+yCayaxiNdN
	7NMYLTXkHh+ZKo99hMVJfJ2nlxOE85o4sH2k=
X-Gm-Gg: ASbGnct/DjZsPH8UUzlt173xxzKbxnBkxXNCmhFAhRo3kj2NP3n0NtyKcAwlLSMB7v/
	9LDwfDDgaxg6zJ48bB7Pm3mBgxWal/jsGAKDrppBfGY7b5ONYqzDstDDbmK7v7/kgivpBfwVR2f
	NcONF3aEsDx6qHkHtYK3WRT3zVg7KfSIvzGTw6DrtLwzS7EMtbNx2qYUo=
X-Google-Smtp-Source: AGHT+IGpNcx2+ByPJ50f1aCbrHqwkafAU++AMNalVPlnGTIN8m8dDqJa1j4SWt/G0ZqXrljT8X36vzQqmoBjlMHm2g4=
X-Received: by 2002:a17:907:1c18:b0:ac7:9712:d11a with SMTP id
 a640c23a62f3a-acad352f334mr377472966b.32.1744404536327; Fri, 11 Apr 2025
 13:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <p3e5khlw5gcofvjnx7whj7y64bwmjy2t7ogu3xnbhlzw7scbl4@3rceiook7pwu>
 <CAB-mu-QjxGvBHGzaVmwBpq-0UXALzdSpzcvVQPvyXjFAnxZkqA@mail.gmail.com> <CAB-mu-TgZ5ewRzn45Q5LrGtEKWGhrafP39enmV0DAYvTkU5mwQ@mail.gmail.com>
In-Reply-To: <CAB-mu-TgZ5ewRzn45Q5LrGtEKWGhrafP39enmV0DAYvTkU5mwQ@mail.gmail.com>
From: AsciiWolf <mail@asciiwolf.com>
Date: Fri, 11 Apr 2025 22:48:44 +0200
X-Gm-Features: ATxdqUFuMtbPG8h2c0oEBKaDh49UX8PgK8HOBxQfYyWPZYpIUu1TBGVOTXkz3dE
Message-ID: <CAB-mu-QE0v=eUdvu_23gq4ncUpXu20NErH3wkAz9=hAL+rh0zQ@mail.gmail.com>
Subject: Re: [mail@asciiwolf.com: Re: ethtool: Incorrect component type in
 AppStream metainfo causes issues and possible breakages]
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Petter Reinholdtsen <pere@debian.org>, netdev@vger.kernel.org, 
	Robert Scheck <fedora@robert-scheck.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please note that as pointed out in my previous emails, the binary
provides seems to be required for console-application component type.

Daniel

p=C3=A1 11. 4. 2025 v 22:18 odes=C3=ADlatel AsciiWolf <mail@asciiwolf.com> =
napsal:

>
> Here is the proposed fix. It is validated using appstreamcli validate
> and should work without issues.
>
> --- org.kernel.software.network.ethtool.metainfo.xml_orig
> 2025-03-31 00:46:03.000000000 +0200
> +++ org.kernel.software.network.ethtool.metainfo.xml    2025-04-11
> 22:14:11.634355310 +0200
> @@ -1,5 +1,5 @@
>  <?xml version=3D"1.0" encoding=3D"UTF-8"?>
> -<component type=3D"desktop">
> +<component type=3D"console-application">
>    <id>org.kernel.software.network.ethtool</id>
>    <metadata_license>MIT</metadata_license>
>    <name>ethtool</name>
> @@ -11,6 +11,7 @@
>    </description>
>    <url type=3D"homepage">https://www.kernel.org/pub/software/network/eth=
tool/</url>
>    <provides>
> +    <binary>ethtool</binary>
>      <modalias>pci:v*d*sv*sd*bc02sc80i*</modalias>
>    </provides>
>  </component>
>
> Regards,
> Daniel Rusek
>
>
> p=C3=A1 11. 4. 2025 v 15:50 odes=C3=ADlatel AsciiWolf <mail@asciiwolf.com=
> napsal:
> >
> > Sure,
> >
> > I will take a look at this later today.
> >
> > Regards,
> > Daniel
> >
> > Dne p=C3=A1 11. 4. 2025 15:47 u=C5=BEivatel Michal Kubecek <mkubecek@su=
se.cz> napsal:
> >>
> >> Hello,
> >>
> >> I got this report (and one more where you are already in Cc) but I'm n=
ot
> >> familiar with the AppStream stuff at all. Can you take a look, please?
> >>
> >> Michal
> >>
> >> > Date: Fri, 11 Apr 2025 15:16:28 +0200
> >> > From: AsciiWolf <mail@asciiwolf.com>
> >> > To: Michal Kubecek <mkubecek@suse.cz>
> >> > Subject: Re: ethtool: Incorrect component type in AppStream metainfo=
 causes
> >> >  issues and possible breakages
> >> >
> >> > This probably also needs to be fixed:
> >> >
> >> > https://freedesktop.org/software/appstream/docs/
> >> > sect-Metadata-ConsoleApplication.html#tag-consoleapp-provides
> >> >
> >> > Regards,
> >> > Daniel
> >> >
> >> > p=C3=A1 11. 4. 2025 v 15:06 odes=C3=ADlatel AsciiWolf <mail@asciiwol=
f.com> napsal:
> >> >
> >> >     Hello Michal,
> >> >
> >> >     ethtool is user uninstallable via GUI (such as GNOME Software or=
 KDE
> >> >     Discover) since 6.14. This is not correct since it is a (in many
> >> >     configurations pre-installed) system tool, not user app, and uni=
nstalling
> >> >     it can also uninstall other critical system packages.
> >> >
> >> >     The main problem is the "desktop" component type in AppStream me=
tadata:
> >> >
> >> >     $ head org.kernel.software.network.ethtool.metainfo.xml
> >> >     <?xml version=3D"1.0" encoding=3D"UTF-8"?>
> >> >     <component type=3D"desktop">
> >> >       <id>org.kernel.software.network.ethtool</id>
> >> >       <metadata_license>MIT</metadata_license>
> >> >       <name>ethtool</name>
> >> >       <summary>display or change Ethernet device settings</summary>
> >> >       <description>
> >> >         <p>ethtool can be used to query and change settings such as =
speed,
> >> >         auto- negotiation and checksum offload on many network devic=
es,
> >> >         especially Ethernet devices.</p>
> >> >
> >> >     The correct component type should be "console-application".[1]
> >> >
> >> >     Alternative solution would be removing the whole metainfo file.
> >> >
> >> >     Please see our (Fedora) downstream ticket for more information:
> >> >     https://bugzilla.redhat.com/show_bug.cgi?id=3D2359069
> >> >
> >> >     Regards,
> >> >     Daniel Rusek
> >> >
> >> >     [1] https://freedesktop.org/software/appstream/docs/
> >> >     sect-Metadata-ConsoleApplication.html or https://freedesktop.org=
/software/
> >> >     appstream/docs/chap-Metadata.html#sect-Metadata-GenericComponent

