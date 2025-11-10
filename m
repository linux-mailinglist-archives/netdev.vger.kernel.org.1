Return-Path: <netdev+bounces-237138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E2CC45C89
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 11:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B370D18919FF
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6973A3019A9;
	Mon, 10 Nov 2025 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DePaYBWv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E686126F297
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762768849; cv=none; b=KeIcSbR/Cmb+/jDb4xax68pLITGIOWVEgRsOFrKpflT74aHL1BHjiuQRB8Wh/6Uv4xihnRSN8aEJ80/7If3MZG8OoQp0GzOoZWetqG/NSUbbsOpaFN9XVybMQwItd39aw7V8w7bTtavrznmLRRUrB6SH+D4reifXDTXmWQIImNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762768849; c=relaxed/simple;
	bh=utVy6JvlKERgKujYhOgnVpCTFIWZ2va0wC2CkiqbEWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyYO1o1iNtm5rBC2yjtxeLuDIhuFRiKkgRV83MZln4+Tkhpp4La9iRikXS0zWn3oYKAU6kSG32GJ+hnkRE96AlB5h1X49JgFrq1rMdDOMAWD4wRTsEZ8uVQXK4L9WSYiWOOlyIrdfBBE6atKbOGm830oo9mR9i+TZfb1qvHWQQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DePaYBWv; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aca3e4f575so2246789b3a.2
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 02:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762768847; x=1763373647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=za7hYkkLPLqSVT9uZfocsnw3yWLzRulvJUyGOCLkCKY=;
        b=DePaYBWvE+f9h4KLoLv4UbtTNP/XQR6fPdslmLb0AfpETuBT+zN1kXswotuQuNSqmh
         6a5MvdJenQiwD0JKHarEbTh/rb2nNS51hozlKJpdzl2QV0vsuou2dh9esaRB1mVSJYWd
         jddDzputRvPgeDKSoTxN2ueifOszETo1Q/US2uJ54dQKa2EeijZ4/DKLCbekSTJZnNn5
         0k74VpXBCo5kXxg0j+FYcuRQgobFlK/U9fIvGK9Xb3L0u4IGQvGHIqjhpBBL8lD8XYNX
         ZrF3YfsPkgp4/WigYyW6QHU0gsJQqTpQ3xU8GZd9KNebfwHg+swGFbn2pGH+gnVr+VLc
         Lx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762768847; x=1763373647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=za7hYkkLPLqSVT9uZfocsnw3yWLzRulvJUyGOCLkCKY=;
        b=KtmynWTCw+TbjEUE1sKPsklN/Z9kNAlDOCt2YBtw4mgfkrANQ4OCUiGuO25MG1DXbv
         Qzv1UzA/AMYNsQ7Ey/ptOIwPVgGL8vLDgDdwsrFZtQ/6CChXX2nk3SfQpCDwqpZ5kMNm
         SNCA7i8aYRoIOJkAUvt7a4vmhHDNu94QS3JDELQRG+0FjTDmpYk71jO4jNYzYclKaaau
         sP3A4S9ltLGGn5ZUBT24StQa6xuCfSeT8OnaWZEXEkQOFJvIXLdKp3fgi/ouSXqPcX+k
         1gLfhFN+hl4QAYaD1yLz3LeN5jRuu6/eVL/gXlXjdE0wwpLzriPeZhxHQM3bu0eTiOMe
         kz7Q==
X-Gm-Message-State: AOJu0YyL9M2hYYXvqEObx/Ck7c/a8QRaoNMEnJ0oPHdO94sBPIgmVnnb
	rU46uTsurvQ6bDX0m9o9/qC3qyx+qE9isJil6LLboKW3dMSDDK4PXzsR0dSWkCFJ
X-Gm-Gg: ASbGncvhjezlcC7/+8bq8bjPZKpisdC9m8p487zraHWkTe4kGsVV9j3zOFnJX79XfB1
	6zFY215+khPdGfCuVZLimRRLf5AYe9N5EL4f07lc6y3++qUY8QCtYLAVaczktZUEiC/WLpgb2mz
	r1surKuw/SXEGDoT1/dbXKT+kBNEuFVhM4eL9UW9yVSi18KivfzZjKVrfP8GeYuoxY0nA3Joz+o
	sEwV+ayFZw7wv+/yna+JoplKAzzaf2Vqq4JyWvr/b4nkIfvsBPeUNqOPd8xZXASIokoYnihHDFl
	T8yVrDeuX+mp/u3a+IbcrOFZEfSEbZpxSBvJFOyTGq0yUD4ychGivRWfS8bgwdJipoF/DWEde9X
	aSx1Ld0tD/zUCKgKHiBiC+iOB0K2C76chk6al5qii+lvmaBHqiwtODfATTDqYlQdG68w9sDScJD
	F9jHIq
X-Google-Smtp-Source: AGHT+IFRlLwBiiIiUYr6m0mzFvYIe5JGFndBTuR2IhPfUvJWomWoH5DBc2Y3talYWL/nYYro+xbtOQ==
X-Received: by 2002:a17:90b:3812:b0:340:bfcd:6af3 with SMTP id 98e67ed59e1d1-3436cd0e5ffmr9126888a91.33.1762768846814;
        Mon, 10 Nov 2025 02:00:46 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c337b20sm10374405a91.13.2025.11.10.02.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:00:45 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 1/3] tools: ynl: Add MAC address parsing support
Date: Mon, 10 Nov 2025 09:59:58 +0000
Message-ID: <20251110100000.3837-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251110100000.3837-1-liuhangbin@gmail.com>
References: <20251110100000.3837-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing support for parsing MAC addresses when display_hint is 'mac'
in the YNL library. This enables YNL CLI to accept MAC address strings
for attributes like lladdr in rt-neigh operations.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/net/ynl/pyynl/lib/ynl.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 225baad3c8f8..36d36eb7e3b8 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -985,6 +985,15 @@ class YnlFamily(SpecFamily):
                 raw = bytes.fromhex(string)
             else:
                 raw = int(string, 16)
+        elif attr_spec.display_hint == 'mac':
+            # Parse MAC address in format "00:11:22:33:44:55" or "001122334455"
+            if ':' in string:
+                mac_bytes = [int(x, 16) for x in string.split(':')]
+            else:
+                if len(string) % 2 != 0:
+                    raise Exception(f"Invalid MAC address format: {string}")
+                mac_bytes = [int(string[i:i+2], 16) for i in range(0, len(string), 2)]
+            raw = bytes(mac_bytes)
         else:
             raise Exception(f"Display hint '{attr_spec.display_hint}' not implemented"
                             f" when parsing '{attr_spec['name']}'")
-- 
2.50.1


