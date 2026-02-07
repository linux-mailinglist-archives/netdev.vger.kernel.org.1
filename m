Return-Path: <netdev+bounces-257748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOB3MmUFh2ngSwQAu9opvQ
	(envelope-from <netdev+bounces-257748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 10:27:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8315A10557E
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 10:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D11A304D159
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 09:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57C53112B0;
	Sat,  7 Feb 2026 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHNv3SOA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C330F923
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770456357; cv=none; b=uUysK9traLDGRnM6nohTGYK7ZJbQdoEuNlCMfS2hQq2Pn/dQa2RTxeZhZOcd17+USXkfynvQ6uyfk/iS5fXQUv1t9pDDQ8gGGEkuodHBgiSgiMssyNnDY+Fs4TxCPqqgeMLrGVj2gmGDIoydTYHlo6iNwzOIwdRVfjGFGVo78BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770456357; c=relaxed/simple;
	bh=WHYAE8ltiGUno0Y/pr0VBXmBeaYCTgMYqkBFoNw1XUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9MM0d6/uIcTaCxmT6yxpu7TKK4VMGzsUv18j3kjLjrnJWWXq010InsFWpdobGpMkk5pZw2730OuKOOu6ws16aj/NrhT4guaid6jhkNV3UU+GJCAO0XB06dR3xFjiCxMrUZJaLGGl4F8LSOyP6K4+eDEV2v9GPPOdop+8XITkkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHNv3SOA; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so16323725e9.3
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 01:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770456355; x=1771061155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJA2EalQsbA1HeA0I9hBQ2qiLRIkuI7uniQJw85bkPk=;
        b=UHNv3SOAaXK15dfp01CTidQSQTDcohed8uxxaMjp0bTYuBa1ZrjjnaXKuTOsXa8bza
         6nM1Vyn/6jXxgU4cvqNCwRJNNrdPSGZLzfoOXIAuCeCjU0ATHXKwirNpx4LV1xQpoMSV
         FVAG5DPgKe/XtVk8EM7RKQLr9SG4pY8WV6IDKHr8LZqpb2LnCSwdPZ2LuCo8bORkTGyk
         hJbRLjBlZpLVvi4L/iWqz/e1spx3QWs5owxnFKb7NQvDbb+msv+xWZELiHnYOtqdMxg0
         UyMx/Nlz2pcsWKKopRmi/rAPdMk1KV6s8hMHpdA6rQN43ie/WkniImnAmOknfVKZkbQK
         Orcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770456355; x=1771061155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hJA2EalQsbA1HeA0I9hBQ2qiLRIkuI7uniQJw85bkPk=;
        b=oiijykVXkDE/mF++j4mOIyvbg7tkZ4ourjob+QLodjQp4W/u+HAf/RM3ZTV498N0cY
         jPt9Oc5yaixYrrXEZb0S/VecIhzf8zLH/RPAY5FPdnfRV/p8hCgZBCW5FztN2f+XyxJM
         MrOaqhhYmG+AJAgKyojfcFbaYGz5gSk9sT0wJMEDnPxs2SJGYExKkQAUa65U7TsVWG/W
         edwj3KXtlTeM2IvWcXT87KTw4DsBt/SVpZWOjvb5vnIT1RMYoNm5938cwtbAxDAuL7lU
         xLWNoA9+1s60SAmfvOYsuQUDoF6R9yl1klDLYms96JE1fDSEFLnzvf1VKhG/mb/k0Civ
         Pxsg==
X-Gm-Message-State: AOJu0YxJevk2JInexWkYmUO94kY6hJiI3Bz/r9wbm6km+5m71gb6l9y+
	ogPd8TarrDhNclCYEbAkFITbixEA4FIsC8qgl6MTDsUfKQ8TABEjg+nh
X-Gm-Gg: AZuq6aL+2fq3MqjFiUMhr0So+AUCl69qj/lZAPwBM2ccUsozQ4jJQ/3WZh7rGU7xA7G
	qCKvCLfvbeP9MlnY4Fa81LQ61SMdBUoejK1FKO7Ehdyv7GJRAfW0mWqlGJ042OVsL7qIKV3XJBv
	T5rld9LO8a8Mk+/J325WFaYTwAZa1GIvgnTe0PFmKnbEbN4a8LoDYBoUkHEzoylvQq0D6wChbIR
	CNw0Egl5D4OO7C+peuxa1NvAO0HfWgTCJD/5kqtmO2IjfrbxkpPh5AFkgVacdXyjnns/EGMDlwd
	kT8GoqayHAzxWYCmH2ji6ADgHv9Of4sBRYV6dDY87VmEQpADgJsHhC19QdtKO2/MM4fnJ57HatI
	Blr1QSoy+D1WieG14iRGldogJqvbgt1DZ4taqCGkBCRL0LP3fLUjQEEm+r7NAYCksp6bLQBXlXn
	ECt/1X5Zg2bCowvToJ8/RCiA==
X-Received: by 2002:a05:600c:c16a:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-483201e1895mr68282065e9.9.1770456355313;
        Sat, 07 Feb 2026 01:25:55 -0800 (PST)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320736953sm101034545e9.15.2026.02.07.01.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 01:25:54 -0800 (PST)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org,
	robh@kernel.org,
	kuba@kernel.org,
	maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH v6 3/4] dt-bindings: net: ethernet-phy: add property enet-phy-pair-polarity
Date: Sat,  7 Feb 2026 10:25:38 +0100
Message-ID: <20260207092539.647768-3-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260207092539.647768-1-dam.dejean@gmail.com>
References: <20260207092539.647768-1-dam.dejean@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257748-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8315A10557E
X-Rspamd-Action: no action

Add the property enet-phy-pair-polarity to describe the polarity of the
PHY pairs. To ease PCB designs some manufacturers allow to wire the
pairs with a reverse polarity and provide a way to configure it.

The property 'enet-phy-pair-polarity' sets the polarity of each pair.
Bit 0 to 3 configure the polarity or pairs A to D, if set to 1 the
polarity is reversed for this pair.

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
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


