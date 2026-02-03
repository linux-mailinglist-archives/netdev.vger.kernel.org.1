Return-Path: <netdev+bounces-256246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B6QIBDSgWl1JwMAu9opvQ
	(envelope-from <netdev+bounces-256246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:46:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADBAD7ECF
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A889930432DD
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 10:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B110D31ED63;
	Tue,  3 Feb 2026 10:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3xECGcF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232FA2D5C7A
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770115547; cv=none; b=POP1lGWZJ44BkHs3MK1NINtzsbaEAr9WOGCKW5bv4gpnPzi0WA0b6wBcJQXyjA0jWiI56byeBmpTAGdjnvgZ6psUQSMKEmj5z/5Pazwp09os1Tyhh2o+UPlFFf1CyV+VGJMyXC+O+21KLnx+yNYSWolTIRYSA9fc734Q47bJWlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770115547; c=relaxed/simple;
	bh=zsphaFUwrIMo+pf0TuXkBfQPvCURjbSZqfmjuT5IT4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DDQg1nvpdjZPeVBSNsmBiW1Q02dWNQNM78YBbe/1/P3MQYFplfDMOLcndlzBaGrvkFEwRx0n1I2g4BCCniMvxol9jxUL8QV1jD86IuPv9QUmiaED2fOH2abEdJX5TlvzGB6EZgqU+vuG4KIC54VaOBLYY3T5AXsAt86jRMPvZMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3xECGcF; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-48069a48629so56570865e9.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 02:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770115544; x=1770720344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3pjjTKOk0euh5gASu/21SEOkboYtVXo/rQHyHB6vLHE=;
        b=K3xECGcFtQIlQ2dgUF4Gi9SK/20rSsb84EMVhbCL8kdqXnfG/IEmWus4SpXifRokId
         WrzzUIGvxmYNcWC8DlBnEnizdvnJnvtMNdxmPRUeiSoSX6kTZ+q+1ql0Z682mSOqUrDT
         N1REgcgoMRISNCBz2Ku5+OdQAoOaMaOQtMlRKJwH6ZSeZy1PTmTpNC1TUGM7icfTME/m
         yUfeRHOxcyZy9WUb2H1pMYtj+uz8nMyzgt5HaH16q/P/jo9K+F+wzF3IYJ19uB+QC2uF
         XPjbK/VS/iHvWhuIjr5HMF8HHpXxZgf3FWmZKnLVOsiwUn6KuGdotiq8gtefOWiWuV6y
         pcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770115544; x=1770720344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pjjTKOk0euh5gASu/21SEOkboYtVXo/rQHyHB6vLHE=;
        b=OlemhIXSbZZRYwGFe3cJ6/lcC41yUI2VGGq4fNsXVuOlmTS4NAjgDjKhSa832s3hAI
         HZufUy2jmH9zBIyFBb2PcO96f7bHGSM910dHRsoalpKtfVaJJMmOmVZU7053YZhHit2q
         2qWP/yHw6KSQf2Uv6RUW/sAn1/sE296R4JhCAx9gRzeeoHwKK706v3SrA4de6r0C3Cf4
         kbVB9k8usRJfsr7DQNW3fvUY2IndoxQbSXsup0kkd0ZcWuWcZyFA8lkg65jY+ZpAoPgr
         G9XCPOOrTCHScpEdE8BKPjHh4yMWNpmmdPzUtVwQvTiylW72X+tQtPfXSp7bY+WTNwXu
         EaTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmd4w6uxLdZ7lpzVBPumJ4eJ3TybYYGaLrALOsCu8v9C1ofRgeUGbaiiAgUAk/hUVrvJ9x0zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeOQTsMWkQxbQZVLaTnCji/H5gkvREhJ3MD/2Um19TxdIcQXOP
	Vvl399D3A+nVf31gR6evGadOvjZFc94zU4/G0vFdfHsdHttj5gmvmGeF
X-Gm-Gg: AZuq6aKqmtm6y90jrWbVcZ12GyGCemneNcf8BSj4AssFpE86dXTscaNdtvuIbDEQ8Pd
	6zq8aC1cmEoaT5vl7cLfROir95IFO9B3NDMjKbpoAc2EAsdO0+qjouhSoBPDLt/RHvRxAQdJLaE
	aLEKt9yAZk/ojiCu+PuubN4fYsvn52WfY4JZBE7/cK6DAKNpbve/f2dm1RKYjjapQMjfRKhLB11
	hDZfkdoY4iWsw1FpxPJfBYcxWOzhTJCyjAbh+zGAtjZVGf+ibyEWR/5M/9JMee3AsHWHVM0nHfg
	08Fa5UEl5SQWrFQmDfI/cwrxtWga8UXsah6oYCnjZawO+RRC0LKiROvkbPiu7qGnFFGg1epKXp9
	DoXcBLEZ4+LWA3yQdDqL19O4WhHZKl+K5OIPcirSSKjhT4ocKV7K4bakLdlZ1XHbeidOreBro0M
	Y3Nv9sLORk5bTmZikJNaOlvI529aLc
X-Received: by 2002:a05:600c:c4a5:b0:480:6941:d38c with SMTP id 5b1f17b1804b1-482db492393mr191878015e9.29.1770115544341;
        Tue, 03 Feb 2026 02:45:44 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:9cd9:f748:166d:55fc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830512ddd0sm56554995e9.9.2026.02.03.02.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:45:43 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH net-next] dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L RMII{tx,rx} clocks
Date: Tue,  3 Feb 2026 10:45:38 +0000
Message-ID: <20260203104541.264759-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256246-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bp.renesas.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,glider.be,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bp.renesas.com:mid,renesas.com:email]
X-Rspamd-Queue-Id: 2ADBAD7ECF
X-Rspamd-Action: no action

From: Biju Das <biju.das.jz@bp.renesas.com>

As per the RZ/G3L Hardware manual, CPG_CLKON_ETH register bits{12,13} are
to control the RMII{tx, rx} clocks. Document the rmii{tx.rx} clocks for
RZ/G3L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../devicetree/bindings/net/renesas,rzv2h-gbeth.yaml      | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml b/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
index fb60f745a1ff..2125b5ddf73d 100644
--- a/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,rzv2h-gbeth.yaml
@@ -58,6 +58,8 @@ properties:
           - description: TX clock phase-shifted by 180 degrees
           - description: RX clock phase-shifted by 180 degrees
           - description: RMII clock
+          - description: RMII TX clock
+          - description: RMII RX clock
 
         minItems: 7
 
@@ -77,6 +79,8 @@ properties:
           - const: tx-180
           - const: rx-180
           - const: rmii
+          - const: rmii_tx
+          - const: rmii_rx
 
         minItems: 7
 
@@ -170,10 +174,10 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 8
+          minItems: 10
 
         clock-names:
-          minItems: 8
+          minItems: 10
 
         interrupts:
           minItems: 15
-- 
2.43.0


