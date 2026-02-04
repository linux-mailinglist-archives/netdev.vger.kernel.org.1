Return-Path: <netdev+bounces-256703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMlrOAZHg2nqkgMAu9opvQ
	(envelope-from <netdev+bounces-256703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 14:17:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA40E64EA
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 14:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 131673015CBC
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 13:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C13224AF7;
	Wed,  4 Feb 2026 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MU23SF5T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9E5288B8
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770211038; cv=none; b=IbtN2gNbuqTaJhp9p6SUCibIrXKPSqaJSEsTt/J7u1BA4Xb9texcXUe4ayhMQz6qQc1mk0RA4GgEZLxsjTMARLLJVGC+FSl7xut/foQdjAhr7x9zx7wfVBaPtkvjKgUqeLRUhqCe4wCDztUBXKPaxjebxNuEcfMRmO/LVm2fIKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770211038; c=relaxed/simple;
	bh=4fhGAl1etiRKhkugayByjRtTz7JIa5wVXw0UDNoMW38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efTL8KYOXmqigOHaXYVpe3QeHAZ4SO3WjfnQIizMumf89lWZNG1teegx10kBIOKveADm/vVFnQOerSev9rgiWdXNg0DZQD0BAM5aodChk5niAaCGUYJ2yK+ij1wnxEKn93OjvIHzCFDb8MmXYe6Air/rHri9GemPQED99lZ1zBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MU23SF5T; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-352c414bbbeso474176a91.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 05:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770211037; x=1770815837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fhGAl1etiRKhkugayByjRtTz7JIa5wVXw0UDNoMW38=;
        b=MU23SF5TXAVvaeG0jPS9AomjuYYbtcmSN+NkLQh5ymkdlbzj0tuh48NxLjYPSIg7Nr
         K8r2fVWkAgNQVF1IXo6rfdhv6Tg+T9tnG5H/8Wyb8CjMz8ERlj6fhTmeIpGPWjFuP2ZE
         O/dthkvz07b1Xbvejnpq3iRCP9ntLYNeNqQRSzbrZJ8SzmqctoRTQJXfjPlzc3ifERN5
         uBtZdx7Jn5xEMBizvdBFrnaN2eir362UdM32l6mPxtiWXLJwahG7AuHCtm8uHsMK1pWD
         D6O0rUA2xyh3zRPNNckeiRKm0FqXS+XDECOyZdgqeCLjo54H79DwD3CCUwUZX1ru2GiY
         NYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770211037; x=1770815837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4fhGAl1etiRKhkugayByjRtTz7JIa5wVXw0UDNoMW38=;
        b=s7pnMfOcLpHRjaEKb0rLzT121Dxw0i/KLK1OnQF7hWldx2839XtNKmfIjyWr/hHV1w
         py0iur7hc5tiiVjVcHyfdxULZLi/LtXRGj15c+0AChgNE87u+ymMBmHDkU6YeOgUiUju
         TppMAM+bB2owVmoWwFM/J4dEtf+jebXvCxoN1mfaDcIAVgg5/VtWJ+9MR51S84hRFsGr
         dmAqJ/za0bJUI4o99MN9RxzVsEjUpRMy7rwVDjcX7VYkAd5SY159/VhCLLrAL+k20hm3
         2NdubLLMSwUNHYkPQ9ZiLYS5evVQPHX01Vo/FOsLH0I8Tv3QQ79EpYnHTsNE1sRkn+T3
         Hinw==
X-Forwarded-Encrypted: i=1; AJvYcCUzzbvDY5x/u0FgUoUYxj4To2ltigAKpypGuLpX0O8kip5WaC17i68mywxtE82cYhbhGRN1gYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHdlrPljKhCtYdWGEcvgZlcS4FX2u/bcu9uuGIXASPxnx0qn9D
	SqjYqguClck60T38g52d4TH2DQAQz1IsVaxwKewgN4VxJATawmvzl0Tc
X-Gm-Gg: AZuq6aJP/6koxTFkAsPfC9D6dHvTQf2DHDQC7Xp8cgaOojzZ9rPAH/ItksIV3d7znMd
	oRVNnk4YTWTOT0LGbLPGrUp/+dnB65IMZ8eR+JTVT7pwqFdTdAvYlPXpD4W9lB1mdX0J4oODH4t
	IjyU5PgNvWUFbbNhSWnmbb84odLzV3+osMVTwOF17Vs7rq0NCgaEgnGlrOktvgbW+3nh/SXG+nC
	C+zY7/2171k2PW0DbZ9kjDw+0QUfSWbxcCucp8btTzsYmt8NcfKAC03IUkB+DOwE40KTXbiHxvK
	tSEuCJkn/JdUeMGEV7/ZAaC05ycYlt1g4RO3UwFklgZ8TBVBZsCsgzQv9K4s1FzsxWdVsL2JEyW
	1OIo15298gp3lX/LDYeFtltiQlc6P7wLd29WHHY99pGgZYx/U66biijBL5Nb+pEy9OCiUzEDgGF
	l966FYlQYf8c7AEO39u4N8dDAhjpkwSEU+6FtVhqRqYc2dedkkqB1H93oWIKeJvEuKdXYk8FfIt
	Y50Zqk+eAXWf9X8HOuD3dpWxmYECg==
X-Received: by 2002:a17:90b:254c:b0:34e:6e7d:7e73 with SMTP id 98e67ed59e1d1-354777ef744mr5226490a91.11.1770211037312;
        Wed, 04 Feb 2026 05:17:17 -0800 (PST)
Received: from d.home.mmyangfl.win (tunnel997320-pt.tunnel.tserv3.fmt2.ipv6.he.net. [2001:470:1f04:2c7::2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35485dcb7f4sm2568072a91.8.2026.02.04.05.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 05:17:16 -0800 (PST)
From: yangfl <mmyangfl@gmail.com>
X-Google-Original-From: yangfl <yangfl@users.noreply.github.com>
To: michio.haiyaku@gmail.com
Cc: 20251017060859.326450-4-mmyangfl@gmail.com,
	andrew@lunn.ch,
	conor+dt@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	krzk+dt@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk,
	mmyangfl@gmail.com,
	netdev@vger.kernel.org,
	olteanv@gmail.com,
	pabeni@redhat.com,
	robh@kernel.org
Subject: Re: [PATCH net-next v14 3/4] net: dsa: yt921x: Add support for Motorcomm YT921x
Date: Wed,  4 Feb 2026 21:16:51 +0800
Message-ID: <20260204131707.224142-1-yangfl@users.noreply.github.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <60f98b3a-79de-494a-895f-4d1eb21a405a@gmail.com>
References: <60f98b3a-79de-494a-895f-4d1eb21a405a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,kernel.org,davemloft.net,vger.kernel.org,google.com,armlinux.org.uk,redhat.com];
	TAGGED_FROM(0.00)[bounces-256703-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 5DA40E64EA
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 3:12 PM michio da neko <michio.haiyaku@gmail.com> wrote:
>
> Hi David Yang,
>
> I am testing your YT9215 driver on a CIG device (ODM for a carrier)
> which uses the Qualcomm IPQ5018 SoC paired with the Motorcomm YT9215S
> switch.
>
> The switch itself is detected correctly via MDIO bitbang, but I am
> facing issues with the internal PHYs. They are detected with a specific
> ID |0x01e04281| which falls back to the "Generic PHY" driver, and the
> ports remain in |NO-CARRIER| state even when cables are plugged in. I
> tried the existing Motorcomm PHY driver but it does not seem to cover
> this specific ID.
>
> Here is my setup details:
>
> DTS Configuration: I am using phy-mode = "internal" for the ports. (Full
> DTS available here:
> https://github.com/michioxd/openwrt-wf810df/blob/1b37e3adee7ab6651430511af259687a5a57edc5/target/linux/qualcommax/files/arch/arm64/boot/dts/qcom/ipq5018-ax3000cv2.dts)
>
>
> &mdio_bitbang {
>      /* ... */
>      yt9215: switch@1d {
>          compatible = "motorcomm,yt9215";
>          reg = <29>;
>          /* ... */
>          ethernet-ports {
>              ethernet-port@0 {
>                  reg = <0>;
>                  phy-mode = "internal";
>                  phy-handle = <&sw_phy0>;
>              };
>              /* ... */
>          };
>      };
> };
>
>
> dmesg Output: The chip ID is detected as 0x90020002, but PHYs are generic:
>
>
> [   13.405614] yt921x gpio-1:1d: Motorcomm YT9215S ethernet switch,
> chipid: 0x90020002, chipmode: 0x2 0x0
> [   14.004664] yt921x gpio-1:1d: configuring for fixed/2500base-x link mode
> [   14.018058] yt921x gpio-1:1d: Link is Up - 2.5Gbps/Full - flow
> control off
> [   14.097426] yt921x gpio-1:1d lan1 (uninitialized): PHY [gpio-1:1d:00]
> driver [Generic PHY] (irq=POLL)
> [   14.160182] yt921x gpio-1:1d lan2 (uninitialized): PHY [gpio-1:1d:01]
> driver [Generic PHY] (irq=POLL)
> [   14.226811] yt921x gpio-1:1d lan3 (uninitialized): PHY [gpio-1:1d:02]
> driver [Generic PHY] (irq=POLL)
>
>
> ip link Output:
>
>
> 3: lan: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1508 qdisc fq_codel state
> UP qlen 1000
>      link/ether ... brd ff:ff:ff:ff:ff:ff
> 4: lan1@lan: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
> master br-lan state LOWERLAYERDOWN qlen 1000
>      link/ether ... brd ff:ff:ff:ff:ff:ff
> 5: lan2@lan: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
> master br-lan state LOWERLAYERDOWN qlen 1000
>      link/ether ... brd ff:ff:ff:ff:ff:ff
> 6: lan3@lan: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
> master br-lan state LOWERLAYERDOWN qlen 1000
>      link/ether ... brd ff:ff:ff:ff:ff:ff
>
> Have you encountered this PHY ID (0x01e04281) before? If this ID
> requires a driver patch, do you know if it shares the same register
> layout or behavior with any existing supported YT8xxx PHYs (like YT8511
> or YT8521)? Knowing its closest relative would help me attempt to add
> support for it in drivers/net/phy/motorcomm.c.
>
> Any advice on how to bring up these ports would be appreciated.
>
> Best regards, Michio
>
> --
> michio da neko
> https://michioxd.ch
>

Hi,

Please do not use PATCH thread for technical support, as it CCs to
tons of unrelated people.

If you are looking closer you might find the thread about the chip on
the OpenWRT forum.

As for your question, the internal PHYs are standard and do not need a
separate driver for basic support.

