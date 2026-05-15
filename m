Return-Path: <netdev+bounces-288288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LKEEIoOB2oLrAIAu9opvQ
	(envelope-from <netdev+bounces-288288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:16:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C9154F4BB
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D91631BFBC1
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FFB47D93B;
	Fri, 15 May 2026 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="dGyZoH+A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC8C47CC8E
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 11:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845861; cv=none; b=Yctda2VznCjArSl0+9hhnEbiAmW6gzJZoI9cKG54bO/KYAmWrmYnyhJXF/wBU7UuAp6UIHpjP4CLAGzq/2PcsmZbxUWSq+QGbczQYYPRJORhLyY9PeJG3Q1Hj5XDRMdjk4x15cWEKtW8Esc0IcFAG7XUT6hFugPXfZIst70NM6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845861; c=relaxed/simple;
	bh=6kFn4dcGVaXo/n35fpEIPoxldbG29tZM7Sv8RrAE/FI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G5mwHUZ62B/sosnNKh5A8t/zp89j1ULJMvqTm9xJq9dRmCB1/LyB3J55/ksAQRyEOJLS8tseMmOm4uSf5Rj6Isk1TiCBJX5Ly2US5LYSZfOZQbTb+b6iNw0KDpspMqCCG1lT3CDHPEyFE0eiiPB1yRd7xNtZcfBctrgOjWcBZQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=dGyZoH+A; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a62f43b76aso8094980e87.3
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 04:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1778845858; x=1779450658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X6ljMWmUboXD/jlL65txDouWmV0Cc/lFptWauWqQZEE=;
        b=dGyZoH+Au2zrEwjH9gfGsLmwb8QoE4EOTJ8y2EXlRHR89hrJ/mnVFXKxALiKcq1sm2
         etls6uJrH0r+b1ydVqPglXCrRw+7IL15FZ02qq1BuIbbCvLPhxCBNEHD75A+sXGT8yJD
         PZmHzQFipstGnLrZ7ozoJLzDp7gIbOxiORV+jzioU7jmHjy/PWCsvZwN1eSoTBkV+6xl
         pSb6wmv1vxbVdeJiWTTJaZf1vdlVzq/4bGKPAcd1fKakB7rvZMRGj/uBLXK2zmND2TdE
         gaA6tvFl0j08cERLgasrcQCTeEXbuDXEiFRmLfxN6MJLZaLIkQr37nLdFYeEC9VmqYfS
         ogDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778845858; x=1779450658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6ljMWmUboXD/jlL65txDouWmV0Cc/lFptWauWqQZEE=;
        b=Sxa3OA8Rt396LhdGPITbvM5uBpQCdhQfvVeRsid4QxPZkNfTG0GgsKqiJWNocN9tr1
         /7Ti1iXGIebv9zhTHcXy9lur/K9sTyRc9A5TwDDCA9NOCAmhAklHApSJeJPhQcoW/UPA
         1q9zY6eUfw/YGOTIvbQ30pDK7DEQ5rJnbgrl8WGETbJlX9Y9ypKrsCpy3AxTR1lk/Rtl
         zaRsXaqZg/5I1e4WydQsvHR+Rx/hzTsrEqlX2QNZ5ST8ilMwi1Obvo8zbOaPSAsgVHlY
         APYv+3vjcM285mz4pKXRra9rw7LPg4a+fWPMWhQ76bIu1wjQFCYOdn3nm1x7TXqSB1J9
         7icA==
X-Forwarded-Encrypted: i=1; AFNElJ/zkLnU8hVGkIIHfpe1IGC43ZuFLWs2yXTDavXZXHIuRto4BOIjqeuY1RuHjo1chvHQ92xnKOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzanNkKswG152QH9Z7XDme2xh5Y0m7xNFuhA9TAG+7r5LD/beHp
	xSZc/aX3mQV5qiwLnKoaSQx4uCNOa5y0mLTGOU2l2QUKXvgGyEOnIq23syGXB2JJg08=
X-Gm-Gg: Acq92OE/2+RAmJHGKxMoXBmBDnD/uFE85xPjzHQLk0FZHlGHuaULRfHz/JIFHrzEv1Q
	KZFwR5roNkE+mvLrpb0tBSgiEzwxXkld7IGSd1C/NWpiGIoX5SkvkOTgYQ2zwwYBWpk1+Ij/QIi
	0RAjAPQWtbmnfdammFF4h7OV/QG6Inavvr+aKcb70HXLnllF4QN1J8gcVrR8Nuvy8+E+NHP9wh8
	IbkitHo9BwFY5cehW0aC1+5x7qYVLHuN5Aq7cMyeJqNRUzM0j8tOLqHrDjRkfjNlgFqJuqlexNC
	Ndsj+WkgCc20+gBx1nl1kdAHk4wi7y+jgY8cLNZYbrASBWjTtl8OM9XGvkawgEqNl7EESWKPXWy
	zd0cWWixYoHWPLS2hlxE/p7d5jUgjoMRY/pZKUGi1RldSQgbEOK3SSk39ayA4KITafmKscWaCB8
	lPZVGkW2F/4mHoFdvQygaw0Zr0dVW5AnQvU/UEseKc/mPWoG5Kl8R8Ax78zlBaITahYxfTS49My
	lvjFmf/FT/9Iuj8jY5GoA==
X-Received: by 2002:a05:6512:1387:b0:5a8:65d9:613f with SMTP id 2adb3069b0e04-5aa0e73c0eemr1036472e87.24.1778845857681;
        Fri, 15 May 2026 04:50:57 -0700 (PDT)
Received: from fedora (d-zg2-146.globalnet.hr. [213.149.37.146])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164bc0ccsm1278617e87.41.2026.05.15.04.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:50:57 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
X-Google-Original-From: Robert Marko <robimarko@gmail.com>
To: o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next v2 1/2] dt-bindings: net: pse-pd: microchip,pd692x0: add port disable GPIO
Date: Fri, 15 May 2026 13:50:00 +0200
Message-ID: <20260515115050.691119-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 88C9154F4BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sartura.hr,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sartura.hr:s=sartura];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-288288-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sartura.hr:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.marko@sartura.hr,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Robert Marko <robert.marko@sartura.hr>

Microchip PSE controllers have a dedicated port disable input that like it
name suggest, will disable PoE on all ports.

So, lets document that GPIO.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Pick Acked-by from Rob

 .../devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml     | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
index ca61cc37a790..ca4200afa793 100644
--- a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
+++ b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
@@ -22,6 +22,10 @@ properties:
   reg:
     maxItems: 1
 
+  disable-ports-gpios:
+    description: GPIO pin to disable PoE on all ports
+    maxItems: 1
+
   vdd-supply:
     description: Regulator that provides 3.3V VDD power supply.
 
-- 
2.54.0


