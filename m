Return-Path: <netdev+bounces-244171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0E8CB1318
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 22:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 981433023566
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 21:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9542727E0;
	Tue,  9 Dec 2025 21:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFnwEemh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635882EBB89
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 21:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765315730; cv=none; b=i/D2IuF/9uzDx2Bn/Vs+iFyMxyABl+Z7oFu9ZrIb8RB/H6Bk9ZIMKhKT233e627cozSlPA1NcM9RZFKLFQXOHHFLstB8l5AxGHa0zdt3WIJ/bPHYGFSD1ze34jOsJo09aNj5PrEvgRllQNVN3X31YEGAbYmqqqbqj9QCO55eaLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765315730; c=relaxed/simple;
	bh=iQOG3N1YgG36US/X17rOmOupxuV1Wcn4H4xf4OfX/X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBHfqMzsTT+YvDV69mj+K8H6hKec9f+K2qFlCdZplRBqCdOkeCzZFZYDg5pcjb70eYNsfhsO2BQi3opr1WT9VVRMb4GQkQ+h/TVsnIO2Mz87uDgaXBpmG/pyCRd7Ki4p9mGAZ11/GUB9VF5I3JvzxqAbmO2cQLl8HdNBvYbJKEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFnwEemh; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b73612e620cso78742466b.1
        for <netdev@vger.kernel.org>; Tue, 09 Dec 2025 13:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765315727; x=1765920527; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6KdPDL+qEVcFOmw2u283MuRo/oz188auYP5u+mGxWi8=;
        b=CFnwEemhswq0ojGly9ykyiME8u7BwF4252u3/HJzyaBfO+J1kyyeOzyWdwNnmNmDaq
         JKSvbOo/jv+5evzwRULGLhaf/cLD5dN5RoBq8+50x0ZXhYeLdu7NG63/6hxD/lJlM4w1
         1G8LkC9M7QvhCp+VZwfQUa7D850uJW83DSL7j5O4O9eUbBMh6sLWlReUP8YarsDtXVIc
         OcPoVRD6qkftBM+hkq8a6k3oMT3d6YRtO1E60Rwx/JiusW6+cvI7qxFJp6j6stHjdhd8
         n0LC9WEdIyA2bN/AA07c2nNLSbmKoJi2IVuW31M8oHg0Vayz9uuMzoX9XKStDmniJvPg
         Qz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765315727; x=1765920527;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6KdPDL+qEVcFOmw2u283MuRo/oz188auYP5u+mGxWi8=;
        b=hXlrqe0llZHgqAcRlM138na59htNPCPIcW0Icpnf4qrsC6tY2CEEJfmXK4u63VjEVW
         830IrM4dv2jMin3WaNsUvEZ8hdTqKKBRCcWoG3ybd0EpBW3xmI7BtkYD5kN9m5NfGB7m
         3lpQnuhDBLgeB+iOc+adlgP1bfv2b6ASkulq13Zyeh+tyrBwQVa41mKA2O3+4HngSNRa
         OkoplQDq4AlbCFUYK3JLdx76p3qI6QTBpD//90bJzRfOkqrXf6IEsB1uczzFakqhc4D4
         4h1uZ7LcQLw5cvhvqOrvI1r+l3GPkVQW2xx4lTVLMab71YefDXaeqRhkwWGPUsaVfii6
         aCQw==
X-Forwarded-Encrypted: i=1; AJvYcCViuDmhGJKpBvLPxskllUz+X6VtvXqLrJ1c7+8BrZFOXm4nvJez1ETkbkcNoGlHDEn2UA+J904=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/0RPBX8ig4FNutt1wCL+D0tagCf1eUmWB4Xs8OMEaUTnQHBE6
	LFqlytydXMAF/8XxXsgo5PuHP4SZeWidqnGkh4b4olGExwTk4bIVArhU
X-Gm-Gg: AY/fxX42F4H+SoldAyKxoSn50Ar2BSkltqTaNvCcoMeIjMaImM+NE6B++iQXM+rprDU
	q/u5OwFXpKyEfzkM0U18RCP4BzQEKyDbGIOub+V1o9DkJhylVQd23Z0R6p2jjljBNoMXzDweqOa
	9PdtyUSvzCzNi9M70I/9vd5UsNrilR8qcQjWyEMgYyGvv19Uy89v4pWB4t1Hf9TLYYJcr2/LfVN
	Ht/pzkwnTjy5L2WElCLarMJYIgR2IEPhAYHvgFtn3rlxuc4kWQfuDvkAfqQV+DzVWoWTwwYF1+F
	q/xAxqVa2s7JkJ4dBb0SBlI6huy5jwoOBNOV9W1oVQAMjDfepiROtsAib8/oltEweGJ4d224hfW
	TcnX8Q09HA630fKI6dPlyPVN608BPPFNrcflDPqX1ZblZqBa6c/VmYum8KfEhi2XVCzWi47/Rr+
	fyDwY=
X-Google-Smtp-Source: AGHT+IFj/5wMArLmW3OmgzskhhnbPrwRXcYYDaRCfYhUBMAssQaU+5cD3/Q1W1ov5oVEalokTWW63w==
X-Received: by 2002:a05:6402:270b:b0:647:5055:6690 with SMTP id 4fb4d7f45d1cf-6496d5ec098mr165057a12.7.1765315726430;
        Tue, 09 Dec 2025 13:28:46 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:116a:e491:5469:b955])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b4121eb6sm15083879a12.26.2025.12.09.13.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 13:28:44 -0800 (PST)
Date: Tue, 9 Dec 2025 23:28:41 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH net-next 09/11] net: dsa: rzn1-a5psw: Add support for
 management port frame length adjustment
Message-ID: <20251209212841.upskgi5dphsmkrpi@skbuf>
References: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121210504.ljeejnltaawahqtv@skbuf>
 <CA+V-a8ve6vV_O1XwPX0sn+Qqm5QoYrf6Xu5gansxW05waMf43Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+V-a8ve6vV_O1XwPX0sn+Qqm5QoYrf6Xu5gansxW05waMf43Q@mail.gmail.com>

On Tue, Dec 09, 2025 at 04:02:19PM +0000, Lad, Prabhakar wrote:
> > In the next change you set this to 40. What's the reason behind such a
> > high value (need to set the management port A5PSW_FRM_LENGTH value to
> > 1574 bytes to pass L2 payload of 1500 bytes)? It sounds like this needs
> > to be called out more clearly for what it is - a hardware bug.
> >
> Regarding the question about the relatively large adjustment value:
> according to the hardware manual,
> “Set the FRM_LENGTH register in port 3 (CPU port) to more than or
> equal to the initial value. When you want to limit the frame length of
> the received frame, use FRM_LENGTH registers in port 0 to port 2.”
> 
> In practice, with the default MTU (i.e. without applying the +40-byte
> adjustment), RX traffic operates correctly. For example, running
> iperf3 in reverse mode shows no issues, and frames are received
> without errors. However, in the forward direction (TX from the CPU
> port), throughput drops to zero and iperf3 fails.
> 
> When the MTU of the CPU-facing interface is increased (e.g. ip link
> set lan0 mtu 1540),

"lan0" isn't a typical name for a CPU-facing interface. Do you mean that
the primary action is that you increase the MTU of a user port, and the
FRM_LENGTH of the CPU port is implicitly readjusted by the driver as
well (to 1540 + ETH_HLEN + A5PSW_EXTRA_MTU_LEN + ETH_FCS_LEN)?

This isn't actually bringing new data, because unless you also increase
the MTU of the other iperf3 device to 1540, the TCP MSS will still be
calculated as if the MTU were 1500, and you won't be making use of
larger packet sizes on the wire. On the contrary, you are introducing
one extra variable into the equation: with this test you are also
increasing the stmmac MTU, which you later clarify that by itself it
doesn't change the outcome.

> TX traffic immediately starts working correctly.
> Likewise, increasing the FRM_LENGTH on the switch side for the CPU
> port resolves the problem, which indicates that the frame length
> configuration on this port is directly involved.

So increasing FRM_LENGTH is the only factor that alters the outcome.

> Given this behaviour, it appears that the management (CPU) port
> requires additional headroom to successfully transmit frames, even
> though RX succeeds without it. The STMMAC driver is used as the
> controller driver for the management port, we are trying to determine
> whether there is any known interaction, alignment constraint, or
> undocumented overhead that would explain the need for this extra
> margin.
> 
> Could you please advise on how to handle this issue?

Have you verified that the value you need to add to FRM_LENGTH is linear
for MTU values above 1500? I.e. that at MTU values of 1510, 1520, 1540,
2000, ..., you always need to add 40 additional octets to FRM_LENGTH on
top of the ETH_HLEN + A5PSW_EXTRA_MTU_LEN + ETH_FCS_LEN extra that the
driver is already adding, and no less?

One other thing to look at is to send known-size Ethernet frames using
mausezahn or ping over lan0, run ethtool -S on the eth0 stmmac interface
(this will also capture the switch's CPU port statistics counters) and
see by how many octets does the aOctetsReceivedOK counter increment for
a known size packet. Then, if you go oversize, look at the statistics
counters and see which counter marks the drop. Maybe this will provide
any clue.

I don't have advice, but what you're saying seems highly unusual,
doesn't have an explanation, and is not fully characterised.

