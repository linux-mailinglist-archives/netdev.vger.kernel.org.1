Return-Path: <netdev+bounces-148778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B319E31CF
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 04:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A09DB2A61E
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C06813D51E;
	Wed,  4 Dec 2024 03:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a9uwQOcK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BD413A271
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 03:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733281576; cv=none; b=Sn1sNWUXx+01Zieagbw2AkwigmYOYaqmNRriSGDjt0yKKtZLbBuryG1OgH0vdD6alOfOOHX+3iWMTbtElhC8xoYgv9flvq+X2FaMEirF/KyiPvMOGBpXd+xB0f7fw+GKfrJ0Q0CqNpfQm6NCTwCD8S1iBzY+zUBEWvWon1UrZrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733281576; c=relaxed/simple;
	bh=f7qtXZo+LmVwden1yoz+OKcyWTpUDFlIviOvyJRkA/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DB2JqtPiYgQHPXgV8G3jEDopUas7SgoKfIQgnlXshVupPSN1KBXs3lP5CJVTx6RJyAFQhLnzobtOto1+TpFbhW0xWoTRql4U1Dj+8ooYDO3y/74UhkVsgFbo+3InPkXjjtlzyTvk+yUh6iu/6wsiCg8kvVIV7U0bPtHuHOrww/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a9uwQOcK; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-72535e4b30aso5332079b3a.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 19:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733281573; x=1733886373; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zBf5l7VMIYQkgKl8HiftC1SiSBVaS4lDPtHAMi4IYAk=;
        b=a9uwQOcK9whpidrHxK1Yu/xptiVlk4CSnHlWBuxaats/VU0Sfwru7AyPh+bTr6G3Y6
         PRuggxKGaGr6xp2T052TK4zL27+VegsNeq5F2bscM0BlI7oaOf9RHIYXt9W5wOSDQn3m
         FUSgK3uSPlgRYo/1NT+zLx1B4bhbWUyc6khKLpQHDB1ZMADcIkGRksLT25heZIei4rc3
         bx7OvPstZVIvzP8qd+TjS3B1Jb1Bi2j05htXLgTgih61zcgYgQ8KHhrpelDe59KaZlsh
         czVxaPvp+MSsZw0R9IPOogl4v6ctXDk95R9o95hiKyeu0e9qs56DUbnrHe11g7xDn/JC
         iyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733281573; x=1733886373;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBf5l7VMIYQkgKl8HiftC1SiSBVaS4lDPtHAMi4IYAk=;
        b=Qf9dlahd5NfMp1P66wL8+aLHOGt/DTRbzErMuSeQHRY9ePox/JMfYFlLSSnbhT8GGh
         62kEDkv0F+awkZRHubh6U48nt/1ixZ04Cxk1EcA1stFNikzVGGzEZy7J2sOTOjm6T3/f
         kinCb1TqZRZXD2MhTSpLVap3hQ+XmLy45aZBWyi3NMOT+xX+dnPi7CvDNPiqVGwGekdM
         /15gIKrcFHIVeoZVevWtPXXkXWMHSXu1Ix6bohobMXmoygPaoOWb6CsauqQPhdZe8QZe
         DcQ6w7AkgRX05U2iVDcsoRMDncUUcTmTORQbhtYL8MsZoqSmSfn/rtJAfreUpc9WBmdW
         KBLw==
X-Forwarded-Encrypted: i=1; AJvYcCWfMByxaUOUZ4ZE5vs4ZC3XRTH8NiyZM9zQCIcVm/91JlR1moeuNplPaPQIn0KdSSoQIc7wLfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT+mafVPz24PXIyGqcsaTLw3RAbPFHHvqRN5RyPe/ASSjNhTca
	7TUU83hKdaP7VpIV4B7HCrcs6DbEIen/s07UrTNgIEVesexSDlD5FFqEVDseDBNtjlrF4wQOoQ=
	=
X-Google-Smtp-Source: AGHT+IHbU1LwKWfSRC0WHPcY8FhwQvH6Lo15XYAZ6nRXfB4LoefK3Ez6NWUx95K3c7UdcI2Bw1MwpjBWGg==
X-Received: from pfbbe16.prod.google.com ([2002:a05:6a00:1f10:b0:725:1eb5:edbd])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:17aa:b0:71e:75c0:2552
 with SMTP id d2e1a72fcca58-7257f97be81mr5881152b3a.0.1733281573340; Tue, 03
 Dec 2024 19:06:13 -0800 (PST)
Date: Tue,  3 Dec 2024 19:05:20 -0800
In-Reply-To: <20241204030520.2084663-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241204030520.2084663-1-tavip@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204030520.2084663-3-tavip@google.com>
Subject: [PATCH net-next 2/2] selftests/tc-testing: sfq: test that kernel
 rejects limit of 1
From: Octavian Purdila <tavip@google.com>
To: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

Add test to check that the kernel rejects a configuration with the
limit set to 1.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 .../tc-testing/scripts/sfq_rejects_limit_1.py | 21 +++++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/sfq.json       | 20 ++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100755 tools/testing/selftests/tc-testing/scripts/sfq_rejects_limit_1.py

diff --git a/tools/testing/selftests/tc-testing/scripts/sfq_rejects_limit_1.py b/tools/testing/selftests/tc-testing/scripts/sfq_rejects_limit_1.py
new file mode 100755
index 000000000000..0f44a6199495
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/scripts/sfq_rejects_limit_1.py
@@ -0,0 +1,21 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Script that checks that SFQ rejects a limit of 1 at the kernel
+# level. We can't use iproute2's tc because it does not accept a limit
+# of 1.
+
+import sys
+import os
+
+from pyroute2 import IPRoute
+from pyroute2.netlink.exceptions import NetlinkError
+
+ip = IPRoute()
+ifidx = ip.link_lookup(ifname=sys.argv[1])
+
+try:
+    ip.tc('add', 'sfq', ifidx, limit=1)
+    sys.exit(1)
+except NetlinkError:
+    sys.exit(0)
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfq.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfq.json
index 16d51936b385..50e8d72781cb 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfq.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfq.json
@@ -208,5 +208,25 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "4d6f",
+        "name": "Check that limit of 1 is rejected",
+        "category": [
+            "qdisc",
+            "sfq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "./scripts/sfq_rejects_limit_1.py $DUMMY",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "sfq",
+        "matchCount": "0",
+        "teardown": [
+        ]
     }
 ]
-- 
2.47.0.338.g60cca15819-goog


