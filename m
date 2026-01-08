Return-Path: <netdev+bounces-248156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC8ED045E5
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 17:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73FF331D5C4B
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392242D7D41;
	Thu,  8 Jan 2026 16:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6L6udVd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085232620D2
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888853; cv=none; b=GmnzZy/+LTCIHA9/9LbcMHLcWYA30uf6bMboiijoh+fy5/Rt/j62L9pqNbP6lPykSGgWw2ZEqTbX1iQB2srF2BGLk+C7AKltuCraPSq2sk58fYp5oh89YIVd+LTHMD86GAF+0Cf2fcYdxxHLIms5l1oXBwGBc0VK0Tqi5P4vrwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888853; c=relaxed/simple;
	bh=rBGsz3z70HxVZuu4fg9mGRBWOBFs75O+avxMCiBk6mk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnyGcgaY3avbcMWDqi+Wxz3fAk4NvUJMebI2KDlXBobwh6tswCjNRPziF3niu8fI68+A3yMNIAFOrYGaLJL78dhxpVbNfphFno5WpxXbzRGDiA+3nRI4dztq7Gqmp3ZDGLIBpQuCfSQRQaSN4V1aZ4Vak7g1zHXR8pJ6/tt+6iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6L6udVd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42fbc305914so2263010f8f.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 08:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767888850; x=1768493650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EmZ8p9rHmLqxQPWnPXAfkHNkg4U8b1nKCMYFf0YxG1s=;
        b=W6L6udVd2BZU3AAchVmtR2asK1fB8Fi8kXiWRGIF8kP1fc9fbaU0Otpp2CTZJmxAgB
         7GZAfJQSx9IEJpbY7cCPwtKtINJ9kZd/Cg327lU0an8/8AqpBwSDF1JpvDG5BRo0+kX/
         HN8xa69zVDki/F/dMgDphlBLw205vcXx6agyTJa6SCttaoHTuuv48I1agX7Efg8QbOY0
         y5hGbiVQG8W+1r0/pcmHDo2Q7LjRUBXedXLjpUvOPF74Drv0lihgWyltULpnEHpc3nty
         SqGDtYM7D2F3dpOfDhUZdLenv3FTk30jXT0/of6zQTgmsl+EqrFRfNcHfeffqIT1tABK
         JGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767888850; x=1768493650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EmZ8p9rHmLqxQPWnPXAfkHNkg4U8b1nKCMYFf0YxG1s=;
        b=aAnoiPrqJ6oegiVXOSK6p1POPDmJCqxyf9ktyorvi0nyzxzDVRJuu0ahypgJCvxm6S
         ENPamZEDZqDkWqyaZDBxOwEfGmRm81Zzkl1jvBT5ux3Ux19fZdOlalI+Prg/tdNDLLSZ
         nXCT+ve70UDOY8KWHkPoOPTalLeafUiPVT+nqvMuRt2E+jaS20ICWc/0Eg0/MDAZZiSK
         2eNZaBKrp4bh9zWJXisiN0GnLgL73uBbraPAvUMaMSP5SjfapFf3yaboA03QGhOO8wGk
         7UetkCsEi5FkOGr+GnxURCgUVQ+pl2THanrKgMv7furkpEEyoE+Z9Ax4ZGQxXC1tdEEA
         2lRA==
X-Forwarded-Encrypted: i=1; AJvYcCW2HsNApJWIBLqTnOUwWA+uNbyA7rXq/vfnVfH4cR9eTTFqHdyQZyBUxPkfhKeY6+UnpnK3Kx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR26PaFlOQugS6Tkijw1gsivp6gbonwPf5qBgdV7s+webdQSSU
	OGmImBIVqNKUZ1vyQY/EZo/0QjwTrJFQ0I4+jJ9HYKBOClQFgoLk6ZeX
X-Gm-Gg: AY/fxX42h1pBhvh25NCZdKC4OSGIa5qMr6RUw813wHesdnorkZq8KoL3XXUhPfKFvSW
	0GQywtn96IikpyobaM5LlmSyiV/nhYkJUaexkUiAWbP2k3hDALoyBnRY0eXGxqwi6QmfeFMgMHg
	akLsOfw3ixhad2pRslMQvcv8JqgABqQJlYpKbNIcu88tOyiFH2YKL77fGNB2rjbF0ZUwnbdhF7C
	+p5HQsbTPC5eU3kw7k11o8hpAO4iSPeEl/Rw+22kkcV2TjlYuZpaZN3EsYZASp4D0iUl2rOVBxU
	DIcj5XlHCyaPz5H6CeiDeVgqfmZO0423aS/nt1sfTPGrzbzdSw7ukhwDAqudJeaeIjXp5TZeiZr
	hxTvdXzWkIdoxkX0wkm4LPa3Ty+b/KtZLh3RuGzEuydz3RLO6C5iZcIRVHoIg7ah0UGySOjqWF9
	RogA8VTujQphAfGoVHIQ2dO5wzwRUb
X-Google-Smtp-Source: AGHT+IFhbo79/crYqwrrB0zcxm/OK+WiMzLgjTkKmEaXHdfirGSsTvn6KlFnIEfCu0jLNNfmokXI/g==
X-Received: by 2002:a5d:584c:0:b0:42f:9f4d:a4b2 with SMTP id ffacd0b85a97d-432c3775a07mr8525845f8f.19.1767888850012;
        Thu, 08 Jan 2026 08:14:10 -0800 (PST)
Received: from imac.lan ([2a02:8010:60a0:0:8115:84ef:f979:bd53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5edd51sm17140039f8f.29.2026.01.08.08.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 08:14:09 -0800 (PST)
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
Subject: [PATCH net-next v2 07/13] tools: ynl: fix logic errors reported by pylint
Date: Thu,  8 Jan 2026 16:13:33 +0000
Message-ID: <20260108161339.29166-8-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108161339.29166-1-donald.hunter@gmail.com>
References: <20260108161339.29166-1-donald.hunter@gmail.com>
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
index 0b5277082b38..fcffeb5b7ba3 100644
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


