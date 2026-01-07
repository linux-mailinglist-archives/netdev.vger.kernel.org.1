Return-Path: <netdev+bounces-247701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D41CCFDA70
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 13:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 863CE30D9752
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637F331619A;
	Wed,  7 Jan 2026 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Di6fI6vY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC7A314A77
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788534; cv=none; b=Xx4TWfTGZrxlOwi24kTWAv317CS1Faz2n0sdHqwo8UG1xjAvO+XxpxOi38coP/CFPon1H8qXk7x8sdHggtpuw2GDtXio0Ms7k+Qx+6/XZ63PDrpXkNJZDjVx8BQC7icOLX+gD4yb+6Je+lR/INREFRdM29rWo33YEHPjsqZYL9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788534; c=relaxed/simple;
	bh=VD/I6jUGFgvjrGJZ+tE5eb0QESIrVHY+p2VGpXV7rxg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IASa6BkfQrvq+6ihotmDoE8wUOWuCaDROTUwY2RNLENEOI0NiY1FEpXxxBrYiIQ+eZXw2E4t4RU0QcoiWfvwdhI3JOg+Dxn1K5cqPAxMHebHPqFY/5WtPTAX1wed+eb07fd2+mOwPlzp7gJ5lqvWyjQz9AAh4URHODCAJCDv4mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Di6fI6vY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4775ae77516so21972635e9.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 04:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788531; x=1768393331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzb1wps8eSWw14l0JHoJa6h2SAn50b1lPYHmOdQkBEE=;
        b=Di6fI6vYHeUvNACELXqdoD5OomA+AzqAiCjiRbUq2NZjZFA0zIf+6N6PTaHFxAsAxi
         NNL85Wsz12eyKJcM66JAnJphQ/9aTUgFw/xhkAGIYu1tNhTDe06H5M7hEbXw51fG3ueD
         HmTbVSGYRFCUbCS4tNC2tHlJJHCwDT6hsO7tBrAxnYO8wJ2YQapn2YXEW3GDajoxK6lU
         EeNXpgHppWPhDksWRy+C4oqPVr5fC9ELbkKn7M7cQDwMhK3FxVOKNpw+X6tJzSSi/JvE
         /KOkDjn2RtBtRxZLBsukOKUUHwkQw+s86PMv1pqBjl4Wy0XoqzMq6uO/AjORia8fyFWw
         5v8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788531; x=1768393331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xzb1wps8eSWw14l0JHoJa6h2SAn50b1lPYHmOdQkBEE=;
        b=lFNo/iSH5E5fMoEs7J+hDgIlyo51vYeUzyNwkoLQLjpZBLGmaPlrOPoFGeqstlnZbP
         H4LmJ6lO5yfNd4r6M8dD3E+MVpxcV/+pCDxOMllsof0sK6sVBgdBKWkEhLCfHYEMaCSS
         26DxD5yqe2cJU/X5NFlb+AxSjrtudF4aFgWruoL5VoeH7fwqZnDlnF4BFmBHf1f6J8+j
         WD83rccZAs4ZedyeGQfkkX0nOYONCat4aw79R+myJx8jfQOt21LCdIwDMUEcZvdwscji
         hBK+zeJ0+IWF6q/KIj0DL89WkDke6Fp6NDnGB61qcEEL5EUwYjJUC3cFlQ0aKQWGVw7N
         Em6A==
X-Forwarded-Encrypted: i=1; AJvYcCUpcV7AH2Z5QrLSaZoQneikyMdiLNHTJOvSAW/+U5VNsdVlUjE8bwzLoLdKTg8YOs4W9c4/3lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS4bCC2nzwddzAf+xtN97FDwAqZEqFLA4POE3bFCjL0BWN/o+Q
	J6JR/aubWkzvoFT8MKpuJvObdeuyZ645HnZ8CcorWcVPRa2pSJakCqTf
X-Gm-Gg: AY/fxX7Ru+EVDqrtTe9WEKi3T8mr6vfXRW1M3ZYNucRzat1dLi/4bGBrE8mEjkKUPRw
	wNsFQ6oFazdufdZeCnO4I8oqf4iuIlqneM98ODn1HJmIOtwl3GTwSz4kawxzbyF7jNTDPGHN6MZ
	WCVj9urV+mbhSq+jcXnDrbSRlpe/J46J2K2Dpi5qZ/qItkzWBcy1MU5cNBKc1j3w7evn4QtLHFH
	DmiscevUSV3KkButKQcqCUAZRJRZ5mbgm4Acqie68m/NJEsxC6nPFgwCn66F8Xn+pMjVfgGipKX
	8WJtCf5YYquQ8LcjW3yQaKdhzD89kKd0gKz08w3BOHJL12XP1bRutqDgy7+DZY1STshxyL0oFbJ
	h0mr/M7HwUDXsBs7OBNvGJbLJgG5m4lUrxAGDuMDqXHLqmmi3ztDKKckLasUPmSPM2cT9+hvFv9
	qDCT8RmCQUB+IFRrdx0h2BJqG1/Nl8
X-Google-Smtp-Source: AGHT+IGih74c1OUYUEBMRCUnH6eJk6L653lrbOyGOFDnLNlorlBJ0fepCFsMQB0kJvgX782FfehePQ==
X-Received: by 2002:a05:600c:1e24:b0:477:5cc6:7e44 with SMTP id 5b1f17b1804b1-47d84b18ccfmr25536275e9.11.1767788530786;
        Wed, 07 Jan 2026 04:22:10 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:bc70:fb0c:12b6:3a41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e16f4sm10417107f8f.11.2026.01.07.04.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:22:10 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	Jan Stancek <jstancek@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Nimrod Oren <noren@nvidia.com>,
	netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Ruben Wauters <rubenru09@aol.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v1 07/13] tools: ynl: fix logic errors reported by pylint
Date: Wed,  7 Jan 2026 12:21:37 +0000
Message-ID: <20260107122143.93810-8-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107122143.93810-1-donald.hunter@gmail.com>
References: <20260107122143.93810-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following logic errors:

tools/net/ynl/pyynl/lib/nlspec.py:299:15: E1101: Instance of 'list' has no
'items' member (no-member)

tools/net/ynl/pyynl/lib/nlspec.py:580:22: E0606: Possibly using variable 'op'
before assignment (possibly-used-before-assignment)

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/pyynl/lib/nlspec.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/pyynl/lib/nlspec.py b/tools/net/ynl/pyynl/lib/nlspec.py
index 5cc10e654ed6..987978e037ac 100644
--- a/tools/net/ynl/pyynl/lib/nlspec.py
+++ b/tools/net/ynl/pyynl/lib/nlspec.py
@@ -295,7 +295,7 @@ class SpecStruct(SpecElement):
         yield from self.members
 
     def items(self):
-        return self.members.items()
+        return self.members
 
 
 class SpecSubMessage(SpecElement):
@@ -570,12 +570,11 @@ class SpecFamily(SpecElement):
                 skip |= bool(exclude.match(elem['name']))
             if not skip:
                 op = self.new_operation(elem, req_val, rsp_val)
+                self.msgs[op.name] = op
 
             req_val = req_val_next
             rsp_val = rsp_val_next
 
-            self.msgs[op.name] = op
-
     def find_operation(self, name):
         """
         For a given operation name, find and return operation spec.
-- 
2.52.0


