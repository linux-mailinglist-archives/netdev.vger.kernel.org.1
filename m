Return-Path: <netdev+bounces-68037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E27E845AFA
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED71EB222BC
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F976214D;
	Thu,  1 Feb 2024 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiHcejBP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DA05F49B
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800342; cv=none; b=BNZ1pHjCdeREZKtnYNU2WxwAPuhoVdmBz5mVwKkMQVkdBDDtUb3Dr/n6TKYSz+wscBR1eZgAZPjWqLicc7yxAjHF84L9yQ68TnZxwNdCpFG1ySlkLm/wGLjQ4iEqrJ36u/AtQIDTWzzXzDg5LLRz8vbR3xJ+0b1MqavpwNGtIEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800342; c=relaxed/simple;
	bh=bmKVu8OffFhgFuX1cXDUBGshCdSoeVA8i4J9IJR6zKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfCNeoKSxBdNd0kgAn3VHuO8upEwyrSz4MsupTsK5FSz2O2paczKX/QmrezukMW3kKZOMsTYBF1wtfqM8ZjPttPCjNrlkPdE6VTzR0zyTauyzdJ7U3jjCtIyCR4cQwEW85eT2Srg3lXIR7A49mjpDsG9SPDK372FqFdfnoHu7qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiHcejBP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40ef75adf44so9365185e9.3
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 07:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706800339; x=1707405139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qI9Nn+orREYV3tFeNmLiAx+8tefrOGcSLtSvYGqoguA=;
        b=BiHcejBPHa+okMmSpeqP22t8e7exvaJy0i8ei70qcj9JB0VtGJZo/NZpiRTwRcTEkg
         ZIsty6+lGuLUGx30r1z4TA8eXUPkSgnfPFwsLtT8gtbu1WhSAXWe0BY/7NDzwJCwqb57
         rq/z4ZaPWDjKGfCOMnjlmAqqbXYg6/z+yiL1IFI4zX3OwNhY+XtDm/4KgkAMyqDDDkTO
         qJFWwB6amuUa31Ej52HHpDuSF3zMFswVKVyqekiS6FRN2DxTSKzmfpU+6v9Q8D3abRpq
         choduYTFcbAh6JZlRTDJow27Qiw8UtBjnqSatBSfOwR6yvWPRd83oEVzfhuk3zp6sjCN
         f6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706800339; x=1707405139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qI9Nn+orREYV3tFeNmLiAx+8tefrOGcSLtSvYGqoguA=;
        b=X4zuRB3zyM3BtUndcOziNlvk9by0t5gyTlj9+ppxtypoqqU7oOEh9/HWHonGoegZoh
         Yh3NXeREGQJebkPzsetwmo4/BJ7l1+760xaAB6axCQO7Bl6Ze6IYdMT2WouVjzZv/Bob
         uTloX4xImqc0uXiZWAebA16VxPNM3dFPbeLvWWt2OuWwEgZN19n8OqrYqytfrkG+6O3D
         Bsjns4s/NyJ+yvCulQ+tSMBq0vLx5LnT5XAgenlXzB9PgeZBYF0Vgjl+3ZnWJuvql4WQ
         r4P/vkThCv0440EHYqc4CL515zFx34t+8qnxYeK3YB0ZyGuKnukjA8cT8rxYr+yQReJx
         sg/g==
X-Gm-Message-State: AOJu0YzvsmzgS6FGKPyfnzNi3y8yQ/3mVGs5/dr1iOjEYevX6TTcdikO
	H1SD7galcVz9oSou2CAjJ6Apdz76T2b77CE8nFRLO2IX1/iQd8vk
X-Google-Smtp-Source: AGHT+IFvLbm3Mm+UdZ8wbIbaM41Es8zUW8/T6/7X1O/mf8hCNShNxhEg5Mw+zT4YCa24x9qmzxVhtg==
X-Received: by 2002:a05:600c:a007:b0:40e:8903:6e1 with SMTP id jg7-20020a05600ca00700b0040e890306e1mr3241628wmb.40.1706800338592;
        Thu, 01 Feb 2024 07:12:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXSFAUdZyQ8jt5HwBVdxklz/dUZ0hzwoiycxBoLHTfgjxH3okjYmrydv9Tf9jYNqJEveD5mkO5yyuJxDy6nmudVfGR5Ff5LyJcVSt4aExEfzwy05BAL2ixMMmKtS/YjF/+Ze0bOw18PEhPAsxohDl88/Y7N73gNwOzIIGXSKcslnhb0P4zkI/Cou5B3QW9Omym27aFdViwoiYWwQg6ppNd8Vey++Kdyjur9Y1jz91sm7zIievXVx5v7GJlHLF/e3++c0ep3l9t2KQWFGQ/o57lI+QOEwweWER6oj50tXAUGqhO/txbWc+1KYdemc/SLBGF552+7l/4H0YGhAk/AKI6LDApwIrYNEbfH
Received: from localhost.localdomain ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c4fc700b0040fb44a9288sm4753672wmq.48.2024.02.01.07.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:12:18 -0800 (PST)
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
Subject: [PATCH v2 net-next 1/3] tools: ynl: correct typo and docstring
Date: Thu,  1 Feb 2024 16:12:49 +0100
Message-ID: <7c1e8ddb4625efae01eeb06b4e42b7a7d6e0065f.1706800192.git.alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706800192.git.alessandromarcolini99@gmail.com>
References: <cover.1706800192.git.alessandromarcolini99@gmail.com>
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


