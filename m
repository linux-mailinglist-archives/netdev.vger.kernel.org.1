Return-Path: <netdev+bounces-254251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMVTIBEJemkK2AEAu9opvQ
	(envelope-from <netdev+bounces-254251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:03:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5150FA1C39
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84D7A30740C4
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 12:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9235B353EED;
	Wed, 28 Jan 2026 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5hIsRVY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D502E352927
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605145; cv=none; b=bUSJLfjORLQcJgOCQsivmXhL+pTI/9EaeMZEVJAQm4xPIgfqDzL4QPTn+6t0TbPXVbfka6GHqwGb7QSOeDM1IDBFEdoIZ79h5ghMySe3MRKZQ4xYHBTROI5lrQhmNVsILH4Rjgc7XDNvptUnLGQ0k3sFLlQ0TYDYjjRpR1h5KCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605145; c=relaxed/simple;
	bh=mPHNzkdxhQ0WZ5DkwNm0IQdgUJMl+Fmoru7kIZpRwNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kli+cVyDOQNkHSg+T6OPgVC98ROBmJSkrxNoS2pplFygrXgcG8oSTKEYw/Y5vlF61cpCQHa+anAC6/OU7HXAqjfKLEC6GBu1UEVUig5qsg+YRoFaU3KYzzHXunWYiwJufk4OaqhCHvahAUfyGudjopBaWI/lOO5aeEXyJ5c5LYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5hIsRVY; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8707005183so1038254166b.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 04:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769605140; x=1770209940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XThvwv1ifJ0OiZooeSbPvbfs+lFNOOjD5GuZJh0mNdM=;
        b=Q5hIsRVYfsbZoJ01FRZ8o4bE097UIsi8llSjTXyEkk8VYtSHgEwAJR9aGwN2QmlctS
         eNTIh9+aySbCfWOC3kg2C7bfl1McgX7+YHgSPWaKdj747oZ7Zv1U8lQZFfTbO/rG/H5q
         reSCj5Jb6ZO2VW9NYhnUl/9lRdRtt9zOHJdDiK5kP8U1qcrfK5iT1Cgr34N5YtayIMua
         T+uY728PfFShuq37neWL/Mr5x/KAHny6vRalxBLDqtWOhbaI+wXyVoFWK8UmevIRKm/l
         1NB+/55Jen9QeXyJZDZeaQc2iKipWW7/gh649LUBUGrMzS3KCYex9+D5fDNcYvTT0pQy
         fbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769605140; x=1770209940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XThvwv1ifJ0OiZooeSbPvbfs+lFNOOjD5GuZJh0mNdM=;
        b=FtDz1nV62eUgZeM8wwbocLoDsn/ydklnVQStvJ8m5684pYbiADtyUeoHTBBST61GqQ
         T07iZ4a9glYEsUyuQwsaUMm+nbqDqQVBkqSSsma67npA5F6P0HSaFTQASjDc0oGlrs6K
         Rfb3LYecMEIuymuHcOnXFeFt/2SgdAFkgUfdpVpzCKtN9l+wlyJ8yHsLZ8Y3Ar6E9pez
         e12kJKOW1MvSF5tDcyCbYZOjRv1RnW7c2XNK0ZjAOSmpDEM+N5kajqCh2LT9tLgQDVuY
         1q+NVhpTetwENdvqRxpkII/kXw7InHGAjDuDCIomF+7SIxAgToIFzKsrxjsJrqavuUPs
         i1jA==
X-Forwarded-Encrypted: i=1; AJvYcCV5zvtqAqAwZAVYCsCwDNh4bugYSDslFn4I9Y25bowUXMULMJiIz8MF66MlAbcMKKvsgwUI7bA=@vger.kernel.org
X-Gm-Message-State: AOJu0YybyR2SHa8SLScMccf5vG9dcCtgNvFHdEME/wQYXncp0kE1J1q/
	mmhzEEikqgkSg7VlKDsOVCHZcVOpxqUoflnFl9zMeyBmzc7+LbEIqSJo
X-Gm-Gg: AZuq6aKPz565EreGLpdXZDcP1uO8kLPq+BDuSrtfIsqbwV/DIMyylVZbVTSp6Lo/PMY
	NmJAUXL8R97524Ncw/XkOVItK8n2hL/Moo83US8Ghbsr64I4sbc5d3DGiQ6YmE25dKZp9w+3uhO
	a3I48gz7/bZnCkJ9qMXtV02IRSWlspvIQFnZaaVXL7uGzQaQNo5Smlhst5E/vJVqgSxPXl+X21X
	p6PBd13+3c9qJ9AMNVIWTVFNeceXACGW8+/zvyPxDpwlQ254HCjHfprlRmZOs6ln4yrEmShaJms
	HEGdkzOZZp9Ubb36eoNBfO9OmaKyrnh/0+wQDeFGMl5Zz6CPF+dRBWaaKGDnELN//RmsXIgLYcC
	9jgvuFC3cVeqjNp95AieKd6IJ3PbTxcZ73OHDMsMoj9NjtcbmeokVLkRruiTQ8NByiI+bE6cKlc
	NlWz7Df3FNZbRriI14pvEGAiV5rE7JXjBnTgk=
X-Received: by 2002:a17:907:3f93:b0:b7c:f5b6:bb52 with SMTP id a640c23a62f3a-b8dab4455ddmr378624766b.43.1769605140120;
        Wed, 28 Jan 2026 04:59:00 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e29d:6e0e:72c1:d15d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2f3e26sm123344966b.67.2026.01.28.04.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 04:58:59 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH net-next 8/8] arm64: dts: renesas: rzg3l-smarc-som: Enable eth0 (GBETH) interface
Date: Wed, 28 Jan 2026 12:58:45 +0000
Message-ID: <20260128125850.425264-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128125850.425264-1-biju.das.jz@bp.renesas.com>
References: <20260128125850.425264-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254251-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[glider.be,gmail.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,renesas,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.7:email,renesas.com:email,2.220.108.0:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bp.renesas.com:mid]
X-Rspamd-Queue-Id: 5150FA1C39
X-Rspamd-Action: no action

From: Biju Das <biju.das.jz@bp.renesas.com>

Enable the Gigabit Ethernet Interfaces (GBETH) populated on the RZ/G3L
SMARC EVK. The eth1, pincontrol definitions and hotplug support will be
added later.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
index 7c21afaee9bc..f52af01a7eff 100644
--- a/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
@@ -8,6 +8,10 @@
 / {
 	compatible = "renesas,rzg3l-smarcm", "renesas,r9a08g046l48", "renesas,r9a08g046";
 
+	aliases {
+		ethernet0 = &eth0;
+	};
+
 	memory@48000000 {
 		device_type = "memory";
 		/* First 128MB is reserved for secure area. */
@@ -15,6 +19,37 @@ memory@48000000 {
 	};
 };
 
+&eth0 {
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+
+	status = "okay";
+};
+
+&eth0_rxc_rx_clk {
+	clock-frequency = <125000000>;
+};
+
 &extal_clk {
 	clock-frequency = <24000000>;
 };
+
+&mdio0 {
+	phy0: ethernet-phy@7 {
+		compatible = "ethernet-phy-id0022.1640",
+			     "ethernet-phy-ieee802.3-c22";
+		reg = <7>;
+		rxc-skew-psec = <1400>;
+		txc-skew-psec = <1400>;
+		rxdv-skew-psec = <0>;
+		txdv-skew-psec = <0>;
+		rxd0-skew-psec = <0>;
+		rxd1-skew-psec = <0>;
+		rxd2-skew-psec = <0>;
+		rxd3-skew-psec = <0>;
+		txd0-skew-psec = <0>;
+		txd1-skew-psec = <0>;
+		txd2-skew-psec = <0>;
+		txd3-skew-psec = <0>;
+	};
+};
-- 
2.43.0


