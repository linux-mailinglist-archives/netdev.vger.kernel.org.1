Return-Path: <netdev+bounces-209596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1C5B0FF42
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 05:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32709160273
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 03:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9669F1DED7B;
	Thu, 24 Jul 2025 03:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRCbjb6j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2403F4C8F;
	Thu, 24 Jul 2025 03:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753329193; cv=none; b=CmcZ4OjQvu1gZxf/biZDJ+VLzsjRQ+4jJXHr2mXmOkSdPuwq7ByOfaityuCvK2R83Rcnlr/LGPkBcL+I6JEdVAU2ZmzWEai9nsJ/8LcI3Eve4sLTGxx+Nsq/gJRouL37dOleYdqv0q1XvPfZXsM0Y7SD24DihZuVG+942OecZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753329193; c=relaxed/simple;
	bh=fG7ES9NUZdqzG7iujsq4OrDa/4JLEMsH5MKZTxgpCpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nTb4Q2Xz8tNfiRwqHj7bwrCMD0jmp9SomqVCr+EiDHVUlTdqKl2xKu7lqa8HJ5c/E84CnWb+k0Wr5ae4G6mDCfOUz722MYks77eRR+jymo90PkgHFYVy6RSA5Raas13vDl4nPL62jOnQfPdjV9QLQmza3bqhmyssOEZ/OBgPtYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRCbjb6j; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b31c978688dso330433a12.1;
        Wed, 23 Jul 2025 20:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753329191; x=1753933991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0KKNQ336azj7L9GAtgWaz6+RVPsKRcCaE1xp54qrlzk=;
        b=QRCbjb6jjJO588FQFKstCqvicUUXhxputna13XbBN8wDc5pog0yv6c5fyrbtqiZ8fy
         LmL8cLlVQd17mExDegjsf9izntc600qUHk8t+QUWFnazQuaDrrp144gzF8RuHfweApHs
         NXgrUTq5IWKond4ja+Pnk6TE5nqOpLOV5Hpq2MFhr5T2RdynWK2g4860nsgBxv3i0ZBP
         y5nluF2AE6MycL2JlpfqHvOjB5LVNxf8Ap+m8H1xmQ74dgQwmC7UWlebYCcGZb2yRWXK
         5MGDu8UMyVpsmaZ44rVijsY9Jzco9JG8G82doH8vKRI2Xh6HWTwG7Z3Nh2cFUjUbGIOH
         Xvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753329191; x=1753933991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0KKNQ336azj7L9GAtgWaz6+RVPsKRcCaE1xp54qrlzk=;
        b=CtZuD1ow1CBPubnLHChVzB/a0ZLVgmMS6uZQciGD1oXS/N4d4mrtpTe1NQMldLMDWl
         Hv9nZpy7XgZMQaqXxkbLhnr9F9ZMgb58JO/Ks1nhmJP7I8KOBdXeKMA4q3CwEWf4zDFb
         ynkECh2/z1QQzVJE7vHQXW37KOhbavMd3u2Oy7Su5b7RybStx+DpE4m8L5mCBdhoDTqn
         kABu/hhUem9pGEyyTXKyQt2NVanMEak2/IMLnejLqaQfw0SEkljpopZ+a4iXJwNYfH+9
         iBK4Gtd9kKVUN3Wl77s0J3kor4Z5i0Ux4B2NDtFrijbmkMalpdyMD+9U7AkgMqATEqTY
         mDtA==
X-Forwarded-Encrypted: i=1; AJvYcCUM+vUfVyDl2UFUr5TUXTBqo6v1Qp/d9I3u3v7LwOdmlhlcx4F7hAhEuWRWnDuBZaYgRmzaa75/@vger.kernel.org, AJvYcCW2chSS8bqzzTd2iu5WP9JMn+UA2XQ6qMOQ35WwSl+xXKrjCeFCpMBvBLqPV4UGjzrr9aywgqk5zyOH@vger.kernel.org, AJvYcCXeKatkspSgUpd8a89eVZ0CsXksK1SMqjE6ig7bjfGmG1mZplAZbaz2racSPAaK768STf6v725wrPIZuv0k@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+Mx/f5LXxUpj20ZiRcgfYEvM1xv+vgIaWRIHQ2yOExyYm2dLK
	ziOSVV1OKMcwiIWS5qeKGpdmOG+7FpfM41kBs5/YNOcxYmSV1ukWS+dk
X-Gm-Gg: ASbGncvlbTCjXxSn1K9UBoYmQ3yBMq67BHgwl8PkbnPetgNtptDti1xUfd5YSDUeXHp
	ElGSHDXQvpINty4HW/w4CtPPG8ImSD9dPPHbhloz2C/eNlxO4VxVfn8UYtb2uu577s2CEwZFcHR
	74ZabOe07pUJR3ro8cMpmnMqKwAmv5uRHpizSdsc0cSHLCR4RveGZWAd1blouFrNKhLafE/LaGe
	pjolfMBcD9J5YryENAkn3YFAF/0iu2zjGR9lqFfaIDuKfcT/Rhuzf3E0knn3vlDRkRYUG54UGI8
	Cud0Aoq5u9x5rKLrCQYaelmrHGl3sJkUz/pyQBY2deTZkYOv3t6h3hnjF0Io3FuoLNixVXBjVko
	KDY+VE02PWBJ9mxikKgVIhKMb6NBMqLICR1AP9l2K
X-Google-Smtp-Source: AGHT+IExZBDbOJBbvjhYg17Sb6h/w8Iqg69NparoRP3Ig1+hOYeBA/a0AI00nM+/PJMGcCv4mZlOIw==
X-Received: by 2002:a17:90b:2e0d:b0:31e:3bbc:e9e6 with SMTP id 98e67ed59e1d1-31e507e61a5mr8183549a91.19.1753329191338;
        Wed, 23 Jul 2025 20:53:11 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa475f883sm4458625ad.13.2025.07.23.20.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 20:53:11 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/7] net: dsa: b53: mmap: Add bcm63xx EPHY power control
Date: Wed, 23 Jul 2025 20:52:39 -0700
Message-ID: <20250724035300.20497-1-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The gpio controller on some bcm63xx SoCs has a register for
controlling functionality of the internal fast ethernet phys.
These patches allow the b53 driver to enable/disable phy
power.

The register also contains reset bits which will be set by
a reset driver in another patch series:
https://lore.kernel.org/all/20250715234605.36216-1-kylehendrydev@gmail.com/

v2 changes:
- Add more description to dt binding
- Squash commit adding syscon lookup into where the result is checked

v1: https://lore.kernel.org/netdev/20250716002922.230807-1-kylehendrydev@gmail.com/

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>

Kyle Hendry (7):
  net: dsa: b53: Add phy_enable(), phy_disable() methods
  dt-bindings: net: dsa: b53: Document brcm,gpio-ctrl property
  net: dsa: b53: Define chip IDs for more bcm63xx SoCs
  net: dsa: b53: mmap: Add syscon reference and register layout for
    bcm63268
  net: dsa: b53: mmap: Add register layout for bcm6318
  net: dsa: b53: mmap: Add register layout for bcm6368
  net: dsa: b53: mmap: Implement bcm63xx ephy power control

 .../devicetree/bindings/net/dsa/brcm,b53.yaml |   6 +
 drivers/net/dsa/b53/b53_common.c              |  27 ++---
 drivers/net/dsa/b53/b53_mmap.c                | 107 +++++++++++++++++-
 drivers/net/dsa/b53/b53_priv.h                |  15 ++-
 4 files changed, 134 insertions(+), 21 deletions(-)

-- 
2.43.0


