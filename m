Return-Path: <netdev+bounces-275495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGaAE6nw0mm5cQcAu9opvQ
	(envelope-from <netdev+bounces-275495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 01:30:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ED43A038A
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 01:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6219B300D97C
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 23:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1892F385514;
	Sun,  5 Apr 2026 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CAdlEL5e";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="W1/iIfAg"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AF3385517;
	Sun,  5 Apr 2026 23:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775431828; cv=none; b=AozRoULkxudfgYjNtzAwYMR9o/hKBOu1bcN87hIKCXsynMY/zy2OxdFUt5G6aSjDKJbdMhQ5P5Imud+loTA1TwzJg9nLXrLRtlksWhMtQKWOyrHIAXqko3h7itqZsLvGWSoWqRunah0T1NUeKKXwDwTWvac2JaBDMF+mFdEShIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775431828; c=relaxed/simple;
	bh=LZTi931XSmTuonHqohM2D1r+oD3qveQ6s/3eHG6nNQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnP7RhkZIoSoKvqH8BwN2UFtcDp11fdLUk2vbMjGjA9SaVHus/fF32wBSk+Y5SPo2gCJ/+BmKVOMuD4Ulj5spvIjrND/mfVvq+NihguP/xnhyv+NZpm5cF76aZaqyyJvT8pKQj13O69l0FG0Lss9MWre7CAVgIKlqdlK01uJl6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=CAdlEL5e; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=W1/iIfAg; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fppbg4bhNz9slL;
	Mon,  6 Apr 2026 01:30:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775431823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6C45U57v4v1geRbpvFxOLqprtKZM/a8CDVjdN4mUmF8=;
	b=CAdlEL5e6f7VXcUFD015akhlPfJMiInpjAc+Lfwf7hNaUOGGxhuC8XDKMF3dtSQ4Hl20m1
	erX12+O5+meBc0fjznN8Oo4ypDzNdq/ow7rCZa78G0xHeiaM26Wia1t/vUOt7rQqMExe0r
	/t0iGLCAvxQ/8Zls9F68pQ0Viakcz9DT5X1OkzFa//TIPR/ffXYjcKVawqfVf2yOT3oRld
	LfCmLFFC/pnlE6WKRuDas1YP/fLaVckwwjvKy9MnndayX73rVXyZv/leJsUOhN6o/B5iO+
	nMdkF7rLJoqAdbMMWCQOQpYXW7HlX6q3xiJbj3sbh8fSzG6sZY4OzoGjnfOuwQ==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775431822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6C45U57v4v1geRbpvFxOLqprtKZM/a8CDVjdN4mUmF8=;
	b=W1/iIfAgwWWYiy+Vy5RXiu1AZHnXjGkE+hs3KMmIjEd/ZQ9zQV4RsNQBa6xwXiMA8MCUWx
	7zPIebI/Slf6BsR1ulwphZTDLid/h4YP3UWOGyPQROmhDmk2B8bGCCvA5X7KRm/W/bbANN
	Ie/ieiaOacgdPJrGh0ufjYcOhcqPhDczkBnDVCXqQUmxDkl5GFC6K1ixB1PI4yMXoO55EV
	QEOJ5iWSYJuM80ReQpMyO8cnJBNs1SQnK1C2mbcp32yajAgGZZbsU37JlP5tx7g8kdQbv0
	noQs4b/DiYrBIaSSIbnj+WN4+iho6z42zQFy7/HwXEpot3NJgGpmqHdRJ9pWQw==
To: netdev@vger.kernel.org
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Andrew Lunn <andrew@lunn.ch>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Ivan Galkin <ivan.galkin@axis.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Klein <michael@fossekall.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	devicetree@vger.kernel.org
Subject: [net-next,PATCH v6 2/3] dt-bindings: net: realtek,rtl82xx: Document realtek,*-ssc-enable property
Date: Mon,  6 Apr 2026 01:29:57 +0200
Message-ID: <20260405233008.148974-2-marek.vasut@mailbox.org>
In-Reply-To: <20260405233008.148974-1-marek.vasut@mailbox.org>
References: <20260405233008.148974-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: nwxe5ags7k58rwb1xo8xd853tx5pwitd
X-MBO-RS-ID: 60249f029d4d3732a8a
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mailbox.org,oss.qualcomm.com,davemloft.net,wp.pl,lunn.ch,kernel.org,google.com,gmail.com,axis.com,fossekall.de,redhat.com,armlinux.org.uk,nxp.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-275495-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marek.vasut@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5ED43A038A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Document support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-CG,
RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. Introduce DT properties
'realtek,clkout-ssc-enable', 'realtek,rxc-ssc-enable' and
'realtek,sysclk-ssc-enable' which control CLKOUT, RXC and SYSCLK
SSC spread spectrum clocking enablement on these signals. These
clock are not exposed via the clock API, therefore assigned-clock-sscs
property does not apply.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ivan Galkin <ivan.galkin@axis.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Michael Klein <michael@fossekall.de>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: netdev@vger.kernel.org
---
V2: Split SSC clock control for each CLKOUT, RXC, SYSCLK signal
V3: - Add RB from krzk
    - Update commit subject, use realtek,*-ssc-enable to be accurate
V4: No change
V5: No change
V6: No change
---
 .../devicetree/bindings/net/realtek,rtl82xx.yaml  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
index eafcc2f3e3d66..45033c31a2d51 100644
--- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
@@ -50,6 +50,21 @@ properties:
     description:
       Disable CLKOUT clock, CLKOUT clock default is enabled after hardware reset.
 
+  realtek,clkout-ssc-enable:
+    type: boolean
+    description:
+      Enable CLKOUT SSC mode, CLKOUT SSC mode default is disabled after hardware reset.
+
+  realtek,rxc-ssc-enable:
+    type: boolean
+    description:
+      Enable RXC SSC mode, RXC SSC mode default is disabled after hardware reset.
+
+  realtek,sysclk-ssc-enable:
+    type: boolean
+    description:
+      Enable SYSCLK SSC mode, SYSCLK SSC mode default is disabled after hardware reset.
+
   wakeup-source:
     type: boolean
     description:
-- 
2.53.0


