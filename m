Return-Path: <netdev+bounces-265344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH+cMkYYrmkJ/gEAu9opvQ
	(envelope-from <netdev+bounces-265344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 01:45:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65455232EC5
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 01:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 758F030488E9
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 00:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22982239E7D;
	Mon,  9 Mar 2026 00:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lfy1hPFl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF0A240611
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 00:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773017029; cv=none; b=gWEn/QzAldZTM78x+UIeQSynQ/5rz/WB7oZxzUQ/xgv6B2dsazzV1WRTjUr6R7YeJrOMrfVrNTxTQ2AELGF6AdeppueWx16uD9thTeeUvyzuq5sqcGRo95H0ODh9nUoR9duX5O1wX20WJLgWWH2fbFdEC1xb4FhMjEtfqXabpTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773017029; c=relaxed/simple;
	bh=h/CjFdpAJcVREpfZXVwfif/697poNJIUcK2DAAylgDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtQEF7405tbwJUP9zjiP+2h3/H1MvO4SLQDng+AQgWM3z8ZH2FQzSBujFxTk9wBRAo/kP9LMasVUzRr01SH6vFyQoQJxp5EHYY5fU9PdwKG4/384otiidUZkhalPhNLIxyXYsx0gMC0Kw+r1w+w+7vjLbvyZPc7MZ0SPw5BQBXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lfy1hPFl; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-824c9da9928so6227917b3a.3
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 17:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773017026; x=1773621826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62PbYYmVOOK5poz3ReEQOuGuTu2sU2hARoRYcSfvRXU=;
        b=Lfy1hPFl34AEByys0KaivoNHJCXwiuVW13gkbJ65wKlj/T6t/WS76SSFkIueaobeZl
         XSnNfBXz7uhFoHordDF8R4SHqai8E2hlbr2hOuW64UXfhzfBV7pQDNwj5WTjes9pOzIu
         k+tYIqJ2dybglze74iodVka2NX7bmMeMz/VfPCTIgwZlvdM+UxaV9TyhAs2S819pWyfl
         2FiwdyZsV7zUJNKnN6/gImhF8J2U10dVNYaHz5eHVYqzfN8eO/y2aPrXSVvDe7sKFPlI
         XsqWYwBX4hqq7qgc5lzhHDwEVGZMR24ne9JB0kDGigYUMeRWHhybwbd9TVPh87zhSnhr
         Cg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773017026; x=1773621826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62PbYYmVOOK5poz3ReEQOuGuTu2sU2hARoRYcSfvRXU=;
        b=gwxdJg5MClvC2vq9xWqin1fg8TNSYjbg9DZYUSkri9HsMjxdG5CfzIBNGxgSAguYVD
         FHzCXYeTr1ygbzK9+EVrHd73/ket/+tRBgfVsMhmfdIcdj6NiCQEjtyDJO8GI4odZxbu
         jXJj+Jvy89x8b4QyNE68UA/m6lxfjDGS4jQDCByaU/OeMQ30enZmYSsil+zwsCeZz9fI
         bagdgUXJuxP5UWJ1dM6x0hwQ3HcvZWezpVhG9KM8PILBLDrBRVBFHjRanU8u8fWeVgwS
         AK0x/ciPzyfEjOUOmI6m8NR96zev/QmwN0n4ZiXZbIk4AQU+jyyOhzLffQUZgcnEmx3z
         1kMQ==
X-Gm-Message-State: AOJu0Yy1RgP4enwhLm0QlK2z2YufhXkqgN76TgZGRyM1vqrsNxIJACNm
	ruhH3UDgBnbQXmnWkGberpyogT2IgZZSsaoh3H740C0TR5CUqqAvnfJ4
X-Gm-Gg: ATEYQzwAB0CSM+JGAYXJjHSvMS3mMASZyl37ZfU2wKGo1Iyn64UcWtaoEvkMERu1LSO
	c+ux6O/wD1Tkwd3nquCg9rkbMZVVpzV6rQJ2NKxn1tt/uhcEQVjD1Z73d3Yg3nJ1HRtZJG4mN97
	uNvd3FYqtw6+3XKcIIvQzDHIfDxm64N/Cj37cnddtbumtlPobX0gIuSDofh3zz8kFeY+1GbY4VT
	dBnC0BPZrqnttNvBMr5fe+mswDjqaNzn39GylGFk0nV2GNPXuI7A8YT7SKWrpV0C6Q/gFq63guF
	7yW7Wu1ek8dUHZz9M6Vk9+y7pY8hFduT/kngrjxqEn7M1tipdFoHRNuDk6rpfrBvIsSNrtYFaSB
	o/6NzohrbYX3Dl8/MC3yoTOttzYUBeabntj58br0lfMCV9Xr8UGjBtV0XNlPpDDZrV/brv9F4oC
	OXVKIdwd0mAIh4dhiFPNhQu2I=
X-Received: by 2002:a05:6a00:1954:b0:823:9b7:9c0e with SMTP id d2e1a72fcca58-829a2f348d7mr8883510b3a.34.1773017026266;
        Sun, 08 Mar 2026 17:43:46 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4656f43sm10324424b3a.16.2026.03.08.17.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 17:43:45 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Yao Zi <me@ziyao.cc>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v8 2/3] net: stmmac: platform: Add snps,dwmac-5.40a IP compatible string
Date: Mon,  9 Mar 2026 08:42:43 +0800
Message-ID: <20260309004305.315018-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309004305.315018-1-inochiama@gmail.com>
References: <20260309004305.315018-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 65455232EC5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265344-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,ziyao.cc,cqsoftware.com.cn,nxp.com,bp.renesas.com,eswincomputing.com,bootlin.com,altera.com,cherry.de,st.com,synopsys.com];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gentoo.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add compatible string for 5.40a version that can avoid to define some
platform data in the glue layer.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 5c9fd91a1db9..02303a808fb5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -396,6 +396,7 @@ static const char * const stmmac_gmac4_compats[] = {
 	"snps,dwmac-5.10a",
 	"snps,dwmac-5.20",
 	"snps,dwmac-5.30a",
+	"snps,dwmac-5.40a",
 	NULL
 };
 
-- 
2.53.0


