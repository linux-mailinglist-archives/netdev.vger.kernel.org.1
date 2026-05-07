Return-Path: <netdev+bounces-285239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKOXL81t/GkQQAAAu9opvQ
	(envelope-from <netdev+bounces-285239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:47:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 411134E6FD5
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F555301B91E
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 10:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239B63E867F;
	Thu,  7 May 2026 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="xRFvAfp+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E003E8C40
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150858; cv=none; b=mTl+4csIcSIEC4Oz6YciOVWl+hrnQ9Ryy8oxAfDE49aYxo0YS03YPV4N93sJ4XR4OkuYh/ltXy+TMX01snIc3tWRw7bZv94V/HoukgNRq8KsHT7tmnLN8Qi01h1dKHZBYrF2DyVzlBjtmB1xm0jMg8VZJZ3crT4pJJN9yHpPnpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150858; c=relaxed/simple;
	bh=vsyg7SzQr/MhpQWX2R69i+dy06+2L6zetPs00hCeGyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oYdfboqVsh3cFP6XGtb+LXtIo4eWysOkF9cdxgEiKD1Pu2elmdKmXfePkV735WHQ88ievNtyZJOyS8N8q1Nn3NOYDlCP37vAKBUtd2LWCio1cX6X+h3sV4HCZAElnxLnivChfOXK991/uhBGBa71rOI3zyYyHVzjhhTFj0Avcpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=xRFvAfp+; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b4520f6b32so1224417eec.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 03:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1778150856; x=1778755656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zaZMoEIQ1Jf5sIP1IUKKwF+M8lMdZJxB7U7Jjxi7VqM=;
        b=xRFvAfp+4vO4qu5nkwmyIIkNhlvaYg1Y+YVrFm0ulpLChQEA573HV3wLSKxiY2paJF
         kLqeiM57SzjmYf60voDecms3noZPOUnG72/wn/1fthGpLigv9nebrryuCbhrDAV2vnWK
         eZnlCfMPExFyA3vFnfwRm1cffXR4beniHi0PkRZzvwCFeQOTaw7KNucUHwc/RIs2Kpyb
         nGM3/8Lgai7Anrk1t8e8o3T9iTVv3jnhdP9FXEQCdaNibbx5fHC5ut+zUJmHnahTArKw
         wyK2R/rG7/LUzjj06t5uzOFZYHd8LvKU+X0uELsj+oGAFBMaGx9PYVgWRZTWOoXhSWkG
         ihLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778150856; x=1778755656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaZMoEIQ1Jf5sIP1IUKKwF+M8lMdZJxB7U7Jjxi7VqM=;
        b=J/tPQnhF9IMF0GNpIc+fVhITMJklw4Rb32bP77wxVO89hHIzeEMePrFaiwxrTfGqYl
         8dg73Qd+JqV9FBBLkk+02yfbxRVZ7GhGkxBtOBa5v4ZWZ0D3KZaETt2/SqEWLc/8aQJQ
         7iRVzizUrBVfAIr004ZpQmdnDlF6bR0ZRGqgGGviMusv7XDV4ZnlzgTFavh2ZRPdkzr1
         z0U70cs3Hgcv3ma73zb32uqne2S0a7rAQ2QoBMI83I6p2EIHf2xNTMB7dfxmGqJIeKbD
         wSH2NnNIR37et/75CKbQACPjR53PvWpehslHcqo/Mnkd1x+fInwCx3u1n0gkhXv57k3B
         rreg==
X-Forwarded-Encrypted: i=1; AFNElJ+Kbm5GykbVBQ72rjUeRjTmNLiOc6TLG6UdFWUtLJdHTrvEPnEC+UMtqw5faxF9m2lMjdcbB7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YytscUSfslhvZyuCFj649SUV8bJwmZPiv+vtsrvZEdJg147XDCc
	x8umlORpZiFGjQuXctfjOW51/4CVb/deB0dKHVG67sNcqLUyR+sICjfT2UmEPsj43XE=
X-Gm-Gg: AeBDietoF09j11mH6nrJqZnwGqXbG/o3T1QIzNMVg8FUNOFc6WxR7URQbi4+DYD8xzW
	jEdCfVEpfgQrhiZ+jaenAxOGSonLQ2QnAjCV+WmVrFEwa2o3QmZGATunQiDTgut3jFItKOyEenI
	NnuHUzZ7s79uSvH2xJemRYz5XA5W8zREjchKmlgpDjpaw8ORw+VqBRySidM+SadeWR5ckG+UQrm
	0eHiUnsx+vCi9igadTT4OS7Fym6DFFVqXZUN9yCkNbb32H68PVlTEnVVsDEbtMCKXJn2N3oMKTQ
	2vIruuOZO3sBe7zePn10mvIH3FaJQzLTNWPh1nTeBRCZ5xw6jH1wgeBEBT2gdE2WZEaTnae+J3G
	gr0LLd6rwbrGPzWtkAm2OUP+IzqBuV8wsF2pSlOVE+2fwxuIRaszmDLU6sYIv0Sz2oHVH5eMVES
	1faNIit3cpP2gAnkJbiaxtBInBuQlxVaNQ8ULqI668vPGUd0+wc2OhNFBgZ2XQmp7RHW9sqjLrB
	KNN1pAZJvJ8AWWjapVHDjCJt9mN9iOpHu/u0ATeja/vmal+5wQ=
X-Received: by 2002:a05:7300:f191:b0:2c4:61be:1d33 with SMTP id 5a478bee46e88-2f54d69b008mr3592034eec.6.1778150855826;
        Thu, 07 May 2026 03:47:35 -0700 (PDT)
Received: from fedora (cpe-109-60-83-79.zg3.cable.xnet.hr. [109.60.83.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56cec5d8asm7040271eec.3.2026.05.07.03.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 03:47:35 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next 1/2] dt-bindings: net: pse-pd: microchip,pd692x0: add port disable GPIO
Date: Thu,  7 May 2026 12:46:54 +0200
Message-ID: <20260507104720.262641-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 411134E6FD5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sartura.hr,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sartura.hr:s=sartura];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285239-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[sartura.hr:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.marko@sartura.hr,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Microchip PSE controllers have a dedicated port disable input that like it
name suggest, will disable PoE on all ports.

So, lets document that GPIO.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
index 03d9ca1cbcc0..f883dca87bf9 100644
--- a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
+++ b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
@@ -23,6 +23,10 @@ properties:
   reg:
     maxItems: 1
 
+  disable-ports-gpios:
+    description: GPIO pin to disable PoE on all ports
+    maxItems: 1
+
   vdd-supply:
     description: Regulator that provides 3.3V VDD power supply.
 
-- 
2.54.0


