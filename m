Return-Path: <netdev+bounces-130068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE30987F85
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 09:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38071F20938
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 07:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB0717837D;
	Fri, 27 Sep 2024 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyaHN9Aq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7748116D9B8;
	Fri, 27 Sep 2024 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727422485; cv=none; b=UXsDQz7F3OxZjCCQu9lRONaDh7GVdD7TVScWJZkJVd8iYTO1v8h+Z34WjoEW/vWWRLscQinAtEs58yoiuwJIJnPzpGuTvVBKYZweN5YDI9MZVCHovj1CK9dEqI94JUc9ekaSv6E9Ij/0gjPJHZZTDHF/M4ykVkbDxyVFtvHDLWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727422485; c=relaxed/simple;
	bh=F8xZbzcZKi7D9RO1xCzeGmIUlk5LUVrjx/z58Sceu/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L+713T3Ee0f1cQHitfcX+T3ww19S+n0zxTn9UX+X2UwLOI0juCpRgVVDDcjsOyL1VUFB+1MGgIqrfnOxluWlQIDvi+jHfXoXXnJX4HRcSUcwQQFvqCoYziGB5NhO66Nd8KmnL6wWfpncOU31KUYDbCyqe0GUdCvf8ju99u1K9CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyaHN9Aq; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5369f1c7cb8so2413860e87.1;
        Fri, 27 Sep 2024 00:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727422481; x=1728027281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z+Vt35wGDJ+l3jGYxFgHKnj4OlEwqHkTiVYdeonhxt0=;
        b=gyaHN9AqrAEafnetieu9KLbDUYa1MQM8yFvhera4IX5G0g1v6G+ecfGLQkxuQlz249
         bZjXZP2jPNoBfBx6bYYhayBv/cTcUjXu8ZJ9yAZoGvcQqjyXvqTF+0bhJiJ9bkPkznC8
         Yoygdw065Z3eHOrUHHyY+00JlJABh+dZ2qCQxmoX3zPg8urtEQLS/qdUTrmCF6cabs+a
         VWTuEYRB3O8TWUxi8iZWjgofstIgE5IjJezq1uRPZv8u/g/wMf7pTNitgkmMPzTYSGQ+
         1RLG5ycKLQCvd3KD49+0QZY0REfLbkpKZebP0KVN2McTnGMTU14eLycq03VrsAEvC7+n
         IkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727422481; x=1728027281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+Vt35wGDJ+l3jGYxFgHKnj4OlEwqHkTiVYdeonhxt0=;
        b=tw6hVY/qmkQoPzEFVpYk6TkvLhIlTw0AYM9aiI29QwUgSYQyXJKu1dC9iGIV/I6y4A
         ihREY/17m92fq2vskdrLNEm7wqKsC+9jkCZ/jCG+63nBesFOLooVrznXPkiQX8hbNbML
         X9CuAyCKExOjiVjSzQ+O8XKqhb5qMC0928XOUlvFKmIIIJYWaftgugeYQWZ/Qq08Fdjq
         7hseeIyWb21UimkZbd+B/Da57uD+0ppNGQQSkAZRqfwFHa/uWG2MXhnfKAXnn/ZiRzxY
         SB2h70iqi0sJ4GdbnRpLhPsUOeijaNpnI1I2FXC2pHFAN58GfuI5gsQpOfmsUHdDCP3o
         2uiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/SF2AGhF5UTfukXzWFYKXqjYN4ItQh+5Ry1DhHlVSGvEXNdUoOImkQAKzUIe9BtkulMB+h+rD@vger.kernel.org, AJvYcCWChLr7SZnLdcdfyPICMvrY4ZkPh94cFckljWBn13zP5vANCYI1XKePrmjxwsu8Oc/XcmWiVOuFdvEAFvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj1Lpzy7wrQ7Q7zqf1hea09mL2gh2aidqjxtPpplc/jXhWYTOP
	aOX5wMHWQ4D4MFfyavKw9TlKxUvBp7TnDx6OmUP3yo0caD7oQ4Gs
X-Google-Smtp-Source: AGHT+IH3C96bwI2LsCmLv1jZkKdOlGuDYT4VudVpPDJSuSHjDdE7Z0Njhr4b7xvwpKFVjhkvBJMTIw==
X-Received: by 2002:a05:6512:3c8e:b0:530:ae99:c7fa with SMTP id 2adb3069b0e04-5389fc29c3bmr1381659e87.10.1727422481196;
        Fri, 27 Sep 2024 00:34:41 -0700 (PDT)
Received: from localhost.localdomain ([213.174.0.108])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5389fd5491esm212558e87.28.2024.09.27.00.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 00:34:39 -0700 (PDT)
From: Volodymyr Boyko <boyko.cxx@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: boyko.cxx@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: retain NOCARRIER on protodown interfaces
Date: Fri, 27 Sep 2024 10:33:30 +0300
Message-Id: <20240927073331.80425-1-boyko.cxx@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make interface with enabled protodown to retain NOCARRIER state during
transfer of operstate from its lower device.

Signed-off-by: Volodymyr Boyko <boyko.cxx@gmail.com>
---
Currently bringing up lower device enables carrier on upper devices
ignoring the protodown flag.

Steps to reproduce:
```
ip l a test0 up type dummy
ip l a test0.mv0 up link test0 type macvlan mode bridge
ip l s test0.mv0 protodown on
sleep 1
printf 'before flap:\n'
ip -o l show | grep test0
ip l set down test0 && ip l set up test0
printf 'after flap:\n'
ip -o l show | grep test0
ip l del test0
```

output without this change:
```
before flap:
28: test0.mv0@test0: <NO-CARRIER,BROADCAST,MULTICAST,UP>
	 state LOWERLAYERDOWN protodown on
after flap:
28: test0.mv0@test0: <BROADCAST,MULTICAST,UP,LOWER_UP>
	 state UP protodown on
```

output with this change:
```
before flap:
28: test0.mv0@test0: <NO-CARRIER,BROADCAST,MULTICAST,UP>
	state DOWN protodown on
after flap:
28: test0.mv0@test0: <NO-CARRIER,BROADCAST,MULTICAST,UP>
	state DOWN protodown on
```
---
 net/core/dev.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1e740faf9e78..10b0ae0ca5a8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10198,10 +10198,12 @@ void netif_stacked_transfer_operstate(const struct net_device *rootdev,
 	else
 		netif_testing_off(dev);
 
-	if (netif_carrier_ok(rootdev))
-		netif_carrier_on(dev);
-	else
-		netif_carrier_off(dev);
+	if (!dev->proto_down) {
+		if (netif_carrier_ok(rootdev))
+			netif_carrier_on(dev);
+		else
+			netif_carrier_off(dev);
+	}
 }
 EXPORT_SYMBOL(netif_stacked_transfer_operstate);
 
-- 
2.39.5


