Return-Path: <netdev+bounces-79164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8313687814F
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 15:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11D11B23064
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 14:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410FF3FB2D;
	Mon, 11 Mar 2024 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqEycfHN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DCB3D986
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 14:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710166058; cv=none; b=W/BBT0Db3kBLBmY349uun14x6vFcByudnm+vD/OA7T0d9xDT8qYVSG+urpYodUJm0DJmVUntVFawjMP3272n6GRpnz9Sq0sxg9ZrVB3Cf0np6scAxtQSm+VcfC7ysxJx10wrbELBIhkv76MsUTVDM4UN6Ys4FVospMzu1CZTGPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710166058; c=relaxed/simple;
	bh=VTZozU3fvTIYRT/5FNjIDNW07GdYS1vWclel/o5A0Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UprHfs83L+xjHEA3pz6aVaVmyd5E1ZHbM1+XbwgG7B3DDKyNsbpsJOvGeGYac1cZxxdRcFsdgjcvJa/DVSqUeXpXLK/f/l81lZqTdK6n0PFnWYSzN1Q17VkVtu92d5F2kLTfjZcgwejEkPbSftluU5CcAnJ1iQqNwFxzmX05BV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqEycfHN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dd10ae77d8so32992655ad.0
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 07:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710166056; x=1710770856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rTSAwCyTAgVkMwdpzs1jGvtnlsvnxtbVScClSpYyDTs=;
        b=aqEycfHN69ttM2XjGhFIAp7Fn5Z88CHByvd9etZqVQNRwm/lvHeHJJIKP+igouUMCC
         vojsylcva3SR1S7UrdrRB2cG8wK8VPDr+QZ43aXYRlOqSUijUW56XZgrj9vIvhOzwH/r
         Pj+pCbNus/6IIlzdsRZx+9ticeT+CkvCXanHcSJFJUbbIMaA4phR6xBmlngcjvTS7SQX
         DEblEuueugJFMzbIkLz/VuEz9JAh5D1AzRkbr1GytPBq1ZliNR7nhgZBDNbkn2dvjr65
         VDyGCpBHO6isb0ST85TK5Iix5PYeIA8NEAMfmpbNG3MQjXpyL/fnGAVUhopbCf3VClIC
         w7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710166056; x=1710770856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTSAwCyTAgVkMwdpzs1jGvtnlsvnxtbVScClSpYyDTs=;
        b=mZYY0N9V0UrlYIzVPot19KOxpgcyN3PFrrNk8SPGw/adzFGgXn0SVMOX2ImAJpmnuq
         bOdGo6FmwCLHWSMRpLE5pXHDKjg/KIhkOnfYZZqwL0W3jNhPCyPJYA4PLZ9MM7Qsa4nj
         kHZsrskoRwbu8I9jmMtqMEg+va0TShrGY/Dqwtjq0TbcKbPAPM0wlvrSOU093AdIZMjt
         mAUcK8k3G6uZegBwkqV4mFCW+0DMTCjAWtbbaAiWvOEo0u4Sgldig96V717DCqL1vmcU
         9Mn0gdhW3xO7uRQ9iBFHHMyYudgqAtMmcc/qwYkA8imtqNmMU8o4YLM0/GxuRyTMU3Wn
         bdYQ==
X-Gm-Message-State: AOJu0YyEJ9ddFg+fbfWpQjBbybW/u1ectbL6VYOruCn095y+1EsRcUFI
	gWa0zpOJE1Fj1VtaE5oH12GXIofzgLwXtT5tHuvp7DJUleY7/w+0jKQfqWQnfwXHGA==
X-Google-Smtp-Source: AGHT+IFl1udJrdmKeousKGfDAq/8100QBfQbhmg0YoYOJYZBA5bJ/o5gRRAoiqjSsqJHKrKP7BUVTw==
X-Received: by 2002:a17:902:cf0b:b0:1dd:a88d:9294 with SMTP id i11-20020a170902cf0b00b001dda88d9294mr1404651plg.6.1710166055838;
        Mon, 11 Mar 2024 07:07:35 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n17-20020a170903111100b001dd6412cbe9sm4713105plh.252.2024.03.11.07.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 07:07:35 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next] tools: ynl-gen: support using pre-defined values in attr checks
Date: Mon, 11 Mar 2024 22:07:27 +0800
Message-ID: <20240311140727.109562-1-liuhangbin@gmail.com>
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

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v3: iterating over self.family.consts as self.family['definitions'] is optional (Jakub Kicinski)
v2: Update the commit description. Drop other controversial patches.
v1 link: lore.kernel.org/netdev/20231215035009.498049-3-liuhangbin@gmail.com
---
 Documentation/netlink/genetlink-c.yaml      | 2 +-
 Documentation/netlink/genetlink-legacy.yaml | 2 +-
 Documentation/netlink/genetlink.yaml        | 2 +-
 Documentation/netlink/netlink-raw.yaml      | 2 +-
 tools/net/ynl/ynl-gen-c.py                  | 2 ++
 5 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 3ebd50d78820..24692a9343f0 100644
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
index 1d3fe3637707..b0b7e8bab8a9 100644
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
index 40fc8ab1ee44..57490e5c1ddf 100644
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
index 67bfaff05154..5bb7ca01fe51 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -80,6 +80,8 @@ class Type(SpecAttr):
         value = self.checks.get(limit, default)
         if value is None:
             return value
+        elif value in self.family.consts:
+            return c_upper(f"{self.family['name']}-{value}")
         if not isinstance(value, int):
             value = limit_to_number(value)
         return value
-- 
2.43.0


