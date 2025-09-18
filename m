Return-Path: <netdev+bounces-224297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9058CB83935
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4969C4A2CF5
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 08:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D738B2F39C1;
	Thu, 18 Sep 2025 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ch3pWP6i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587281A9FB8
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184953; cv=none; b=E3vkLu38+1QycZh4ee9mwpecNzqOXlW/4ia2uxD/ZgIa+ptZ0PTcJ2iUQnqAxjDOq303GNY04Rubj8ve2P2K5Ss2SCdaF/A3OZUUSCT2omZS2NcrlJQKVXpIXRmQS/U2VRk42553cBLBaSQRPKNv2uD9yJ84v92LPYZaWsEMtTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184953; c=relaxed/simple;
	bh=+apsQO6QEjdzapAHpxbdsNcSCb9gL0RNQ2fDJKQk9oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9RAYbdoN2pjP77hQZSuEnxJVVWHXKf0R7Dq6g40+xU7I3/44W4VHRCYeVjia89lkrBgbjZm5lra7QA3sICqwhr9+pEISs8ycx1AFili3ZIe4DHUfRivUUO2BGb2SV8XZk2QDCneFL2Zl2RVio/OaWvSwpk7WIZ9AkyuTZ72leo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ch3pWP6i; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-329b760080fso540220a91.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 01:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758184952; x=1758789752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dgpJuE6FSpEricZhRzRNffSw0PwjJk1HPEn6KVtJT7M=;
        b=Ch3pWP6iv2HFT3p9w2dd+qVofCYfmWgR3beGFKICOr117JdMgXwQHeEkTOExTxiGj3
         bmbIjZAMh0ajITnZ8DQV4kXGgzmfOd7sqTuAh2wXtRRD79JaoU8M2bj+EgZJpwywzcUz
         B08IUCE/HLR+4U0LmF4dceSsAXHHa0anuuGQ7foufTnAb1bZ7TTL6cPbYdrkLe1UzI34
         bHpgvXWrZgDlf4D1ZkRaIHjTZHrpJo6QysO4cKi5wA0cJoiqYTBYoNBM3h0cCO0mu4wS
         yzFP12OuDzwtDVYw8xvrbuosCeTNbHpnQbrN3R2+5lFM0YddWeAakDXeIhPTrNeHqzV8
         FTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758184952; x=1758789752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgpJuE6FSpEricZhRzRNffSw0PwjJk1HPEn6KVtJT7M=;
        b=wXw+qiBTA2ZE+T4QA/09774UmHlsM9v7YWNIynl3VttCarmh6GaTnlWH5tjVSbYiUv
         dxV03CgCrhhyGq9t/e2+tcCrqW4pRyxGGewFzachUusRnXAKfN6a5qi21eL7kBvsg7gs
         X7auvHz4eQfXqowVnFY+sAV9AExP/XaS09OyVSKjJrZYqXQdGkRiTZE9DN1Ah9InQWqZ
         bUvGyL7//qaxgn39cc54dJA+57rK67UeZm9jZ1cz5mN9wiYm0wPPCl5i2c5TKpDOW1vx
         naNCneelTHC2gezYRpMOQBR6eYTMrK1qfxd4VTEyxg0xEajraVqu7bboN6V7Baeq/KqV
         1ZQg==
X-Forwarded-Encrypted: i=1; AJvYcCVuWnKVBxsLU4581MEi3k+DLfO0mT3XCD5vdXurk/6BGRogCXj0IMsPTdIPoSoS3bhsUI88MDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt64VdJnvYJbBNnPI2Wan/HybsoLHwOeXgI8YVrJppjtVbWjCs
	KNs95nN9wU9Eke6AtuP6K+UM0qe6UqnCqa82LZPp9ifeSOgzMfInmKgWXmfgMg==
X-Gm-Gg: ASbGncu7THUQxMvpH0QTbJUO0c30y02xud5Qi20PNjLf9XnSsG+yw0tycABcZysKLVx
	Z4KEDVCzXBEdQ6/FhjGrU5C0OO+lNVr+Z11C+dWxxv9Q4JpJabE87v1o7LATmAJO7q1mq/3813k
	ahgv1r1MKqUJfL1FVEe98SI6fxlYFILO3MbTBaY9q8lYD4LtoJ2w+qyIJULDbF1auL3faYDWSkS
	p0i/NxDvxK7eth9iI11ZLVCE1rb47cLwvozO2ytKODhjvwuPDNRQKjsmIxo6zHSL1zPJcbKZFQt
	qorOy+Wr5u8QOTSDH4+rgrobKbzvvnmI9uglLOEFjCTBu58lK8CdC9MNE+zC79Pl4uCed319K9y
	+yndthK8AZM6eYpGsTo+cVUxMuSK4MKcZUfaKazJwNqwxHLHOjCg=
X-Google-Smtp-Source: AGHT+IF4rdzSBg32vZ0gOZ5A2EXINLPGUFMHUK7MiBcB7eEAbMtGfUaW+xnMSNLr9IaJ4SNTLIzT0g==
X-Received: by 2002:a17:90b:35c6:b0:32b:d8af:b636 with SMTP id 98e67ed59e1d1-32ee3f619c7mr7502380a91.19.1758184951396;
        Thu, 18 Sep 2025 01:42:31 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cff229940sm1655100b3a.99.2025.09.18.01.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:42:30 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 0F8AF4207D19; Thu, 18 Sep 2025 15:42:27 +0700 (WIB)
Date: Thu, 18 Sep 2025 15:42:27 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Divya.Koppera@microchip.com, Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v5 1/1] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <aMvF8yNJbPSqqypY@archie.me>
References: <20250918051538.3651265-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oV2pbrsk+dCJ8esC"
Content-Disposition: inline
In-Reply-To: <20250918051538.3651265-1-o.rempel@pengutronix.de>


--oV2pbrsk+dCJ8esC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 07:15:38AM +0200, Oleksij Rempel wrote:
> +* **How it works**: To inhibit incoming data, a receiving device can for=
ce a
> +    collision on the line. When the sending station detects this collisi=
on, it
> +    terminates its transmission, sends a "jam" signal, and then executes=
 the
> +    "Collision backoff and retransmission" procedure as defined in IEEE =
802.3,
> +    Section 4.2.3.2.5. This algorithm makes the sender wait for a random
> +    period before attempting to retransmit. By repeatedly forcing collis=
ions,
> +    the receiver can effectively throttle the sender's transmission rate.

Please align the bullet list text. I see hanging indent instead there in
htmldocs output.

> +* **What it is**: A standard Ethernet frame with a globally reserved
> +    destination MAC address (``01-80-C2-00-00-01``). This address is in =
a range
> +    that standard IEEE 802.1D-compliant bridges do not forward. However,=
 some
> +    unmanaged or misconfigured bridges have been reported to forward the=
se
> +    frames, which can disrupt flow control across a network.
> +
> +* **How it works**: The frame contains a MAC Control opcode for PAUSE
> +    (``0x0001``) and a ``pause_time`` value, telling the sender how long=
 to
> +    wait before sending more data frames. This time is specified in unit=
s of
> +    "pause quantum", where one quantum is the time it takes to transmit =
512 bits.
> +    For example, one pause quantum is 51.2 microseconds on a 10 Mbit/s l=
ink,
> +    and 512 nanoseconds on a 1 Gbit/s link. A ``pause_time`` of zero ind=
icates
> +    that the transmitter can resume transmission, even if a previous non=
-zero
> +    pause time has not yet elapsed.

Same here.

> +* **What it is**: PFC allows a receiver to pause traffic for one or more=
 of the
> +    8 standard priority levels without stopping traffic for other priori=
ties.
> +    This is critical in data center environments for protocols that cann=
ot
> +    tolerate packet loss due to congestion (e.g., Fibre Channel over Eth=
ernet
> +    or RoCE).
> +
> +* **How it works**: PFC uses a specific PAUSE frame format. It shares th=
e same
> +    globally reserved destination MAC address (``01-80-C2-00-00-01``) as=
 legacy
> +    PAUSE frames but uses a unique opcode (``0x0101``). The frame payload
> +    contains two key fields:
> +
> +    - **``priority_enable_vector``**: An 8-bit mask where each bit corre=
sponds to
> +      one of the 8 priorities. If a bit is set to 1, it means the pause =
time
> +      for that priority is active.
> +    - **``time_vector``**: A list of eight 2-octet fields, one for each =
priority.
> +      Each field specifies the ``pause_time`` for its corresponding prio=
rity,
> +      measured in units of ``pause_quanta`` (the time to transmit 512 bi=
ts).

Ditto.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--oV2pbrsk+dCJ8esC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMvF7gAKCRD2uYlJVVFO
o79lAQDH8IV49DcW+hwiMg+vNiZyA5vrPzmGSVHqpDc1ILyIHgD9Eh67ub4hbJGg
Spts2kxJlXc/zM5nT0aVpERot9Sgjw0=
=ajh1
-----END PGP SIGNATURE-----

--oV2pbrsk+dCJ8esC--

