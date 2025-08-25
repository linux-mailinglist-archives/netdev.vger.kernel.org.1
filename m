Return-Path: <netdev+bounces-216543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C4DB346E4
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 18:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 184527A4443
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 16:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693123019B7;
	Mon, 25 Aug 2025 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDpWuDtR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15CA3019B3;
	Mon, 25 Aug 2025 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138283; cv=none; b=jlpXohFeUOSfHWRaIg8Ig4RVA8I8SQxiGN4I1ClWkQbiDTEu3lRrFWUlquSvSwjm181NsdXZ6uxCtneWtF+MYNcWG8gMczua/GdhkOKeGgJ62FswYRtSZi4OzdlN4WicUJYWRQ+p8fpIWzV8aMId6CNOWTWOqQJQsdSSBHvtUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138283; c=relaxed/simple;
	bh=5Y8C0T9L6QzzrF4J+0rDNTbZ2BMah0+T50iH5F4/Qsc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jXzzXbUzQmSVDKR8NzURiZ3KFDEYXNxrRahfF7jxBRfXK2pymkkDkRBgRFab8WdnkfKpBOfcRYPPUfbP2XDV+ajDNKpi0LXThSqxXpVpB3e9SLMvuhaF3JghROg15Xa8b0jJBUGW3osFk24lWqdcIYfUFwKOJ4huu4PBqSnVm8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDpWuDtR; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so3544413a91.2;
        Mon, 25 Aug 2025 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756138281; x=1756743081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JYA0khIeH/P8+XSTNmugjVjjGIz4bN0sF/6YfGXRFug=;
        b=PDpWuDtRH1sORGhR2XpWAjiXeTIxX2AcDo+RsQ6TF1d4rU48myBYNoODC0J8+kk+Hl
         WOmEveC3vsc9Z8bH6A5aCkGthw0JhGgbGAQEklHG63jI6CcIdFkhXckD3znGB1tz+/iN
         GWL2jOv4BZrBtKb6bDXb4Qasb4aeho06nd6el0FlbjE0/KowbMUR/m7Z7fG74YLSpE34
         gSaoc60CVLK+jWjqEv6MzxhAvK3m4Xbuqvi1Zdw3XQuBTxFn3GQ2xcsabRPbgbCnC4Ae
         UpM+lEiCcL4f2Dhtg9LWBGmFbKKDgjj0hrL+MWBU/Za8lCeKbac52mVQ5zzLkHkOHuen
         nu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756138281; x=1756743081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYA0khIeH/P8+XSTNmugjVjjGIz4bN0sF/6YfGXRFug=;
        b=B9jNfPGfHSJgJZLzo/y+PjUhw84YwQmy3XxeyxcLNs7tNSWgoOj2Ht/IlZUcdgg1DN
         ycFbPxzW/Yt+gC6L6AC/63f/ARtka/1eFILiayQV7T2HEfFA4lE6jElYPXjFRa+5XBhv
         DRSpXcf+QlvYAROxds+gmtY2mQ7h4aNrEEiG9wjMmeLgapegO7gHH8OQrhutCaG2R33o
         uNJf7gYF4K9c86C26UWGffx0Sf+rVA5sI7YddrrlloHOwjgM16hFProDIhMrnGwQAlNt
         v558mhMnVJnM+ac8P7F2tuu/S1cCloLWN2Eh5oNh9/B2M66x4jpnrkpKFIUOTcobZDZD
         SIcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8DcjGWZPScn9POO+0AhZb1so6hC5CfsyvOxA49alX9PTlhhOk/AK7w0lbaHfnM5HSVhVcgpxz@vger.kernel.org, AJvYcCXMk6fl+PrE5No+rvgaB6w+6LMMMlJMZSfbR1g3A8PqxPhlAh9sFDsDbHDdDJyTd9KHeHoXobGErrRw@vger.kernel.org
X-Gm-Message-State: AOJu0YznU7SEZuaTcQF/C4PREYIBrrAwU5K5kP4EJAUuD0Zf8zkXfhzj
	I0LbFAePk3kBaxtFuBOeOe9Dtk/D/ZsiVaSF8zzfn3vGD11KFJBJnQAm
X-Gm-Gg: ASbGncthSD0t+9EZXRlfgZcauzoZuIzom8bcs7RftCszjckhDrxWatQRrFKsLFltTlF
	D0WG84eMXpaEVAVjGhelWKtUHY57TKai4EqM4cRw60Whwa4Wvynt/ZeCQ1LT64vWRpp1NwKRTzd
	5ZCeVZTAj+2iO8rATK4ypOwFjslRfg6pYgbzCQXbd6/pTU06Ek8OvIL+kle7q4V8bJcWCCnPJ0l
	+jOVnk5ECHW3iKoKkciZ+NHUMNl0BBPHGnVIXPruBNlZCeNDhYpj/QekHClrCT+DLS1KMEEitzK
	QGnG+25FRcVxrNpCHWVJOMIwk7G4M0mO8uqHPoRuLZM8JEYwE54cCHEpHlTAA84l8+zoYdoyuMs
	WttE8oF1HKUiMePs8f5pN+bWa3Xl2RcpoPBHf
X-Google-Smtp-Source: AGHT+IGY14ia2me65kuJ99QlTwzbvVWtjr5P4YvNuETHJzp2CJSaNzYKob69gxUisdYJrZ2C1PD58w==
X-Received: by 2002:a17:90b:51cd:b0:31e:f193:1822 with SMTP id 98e67ed59e1d1-32517745f63mr16115616a91.28.1756138280973;
        Mon, 25 Aug 2025 09:11:20 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:c097:8aec:1f55:188e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254ae8ab5asm7439494a91.10.2025.08.25.09.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 09:11:20 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: krzk@kernel.org
Cc: mgreer@animalcreek.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] dt-bindings: nfc: ti,trf7970a: Restrict the ti,rx-gain-reduction-db values
Date: Mon, 25 Aug 2025 13:10:59 -0300
Message-Id: <20250825161059.496903-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of stating the supported values for the ti,rx-gain-reduction-db
property in free text format, add an enum entry that can help validating
the devicetree files.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
index 783a85b84893..7e96a625f0cf 100644
--- a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
@@ -58,7 +58,8 @@ properties:
   ti,rx-gain-reduction-db:
     description: |
       Specify an RX gain reduction to reduce antenna sensitivity with 5dB per
-      increment, with a maximum of 15dB. Supported values: [0, 5, 10, 15].
+      increment, with a maximum of 15dB.
+    enum: [ 0, 5, 10, 15]
 
 required:
   - compatible
-- 
2.34.1


