Return-Path: <netdev+bounces-256001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPU8DncEgWnZDgMAu9opvQ
	(envelope-from <netdev+bounces-256001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 21:09:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E48D0F40
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 21:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE1B130A28CE
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 20:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26063806B5;
	Mon,  2 Feb 2026 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnpAhzJG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5FF36AB76
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770062669; cv=none; b=pane4ipzhILhdaSMaSAHynY7FoY7fZGDkzPTRg6xtlhnMlSijxQnLpNfuRbiWJ82fCoxf0/rkAaVtdUSqaKr6y3iwBX6jcmEWtHZuqXurK/urnfMp4FcfVPMmhF1dN196rV+VNG3ZMmqUVaFOf9GSM7jT612ZA2uBdJ7qC5rVMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770062669; c=relaxed/simple;
	bh=Se0P0dL3b3W51U6MVaZg7UsTm1e1L6pVdlM/Sha3Lt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goYIZl7Zohrko57xpF91gRmJzGkPlAs51HciRiWxmwdCNTju6vTI8FeghuA1NsSB/GSF2fStNBPaSz/hokiSlx2BGWOeyJl0546gVkJOHL3iER5R+jaJkgb87uxPjCHSaCwZQZ/M2C0FTx9LQjjYkBEBFDa/fFMr0Onop9Jyy6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnpAhzJG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee2715254so26484255e9.3
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 12:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770062665; x=1770667465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3zK/4SLK4ukG/iXcIDXnPvimWgfkq6O3gX4ZLAuWM8=;
        b=jnpAhzJGKxQqNx1ayePpHahbsCs3MBzvjIldlUQCgMJeqQuaAFepuSssj0v7CqFzPg
         JljOnDcOzvZsKfryMKd/oPLbEaJd6rkXFFpfAfPmhOhdM0rndv3rCRajsdOzt/59TEH/
         aq1Ls2xFAU7LTnGtL+Y+45d+2OEVhqhBA1dYubcUyTmtdjQ7TXCanRZFAYNe+AWbkS2J
         hq4w4SGOHEmCYPDfR//sV7J83VzGhUZloUMRJQaM0WEOYja8JAWKAy7WqwitFqj4cdlF
         DH4EcKy9nNJATBj+2ZyIzLmGdSysTu78WwHhF/f/eHAn1+EXs/RqHAyL6ZlDfJO9pTMv
         7Tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770062665; x=1770667465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q3zK/4SLK4ukG/iXcIDXnPvimWgfkq6O3gX4ZLAuWM8=;
        b=lEAM0Kf64tq6/0IJnLMuQwE7JHC1VwgmgHqnkExx7Y7AM+TX14+WxDG233y9glCZrK
         rGQdA1NPkfjsHYXejuLfOhVlnrg0BjPCKaZEqfqRWnUToXDDH7JGrceb3TNRNLtzv65d
         yQdI4BK4DBYO5eXlCYLjAOW/mMsaKnDM1zEaB/1Ne3vIFLQGjuk6Bnaw/Lqe/+9+xBV/
         bg1rA1JtZdSxYltn3BbxarEKGGPacjI85mrV174BR5LIM/Zdc+16ypobcwNL6hT6AZPP
         aoE4UokHz6Obpoznrc4rhzaN/iftarJsfKUzN79T0NftV21rGjrLk/OSUxfhmzJBZjlP
         hXSw==
X-Gm-Message-State: AOJu0YxQimFRqKDoGwqPqDU9LQxbByKotvJv5MM/KbWd7oK0NdfzKvID
	hpeDymGU4WnBbaxk6NzsKIrKxhzYjSuELuUtum9tP5MN2dJtIlcI8Vvs
X-Gm-Gg: AZuq6aJTnH76Ikf4hiKv2GfAjAbfghrQk1Hdga9am39TeS72uprufGr63pug8Qab6gS
	DHQe9YabFMM0mazs742U0QyEFNqFnmNaNL7CuRPtuvEwOhVKynEVFanzudMtFJlfRCBlNzfUPka
	vd/B4R6KhG2s152OiS4RVp6yshEtMsBjDwsAV4BA2tS1QSOcZ6gECKz5vlVF+xhmoKaFp627c4V
	12/ULsDgsDFAAIdUsVBENBOpUuiiastzIojyDwKfkcFWzYMdfNiA11YVRh3xlXj22rnG80iS9+N
	DDQ2LS6P6xVLv/kpxKvroJGtomNZ+SFaKn5SQ8HwOcTYndJ352HOULTdBirXZyjrFbhpT1KUyEX
	CzPQF2KyQNAmBfMfRQ+0eXQ+gmdLT+yUSXsL4akQ3HQh4cldo6fe7P82ZBhPYrq1hG6fk4nQ2xD
	kzbGSVoJXddp4=
X-Received: by 2002:a05:600c:8116:b0:480:7385:110f with SMTP id 5b1f17b1804b1-482db460564mr171982085e9.12.1770062664929;
        Mon, 02 Feb 2026 12:04:24 -0800 (PST)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482dbd3953esm120842955e9.4.2026.02.02.12.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 12:04:24 -0800 (PST)
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
Subject: [PATCH v5 3/4] dt-bindings: net: ethernet-phy: add property enet-phy-lane-polarity
Date: Mon,  2 Feb 2026 21:04:10 +0100
Message-ID: <20260202200411.373161-3-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202200411.373161-1-dam.dejean@gmail.com>
References: <20260202200411.373161-1-dam.dejean@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-256001-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: C5E48D0F40
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
index 8347d4e134d2..67747493352b 100644
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


