Return-Path: <netdev+bounces-256827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH1HCaW7g2kgtwMAu9opvQ
	(envelope-from <netdev+bounces-256827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 22:35:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3FDECC07
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 22:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15A713004C7D
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 21:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE942395253;
	Wed,  4 Feb 2026 21:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ2G+5tp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8F3394476
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 21:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770240929; cv=none; b=C+JgZ9nIWv9LYsADMiGxhBL5S6Re9/272Dbe1MUtCWxLxO+xKRJPNUGnWODuNPjyQZzG/NpG4SAeOtTNnrvk+jAjY88yoA96d6S5WTj/6x/WbbDC7CwoRT2dlk1jgkZB29M27sPuNL1deQryfhvu+m8C/53ZSRkt73VAq0AdhYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770240929; c=relaxed/simple;
	bh=/uXzpBkZvVH/CVh+0y+pkNOin2JA9iRNlmldoLBo3UE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vGejFgEseOMdoMuGq31oC7RlwkZluHPySxyaHsMp8ekrw0JXNQWhLY0D2YokjZxee6bWHzKioV7tfFIuuY3BPKma7nIXI/pHSe6qEZ6dgViGAGMtnXXABEL/xuz1buQ95EwtD0UAEy4gRBGcFe7i1KIc878aKepd9xzfXaDFu6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQ2G+5tp; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-65941c07e8dso446188a12.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 13:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770240928; x=1770845728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rSgRM+hXY45JfIAA1cA873q4K0bzGufihgURNC0AChQ=;
        b=aQ2G+5tpPXhMJEDc4Hbc0mwvkHitA5CQDEZmpSNEN8W/Pwq77UfgPD14jmkr3FMDjC
         JbTu5Tru2SpiZSbwCLisCqELFFvQY0PyOILvAuVUYZdLhU0ODL0QQDlUunEfdLaTGHhE
         lIiecsIxjsVnyEvqbdW9MQqVJWsadmTYzZoTHbNmSTRv2KztwSgh6sG9dxd4u+GmVisw
         I88bNuRB2ebTgD7CtFW98oV69qamxtA9IaJmlyAcfEbJ6sWVkYOabtUBLA5h3LaiDAmG
         gLtJdx4j611+BKRRAkoGstg/r3RqAWHgxPMjyW1NC9q0QKzuz7IjUKeoWbLXoTLbIe7I
         lj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770240928; x=1770845728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSgRM+hXY45JfIAA1cA873q4K0bzGufihgURNC0AChQ=;
        b=CgUITihCNyFYbX761HeL6dYKMld5kRnDY63tAKAqSX1MCQREM+peEpK1yPu9MTewcV
         U/4YwBtgbc8F+HW4v4hcQx4JfUdDSgovaxg6r45U7WLPlkDzxhEA3lEtyqtkGHbdilxo
         XGD3niPBa0Ra6rGm7htxWummcB3FG51ZdJSufTgaGZuaMScLEdz/WfDw9i6+cEKwiv3w
         Kcpv+0I3g8A+Wz3IueM8WMttWWPVcrRrG/A9NquZZJ46oJ8ZNYYIcVYTIV2hDpWe3JGr
         T18Oc9O9F16vtQ0Yuo8ud3W4XRKf36Ohvr/QlXTBcQwEk5MaOlqXrzT/lFUHTSmG0h1s
         jk/A==
X-Forwarded-Encrypted: i=1; AJvYcCX5tDyBgASZYfoNaHky6tU/G0UQpqY11mY1iOi2DeayuXaL28LED2uIJpSvMppTV5cR1Lf8jPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZHdQHmgqrL7ciUwWxTDBzcKmaRfHkemQAeEHDi1ZwFIYQKhHT
	0V55f28SEPUbEaD/eQqz5ExNS0PxXrd+XqxuRY0ecCbumg2sa9HZbomj
X-Gm-Gg: AZuq6aKHoMimarG9fHYR5OHt2g661D/6JtszK9U8NEyqkxuHb7il3LNlkwu0dgwswwf
	q9Ar49lSRngear0jU87YrSubCZm6fCtdMxf3PJkX0GW5DWVDFzTHy/AmVtzzVv6YqOW206JgCo/
	k6u58+YbxJUDnI55MpuaxsclQK/r6D8aY6pLNAHRyCziltfJi97LX4gNxmvVDB8Gxtnh4/hvTP6
	YAFGXL6D4HsTgusLhRLcflSW2FaUCQvXoOzTsCzUWcVNK3ggSrj2S3BJIVp3aEafTU1fJIicL6U
	LoiN4ewMdSlx+jIn4DbI2IbrDtS+8LR1NSWoxIvAsmDLheTMvbODcAD9A/5a8/fcan8RmYjll6S
	UQjSUVX8rhEYVTVSJv55bL5mcuZmOnS9OgQpGP18IESNDf721a7CjZDu8Wa6Ly6qK7OlUI8sEIC
	C6mt0hwfif7g9750TwKT8VAMGimuIiFDFY7LU=
X-Received: by 2002:a17:906:f589:b0:b87:a0df:2f98 with SMTP id a640c23a62f3a-b8e9f3b7625mr273262966b.63.1770240927584;
        Wed, 04 Feb 2026 13:35:27 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:27b8:773c:f9e3:1dde])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8ea00435fdsm155454266b.57.2026.02.04.13.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 13:35:27 -0800 (PST)
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
	Biju Das <biju.das.au@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next v2] dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L RMII{tx, rx} clocks
Date: Wed,  4 Feb 2026 21:35:21 +0000
Message-ID: <20260204213524.3437-1-biju.das.jz@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256827-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bp.renesas.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,glider.be,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[bp.renesas.com,vger.kernel.org,gmail.com,microchip.com];
	FROM_NEQ_ENVFROM(0.00)[bijudasau@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email,bp.renesas.com:mid,renesas.com:email]
X-Rspamd-Queue-Id: 7F3FDECC07
X-Rspamd-Action: no action

From: Biju Das <biju.das.jz@bp.renesas.com>

As per the RZ/G3L Hardware manual, CPG_CLKON_ETH register bits{12,13} are
to control the RMII{tx, rx} clocks. Document the RMII{tx, rx} clocks for
RZ/G3L SoC.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Fixes: 3ac2aa31b489eb4e ("dt-bindings: net: renesas,rzv2h-gbeth: Document Renesas RZ/G3L SoC")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Collected tag
 * Added Fixes tag
 * Fixed typo {tx.rx}->{tx, rx} in commit description.
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


