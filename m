Return-Path: <netdev+bounces-199780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7020AE1C67
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9996B1BC8260
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D95294A10;
	Fri, 20 Jun 2025 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joBAyiRa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78CA292900;
	Fri, 20 Jun 2025 13:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750426928; cv=none; b=HW/IKZOBg3YEpHONJsDmZ5ARTOh8yntGNMC/rQYkXwmk7Q2LNC/U6z0ISyngtp0tMuH4y1T5glwx9fuAE+l4jIlrjkXyMubc3MlZ7QOpUopW6kIwmAT10ZfNFLxYi0BvpSFPVLSPzXEY9maHRFU0tQ6AVcixrJPT72+iBi8pyko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750426928; c=relaxed/simple;
	bh=eIiuVBlfo02lyIT3V1fu69Cw3GW5a++j976aLbRwJRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XC8anF8jW7PDRSTl2KWS55WW0nINAGMkbbcfjjzaAIjN71RCo9RIayxd3zufYQ2Mt4pPIhZZjm5RDqFs2llpIgHOAdWJ72T2G0UIfirMsnER7/iZwlXxQKtQBfpI87qhvAhh4SuS/8Bfa7Ta6Xdj402tk50ci9GbZfhMEUGOgxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joBAyiRa; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23508d30142so25649055ad.0;
        Fri, 20 Jun 2025 06:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750426926; x=1751031726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtCHmfEP5YnQ6wrmUx90FMQC08fmdUCpc7zZpVMED34=;
        b=joBAyiRagtbgCGGIVmHe63oAO+/cSsCv/CA30fptla3xxS88UV+fXgqAtBNms/wM30
         JF3f7cjSF+eUhmedAIv4bZsRR0cosUAXNyng4pqG+6Ld7IcfDxLIHjJYCjXWML1yGaPP
         ukK8e6S76K9jtznGaWq59fOm7fVV5jpj8j1k7VcV65WCXJPM/4eLkV8v5+/jg2T05Y/6
         qsakZ7zKhDsUV12+jRWGEKcjoNg+CEiK1moSYszslwTlIOMfDvVDVgwQUhrM4o3aeOAI
         YKbQ3iBMiotv1Wivi+3mkZFLTPwkFXTiiaUKnHu3Fd7317CzzgiWi9ddfYPcz1cvV4CF
         cUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750426926; x=1751031726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtCHmfEP5YnQ6wrmUx90FMQC08fmdUCpc7zZpVMED34=;
        b=fO15BMnEOeb3y/S1qHnosVhu2grQeGB2jfsnd5qxhLCgyjL7BLgYvmLX8ylcwalsBV
         ZkU23byp7DI3Ic2i2emcXWmTSRde6OrHyFdwDyctHufdp7HEaPu+yQBDxqeoQizS25Ld
         ORaXvx390zjM2b73UD8Fqa8aJVIXS4g0OOQMwP+qgoB8WvlnwaMwMF+27FN6o/7D25Cg
         CgMkg2XtDrvAaIqZPGly5jj/CCiAeC+WXfdqvrsNzrm96DBP7KzUSSzyYwmTGtPt0/PU
         LVR0DpvWebmZ/XNMWFwf9cHUxBcJXAu6UMmxKMjSoky0dbtajgcF5M8hc2MZUaWFEU5B
         BwhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFU7RXL35JJqX0UmddICV99OM9bZinwjN3fkw5T5QpUopBgews38GTTwfxFgzEWMS79pb4qnDtmK2W@vger.kernel.org, AJvYcCVq++DmRfHI+Rk9FzSW06e7+Or6ooqkwwRizekL34lAvqJbmU7WYSeSBY83AVAMQcgZKqPy/sAz7Xty5245@vger.kernel.org, AJvYcCXX4hUowoSaGvFuekIZFce/kQDrAhZWvGtNU53b9dI5DGZp9115TCOPo2hYbR6L2EfLkIF9F6sY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+EwkQ5AQYro7Ssz1aDu6qH0vxu3Y9VRrzwvwMQcxRvmH2innt
	3pHF+VKKGhki/t1RC//I5SZG/m3n/KLRWONBysmouWaKbFN1lM97mKDi
X-Gm-Gg: ASbGncs1BO+ofy24fjTDSlVERB7qMTxnPqtyx7Rp/c5wxSpd+LfIGcX6GWgl8ChysSx
	e6pBAczFQ0o8l2Zs2+W3eU0uemEktZvBdaQXFzW0O7fBzV4MWKGfm06iW5IvBYdLw9evf4VsqeL
	z+JGyGYj8Vm225+cjv24nTcYS1UurLkie9IF1g/kA4PlUA0HxLgBh1ssChBgaYbV/aCY+kY0D/Y
	Xp20vQzazl6s0WlDTHrKLtNI19gtGQapwALE53glhbQbKkltk68uEY8aboiQaiukz6S0SnlqCT8
	w68DKPUnEe2MhCvsc54qkF2ZhUGgDkNSx8ChnAChV7tjKlkZpcQbvWDXN5ef3K4C1sgLQ3pesih
	lY9Py
X-Google-Smtp-Source: AGHT+IG3DXSD4t64F9fyueP0r4yQqhl3zYfjVhDf4TZRAk46wMKvnfDgiFmqk/fbXTrznYBnGe20CA==
X-Received: by 2002:a17:902:dac6:b0:235:ecf2:397 with SMTP id d9443c01a7336-237d9a7a3e8mr51879305ad.33.1750426925680;
        Fri, 20 Jun 2025 06:42:05 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d861047fsm18885505ad.134.2025.06.20.06.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:42:05 -0700 (PDT)
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
Subject: [RFC PATCH net-next 3/6] dt-bindings: net: dsa: b53: Document brcm,gpio-ctrl property
Date: Fri, 20 Jun 2025 06:41:18 -0700
Message-ID: <20250620134132.5195-4-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250620134132.5195-1-kylehendrydev@gmail.com>
References: <20250620134132.5195-1-kylehendrydev@gmail.com>
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


