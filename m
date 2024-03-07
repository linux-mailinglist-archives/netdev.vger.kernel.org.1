Return-Path: <netdev+bounces-78312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59371874ACC
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 10:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0681C20E5A
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D10C839F2;
	Thu,  7 Mar 2024 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg0Y2dKB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6176839E7
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803601; cv=none; b=uNYzoTMykVGmgypjSVaovMgQG7MvMuBb224Ot6Pdev2zc3kUUrTT8bYr/Yom1zgFWmEkJxEh4/GQ84gDuueLV/7C8TaPnpIic8q/ET1YUHXr6iwYryhX3EYkBTh/Aj4on2HQm2O2++aIwR9oqW4612RK6bjtrMWaWy6wAV4Tth8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803601; c=relaxed/simple;
	bh=zxubxdQpMf/J+e957cKvI24zoM76HtbiuIgv9vI5edw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jCy3AhA8ofD+NahAB+roHyZC5oADzqgJVh1rSmot6T+rDSFczdkS+pvC4LzDHJwFE9+UPc78zwVxxpxNfRfvSdjwWUNkG8jQKg/tCcgk+77G4JFFGifTL6v7yIltXHXyEp4WC5UoapEYoXanQYafwVzjBQagIvxNbg9at8nicko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rg0Y2dKB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dcd6a3da83so4653575ad.3
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 01:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709803599; x=1710408399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X2PM83S/sTsbcKGFI8zRbeKRaDLEoOwaLLfoTCoFLwc=;
        b=Rg0Y2dKBU53F1+9/VhqBrPxyAh41WAoOFF5/KR/RrslGsGJsXDrCJeXMFlu3KdRvk9
         BMmLzqoSaCEoXaJ64hR9U7eD0DtVn+Nit8LKdBf8Pz+CSkZ1RYsxv1lpEnORqxUYxrnD
         gx/FTUxVZ41iTwbAHl8sq+Zv7AkLcgA1Gqz7TQAp1kWMh3TIiG5EugMCaTDYF1qUKm/H
         skDm+UXrP7ytKy+IS/44wh3LWxRNdU4f5LgcvXqhEPXDJtvrD4QEAetBefANI1Lt139V
         rB5hjmoyAM8WFH00xUOfg1JOSBfRRTCoZGQUCEKt0IG0bO0lJW6S+QxJytD2BDhuM76b
         aSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709803599; x=1710408399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2PM83S/sTsbcKGFI8zRbeKRaDLEoOwaLLfoTCoFLwc=;
        b=uJsIu2HqfqwVCRy1GCHtaoxOqt9UV++/9XMUPxJ5HACixDM4BCYMlfC/cjdBpvJ5+n
         BX6+X5sgL5IexWobE/buN6ECJfV5rOZbS52yPp1J2NpXhqd8vVVps3PQMH5z/n162EQP
         F1qjWKB3/kahoRR4dkvvi8JKV0sCwAPwHq+CeCBviC/NjM7nA58IdCZPznumZt8rfG1L
         q01Oubx/+lhkJQxv5F9VZg8bOw4dkSRpKSsyurqjQen2WZbnoUKKalOYNKAxTbGw/RKw
         zi/cLnBqNgzjegmty2euOVu5QHauXFRTQyq3EFMwg9Vp4RBohoZ+lLgLAN5aiJD/1tG5
         8Gxg==
X-Gm-Message-State: AOJu0YyIPJFbolgTpSR08/KrQ5UW+Jw8eF0FLNyaj0yn/9my+gZEfTvn
	f3jgxG+Y9uqHP97OKrDMPcHAVoUhAjPyEL7oiA7uMppdd7Dkxf1c2t3g/lHhzZs07A==
X-Google-Smtp-Source: AGHT+IGHLZz1G6c3npPIb58ZpTbbj3+GLxYKC5MBf9h7LMmNmQsxx9p+WbIf/1sdLkTn0Bk7c1PL1A==
X-Received: by 2002:a17:902:eb89:b0:1db:c90f:e189 with SMTP id q9-20020a170902eb8900b001dbc90fe189mr8148150plg.57.1709803598615;
        Thu, 07 Mar 2024 01:26:38 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b001dd2b9ed407sm5153424pll.213.2024.03.07.01.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 01:26:38 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Donald Hunter <donald.hunter@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next] tools: ynl-gen: support using pre-defined values in attr checks
Date: Thu,  7 Mar 2024 17:23:57 +0800
Message-ID: <20240307092357.1919830-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support using pre-defined values in checks so we don't need to use hard
code number for the string, binary length. e.g. we have a definition like

 #define TEAM_STRING_MAX_LEN 32

Which defined in yaml like:

 definitions:
   -
     name: string-max-len
     type: const
     value: 32

It can be used in the attribute-sets like

attribute-sets:
  -
    name: attr-option
    name-prefix: team-attr-option-
    attributes:
      -
        name: name
        type: string
        checks:
          len: string-max-len

With this patch it will be converted to

[TEAM_ATTR_OPTION_NAME] = { .type = NLA_STRING, .len = TEAM_STRING_MAX_LEN, }

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2: Update the commit description. Drop other controversial patches.
v1 link: lore.kernel.org/netdev/20231215035009.498049-3-liuhangbin@gmail.com
---
 Documentation/netlink/genetlink-c.yaml      | 2 +-
 Documentation/netlink/genetlink-legacy.yaml | 2 +-
 Documentation/netlink/genetlink.yaml        | 2 +-
 Documentation/netlink/netlink-raw.yaml      | 2 +-
 tools/net/ynl/ynl-gen-c.py                  | 7 +++++++
 5 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index c58f7153fcf8..8c2363ddee03 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -11,7 +11,7 @@ $defs:
     minimum: 0
   len-or-define:
     type: [ string, integer ]
-    pattern: ^[0-9A-Za-z_]+( - 1)?$
+    pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
   len-or-limit:
     # literal int or limit based on fixed-width type e.g. u8-min, u16-max, etc.
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 938703088306..75ed5c773a0c 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -11,7 +11,7 @@ $defs:
     minimum: 0
   len-or-define:
     type: [ string, integer ]
-    pattern: ^[0-9A-Za-z_]+( - 1)?$
+    pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
   len-or-limit:
     # literal int or limit based on fixed-width type e.g. u8-min, u16-max, etc.
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index 3283bf458ff1..d7edb8855563 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -11,7 +11,7 @@ $defs:
     minimum: 0
   len-or-define:
     type: [ string, integer ]
-    pattern: ^[0-9A-Za-z_]+( - 1)?$
+    pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
   len-or-limit:
     # literal int or limit based on fixed-width type e.g. u8-min, u16-max, etc.
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index ac4e05415f2f..4917beeb046f 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -11,7 +11,7 @@ $defs:
     minimum: 0
   len-or-define:
     type: [ string, integer ]
-    pattern: ^[0-9A-Za-z_]+( - 1)?$
+    pattern: ^[0-9A-Za-z_-]+( - 1)?$
     minimum: 0
 
 # Schema for specs
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 2f5febfe66a1..745eb48e8628 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -77,9 +77,16 @@ class Type(SpecAttr):
         delattr(self, "enum_name")
 
     def get_limit(self, limit, default=None):
+        defines = []
+        for const in self.family['definitions']:
+            if const['type'] == 'const':
+                defines.append(const['name'])
+
         value = self.checks.get(limit, default)
         if value is None:
             return value
+        elif value in defines:
+            return c_upper(f"{self.family['name']}-{value}")
         if not isinstance(value, int):
             value = limit_to_number(value)
         return value
-- 
2.43.0


