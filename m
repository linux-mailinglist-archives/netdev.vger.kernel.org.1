Return-Path: <netdev+bounces-240870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D55C7BA33
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 21:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845D33A6622
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 20:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C7F2D77EA;
	Fri, 21 Nov 2025 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUfXbT86"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4820C463
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763756973; cv=none; b=Jx7ZPGEm8e+mMdJes+dqJeTfV+rGzh4IAoABUyXnV8EnPXIXqk94jpxpqtBpW7G4cUW9NNZFDRjAV4k9TV79Al6oahd/Q2yniFWV+SqiNYx6C32ZFzQErU/mwNj3zJf1zWRUAqiKoxS3wKt7aFHX/FtTeNs/pST776TPi1XJapE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763756973; c=relaxed/simple;
	bh=4oxkpLEiS7UtRUU0+veSAyahST6PE2C0JQtZa1PvacY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFo1ojRykHAT12/AEzjdH1BSh1u4UpEAcgohaPbk2kGLPEFH9Y86Xzy+JGvlMmcQnqDHMWdNR1ietFyr5VEFhL0Uq8Soa+O81wbd2Q9K/tTwAoSbnUPT8JMC+XyeUHjcSj7+5IDhJ4hvbN+XF0LQTJo4SfITvdFYpbw+2eu4C+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUfXbT86; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so9973475e9.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 12:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763756970; x=1764361770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4oxkpLEiS7UtRUU0+veSAyahST6PE2C0JQtZa1PvacY=;
        b=SUfXbT86diDoKrScagSA3S89haGS7XEkX4wjIOeMOLfp9w5z0xG1TmzfBZvZUtiYKt
         SQazYvn1C0+CVOsuYlIQgSmLMEmPKJnSMp3aZDCEJVWAjPmyqG6R38WyAaJwFegVy8HK
         2cNQKdb5lcB6rYlo8vdaKqGHFgQP8LuKu3JJguVPRduwURwZA4ddj1WT8P9nnVmjPU+v
         c7QgZ/O/oAClO70jsqhOqrVaQm+1h+UtslAE7XTYl202oiBM2V8GkEvH2ylErphnMhSV
         OND494bix3lCxpWVW94jMSOwlo4hSjVNNK+QKpGO6vcZ//XnDF8CwRT1wEvuuLDm3qM0
         NCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763756970; x=1764361770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4oxkpLEiS7UtRUU0+veSAyahST6PE2C0JQtZa1PvacY=;
        b=Z3jQ8dFKjVF2zCNGSueGP0GbCg/rSqZsHJAl/QyVF3t/wqMa7G/coJ4oChM+NUZ0d1
         ueuFTHNTtIHLqUgn4g0+QxIHJqVVf8ox8mp5VZlRZ7X7GWvedAkyAkMyQYRynIBqTF3R
         3n+ZuWulz1m79G4dblVU8WqZefQusEAZVVm489EStWAnsq9WnmVrLTd5BAHHFhKjpzG5
         xbqf8dPd37/qjNX1FA2ldCTgekpo+0MWBhI18/EUkajqYPB+QlAc2uT78WvfjgBizmsr
         zjngPY/6pk9Kd1vexmiqpv4KdGPEMbHpXEXA4PiBALouvN3/AykWQzZhawiwwkRp5AbB
         8/mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxNX/AIa7fb93xTC4bhU+fMvm5vBWJK30qX2lAaqgzWdL7sj3KxNwwEDdSOapeoqD1Oj/gFXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3FTC/Wl6bOXEAlkrH6DYbYx0Pya9T8dddLGaZGk57Ynnhj+4x
	nOdevbZWupd5VLObbdvH5YnQN5/enP7u1rDxpsBySrltjs4xRGNgl1yYPzOvBrKH2r5b6mvg/v4
	SIwXfhdnzQTaX9LPjDvo28np3S8LmaYU=
X-Gm-Gg: ASbGncvLJj4h9mFNLUXVH22XcNOxE0YCql0KzgBuQEKXUDYofL5/OEQtPZBGNddLd//
	7PDS2J27APudhoYgAWn+aFXcBwGghW3KfiJwaF4WdUCD4RgXW2OB5rmqp52ZEVHDCd72+l0l1rE
	/PQnwmO45TI65BvHYwa8M7L+ZP3DP4gXNKWDnjUHiTTjr2F4E1m2tkxywLShKZfCmG0KT5y8a4r
	d4Z5PEv5gF6VyM6h+9RvdQzp7GXW4BFUFe3cWucomFv+w+CtRxyETjhQeH/CcC/HIqcVtfb5PxY
	LW5QcCB6MD3J/sclnvVTsap01LaC
X-Google-Smtp-Source: AGHT+IHyvjNt8B3ynrnNwAiEOgrIi62AIMxnBRQlky33w34DFkYNsPDJlZ+4lJ4YY4s3VHixuIlWpE9FIoPAZcJepxA=
X-Received: by 2002:a05:6000:1863:b0:42b:394a:9e3 with SMTP id
 ffacd0b85a97d-42cc1d27ba7mr4099815f8f.38.1763756970315; Fri, 21 Nov 2025
 12:29:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251121113553.2955854-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251121192700.3eg5h2eqk7bruxeu@skbuf>
In-Reply-To: <20251121192700.3eg5h2eqk7bruxeu@skbuf>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 21 Nov 2025 20:29:04 +0000
X-Gm-Features: AWmQ_bl45ujDYyvgUUZGB1F2GXAKqlzyxY_VtarQkEd0nhJHgn9X11VcJTtqKKE
Message-ID: <CA+V-a8vyjt43TPUmu+1TFHFvQsBwYTzKFSQOQm=O3R0dpZWG_w@mail.gmail.com>
Subject: Re: [PATCH net-next 02/11] net: dsa: tag_rzn1_a5psw: Add RZ/T2H ETHSW
 tag protocol and register ethsw tag driver
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

Thank you for the review.

On Fri, Nov 21, 2025 at 7:27=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Fri, Nov 21, 2025 at 11:35:28AM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add an explicit tag protocol for the RZ/T2H ETHSW and register a separa=
te
> > ethsw tag driver so the existing A5PSW tag implementation can be reused
> > for RZ/T2H without code duplication.
> >
> > The ETHSW IP on RZ/T2H shares substantial commonality with the A5PSW IP=
 on
> > RZ/N1, and the current tag driver does not touch the register fields th=
at
> > differ between the two blocks.
>
> Tagging protocol drivers are specifically written to not deal with
> register fields. I would like a clarification that this is a phrasing
> mistake and you mean the packet header fields that differ between the
> ETHSW and the A5PSW tag format.
>
Unlike the other drivers, tagging drivers don't have compatible
strings to match against. For the ETHSW IP, the current driver is
reused as-is. My intention with the comment was simply to point out
that, if an issue ever arises that requires us to split the paths, we
can future-proof things by using DSA_TAG_PROTO_* identifiers.

Cheers,
Prabhakar

