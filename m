Return-Path: <netdev+bounces-119651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B129567E7
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0B7281221
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE3715F418;
	Mon, 19 Aug 2024 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqSjIXCK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C915F3EE;
	Mon, 19 Aug 2024 10:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062407; cv=none; b=QboAHB0KsWJbyiOWO51yTqhujaQ3yO2IZR44uoVHz2EkWpblDQYmGzF/Ur1Mct/spUb8S4KVf5K/lrR9i64j3tlrIOcvCVy0/Up4v1FhJOZMYix6tGq8eL91N2GObapjGH9ALDuOLU+lb6+huqviCmr7O4QSbxq3MDBzV/8UXNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062407; c=relaxed/simple;
	bh=YQLM8o9fy5idEF5/z9F97EikKv6l6cGrw63nJ9lhSTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pb9Y3dRcQ5T8ppdVjqnCS1TNfqkSQnTouwxDk0XK/bafCC4G8toeOdQn5deXEg9bM/Uq7Gj9wraHQYg+hrrrIOZqaS7EiSTKRYtjLFrCkeM/pOlEmrX+gpPi82dRThXZxsHpyiuU1uUCpogjnYhsTihQx0/TDuvskN1xs5dfUOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqSjIXCK; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so294169866b.1;
        Mon, 19 Aug 2024 03:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724062404; x=1724667204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rpmXjvt65dcgn9PdN1lHowqP9gEPK3up9i/guynjyLI=;
        b=WqSjIXCK81C/Z2neOei6GM0oMWPUt+nDRK8acUJQ1pixFav9UY3fKAkNgHgGtw4Zy3
         ZtzYkIcbgy+BrFwnwiYcmoUWvN5o7sz2rNPN2d+WOhYD32gSZUwjvhxyCjAaRkyM4YLR
         OGZsS6eAFjCgc4mhrPCxIiRoAPxJ5/XG/GVdZReisYvnVexm8OXsygQe2zU7Wvmw/eP2
         aWlCGtw6TElFG3fsP/aQEuJzzqI8kmOV87xiqgjzoSL9J3AFkRxvzNcxvY+kHn0MhphG
         rEQ7ov0jfLvrRf8+kdnE2I6X3aO57SD7R+BiCn0akQNwgMy4CsKKBR9w+EM0emTUXdib
         SQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724062404; x=1724667204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpmXjvt65dcgn9PdN1lHowqP9gEPK3up9i/guynjyLI=;
        b=H8QA/h1074fRubyzOTjPavgEZTdGxkRX7YJq5XG9xTMMnUTL9h3ZzUkTpeBdyc+u/d
         gtXt41AEj7OTHE3o7ElMjrM8GkfVZUfnGovLQ6f6s3D/cc42/7oFddUYUa6Rrp4MIiDU
         mpCOn4iaK456W5Gr0+8kAfXxWov1+D1/4vcuSZ4fngTEq0XEv0BPlg+2TJPrKtL6Avde
         2AT/CoHZP7gs6zp6nb5YD2hsHsewT6P0RwZ9k2qBshp+Kl7qRldYed+iWdJfptdQEEbi
         7rIOnIV618LDWTtAcm7zKhHsSMlpqak9SSr+vtyJ/In6E8sPw24cazTcRmvSsAk+SBuK
         Q5gA==
X-Forwarded-Encrypted: i=1; AJvYcCUVK/LLJEyjXe9CzUbnaQVR5mq1twU2BFjsYTasMJOCTtPobyjQKoUBx+nXjPUb1oxHJj09MQJD@vger.kernel.org, AJvYcCWBGot41jWmWm3qbukcI7OrA+aRAgadgZmzYWi/0QX8mV0x0Uiy/8qGBUHRtREiCxCmqWrIVs8AduikC2US@vger.kernel.org, AJvYcCWIlye49xLJFPXsd0Z9hmz9Ey1EjORsiILscv6mnAZ7PcH0YDSL/BJutMNZXZ6QJLW+s6Lp23vO6nVT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz509f0UuJ3XWSbWS0r1jKD+wWmyjl0k47OWnVENqY+GZqgsUU6
	r6WINjOfJkAhKxrHKlBT1+22200lCcE30jcmjgChCvyslZrWIwkb
X-Google-Smtp-Source: AGHT+IF/Q5IwAxhEZ9N40GS+cHzsfayz5XPtSNhFPGp2kJsv97tryUwH34I7AnFdI4kOb7swbe7VGg==
X-Received: by 2002:a17:907:6d2a:b0:a77:d773:54ec with SMTP id a640c23a62f3a-a83928a35abmr860206366b.8.1724062403490;
        Mon, 19 Aug 2024 03:13:23 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396d5a7sm612749366b.217.2024.08.19.03.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 03:13:22 -0700 (PDT)
From: vtpieter@gmail.com
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] dt-bindings: net: dsa: add none to dsa-tag-protocol enum
Date: Mon, 19 Aug 2024 12:12:34 +0200
Message-ID: <20240819101238.1570176-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

This allows the switch to disable tagging all together, for the use
case of an unmanaged switch for example.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 Documentation/devicetree/bindings/net/dsa/dsa-port.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
index 480120469953..ded8019b6ba6 100644
--- a/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/dsa-port.yaml
@@ -53,6 +53,7 @@ properties:
     enum:
       - dsa
       - edsa
+      - none
       - ocelot
       - ocelot-8021q
       - rtl8_4

base-commit: 1bf8e07c382bd4f04ede81ecc05267a8ffd60999
-- 
2.43.0


