Return-Path: <netdev+bounces-64805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE95A837257
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 20:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897591F339CC
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 19:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8246B3DBA8;
	Mon, 22 Jan 2024 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdTzV2XJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB89A3DBBB
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951155; cv=none; b=FbYdr8+xZWQGarL5AGHS9Haj2FMDx35pvBxNJdMGpHMq1YM51l4tcMfutxwU15dAbzmf0pBqQGdQnqaou9PIrJfO7XVDITElm9WcEgDYZcdmDTUpHGRJ3lfLGOWyxLfKBu9j0baEVudP6L/+pE07jiSN2R/uF+T5bOJbLL7nvrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951155; c=relaxed/simple;
	bh=NIzF4HOoeWcX09o9CigouEo1jnkrQhGpQ/EDdZaZ4zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/vy66w0MxKCveE0eo3MXCYTIUYvhnlklseu5Phq56V9MH1UXDG0EvYp9IWftFj86vKBC1IvHwVdKAGkeXlTFyRhNs9IGS3mxmWqMpSnAwZQ4E0gyrWTp6UwfOOs3963mbTbphRVknexvo0J5Pb/+kAa8faaBQgJ2VDgJxjiOVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdTzV2XJ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3367a304091so3901289f8f.3
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 11:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705951152; x=1706555952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t57AyYBGWcxZqrcQdzRHminQZoOXAn71o8VVm2M9WtU=;
        b=cdTzV2XJCEAolZWa8jGpBhuELwOoIGF5Ch4ux1ZL2XQxUgAVOo/Y3CWnF656bNFHPS
         Wr6Cz1qRBLvcoisD5Z7kixN9jH0WhTP8+0uj3O2Wsz1jSxIaFj/B7NZzhiN59k1KkgfT
         irxgp0kZOEiLDkjA3K31UGIIKTihogvG+dnuGh1JXITIZmgr4L8M8jOBkyaJJILdO2LC
         dnhv5aI7ideDtqxtrreTfwWYA9ww0C8MQNYklqRpbnr7kHZbpwvHd9tzKgDQJBTq22LE
         zv1CmFkRXKRNtBDIUrJi9hOXogr1/9LYqjZqlE4jsfPm5IrpG5OK6Cid57k3bbBAzJGG
         bMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705951152; x=1706555952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t57AyYBGWcxZqrcQdzRHminQZoOXAn71o8VVm2M9WtU=;
        b=fpSZVbAk/mGkSVoHeuDACqt4M9RHQr8T7RRoSYzhlrz/h3HGtwjga4xrxC2RHfyIL1
         NpL2X6PRdipHELYVoFAwYqRR/96DBPWZC0qst1ZGXUZ85j9V7YPZFKEjhYfMLW22KRdr
         7Jmp2CT3b6HOgkde/WD7jDveQxoCWoBofRzYa4Glg65UwVhhECso7AzxQlwlatbdx9BS
         LbHL7ADtV6INMuipUsl3CIVW8yx6vvdss5W1ZcMkoAJ/L5fxcnObluw4Z2p6FvzDSH7z
         AfF64yYOeTsBnwtXHTcUaSt82ErZrGqZKSzFqgkrl6S3yTxM3kT2ym6zgl5JvFRv5P/J
         YeAg==
X-Gm-Message-State: AOJu0YzzDMurcGFBsZcYnStUrpg6eQ7Agq74xY8QGh4sIXVtbeQB8w/v
	BZOXStSIcUA9uVcGR9OLPnvs3GKuYnYoJlH6cIT5oVsF/MrxKv2wI9yj8l7ql+tKkg==
X-Google-Smtp-Source: AGHT+IHOQuIxgiyCBV5wbYT2HDXnYtBafZH9JkanrftdVJCFfPFuHYxOGEczNL7CABclb2xlVqB4MQ==
X-Received: by 2002:a05:6000:1e81:b0:337:9a60:f00b with SMTP id dd1-20020a0560001e8100b003379a60f00bmr2125719wrb.127.1705951152275;
        Mon, 22 Jan 2024 11:19:12 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id t4-20020a0560001a4400b003392ba296b3sm6211104wry.56.2024.01.22.11.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 11:19:12 -0800 (PST)
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	chuck.lever@oracle.com,
	lorenzo@kernel.org,
	jacob.e.keller@intel.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Subject: [PATCH net-next 1/3] tools: ynl: correct typo and docstring
Date: Mon, 22 Jan 2024 20:19:39 +0100
Message-ID: <800f2681d56b5195c8b22173a3b83bbac021af92.1705950652.git.alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705950652.git.alessandromarcolini99@gmail.com>
References: <cover.1705950652.git.alessandromarcolini99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct typo in SpecAttr docstring. Changed SpecSubMessageFormat
docstring.

Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
---
 tools/net/ynl/lib/nlspec.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index 44f13e383e8a..f8feae363970 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -144,7 +144,7 @@ class SpecEnumSet(SpecElement):
 
 
 class SpecAttr(SpecElement):
-    """ Single Netlink atttribute type
+    """ Single Netlink attribute type
 
     Represents a single attribute type within an attr space.
 
@@ -306,10 +306,9 @@ class SpecSubMessage(SpecElement):
 
 
 class SpecSubMessageFormat(SpecElement):
-    """ Netlink sub-message definition
+    """ Netlink sub-message format definition
 
-    Represents a set of sub-message formats for polymorphic nlattrs
-    that contain type-specific sub messages.
+    Represents a single format for a sub-message.
 
     Attributes:
         value         attribute value to match against type selector
-- 
2.43.0


