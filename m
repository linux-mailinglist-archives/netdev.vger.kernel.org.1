Return-Path: <netdev+bounces-105711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAA4912647
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 15:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF961C25657
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62867158D82;
	Fri, 21 Jun 2024 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SwyOJWIy"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E528156675;
	Fri, 21 Jun 2024 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718974871; cv=none; b=EviaBB7mg4vKIzPBRFsShxnE5Z1vS1o4jedGSXfdjWxm+Hz/A/tejiHE+OLix1iRgLU8OqNw7FoKJSWEkB9ux5qvsgyYDz3AgVwdh7zmxp4kqpuS+lP6thzs5SvoZakiAaJdNicKWAIA79qxL86Rds7UI2ut19Tu6fAT8NaODho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718974871; c=relaxed/simple;
	bh=DivwwDalS9XSi6C+Pb7Pl0M5dldZfkKIe329gjGE23s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ehRwrfuhMVfU7m6cX5KO0hFKyGKpQRrnQnqpzB5qPPCSRcoIXWia0Bv2DogxSs/ZUrSb/+EcgzWucuPN21dPlLOAaCXtZXa99VYIX/aHIMJGB71T8Ali/AzLyOOiOH2WfPQRmKkaw1wIObykEg2ozi2a96bi5Na5mdbs+VOPQjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SwyOJWIy; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D5A171BF208;
	Fri, 21 Jun 2024 13:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718974865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JKBsx/vZr3c1Dk+2ljEwKIlxwbOaxR4usnVKt0CKk70=;
	b=SwyOJWIyQP0ivTGXPSGy3ugNE23qswHSOBJiXRSLdlZm5lOnk4Mf0X8wPIzdkpPXr7A/pa
	HWqh7dB6byidsg8ZR1HAgvYb1SfzkmEbwnytPnhVXEuTPwEQyKu24H16YBikLZzB47e7y9
	VhHd2L0DrK4pkGvjGOMDhh/FIb94NU0vnTpo2SgNsNzQXvkoqN8LvCUZXW2Y/plUErMang
	Wdrt0TjVNrLSt6ZMo8EMIusIOXK5Zd2oBmqvV6oIZii8eP+YEb7TrlPWHVfngX5WDp5h9z
	qw2UagBKwmkEoa95UTcC5QpuEXGBQw3pPy1a8hBGPJd1Pq0ss+nj9NdTnMbJ8w==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	thomas.petazzoni@bootlin.com,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] netlink: specs: Fix pse-set command attributes
Date: Fri, 21 Jun 2024 15:00:59 +0200
Message-Id: <20240621130059.2147307-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

Not all PSE attributes are used for the pse-set netlink command.
Select only the ones used by ethtool.

Fixes: f8586411e40e ("netlink: specs: Expand the pse netlink command with PoE interface")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 Documentation/netlink/specs/ethtool.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 00dc61358be8..4510e8d1adcb 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -1603,7 +1603,7 @@ operations:
           attributes:
             - header
         reply:
-          attributes: &pse
+          attributes:
             - header
             - podl-pse-admin-state
             - podl-pse-admin-control
@@ -1620,7 +1620,10 @@ operations:
 
       do:
         request:
-          attributes: *pse
+          attributes:
+            - header
+            - podl-pse-admin-control
+            - c33-pse-admin-control
     -
       name: rss-get
       doc: Get RSS params.
-- 
2.34.1


