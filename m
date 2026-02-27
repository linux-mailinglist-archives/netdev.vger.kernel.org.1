Return-Path: <netdev+bounces-261754-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sL3CENhOoWkfsAQAu9opvQ
	(envelope-from <netdev+bounces-261754-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:59:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D631B42FD
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65C9C30F3AA7
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 07:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012F636F41A;
	Fri, 27 Feb 2026 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcdcskKe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A5636E48F
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772179074; cv=none; b=bOooH2VyVS1J8dRQtIcAMLkul7vK9SM8V+W3DjKeU4LICAACt10+dyc411CuH3oMTl5ANO/IcNVAyiW4S0YY0DoaNQLWFMeZkW5yoB3drSPWKIjt+X9mX/yEwe59ldwA47zKHmK6Ta/sn58rvtp2v1HsDvWKK4YS2LGXNnaarOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772179074; c=relaxed/simple;
	bh=h/CjFdpAJcVREpfZXVwfif/697poNJIUcK2DAAylgDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9LJKb5Qzw6Vq9FcguQbfhy9ArtG8gtPvBG+TPJoBkdtaO9mrudddxO/5nSH7iusFxErpCe7GWOkbRv2s3+ShoNao1eYXJbbpir2QnACaoHwljMKruKcW9FCt2aGeiWPU9jzxZaROhYqiDPJ45ohpv8Yy0XCDQj2IysZ3lQmcy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcdcskKe; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2aaed195901so8928035ad.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 23:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772179073; x=1772783873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62PbYYmVOOK5poz3ReEQOuGuTu2sU2hARoRYcSfvRXU=;
        b=HcdcskKetfaE05UIk//kOAyO17tV6AuNfISzx6ZK/1qTXz37iET2RpT2eUQOxACqmU
         p553usxi5R8M/VNYan7WIhctHlI0KxJ7/g4HPm9Zt6v2CHry3qpO8zR3YuRi5WmamyYE
         DZkjg99ZIVRCboTol58DnDCnkErDTa4FHFVYmqGC9ob4wN8fMPeS174WeZbI0v7ZFXRM
         erkmXic4N0yZHF+mZbvWwYhzWXkIpCT25JWx4Ud1/FjbX27UhP/3JNiTyFS7b5thsRTt
         +thw9nVgHJA+CR6rECC5InOAKy1MuYaydxN10zoVYhTfDFOQ7RsOoH57orrjDoZls0Gx
         8MWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772179073; x=1772783873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62PbYYmVOOK5poz3ReEQOuGuTu2sU2hARoRYcSfvRXU=;
        b=SDSwwge8y+skFVMRqFWs7MCoqtRYoobUjXEnKf23eLGxMm1cH+XJ0R3Ipm4AVp3awd
         CaULvVBxpUUw73IggRkNmOMWz6NSDlr8kmbU1aOpw0KAZjkQHPMPKjE86dlOasA5QP3W
         7XlzZZHEO3BXagCshS2z3pyv+tzG+1qk6u5RB9zx0F71pgwG/hvn0KQ/2Os1L4blayEH
         +J2NQQZxvH5ALNKEHAyjKhmwZlc1htGfNZ0cSPpQN3fignzMc8GxcVsotA5IWxZu2M/X
         qD9UP8N9K3zohpGAw2cv2Ix3pGxgYrc5vlnU8rkIRMIZeRe8lMbxWVxcnwQq9RYqPSR6
         ky+Q==
X-Gm-Message-State: AOJu0Yxj9vHXkHdvshuzOu1xCjnQqfgkpa6PzYlLQnHEqNUiBEMmpWiW
	L4KFwHDIcGrYCBDP8Ax23BbNTRhnPXcsgpNRkGsfvCJqae7l2zF28GJC
X-Gm-Gg: ATEYQzzRpzddtzI9WoKAVDcisIik3ZHBxl034yYkflFb4tTzrwW+YWSVubA1OSx8HAZ
	S0uaBte+gcOY75Ipgp1AcisAzn0+lAHzR6RwL+Tla9FVMzf4YsIhgA/5jRr5bbSjHccSFRxS5ge
	uDuQJF9qQ0UpFqTWEe3++IjXUpoXZwJ5DvzzAcRFRg184jkusck6/WsRjAq+nst2UU6SMVepq4J
	nrvC1R6EvJBQPm6asNCkOUbOPcf+O+fjqr0gogyuzg6xa3RAGWNxJX+5K39YY29X3YGs9Xl27dC
	OhScJBCXC6bVoOzGaPSYXnCdUl3r0k7oFgzu/uLoSOKsPiT8U2Ttl0ZdTKgP6GNR4WhzJgf9i8Q
	06FiN0n2QMXuCaJkIb9z4KTVOPnJOZDyhP78JZSwC122RQddRQmTg+CHPd4D2P+x52L1vo3pG3o
	rBQzds54oca9YXSp7wiTex5w==
X-Received: by 2002:a17:903:1b6b:b0:2aa:e817:1bd4 with SMTP id d9443c01a7336-2ae2e4b12cfmr20205135ad.37.1772179072569;
        Thu, 26 Feb 2026 23:57:52 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fa43sm47358095ad.46.2026.02.26.23.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 23:57:52 -0800 (PST)
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
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
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
Subject: [PATCH net-next v5 2/3] net: stmmac: platform: Add snps,dwmac-5.40a IP compatible string
Date: Fri, 27 Feb 2026 15:57:16 +0800
Message-ID: <20260227075718.2243818-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227075718.2243818-1-inochiama@gmail.com>
References: <20260227075718.2243818-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261754-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,ziyao.cc,cqsoftware.com.cn,linux.intel.com,bp.renesas.com,eswincomputing.com,altera.com,bootlin.com,cherry.de,st.com,synopsys.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97D631B42FD
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


