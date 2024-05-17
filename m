Return-Path: <netdev+bounces-96955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4A58C8675
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 14:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05BA7284255
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 12:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73D24EB3A;
	Fri, 17 May 2024 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=georgemail.de header.i=@georgemail.de header.b="jK/t/1aw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp052.goneo.de (smtp052.goneo.de [85.220.129.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8A47F9;
	Fri, 17 May 2024 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715949959; cv=none; b=YaZt3slf+ArBCpatoWWJgwXUDcY/77usMOU79CfqjAdfbzDq+YAxqKrLQPe8v1vl1T+sJdPtSojpJJAeIyFnZOsvSDoG9NBNPdxGYa0w3uRrFaGfpVJVQ5fKCszJk62u6r8cC8oaUBccq6I+rgi7E7UBA3qEDwf1K1AWFoW++qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715949959; c=relaxed/simple;
	bh=Kjen7XIcV2/xQdQ5aWzsH2RWYIfb4iCHsMh5Y5WxIS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmRPZH1qS6WCJykLdfdbZv/2VXE6rWrTe7fQ0wFBHyMjPDXk3z8ji6+NyTIy9kQiFiiY2IcloP3HOsX6pP1uDQzBYhSTXQSYT4K0O53SLJ6C/V25F2/4s8KkXQQGXBPykJ4qwG9S2YHwCjU4vV0c2JwVilzd2yJYHkwjcCNukVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=georgemail.de; spf=pass smtp.mailfrom=georgemail.de; dkim=pass (2048-bit key) header.d=georgemail.de header.i=@georgemail.de header.b=jK/t/1aw; arc=none smtp.client-ip=85.220.129.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=georgemail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=georgemail.de
Received: from hub2.goneo.de (hub2.goneo.de [85.220.129.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp5.goneo.de (Postfix) with ESMTPS id BD6A6240E0C;
	Fri, 17 May 2024 14:39:19 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 1768F240537;
	Fri, 17 May 2024 14:39:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=georgemail.de;
	s=DKIM001; t=1715949558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W6BZGlP1L7RdP7/xUvHw5XeXZ+uCdJEAW184lQuzOHs=;
	b=jK/t/1awh0nUx/oxAzwOjhPMuUri/dx3ruROKgYtPxYfP2OijZV4t0QuBiWaoZlSSl/ltf
	M3EC3WCRkRFZimHVLXgMPp29BwRccLiqDuHB7U/eQ4ZzTvCVogle8Mj1Wb0KNAhFs2v/kr
	g0SmKI997rXptBj4EuRNsrzZkbSIVko/Qi/Mq/vf+lEtEVQRIs/1JGZrKXwDhi62ZHP6Uv
	YxIK5z2WwhmVPzjeGK9RPWWyjvKc5C7YD2e39nQz7fcZknKrOrRLdVrUBBuG4fPEJ2AkAy
	ZYN0/CwYsmx8zc88JGHYxrDvxgDysN902qpT3Wt+fiAPgp7IKX/Ievdam9eKuQ==
Received: from couch-potassium.fritz.box (unknown [IPv6:2a02:8071:5250:1240:f4e6:f6d2:6d95:e0c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id CA8B02404C8;
	Fri, 17 May 2024 14:39:17 +0200 (CEST)
From: "Leon M. Busch-George" <leon@georgemail.de>
To: linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 2/2] dt-bindings: net: add option to ignore local-mac-address
Date: Fri, 17 May 2024 14:39:08 +0200
Message-ID: <20240517123909.680686-2-leon@georgemail.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240517123909.680686-1-leon@georgemail.de>
References: <20240517123909.680686-1-leon@georgemail.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 3b0747
X-Rspamd-UID: 92074e

From: "Leon M. Busch-George" <leon@georgemail.eu>

Add the option 'ignore-local-mac-address' to allow ignoring bogus
addresses. This restores the ability to correctly set the MAC address from
the device tree if a boot program stores a randomly generated address in
'local-mac-address'.

Signed-off-by: Leon M. Busch-George <leon@georgemail.eu>
---
 .../devicetree/bindings/net/ethernet-controller.yaml        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index b2785b03139f..67b8437febdf 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -23,6 +23,12 @@ properties:
     minItems: 6
     maxItems: 6
 
+  ignore-local-mac-address:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates that 'local-mac-address' is to be ignored. This can
+      be useful when the boot program stores a bogus address.
+
   mac-address:
     description:
       Specifies the MAC address that was last used by the boot
-- 
2.44.0


