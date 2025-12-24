Return-Path: <netdev+bounces-246018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6CECDC765
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 15:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16432300DB9F
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 14:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EF9352957;
	Wed, 24 Dec 2025 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="OwOktS97"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BC5350D4E
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766584888; cv=none; b=Jrl7jwOwBM1qKk/uj1gtcYMWtYNV8ZmJbmxDg0uToA8hkJXd1I6hyxeiZIobM+xT+diCohI0pE5ifKWmvtIoftt3bb1zij6yNS+gfdNBfTD2Ktwj/NaYBBjtsruaRfVxwS3HSqGyK7dnICZNgFpp7N1or0o9bS5CP+l6FjRNa5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766584888; c=relaxed/simple;
	bh=I7+JGBFRKWqyrnVXzLUaDYsKdcEDRxDNeUF16RxUnpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rro0LrI96CtmXjOPEw60MI8aoVTaAVbmUrKMi07l+Wwf1wf0QnxY6Y1d/L15njAYd4qs5+PZ0YAMPaBzupd103Wa+G4aPrVps9nrxvaGgfz504RW7kIo9oXM2bUYAt0OUAzhWqejnLVYq+QPcqFd4SeQy3UKueNWBi2Z6v3Xy20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=OwOktS97; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7355f6ef12so1128337466b.3
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 06:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766584884; x=1767189684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7+JGBFRKWqyrnVXzLUaDYsKdcEDRxDNeUF16RxUnpo=;
        b=OwOktS970iZyjTToJrv3vpFIp+TVfoApn5xuvs/UTEwPPJRn+MEeHzVu/i5cdpLGVT
         c0Qd3a6PUuoevDp7TY7TY2CybeAVSC7N8/jEA5T/5hFTwdqieiluHy54dP4zknESaAGB
         bNizDukwvsJqgYnyjKPfBCH5tc6upXcXTkq41BQxwzaYcJAi6GMbJAHalK3kUHPjUC6H
         RPJtAND8ymrvcy8Nq2bqkNF6MRBftJGGzwdXE15I5yysfQ8A66e79CCa10L9imyAbH/P
         V4ZeStIKcTcR1gknTPgWu9Lclta6kc8pRDXW8YZMteJrXRcw5mrBiaS3bHY8ZvKq8k3r
         7TAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766584884; x=1767189684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I7+JGBFRKWqyrnVXzLUaDYsKdcEDRxDNeUF16RxUnpo=;
        b=qqE+ssUouydAeC1sEPfgmmfCg6uexl5jVzXRA1hRFsP8Sfj6r6VIpmgrzbMc44YSjx
         xVfo0Jc72Vqk1T/G1UpU1qT+cEkOIO86cUsSEv+230Yun1WwsP7dpMol7shS7oYNvVuB
         OYECCj0bmOcW6XTrMgL7nxf82J/5OD7xlUfZJrsrGChP120b/S6tUWcOpLwsPpM0SQEL
         3VPTdrBoREhMGyeUVPrBYcwhDQzUBhnDBJs1MORxKWYIZXzfABasHRKR/kKgz+DViWnU
         u9tiuz+uu24fcETBMu/rL9f2ZjenMqHDJNjHRLZ6tnxoRsJn0i0sAHxn2m2MbvBTWb2Z
         U4kg==
X-Forwarded-Encrypted: i=1; AJvYcCX0L2/lEcU+2nztmX0aaOQAyhEw6jxdbzzrWsXctEEgiMQOPk6W1xkP18w0mSwLy+tQroHrTi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC6R4KilAqW8HdYp5kR9S5HnP7SugDmslhIJYVh3wIwV5GLIkV
	W1oreDhZgCz/0VdJmWmDGr0K2N1C6uhkv123bzINvx+gXNOPcuV+rALO8RDLUx0UEPAGZBMtd0G
	tu05bpBTocHSGFxlIujul/gsodtNoxXKTGR4r6SA6Hg==
X-Gm-Gg: AY/fxX6bTkofv3GA3eP3adHT4vR3rzLSdXoWfxFqUOl4U0ythC3dcsBI6YORP4LfGX5
	f2Yir2Q5JN0QDCgHjTR48uovUpAvH9tantyH1nBlIupxr65lMOyAQJ7Juwly1M0GGZDGyf8SCde
	FFIPEMeb/M3OyNHlQ4xn+aVpH3yOyZlgarccfyMeW/3UiCnXXu+HPnXRj8IpZF0NBzMTKXvLEbN
	yQzvtdMvuQYhnS/ruaUUlv/xAdBMJgze6KoSRhcejJ4D8XZnh7m54hrqcrNw+25bK+PZw+wCjor
	MqyQUI+VNqD+Z2K8RO4Lv7qPw5cqTe6gcZbNqf2WyyG+4qKyPw==
X-Google-Smtp-Source: AGHT+IHCXMeYFxQVcU8rJRtC/cDnDm53nQPvIw0Xbx77plqQqDjE4I50qoqJy3GeuDjgR14U8tTAxFKyl0h6HDv3chw=
X-Received: by 2002:a17:907:6e91:b0:b73:8639:334a with SMTP id
 a640c23a62f3a-b8036ebd999mr1821689366b.13.1766584883876; Wed, 24 Dec 2025
 06:01:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223201921.1332786-1-robert.marko@sartura.hr>
 <20251223201921.1332786-2-robert.marko@sartura.hr> <20251224-berserk-mackerel-of-snow-4cae54@quoll>
 <CA+HBbNGym6Q9b166n-P=h_JssOHm0yfyL73JZ+G9P81muK=g4A@mail.gmail.com> <78bf252c-fd5e-4a36-b1a3-ca8ed26fde7a@kernel.org>
In-Reply-To: <78bf252c-fd5e-4a36-b1a3-ca8ed26fde7a@kernel.org>
From: Robert Marko <robert.marko@sartura.hr>
Date: Wed, 24 Dec 2025 15:01:13 +0100
X-Gm-Features: AQt7F2owdEGYn8vQgdJCyQRcW10NeJzDUOJWapd16DEqGEP6zPqPRLNSqy5Q0Bc
Message-ID: <CA+HBbNG+ZVD6grGDp32Ninx7H1AyEbGvP0nwc0zUv94tOV8hYg@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] include: dt-bindings: add LAN969x clock bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, herbert@gondor.apana.org.au, davem@davemloft.net, 
	vkoul@kernel.org, andi.shyti@kernel.org, lee@kernel.org, 
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, linusw@kernel.org, Steen.Hegelund@microchip.com, 
	daniel.machon@microchip.com, UNGLinuxDriver@microchip.com, olivia@selenic.com, 
	radu_nicolae.pirea@upb.ro, richard.genoud@bootlin.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.org, 
	mturquette@baylibre.com, sboyd@kernel.org, lars.povlsen@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org, netdev@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-clk@vger.kernel.org, luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 2:05=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 24/12/2025 11:30, Robert Marko wrote:
> > On Wed, Dec 24, 2025 at 11:21=E2=80=AFAM Krzysztof Kozlowski <krzk@kern=
el.org> wrote:
> >>
> >> On Tue, Dec 23, 2025 at 09:16:12PM +0100, Robert Marko wrote:
> >>> Add the required LAN969x clock bindings.
> >>
> >> I do not see clock bindings actually here. Where is the actual binding=
?
> >> Commit msg does not help me at all to understand why you are doing thi=
s
> >> without actual required bindings.
> >
> > I guess it is a bit confusing, there is no schema here, these are the
> > clock indexes that
> > reside in dt-bindings and are used by the SoC DTSI.
>
> I understand as not used by drivers? Then no ABI and there is no point
> in putting them into bindings.

It is not included by the driver directly, but it requires these exact
indexes to be passed
so its effectively ABI.
LAN966x does the same, but they differ in number of clocks and their indexe=
s.

Regards,
Robert

>
> Best regards,
> Krzysztof



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

