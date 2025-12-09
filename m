Return-Path: <netdev+bounces-244149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E30CB07E4
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 17:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEDE53007615
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 16:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8A82FF672;
	Tue,  9 Dec 2025 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLhKu8z1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BE41AF0AF
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765296170; cv=none; b=ofvgmKZxCOfDLwKDZ9h5vVrfh9fuT9WVGeCJo4FBLEP8EKY/gJ28Lo9G7ruNGguEnWtVrXqO+JiXWgaAQDsnTSa397BWjPFlxnmemOMtKvyRUa1AnxRNEV5GLubJWC8W87Klu461pqCKAw61+5SbQhkbDPeRYy4fHJ7z3xiRVrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765296170; c=relaxed/simple;
	bh=P0y9AzHMVDw56v7bDsS/jYQWeXGxy/dGmh214wSQexQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGZlH6EdFEq61IJq/QcXFXwB0ZW83xyyQn0o5UEa0isMvK8ONbydM+fe1/OGhqYrg9qORGBSrd+x4eQR/jtkFF4quUCz1y08zLwvBTH7UXE4ctyajeef7Ow5wYTN2xXhMgbykmFbbP2yBnIn1Qg6O9FHJ85pE/6axTfeevzFAI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLhKu8z1; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b38de7940so3020302f8f.3
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 08:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765296167; x=1765900967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0y9AzHMVDw56v7bDsS/jYQWeXGxy/dGmh214wSQexQ=;
        b=CLhKu8z1SPzOOIWBMBie6+AYIvWPwmUmiSzbUL5q1pHQa1D+tacJsVO9UQGLzi1MKe
         hAVvs/MoSBoOzmRBYf2TYxZKfU1SjbR7hHgEuU3h3pr62iMw04cvtUNl6PpfmbiXCgQH
         4ER8+MQoUrMcFMZAL2f5A6+e4BLyM9V5xUoItOOMNQJtXAF04XcZY1zvVcAWqsf1aDmJ
         yksDFMWIF3xETF8yg4CTpGzDtcy5nsyR2TCpxFBMgD02iV6H9Pdg16ln5gTC7O7ZWq1Y
         Ikl1lzUWR1d/5/3C586J9rSi1ClXrQnAINpxh6NdZZCjyCByXaJWIZz2yvmpxGFR+UoS
         GZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765296167; x=1765900967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P0y9AzHMVDw56v7bDsS/jYQWeXGxy/dGmh214wSQexQ=;
        b=lGAMAj2P71ks06AGxJMw86uBtnfHfkEd3cNsuZJuDqW+wmXmAOL0EKyuhfz4y1LTEs
         +KOs51byNOxFjtDFfCCrVim0wGWzk52BYZe9eQOBVJ5KVZPbKHquK6v1fbyazsisyuo6
         ZzsR3eTdst3k3gCjc6mQj0A7EYbQqFf5ldPXF9vCAFaJobOq9XToQJr4BZ69YzjKz9S7
         TiT8RsoUoioTszPLozwedJ2uWKmQBZMfgfR7z0bN62Fz652oX8h42I3cwqpHgDimNdDM
         MuQucwmUudML5Zez+qRXvN4fqwTwgI7yjEF1mIDx51xMDKeCgdLpjqn0ZLSlfhiUuJew
         9m2w==
X-Forwarded-Encrypted: i=1; AJvYcCVYkbLX/uqBNkMfDDjx+uPdSza7OYM2FPiG//knucZ72QT3LPnHuU1GNy3cQ013AoPGwO5wSIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxozLqnkItxMU28AcsWoI5GVg9YlsumvIPu5WJl4gIYM/VCFrjK
	yh3j3iqR9gUsVwYDZ2Vm8v9iYz0Or1Dd1LxgyUuRIeYbuJVARt+bNzIPyM0exQ3Bw5FydMJrKXu
	1s5eYqvgyoECkEoqiLJaRqrHeVjTGwjw=
X-Gm-Gg: AY/fxX4LSIcPO/XFNjAJgOtiT0q0LklADy24KIPtsBQ9jeWddfJZxlBGOc2xv3T4unZ
	GhuvAALZb7zRCqne5tr47kXOHeGbhVh5Zm/TOdQxkZytRlomJUe3F1QrS6KY7wXLG4bUq15Zx0r
	w3SBCEnYv5tXgG4NgZHZtLo1nm4FfiRdOK6xrsob0rUZ+i3VIelklaCaJ07A7ySjpgahAtRrzAm
	b7eqODOdM0e9ilp9fwsboWLo0rIBqWpPJy3p3L7NQsU+un9MeV302RJXl9CbPG/pdTZEDaKUeav
	d+Ckh+F7EDRCoqklRKian/sovcVF
X-Google-Smtp-Source: AGHT+IF22w8WPJ+UlZl9Ma99jHI4R3o2mO9P/F/KMwatKGiWlb6HPQkmByUN17gG7EsZe26xrIfQiZ1CrwX+esSdnJE=
X-Received: by 2002:a05:6000:208a:b0:42f:8816:c01c with SMTP id
 ffacd0b85a97d-42f89f6390fmr11947805f8f.60.1765296166162; Tue, 09 Dec 2025
 08:02:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-10-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251121210504.ljeejnltaawahqtv@skbuf>
In-Reply-To: <20251121210504.ljeejnltaawahqtv@skbuf>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 9 Dec 2025 16:02:19 +0000
X-Gm-Features: AQt7F2pvBSI85gchAJ7G_EIO8j35frbGVSxrBViC0qcBM-JePncctg6lgQ7WYxs
Message-ID: <CA+V-a8ve6vV_O1XwPX0sn+Qqm5QoYrf6Xu5gansxW05waMf43Q@mail.gmail.com>
Subject: Re: [PATCH net-next 09/11] net: dsa: rzn1-a5psw: Add support for
 management port frame length adjustment
To: Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Russell King <linux@armlinux.org.uk>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

Thank you for the review. Sorry for the late reply.

On Fri, Nov 21, 2025 at 9:05=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Fri, Nov 21, 2025 at 11:35:35AM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Extend the RZN1 A5PSW driver to support SoC-specific adjustments to the
> > management (CPU) port frame length. Some SoCs, such as the RZ/T2H and
> > RZ/N2H, require additional headroom on the management port to account
> > for a special management tag added to frames. Without this adjustment,
> > frames may be incorrectly detected as oversized and subsequently
> > discarded.
> >
> > Introduce a new field, `management_port_frame_len_adj`, in
> > `struct a5psw_of_data` to represent this adjustment, and apply it in
> > `a5psw_port_change_mtu()` when configuring the frame length for the
> > CPU port.
> >
> > This change prepares the driver for use on RZ/T2H and RZ/N2H SoCs.
>
> In the next change you set this to 40. What's the reason behind such a
> high value (need to set the management port A5PSW_FRM_LENGTH value to
> 1574 bytes to pass L2 payload of 1500 bytes)? It sounds like this needs
> to be called out more clearly for what it is - a hardware bug.
>
Regarding the question about the relatively large adjustment value:
according to the hardware manual,
=E2=80=9CSet the FRM_LENGTH register in port 3 (CPU port) to more than or
equal to the initial value. When you want to limit the frame length of
the received frame, use FRM_LENGTH registers in port 0 to port 2.=E2=80=9D

In practice, with the default MTU (i.e. without applying the +40-byte
adjustment), RX traffic operates correctly. For example, running
iperf3 in reverse mode shows no issues, and frames are received
without errors. However, in the forward direction (TX from the CPU
port), throughput drops to zero and iperf3 fails.

When the MTU of the CPU-facing interface is increased (e.g. ip link
set lan0 mtu 1540), TX traffic immediately starts working correctly.
Likewise, increasing the FRM_LENGTH on the switch side for the CPU
port resolves the problem, which indicates that the frame length
configuration on this port is directly involved.

Given this behaviour, it appears that the management (CPU) port
requires additional headroom to successfully transmit frames, even
though RX succeeds without it. The STMMAC driver is used as the
controller driver for the management port, we are trying to determine
whether there is any known interaction, alignment constraint, or
undocumented overhead that would explain the need for this extra
margin.

Could you please advise on how to handle this issue?

Cheers,
Prabhakar

