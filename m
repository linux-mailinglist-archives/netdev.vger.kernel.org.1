Return-Path: <netdev+bounces-256271-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPMzNejogWkFMAMAu9opvQ
	(envelope-from <netdev+bounces-256271-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:24:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9FED8F6E
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9612C310C420
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 12:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D97F33FE0A;
	Tue,  3 Feb 2026 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2UeWlRe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F57B3346B9
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121050; cv=none; b=lGQmOF+Cux+JM9quF7QLh1iwZaepHfiTXwKvUYefkET2hXlCoqaYpE4ep+eCSrRhoVXH3eiBzUvTJG8WmTwyJS8up4F2uKw5S/ga8v4D5a4PkalnrAovxXmZv7hMEvvs7a5IqN6PHK+pemTH0ItYJIbtlkEawnKG+2unmLh0H2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121050; c=relaxed/simple;
	bh=gninZlBoLuHNxge4GK5ffuEcWrBCJW7xBMyZoit0cSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gSuUnOPFOYZMFCz+ku4uNdVJgNSl2RglMAAuDzTPGhvisSKZSnIAndet1o+LKl9sUNTIrA5TkILsjVSSQNvvqWX05tLy59EkMJIIZEAUKoMd8OJgkxLuRR11Btm1M9MbGjKT1YCDrkUh4yQhPhWZF8dRSYv3vhuI9M/xdVWCYmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2UeWlRe; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4806b43beb6so40772005e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 04:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770121046; x=1770725846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fcy8M4BGhMrAt0/LmVopycDbCegF7gwE/HhYCJa6vg4=;
        b=l2UeWlReGN5RKajqvFD8OpnPtmrYkmCLDlD2uf0WV3VcsKlWIowdYrObskQA+y735b
         fd76Mjhh9LExpS4yY5mtrBEKNW7llQBzSu60VGR/hcjurP1AdBcR+yHDUAtdV/tl/eNL
         uUmozzaVaiKyoHBhn1o722CAs1ReE/6GmszA6PuQgnMM47dFUF7gYeNvb92TrX2eD7bL
         NAKqPmntTVz8d60vvDXrqW+ASJtQOpgITRxDHCgDBnptK6uT5Dob3BAq3PGD3QZ3a4pv
         SXJFaSdtyVZvncPfXyMusnNPvPHGNRbET1qZkg+q2GAJ17ggWwo8UqDTuF6m80KYUmD0
         hjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770121046; x=1770725846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcy8M4BGhMrAt0/LmVopycDbCegF7gwE/HhYCJa6vg4=;
        b=GChzuIceFWf2hVc1XHEseTSGpd+GkfD95fmJlDPmoPo87WWag0yKBdAEf29T9XDz5G
         x2XekIXapEYyr1LqdJCh3VjozCzHjyq7hAn001WOvD6TUs/+sDHTzxGBKqpFL1CZ7hjK
         4yBj4YMxLabY9kpSQ1Pl61E9yh3RjZm9XjcpBm7IEK5PyswDImeinwqzZx4dtgMnjNw5
         zDZAWesZGb5b5qE+CtQy22qtkFFp0SIYiQnCtXOdJfv4Bb749yEifdPWyWYK6YZcnY/+
         Vz9bz5feqk9he2BDE0yWHPBIqzI1O6hPFzBVH4VioS8+8hZCweqUbOMh6o8zBKYHmpam
         2B4w==
X-Forwarded-Encrypted: i=1; AJvYcCXLXCsafITZN8F0fkviMK1AIQm7J3VVyRiLLPRibCCMnOahoV0lI4IUMRjEeQh81rK9WgcaPF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw8lKgX21bZCwFZYTQLlT/dZQxe4+2b8HJcjej4aShlm5XZ20F
	xTmL4+mzsUZRuoS0A4Ti2GlmwQR6Y40Yd5dflxelAh3mfkFFnmzILhIc
X-Gm-Gg: AZuq6aLnHG6wn5lp0XMGqZsVUghfVLDPP05HNReehNjxYvLwPh/TUOnMwd50+nieXzk
	AM3D8bJXC/TifUpOKRy1XgCam40cSG6VsKPlULu3uOHm3DB1XO2wBQQw3TND8KLyzCPsku0cunV
	RIm4zyuAydptGyxpytfYaGNA3VYsqGGRhocWrqUpdDA4I5dx41OVznLsEFglmpvvVuUp6d74AEv
	yiy7FHJ39WfDdjBAbPIvuH6gqKKYUbS5qyjQVyZYxPe35kOWw1TIW3ay3SbTv5zheaVv7hPdwGX
	i549Zw4bFl9hBE/ftYj/juY5WMM7ew5r6rcGcODmE5hefatkHhrP9doI+zJM2h7hzsu6E0ur/00
	l54BMHxAQ8D+6q71a9AdyHi71DuZt0IPQsomV+pTrrmhKB9NZjs02R8yscR8Nit5btqF9z60y88
	uDqahWZ7ahCIl8HMvlCVwB9bPJr9mo
X-Received: by 2002:a05:600c:4451:b0:477:639d:bca2 with SMTP id 5b1f17b1804b1-482db457724mr217768105e9.4.1770121045688;
        Tue, 03 Feb 2026 04:17:25 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:9cd9:f748:166d:55fc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48305129419sm56042495e9.6.2026.02.03.04.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 04:17:25 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next] dt-bindings: net: micrel: Fix dtbs compatible too long warnings
Date: Tue,  3 Feb 2026 12:17:21 +0000
Message-ID: <20260203121723.312336-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-256271-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[bp.renesas.com,gmail.com,vger.kernel.org,glider.be];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C9FED8F6E
X-Rspamd-Action: no action

From: Biju Das <biju.das.jz@bp.renesas.com>

The KSZ9131 PHY is suitable for IEEE 802.3 applications.

Fix the below dtbs warning "compatible: ['ethernet-phy-id0022.1640',
'ethernet-phy-ieee802.3-c22'] is too long" on the below dts:

r8a774b1-beacon-rzg2n-kit.dtb
r8a774a1-beacon-rzg2m-kit.dtb
r8a774e1-beacon-rzg2h-kit.dtb
r9a08g046l48-smarc.dtb
r9a07g043u11-smarc.dtb
r9a07g044c2-smarc.dtb
r9a07g044l2-smarc.dtb
r9a07g044l2-smarc.dtb
r9a07g054l2-smarc.dtb
r9a07g054l2-smarc.dtb
r9a09g047e57-smarc.dtb
r9a09g047e57-smarc.dtb
r9a09g056n48-rzv2n-evk.dtb
r9a09g056n48-rzv2n-evk.dtb
r9a09g057h44-rzv2h-evk.dtb
r9a09g057h44-rzv2h-evk.dtb
r9a07g043u11-smarc-cru-csi-ov5645.dtb
r9a07g043u11-smarc-pmod.dtb
r9a07g043u11-smarc-du-adv7513.dtb
r9a09g047e57-smarc-cru-csi-ov5645.dtb
r9a07g044c2-smarc-cru-csi-ov5645.dtb
r9a09g047e57-smarc-cru-csi-ov5645.dtb
r9a07g044l2-smarc-cru-csi-ov5645.dtb
r9a07g044l2-smarc-cru-csi-ov5645.dtb
r9a07g054l2-smarc-cru-csi-ov5645.dtb
r9a07g054l2-smarc-cru-csi-ov5645.dtb
r9a09g056n48-rzv2n-evk-cn15-emmc.dtb
r9a09g056n48-rzv2n-evk-cn15-emmc.dtb
r9a09g056n48-rzv2n-evk-cn15-sd.dtb
r9a09g057h44-rzv2h-evk-cn15-sd.dtb
r9a09g056n48-rzv2n-evk-cn15-sd.dtb
r9a09g057h44-rzv2h-evk-cn15-emmc.dtb
r9a09g057h44-rzv2h-evk-cn15-sd.dtb
r9a09g057h44-rzv2h-evk-cn15-emmc.dtb

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/net/micrel,gigabit.yaml          | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/micrel,gigabit.yaml b/Documentation/devicetree/bindings/net/micrel,gigabit.yaml
index 384b4ea6181e..284c3ba379f3 100644
--- a/Documentation/devicetree/bindings/net/micrel,gigabit.yaml
+++ b/Documentation/devicetree/bindings/net/micrel,gigabit.yaml
@@ -17,15 +17,20 @@ description:
 
 properties:
   compatible:
-    enum:
-      - ethernet-phy-id0022.1610  # KSZ9021
-      - ethernet-phy-id0022.1611  # KSZ9021RLRN
-      - ethernet-phy-id0022.1620  # KSZ9031
-      - ethernet-phy-id0022.1631  # KSZ9477
-      - ethernet-phy-id0022.1640  # KSZ9131
-      - ethernet-phy-id0022.1650  # LAN8841
-      - ethernet-phy-id0022.1660  # LAN8814
-      - ethernet-phy-id0022.1670  # LAN8804
+    oneOf:
+      - items:
+          - const: ethernet-phy-id0022.1640
+          - const: ethernet-phy-ieee802.3-c22
+      - items:
+          - enum:
+              - ethernet-phy-id0022.1610  # KSZ9021
+              - ethernet-phy-id0022.1611  # KSZ9021RLRN
+              - ethernet-phy-id0022.1620  # KSZ9031
+              - ethernet-phy-id0022.1631  # KSZ9477
+              - ethernet-phy-id0022.1640  # KSZ9131
+              - ethernet-phy-id0022.1650  # LAN8841
+              - ethernet-phy-id0022.1660  # LAN8814
+              - ethernet-phy-id0022.1670  # LAN8804
 
   micrel,force-master:
     type: boolean
-- 
2.43.0


