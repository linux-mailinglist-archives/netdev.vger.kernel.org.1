Return-Path: <netdev+bounces-267964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EaOCPgat2lGMgEAu9opvQ
	(envelope-from <netdev+bounces-267964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 21:47:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CC829271A
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 21:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 750543096B00
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 20:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD8B37C91B;
	Sun, 15 Mar 2026 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDoarNSG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937F737C0E0
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 20:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773607516; cv=none; b=GIXJIJccd1n3uflG5uNhPzFUUoxRGjLS3c4Dwick/mEBaKIaLyc49IYKKr9yJWHYdR1AzJHi1dQrQ11JW+ZE0Qem+3KRXyjzFNY3DDdKNzpOCXSm0QvfNm9d03BCv42OT0Ezk6X+11JRYdtGBPrHZEaJeNoz09Hmt5rc3AM6ODY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773607516; c=relaxed/simple;
	bh=NcV7Y8rF5EsCyaO+fQzMv4yYadXViOfLjUAI/+Np8mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHWIf4J8q+8qRiOt0K38l2Qr9NKS8PYdo3F61q74TjeIWg3uBqTOqsaeYx0Rf+foMeGGpe/KJ8qU2yiukAaIoYHfXETNLyVl1bRq/ApzuXKPk36fhceyN6DAxMCMHk1BW2VuOmfI+RyLCjJtOhUbBKlic1CQFW7yeaBHIcQljsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDoarNSG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48534b59cf3so34480335e9.2
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 13:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773607513; x=1774212313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkgvDwmYQtcd0bE08ner2utHU4QPqUbSnWFPd8ItaAU=;
        b=iDoarNSGXpSFgEzhBGusuWrzrWIqxrSnhO+7rjuY/eQjRiNZ8ZS2GIz5ty/GWC06A3
         4DbQS/NK1dte3KRptqlH2839P9J83HGQRGfNfMXI2E5nKawKGSuxfGdDYnBQJ+1fZulS
         NB3pXBIew9j9otzv/+6vk9POGwpQJPt/RQkJs9zzUOZFv8HBYrPHrgzSQJneSrhY4fQO
         DiSn3Dnc3PeTLTg9FZSQAZoT2uyKLcdkVxiM8ntqQ2AfK7mTf6q4iEVDn1jCJSNiDEJR
         h4nnmQr8A/IE/T1OhX1yDP+VSgl37mntTdu9IzSd5nahVtjZ2ecHFT18t08VkjIkFBt+
         GomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773607513; x=1774212313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IkgvDwmYQtcd0bE08ner2utHU4QPqUbSnWFPd8ItaAU=;
        b=rYKHSnhIrN3iFrfQfyGp9BEdC9FiJMxXHHtgzuHjiu07x1HfgrqlqJV4sJJhETVXZ7
         voIM9aQs7/Mu1mewd2Hnzqpobr4DwmrqBdkJq1PXLzB6oi6fGXVBXEfoYx3p3ecFNTwE
         AEiAoFVZC/XM+Ilnvt0p4PiD4zBnEYb5C1k+lkH9SioSSh43JIL+emClHLGMQjPsK3Q3
         67PrK7OJbSpO7uGrGtftuMguXiQJjjwtTNDtaxwzUbnfOgWLH7lUZ4sEIRY8WvF+nhn3
         lC7l6yDyf2+UI4Qb1FHroexXu7Za2f4MHj2qAKYmzgP1Ljmhs6ehEJMv3mHEmYjXEFVx
         Ikww==
X-Gm-Message-State: AOJu0YxewbMohuIoOpZxRZ3yd572qvanW8uVO94FiYtdjJj68LZW5fMy
	yO0kZS5Tyrod0JCKF/bilplHknZNbXLZtwEgjrImbHLC8B64f4YVQJGA
X-Gm-Gg: ATEYQzyKTTy/vQlDSzjt0Hmdy0pL13JN4SJKxhwNyQM80ONvqDyW1fDXupEgSBYl0Rb
	sCgf6nC3wlabXlu2f39NqzFI9d7GeJ1j6eWzcsIqHUMQNFNLka8LRpx8aMdt8WnwBjRX+tkkp72
	/XHPjVU8qLwAaQtSX+qhIw9HydHBIkRSW61qXdeELkuJOolUk2WuMgEjefi7iF1+tVoEVxzH5o8
	+SrU3KVYix6419Eux2PpjBrCCK/sF+hXjO9NqcSXD0CwJxC2/YX3H2ERc0cNrXBYhnotTArK/bD
	4YK12KG2B+p8xMONXRWWA/5S54e1+lo+TF3Ku5ptlehNnBok4oMU0ZoLhcF3/4mxq9jA185WFy2
	rSALVNs9ze7t7EYLCoiC4qdAu6bU/ubNjD0wYaE6iPKkkpir1vOucn6NCk6LQ7YsWcCn4lPMc1N
	tbQ52BxCaZstA+MNGTMCeqTJk=
X-Received: by 2002:a05:600c:8a09:10b0:483:badb:618e with SMTP id 5b1f17b1804b1-485566d6e33mr124698135e9.8.1773607512923;
        Sun, 15 Mar 2026 13:45:12 -0700 (PDT)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485563f8c23sm132043885e9.1.2026.03.15.13.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 13:45:12 -0700 (PDT)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org,
	robh@kernel.org,
	kuba@kernel.org,
	maxime.chevallier@bootlin.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH net-next v8 3/4] dt-bindings: net: ethernet-phy: add property enet-phy-pair-polarity
Date: Sun, 15 Mar 2026 21:44:53 +0100
Message-ID: <20260315204454.124544-4-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315204454.124544-1-dam.dejean@gmail.com>
References: <20260315204454.124544-1-dam.dejean@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267964-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: B2CC829271A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the property enet-phy-pair-polarity to describe the polarity of the
PHY pairs. To ease PCB designs some manufacturers allow to wire the
pairs with a reverse polarity and provide a way to configure it.

The property 'enet-phy-pair-polarity' sets the polarity of each pair.
Bit 0 to 3 configure the polarity or pairs A to D, if set to 1 the
polarity is reversed for this pair.

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/ethernet-phy.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 4a27547f7d7a..21a1a63506f0 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -132,6 +132,14 @@ properties:
     description:
       For normal (0) or reverse (1) order of the pairs (ABCD -> DCBA).
 
+  enet-phy-pair-polarity:
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


