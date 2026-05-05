Return-Path: <netdev+bounces-284554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCgZGK03+mnVKwMAu9opvQ
	(envelope-from <netdev+bounces-284554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:32:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6180E4D2B64
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B0C73028B29
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 18:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA024BCAC1;
	Tue,  5 May 2026 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3t1M5IN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285984BC029
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005662; cv=none; b=XFtiXQGGMe4wG9EYb//jcEnCk/cN3alllOOhosiop7RXV9kYUY48H/N6j4lEK4C8EOnnYy9bZ/QoIAgP/kf4DNBdYDmNnrSO0KnzouAoj5xKnYcQpkf1ke40NN0G4aDq7dNG44RbimNnb+X/RGZ1LFOjAoPFpqdBuG0GkS+SYe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005662; c=relaxed/simple;
	bh=9SRiToZStmepK6Eod4FcGlMmOh1qu0e+H6ejyB6vaS0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kR82O1AwWcGbbPK8Xj0NbiTJZEppFdl0EHosRDAp29XMwddQWsEOjeCyeg3m2wqkCUir+ImlLazI5gtvp/TG6s5MKcfPp9zt4XjJ7Hyiv7aYE2uCAjnYndGuJ85FPgO8OoYgtJKKO0CUJ8cqvDifUEKvjOXOh8MZ8QHgJMgzrq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3t1M5IN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b150559bso38498265e9.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778005657; x=1778610457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsjeeVtAkvtmQCzhPvbG7FaRQP12aRU2hZI/S64sceQ=;
        b=i3t1M5INF6rsFDZpZmHbZWRsrsSsDL4i+F5bpVMyYVvMCDsiOJCdq0smOEtFJ6LakL
         rAqhK2i6JrCsTBeaRdCMOt2vU1Vcrmu42jaYlDGtetlFFkzKlwJdW1tHF2Nztu1BYh2u
         2h43hXY7+n3GD/hzP4ZT6nVT5jll3wMtv+CoI91LdGdu051vV2niAtdlnDOCrLgM2TKo
         CQMxLPv/iYTMzih6m/DX5/cMeNbt2+6apBjQxh4XX8H1AjPdWS2WGWz9x0z3qeSJYcmP
         Z5vwsBvkpU46wcMx1z6unyZ5oEFlzwREQdn+qrzbX+Oq/YS0CFlTfZ47A69ZnUtufh0x
         lXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778005657; x=1778610457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zsjeeVtAkvtmQCzhPvbG7FaRQP12aRU2hZI/S64sceQ=;
        b=L3R/jVPcQnXiRwT6mpuAkvhXqo4dyKHSGRPf4bjrZkbH8ModP0bdlSBUkpIJoQgsZL
         HWuCr6O/05fuDcrewizT9biQ0X/t8gqFp4ggzAsDPiMSxDKebDPskdj77SCu8eQ6AZa6
         1ZVdy08Jji0PTKW3bQxgDOnimdSVA9I1P3RVu/w4E05J7iEr1pwVd0NAE56ufVmDMyOT
         ZRV3ZxEcUsD+5k3aQIcTSYdCR/ZTNtuyY9d+nhbxnFtJI1rXfv1QY/0N+xCDL6WG62Or
         378a24WX1h4pYsgOsc9fLnzFSrbG7in/mg4WvhFZmhSez4jws7DRLqUimDMALtU7B7hk
         Hl5Q==
X-Forwarded-Encrypted: i=1; AFNElJ/fQpiUmtEtBnK0/ejgjzWRv+3tF1yW1AqqD7a5MonR0J3dvGLlTEWCmI1ABkciSdFOFIAW+Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGUBMgT3Wn/pwLyms1XvRuKksf+EikMxQcXjQ4Td5FPhaoFcNO
	97zSrMGAb2FwRE60gtL+FGxTKrFCLGQ1QwM3Ax1LcuFTkWPCyeAtza4U
X-Gm-Gg: AeBDiet+0Kf/XgOitC7n763hL5asDsdcs4QGBPhKmVyXXpoZhC1qpVxeLk6MSoKz3HZ
	6ROpCXgXAag8PqZohKGnyo6GAaMGskh/Sk2zGybPWAs1zuoL2e5ZVUGl29KSfeY8k7TlIxwlOWl
	+rNgr71SEmukqIY0ZXCo4xybAOkkdWts83V4FlcKArFRh3k6nPgmC6UK7oQtR9yF9QjSgDrZdXC
	z7JYg/JiQ62x7H/QFTbPJQxdlaFAyMRtRWyhWZyy4PumBGDxCTTUUC2snu8CEioZHIya/ekavFS
	GQY7qEyGXdiM3aM69Sw3WBemsFPxsT9mwoGfznFqezR0j4B13E15VhmAXeIEIwisOY4132jXTMK
	4fRkiKsSAvVKydkCGAEDkwTnXj+h3IFrQXEzqhPVjQLxLFfkvjyabCyXyezluHwexO0GMcM0ww7
	P9G3TeXT6ZlWoyW8I39PwWKFFTsNMl+67iKv1ND/tKSOEhgfbUT6SLMltTV3Ba/1CgEi+ax7RfA
	fz6JUA=
X-Received: by 2002:a05:600c:17d0:b0:48e:526e:101a with SMTP id 5b1f17b1804b1-48e526e115bmr262175e9.12.1778005657086;
        Tue, 05 May 2026 11:27:37 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-59-227-65.retail.telecomitalia.it. [82.59.227.65])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a820c865esm408208245e9.5.2026.05.05.11.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 11:27:36 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [net-next RFC PATCH v5 06/10] dt-bindings: net: ethernet-controller: permit to define multiple PCS
Date: Tue,  5 May 2026 20:27:07 +0200
Message-ID: <20260505182713.27644-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505182713.27644-1-ansuelsmth@gmail.com>
References: <20260505182713.27644-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6180E4D2B64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284554-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,pengutronix.de,makrotopia.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Drop the limitation of a single PCS in pcs-handle property. Multiple PCS
can be defined for an ethrnet-controller node to support various PHY
interface mode type.

It's very common for SoCs to have a 2 or more dedicated PCS for Base-X
(for example SGMII, 1000base-x, 2500base-x, ...) and Base-R (for example
USXGMII,10base-r, ...) with the MAC selecting one of the other based on
the attached PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 1bafd687dcb1..51a8a418955d 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -85,8 +85,6 @@ properties:
 
   pcs-handle:
     $ref: /schemas/types.yaml#/definitions/phandle-array
-    items:
-      maxItems: 1
     description:
       Specifies a reference to a node representing a PCS PHY device on a MDIO
       bus to link with an external PHY (phy-handle) if exists.
-- 
2.53.0


