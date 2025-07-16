Return-Path: <netdev+bounces-207327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 763B3B06A77
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD8837AC0EE
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BB719AD70;
	Wed, 16 Jul 2025 00:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQBJ59jv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6276192D97;
	Wed, 16 Jul 2025 00:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752625782; cv=none; b=g3LJwREsd8a/l/tonpJ44YjQxH2YAyUFly17Hk6+BmT2RjGV7xCk2zBxZM/zYNE/cy8PCvDZFo90ou6lZNZdlGPyh9yibTqoacSBc9m9pB5f7kNX49VG7QawuFKRnhmAN8VYL5V3m7e7naRrApFzM6WSvU6IbBkBT+0WTseeGlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752625782; c=relaxed/simple;
	bh=eIiuVBlfo02lyIT3V1fu69Cw3GW5a++j976aLbRwJRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=az144IRhq7It0uSwB1tPsORQckTPAYYXhxMlRIdGSJynLRobgCRkjwi51mD97jEc2+LxK/XUrxa96ULeBMPtyLMGZJfNs2picccl5Mr1RwTTmRRbVWKRe3CxM2M6eDfCWMBel2gHWUzf+72hc/dLv0stGjl7s5ir8t6JyupDwx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQBJ59jv; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7490cb9a892so3672977b3a.0;
        Tue, 15 Jul 2025 17:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752625780; x=1753230580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtCHmfEP5YnQ6wrmUx90FMQC08fmdUCpc7zZpVMED34=;
        b=mQBJ59jvub2NiPdjMCGgtMueREs0zcR9GTXgYfhlvBe5ZZ1tbn5laIiyIYVg3vtCKJ
         G8e5IT7lNxiYlj9rJSdApBGXC0rbGmxrM5tyg4iask8BA5jdM9b0Uuxj+JhLLj0dnAdG
         MLRixRruybQehe56YBsma6uy4abPvUQpvEF+0DJ+SIW1L/806COXe+/zyiy5BLFavknR
         x+qMonSIx+FUaqGPjnx0PjNLnD+wXvSi0tGp7Cghwk8c/SEteSlskM2O27kecXy7F+nz
         BLCydoBIlKz2cpZZzX38aHt73+mf2w8KIJV0UfGpqn1cmL3NMqDQY43Vu0DCUtUFbO1+
         8T2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752625780; x=1753230580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtCHmfEP5YnQ6wrmUx90FMQC08fmdUCpc7zZpVMED34=;
        b=eQfijlVxE6x6WU2layo3+CQ15Snh2mUQzD2nbch/onKVbI5qBWfkPQ33N6p/7KJSYD
         7PgjcS+vHBL11uPf3ZbqdspD6KouXMAHt2q4geolJVzBzHPi0kyuAs6xdBVB3NPyI6td
         +Y66TmXdfAkcoaeQn9SsdXAsLRt32ZLFcF2yFFF1aEen2WqX4U62r9f2bZCuz+e2kSRZ
         zqVDC7Q1njZBE14y/ju62LiQWTBVeZ0LYz9P7fdhS4YM5FkqNsOwyJlitm2H8thLUL0Q
         SL5qTcz7HkzEiqxc81vem8TKKiZKjy7YZv3xVkL2DYrY9HGezSWVR3veQQhe5VILRLFn
         EQGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOnHKIE+AvTIxMwmnB8U0EZp9yEVnp1NHuFjvizv8n8wzKKY9qU7x+9tDdQsAFgxmdFb2Rw+nciXU2DlVx@vger.kernel.org, AJvYcCXCwER5sDFYVyX9K/hW346D7wSXFpnbrRHfk4tbE4k4JqcUawHGVesWxgA1Ufpo5VKI63553noirRRi@vger.kernel.org, AJvYcCXwCXkt51p6FOSMYMyR6EYrR77Ls9wBO9J5ct8WQiqMEH52x2ZXI99atpZmN3czlNDAP3bvjoZo@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu1wXjIsyHfid4bh+1Ex+MpB9/d1L06tn2kz4thd88ueCgVKuU
	iynNOP76KUaTSZTn7l3q3oOeS+A9oY3/2Svc+2mC6OzL2R0Nx3MmWsjo
X-Gm-Gg: ASbGncsyfjdAEyQ1cBPsTWqLtUxbqa1CLCENt7vdcYac5MGeLbuNZV62mIMjZWpgYMN
	Qu961YAxgQN+FUEQinZYZXbhEB4sE6ctmVMnMfBZjzz32tgfEfaeNdv2kxn/In32kybvBuLZPET
	7sAFfqDMJKFnqS5G35iFIr/QB0WTim+S13IMfTgL9RmD03ziYDSPiGz2Uyqp+kOD5A5+c/Gv6Q8
	qvPDEMLDLV3vw0+BzhZmuAjwKGjx3O8B1lDZr2kOrK1NLwrpGYQ/QtL9Y2dHGGYKyRhj4ntEqyL
	+rbY+T+4xEeydntWUXtLGSer9NOGTCIL/5cpx5v4oE0weswKwayOI53G+VFmXb1fOw+wpcyVcT2
	ErFXm1/NXD2fR5idok/JVWC8+n3IcggG2fdD3lT6sNmYvkfew2lA=
X-Google-Smtp-Source: AGHT+IHVIQeLxJQNEcZE7S+tUeXrTSlGNF+2amX6NRegRxrig3WU8EvvhlFdVvNHx5R6bjyIQJXgUA==
X-Received: by 2002:a05:6a00:a8e:b0:748:33f3:8da3 with SMTP id d2e1a72fcca58-756ea3ca5aamr1988478b3a.19.1752625780001;
        Tue, 15 Jul 2025 17:29:40 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ebfd2d26asm11145720b3a.76.2025.07.15.17.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 17:29:39 -0700 (PDT)
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
Subject: [PATCH net-next 3/8] dt-bindings: net: dsa: b53: Document brcm,gpio-ctrl property
Date: Tue, 15 Jul 2025 17:29:02 -0700
Message-ID: <20250716002922.230807-4-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716002922.230807-1-kylehendrydev@gmail.com>
References: <20250716002922.230807-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for bcm63xx gpio-ctrl phandle

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml b/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
index d6c957a33b48..c40ebd1ddffb 100644
--- a/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml
@@ -66,6 +66,11 @@ properties:
               - brcm,bcm63268-switch
           - const: brcm,bcm63xx-switch
 
+  brcm,gpio-ctrl:
+    description:
+      A phandle to the syscon node of the bcm63xx gpio controller
+    $ref: /schemas/types.yaml#/definitions/phandle
+
 required:
   - compatible
   - reg
-- 
2.43.0


