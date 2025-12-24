Return-Path: <netdev+bounces-245959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D5BCDBFEE
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 11:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5C29300F17E
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 10:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87303168E1;
	Wed, 24 Dec 2025 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="QkflirsL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB932C0281
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766572229; cv=none; b=n2end6hCkaIaexK85Uaj9yBa95Wzz67xhhQI8mgkSXOxbAV5TmE6NLLs2LCwc7m7mXrtWJpqFHntQcqGe6gh3iNdSHLlIRTLqwHf9LkmtKn6gXveDrJQcjAlesDeV4Ryx111lPVWRylBDDFHlcffcqSGkksaFP57D4MBXPs+TUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766572229; c=relaxed/simple;
	bh=KNz2TcJzJmqF7rsKjUpwytr/M43/Sc2TIAVK6pF3yUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LiNe+0sj+wagXpIromUCfahf04EST4bnMi8bFku7PAXgcbQwnIN5YdJjrO6tKhWM8JxcMRaQrQZG1qelC0XQ/E6u8w8aL7oNfNNxrVAVF/99LDH1IIBC8LfVa1n2IkBvZjDw9D8cCx849w1WfjY9mWFwCgMwG1KY18HXbgmm+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=QkflirsL; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b73a9592fb8so1096719766b.1
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 02:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1766572226; x=1767177026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNz2TcJzJmqF7rsKjUpwytr/M43/Sc2TIAVK6pF3yUw=;
        b=QkflirsLWgw6/rIVLUiHc+xA6dek2yABjKGT4i+A+L5IppltKVDlUGSuOMevhCMgcK
         ckCLksZyu0cznkJw9n+xpMrIVsyQ3Vziem1/pZP0tLUIfK9BDzN3rwJgG/wSnpHiLBmn
         TbECIwlIAMkmtsBG4zMVFVhSwlOxuJaxJtFPNAujXepGgZdMwiScXo/ikP27cH5mMmK5
         QdxyunnKgaVS/qXTP0+3piJErhrQ7gDnG6FI1Dwa1lihHSqS/wyP5Uwz562Viur8V2EB
         fBVLF6esy6inerOy3NioZOYB5LpnIbIj1uwUN/K3fkNamRPUqXKSwot/bT8w1TYli6/g
         f0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766572226; x=1767177026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KNz2TcJzJmqF7rsKjUpwytr/M43/Sc2TIAVK6pF3yUw=;
        b=qJMCS8XXd07EbuJN4cjkb4V7ZltVskQLz7pd98VQgFaqSSvmKWfzzqzHsSKxvQSM/5
         8UASSZS4E3UmjUqYtgiCDJi98GFN1hKHCOrfkVthFcE4E2N+UwYrqYGbOdgvFcD07tBC
         Fci0YOKXmWjSA+iSMfycqvBIVgJZsEKkukXlWsL1mYJyzwXEUBTzT+G7ZphBzDsjERzH
         YgWTqFjt9lb2k29Uc5Y9AibRvQ8uOp5AiViD4NlXcpVGN1TuTYN1gJE3SKO5Svzc0vuu
         BZUr9nOv+PnFw9jdvfQEwylNuhQH+lyTULpqU12UXbw6M7oo/dJkTQ95tqCPin7kJ/5F
         ZPvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2eieXmDMzpEnOXJaGIqpJIgGlrlkDMCzzWyoyFGtfMXgxDap0eMRDpXVMsMp6gZw4bRAvYas=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA4njFwqz6z34262Fd9YUCQfTmZgnxgEbUTHfMsK5VnOun3Q/q
	pvpjwPnBP7BOTU2kqH2wagtUrcuKn0N403a3JqSYyP8oM2GGAv4GhTjpNL1jBalSfyKWFvrQomG
	V0QkGAjtZeKAeLF1ffYLYa2vX8bHoUt7Kwvv/nEXBqg==
X-Gm-Gg: AY/fxX73HBHzE3nnHaWhCSqNWeGoiuHbxcPqsgWwN4xAIw+OiicagzMbI/UwuSOaKSA
	QEQKHsL42CoBNB4nTJMIPAshuu9gQQpwquWVVZybLEOY017NDSA5yASeFaGdjvuyZ0dlDs/oTYt
	uUcW1KTqnXdeCo8mSWVlzPgJEBnmBsVwuTfAid0sT3/0Y74cWvPNhPPWzog8JM+DPQsAI1pJhWy
	EYjGnbRmuPICuIoo+sve8+38PJQZ8nRJGhFhID9ApZIzvX11+wjxr95J0y2JPrEP8uD7LKqzbta
	jlwKf2Axj8gGnPURbQ/Qy4w/EKu9FpEl3uMLpqLVV1CX2/0mhjJhVJmoZ7dF
X-Google-Smtp-Source: AGHT+IFeflXA2mce6O+1rdmvPjP/12/Umt2Y99WbRQ8cM3OEzOcKAWgIne20UzsSB0V8xKjPoflCDtb5j1Pn52N5SuA=
X-Received: by 2002:a17:907:7f01:b0:b71:ea7c:e501 with SMTP id
 a640c23a62f3a-b80355b2523mr2261188266b.4.1766572225170; Wed, 24 Dec 2025
 02:30:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223201921.1332786-1-robert.marko@sartura.hr>
 <20251223201921.1332786-2-robert.marko@sartura.hr> <20251224-berserk-mackerel-of-snow-4cae54@quoll>
In-Reply-To: <20251224-berserk-mackerel-of-snow-4cae54@quoll>
From: Robert Marko <robert.marko@sartura.hr>
Date: Wed, 24 Dec 2025 11:30:14 +0100
X-Gm-Features: AQt7F2rVNXRXeSbgmjkb2SKB7p5AiaNihNvuJMBrgMZ7XIKTnJcRJJO5brWpKNE
Message-ID: <CA+HBbNGym6Q9b166n-P=h_JssOHm0yfyL73JZ+G9P81muK=g4A@mail.gmail.com>
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

On Wed, Dec 24, 2025 at 11:21=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On Tue, Dec 23, 2025 at 09:16:12PM +0100, Robert Marko wrote:
> > Add the required LAN969x clock bindings.
>
> I do not see clock bindings actually here. Where is the actual binding?
> Commit msg does not help me at all to understand why you are doing this
> without actual required bindings.

I guess it is a bit confusing, there is no schema here, these are the
clock indexes that
reside in dt-bindings and are used by the SoC DTSI.

I guess I should have titled this something like:
dt-bindings: clock: lan969x: add binding includes for LAN969x clock IDs

Regards,
Robert

>
> Please use subject prefixes matching the subsystem. You can get them for
> example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-pat=
ches.html#i-for-patch-submitters
> Bindings never have a "include" prefix.
>
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetre=
e/bindings/submitting-patches.rst#L18
>
> Best regards,
> Krzysztof
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

