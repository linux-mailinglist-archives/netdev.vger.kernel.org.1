Return-Path: <netdev+bounces-270239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JGzCA7ovmnIiwMAu9opvQ
	(envelope-from <netdev+bounces-270239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 19:48:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0832E6D8A
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 19:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19AE23004CBE
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 18:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64DA280CC1;
	Sat, 21 Mar 2026 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="G2IwYfno";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="N6BrGO39"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B63217A2EA;
	Sat, 21 Mar 2026 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774118920; cv=none; b=MoeaASL11WVak+pfecu1eayEzcr1U7xdW8tZPTyln51rCobwCl8zMkTGswsAOmMvylsRfL36GU6CcJ3/7tb5Df+zrE8njyzbtaPj4lrTPNuna2tfPQ8933kRcuMkGuVCYe+sInnLY7W7ONZwodREX8EY7I+trxmogck2QsKlBh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774118920; c=relaxed/simple;
	bh=BPfM2EEcXdMCBWPXY4opNhCJ7dRFzrmy12TRczvGSqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gj8DD0fBH7XfR8/EylabjpqSgv+ooQVuRUQeEx5WpThsDC9TInd9YuhQtl8uxK5EAvJYHf+1knLZ7NNvx2JovxrJ0UN7CvLbScd6+5EwQCTFHiCilbMZKcriAUW/dW4llzgjFRPVS49xBWuOatfYie8yniHeVNLFmwOivjXDc7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=G2IwYfno; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=N6BrGO39; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fdT3K4cTcz9tPF;
	Sat, 21 Mar 2026 19:48:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774118909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VnLXvXQn7ocYCs7HJcjTZhRgKFe+q+NcDGBfanDCb3o=;
	b=G2IwYfnojJ4+qcu+tubwdzKVyIDPFALSbUFx5iuUhyJFFPLeWpfjs7JwknF5Mur4IT8qsa
	pLPZDzvwD5wLw2ZqvvhB49dSkuSDGzsw9r5cQN8JFLGoSqsgLsaobYJVnCAJZeKcGDDoFJ
	pwkkDANPt7o+caAOv11B9kNDUgdjKk/DLcabIvdgXsUHEMnUuqURa/gf7ijwguRI2gAHGo
	EnCKSyC9xxvRRUW7SNJ3RNW6fYOlgUTWEc27J9eOhqEHR21UL0RskINGEKZG1VzF5eDB92
	3VVbh7KbIrMmheQaic8pbq+ooVxrRtfraJfiZztzaE5d8YAIBqJbjjIcn8fJmQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=N6BrGO39;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774118908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VnLXvXQn7ocYCs7HJcjTZhRgKFe+q+NcDGBfanDCb3o=;
	b=N6BrGO39TVcVXrVgXYqqhoAFNNgNK8y0s2knyEwofyCkd7HKrxOsjQfTEzqZ9ChMuXgRbq
	QB1NBoKcNaySpSsBFM13JbBSQkZj9qSB5VaYHb7Eo7VLt/LgVNVIpmW1U/CRI3GX4HPG+X
	o3sOTSSfrWo4gRzw8C0cxxAAZC3T7s3skwPoyoEydH5KT0WovY+oKXCPnPyQp40UV6q32U
	BXSlCi0crn+v9VBLoNJGozz5y9hEQjSH+BfVv7YxtBtm2johmTN9bG1wcRGrAMm/YL5QH9
	wuswFIaRDAlcTSdnpsc9wDt2LRrpzFigPl0b05J+3yT8Mgw0De7mUCWIxu6c9Q==
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
Subject: [net-next,PATCH v4 2/3] dt-bindings: net: realtek,rtl82xx: Document realtek,*-ssc-enable property
Date: Sat, 21 Mar 2026 19:47:42 +0100
Message-ID: <20260321184815.148485-2-marek.vasut@mailbox.org>
In-Reply-To: <20260321184815.148485-1-marek.vasut@mailbox.org>
References: <20260321184815.148485-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 89bca8b6fd44da4eabc
X-MBO-RS-META: ysqdocse3to796beecu98564gnjc6qby
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mailbox.org,oss.qualcomm.com,davemloft.net,wp.pl,lunn.ch,kernel.org,google.com,gmail.com,axis.com,fossekall.de,redhat.com,armlinux.org.uk,nxp.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-270239-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C0832E6D8A
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


