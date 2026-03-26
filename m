Return-Path: <netdev+bounces-272255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN36BiOgxWkZAQUAu9opvQ
	(envelope-from <netdev+bounces-272255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:07:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF0933BAFC
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1829301A926
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AA8388385;
	Thu, 26 Mar 2026 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="agn9IsYN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Hwv2qC5j"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CB134D4DC;
	Thu, 26 Mar 2026 21:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774559239; cv=none; b=D8/jPFSxvZyWWIQBioA/26SnTZKMXAcH0LIVm9+AwczGUplt1GGiyNVIFsiwyvER6E8F5pfyybPY/d0aU9iXxMYgnIJqNy8rGPQiM/kW+w5LjVtaMlYQV7Sd8Emzum6J5ACnvoxf2fCBpDNd8nCUzi2guctY/3cDUvb1VNzdOZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774559239; c=relaxed/simple;
	bh=+iXfULE7NME89vmKqT0uxglqS0A5EV0SfGCvta1DSM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/biVkU2JzW0WrmidvX/1Pis+TZtBa1TFV4gnM2D6SOt0bYS/kQxWk3RHpj3g7gi3hv6GiVKomwCBNFWPWati3fTC1M8R9XjgtQCWqlYfnZj3OgTNjIAsNbI9bke/GEO1CdbnaBHDKK6WM83Z9SEy1JvSoiNQ7riFYvpCosfluE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=agn9IsYN; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Hwv2qC5j; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fhbv70WTXz9tfP;
	Thu, 26 Mar 2026 22:07:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774559235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EKiyxni9aMD5eJ/gA6rUc2BWYV+YLF016wTLlDwFNfI=;
	b=agn9IsYNToG0ek4rOcDB9Oxh3GUEJz8WuKHG0B+awkCvnkVwuBGjOb3HO9Hd4Jm8Sl3P7C
	xnhxog9b0Ne6rfNFHJx8vI5EkUUQ/QskvYILCE2HjR8bNf9c3Fk6fKzUrWamfEtPkwXdiR
	uhiwtPcRot6h17f9hyv8219zSzz9QQ84DD3Bv8zPcJesKdf5V5EeN2OrD/Sou6vLVt6faa
	uUYfw8xN8A9XdpIDe+N7ua1Ym21dXhQORvj0sMyLJVGYhqK2MFwACOik/pHROorfYIKsaY
	CEXcK5oK9oyYrmDqLGLJuTzW/TNiNq/yx+PBh2ST1Fpb0tsJidz2lT4fqzF6og==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774559233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EKiyxni9aMD5eJ/gA6rUc2BWYV+YLF016wTLlDwFNfI=;
	b=Hwv2qC5jmI93hM2VjYkzgbrVE1N6uRlblxlbYZ1+OpwL0e/x5n3tXHpw01eRmyPkk9efCn
	qw1fgjlZhp6wpodMeSX6tp1Aoi3lnzaF3Jy0rnTw+8rBNMm2Q04NqMT4JAcrgc0DOHe0Hi
	KpRPG79B6zj8vPJqzha1jY6MqHL2O4hpOljIi0/bQO+U+PzntuOILyPxPJlYl8/VIT9z7j
	rF1woaGzrbOmu5FB93kuX4YRtNGkvT1o88mvFGO3zldK1nY3PdqAaqd/g/P/CBEW6A4iAz
	CoHiblR63JP3XvT47Xe60jfux/ukkvwBK9xvq5MQisDlCqN+a3uqvNhaw/13RQ==
To: netdev@vger.kernel.org
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
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
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	devicetree@vger.kernel.org
Subject: [net-next,PATCH v5 1/3] dt-bindings: net: realtek,rtl82xx: Keep property list sorted
Date: Thu, 26 Mar 2026 22:06:33 +0100
Message-ID: <20260326210704.58912-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4db2c77216745c646a7
X-MBO-RS-META: hs6siq3djo7jyg7or65xwjsw5yn53rzt
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
	FREEMAIL_CC(0.00)[mailbox.org,kernel.org,davemloft.net,wp.pl,lunn.ch,google.com,gmail.com,axis.com,fossekall.de,redhat.com,armlinux.org.uk,nxp.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-272255-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 6BF0933BAFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sort the documented properties alphabetically, no functional change.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
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
V2: No change
V3: No change
V4: Add AB from Rob
V5: No change
---
 .../devicetree/bindings/net/realtek,rtl82xx.yaml          | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
index 2b5697bd7c5df..eafcc2f3e3d66 100644
--- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
@@ -40,15 +40,15 @@ properties:
 
   leds: true
 
-  realtek,clkout-disable:
+  realtek,aldps-enable:
     type: boolean
     description:
-      Disable CLKOUT clock, CLKOUT clock default is enabled after hardware reset.
+      Enable ALDPS mode, ALDPS mode default is disabled after hardware reset.
 
-  realtek,aldps-enable:
+  realtek,clkout-disable:
     type: boolean
     description:
-      Enable ALDPS mode, ALDPS mode default is disabled after hardware reset.
+      Disable CLKOUT clock, CLKOUT clock default is enabled after hardware reset.
 
   wakeup-source:
     type: boolean
-- 
2.53.0


