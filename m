Return-Path: <netdev+bounces-226361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E70EEB9F8D7
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 15:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9593BF8EB
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 13:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1446279DCA;
	Thu, 25 Sep 2025 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="JIf2cors"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7667423A9B3
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806483; cv=none; b=RIobg+lsOaCDvGIQRzpDzxqeh8f0DhGKQlPw1uKUkb/NuaOD0PsPVuzJ3hnpERGGcscIz54ksAkQq5ggnJsXxTS/sPK71esFk9ikum3zIlNEmkGPvPKNafz99UxSnwhHX1bla8EfEXJNQ4uuJo8A3dvtpb4RLYmu86ge+IPJYco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806483; c=relaxed/simple;
	bh=6DkEKz0Sd3dC4Jk9T0dI0jxA9uPtNze3gqNwzDK472U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TbVF+5CrYVjVdKTkfmU1Y42NH8yLd80/uCzsCtwjHb/pWRMzkSK1xxy9YWfk8ENeq2c3Qqurps0eydnxUdgCzHigBeFQqfgzWut45VMLh+B/c1hErYLc/g3R65v/5scpek+pzqkXQl3ykL4wY4VlIHYUQ163JJkTdrcx/NCKu2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=JIf2cors; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8030aea5e4bso7324746d6.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 06:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1758806480; x=1759411280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ikj1YYbJyMMY0I/qjjfkDNziE+dHmdeEHUJPM2fNZ0w=;
        b=JIf2corsoOsyql/FH2Ec2/kvrjna3ECx4pG7e787xzTh93tpFyk5oos5oNEi/ng4vh
         huUjSSdSGxML/f+PbbyAZpC79/o7Y2ke0kdJgd9LzPOuAKUhLD+/qechTJZpnvq9u8mg
         5RT0Zz3J6zF4ywUBdFVAoaN1iV8TYEtilAGkIFNUMIFRybgKu17qNiTnf6XwZNTvu6BH
         LP6jf/vQXUp1UPUH/iAUUu9C6O8Rid75gjGQKcFwqXn5os4UcQhA1STH2lTT5M9o5QzK
         T013pnimKPBdEDQU2HBZzyFOSksQDgODDWf16hT88qlP2KA1Q5ehO7KPj2F7XhymMGlm
         r1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758806480; x=1759411280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ikj1YYbJyMMY0I/qjjfkDNziE+dHmdeEHUJPM2fNZ0w=;
        b=LtQZg+2e/KZ5FWLwYiJTOKDKQ+jsJQEZUfYlrbvgg26lTNlRLoGSZ8EmjdxXZQCqRQ
         WYFealnOcnUcUf3ZasFZmN4Fs21bdlAh0OhI6eZXvqd35cYRuKZ3hxPuw2EO3TnhjK7Y
         +eHwkIjPTwPDIFHx33feDsnnWrdCCmJiI4bq90urBPbxNwZoHSc6ugKJNH8L4zWbKLu8
         BpLZhlEUMwjuqToUoD6W1uFrWRqW1sqbqI+3pO7z+ENaq+OzOED9KBIum1wqDdSn/Gyy
         i+K8woaKaDYsEUp/mFOBaSRWO9MTterAWFpMK23BGAGnnBNeJl/9tDDlSOEoxHzDBI0B
         Qn4w==
X-Forwarded-Encrypted: i=1; AJvYcCW/tEXiX/nQF1gkwIE+QdcF7pscqwQRgtlSq/HBFBnXDzCazPHLpIZU4cGgOU78JynynzbyCZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWygXO39a9QzNXCT94NmeL4ZJsYASSKqKV7wFnEA/wNBxkLDRD
	GBjtE8FEg8NAsVrqluzYx9gfoNfdB/NS/GqTWHFhKbGbJ4h4rJ46ugvodp4dzBRcG6g=
X-Gm-Gg: ASbGnctFqhZukq44r0LW1xO1qak2tZ5ZxjFxtw4+393e44ZNsaIVBL000wlxLnLteUd
	PHeW53l5qCYTFa6ukUA7oBtpGOMOFC94I9PXUqFphVI+CvApRtNfcvowcEqHWuM1ddKfsd80quz
	6AbPrzH+3qx6RKj11yZuhEK1SfWRbipXPuQtfdUsAEo5jkqdrJVpud8ECTpuUp0daXc5IT9XE3w
	WiiJErb5zyYxGVCJuXyEFfXIFsEu3aiG1Pmkc7jzgi0P9hzFTuV70DcYrgKYduYDnwnGUoP2TL5
	Pmc3bBnvH7RdORoVlfaJAQXmv00ROhakFuDoIBX2+XJxS0WMcv2OKDE5qPVe5GTwW5ODA6LgHBG
	OUetbSJU3dFfa3mFkpzR8t3G9/ZKzFBvIV6aAjYN0zm0=
X-Google-Smtp-Source: AGHT+IH8XUinRdR3zGGiBp2m82mpBfD/3zmwNXqhrKUwUBHni0a1zJyvS8LqAu4izyJ4awYO1sa/1g==
X-Received: by 2002:ad4:5e89:0:b0:773:292c:4f69 with SMTP id 6a1803df08f44-800e5116d46mr30765656d6.10.1758806480193;
        Thu, 25 Sep 2025 06:21:20 -0700 (PDT)
Received: from fedora (d-zg1-232.globalnet.hr. [213.149.36.246])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-4db10872737sm9887351cf.30.2025.09.25.06.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:21:19 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	lars.povlsen@microchip.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	benjamin.ryzman@canonical.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net] dt-bindings: net: sparx5: correct LAN969x register space windows
Date: Thu, 25 Sep 2025 15:19:49 +0200
Message-ID: <20250925132109.583984-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x needs only 2 register space windows as GCB is already covered by
the "devices" register space window, so expect only 2 "reg" and "reg-names"
properties.

Fixes: 41c6439fdc2b ("dt-bindings: net: add compatible strings for lan969x targets")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../bindings/net/microchip,sparx5-switch.yaml | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
index 082982c59a55..5caa3779660d 100644
--- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
@@ -55,12 +55,14 @@ properties:
           - const: microchip,lan9691-switch
 
   reg:
+    minItems: 2
     items:
       - description: cpu target
       - description: devices target
       - description: general control block target
 
   reg-names:
+    minItems: 2
     items:
       - const: cpu
       - const: devices
@@ -168,6 +170,26 @@ required:
   - interrupt-names
   - ethernet-ports
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,lan9691-switch
+    then:
+      properties:
+        reg:
+          minItems: 2
+        reg-names:
+          minItems: 2
+    else:
+      properties:
+        reg:
+          minItems: 3
+        reg-names:
+          minItems: 3
+
 additionalProperties: false
 
 examples:
-- 
2.51.0


