Return-Path: <netdev+bounces-98615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CC98D1DE3
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA111F22E5D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D433B16F834;
	Tue, 28 May 2024 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diowS6Fi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CE316F826
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905231; cv=none; b=XwMTI1gbhT3Ms1BuMkz7Bou9AaftqRf7Fp93imSvM7paXal+ejQDly2aGxWSXb23EU1l1sKa2Sb1ItLfIn7j0+WVSqR6kYPCZOxrZUPZIoHRMJUV8ZJ3rR4LfeOtxja2fA/tm2m/sGtf/DperQPR5kZUoeL+6P5DTmL4QES5P90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905231; c=relaxed/simple;
	bh=kdWY1md+Cnz1PlyvFWi4xZHNlbTD9PJAG5QXiKfnYPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZv/EBweXt6xgqeJjT6KzejTgqlh7gnZ1hT1wMoVtrCWRMWACoq44eKgM1+RuP0AOhzEjzkkjdsSqHUzuAVhS3KJAm3m7lW4xIkedgHEs0ULuxo3DUCUM0+xkeMKnygSl22aZJUQ6Uu+JMXboId2H5Lh0+Z/2sbEwZjDdFvzkBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diowS6Fi; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42108856c33so23485765e9.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 07:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716905228; x=1717510028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLkiSiRrSAnOAs3Y6h5iMAoW3bCpoNjxPw0wPZ+lU14=;
        b=diowS6FiDBhSgKuTdaUuPTDqABpwYak37m59zxNGhY/IT9/XGZmeUNIJMLy5QFIVyh
         BhnPW6nBbXC3cqQwmY56Wvzjcs8kWdDjczE7WM1iUYyPdv61p786fAypDdcOl20RB8vj
         Ru2b+nG5rDg1OlJGiR4oUcAJQYGNkToMGWjh6qsuPUNEDACf/EjoxQuL+ZTHLUfe6FMc
         p2w0N6aHzI5cqcOnHFoXoObYRcrfEvfjl3WQkhzLQg1/yJ3wuhpALwnBSloAkY2xMv0M
         sU9KL3Kw7gIsRIc5X4mVP9yH5FV6l6OevJOvm68Nu4bneqFh/YSLEAoHFG5jP2GbTlYY
         y36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716905228; x=1717510028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLkiSiRrSAnOAs3Y6h5iMAoW3bCpoNjxPw0wPZ+lU14=;
        b=OAGhbgJQwV4xyoyF2at+7ip3LQv9174zgNQF8D+u+FSyDBXUcyorFT0inooO6aG1gW
         DrnTdaVLbxETDrn1PTTdQkfGYwCnQwbIQld0/fsewIQKo1qgB+9TQwkx0hAqgFmYPWTd
         QXGz4yi+BTp/nD0X1pRCnFJx5xQY70V4LYEfGcMxXqVZtisBXL+xcUjwgmBihEpdv3yI
         i1l+Z9NcI6Ru2t+05n0oIGFUYp3cibP7J5J7LiR8RjsOih8hRWDhMmP0RO32Lid7uT0R
         xTZ6IA155RzEzSMyCY+lpS4c523YlsGrxCYRWRelhioWe0GUEZqCv2egqY93jyokQuVx
         F7Jg==
X-Gm-Message-State: AOJu0YyOFXe95dQ7LbJOX5XNixf+i10uZkG8umeladIDlK20yha0ykOL
	wtyNEI6IxbXuFTqerf/PlOfVd0VLUA97zVQCAfwkLIOUv8vLD1+/qRxaMRU0
X-Google-Smtp-Source: AGHT+IEhXkpj51ZifiR25DYyGuchZ/W7P6QHJ62qqcftuUbXfQg8NXe4YOdQv/ClQq/lhxAYXo9rEA==
X-Received: by 2002:a05:600c:450a:b0:41a:8035:af77 with SMTP id 5b1f17b1804b1-421015c7259mr129966985e9.12.1716905228139;
        Tue, 28 May 2024 07:07:08 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:68e9:662a:6a81:de0a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-359efaf5402sm4534599f8f.78.2024.05.28.07.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:07:07 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Breno Leitao <leitao@debian.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 2/4] doc: netlink: Don't 'sanitize' op docstrings in generated .rst
Date: Tue, 28 May 2024 15:06:50 +0100
Message-ID: <20240528140652.9445-3-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240528140652.9445-1-donald.hunter@gmail.com>
References: <20240528140652.9445-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The doc strings for do/dump ops are emitted as toplevel .rst constructs
so they can be multi-line. Pass multi-line text straight through to the
.rst to retain any simple formatting from the .yaml

This fixes e.g. list formatting for the pin-get docs in dpll.yaml:

https://docs.kernel.org/6.9/networking/netlink_spec/dpll.html#pin-get

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/dpll.yaml | 1 +
 tools/net/ynl/ynl-gen-rst.py          | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 95b0eb1486bf..94132d30e0e0 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -479,6 +479,7 @@ operations:
       name: pin-get
       doc: |
         Get list of pins and its attributes.
+
         - dump request without any attributes given - list all the pins in the
           system
         - dump request with target dpll - list all the pins registered with
diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
index 5c7465d6befa..1096a71d7867 100755
--- a/tools/net/ynl/ynl-gen-rst.py
+++ b/tools/net/ynl/ynl-gen-rst.py
@@ -178,7 +178,7 @@ def parse_operations(operations: List[Dict[str, Any]], namespace: str) -> str:
 
     for operation in operations:
         lines.append(rst_section(namespace, 'operation', operation["name"]))
-        lines.append(rst_paragraph(sanitize(operation["doc"])) + "\n")
+        lines.append(rst_paragraph(operation["doc"]) + "\n")
 
         for key in operation.keys():
             if key in preprocessed:
-- 
2.44.0


