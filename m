Return-Path: <netdev+bounces-208382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E6EB0B329
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 04:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94E4189EA3F
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 02:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852E828382;
	Sun, 20 Jul 2025 02:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9zesbQE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541A4F9E8;
	Sun, 20 Jul 2025 02:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752977906; cv=none; b=P1yWWn94xH9klYqV2M7RfCBL0baOrWLam3iYl/dMTalMNzFT3P7HNRMtHpdujki6mSVACmt/8TYpoIJzK/pQ+w/QnYHriBM1NG6M/xU50amnKSX7IJFMQ4embb8yw181EiZDUXR2z3n3g9244Qg+08t3tOXC4zZ061p26a8a0XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752977906; c=relaxed/simple;
	bh=CIWtVBqjC3CNHLKXJxGywWbd9i7KkRe0Y6wKziL2x8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZmLuj04sfxvWQh/h1/FxYzqu9uc6R4XExCIVE6HrjQbyjpMQ41mpmqtnbNPspyq6D17E58MEfJdJieddGTM7k0T1fjYfnVrVACxkTHfVshDHMXefwFY+8S+JHKQVtOgnc7PKiRK2t5DFg3q+2GQ74bSq1CaSVUy2rq/VctLogM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9zesbQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90D0C4CEF9;
	Sun, 20 Jul 2025 02:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752977905;
	bh=CIWtVBqjC3CNHLKXJxGywWbd9i7KkRe0Y6wKziL2x8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p9zesbQET/vThWqorjXk/2fA1/iAxv6Yv7xV6i92m4r4KQDXpRuaqEP8HgEygU8VR
	 LeYRa5hEj1td32lELf08UtHl9MjnOexpL/eEvziOwkdfui1DYDXukQiPFUo4tw0otT
	 9WEjACmqeZ5Xo3ijITetDrAgukPpbUWqVgYgUOUEH89IPaIitIMRXtqvjxXtxDlsH5
	 1l992jv8+c9giwrGi8bbu1td+yERu6gybb1hHBVRhiET8m2P404KPFShMJoYAxghht
	 xDDZ2rVKKsUrUKYBjM/ToqpKWwj1FeOgxQCoUofnbLHRo2p2ToMeBTawl58VBubmBN
	 v2m7KrtLO/fIg==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0bc7aa21bso643278266b.2;
        Sat, 19 Jul 2025 19:18:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU01VblCd0jc+zR0zS9Ed9x9io90Hxuvgu8Cg9wAm+ljfgTOxCYDQ4z4zj7ohcN2/dd8I32Hgewtran@vger.kernel.org, AJvYcCVRosJyKzSjX1Iw+wtY+z1fEck/NmwhCpEWp4B0RDkmgKb3TKiz5DJePG5df1wflgdRriWeo7kCz8/Wv7dN@vger.kernel.org, AJvYcCW12O13OUKcIIc8FBblnlDxc6KwThfepQkvKa9LCH15NNAKfQ5WUfs89teWCsnErYr56L+J/mDw@vger.kernel.org
X-Gm-Message-State: AOJu0YyHwDIrjlAOx0a1lq/bq1GADYrXlXbuQRP8H5VfpE67mTz9Ujzi
	EBEMzYj3D9Z7WPnAg5tdITvRU9x0RXvX57o5Bd0ts68YPvut6NGERgR1q1kCDybHpDOwdRjYmJZ
	PqiwVQhelcGI92Y4dI8KVeHw+jI/4+Q==
X-Google-Smtp-Source: AGHT+IF73wL3Au0Ow4fJuaa8CNdtP9Vv+uineKG9cPG87uBliI18it3QFFJ6u3khp61UtQyoAQGWVTxdNcrQVO4osII=
X-Received: by 2002:a17:907:96a2:b0:ade:3bec:ea40 with SMTP id
 a640c23a62f3a-ae9cdd85e2cmr1733577866b.10.1752977904268; Sat, 19 Jul 2025
 19:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702222626.2761199-1-robh@kernel.org> <a965baaa-c4e9-4d99-9143-466b11bc19f8@redhat.com>
In-Reply-To: <a965baaa-c4e9-4d99-9143-466b11bc19f8@redhat.com>
From: Rob Herring <robh@kernel.org>
Date: Sat, 19 Jul 2025 21:18:13 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLUuMV7RNqziCPrxnXVN+m3LhjqTk2kBEEEwtdWzV6+SA@mail.gmail.com>
X-Gm-Features: Ac12FXxcHbkIPVvaGIon8h_AG_UFUT6Pxckaj6PeYRO2ee1rlvOrMtuFN3jYRJQ
Message-ID: <CAL_JsqLUuMV7RNqziCPrxnXVN+m3LhjqTk2kBEEEwtdWzV6+SA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: net: Convert Marvell Armada NETA and BM to
 DT schema
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 3:46=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/3/25 12:26 AM, Rob Herring (Arm) wrote:
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/D=
ocumentation/devicetree/bindings/vendor-prefixes.yaml
> > index 5d2a7a8d3ac6..741b545e3ab0 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -21,6 +21,7 @@ patternProperties:
> >    "^(pciclass|pinctrl-single|#pinctrl-single|PowerPC),.*": true
> >    "^(pl022|pxa-mmc|rcar_sound|rotary-encoder|s5m8767|sdhci),.*": true
> >    "^(simple-audio-card|st-plgpio|st-spics|ts),.*": true
> > +  "^pool[0-3],.*": true
>
> The 'DO NOT ADD NEW PROPERTIES TO THIS LIST' comment just above this
> block is a bit scaring, even if the list has been indeed updated a few
> times. @Rob: can you please confirm this chunk is intended?

Yes, it is intended. It's not new properties. It's properties added to
the schemas which I suppose I missed when initially populating this
list.

> Also I understand you want this patch to go through the net-next tree,
> could you please confirm?

Yes.

Rob

