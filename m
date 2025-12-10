Return-Path: <netdev+bounces-244290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD1ACB4080
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 22:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78B52304C1D1
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 21:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAECF2FE066;
	Wed, 10 Dec 2025 21:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/il+UyR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB9A2E6CB3
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765401023; cv=none; b=aiEixYO7pWchIKvoEXYT8AnFEASR+sBNksW767IzoYiae1/kWf/i6xeM3F1j2pB1vSGy1i4dL+GoCFGxVFEXCFJFPZSVWWrisqfPnEzH1J4wYVlAa4YojOG2Vot8S83jKyG+ikZSC/w+xJxZZ+JGqSGrwHeNOV+AD4vy0ZnpOjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765401023; c=relaxed/simple;
	bh=Uh+9H8bdDNwclyo234VBfjWf+hPZD/RjvnJ13fK+bUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NA2DlteO+urG89FmWkU+ASlcDqikSO7cEHJr8+fjSdw216Q+ZeVeWycw+0YKPTDKzfODRS4N+P4AobtQpdq8X8mqe4C6U69pVUzLwI31B0ELLTOX2AwJ8/SEWxs9avMZszApUgqOi9FIx1vt9XGMaRfPjwS+ERaE27mLsRXWzRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/il+UyR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477563e28a3so1828135e9.1
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 13:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765401020; x=1766005820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6Ap2wL2QNWzNOuJh0hZXjD0O0VdpkojkcVs56Al8cw=;
        b=h/il+UyRcfUV5ophE7yr1bMcD8/fMeLheEypjbuvu7gg07nvOz18oRtr5oLVz5LIyH
         xUf21BFcctap5DVpMyUTbqXg8IKTvg45zLY1ajh6etNnEuom/Cx52lsTKw3LTj41JRMB
         foS0SH8GdRloYqhxhBULP2sGCsUU2nngKpmtzwl7C11IdHVzd6RWOt8wmFfvyjn5pZpj
         VIaB0tSnlnaKxfAc9hB7116T9zslVFg+lNl+TfIgyFnFTx12y6nF4wwZveALQl5HgPu8
         p7YgcSurCZH/C/4PrCxCf2AdPcs7FoXdfw7qRqe7G76B4qLIg/ayaXaSL5cYqrCXNCoG
         HcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765401020; x=1766005820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f6Ap2wL2QNWzNOuJh0hZXjD0O0VdpkojkcVs56Al8cw=;
        b=uHoFc1lBMa5dzrQr4zUzZE7yYCwgZCdp4x4LIr6cZ3ZICLZIzq7T+KdDbmMNwykfMs
         kseB33W4t0kX2rWaMT1xV/1BHGzoNlglm0MWl9mPXgOCaXjAZtiD/1MoUiVh6/xCWizR
         zZZ9se0CQngnA6MpQV+zI8X/2HW3XNqhtxx5Lfp197LUjs56oMWkBgvhDNOP1covXzoC
         tFfnOb4DbZE9XsuajE/sgcCQNdQeHwKzEy3AFHeqccG6xu9QkiZVCN0x1WlsKrWFeTej
         4+HZ97SM8b9CtXsGsQccK7ss1aWMzunFd832YF7NhxJ++jGym5M9H+xqg4XP+INQctzB
         DhJA==
X-Forwarded-Encrypted: i=1; AJvYcCWIfzAGXA4f1FgPRnFfHhAYx0ncYxJXKLZEp+CDc39V0k4oRiOHlta2W/HpfqZHYSSKJ+rPUZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy608RtHNHGaaCcbq3IU/hQoykWfKsUCK6jGG4LHh26ehaxf5mj
	vBhiO7PX+e+oeABt8J14eJ39MPN4FS9TDaE58YeIsPen4vr/TpCddQZoGhjfNVghl90qWlsSDdI
	DFfNWXfFl85NQ/LsBmf/rvBa2GxoN3TNeygkhp/gvdA==
X-Gm-Gg: ASbGncuyk4cxV8r7flaOyrv+Y0yP2DEzycnueBnaUdy83KBgN8xZ0x8feovumd6G23Z
	1eOR0wFMYQxWzoTvSINRXeN9SKUmmLPfdTS8jPRUKY7U+Mc/eZvj1f5ivBcRRFC2ZhVBipjj/Q6
	0X1/90mdERZFtH6uDCZxj715fl8W28isvlZfvWGBYlmuWTgxV8VBm56sWDgMdYDMyzaMBx5BmAW
	spfLP1Nyu5JH5s4K5rbJESM9gympmqU0pzOT/PCwNhzb8j0QRuA2LNvUa2eh7FeXTQKM9I7Bw==
X-Google-Smtp-Source: AGHT+IFQU1/Jhu22RnkhsOBefhQOpeX8PaoabdXqTjqdirBbdMixKWOg/r6NaWYfEBa73u04Avqi37Rvk+u2FM+qxao=
X-Received: by 2002:a05:600c:56c8:b0:477:9890:4528 with SMTP id
 5b1f17b1804b1-47a886a08e1mr5232305e9.2.1765401020116; Wed, 10 Dec 2025
 13:10:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121210504.ljeejnltaawahqtv@skbuf> <CA+V-a8ve6vV_O1XwPX0sn+Qqm5QoYrf6Xu5gansxW05waMf43Q@mail.gmail.com>
 <20251209212841.upskgi5dphsmkrpi@skbuf>
In-Reply-To: <20251209212841.upskgi5dphsmkrpi@skbuf>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 10 Dec 2025 21:09:52 +0000
X-Gm-Features: AQt7F2o4iDtd3Rpuz4FTtk60m3_b-aAdWYBIboBEH1hguLv-mqZPIp_mG5EBJfA
Message-ID: <CA+V-a8vkzrO77UBeR+YhPwcv608Zh9n7CHL-ugcsuhk-vuRyMg@mail.gmail.com>
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

On Tue, Dec 9, 2025 at 9:28=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com> =
wrote:
>
> On Tue, Dec 09, 2025 at 04:02:19PM +0000, Lad, Prabhakar wrote:
> > > In the next change you set this to 40. What's the reason behind such =
a
> > > high value (need to set the management port A5PSW_FRM_LENGTH value to
> > > 1574 bytes to pass L2 payload of 1500 bytes)? It sounds like this nee=
ds
> > > to be called out more clearly for what it is - a hardware bug.
> > >
> > Regarding the question about the relatively large adjustment value:
> > according to the hardware manual,
> > =E2=80=9CSet the FRM_LENGTH register in port 3 (CPU port) to more than =
or
> > equal to the initial value. When you want to limit the frame length of
> > the received frame, use FRM_LENGTH registers in port 0 to port 2.=E2=80=
=9D
> >
> > In practice, with the default MTU (i.e. without applying the +40-byte
> > adjustment), RX traffic operates correctly. For example, running
> > iperf3 in reverse mode shows no issues, and frames are received
> > without errors. However, in the forward direction (TX from the CPU
> > port), throughput drops to zero and iperf3 fails.
> >
> > When the MTU of the CPU-facing interface is increased (e.g. ip link
> > set lan0 mtu 1540),
>
> "lan0" isn't a typical name for a CPU-facing interface. Do you mean that
> the primary action is that you increase the MTU of a user port, and the
> FRM_LENGTH of the CPU port is implicitly readjusted by the driver as
> well (to 1540 + ETH_HLEN + A5PSW_EXTRA_MTU_LEN + ETH_FCS_LEN)?
>
> This isn't actually bringing new data, because unless you also increase
> the MTU of the other iperf3 device to 1540, the TCP MSS will still be
> calculated as if the MTU were 1500, and you won't be making use of
> larger packet sizes on the wire. On the contrary, you are introducing
> one extra variable into the equation: with this test you are also
> increasing the stmmac MTU, which you later clarify that by itself it
> doesn't change the outcome.
>
> > TX traffic immediately starts working correctly.
> > Likewise, increasing the FRM_LENGTH on the switch side for the CPU
> > port resolves the problem, which indicates that the frame length
> > configuration on this port is directly involved.
>
> So increasing FRM_LENGTH is the only factor that alters the outcome.
>
> > Given this behaviour, it appears that the management (CPU) port
> > requires additional headroom to successfully transmit frames, even
> > though RX succeeds without it. The STMMAC driver is used as the
> > controller driver for the management port, we are trying to determine
> > whether there is any known interaction, alignment constraint, or
> > undocumented overhead that would explain the need for this extra
> > margin.
> >
> > Could you please advise on how to handle this issue?
>
> Have you verified that the value you need to add to FRM_LENGTH is linear
> for MTU values above 1500? I.e. that at MTU values of 1510, 1520, 1540,
> 2000, ..., you always need to add 40 additional octets to FRM_LENGTH on
> top of the ETH_HLEN + A5PSW_EXTRA_MTU_LEN + ETH_FCS_LEN extra that the
> driver is already adding, and no less?
>
> One other thing to look at is to send known-size Ethernet frames using
> mausezahn or ping over lan0, run ethtool -S on the eth0 stmmac interface
> (this will also capture the switch's CPU port statistics counters) and
> see by how many octets does the aOctetsReceivedOK counter increment for
> a known size packet. Then, if you go oversize, look at the statistics
> counters and see which counter marks the drop. Maybe this will provide
> any clue.
>
So I started off with ping and that worked i.e. without +40 to
FRM_LENGTH. So when I increased the size upto <=3D1440 ping worked OK.
Anything after 1441 ping failed I could see
p03_etherStatsOversizePkts/p03_ifInErrors incrementing.

              MTU Ifconfig
-----------------------------
ETH0 -  1508
LAN0 -  1500
LAN1 -  1500

After increasing the MTU size to 1501 of lan0 propagtes change to eth0
as seen below:
root@rzn2h-evk:~# ip link set lan0 mtu 1501

              MTU Ifconfig
-----------------------------
ETH0 -  1509
LAN0 -  1501
LAN1 -  1500

$ ping -I lan0 192.168.10.30 -c5 -s 1441 # Works
$ ping -I lan0 192.168.10.30 -c5 -s 1442 # Fails and
p03_etherStatsOversizePkts/p03_ifInErrors increments.

So +40 to FRM_LENGTH just made the iperf worked earlier as the length
of iperf packets is 1514.

I'm still looking into the switch on why it could be dropping the frames.

Cheers,
Prabhakar

