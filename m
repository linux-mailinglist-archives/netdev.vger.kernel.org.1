Return-Path: <netdev+bounces-185573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D550A9AEFE
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE11D9A1F7D
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B7327C17E;
	Thu, 24 Apr 2025 13:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIrdGsqO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA6814B06C
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501361; cv=none; b=RSdXSwLbyRgY4ogeLKLTqVyYM5p6/2pRWSiCEenuMZ3qxwmxVHwF3BA1hJUtF3rYrQZQlgPhOhGaimDyVrMLmVbUB/CPvaHzgABJy8xVNX3PI6tBabwHTkPtWPlPjd4ewdJdJ8Xr4QUxR57MdrMjSQWGvODprlYUdGGCWSpAAUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501361; c=relaxed/simple;
	bh=zoax3uXulBFzSaQaroHRLePzkvr3IsjjABI1xegh8AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSq0e+JLvWW8aWco3Ej0/O1mI3vRHIzaeruQq571WW238Re4NIpESE6Za7AfTQGdhsKZVpPCIcZbynj600ktY3cDZtWo4XjHFnUcTnJp3vg4lYcXv3YiaJdyREDUF7F63rsNkcyvctCWx345HsTzYhClDdsgWp9uUMSJ6wcxnqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIrdGsqO; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso133306066b.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 06:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745501357; x=1746106157; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkecCv6ZK7DSBxUy0/GrI3ZGwillzf07KYYuKv9rN30=;
        b=UIrdGsqOI62AmQZ6frhPXwyuIwHZllEEL0lfE4653I/SYeN6mTaHMh2uSS8hiZXkHv
         UGr0QjrAxa64Z+H8WekjLjrvLugeHRBjMeGnIusTl3Y5DVD81GKZ7fwtvL/T6nAq6vqZ
         DgHYRiyaebPb4pLJq8P0gGO8kBc+gUXr1WQiWeaAD+i/T6ataIN3f1NhTCFQW6IB+TfS
         kNCR3bx0JCUn00HAHeOu3tHeY7MAAa8uEG+tYc7Hh7KXCv3qjSeNi0nwOaqN9Rtz1Msr
         KgP2QzCNMcXOJytsuZoYhdde+5c5sKHHpjClwrAU8J47LUGKZQ8fdkWxPtkrcFVvtrrQ
         PMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745501357; x=1746106157;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkecCv6ZK7DSBxUy0/GrI3ZGwillzf07KYYuKv9rN30=;
        b=MCoDc3lEDUbhVB+bnftMhiMYsi5BS08mCpIdZ6VaTyehXqbyMY1Yct3QQm32yk8fzf
         mk4VCxGjuYtjmyjAU/iF4f0UKH9cmqHUYls0EcHbMkyA2GqdU6JWykDSe3M0d7e41070
         TSneKNbPtYN3b8uhQ3hVSCvyWeheB6jKoDWNo1IhvpmDAlGaxiW+Azq/WVHN6VZO8iH0
         0r1PUxwrogTuYKm9iZ8fQnWPbQkmwZX3z8x7trDDxq6djl4Th9cM63lx6w6+FEJmyCU8
         w6RDBStjPOVSMYQKYl553Hd1sTyj0NkPTqD+9X3DcCQPP9jJfptQSGn61ivFkzvBb4Yv
         8MqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN2tQ0VGSOaEVx7QXLPZEg/IaY/EaSB5NmO3sFzIegVG3whlykSYRmz77IeORskII66K4m55c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzpvGaujRTBImmgMvrdD+SV/QgHdp9pyoz/UF7bVpAEsvxdUUn
	31gPDTb5ZTJnwtafMhcEFVytbuPnvrFBHj5uyscEPYvgTawc6Z5B
X-Gm-Gg: ASbGncuWZ7Jb+GL0O43iFsjeGtIZdVVvfCdc+ZZ8aBh42S1EID6hln6FcCMUybwt7pn
	LPXSp60P3fzHeKDgpzPz4Sh+Bv74P0dlYm0BFyio17JRiMh8cz0n1l6vAxR2Nw600H+ITQ2s1+n
	TQafTUTdlWipCBZR3ccONZvtcEfSU4Y8kDV+5eIZUX2ObbEo9e2v9F+cDh7OLlQbH97Y40APeek
	67hDMnN2MV2EdYhbSLsMSLaAxTN9iXPDzVI1JfzIH1NlRaK4NlJb4oWhcHDl9gTuJYKW56eYCK6
	vsYQboPD/pW00kErhm8S/1H+upWC71X7Knz6xPskXTOenTGpxn5EVf4S95Rj4d5fd1NJ5cM4JA=
	=
X-Google-Smtp-Source: AGHT+IG+FJRhi/axz9hJD/XCkGMg2vnYX+Dl6QX7U7vLFWmsPCKayGPC9j2RP4t9PUHe77jCQDIptQ==
X-Received: by 2002:a17:906:f591:b0:ac6:ff34:d046 with SMTP id a640c23a62f3a-ace570fd142mr287265166b.2.1745501357225;
        Thu, 24 Apr 2025 06:29:17 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace59c5e349sm105747566b.169.2025.04.24.06.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 06:29:16 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id DA354BE2DE0; Thu, 24 Apr 2025 15:29:15 +0200 (CEST)
Date: Thu, 24 Apr 2025 15:29:15 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Petter Reinholdtsen <pere@debian.org>, netdev@vger.kernel.org,
	Robert Scheck <fedora@robert-scheck.de>,
	AsciiWolf <mail@asciiwolf.com>
Subject: Re: [mail@asciiwolf.com: Re: ethtool: Incorrect component type in
 AppStream metainfo causes issues and possible breakages]
Message-ID: <aAo8q1X882NYUHmk@eldamar.lan>
References: <p3e5khlw5gcofvjnx7whj7y64bwmjy2t7ogu3xnbhlzw7scbl4@3rceiook7pwu>
 <CAB-mu-QjxGvBHGzaVmwBpq-0UXALzdSpzcvVQPvyXjFAnxZkqA@mail.gmail.com>
 <CAB-mu-TgZ5ewRzn45Q5LrGtEKWGhrafP39enmV0DAYvTkU5mwQ@mail.gmail.com>
 <CAB-mu-QE0v=eUdvu_23gq4ncUpXu20NErH3wkAz9=hAL+rh0zQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB-mu-QE0v=eUdvu_23gq4ncUpXu20NErH3wkAz9=hAL+rh0zQ@mail.gmail.com>

Hi Michal,

On Fri, Apr 11, 2025 at 10:48:44PM +0200, AsciiWolf wrote:
> Please note that as pointed out in my previous emails, the binary
> provides seems to be required for console-application component type.
> 
> Daniel
> 
> pá 11. 4. 2025 v 22:18 odesílatel AsciiWolf <mail@asciiwolf.com> napsal:
> 
> >
> > Here is the proposed fix. It is validated using appstreamcli validate
> > and should work without issues.
> >
> > --- org.kernel.software.network.ethtool.metainfo.xml_orig
> > 2025-03-31 00:46:03.000000000 +0200
> > +++ org.kernel.software.network.ethtool.metainfo.xml    2025-04-11
> > 22:14:11.634355310 +0200
> > @@ -1,5 +1,5 @@
> >  <?xml version="1.0" encoding="UTF-8"?>
> > -<component type="desktop">
> > +<component type="console-application">
> >    <id>org.kernel.software.network.ethtool</id>
> >    <metadata_license>MIT</metadata_license>
> >    <name>ethtool</name>
> > @@ -11,6 +11,7 @@
> >    </description>
> >    <url type="homepage">https://www.kernel.org/pub/software/network/ethtool/</url>
> >    <provides>
> > +    <binary>ethtool</binary>
> >      <modalias>pci:v*d*sv*sd*bc02sc80i*</modalias>
> >    </provides>
> >  </component>
> >
> > Regards,
> > Daniel Rusek

Is there anything else you need from us here? Or are you waiting for
us for a git am'able patch? If Daniel Rusek prefers to not submit one,
I can re-iterate with the required changes my proposal 
https://lore.kernel.org/netdev/20250411141023.14356-2-carnil@debian.org/
with the needed changes.

We would like to apply the change in downstream Debian fwiw, but only
with the variant accepted by upstream.

Regards,
Salvatore

