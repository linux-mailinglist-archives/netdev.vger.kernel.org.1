Return-Path: <netdev+bounces-245964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C279ACDC388
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 13:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F32430215F6
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 12:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC2E3385A5;
	Wed, 24 Dec 2025 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="xCK4Vx60"
X-Original-To: netdev@vger.kernel.org
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560C4337B8F
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766579564; cv=pass; b=D0cud+HYyIvAbwxkDpHbeRPwQv/yI9L/eLfMsRkdyYR74bkB2CrQII62/fyNSAJV7pPultl7cm30L6eNHrP1qHu1vrRWQAeCHQyGn1oYD6sZDjsfm8oMCautB9kT2heJUW5qBhYWQrW8lHRQ511aITUgqDaKBNyy1xIN3ICGIgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766579564; c=relaxed/simple;
	bh=XZCMf9+zlQSN3i2IDz9nD93cqF30ihYzs64tM/EBToY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bx/4G7G8GfRPA9vmhev9eGadQ1BXAZEVowTuaAajsN19QDsizE9w95AnRrn1rwojEHOnvIFCaONpEHUvMEAdDpvHMknAp2KHBjNRRkrARpPGnWT5fmvC1tH1ONCTBoi7agf6uT8lF5SAmmJCR6LL+HUVIF7ZzvqZNDSSDJOnSlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=xCK4Vx60; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (bc043154.ppp.asahi-net.or.jp [222.228.43.154])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5BOCWcdF056253
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 24 Dec 2025 21:32:39 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 73DA8109D6C01;
	Wed, 24 Dec 2025 21:32:38 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ERKJ59vE7ZLY; Wed, 24 Dec 2025 21:32:33 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id C3176109D6CBD; Wed, 24 Dec 2025 21:32:33 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1766579553;
	cv=none; b=OxSRKFAaLf6JaN+349qZau1bIA8hLSlOzpS8V6fMnVPoLt+/4lK/j1+mP6z3UOWAiRKTSD1wZLG2gQP/8fVIsF8yZeDZwWRKCR9DCxAxIfIkHnMOF9JKw3m/9ccSUdsyAeWwqj6D3ZOb2t4RbwNoyC8BcgpVXWU4rdjYztQaO50=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1766579553; c=relaxed/relaxed;
	bh=9U2+TTbc7OJ3aq/8n2VxRzkLlrPvLooA3cqdgMpvEMA=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=MZwYWTCsJozrglKStN+4xlqBwA8h7OMlFj5trpZZfHbS+SbKdjJ6tD7Y1OESoFz0sUIX8Lnq2akVzTdXmLKUuia4i3wiHa0Fokql0zAAGqX0hfrG280s1/iWHtngX6UXViZhxdWojcCvrHeR6BqPgqYMTH+Vm9BbPxll17qEVlU=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org C3176109D6CBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1766579553;
	bh=9U2+TTbc7OJ3aq/8n2VxRzkLlrPvLooA3cqdgMpvEMA=;
	h=From:To:Cc:Subject:Date:From;
	b=xCK4Vx60n8C1BuDWOYEnofA/LNd81d3G1hU3SVMDneRsS2IkckPTld3VcsfBS9KvZ
	 HCN9NoFZzgVwzPnMELlTAy2euR1u8Cuuz+mTyrA9/TDi8Nf2AcPG6KReo9Aop30xPJ
	 9zqizA8kusmwgwjUoRuRj9RvhxvOlRyRGAPOWPxM=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] dt-bindings: net: dsa: marvell,mv88e6xxx: fix typo
Date: Wed, 24 Dec 2025 21:32:30 +0900
Message-ID: <20251224123230.2875178-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix a typo in the interrupt-cells description ("alway" -> "always").

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 .../devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.ya=
ml b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
index 19f15bdd1c97..19ae600e9339 100644
--- a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
@@ -72,7 +72,7 @@ properties:
=20
   '#interrupt-cells':
     description: The internal interrupt controller only supports triggering
-      on active high level interrupts so the second cell must alway be set=
 to
+      on active high level interrupts so the second cell must always be se=
t to
       IRQ_TYPE_LEVEL_HIGH.
     const: 2
=20
--=20
2.47.3


