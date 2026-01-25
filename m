Return-Path: <netdev+bounces-253199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BlsHgV3dmnqQwEAu9opvQ
	(envelope-from <netdev+bounces-253199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:03:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B63824C5
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50B673001325
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 20:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52743009E1;
	Sun, 25 Jan 2026 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVKc39e4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372842FFF9D
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769371389; cv=none; b=grZysG5VcsJK9Fj7/xhBtympxxUPv2SxM0XyFOolpzgbbc9JV1uyba8m/ELgfSj8+oyBNx0nBmOLT5MQhiM8I3FbUjy6p+CnkJkVJJMMN7myTVH2opJLeztNOZz76JUFPbic+HpRf/k6ZxRd2NNOVI5qztf6YM1cSg8VuyFqy5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769371389; c=relaxed/simple;
	bh=pSAL93nHZnSqriO92kjK/3e9XFl5GN7qGm5RZwIm4o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYumwO/rfW6lxv0gNb0DXhIsFH1F/3iHTcZK6UXCtWheGussfaPGKiMO8iSdJJFnVudS5+h2Iq4XhFj2K+E/aG/isvHitWdsggMR+Y4z/QVLaG4Eo/RO4DoaxW5P9RTMzrqhQbvzaUzk7LH5k8bzsQ11319vXg2mqE2vTffjbbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVKc39e4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801d24d91bso41217425e9.2
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 12:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769371386; x=1769976186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63tDj5BfKjz+XebxRQfxXku12AhjNyBPccGDrGS//z4=;
        b=dVKc39e4+pwhXRfxz3hFS+gojeWKHrBGOfMa/wsXF0zx0ijmaq/QCErGv6c7/HsiTt
         /lRJyodJU7Qh9SfBDBmRRL2+4dbzPnHu+Mh4iYnR+IPzUw/eoElTSv9M+NYDMtw8ce1W
         6POkyJ3MiMtyQrf4iqlptwtRErr5N3P4OU6+M+EA7L0Ke8PoBq/gGO+3/3NfCB6lYpVe
         6KsRvPtbylOTIKmUh3OtWmSKmIBGNacdgMzzHQhw7UOHoA/4m/dN/0UEYQJH5EO5ikGB
         VJ+9JxPw7FSp1uG7vKneClbx37KeJy5LQXyIN9Necsc8EXSFmyxm4wV/nP8gHf1MNZUo
         t4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769371386; x=1769976186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=63tDj5BfKjz+XebxRQfxXku12AhjNyBPccGDrGS//z4=;
        b=TjSxb8seJWytO6wgdBZi57nLncOYT+PGamopyueYVq3HXh49ewlBzIqoHT3zi9Ry3Z
         z7RZ1CG/dNwOo5iuYT7/SDt/BZPKE/qunmu23mEBThNm8hwbBqDbuT3OwxaBAFygEEpd
         SvmjZvJPHQGMIPjKpRPyZWPzs/YU/9OPbxQrVUWfbRNbqOcgSPoECP8RwKHn1mgC4S8y
         lDYntjfoGGOiihHk43Nk36UFitOZrKZ68aoD27f25deCMqPgjXAhSlbl9dRlljq4H5GJ
         2HPi4YbatZ95j3KJ5UvMDyRNtSSrpsXXm35OpNAWW5uYwSTDBIQzADXKZfi3UCpTnDLE
         c43A==
X-Gm-Message-State: AOJu0YykawmnCxGXfbQ2H0Jeo93/JwnXkawLsFNupNPGq/i7/AFYzvWi
	tSjYxFyuZ4+2ko6XfMchJLk0qVCoo0vabwrGj92MA55mzb3O4GFCzX9e
X-Gm-Gg: AZuq6aLr76/pjqNgitBLyEfCm6OJnarwIJ7xfPMuVc8RntoAvbKfoPfcwCyM36ouWzW
	0Foi/MhICVEJ/V/3EPTUz3U9KNAUV9yfOQGdc9W3FoURozkNwfb5M9VivB6OSdsdzeZtI2rGf/Y
	JLc2ZEteqkCAB1vuGqgtZHEJDm8N+Zcp6kSk68NBSkNBPU1Geg8L3by5rfKnAGC/PkFEqQSf/BL
	7n3lXBL4pEDUmP6EZKbVDLq7S/qeSkEJ9H9K8u9Ds8b2Z7RRQNsVmVkC7WqyH+uAiOLNvHNlwt7
	lCkCpszAGIJjPTpBGrdynY3pvAPWg/tyT0hQ5QKXbvpVT95cWyjGRstcTNG8g5mLxlYo8uuC4Es
	O8K9DjU/WMFwbFmoiiKOWezxteBnaBAQm3VUtgVYPhKR1FI6vKZWndF6cJMs2lpKiHWF7yTGbwM
	ctz4WDL0s2rrw=
X-Received: by 2002:a05:600c:530e:b0:47e:de9c:92ec with SMTP id 5b1f17b1804b1-4805ce4e568mr41469235e9.14.1769371386477;
        Sun, 25 Jan 2026 12:03:06 -0800 (PST)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7c269sm24418036f8f.43.2026.01.25.12.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 12:03:06 -0800 (PST)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org,
	robh@kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH v3 3/4] dt-bindings: net: ethernet-phy: add property enet-phy-lane-polarity
Date: Sun, 25 Jan 2026 21:02:58 +0100
Message-ID: <20260125200259.2903271-3-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260125200259.2903271-1-dam.dejean@gmail.com>
References: <20260125200259.2903271-1-dam.dejean@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-253199-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 02B63824C5
X-Rspamd-Action: no action

Add the property enet-phy-lane-polarity to describe the polarity of the
PHY lanes. To ease PCB designs some manufacturers allow to wire the
pairs with a reverse polarity and provide a way to configure it.

The property 'enet-phy-lane-polarity' sets the polarity of each pair.
Bit 0 to 3 configure the polarity or pairs A to D, if set to 1 the
polarity is reversed for this pair.

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index b8cd5d2b9f76..ec8906708100 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -132,6 +132,14 @@ properties:
     description:
       For normal (0) or reverse (1) order of the pairs (ABCD -> DCBA).
 
+  enet-phy-lane-polarity:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 0xf
+    description:
+      A bitmap to describe pair polarity swap. Bit 0 to swap polarity of pair A,
+      bit 1 to swap polarity of pair B, bit 2 to swap polarity of pair C and bit
+      3 to swap polarity of pair D.
+
   eee-broken-100tx:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.47.3


