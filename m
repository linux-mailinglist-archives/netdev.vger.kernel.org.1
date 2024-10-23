Return-Path: <netdev+bounces-138302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8B29ACE7F
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605BE283538
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6D01B5ED0;
	Wed, 23 Oct 2024 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYpQr3aC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B62762F7
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729696891; cv=none; b=cOwNUyRbLPafX7YE8MwKwsUYlp1050cMFiQbWQvi9yUkSgoP5JWImHUyGQkxGeuYKQREB0SmiPDsPOmmC9raESITHiyEsTtkvgScyK58BMACO7ndRfAOUgmQzlLeBXkkArXjJngrnz5nwnB+Pv9S+2W1AWHfrKXEjq/fr/OAAwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729696891; c=relaxed/simple;
	bh=tKZ0RLbM976KwVvBAcXswPDIrUo+ep7kQOJ1MzPirTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZKXOoppMl+ZJQFQoNAFUa36aFTqiol1KXBqwtcFMpcqbKiQyvKy3u07A1iqkI8KQW+LvS1ib1mrNGI18RY/ulS2Qwt19QOJ20DsdO2L9JmQ0f8Buhg647ouLo/FVzM+fMCMrTNo2WLd8xEYMzBruiGOIaKLX81fdnTn3t9q2h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYpQr3aC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a998a5ca499so860228866b.0
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729696888; x=1730301688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKZ0RLbM976KwVvBAcXswPDIrUo+ep7kQOJ1MzPirTU=;
        b=YYpQr3aC4utwbtQ+6EgeheYypyOmxZvjGx7SG/a/wlakDGii4//hI4PZakFBgmxOJ1
         PUvib8VvPmHmXCSBpPfkMPBfh6777jkrVPUOumCp/huVRl2jTqild4P2TX8NEMo89hJ2
         5OGUoLZAKEuhR//C4J9XFQGs/cgGgAu5pBvHi9FQlHmEktorqYyB+JDnMtEZm0x0LRbp
         jKL6HUZ5um3VW3ooki0jw+GSXqrZ/M/ZWESKPYRddxCntgt3NsOsADmXPlFwjpIhId95
         FC2PrfBg6g6TCQYyuQ1xf+Uq9p6DebxwUKlAEMDOp8SMYCjjYUUzyoVbN2YtOf971yMS
         QhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729696888; x=1730301688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKZ0RLbM976KwVvBAcXswPDIrUo+ep7kQOJ1MzPirTU=;
        b=LnIqNdR3lC0uoZ2NMIapoh4BTlUQS/ErceceapTPSADQb8AUjmZY2gWJKgkRKP4LLh
         IIBLcBKoZ3Ae49OeRAtz2QB2n1INWVRPhLx2x/jir/W/pse1k5vfnZqeBkM04I8F4jyk
         5q//gx4ZA1SYjDLWrOLjrPRJAgwZ2Akp4kmoAhqaHf+xJ+Sjjwj4wFahAJGfhy8GbI/t
         Ft5IkZ0uCtc9kJGGr4mkinykmVDsmTQfkpbyQUKSDrtPOLecZ0hvzprxyPG/Gq0uwZVr
         vH/CLkItQjE1TmFuNkNdecGws1CR3iWRTDZZIzZpRV4Xs1aSnl/ukygKBpPKFdDjfIRS
         Z6JA==
X-Gm-Message-State: AOJu0Yw7y5dl4rd4Qd4K+ZurXEOKzVQf0Dl6j9H1geSLMLkVcGw0byih
	QhTaq195vR7iJc+EM/2dxRkqN1MpM1mr6ENQpstjNz01aPwUqvS4EwXoAlfVF/BUw+zRHNDscYi
	v6Tl5Q9lUq/Eqp9QmBVskdUkUn3rVmNap
X-Google-Smtp-Source: AGHT+IFnmNgTNASo/MZie4IqFFrE/n8XEraA/j8sKo8F8QuC1ZHU79Fc4Wp7L+I8Ksi7huCQ2pgtJLD0lhuFA6MEdcs=
X-Received: by 2002:a17:907:3e9f:b0:a7a:9144:e23a with SMTP id
 a640c23a62f3a-a9abf94d3e4mr303243466b.43.1729696887964; Wed, 23 Oct 2024
 08:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE8EbV3aruDHKrBezSLg_hy0XZG2Dr1pkzvXVVTj0QpNpH86nw@mail.gmail.com>
 <66d96956-e393-41e6-952a-3f23ebcd3a79@intel.com>
In-Reply-To: <66d96956-e393-41e6-952a-3f23ebcd3a79@intel.com>
From: Stefan Dimitrov <stefan.k.dimitrov@gmail.com>
Date: Wed, 23 Oct 2024 18:21:16 +0300
Message-ID: <CAE8EbV3SGtNhYNN4EGonQrfiezVf=ZjC0hoB+9_0qxETm9E4tA@mail.gmail.com>
Subject: Re: igb driver: i210 (8086:1533) very bad SNR performance
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 4:38=E2=80=AFPM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 10/19/24 14:39, Stefan Dimitrov wrote:
> > Hello All,
> >
> > I am reporting the problem only, because the exact same
> > environment/setup is working perfectly in Win7 with Intel driver
> > version 12.13.27.0 from 7/8/2019 (I guess that is the latest driver
> > version for Win7 as it is not supported for years, but it's the only
> > Windows version I had during my tests).
> >
> > So, in very short: the same 20-25m of UTP cable, works perfectly in
> > Win7 and not at all in Linux with i210/igb driver and my best guess is
> > PHY initialization in the Linux driver compared to the one in Win7
> > drivers somehow reduces dramatically the Signal-to-Noise performance.
>
>
>
> > P.S. it seems i217 (8086:153a and 8086:153b) is also affected, at
> > least based on my very short and not extensive tests I did today.
> >
> > thanks,
> > stefan
> >
>
> Thank your for the report, I will dispatch it within Intel, we will
> communicate the progress here.
>

thank you! I hope someone will be interested to look at the problem
and even fix it, because it seems significant to me due to such
obvious and huge difference between Linux and Win7, at least based on
what I see in my test environment.

> It will be beneficial for us to know the firmware version used both
> on Linux and Windows setups.
>

please, see the FW version reported in Linux below:

# ethtool -i enp4s0
driver: igb
version: 6.8.0-40-generic
firmware-version: 3.25, 0x800005d0
expansion-rom-version:
bus-info: 0000:04:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

I am not sure how to check the FW version in Win7 though. however, is
the FW part of the driver or is it burned to EEPROM/Flash chip on the
motherboard or maybe even part of the motherboard BIOS? in that second
case it will mean both in Linux and Win7 is the same FW.

> For future reports, consider also CCing the IWL mailing list to get
> faster responses.
>

thanks, I was not sure, which is the correct mailing list in the first
place. BTW, I borrowed from family and friends few PCIe Intel Ethernet
cards - different models and chipset - I hope to test them during the
upcoming weekend and get better idea how widespread is the problem.
Also, I found several reports about "i210 low performance in linux" in
different forums, for example:

https://forum.openmediavault.org/index.php?thread/36799-dual-on-board-intel=
-i210-low-performance/

and maybe it's the same problem - I mean if the SNR performance is
that bad and it's that picky about the UTP cable, maybe in cases when
it connects, it cannot transfer the supposed amount of data,
especially on longer UTP cables. I cannot tell more, because in my
case the Link refuses to connect even as 10Mbps in Linux, while as I
mentioned in Win7 it connects as 1Gbps and I see no performance issues
whatsoever in Win7.

> Best Regards,
> Przemek

