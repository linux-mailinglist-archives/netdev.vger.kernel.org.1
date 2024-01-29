Return-Path: <netdev+bounces-66895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCD48415C3
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 23:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D251F22334
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 22:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A38F159571;
	Mon, 29 Jan 2024 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qtlm+oHh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3BE53E07;
	Mon, 29 Jan 2024 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567737; cv=none; b=ZjwZ2HXf+c/gBklAl8+IbMG4ELFyxRPOttqq0n3iDvUN91EP7EWeGBdSevJrxtU2wkHSnQ68+44dB7QJWhf8Zlao6Fpi6rz+sXmOTOlLBr57H4xk6nMy69YtIVA8hrLq5bay8aALXq4w+R+jcas4XGODuXGC9XcU7ztXBhSKV0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567737; c=relaxed/simple;
	bh=OdvP8j6NATYldZfJ2QxJSvvvX/SxB4R5gU9B3uI+VYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8jmwqT1ZyD4QZNcbStvTDLF8vcUTUIwoDIToPyqu4RqJmQDEIFBlWSqe5i7vj74wCs4bYSbR3uKwlJ9PJvPD2ohLUx2jKbmlAmjXPXk3W5opfQC6+juwZWcGMbDwBAp+kXSuX/3a/ryD2OIbVcq+Drr0zuQQJ9MZB6sT3dieUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qtlm+oHh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40eec4984acso26170395e9.2;
        Mon, 29 Jan 2024 14:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706567733; x=1707172533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClXG9uTDgBMA81lLT/nmnwAaiOCypQE3e9mwTp7YT8E=;
        b=Qtlm+oHhMmoUafbHyU2IwpI8sj2WcKr9FerNTpbpEWrH3hNSiE93zUEH94O9q/0y8J
         CCPigCe2HJLTnX3jqPCRZhyhX9+l/jRUrVs79uz7WGRZ7pHuKQnmXITJho+bjIGb7TyO
         PrNk+qqnCZDyk4HirzyZR7Te+oOYjPCobXgoiKLXZot7WeY/q1c3OeNU92FcAZofyRw/
         KI8VZENBC7Jnw7cHZCSySwKkRBjWbmbKlfHn0Bj3Q4ss4eAKoDQvC9TRkBkaHmiDbTKm
         JvE97rH5k0yUxf20Pbvd/nRxVwnWBves4kU4Ngq09nGjGxM+Exz+GATfWiI3CM54UpOi
         g8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706567733; x=1707172533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClXG9uTDgBMA81lLT/nmnwAaiOCypQE3e9mwTp7YT8E=;
        b=NMoP+b3JXoL9VoWgCmILGbzmXggcgkX5VlH9L8VGkIijw1D0hvPf3XtUPnrwRk/ITD
         im9byL6GWFl7oxjmetnfSQUlxjmul97f1MiQ1HycXdA5Ao9YUZHKvvVnVzY1MfcnGoO7
         Ua+zBsefdtnZArlCYpDOT0sc3Gbq1a5dDFQbIeNl98BK3rMfHdSEFH5ZavyeXS3vy+H8
         9Wuw/cMKmyofMxrlXeelSKepjzITKS4cNWpgWZu07MWJixQn2XxH6Z+IfqVJMR+8qpdn
         Zn4F3ciTTM3qSj3luwohYZkCYTV2kh2edTg6i9RDNYSUAPs4vpe98rRn5igIzp+H8B9m
         epzg==
X-Gm-Message-State: AOJu0YyjHWwaTHuu8qEvni+0kVD6VtMUPBVDvoHZWE4hOPnRM6qcN3ZO
	fBAZKzaHOF9IbxTdSMIbLBV/x4lzwZYeqW+17bjdnOupZFHaa1ZmISqcHUMz1GI=
X-Google-Smtp-Source: AGHT+IGv8t7aMEWyLzZQD5Q/4Rxbz1k5hTzsoMtXeeA+qcD2zSfHq3xkcCA0yrs8A54AM1p6KU83Ew==
X-Received: by 2002:a05:600c:3b28:b0:40e:e2eb:bea8 with SMTP id m40-20020a05600c3b2800b0040ee2ebbea8mr5944049wms.0.1706567733466;
        Mon, 29 Jan 2024 14:35:33 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:9c2b:323d:b44d:b76d])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040ec66021a7sm11357281wmb.1.2024.01.29.14.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 14:35:33 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 12/13] tools/net/ynl: Add type info to struct members in generated docs
Date: Mon, 29 Jan 2024 22:34:57 +0000
Message-ID: <20240129223458.52046-13-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240129223458.52046-1-donald.hunter@gmail.com>
References: <20240129223458.52046-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the ynl doc generator to include type information for struct
members, ignoring the pad type.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/ynl-gen-rst.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index 262d88f88696..927407b3efb3 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -189,12 +189,19 @@ def parse_operations(operations: List[Dict[str, Any]]) -> str:
 
 def parse_entries(entries: List[Dict[str, Any]], level: int) -> str:
     """Parse a list of entries"""
+    ignored = ["pad"]
     lines = []
     for entry in entries:
         if isinstance(entry, dict):
             # entries could be a list or a dictionary
+            field_name = entry.get("name", "")
+            if field_name in ignored:
+                continue
+            type_ = entry.get("type")
+            if type_:
+                field_name += f" ({inline(type_)})"
             lines.append(
-                rst_fields(entry.get("name", ""), sanitize(entry.get("doc", "")), level)
+                rst_fields(field_name, sanitize(entry.get("doc", "")), level)
             )
         elif isinstance(entry, list):
             lines.append(rst_list_inline(entry, level))
-- 
2.42.0


