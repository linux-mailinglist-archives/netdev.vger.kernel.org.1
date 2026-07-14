Return-Path: <netdev+bounces-307561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 68yvFKaKVmqk8gAAu9opvQ
	(envelope-from <netdev+bounces-307561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:14:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A5F758242
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:14:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=d0sKl51c;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307561-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307561-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C4B130376A2
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF2F3358AF;
	Tue, 14 Jul 2026 19:14:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9803418A50
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 19:14:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056444; cv=none; b=HIElB45nZGKcMJCB92UFpuIFfzAxE+g+nQGfsk8Mgzw2rAVadTooi3utOdOdiHwjghfLVS3LmSjRLxF2Y+LTEplMRn+nYfo0QRTbCe2QrU5WqfW8VYu/yswAukcLpy0w1PIY0hFu5Pzu/yKaPTc4yEaRsH6hSXRv5Gn2/C279NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056444; c=relaxed/simple;
	bh=wxPeLCsTAeswrvJTcR+iTOSTPK40LDXWungZWSaYsrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9BaBh2jhjkIAKKA5+Id4c9PyoqhBIUPkLo9SCiVeqsJU1oqUS7ahsDNQCOlELv2y7VKSDqQPURYl06XKUSgrR5drDi8NptWyg5xo8P5lOLAOrz2yVB738TDl12zU6waTpoKF+nAqzfQu2a20Woaaui3f4Va8qiXNkWemAkUh+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0sKl51c; arc=none smtp.client-ip=74.125.227.130
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2cad83a0aaeso20233015ad.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 12:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784056443; x=1784661243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8x8RDbcfDX0JdqW/clHRnOctzbZEE6whwRLBLDpw64o=;
        b=d0sKl51cPheR02G4mwJ/+sPH35EqhCpVvqaQfDK0GTYOt8yNLCdsbDp1p9aMxnqHub
         JnXIxBcD06x3YQfQcS1VK/8zjOfB5JmK5rm1GDyeGBwMGHJzs0izcEvZKI6R/lXMgkSC
         gTi35BV3wXY92BpgMnCZ86AihrptpWPkhT78MuCDKpaGHaJqhD53dFnVgPNLWRVD+v4T
         27HFC0kFAqANC6KnpFUYEgWYxl7gXLysZ4DNGHXgmmqIeECl4diax36QpO+e8m6vuNTG
         b/gXXKaGr7P5zthl+JGdp/RvGAXwqtXSeBEcTYgee6MJinYBYhBNWw3SgAdEwVr5OMSV
         QDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784056443; x=1784661243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8x8RDbcfDX0JdqW/clHRnOctzbZEE6whwRLBLDpw64o=;
        b=djJNYn3/86lYKhQZsaxTOOfO4P5vaZDdsTtTDt/Ade5Q1Xl+4Ydk1LBYMJvedwvmla
         z6M/4ppDBZ9YM964KoIwrPORFFbyi6H6nXd0VeZPlzN3N4+huPlVyeZ2Z8BV+gUByuKG
         oe2yNhMhzgsF/EjpidQPTDYnEVq842lpmezHP98bHbEFboLzsXSA1vJbltWU0APK6Q5J
         qmJMUtyMBr+doinjSsVASvVvrxOufmccHFKlR2ydiu7Y5mzafRW8zE12UatXQt58kZBh
         gzR9SqPE1VpntkoZ+ptUOMqjeVgXYKLHlYPkBt6h95QOBvMiCyflXE3a3bbg9dgHxhtk
         sHdw==
X-Gm-Message-State: AOJu0YzwuQd/O7mNfqXDBvg8mCjdlR/QbiLA6glo/vSJO5r8P1mpaYO1
	aEygG2fpqQj1MJmCPsqQC/C7HHKWEpRJWK1JIlB6ELPfLx1PWCoWr3Td
X-Gm-Gg: AfdE7cnxxeIOCpaDDOuwC/GZ7O0kVs26KKOgmliJu48oJUyxnTNfxzO4KTeDuZ++D4d
	v2oTTg+CpTykPQeHeYTxVScSb2wDBrDP9l8/60SW03OKEjAiqy+5uj/RP/XLwtj78e1xK3QoJav
	yAUMPpHLjV+W+k4LdkHL1spD809DRysNqZJrsfZkym+IZe4Wjmx7wmK2yBrlO25gZRW5MLmLg0u
	OschnsO9MX8x58MWee1kSC7T7bhUTYxU6KIW6lHAgQll41kIIj/d9ulcYUbGq8in53u28QkirAm
	kaG+WKu/+ptsMZruKt1HuZgaSVa/HXO0N41ZXxXZjBl1vN/xZwABYIqMtSQ4WJO+Wrj3vka0TH7
	SnwUi2y+cUC5YOW90e/cm9SvjuOwuZ3sbTbMIyLxpgVMJ+btdrO6c2jppDeF6ckiW//kB2ZxLQT
	1Cc06EgiFn8Ew=
X-Received: by 2002:a17:902:ffce:b0:2c9:97a8:8c1b with SMTP id d9443c01a7336-2cef1374743mr36739275ad.46.1784056442914;
        Tue, 14 Jul 2026 12:14:02 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d451sm120763245ad.65.2026.07.14.12.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:14:02 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	heiko@sntech.de
Cc: netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [RFC PATCH 02/10] dt-bindings: phy: rockchip: naneng-combphy: add rockchip,sgmii-mac-sel property
Date: Wed, 15 Jul 2026 03:08:30 +0800
Message-ID: <20260714191341.690906-3-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714191341.690906-1-coiaprant@gmail.com>
References: <20260714191341.690906-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307561-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:robh@kernel.org,m:krzk+dt@kernel.org,m:heiko@sntech.de,m:netdev@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-phy@lists.infradead.org,m:coiaprant@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3A5F758242

On RK3568, the SGMII interface can be routed to either GMAC0 or
GMAC1 via the pipe_sgmii_mac_sel bit in the pipe GRF registers.

Add the optional "rockchip,sgmii-mac-sel" property to allow the
device tree to select which GMAC controller is used for SGMII.

The property takes a value of 0 (GMAC0) or 1 (GMAC1), with 0 being
the default.

This is necessary for boards such as the Ariaboard Photonicat, where
the SGMII interface is connected to GMAC0 and needs to be explicitly
configured.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 .../bindings/phy/phy-rockchip-naneng-combphy.yaml          | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
index 379b08bd9e97a..6173192e31ab2 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
@@ -80,6 +80,13 @@ properties:
     description:
       Some additional pipe settings are accessed through GRF regs.
 
+  rockchip,sgmii-mac-sel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    default: 0
+    description:
+      Select gmac0 or gmac1 to be used as SGMII controller.
+
   "#phy-cells":
     const: 1
 
-- 
2.47.3


