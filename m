Return-Path: <netdev+bounces-304253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qA7NMOWxRmowbwsAu9opvQ
	(envelope-from <netdev+bounces-304253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:45:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D17A76FC467
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:45:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Boh8qgvP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304253-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304253-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A47643049DC1
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 18:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D5F3A718D;
	Thu,  2 Jul 2026 18:11:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446BA3A6B85
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 18:11:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783015908; cv=none; b=Gqd3vQeF5/OIdK+LcyepbBc6f3kjvBVuB+Yipdot4Rj4cTeVO3cytRe7iEN6vHJedYALOfprWqUYN66ZHQp7Rm4FwVKehWjx9+WLO7ZSCIx5HmFb1ddda0cgf1cANy3AK1J+dqEw7Q+X1Fl+3LCpid3Xq12wrcWugPhAhJ3tVWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783015908; c=relaxed/simple;
	bh=hwCMbQOiZREN6cIUCJHWWmm1HntdXr3h4PlM+Tbadsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2LVJE1N9Jmo/UuEw8a8xWc/mB3MZwhF14FP9FwHmxl2ODoaLnnPdpBgKO8aCpCxDbtUzUatPUIW4lIGB0QiMn+bosbXv1U2oIhCZo0e5mqZqs0n3RB+UVaCQQKmHbLyjTsSKifd1S7rhsYkIvJRA9DJ53wc+80+0CLxYT+mD5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Boh8qgvP; arc=none smtp.client-ip=209.85.222.170
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e5d6f35c1so174260085a.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783015905; x=1783620705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wtCCML4GCtPrAf6qduQMkfSK95cYT1SxvrHR4pZoPOQ=;
        b=Boh8qgvPRVtyxiQWLHjETETL+CqebcD1iN2UmwYm/bWAL6b8ZjW6Jj7Bs8xd5av9ds
         DinP93FoXDvSVJ4SPRPluyqRXt9K5N4EmGJqumF2YQYos2EfW0AlQYTybZD1pygMDvbk
         caK0BjsnDYSUdyss2EybRTxYv5l4JKs3RGZF+w0lMQk4u6Y+p3dw0mYk0NfrP8H6E9V6
         enob59LsJ1UcAH5qi0IMSMnNlUw7Qi/GvgPJE7lnfSrOE6zmeR4it14nZNeY2QjFj0UQ
         ApACkaFh1XmFR8xbIqn4xLKsWb6NL2XVIHpMvpXo4t/bHh0psStB+jTgfAnrvsNcK/dl
         48fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783015905; x=1783620705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wtCCML4GCtPrAf6qduQMkfSK95cYT1SxvrHR4pZoPOQ=;
        b=WrSqEduZ4rJXnTo6L7H+KP0S9/+SYurI6rKMyP3hYSa5atqPsTSypUXjGCLF8H7kz7
         WsYUKH9M0R1mdRysJIV41ltO1wwqjlWInMeQcVh04iFSBIYlm7/gxHDIcm6OWYhuWsBY
         Ab8/oX58pqChwZl7dQ97nWo9nkEy94KGK73P4xIuESqyuqlF/IIq2vi2eOl5pKfyFxBA
         BbCMuSV7NXM3J6slf/DcyFon7FLopy2ya6I0VP3YEv/jCAwJp6MuLzgBGoium/ui6DtD
         tQCFUIz0Ls6BLv/Hb7yMhNM7SZbNuFJ26ze7GCCFOqyuyhCH5gtTUWh/3J8WHDdkvYR+
         X0Ow==
X-Forwarded-Encrypted: i=1; AFNElJ/Gs3SzCcJSqQ/I8pOnDzXhOxa5DsH+/IrVCuPr4ZmFdFfCmTcljW+RoI53UmE83r8clGtOpPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXfua+hHeLj+woYXX1WrqfPbiwUQ8OtvJ4d63C1FARAYDw15o1
	2rWVF8WZPm6frkwA5OivZA7ZJ98Jf6tQoWo8u15E2Supcs8vEX89xpBq
X-Gm-Gg: AfdE7clNHovp1TSl/Gpv0X7k046vd/2TlKtLrIc69az4edD5CcBptUn00rx8iFQzgMq
	y3ac6R3W7e7yKGsLWoQ1g/XlP4grdgjmoKq7IfTA4HyFI8r6Gzcmpjos1Z8U+by+APzI5A07fte
	Idke8Fpb8AFqBZ6isgSRZDiyOFesADjmFqSK2hCIuyIbcB/tixWbZ/Ad6Y8krLe31a+zc3rl/wo
	ToV/ZmjAiwShfmKSEntX1K0NilVcOf+35D4yB5UT7BkfSwZZoIT2z3GyBICgW03R+u3OB1ItBf/
	5GOwNLZL0+3gQQreW8OO9zQP09vN0fDIjPQFFe/vvd7yQd1bdyf9jUiki1oD4cFEeMtHBgPYY5H
	YyDl1PLveLohbkKesIXxHoUD0YFhGOornWPms9d2BvqESlGJ/II1dBP+LIL5YqZ2Nu4FaRJ+8ep
	afZ+l16FUPas6XPf0rcdecrAOi5y4lvIYwbCwJFV1181qMO9/TgSzWqzRrYZRKr5R48eXroRQ=
X-Received: by 2002:a05:620a:3722:b0:92e:4927:1ffa with SMTP id af79cd13be357-92e7825b2d6mr905846685a.24.1783015904823;
        Thu, 02 Jul 2026 11:11:44 -0700 (PDT)
Received: from AMD.home.local (dhcp-9-244-8-156.gobrightspeed.net. [9.244.8.156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e80194291sm274217585a.37.2026.07.02.11.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 11:11:43 -0700 (PDT)
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
Subject: Re: [PATCH RFC 8/8] clk: sunxi-ng: a733: Add reset lines
Date: Thu,  2 Jul 2026 14:11:40 -0400
Message-ID: <20260702181140.883070-1-enzo.adriano.code@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310-a733-clk-v1-8-36b4e9b24457@pigmoral.tech>
References: <20260310-a733-clk-v1-8-36b4e9b24457@pigmoral.tech>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-304253-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:junhui.liu@pigmoral.tech,m:andre.przywara@arm.com,m:bmasney@redhat.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:p.zabel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:richardcochran@gmail.com,m:linux-clk@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-riscv@lists.infradead.org,m:devicetree@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jernejskrabec@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[enzoadrianocode@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[arm.com,redhat.com,baylibre.com,kernel.org,gmail.com,sholland.org,pengutronix.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D17A76FC467

Hi Junhui,

Same exercise for the reset map: I compared all 121 entries' offsets
and bit positions against the public A733 User Manual V0.92. 115 match
the manual exactly (including the multi-bit GMAC0 entry - 0x141C bits
16/17 per section 4.1.6.212 - and RST_BUS_SYSDAP at 0x7ac, which is
what makes the gate offset in patch 7/8 stand out).

The six that have no register in the public manual, in case you want
to add provenance notes near them (as already discussed for other
undocumented IDs in this series):

  - RST_BUS_SPI4       { 0x0F2C, BIT(16) }
  - RST_BUS_SGPIO      { 0x1064, BIT(16) }
  - RST_BUS_LPC        { 0x1084, BIT(16) }
  - RST_BUS_GMAC1      { 0x142C, BIT(16) }  [GMAC1 question]
  - RST_BUS_GMAC1_AXI  { 0x142C, BIT(17) }  [GMAC1 question]
  - RST_BUS_TCON_LCD2  { 0x1514, BIT(16) } - the manual documents only
    VO0_TCONLCD0_BGR (0x1504) and VO0_TCONLCD1_BGR (0x150C); there is
    no TCONLCD2 register set in V0.92

Everything else in the reset map checks out against the manual.

This analysis was done with AI assistance (Claude Code, claude-fable-5)
and each finding was checked against the cited sources.

Thanks,
Enzo

