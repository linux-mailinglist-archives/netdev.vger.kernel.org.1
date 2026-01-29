Return-Path: <netdev+bounces-254685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCuNMJEze2lJCQIAu9opvQ
	(envelope-from <netdev+bounces-254685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:16:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66422AE781
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79C493016CA5
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB11C339705;
	Thu, 29 Jan 2026 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5+pkaAB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4381022A7E4
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681781; cv=none; b=eETAmyl4ARf8VvG8WOzjiYMzj2oCBj4iB34Z5AhaYNhIW1F2ELg3J/CDBwOOm1NUbt0PKZn4yPDh3aRtW4kY01C17q0Sqxz3Qd21w9wabGek8GPItZfqmRMb76I2774vF23fy3JsUsXrN6EdLG6jLo2ZZTSHi7zOaNYlQU+7uBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681781; c=relaxed/simple;
	bh=6mwvgcU4b+9/QTYhLf3cWuarnifzlcz1Qc4XoUMHFqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MRN6x6H8g2zHJEat1ERVzoZHZT6jg7FzMjYplvLxUZrOoA3wY27c0VbPLYoEBQENEyzPLff9d/st7Tam61Aa2vWAk25RP7DxpA7331Wc2lQ5p5F9Tofa29NSsiYxghnSYk2diPWAFf6K7oBKI+oE3Fd9qrxzdRaVQ0TsABmEM+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5+pkaAB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4359a316d89so687185f8f.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 02:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769681778; x=1770286578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DnYB/5fk0KIL/28WT7coTBmZftn7pWijOsAyfPHOv0M=;
        b=i5+pkaAB3nD8j/YWmt28Hz2k5ZfGabZ/9MEfxfTe99cAeuaHgFcYc7ngSU89qjMzOF
         MIFypLEQGGKYgkGY9CFuVZfIxv8TXMQI76Q0EtOn5l+/QnFaTfNqli10EXI2CeiXkb1g
         2FjecXNXSrFnrRTfTn98BQnIBd7/VVkrXBHMnfK6IQfx826xz9U2bG0oxwc7qWZaQVlk
         RiOgR4Cne17iciwLOv25aQQGkN6VTX/M/nNe2iUrxiPcJa5DPlfJebQnhFUEbSPEoa6w
         iuvc0tGBtVTAXNMCp7vTvmX2pl9vjoN41/cxthN99jF8neWXWezbk37aZ2hCpPoHNF7x
         58EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769681778; x=1770286578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnYB/5fk0KIL/28WT7coTBmZftn7pWijOsAyfPHOv0M=;
        b=mbdCTGrHrgX7tjqX4t7gmkN+hNTvYDVp36kDfiQBjpfpl4S/4Cx36p4q/AD2tV7AYU
         T18AUWhDSP9gxQXXh8IS/7JF1EFcqfx5g+6Wc8ypF+a4qwW8ExTQqqW3f7CLypSIg0o3
         IKLCgV7fdu1umhmRBje5yEDihrMEA91qVgYtYDQ3FIdMCiD0xDrfpgfKKnVGmyLaVUL0
         D7sxPnOXWcbLgAmzv9gL+ZOOWFelYZ3JuHZkuYviN9PmRKM6tqyM9UnDZ2HEagGgEU8V
         NMJORNna5IIFoslqI5e9uP7l4tLFdCjCwK0dpQLzru85q7n5ySQoXOK5+J2kz9522zx8
         l6aA==
X-Gm-Message-State: AOJu0Yx2xx6aeI/mJlUdJvqGH2vn86nDoh/XQRLlOeqaY9kP7/vtNfvI
	JFtWlTRJAG8X7FI+LCYzGPosxLjwzwxOB7JPb7QTtqInR1/dwLkXMbIc
X-Gm-Gg: AZuq6aKKnWdsY6M7tzfwooKixakUCuzdJ34ps227Dp8jnR3ijOGykfWN9AQKeVuWzRa
	M9Pc1m4KW7brqg9VRfPbwGViehk1aqif2Xctip0HBUbVuXyFX33ZfWw773896mkWqLk/geyESfL
	f0fTuZFoGE8iz0T2nZfctrSIdLW/Wx1O5Gehx6vX3t75UD8w89/+BJAw2zlp4j3t2GZjXbhW0oo
	w/FPcsSl1nPzOUKYBoc77lglun/E3WneNihaTfWAzfezAefpAV1MnH6f+cgTe6wicAfY9Tdon35
	gm9Wn4C/RrlvhXaJSMZbbYQk7R0C11ZGyU8+0oNaa8t0pwvVNlOp4JE+PeQXBQa2KS4KDfLarhQ
	aFUcwj97bpayAH2QG/a7ljmI8HusLFYC6xOqYiE7w+ybcjgK1dtjs5gSG+gJN9LcFX1q1qNawVL
	df49T/OdO9F0s=
X-Received: by 2002:a5d:5f56:0:b0:42b:2dfd:5350 with SMTP id ffacd0b85a97d-435dd1d92a1mr11347963f8f.56.1769681777514;
        Thu, 29 Jan 2026 02:16:17 -0800 (PST)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e132303fsm13413662f8f.36.2026.01.29.02.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 02:16:17 -0800 (PST)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org,
	robh@kernel.org,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH v4 1/4] dt-bindings: net: ethernet-phy: add property enet-phy-lane-order
Date: Thu, 29 Jan 2026 11:16:03 +0100
Message-ID: <20260129101606.33972-1-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254685-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 66422AE781
X-Rspamd-Action: no action

Add property enet-phy-lane-order to the device tree bindings to define
the lane order of the PHY. To simplify PCB design some manufacturers
allow to wire the pairs in a reverse order, and change the order in
software.

The property can be set to 0 to force the normal lane order (ABCD), or 1
to force the reverse lane order (DCBA).

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 58634fee9fc4..8347d4e134d2 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -126,6 +126,12 @@ properties:
       e.g. wrong bootstrap configuration caused by issues in PCB
       layout design.
 
+  enet-phy-lane-order:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description:
+      For normal (0) or reverse (1) order of the pairs (ABCD -> DCBA).
+
   eee-broken-100tx:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.47.3


