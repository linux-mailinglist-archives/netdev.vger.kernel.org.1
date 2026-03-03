Return-Path: <netdev+bounces-262971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCgmAa00pmlJMQAAu9opvQ
	(envelope-from <netdev+bounces-262971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:09:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9011E7810
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A7F930CFC3E
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 01:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DB1223DFF;
	Tue,  3 Mar 2026 01:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4YCWT/R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E71E2192FA
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 01:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772500036; cv=none; b=Nz/Wf1q1IVrWkBGsgbBhmHKsB5HmuqhcImS0/YaKesY0uli/lu6uWSxqh0X/OvLNn+aWYrA6AceXhUYIQlZ9dOUo3/fSJToMJf9tuGqekXkMgJTG9WAJXk6JE82RAcDEXZexAO92YUSLtuXyeOpEFcFyl8pwtfgGNxRkLASRbc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772500036; c=relaxed/simple;
	bh=h/CjFdpAJcVREpfZXVwfif/697poNJIUcK2DAAylgDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBJT3MVcX3IrdOMe9mESGtPAy+wykjpSIhMfiRJeL95N6RS5e2iOttKDjwsvzVG39dDK4S+RuQSDfYsFM9wfEeYHlzNOJxEXK05M3zY7kBcImjUMCpqVQo/DHvXLXFpLrO/+3FMZh0gee48FQuC/lm3/o8mBvIOf/sywnwaqiXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4YCWT/R; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-823c56765fdso2472849b3a.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 17:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772500034; x=1773104834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62PbYYmVOOK5poz3ReEQOuGuTu2sU2hARoRYcSfvRXU=;
        b=U4YCWT/Rr1wKvqKs8eKP3kYTmnN5+tiAOHLLVvs4XpX3IwBRTZnup86v2BWP/ByPZV
         xKQCNTyhK/nVUn/Nvncva/nfl5UmrSISnnaHfckv91VwR6ONTfXBG3ZVsXh09n5S36sM
         n/GYDvTevH/+DtCUCh3bN4I05HZ0gbG/2FCAO45dnSi8rrTAjcOQegCTfl7ByOb759fP
         idQGG5zdo82OmubAxZbbKUvDk6SJU4+MhZYOwCXn12bgexwwFXOtFZVcg0TFKKsd+raQ
         9jlF0M8G0RXpiPoFae3zzEJwLSROzI1hPW0FonUNyFi4dGpsnIJb+le06z3AR9PNihJr
         YUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772500034; x=1773104834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62PbYYmVOOK5poz3ReEQOuGuTu2sU2hARoRYcSfvRXU=;
        b=f3tj8TtxEV/k71nFahvoC9JY5p1xx1k1xD87kXmbuTUxqCLBJufS6BsENyfpJYY5Hd
         0q/TzAJiHmuyafCQCP1ldWNkAN6mOc5x2roLCgNvCaE/6SUDX5gvnfHdeDWDE3vfj87/
         1CJWOtgUQvspb962dWAl0I7uCuU/bUkJiJrUmPd61iSnrYPlzx79fPuqockqeHl11Wlm
         QEkokr9G/SQfIEPoJx0+LsLvuDRYds07VE4Z98YWnqbhsc32Sgb1piHdmXcx6gySL450
         50JRouYzWms5/uwph7kCnxViCvcW9jifx5eVqkmwf+SZAL0ORl+kHEtrxnIj2/7FT6wP
         8yAw==
X-Gm-Message-State: AOJu0YzPDC9Mnh2Y0AV+yo2o1y9aOcH5ghlksMvFcL6hZwTswtOtO9nZ
	NUN64pIHnVrovuUkP2Voz5OxcfzaromxqCkY8RHOs/F3Ec3jWnXAK+GX
X-Gm-Gg: ATEYQzx/wwyg+ZlUjSI54ltvKsTImjbuudO26Nki+NLanVtdATutUNyDsk0dFZor3Qk
	BaSIXCd7M5eAqlpo0hYcR6wSFVbCwASbS8Ixbn4ZEkoXi4dRM1DOAGAynB1spSMCk1dTdvU+s3N
	7wqPX4lgyyz5uSZgryhT0aFRtjtGuGHzyiuO44eAPxVnuzpiYbxUQNHwwRRYfBKPvb6CsWA2Rz+
	PMkxu3XtPH/k659BTL3rCSTVv+0GXdUVwwkrcT+fzwg//L/5f/R3EG5OxSBNW5QxF1hoT6aPgcK
	YFMC2DcxXnPDDbDb6uTjyLwHYhR/fB0GTBbbFsR08CFWvL9iFO0C6XqDInJ7rwnX+eZ4v8DbsHc
	4/5Wxfadwz40fSdf2/Dqu1FThLDhBIriCM6I1erPNqufTdCUUwKKQDQe1NWE3iIgs/FFzrQrGPM
	5qpazoNQn4AD0vhe8v2UYeWg==
X-Received: by 2002:a05:6a21:170b:b0:35f:b243:46cb with SMTP id adf61e73a8af0-395c3a1a5f3mr14011142637.12.1772500034381;
        Mon, 02 Mar 2026 17:07:14 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5ef857sm12435059a12.7.2026.03.02.17.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 17:07:14 -0800 (PST)
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
	Inochi Amaoto <inochiama@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
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
Subject: [PATCH net-next v6 2/3] net: stmmac: platform: Add snps,dwmac-5.40a IP compatible string
Date: Tue,  3 Mar 2026 09:06:28 +0800
Message-ID: <20260303010630.567674-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303010630.567674-1-inochiama@gmail.com>
References: <20260303010630.567674-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7A9011E7810
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262971-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,ziyao.cc,cqsoftware.com.cn,bp.renesas.com,eswincomputing.com,altera.com,bootlin.com,cherry.de,st.com,synopsys.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gentoo.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	NEURAL_HAM(-0.00)[-1.000];
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


