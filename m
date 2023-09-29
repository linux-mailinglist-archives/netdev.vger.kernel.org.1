Return-Path: <netdev+bounces-37030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27B17B33FB
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 15:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5CCCF283DD9
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 13:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1E541A8A;
	Fri, 29 Sep 2023 13:47:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C64179B6
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 13:47:49 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D8F1A8
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 06:47:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b281a2aa94so1290009766b.2
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 06:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695995266; x=1696600066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJGMiysx/JfRAL6iX46WM7AExnXBLd3c6bT4aLtreL4=;
        b=kaAr/QaFu7d9i468dQPsMTfM16AJk4E1hKykmDUDrwrwLib/yBja2RKjlXfJdOTovT
         Us5WX6uM+nkeAfRntvIC3sThZ0N8N8AaD0jUe0z2a/5lj1uOGxfykIUksqVYGaJCl6v4
         AOPnj3vyDTtkHemvK4cyFf7NnJ9zCCIbOFxFq+mLH0sCGog0GiyjofAqpdCK0FZ7iXNi
         LVwODcKyN19sLoY1dirJ0iEyVdpdQ40EZrzfePlT2J4njGlsCE0DKffiOXdssBEUbs0J
         3qfb3FhLQYJYwKhO6t47wFG216LZmfJXbJ6Qf5i3LgzgW62C8dWKfFm/A/zJogLU3aUo
         ZQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695995266; x=1696600066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJGMiysx/JfRAL6iX46WM7AExnXBLd3c6bT4aLtreL4=;
        b=GgIC0wCuqUud43Pl2QJN6MgGeF9XyD9QkeAX8cJq1jdHk/vn0Dbwqct5EerqLTxZhy
         pG2x+0Y/YIbWXjJ66q4W9bhtWlDaQP438UgLR9CuxAsulBEgxdhf5+xF9FkReDJbRJgV
         Lf6o5o2g65MELlFQaC1i+21vfoVjeTMad80OS1AiA+J0ouAG6jsnk+0Bth1naimjBUbO
         M/Xi56mzeDL/UTLMEuEgkX0WZdiICkmxySFCC0l2u/CO8hS36g3neKEp2O2ct01hFGc2
         Dc4M8NQe/g+o9vdicwNREEHVHY08256aMa99GLay3a4Q6DYUfLeLcoMY1og74JZx92+F
         BzDw==
X-Gm-Message-State: AOJu0YzZlpiGBdoYX6kmucAGUr4UcBk6DdrB8PSArwuqY9x+hbc3m0fv
	0sZBnzyZ8JuTlOxEX6CDyKClJPag2dpZchASmmE=
X-Google-Smtp-Source: AGHT+IGxreHUNbAVxmJA0qiF3WufuAnfyhKvy1jR0RlP30FXWDIIScORftZBR9TyBIyJVCHixYudKw==
X-Received: by 2002:a17:906:32cb:b0:9a2:232f:6f85 with SMTP id k11-20020a17090632cb00b009a2232f6f85mr3966998ejk.52.1695995266066;
        Fri, 29 Sep 2023 06:47:46 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id fi3-20020a170906da0300b009a1fef32ce6sm12572151ejb.177.2023.09.29.06.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 06:47:45 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	donald.hunter@gmail.com
Subject: [patch net-next v2 1/3] tools: ynl-gen: lift type requirement for attribute subsets
Date: Fri, 29 Sep 2023 15:47:40 +0200
Message-ID: <20230929134742.1292632-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929134742.1292632-1-jiri@resnulli.us>
References: <20230929134742.1292632-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

In case an attribute is used in a subset, the type has to be currently
specified. As the attribute is already defined in the original set, this
is a redundant information in yaml file, moreover, may lead to
inconsistencies.

Example:
attribute-sets:
    ...
    name: pin
    enum-name: dpll_a_pin
    attributes:
      ...
      -
        name: parent-id
        type: u32
      ...
  -
    name: pin-parent-device
    subset-of: pin
    attributes:
      -
        name: parent-id
        type: u32             <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

Remove the requirement from schema files to specify the "type" and add
check and bail out if "type" is not set.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/genetlink-c.yaml      | 2 +-
 Documentation/netlink/genetlink-legacy.yaml | 2 +-
 Documentation/netlink/genetlink.yaml        | 2 +-
 Documentation/netlink/netlink-raw.yaml      | 2 +-
 tools/net/ynl/ynl-gen-c.py                  | 2 ++
 5 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 9806c44f604c..80d8aa2708c5 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -142,7 +142,7 @@ properties:
           type: array
           items:
             type: object
-            required: [ name, type ]
+            required: [ name ]
             additionalProperties: False
             properties:
               name:
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 12a0a045605d..2a21aae525a4 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -180,7 +180,7 @@ properties:
           type: array
           items:
             type: object
-            required: [ name, type ]
+            required: [ name ]
             additionalProperties: False
             properties:
               name:
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index 3d338c48bf21..9e8354f80466 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -115,7 +115,7 @@ properties:
           type: array
           items:
             type: object
-            required: [ name, type ]
+            required: [ name ]
             additionalProperties: False
             properties:
               name:
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index 896797876414..9aeb64b27ada 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -187,7 +187,7 @@ properties:
           type: array
           items:
             type: object
-            required: [ name, type ]
+            required: [ name ]
             additionalProperties: False
             properties:
               name:
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 897af958cee8..b378412a9d7a 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -723,6 +723,8 @@ class AttrSet(SpecAttrSet):
             self.c_name = ''
 
     def new_attr(self, elem, value):
+        if 'type' not in elem:
+            raise Exception(f"Type has to be set for attribute {elem['name']}")
         if elem['type'] in scalars:
             t = TypeScalar(self.family, self, elem, value)
         elif elem['type'] == 'unused':
-- 
2.41.0


