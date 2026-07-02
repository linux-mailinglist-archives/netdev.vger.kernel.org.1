Return-Path: <netdev+bounces-304241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SbI1KB6fRmptaQsAu9opvQ
	(envelope-from <netdev+bounces-304241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 19:25:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2B86FB515
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 19:25:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lbDJUUcA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304241-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304241-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9162430315DD
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 17:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036373491D0;
	Thu,  2 Jul 2026 17:25:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF9349AF5
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 17:25:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013102; cv=none; b=OAOEvYy8p8uViqWUE0vUI065XqEGjalRIBtJXtUI6ln45Z9Xu5mXPh7MIzEyZJP4Qu6ap1E1CE54PNUQiDdu1Jb0FMlYDUTqaCqR1SurtT0wRiSn9HHge6FIBjDHq+uzpIp21RlBNlGpCDSXvBq5qSiCO1BuOds7RjrA73dVu2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013102; c=relaxed/simple;
	bh=wYofpd20/2MAY28qjdWeuTMS8chWG/vFjgq7i852FNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxswabM22MqsGEhedzMRUSSDx/daQB6RnqyYwtnAPHA5mYI5pqvwAi1AsB8q7Qpja4EAElp1Y1Qo2PkwzfZK2twQs+ifbQnZLrAQ9YO1xxejAh0TXOoZKmmMdVdlRknDv7Yz6SNYGr9h5kQmaGNDVSlvjRIOVVgwdX2Wz3IjvFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbDJUUcA; arc=none smtp.client-ip=209.85.219.52
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8f18d92172aso28224816d6.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 10:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783013101; x=1783617901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wYofpd20/2MAY28qjdWeuTMS8chWG/vFjgq7i852FNw=;
        b=lbDJUUcASoJwiJutICwz8ij3ML+QnftQqwday3upc1aZ+MkcGlcYXIGkeAr0MvnjYU
         h01qd/slnALp6AAXGlkKcWkM3VVJPhR59Z0+rUrOaS0nLjMF0qI9XgXUJlCASRh4saNJ
         c71RkGiYm6PkutNHLMBGBsy7KwFqMdgLzyw+kPGzP1MOpTPkVkYjv0+t3uf7+THkfUDx
         7HzJ8QLlwISfmMrvjxImj9zTQ01FDsuLPjN8oYhhCBjVxHNL7+mTn0RKEOFq4wYMQL/M
         Wf4SvAsev+9AV4WCSxz6gQNftrQj2jC/9T4/jmftvsvoNpT4cjTDnADzmBjqRS7NRtkE
         LLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783013101; x=1783617901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wYofpd20/2MAY28qjdWeuTMS8chWG/vFjgq7i852FNw=;
        b=DLW6J/3cGPURbQ9tbxMPBmnc1/8mWdSYR9+6dXQ1iebQdh3OcWPQ8S7iJD7GKq5Zeg
         yPWNp8PAhreGu/m685hn6EzHbb8Yabvd7esTwmBk+El/pKiYIw4lh1zVc4xWyR7nxnN3
         E3+7/cw4sevyai+nkOoOVdGQ5fhKTZnxKbBQ0c5QTP++nTRlTeNC3MdBYWpHhfCSTmao
         aOB4R0sy9Q6oyKEiZYslYCUMWY/lz5acDpXXj3QdfxS6Mv511urLFFa3oMZ9XSY9NLbr
         uHsuje4gClF/tr2ZFqXqCDJ8xSO9esTxDGIQEBihDA46e2aIB4I1LME9dejiQuepsp4J
         XE5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+vBjqrdEypL9C50EXkRTxoYWXDAKTAToEbOcMn9K0NktAfxEF2GwHnIS7zzyGHPr/03gZsBT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQAdEnE+GzYj2QcN7d+Fn0d3u9uXXO6z/qmMTrUockl2yWu6we
	qKrqFq1Xl/6vxhi8WTA58roMQn9l1LZdcgNoMjXrhEWjsEg15zAfD2Qk
X-Gm-Gg: AfdE7cn0V8v1RIrbrDonEnZ4SrtPP1s5kmYjHIXvu6gqIYnnzLMtdcbtLGgwD2kIj1I
	24dPCL44yQ8mSPKdGkbraFKv6LtcvMx4VfBBv5V8t1RxCmL7qgbIrOxt47p9XNvBYVl7EQg17fQ
	62Tk5i4sDSzUIr5VXMMdNl8pzP3J7nGZY7ZDWBmDU7v45AtQigGNHs37g9l/BMgIaV3X3Yf55o2
	Im4j+RpMRNssh7NH4bqMbICzw6cJj0cAZbF64aB9ANFT51BBmmgcWuJLgz7syjGmaVE4w7NuOCR
	5sqEOg7+3/Mo7ny+LEHqogRcHgxweD11sRyIpIVdLFXpLybA6lZIAeSkXnfdgZybxw7anycdy+1
	9MhcVj2jQujy8tqC5leVaCHjs++NBpJxnfenDjXzaRU2PisCi4VAZuKhzdbENjKN1RMRi0ocGVX
	0KSm7pNavoBseAiEx5D8AnGlOVR3xilyNmWkewxeTUcvYEXmqjhUTZTg1jFhWkG/HXmmaihr8=
X-Received: by 2002:a05:620a:4555:b0:92e:44be:bbd2 with SMTP id af79cd13be357-92e7afb2399mr780848785a.9.1783013100344;
        Thu, 02 Jul 2026 10:25:00 -0700 (PDT)
Received: from AMD.home.local (dhcp-9-244-8-156.gobrightspeed.net. [9.244.8.156])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e801948a8sm265545285a.35.2026.07.02.10.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 10:24:59 -0700 (PDT)
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
Subject: Re: [PATCH RFC 6/8] clk: sunxi-ng: a733: Add mod clocks support
Date: Thu,  2 Jul 2026 13:24:56 -0400
Message-ID: <20260702172456.848487-1-enzo.adriano.code@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310-a733-clk-v1-6-36b4e9b24457@pigmoral.tech>
References: <20260310-a733-clk-v1-6-36b4e9b24457@pigmoral.tech>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-304241-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:junhui.liu@pigmoral.tech,m:andre.przywara@arm.com,m:bmasney@redhat.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:p.zabel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:richardcochran@gmail.com,m:linux-clk@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-riscv@lists.infradead.org,m:devicetree@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jernejskrabec@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[enzoadrianocode@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[arm.com,redhat.com,baylibre.com,kernel.org,gmail.com,sholland.org,pengutronix.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F2B86FB515

Hi Junhui,

Register check for the mod clocks in this patch against the public A733
User Manual V0.92: 88 of the 94 mod/mux clock entries match the manual's
register offsets, with the documented gating/mux/divider layout at each
offset. The six that have no register in the public manual are the set
already discussed in this thread for provenance notes - avs (0x0880),
spi4 (0x0F28), sgpio (0x1060), lpc (0x1080), gmac1-phy (0x1420) - plus
one more: tcon-lcd2 (0x1510); the manual only documents VO0_TCONLCD0
(0x1500) and VO0_TCONLCD1 (0x1508).

Thanks,
Enzo

