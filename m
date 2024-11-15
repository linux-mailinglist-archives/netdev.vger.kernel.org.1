Return-Path: <netdev+bounces-145376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3131E9CF4FC
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 20:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE4A28A2D2
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 19:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C2F1E25F4;
	Fri, 15 Nov 2024 19:36:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804881E1023;
	Fri, 15 Nov 2024 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699413; cv=none; b=GC4PrhqJttM0CyaqYaWT7ja0LUjSZf1358uH2iqvdZk5fXaIszmViZ83gvi2VL2U72rLgjL1gBYPYB7p/dQrGlSsiwVTkG3CouqnjWZ2vgQ5yTFMevGijPDp/Jy6ZoDg+m1Hc/rsU5pgNY48eN7vKV47VuCHFAh2+v+r/87C/EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699413; c=relaxed/simple;
	bh=0HURAoP05ewL0yjkUita5x92KSPTXFdoL30xsQh+/kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIX5XWwgXoBMQJdNjbeyK8/+iQ9d4yw069ckXq7uflGF4joyA8VeydPIKKyAwQXuN1WNbPXfGHWkb2lPUQaODcHZ0p3cTDDMfVElLXy/erOsJAYNhintlU6GQSi9z4PS8E6dIq2JgZpc+Klkiid4qkvKi9FjVOZ1e7Tq4xOq/8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7206304f93aso14011b3a.0;
        Fri, 15 Nov 2024 11:36:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731699410; x=1732304210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZZAw5tZucUhEBuhWIYesgkI51NPJ4Ne/XBaMDswgq0=;
        b=v3PX1yiyjtxbc+ULTfuYDlbwo76OvDhazi7KQLf57sdOnB6EhfawVVvemM4kPvNEJV
         KCp+1IFqbeG1nfdokKPrPaIUBZCNiDdJywD73jsx2jB3WuLBZf0UCkG+DgxZa65FtlTq
         H+C41ngvg/B6IQnUmOaQroLkQoYpPWXgK4pNQR4wxY9XF/dlyZfDrAsdL2C7DGhwquH7
         kTQNCbWuGK2hq4lnVvAtjhwx/5mEpIo7bRAw6Vajy8QemcRHGzNK9J1jicgmYqONt6SL
         fdJzEHADimurJnSFpP/KDNpQSNuslALul1dNWwNLKYN9t8O5WLH3PaP7jzbS8BY/mugk
         QvcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN7ln9np86+6bkTk+qPo7Xb8J/fUoA4uw+5mv8vwUpB36K3Z8eFChKt17GaFl5Gb4uGGy/Lrks0veE6wlu@vger.kernel.org, AJvYcCVwFNjqeUNnE6Tc7alpxuAE7/p90SI0K/ghaHcnkcAJEshksIaRRyjs31hhIxNlz1KUI8Qg5Q80qaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPrHWWRVxHY9821zZX4wXeRhlQ3wywuB2spGTH9U5KhzsASnu2
	XSQql9yU3xJwLK6KjrJhOWXmXrzEkzJJKywjT04Aedy0BmRRDMZpIpiYq9w=
X-Google-Smtp-Source: AGHT+IFmazW+ytgmFZiK4HiXxrsSFX57fKAHUMd9AN9AzApxoetCj1zKD1uxmRQY91ZOun4ArvH70Q==
X-Received: by 2002:a05:6a00:3c96:b0:710:9d5d:f532 with SMTP id d2e1a72fcca58-72476f7d406mr5393537b3a.19.1731699410367;
        Fri, 15 Nov 2024 11:36:50 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72476c8fc47sm1774014b3a.0.2024.11.15.11.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 11:36:50 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	donald.hunter@gmail.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com,
	sdf@fomichev.me
Subject: [PATCH net-next v2 2/8] ynl: skip rendering attributes with header property in uapi mode
Date: Fri, 15 Nov 2024 11:36:40 -0800
Message-ID: <20241115193646.1340825-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115193646.1340825-1-sdf@fomichev.me>
References: <20241115193646.1340825-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To allow omitting some of the attributes in the final generated file.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/net/ynl/ynl-gen-c.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 55e7f2415b0b..8ba252973c2d 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -801,6 +801,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             self.user_type = 'int'
 
         self.value_pfx = yaml.get('name-prefix', f"{family.ident_name}-{yaml['name']}-")
+        self.header = yaml.get('header', None)
         self.enum_cnt_name = yaml.get('enum-cnt-name', None)
 
         super().__init__(family, yaml)
@@ -2440,6 +2441,9 @@ _C_KW = {
         if const['type'] == 'enum' or const['type'] == 'flags':
             enum = family.consts[const['name']]
 
+            if enum.header:
+                continue
+
             if enum.has_doc():
                 if enum.has_entry_doc():
                     cw.p('/**')
-- 
2.47.0


