Return-Path: <netdev+bounces-78154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B569874382
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9AF1C21B1A
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC0D1CD3D;
	Wed,  6 Mar 2024 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gthuaaJA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AF51CD16
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766660; cv=none; b=czUIX41cPdirTNRo6pu0uQ7wM8Dj+HxstR6er/yfGR/cDU6sQq2B3NQhRTjOxcYu3M082oT9Y77Mur46Mg37X676ydEs6xktwMYfmNwqp/V63Iqz7tHK7JxqQekKCTd051Of4ZdIv6UvQuvDNUYXPIbe1NiA78ivI8N4CEvdQ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766660; c=relaxed/simple;
	bh=0MKVABzlWNmbqJxZGdlvnuejy6g57xqzbcUe5hFUFjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6mnSoJcLve9E1O1rJNiabWzM0hD3stgR0LA4kawPNxXdU2NQXBY1GtO3i+kq8Lm3xU7rD0MkHiQfxRHpiMxdnCRfsZuR4af8NQBkugSukQUiXJix2C4U5eW2V5b/WAQTXMcr+hd0xutSjjiW6sqq7dQa3DtM+BXJqFERwoR10w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gthuaaJA; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33d9c3f36c2so73018f8f.2
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 15:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709766656; x=1710371456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBPut+azW4VgeZF5AoeAaAZK5YIORL8YBqXmq2t1sBU=;
        b=gthuaaJA5IVZdtErFwGeP8KPxGdKzlQvUkt/UB37U5pyrQxwDunXYJEH9JPkZt61p9
         PArGfvhfU9eydvubhWwQF76sN9ZUE+JgSObrTWeHrmZCjgYNKv18/dyn1gVtSzEMkHzi
         k8ElY0op5+QAN0UkJYIcDa1/DIe32KMnPn1Q8iHAZjPLlM0pPJaFgaK39bfvQo8u/eIz
         /5U3z2KN1YqJRzDgZNd3F/buVhnQ4xqxd4O+QESjvFvYX2WEtoilSjeFabhgQZrOKUf1
         PiQeakygFrNvdNosKOWOPEttJaISgPgKlxgI44WwJQSiTcJZruaUibl5gUs2GJeD4YFw
         kEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709766656; x=1710371456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBPut+azW4VgeZF5AoeAaAZK5YIORL8YBqXmq2t1sBU=;
        b=XqOyegS8qjdo6uNzmuUbGpRwaKNGKmJbodl7Wc3OUQvl2gLV6tjbaH7bkVtiOacRSL
         XReilUZfEs9wNE9d4W7hJnpVzQTgs4sWmcy2eqSkvgbPwYOSNUXjSpqlmgVkl1KJlgM6
         xjGN5rn9G5kmYS2L6e218w23m0DPhFfoJ12UlWoKahXHPR1dT9xmnS05iSZCi57YHfvP
         c+8Qv8P6ZRvVVVl3GALl/+KQ6WJMebhPEhXcAvvmIinFjZp1Du3eXWVO75qEQ0r9qItc
         xz5xItHVvAedDowe7pYqA+AjlWZ1W8QyMDKqzXUceTFoR8SxCAw5UJtExbbmr2qfSciP
         leqA==
X-Gm-Message-State: AOJu0Yxh8JNtmcsT/MdxtA1aXkb18BiRZcg31T7QxptNN7lLDGwQrwv6
	4Z1hAd1ZvevLJWo3Xajsae6/0sgQqbxZxdaPedqogs9egTm3VPmHNhRd81h6G6A=
X-Google-Smtp-Source: AGHT+IGvoS4INHBakPvguKSDC7cJ6YsMEKXVSRXuBTVMat32hY0MbMiVYbnbnS2YnMoRkMv7zx3loQ==
X-Received: by 2002:adf:f94a:0:b0:33d:579e:f462 with SMTP id q10-20020adff94a000000b0033d579ef462mr12303076wrr.36.1709766655940;
        Wed, 06 Mar 2024 15:10:55 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:952f:caa6:b9c0:b4d8])
        by smtp.gmail.com with ESMTPSA id q16-20020a5d6590000000b0033d56aa4f45sm18722810wru.112.2024.03.06.15.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:10:55 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Stanislav Fomichev <sdf@google.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v3 5/6] doc/netlink: Allow empty enum-name in ynl specs
Date: Wed,  6 Mar 2024 23:10:45 +0000
Message-ID: <20240306231046.97158-6-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240306231046.97158-1-donald.hunter@gmail.com>
References: <20240306231046.97158-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the ynl schemas to allow the specification of empty enum names
for all enum code generation.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/genetlink-c.yaml      | 15 +++++++++------
 Documentation/netlink/genetlink-legacy.yaml | 15 +++++++++------
 Documentation/netlink/netlink-raw.yaml      | 15 +++++++++------
 3 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index c58f7153fcf8..3ebd50d78820 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -126,8 +126,9 @@ properties:
             Prefix for the C enum name of the attributes. Default family[name]-set[name]-a-
           type: string
         enum-name:
-          description: Name for the enum type of the attribute.
-          type: string
+          description: |
+            Name for the enum type of the attribute, if empty no name will be used.
+          type: [ string, "null" ]
         doc:
           description: Documentation of the space.
           type: string
@@ -261,14 +262,16 @@ properties:
           the prefix with the upper case name of the command, with dashes replaced by underscores.
         type: string
       enum-name:
-        description: Name for the enum type with commands.
-        type: string
+        description: |
+          Name for the enum type with commands, if empty no name will be used.
+        type: [ string, "null" ]
       async-prefix:
         description: Same as name-prefix but used to render notifications and events to separate enum.
         type: string
       async-enum:
-        description: Name for the enum type with notifications/events.
-        type: string
+        description: |
+          Name for the enum type with commands, if empty no name will be used.
+        type: [ string, "null" ]
       list:
         description: List of commands
         type: array
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 938703088306..1d3fe3637707 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -168,8 +168,9 @@ properties:
             Prefix for the C enum name of the attributes. Default family[name]-set[name]-a-
           type: string
         enum-name:
-          description: Name for the enum type of the attribute.
-          type: string
+          description: |
+            Name for the enum type of the attribute, if empty no name will be used.
+          type: [ string, "null" ]
         doc:
           description: Documentation of the space.
           type: string
@@ -304,14 +305,16 @@ properties:
           the prefix with the upper case name of the command, with dashes replaced by underscores.
         type: string
       enum-name:
-        description: Name for the enum type with commands.
-        type: string
+        description: |
+          Name for the enum type with commands, if empty no name will be used.
+        type: [ string, "null" ]
       async-prefix:
         description: Same as name-prefix but used to render notifications and events to separate enum.
         type: string
       async-enum:
-        description: Name for the enum type with notifications/events.
-        type: string
+        description: |
+          Name for the enum type with commands, if empty no name will be used.
+        type: [ string, "null" ]
       # Start genetlink-legacy
       fixed-header: &fixed-header
         description: |
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index ac4e05415f2f..40fc8ab1ee44 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -189,8 +189,9 @@ properties:
             Prefix for the C enum name of the attributes. Default family[name]-set[name]-a-
           type: string
         enum-name:
-          description: Name for the enum type of the attribute.
-          type: string
+          description: |
+            Name for the enum type of the attribute, if empty no name will be used.
+          type: [ string, "null" ]
         doc:
           description: Documentation of the space.
           type: string
@@ -371,14 +372,16 @@ properties:
           the prefix with the upper case name of the command, with dashes replaced by underscores.
         type: string
       enum-name:
-        description: Name for the enum type with commands.
-        type: string
+        description: |
+          Name for the enum type with commands, if empty no name will be used.
+        type: [ string, "null" ]
       async-prefix:
         description: Same as name-prefix but used to render notifications and events to separate enum.
         type: string
       async-enum:
-        description: Name for the enum type with notifications/events.
-        type: string
+        description: |
+          Name for the enum type with commands, if empty no name will be used.
+        type: [ string, "null" ]
       # Start genetlink-legacy
       fixed-header: &fixed-header
         description: |
-- 
2.42.0


