Return-Path: <netdev+bounces-68530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1A584718B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6461C2521C
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CA37CF10;
	Fri,  2 Feb 2024 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhzPb0RF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637EF7AE4C
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706882371; cv=none; b=HLJAy9hktIAA8Z6kdDHxB2hFXvr1svDdQFCg0BEyqnkWviB4Pk2I+M5M2lsW+S3I6fFKlMmElCoiNsXQqRWYCb3jSicLRgmKxilPgEMqXQdcog/wyI6BnHN6XMBxKbhc7sSnZF3D1PLZNDJqJURvTTLTkdopUOwfGFk9AlOGIqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706882371; c=relaxed/simple;
	bh=bmKVu8OffFhgFuX1cXDUBGshCdSoeVA8i4J9IJR6zKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEDQPA2wIWFfON0KUm/03sOgh+hlvQTF5t1mu8RSVmQk3OM6iBIq+JpBy/vKHkmjTDfRKvUEgZ1EkHNSdHa1I5U5+vHYqFy6jXXhBbLnGF553DStPLStpEJj3gQelAMAMrQTtbf5kX6uSfMJEQJi4fOoK74mlx3BHOxRryCKvNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhzPb0RF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33b0f36b808so1274559f8f.3
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 05:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706882367; x=1707487167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qI9Nn+orREYV3tFeNmLiAx+8tefrOGcSLtSvYGqoguA=;
        b=BhzPb0RFSIi2wX5nlm7WESfTILHcDbAWkQa2+MQFLsT4asm6DmYU8tNCIhfWQcwPbz
         bROUwYaD6Zs+AlkDAhrR8ArJTGccVcNSOduv4V1mKSRC4B93nYln49kv7UCnx8JhRzxs
         LuKDKbw8W7to68KNSZU+9lVL2EVTul69QEODTFZ8RrsCSYmm4BmruuSnSw4oTbMs+rk/
         gFWFhkmU7ohtvTmNMkZ4qkyUkq9YY7FpKFviqn23YXNYLkYZrRbugYWHbTVkwVmv22/H
         zQNUPnDlDmxSwio/2qImNrfQiJl0EiicdFxLcb5KKBUvl0G2cKBcRN4WVXMoGQlG6g7a
         3HLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706882367; x=1707487167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qI9Nn+orREYV3tFeNmLiAx+8tefrOGcSLtSvYGqoguA=;
        b=f7lDTAlr30JCmiL8ln1rAWWBsPRGOVrGkna7//K3s8Zp4NgPzctBQSUnHRHi0799/e
         IwFkqgAdMhNcCCIoQCR/9Wqsg4bi+CfyhK8qb+VCqZ5TBiwWvzUqH/nh2BX25b9TZJfM
         Htj9WYYuNTvbzvfuomyK4ElRRG0224EQAfZclpmoHNrv2gI4+XQB/t7hTy8wCTU5YszS
         wwirycCwCboHFGfCSmFnve5mWNP7XnacfssB9XuQLeg8vaGJ0OWfRqeYHIY9e3MtIQM8
         Cv/g9voWSfGpNFnUcDYDJaAkzhpV6K7kRuy59WuEwqg3rN0BTl9P5zODzWPtmP0NStbA
         L82Q==
X-Gm-Message-State: AOJu0Yw2YzYWJiQHX6VYwlnDkS1iX37v4Er5WT7GIhZMBif/a/o1re+O
	T1S1KwzL7sSBdv7T8Ju0jG0EKX3yRZpMCOa/4yTVnES0TfauziS+
X-Google-Smtp-Source: AGHT+IH5KZPEaYzes6+FyosWngGkUsfiOtjqK1b4T2rWU063G/5K5ST6W33fCOJ/5jrOj7Y78Fhspg==
X-Received: by 2002:adf:fd82:0:b0:33b:e62:63c7 with SMTP id d2-20020adffd82000000b0033b0e6263c7mr5091745wrr.61.1706882367265;
        Fri, 02 Feb 2024 05:59:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXQe6ZtULhTszKSi6EYneO7jYsbGcW7TCY+kZw5Z/PBii8692Ag207G1X61NM4MripZacOa1iy/VVFFmQpWvs0DFgZWGT53iEBIxk9iylgElijAW4yd5gtnd6BeiUS9o7Qu2s21x/VLbewVknzSh39mBt7yJ3eNq6GV+aM50FvRyQXvjx3LxSU42iMrZU/lLAqdVSpQ9v20TNwEGBOPntDYmZI825sfrlmkVLfXC4fYYxa7hel/oPuKUcg/k5HyuE7yBfZb3Ogm0qQ2YnMYvpdaQFpv6ZttjgkJIGm99y6aDn9za6a2QYT48IXvQdB2rTfHtlyq965Okfct6v3vzlLnbSyKIC6KMd0q
Received: from localhost.localdomain ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id x16-20020adff0d0000000b0033b1ab837e1sm2003952wro.71.2024.02.02.05.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 05:59:26 -0800 (PST)
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
Subject: [PATCH v3 net-next 1/3] tools: ynl: correct typo and docstring
Date: Fri,  2 Feb 2024 15:00:03 +0100
Message-ID: <7c1e8ddb4625efae01eeb06b4e42b7a7d6e0065f.1706882196.git.alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706882196.git.alessandromarcolini99@gmail.com>
References: <cover.1706882196.git.alessandromarcolini99@gmail.com>
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
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/lib/nlspec.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index 5d197a12ab8d..fbce52395b3b 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -144,7 +144,7 @@ class SpecEnumSet(SpecElement):
 
 
 class SpecAttr(SpecElement):
-    """ Single Netlink atttribute type
+    """ Single Netlink attribute type
 
     Represents a single attribute type within an attr space.
 
@@ -308,10 +308,9 @@ class SpecSubMessage(SpecElement):
 
 
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


