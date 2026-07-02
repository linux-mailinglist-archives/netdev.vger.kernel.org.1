Return-Path: <netdev+bounces-304234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k2HwBx2nRmotbAsAu9opvQ
	(envelope-from <netdev+bounces-304234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 19:59:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F09B6FBC3F
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 19:59:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KkknvCCW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304234-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304234-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09DEF3346F7C
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 17:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91140310779;
	Thu,  2 Jul 2026 17:00:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F74F2FC893
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 17:00:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011627; cv=none; b=TJQK5joNwrg/FJkfflbuhumpx1JfKcAmXb1Ux63EEX2fzdMWucpfa+ATOWMUq6Kzyxyfq0S5UVqX3xUpo0cdpAPLnKJsCWvR8eV07touw1V8LcwxycNaJmGWVejdAS6lVjuOmDr0ypLREtLX5TnlUOlZSyIzHMxeJwZqdpcXGD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011627; c=relaxed/simple;
	bh=yrCrvjHFqhQoi7ugBP7i0ix99Rxl2YLAyjImpsg79vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRN4OuaHvunU3fvcgf5vHdCkiHKlePuSZAP7Ic50cZDkz2NqUIVWk6JLuGclMzzzuIIJ5v18PlyYNJukcGwBpI8hlw10Sv6Bc+UDfHRWOKzcS7fcpseDTUYgbS3HZEM31KgbJq3nCNkrRDrxq2IfNRGtv4n52oWFSuIMoZtnWT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkknvCCW; arc=none smtp.client-ip=209.85.219.48
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8f2509d6becso20341856d6.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 10:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783011625; x=1783616425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrCrvjHFqhQoi7ugBP7i0ix99Rxl2YLAyjImpsg79vM=;
        b=KkknvCCW6rKmRQLC5ssCGlUsqXz2EqzCfFAk9FAavRI4ejk7D/gc/ET86SdxBR4wti
         hmRfG97JDRKow/DtNWDdSiGLpL3OLEfbvbDUY0Gy1TBptViH54QxIwH74K8dtYo8AL5N
         X6U2RWI3/hLSQixrSoyOT7RMq/buOFfeWsfpKMyNG4FfP3VGQpN4Ra/s2vRIjuUyeVkF
         F+TZZkcRU1O+CcINtAn9QiKP5Q9paHaJ3+IgCtBJ/s3EQSfSdA4j29qMJRbc2EvGSqBX
         lEYLDwJyqsFwS760yU7BR5kxiv/udQOXZWUVMJ/K/VtgvFWLQUp9rU2lmIE0FJ/KLuao
         4GdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783011625; x=1783616425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yrCrvjHFqhQoi7ugBP7i0ix99Rxl2YLAyjImpsg79vM=;
        b=P2MLQtf83yzE3/EV6auayA47NAnbI/m/oXjITL73lR8f4wJIQAnMDHVs4E6xPcwejp
         2rXnwCMwhAPu/l7sGU29omq6lH4bqjuqdaQFc93+8pHKqwFMexcU3kMLNe3rx/E6LUfy
         nzLoHHCGPf4uYNkLjmt7RJldbWa40KWQPEvt31h4pQMoiwGdZhoPyg57qZW3/QBLqhtV
         AMcWMcjJznxDsl8FEwCW8ykCpXlk/VmPCw4gAVHD8mzHIq53B8MAZ7aVMCP7XUs7P6j9
         tQhxFD1vlA+Z7y8t/ZCdPY+psKjvsMx5SDT9WMOqasMn52cmOzipazxKr8gXWbKE9reQ
         5SaQ==
X-Forwarded-Encrypted: i=1; AHgh+Roj7geEJmbqBqnqNfhdFjMCUKjU0DU1mxdspi9Qot2qZ+KSWkVVaxAxxFynfGaEqH0W0Q3DiFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEsWt9bhHReelNB1mgXSLM8hdW47qyuN/aN+pU4xeNILPZNf1F
	MXZ55AZ1fiifgQ2vx0wbfU4B/+slGX+bF4UMCFcYd/2t+3BwlCdeNoJe
X-Gm-Gg: AfdE7clhzbWQG39e9E3rBJvBJjMncAY78jPQUB0YFzrtlHNbebMqQrdx4EdKOfztmiX
	LWWiNkOG2AqdKNs2kVa+w5yf2M13F98VrHd3cH1oPpH5RqEpsh/EP/CUGAB/xh7LFjbu44yvodD
	d00zR/QKppy4DiPkP61PbhkLGzGOHvFQHaWoEvmbIkISNqnR+ThWuVIvEXC2niU6Y4qOPA1ep98
	aKOmLghtca1iqysExprNLtdc41FZcM4i4tz4Yg2jJRNV8Hu0Y3QfSGidTtDn+LTeV583i2lww8o
	sG7+lY3DCBIsXiwx1L86OAO2UWnMuVT4K13t4n7xceOl15KJfb+a4wsqhkqtFrQgdTMVCWdwstT
	mMZmqcQjd0YYwK6BFoEHWEHrEVWxP0e7fI9qVY0lnTyGAlMNktot8a8mucoUrZ17vU5q28BfLpb
	QJwkKvkqoTwp0Wm42a5WWpN+qB4359jlac0VHUssynEiWEK3pG8l7MgME6+A5P
X-Received: by 2002:a05:6214:2d46:b0:8f2:8b5e:3b98 with SMTP id 6a1803df08f44-8f3c63d68e9mr104833466d6.9.1783011625104;
        Thu, 02 Jul 2026 10:00:25 -0700 (PDT)
Received: from AMD.home.local (dhcp-9-244-8-156.gobrightspeed.net. [9.244.8.156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46f30b94fsm30106746d6.21.2026.07.02.10.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 10:00:24 -0700 (PDT)
From: Enzo Adriano <enzo.adriano.code@gmail.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Andre Przywara <andre.przywara@arm.com>,
	Brian Masney <bmasney@redhat.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/8] clk: sunxi-ng: a733: Add PRCM CCU
Date: Thu,  2 Jul 2026 12:59:44 -0400
Message-ID: <20260702165944.828550-1-enzo.adriano.code@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310-a733-clk-v1-3-36b4e9b24457@pigmoral.tech>
References: <20260310-a733-clk-v1-3-36b4e9b24457@pigmoral.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-304234-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:junhui.liu@pigmoral.tech,m:andre.przywara@arm.com,m:bmasney@redhat.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:p.zabel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:richardcochran@gmail.com,m:linux-clk@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-riscv@lists.infradead.org,m:devicetree@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jernejskrabec@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[enzoadrianocode@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[arm.com,redhat.com,baylibre.com,kernel.org,gmail.com,sholland.org,pengutronix.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enzoadrianocode@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F09B6FBC3F

Hi Junhui,

Register check for the PRCM driver against the public A733 User Manual
V0.92, chapter 4.2.5: all 41 entries I could extract (13 reset-map
entries, 18 bus gates, 10 mod/mux clocks) match the manual's register
offsets and bit positions. No discrepancies found in this patch.

For what it's worth, we have also exercised the R-domain at runtime on a
Radxa Cubie A7S (r-ahb/r-apb0 rates with live consumers on r-pinctrl,
r-rtc and the PPU, bus-r-cpucfg via its critical flag), with no
misbehavior attributable to the PRCM model.

Thanks,
Enzo

