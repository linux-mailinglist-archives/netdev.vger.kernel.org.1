Return-Path: <netdev+bounces-301570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2aFiBryZO2rRaAgAu9opvQ
	(envelope-from <netdev+bounces-301570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:47:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E326BCAAA
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 10:47:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DJi2w7oB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301570-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301570-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C8D4303B4EA
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 08:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31B931DDBF;
	Wed, 24 Jun 2026 08:46:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7516F25B092
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 08:46:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290805; cv=none; b=sgaY/dVLz6fy//Q9b8rIWsnKaFMb1y1+H5QYlShqyPPEbu7fT3ExsyRB4bljkxm4+6Oi80eqWL/rquwv1Nv/r+FB/YUmDZQwcG5c2LVyQfi5kDemBdOo/4m1DD0FNwFAmOduprdHtS2kV2+rGS++vK5s1cQgV6kKscPK6/1GD5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290805; c=relaxed/simple;
	bh=Jsh+4vP/f+Y7qzRXW4NmYmHJSetmziSvku7ESza+DQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nKFyCxZ80M7M7uPhIF/SLebo25/uTud5hs9QHpZ26gEmw0lYYMvq7BjE4hVvxRPCEngVox4ghXNeEp/BXTJcSH70hHL8Ag4XUqY51p3KzeBViF9nhhB0she2tpqnrmyYn+xErgC6FGbO0K4UfdwwtF2XDo4oNTB2ujlgmNEllK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJi2w7oB; arc=none smtp.client-ip=209.85.216.68
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-37d55e8d3e3so460792a91.0
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 01:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782290804; x=1782895604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80huAu9bkh6KHgzBZGFLSxb8JVOVhcXYtQUMYEe1cbA=;
        b=DJi2w7oBNKq00YJO+RhjhHa9xYBVP63kTvGWwc+wVJUX8ff2dWvf5yR4PS8z+VSHq/
         9m/MbRPgIG4eWHE4hFtJHqsPAbhu4not0whkHp1sqEQ/lBrH2/D6BWHcp0husABtBprh
         kiqammE/tha3J3RA9hya/pWSfJeyDRFq/9cSbLjZcidF91qql93mMa+98N+N/FDoqNuQ
         FisYU0X8HA0BlVBWDj6MYvAk7PCQFmkgXHzfR5LDyGzFFZcNq0Oi4OByScyoLzB+j5OZ
         ta/aAgfUZr/d10CvbEvtmlJn4i1fBYlZu6xcIQi6zToqajD09TufIsP/f/bvdgwjG7U+
         OP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782290804; x=1782895604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=80huAu9bkh6KHgzBZGFLSxb8JVOVhcXYtQUMYEe1cbA=;
        b=i42yWzK+srJPVCj1sxNoAnZbCF+VCCvjqGuFVHYI8ZxJABKh5vip2NQCj/+4o0QueD
         1cuLGCu/IRHshNJtDptlTd3B+EgslwpyO0LahlSsfZokNu1ChjoZXC2mOLL4wrkiBq5R
         kAuxM9qVwS23tscCmtqCzHSGwSSXJgroZd9rEDHh1G8ECo/A8U7DONuXcKCR8R2XCn1w
         emxyrDEoQz20jk5xmrTIuiSFQBo2VQW44Pf7ThciFWxsFAx5VrDWUxKG5vIfJ+r004am
         9uWmk3MlmgCiTx9E3QCWC8OwMXvYESBF9TcXyK819Xu0IjS7TGe4YB70cM1fLBQjvYvG
         +zMw==
X-Forwarded-Encrypted: i=1; AHgh+Rqs0TECUjU+5TPQ1dhwy2KMISZPnb98zRNrPi+Fu7IdLeMjX8aomJsjh6+/d76/prYLT9jDyWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc+C4wEOA5aoFcnEwSE24ubfY22uEYbTxxvRraZESxLFQXsxQN
	zmReV9+xTd+bVj7xZad7TfpGv5yOnG6PIbAZZDTFmh30g0A8aeeViJoz
X-Gm-Gg: AfdE7cmzN2/MNkONmd29wdBRctWGOpONRNjcJazCk5iMqMYloKRuj68PUgp/+4j5ezF
	8tf/VqkCY0ssp7QBOpuwcUS66L/d7TI4gdLXCndfdFmoHKn6x5Q4uNW1ITD5ls6FFjMdZ9lcpsp
	1TK8sr0QdMrLnDAM6CWGh3RWucbHchy+Dt0VPfi2gzAnscYVqRsyLgglDFlNZj0bHMVRW8PeJlV
	4//sqbIeYfuxxFpCrvdVc6ABp4jI8QSAtHBke56p9+9bMxAK8uBQBYGBK8kXPvzjXszl9N2mxJq
	cJGToQZ7AdxOjKg7XumW+QQL+hxjvcdj4/o+q/sGcHCnUwdNffsz5JEU07JCVd7lP3Yf6i4nBf0
	m3NkSoPUkCsx59Qf3evZhCTKW3ya0BzXFg/KnRlrG2w6PelnXG6HCDPpXlpLc4zNidrUdWIUorL
	VX6/8Jr/p3HY2cRbf4O9m4pBCoqQaUzk7YGjY=
X-Received: by 2002:a17:90b:3d8f:b0:37d:9874:935f with SMTP id 98e67ed59e1d1-37dcd701ea1mr6306406a91.11.1782290803441;
        Wed, 24 Jun 2026 01:46:43 -0700 (PDT)
Received: from [192.168.1.101] ([218.194.36.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37de3d152f4sm2138146a91.14.2026.06.24.01.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 01:46:42 -0700 (PDT)
From: Yanan He <grumpycat921013@gmail.com>
Date: Wed, 24 Jun 2026 16:44:38 +0800
Subject: [PATCH 1/7] dt-bindings: vendor-prefixes: add alientek
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-rv1126-alientek-dlrv1126-v1-1-5aef608a3f64@gmail.com>
References: <20260624-rv1126-alientek-dlrv1126-v1-0-5aef608a3f64@gmail.com>
In-Reply-To: <20260624-rv1126-alientek-dlrv1126-v1-0-5aef608a3f64@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Wu <david.wu@rock-chips.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Yanan He <grumpycat921013@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782290789; l=883;
 i=grumpycat921013@gmail.com; s=20260618; h=from:subject:message-id;
 bh=Jsh+4vP/f+Y7qzRXW4NmYmHJSetmziSvku7ESza+DQU=;
 b=Z9Lt///3m84yBAmd5Rx6elPweLgGZVP5itDksYZtTAsSRkl/mztlr90ckF6yRI06aMkezej95
 wSJvTw1mqiAB++WxygtHTIGc9+5JEekbHz0QDhcyHEO0zxJqsmdeR9j
X-Developer-Key: i=grumpycat921013@gmail.com; a=ed25519;
 pk=oWrY8KwXIunZWlYBV76NG2A3V4p1bJ+aD45Mr56ErTw=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-301570-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:heiko@sntech.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:david.wu@rock-chips.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-rockchip@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:grumpycat921013@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[grumpycat921013@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,sntech.de,lunn.ch,davemloft.net,google.com,redhat.com,rock-chips.com,gmail.com,foss.st.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grumpycat921013@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61E326BCAAA

Add a vendor prefix for Alientek, a board and module vendor used by the
ATK-DLRV1126 board.

Link: https://en.alientek.com
Signed-off-by: Yanan He <grumpycat921013@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 28784d66ae7b..a23508a61373 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -88,6 +88,8 @@ patternProperties:
     description: ALFA Network Inc.
   "^algoltek,.*":
     description: AlgolTek, Inc.
+  "^alientek,.*":
+    description: Guangzhou Xingyi Intelligent Technology Co., Ltd.
   "^allegro,.*":
     description: Allegro DVT
   "^allegromicro,.*":

-- 
2.54.0


