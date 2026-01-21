Return-Path: <netdev+bounces-251953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BQHILDzcGmgbAAAu9opvQ
	(envelope-from <netdev+bounces-251953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:41:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0E3595CE
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B44676548D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F2E41C316;
	Wed, 21 Jan 2026 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AleF6Kuh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62B93446A5
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769008520; cv=none; b=vE12UjLUy5N4/dAgH3YUV93HiBm3oPvAeJGWzKKiAhbZAwZp8HoYxmnUhTWZRHbk+daECA+fBUZvhmhjrrvpX94SXvk31M7IqsoyyB9JCkpfLXl/8gGpjtKlyYpUasCw07qZslxwkxIeJOSKh9NsXr1VfEqdYeifjyrVYhR+GHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769008520; c=relaxed/simple;
	bh=FTEwGErBLHqKunY94YRfmnEFJcgED1VQR5css/VjSvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIVtKy73eJgsjyD8S6zcxENtL/JU+FgAEQ64TugQN+HvnAv+Bucc1H3tEwSiXikbxetCz7RGzHAJPEnChrufcX6jlDmtDTnQugkh6p2rco7egX6kS5bxBAQzm4xuD/PdRvPh73vQ3j5VLcuQRy4Mv/8ZSQm5x5+Q+RZ6zy6N3PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AleF6Kuh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47fedb7c68dso50222045e9.2
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769008516; x=1769613316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ShDd3bg/yye6DPfyO0pVq34E+Bi6k81pmGsR4VGz0/w=;
        b=AleF6KuhtvQMngsaSizIeoTiBAYQtxQUi/URhYBUAnqb62kpsLu0MYkk3WrahRbAQM
         xyRdcnTfKJltjiPCeHz6mmgR4CHWTjViu1lBufyRlGzKgUkssNNKNujrfmKjhusFIcKq
         eiU3Pxq6degVb0E4k5tdZHfdzkLmJEd0qXtz+mT90zOatyVigds8mLF+h9PIhI/2737p
         NdZWZrnJXloP5uu4e/g4vC4sbgoli1QimxGJ8nAQB0QJGOleE9NwkUTGX4MoXePoir9N
         UO82bVP9ak9mbl1YeWiNWaC5sthA/IEsbeC2MqmL6Los6zYE4ZIiQfp8JTF7hq7m4Ed6
         Txmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769008516; x=1769613316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShDd3bg/yye6DPfyO0pVq34E+Bi6k81pmGsR4VGz0/w=;
        b=eRws6pzLvYnyTIKfInR0EgPvIhs2MuB+QpNiPp1bY0vyqPQPAeKettH7JiuRjFXvk1
         1Bo0C7XBi6OuGhlae12jdzinQyxiUdcweh82Mbaw/slsYu/iSA7gwjKKbiFyBR6V7SXi
         iuqUKJsFA912qGW0e3+cIGDfLQj654n47tHh0sKzFWDLfnRE0NqeL9xKN2u4HQR0roqB
         JXEu8aPixlkpdMjjQ2qqIPXWoGko5YQF6FZFCckZQ1VvBqEJUOe1L9X37y1SgFfsPDPJ
         NojFSjNGAUXhq7O4lNF2jE6XL1Vy6JcwHLsnLuutZgimbEwbcjk4zQuioWg8NbezvxwT
         YXHQ==
X-Gm-Message-State: AOJu0YwmclPVUM2ZgEu/e/qFXw/bCN6UNDq2A9qt+3dqoxMVd9GVBcyk
	rBL+S+dl919OX/RJjSdwiluxT7rRaQxXC9a640AREd95WooP3IUDHSNzSVx5Uw==
X-Gm-Gg: AZuq6aLI8PiC5Xduy2e5gF7qVGCk8pLKDlY+5OPwNulqqP/s9pU08rpiNCQaLFIaQc2
	75lJhYExfAv8djAuAFJSwxLJfAH4PIz8/sD6aGUHbLXbD+/p1tEXchURuv8emNG7VrYpfCx2js/
	MsWcDJB6Xxnh0hG+084Tm95Jb+e2YZ87m47Bz/UzgZjWhaKPmwBJDTH1TgtfEtr+94fPb0X+Qdq
	ZTGWljphQ+Awgl1N9GlxXY538OGGLgxhkgDHanRAQb4mCgOKWkp0/1DeT9txDu8S2GGyHMOX36F
	9iXy7KSgWr0YE7hnEAG8NSrkK5GNsiw6KNZy+obZPiIShrBq/0kyqhAHjOpD+WzPQju/R/HI6oe
	+m39UBBUS1YELAr6UR7WQS1CJPVaHYb/OifM5uglKCVlE5OHM0RGFrJRwybLrucOyctikj0hiLr
	v4+E74sdH5X8k=
X-Received: by 2002:a05:600c:1f8e:b0:47b:df60:8a14 with SMTP id 5b1f17b1804b1-4801e30ef39mr244009195e9.9.1769008515786;
        Wed, 21 Jan 2026 07:15:15 -0800 (PST)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435924ae6f1sm10534349f8f.33.2026.01.21.07.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:15:15 -0800 (PST)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH v2 1/4] dt-bindings: net: realtek,rtl82xx: add a property to set MDI order
Date: Wed, 21 Jan 2026 16:15:03 +0100
Message-ID: <20260121151506.813783-1-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-251953-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 6E0E3595CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

MDI pair order reversal is usually configured by the bootloader.
However, on some design the configuration is left untouched during boot
and needs to be set by the driver.

Add the property 'realtek,mdi-cfg-order' to allow forcing normal or
reverse order of the MDI pairs.

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
 Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
index 2b5697bd7c5d..c4ced671ecb8 100644
--- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
@@ -55,6 +55,12 @@ properties:
     description:
       Enable Wake-on-LAN support for the RTL8211F PHY.
 
+  realtek,mdi-cfg-order:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description:
+      Force normal (0) or reverse (1) order of MDI pairs.
+
 unevaluatedProperties: false
 
 allOf:
@@ -79,5 +85,6 @@ examples:
                 reg = <1>;
                 realtek,clkout-disable;
                 realtek,aldps-enable;
+                realtek,mdi-cfg-order = <1>;
         };
     };

base-commit: 983d014aafb14ee5e4915465bf8948e8f3a723b5
-- 
2.47.3


