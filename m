Return-Path: <netdev+bounces-292020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKD6BOw+FmpMjwcAu9opvQ
	(envelope-from <netdev+bounces-292020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:46:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CA25DE089
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79644309649A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CACE2ED872;
	Wed, 27 May 2026 00:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="SlAcLmtA"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E91138490;
	Wed, 27 May 2026 00:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779842654; cv=none; b=an+AXWQ47Mhctzpt3f8KDN6tv4S5wR2bN1jAu9vRWBuvOOsWJZw7U/PtxvPuhijmU1fEVS6rVyoABVERHh7z6SGcrekHTZAffji356L/X0wa2UgX9Pdfy7aoTccMdqDbtwcnyxKbexjLg+6Lf/Ss9PQSPOsMi525y9NTtnzlCEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779842654; c=relaxed/simple;
	bh=2WblNysk4PkKOB6HlCqrAyJNtSqxyEmUUfXQ1XUxs10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bcsK0z/HzzlimfhXzoDblPzecNSabmKJ+K9fZHGjogd7X2kRYo/HLWI1CdwsWA3dqfEZbHmLyRiKPmxWcTai6nRjbr3XVEEg+/S3RW+gWqQo51svQYc/XlU9e9oCr6BPL5m7TL4c0aeB05Dqm+GyarWGPe2sPjCriDyhWeFgCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=SlAcLmtA; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64R0h2tJ030932
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 27 May 2026 01:43:54 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64R0h2tJ030932
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779842638; bh=UPQX5Vqp+5AaZnw7bA267nDtQyY5FzQq8U+3K/OiaWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SlAcLmtADgXHM/f2yfU01Y0oRfQ7TnPqRlha18Qzf4jikXR9Lv+4SC/E9NPXBlVK2
	 DmS+EOmyqSlzebvgF66VYqvnu/c0q3ozVHCayl8kCoWZrtmh3TJXupi/T2Rop78H2Z
	 wIzqrKa/vUZz7cNLulz191ilQXUDiBWeFN6ibztWv7yqSAiadYosceZAEBlv4HSWSM
	 XKdC0noVQGXfCD9wraQ/Z5oZ6rHsHwKhU3MchAweAk4vDv7FDyj4/60nDh6Fwryu6H
	 MdKS58l2uyvHoHVEva9jfdKadjbZibKS6vBVtqT2isolNhajXauTqcE6Kc3LybRA+w
	 6/LjzEaRzp/Cg==
From: Luke Howard <lukeh@padl.com>
To: netdev@vger.kernel.org
Cc: Luke Howard <lukeh@padl.com>, Kieran Tyrrell <kieran@sienda.com>,
        Max Hunter <max@huntershome.org>,
        Cedric Jehasse <cedric.jehasse@luminex.be>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 6/6] dt-bindings: net: dsa: mv88e6xxx: add mv88e6xxx-avb-mode property
Date: Wed, 27 May 2026 10:42:52 +1000
Message-ID: <f0a4fc5e6918040b2c9a72da46a8cdcb43ed5049.1779841530.git.lukeh@padl.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779841530.git.lukeh@padl.com>
References: <cover.1779841530.git.lukeh@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292020-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[padl.com,sienda.com,huntershome.org,luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[padl.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[padl.com:email,padl.com:mid,padl.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A5CA25DE089
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the vendor-specific marvell,mv88e6xxx-avb-mode property for adding
stricter handling of frames with non-AVB frame priorities and destination
addresses.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
 .../bindings/net/dsa/marvell,mv88e6xxx.yaml   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
index 19ae600e93394..1a01810e7682c 100644
--- a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
@@ -97,6 +97,32 @@ properties:
     required:
       - compatible
 
+  marvell,mv88e6xxx-avb-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Marvell MV88E6xxx switches that support Audio Video Bridging /
+      Time-Sensitive Networking (AVB/TSN) traffic prioritization can have
+      ports configured in one of several modes. These modes control the
+      handling of frames with non-AVB frame priorities and destination
+      addresses.
+    oneOf:
+      - description:
+          Standard Mode. Frames whose priority is mapped to an AVB
+          traffic class (TC) are considered AVB frames; other frames are
+          considered legacy (non-AVB).
+        const: 0
+      - description:
+          Enhanced Mode. Frames whose priority is mapped to an AVB TC
+          and for which a static FDB or MDB entry exists are considered
+          AVB frames. Frames with an AVB TC but no matching FDB or MDB
+          entry are dropped. AVB MDB entries can be added using the
+          MDB_FLAGS_STREAM_RESERVED netlink flag.
+        const: 1
+      - description:
+          Secure Mode. As Enhanced Mode, but the matching FDB or MDB
+          entry must also have the source port's bit set.
+        const: 2
+
 allOf:
   - $ref: dsa.yaml#/$defs/ethernet-ports
 
-- 
2.43.0


