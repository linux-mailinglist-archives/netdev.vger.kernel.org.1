Return-Path: <netdev+bounces-272257-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGI8EUegxWkZAQUAu9opvQ
	(envelope-from <netdev+bounces-272257-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:08:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B7A33BB03
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 802DA304AADD
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB75397686;
	Thu, 26 Mar 2026 21:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dP7nHqG/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rKXE8x68"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90313A5437;
	Thu, 26 Mar 2026 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774559248; cv=none; b=V1vyH9RhNPry3w53eJ4G31h+2nmoWXqshNUumW2jfmARDRPv3lI0ShZXq3FGU9mD+IjTY6vtfociVLZnun7P4GLAk1zCwsj/OCVCWp1RGndwg+6v4ftXPNJQMUt8jU9ciRRfeF00zfZcJrU8xiWgFlM2HHQicuOX46t9+WAA6UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774559248; c=relaxed/simple;
	bh=j/TYV0MBLWz60ydfp+4l2+4CXouOxBaIEDWnVD4hkG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqYW55Niutb/YVbzUCDtNxcN6N2C++QkdVgH5UBmiV86SySt4RyP8uo/qkMwdoWRbyJ365Rw7sYSbAnGjcGO1fRXktCFVcO/t1q5FvaNg6PdOfiUi5hy1sDu9ng0ZOfc/YO3i6vcAvy1BL6z5nYuuciVE+L+ATR1Is/86XuvmTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=dP7nHqG/; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rKXE8x68; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fhbvB6DTHz9vHb;
	Thu, 26 Mar 2026 22:07:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774559238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j063w22VGQUG9dhw3kIyqRXx1DH2/BF05+y09Ttl6lY=;
	b=dP7nHqG/KxWvtGCYPPlI41oJc7PtJhJYnikZ/crYU5+Cy0Is85ZFCJHFOt1fTgAQBSKoAd
	H3KIbV/uSADNHEdMnlUBkytleXMeEQyL84xfRp5LctlqENs4KmW04YsgEbjnqJgjsnbVUY
	zkzN17+YXmQh+d/qtjI+4Ds/Jryt3gR+A1swBDl7GtNmf8yooy/jnawoUurbi2gq2sK58z
	P4WvagC6LCP5eLqIZzXbc7ZildCxSXYd7iFX7CMQG3gkQByxQ7Sp3MXGCzH7JaTp9wkWJk
	WYsYeifFheUwqP2Vq+rvM+ORdCmkmJjrkkxElpkbm1VXx6qxPJ/4K67mKtHUfw==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774559237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j063w22VGQUG9dhw3kIyqRXx1DH2/BF05+y09Ttl6lY=;
	b=rKXE8x68rS/hMjlpLl6yzM7Zf2M7dQIRoZdQbUZGruurGyfgNpqC8fe8sZM+9PmmOcLyC0
	YzsOUDy8hFC+KCzTtUAm5BbDlr8Crkf8qS3iaQ6hBCfaNNEFcRESsIXFY8OH4BGM6Qnq8B
	Gk0X3aIu02+n/QoevfY+qDwcIhcNDIrCcv3GJrVu69kpEZh4XaihaxqHfqlzH+1mTpexAc
	E/Ib/79c6zYPEt5Zorqpi9cSnANVKFrpVkm33pHOfsVhr+fPX0IztXMWHiSONum8Iihpx8
	NRhcZsCwHQaTNizH9XDjCuhBVgSyNL/lnwIGoUxToiJodF8pcjm0rZTTJFw0Tw==
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
Subject: [net-next,PATCH v5 2/3] dt-bindings: net: realtek,rtl82xx: Document realtek,*-ssc-enable property
Date: Thu, 26 Mar 2026 22:06:34 +0100
Message-ID: <20260326210704.58912-2-marek.vasut@mailbox.org>
In-Reply-To: <20260326210704.58912-1-marek.vasut@mailbox.org>
References: <20260326210704.58912-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: db2ef41e5dff79f0b96
X-MBO-RS-META: tjj4w5j3f7qe5f3oic3efnw484q5diw9
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
	TAGGED_FROM(0.00)[bounces-272257-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: A0B7A33BB03
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


