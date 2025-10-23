Return-Path: <netdev+bounces-232084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CA2C00A8B
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2397319A1EEA
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C32A30C62E;
	Thu, 23 Oct 2025 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/9otqDC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB96430C375
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761217983; cv=none; b=qqZ76kAp3/nPQGsOkkOaCsdAkljQTwHtGErhqAtYP+0fR9PYICdp0coe4Gph6XAQARGWdwRX6nFEv1MD9Uma0qd2IcAa+6N9jSLGz8CKr1Tf1staUFjhWeXuAvp1Y8A22j9AciTkqIzAFLJSZ0kWeNo+t0xyPj+AmIttG5D9xjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761217983; c=relaxed/simple;
	bh=VSofXPKltqSzfUAWfolhUYjZILc/jZGqF+OMoYUXiPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQ4dohumo5xSHCJ3u2JxCSBFSWOrH1xC2klxRxkPiYfdHQ6+M/3I4eeV4h+CNpFZ8RLyiMPSzoGeUhp+3K5lrSaol3qH9n66ncP6/9JB+6xBfbVnMU9VsHCC/cz/QkL0MiqyE98Qqadb/7b9eti0r+w5iZHm1I6R6PO2akP+Kog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/9otqDC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81E2C4AF0D
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 11:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761217982;
	bh=VSofXPKltqSzfUAWfolhUYjZILc/jZGqF+OMoYUXiPg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f/9otqDCFyr/bE8MPe6ch3MwaJ1kyi5Kq9EIZzV9+hO+1AqinNOOZIBZfpxkZRBqx
	 bptX2Z7iZb5DDWZPoMUACkW/5EdPelk3FYviPAFMHF+r1xSgv+FD44cW5wPzUX7Vyc
	 UPCAoHqzRafCo4j3+dqcrjFjn6PVF/Z7dw9lvFYJ6AmGmD8inamXBApCsgijcdvu3k
	 yXw1KqlJ3tglPWS5WMKmaV+7TnJPTBD6NZi4BjsttO4YmL8W2P0xo+qTjb1yXtETSh
	 XAnPXhkXsJd8nEoZ9xMO9tYn/xk0twYm9keODkjt+L08SGR9DeHjrO2bSqxLW2ppEq
	 Fk5NvYeEA7B8Q==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-637e9f9f9fbso1264102a12.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 04:13:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXB3AbZygp/RUchz5gdT/oWnTITen8kcEhigIcXqKfRh1sHoRTID9tK/2uHPJeXrvCsq2ZpjMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIPB6jzZqqs5bw2NgIOzgEK558urrVn7pzgnng3ELdSGIAYLb1
	TulHGqzsdO3G1S1LoYgkhcfquT2QDyyl2dellGedEuRhEDaoFnwgln6fTAZymYXiCKpVs8iqwJm
	P8PqAU0USUsqnE5Y0VXDzIwYraubZbg==
X-Google-Smtp-Source: AGHT+IHXTXK9Inhzp31f6w2tfR0eGiG69ffpyx6TLgXjLoQig5J/jMOVgrMAnyrlyG50AeAs4SS7Rb45JstbYWrnInk=
X-Received: by 2002:a17:907:9690:b0:b46:8bad:6970 with SMTP id
 a640c23a62f3a-b6d51c05e68mr217698766b.36.1761217981126; Thu, 23 Oct 2025
 04:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022165509.3917655-2-robh@kernel.org> <87ms5iqf5b.fsf@bootlin.com>
In-Reply-To: <87ms5iqf5b.fsf@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 23 Oct 2025 06:12:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL+DY4j62m3_BVjC7_o9Hbx4a54UORDNBC+Pg0YAQCO+w@mail.gmail.com>
X-Gm-Features: AWmQ_bmtPaFimucwq25igSrk9S_iboFzoF-uoqSjxWerG3P5s9m5XHzlE7aUD-4
Message-ID: <CAL_JsqL+DY4j62m3_BVjC7_o9Hbx4a54UORDNBC+Pg0YAQCO+w@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: arm: Convert Marvell CP110 System
 Controller to DT schema
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Richard Cochran <richardcochran@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 1:57=E2=80=AFAM Miquel Raynal <miquel.raynal@bootli=
n.com> wrote:
>
> Hi Rob,
>
> > Convert the Marvell CP110 System Controller binding to DT schema
> > format.
> >
> > There's not any specific compatible for the whole block which is a
> > separate problem, so just the child nodes are documented. Only the
> > pinctrl and clock child nodes need to be converted as the GPIO node
> > already has a schema.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>
> [...]
>
> > +  "#clock-cells":
> > +    const: 2
> > +    description: >
>
> I am surprised you prefer a description to a constraint expressed with
> yaml. Yet, I am totally fine with it.

I don't, but no one has come up with a way to put constraints here and
then apply them to 'clocks' properties as appropriate.

>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks.

Rob

