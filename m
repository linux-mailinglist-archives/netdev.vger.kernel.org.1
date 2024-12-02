Return-Path: <netdev+bounces-148149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE4D9E0A84
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D306B3BCAE
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140641ABEA1;
	Mon,  2 Dec 2024 16:29:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389711A0BFF;
	Mon,  2 Dec 2024 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156983; cv=none; b=djvhlefTjEyCaBQi9SS4QdVDlq/eV66anOxw6DjObtmWVzoshGUOes0esWTAX+0HMQ44Bfv3a+ctr48okWlS74vOkhjULP4ejxjEGl4JujKxabyjeafbLjy6CX0W46Gxt0+Cf8oyFp8Xi6gsnA+CQsle7tJOj+5Y4oHv2djp0zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156983; c=relaxed/simple;
	bh=nvvR5F5/9JC5aUPzeR+KkgHa2iTzckODeVucOV/sQkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxK1734HPwmcUj7WGnda4HGjBpox7zlv5QwgpMBpVcc/byC/IFdNH/2yWnbLunFfewVL5+QMvWMIHKZP7CaXYIVz5cokRBOtfsLcYdBOEICYLIid6+mg9ZCtijOpXmEMIKVrFGtliqOu9Z5DLzsdfAFOhyS7hnuXUo/cX8z0tvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so1559569a91.0;
        Mon, 02 Dec 2024 08:29:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733156980; x=1733761780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+AUR96o9qjCdgchamnRhZInSsfHOVILC2gNs+9yB2rI=;
        b=qCu2yqG+BdyzyA7RuvgflrXnYSxJ0SqKKCWD5cceCaMtHB0LYETs0Sk9uqDHrmH5l/
         Od67QHOTPfhIa5Fl4+ZU9we0D8897bNnT1kFZeSKk6ucZIeX9ptT82m8QlJoqdaCZWP0
         WdnRYwxQebJfTImB/QWm8BGJbwq5HLxVBfOomnOZvhqEu33aozaMxaCbuZ+LdllE46OP
         yAN9V4CEqhmthw9Mr69fbG719TfNU0bQrouif/hZCNrAex1DO0oofOzxYzTdy17BRA77
         apdtJUlWLqzsDaUnDmrJSZWkibq+aRdJHyHV5PtAK9iZDbOcbCmLknHtCep1tQSlNk1N
         uHew==
X-Forwarded-Encrypted: i=1; AJvYcCVOh576p0cbUR0XAfR+43a64CfOharvh3DVObgiMWjfikaeTzyFEJHp3eZ5n37wCUMKBti3DGbde6zNq1sr@vger.kernel.org, AJvYcCVqZvabtw6z2Tmu4kASrjC+Vbeg85B6QGDrXDOVyARF78hd/G7zoEwLtJ1fUupUKvT+apDkl6Unl1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz55lzLS2NRWTZ7dvY/XpHkeeUXUQsy8JCh48n5ERjkME4fijvM
	zp2REWGx4qcTFUgbQEkSV9QwkSxD3XoGqTJ6IbzQdhghaMnAIS0tDM/+K7s=
X-Gm-Gg: ASbGncsX2FGYaoIMIjUUWtVcFyxf0zJlIYvjMULtwOxRkjav9O65n+t3ynPHAcZe6sw
	fEw5SsAG0JeNAVARMNytQAsLGytUuUTwL8F3vuxS2pxdewh7F9cpTq9BGYqWzohSyE8/T9DpnyG
	jmC0992Nkzq2+pLpYmXT8dd6kRD0izCO83+GmQ/BIUghwnubDfV+XTN2dS9pnvs7Fg3BpTEtR/p
	2ol1sKbwlfYZRm5+AaYcYRZOXJ6Bav64LD36irFdmE8sHUpXw==
X-Google-Smtp-Source: AGHT+IFTfceYijDoihuTu7rdORK7cEW6N/rzU7BP3Do/7XaQu6YoJsIuNw9MjZKDsl2zveqGPOk3PA==
X-Received: by 2002:a17:90b:3906:b0:2ee:fa0c:ce9e with SMTP id 98e67ed59e1d1-2eefa0cd122mr28405a91.32.1733156980231;
        Mon, 02 Dec 2024 08:29:40 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eed19aa971sm1838796a91.1.2024.12.02.08.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 08:29:39 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	kory.maincent@bootlin.com,
	sdf@fomichev.me,
	nicolas.dichtel@6wind.com
Subject: [PATCH net-next v3 2/8] ynl: skip rendering attributes with header property in uapi mode
Date: Mon,  2 Dec 2024 08:29:30 -0800
Message-ID: <20241202162936.3778016-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202162936.3778016-1-sdf@fomichev.me>
References: <20241202162936.3778016-1-sdf@fomichev.me>
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
index bfe95826ae3e..79829ce39139 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -801,6 +801,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
             self.user_type = 'int'
 
         self.value_pfx = yaml.get('name-prefix', f"{family.ident_name}-{yaml['name']}-")
+        self.header = yaml.get('header', None)
         self.enum_cnt_name = yaml.get('enum-cnt-name', None)
 
         super().__init__(family, yaml)
@@ -2441,6 +2442,9 @@ _C_KW = {
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


