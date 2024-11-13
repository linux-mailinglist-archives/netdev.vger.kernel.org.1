Return-Path: <netdev+bounces-144525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DAC9C7AFD
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 335D0B2D805
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5942040AF;
	Wed, 13 Nov 2024 18:10:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8673F20125C;
	Wed, 13 Nov 2024 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521430; cv=none; b=I6TjS0kFgJPrZ6tn089v6SFyUTpH7w7t3wJM2ZX8WpPidaVC6UwTFy06gQMzHfHV+VzU+P3jM8jD2A4BbMaUadMvVLvjPqDU11MOHh8aP5/o167XfO9wDeL/rLqjxjeKHFc8WZbbJEEC/mgpfCv1ywWQF8I1oZlZwlIBM1K5/Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521430; c=relaxed/simple;
	bh=1w/jmuGq8DSW15NX0XNz0lT+0H9UR1upA0pm6XvmLr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxvl5el8sARcSxKnPugU+ds8zA4oyd5TyQZnAWn8SnmbJIJa/MJKfaQQQgohXK09nGBxkNfmkt2nkZNBwIlpkNzJPVznSPqjbw1bNhmllJiYsRlzjS02fQ9TSS2NtMNFwyD+5DiLyFF9hf/Lx7cB35LuPpfGDf0nr5OLFk9xflk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c8c50fdd9so8092615ad.0;
        Wed, 13 Nov 2024 10:10:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731521427; x=1732126227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVUAk7yzKNUrF2mMAtjCVluT6J9nMa2bsCU5/aa48Zc=;
        b=U58yfVCqYzrkiC79vUQ/iXKCcMDOti3Wio3F7AuUnD749Tfv+PYoQnwyFS2tjYbCeN
         uMKo8rYLogP1nQC+AuiNXKWrPTaXpaPyuYveCcJblpV7wlJBCappEATVthV5mHzAA0eT
         VRZ/re04XA7KSs6QJ35I9kJqJ6UkNySHCwjgvHVMnrk93Z4Z+6rHeFZzwNF/U810oK7A
         5SAfDznwIvT0qtz7YiZa7I+j9pIbfAccj+Ms9rcstRwUZEeJrEHvkvA1aw+uarS4ErAF
         1dp3JdCihkLcEqFmCkMeIgbeRf3KwJltk4e8WFm56Wl1/f//fm9R3UgmvX6Yf+OurQ/K
         S4xw==
X-Forwarded-Encrypted: i=1; AJvYcCXBJ84S8Jsnn2XafCPglf0ceWGziDBv0uKluSXCAO0RPVkxhJeNzcnwP3NX6uypX5w594BNDeadSoBPHsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP/cME8nNq1Toz2VQA5s3RHGzL7BulFjCnfxi1Emx6Wedm4dio
	cFmZQfk9nHGOWq7KHdxLNF/G91KYInljD07tp6JU732/q86m3HGcqiVl03M=
X-Google-Smtp-Source: AGHT+IHH1lJaJN0k7JHtk9vtWUSRWiHBX0F1h0XuBCy6BzZ7yOldt5qNlkp7YuwQ5DvuFbxpr15P9g==
X-Received: by 2002:a17:903:32d2:b0:20e:5a79:b97 with SMTP id d9443c01a7336-211c0f3e1e7mr4924355ad.15.1731521427590;
        Wed, 13 Nov 2024 10:10:27 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724584aff8bsm1921428b3a.3.2024.11.13.10.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 10:10:27 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	donald.hunter@gmail.com,
	andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com,
	sdf@fomichev.me,
	nicolas.dichtel@6wind.com
Subject: [PATCH net-next 2/7] ynl: support render attribute in legacy definitions
Date: Wed, 13 Nov 2024 10:10:18 -0800
Message-ID: <20241113181023.2030098-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113181023.2030098-1-sdf@fomichev.me>
References: <20241113181023.2030098-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow omitting some of the attributes in the final generated file.
Some of the definitions that seemingly belong to the spec
are defined in the ethtool.h. To minimize the amount of churn,
skip rendering a similar (and conflicting) definition from the spec.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/netlink/genetlink-legacy.yaml | 5 +++++
 tools/net/ynl/ynl-gen-c.py                  | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 83f874ae7198..cdda9e6f4062 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -83,6 +83,11 @@ additionalProperties: False
           enum: [ const, enum, flags, struct ] # Trim
         doc:
           type: string
+        # Start genetlink-legacy
+        render:
+          description: Render this definition (true by default) or not.
+          type: boolean
+        # End genetlink-legacy
         # For const
         value:
           description: For const - the value.
diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 210972b4796a..0de918c7f18d 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -798,6 +798,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             self.user_type = 'int'
 
         self.value_pfx = yaml.get('name-prefix', f"{family.ident_name}-{yaml['name']}-")
+        self.render = yaml.get('render', True)
         self.attr_cnt_name = yaml.get('attr-cnt-name', None)
 
         super().__init__(family, yaml)
@@ -2437,6 +2438,9 @@ _C_KW = {
         if const['type'] == 'enum' or const['type'] == 'flags':
             enum = family.consts[const['name']]
 
+            if not enum.render:
+                continue
+
             if enum.has_doc():
                 if enum.has_entry_doc():
                     cw.p('/**')
-- 
2.47.0


