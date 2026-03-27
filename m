Return-Path: <netdev+bounces-272392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOCDMNgrxmmNHQUAu9opvQ
	(envelope-from <netdev+bounces-272392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:03:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D38340275
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ECFB30D0A57
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 06:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BE03C276A;
	Fri, 27 Mar 2026 06:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="R072OKnB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A7C3BF687
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 06:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774594564; cv=none; b=HrN9ff+WvMcp9pDXbMkvCEBbV8GN6np1eckVZZ/9fHayfjpBp42naDqBlC4imx7g2Ylpd3hnKmDGsCO52bCDXfbE8A3hTgnz+LU9I40+OhHGgnnkjr1JOPCqzWguwpP+3XC0x+zc8o+EHmDUBoMWghJlLL9wyXv4nnRFPiPbWs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774594564; c=relaxed/simple;
	bh=pzNOcC6MQY4m77lKhVLPf5Crn46Z/jG8pstZT63UrNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IA5Uw8PKuYYW34VjTo3NSyfxvckISLnqa4zea7TwzNcGHceKbi6fW+zgcQZVMyXGShvfbFArA8eYcA4qPO9K9n7zSiv6sCzSqRIzntvDKdf3jBI9sIzD+Jky0l/pJTjwtP/yrTC3S+DoQtnAZGUF6QR5IYR7Zz9ASB1HGi0Wyu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=R072OKnB; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2c175635a33so1174817eec.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 23:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774594555; x=1775199355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNiW3ma9OdcBsoaDz5WJ0IYBuhCWEZ+XGPJsxYt1x8E=;
        b=R072OKnBaOq7110Vt9jNL7OsYedSKr3vqa7f3ctRaAxJtLHC7Cna11pMggq+iqNVSm
         Mqqe4Mwa+ljsX/26mOHNu40inT8iqrmIdEbOJCSbD8De5CFkij6IUimFd9zphviAeTjP
         5oqM3BJWeCTSd8Hdo2WtWQaIS1geZqqk3uFR72RbsyIdUEGTOqyYT2outt3X8sYiPpCz
         6+XKTxYTvybi2jXRcfoUSEt4F8AVA4auuHvj5u/O7odF/SWEEZzhK29McyRGZozy0pTG
         8dM6bjWnXP+VYgAosVc/ee0toHuQKZ5zmd2+9z6HIBEZnVy/NHwS/hAj6I0hHSRD5jWZ
         /Wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774594555; x=1775199355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CNiW3ma9OdcBsoaDz5WJ0IYBuhCWEZ+XGPJsxYt1x8E=;
        b=ZnQqPee5DSSd1LVGGymGXTrSYDPuyFq7NGm1Jp6LIsvWwIQI+eUNd43sdgVhOBjl07
         xgZSqIzP3sRe+Rd6h8H0jNwZBdvACWVxBPzvIrT8Hfs8s4zh9fCtHxLbG/XccwtdLAvI
         dDi0UHyBkCAWGOUz05dz7t6QJehbzeUWSSz6K9DdR3jc5wnBKKMIO+fVTjtvDJCt51dg
         o2QNO2n4iLH0ru/xEmuzYELP6wCCCpObuzj2DtqbmwXozcgCgMAkWS1px5FE+1oRCML8
         eHry+9sMhCU+1K9TdctBLEd2onZaDZmgWhx0AEKzSYMik00G4G50z3VAvrqjTSGcl0rg
         bwng==
X-Gm-Message-State: AOJu0YxDbtiaDIaaj6bigXl+kbKPWxvD2IPvozapOkzqtwnuu89fbPkX
	yuOCRlp8jwmDH98BH04Ouzov2pP4pY1St9LqlawDiVI9NFOL6CzsnNfVYwzZPVAqKb8BRmwXlGg
	1ejP0ag==
X-Gm-Gg: ATEYQzzxys2KweO1GZY1drFPB0BwHyuEgN1c1bge6ggTDnB+wyvxqOH8AeWt1seH9xX
	38XOInvO2bKvxOWgmNCUr0p+/nxYm6urKSLI8taKv6HYYl6EyPNG4+1gPU9c3xwYQIsAKtiOHk0
	3mFWROKQNX4kpa2lm5m3HFF7sYU125d8Uo4HJnUTMcWJCi3z7uecBkutFVB7jp0fAAUvIYLesif
	k1udq2jk2f1NkpD8vCj3tRgSEBEcJusWg5J5nSyqI8Ou8ilz3u6dA/PayDszRO01bvEVKQkJVZt
	uJeHDd2BSAMmMrtlYAb8WDQKZIswhmowWbT7xBu692285rpoxtGndEw1ryqbUm6PWC346goM21C
	06TX/koa/4aw4N10pH8+t1o26+kfsGafEP/LsXsYxerITpfuQQ1vDpNt0jo6Rbo3/UZLWbWxYRF
	0Q5Q+SlEgHJXsww4EmxbliqpU7N6IjBhlZKyiUwZfx+O6KlXqjBwG+Sg==
X-Received: by 2002:a05:7301:4094:b0:2c1:71a8:3843 with SMTP id 5a478bee46e88-2c185ed7219mr601131eec.22.1774594555054;
        Thu, 26 Mar 2026 23:55:55 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ee3c3ecsm4503957eec.31.2026.03.26.23.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 23:55:54 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	shuah@kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2 3/3] selftests/tc-testing: add tests for cls_fw and cls_flow on shared blocks
Date: Thu, 26 Mar 2026 23:55:47 -0700
Message-ID: <20260327065548.3191115-3-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327065548.3191115-1-xmei5@asu.edu>
References: <20260327065548.3191115-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272392-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com,asu.edu];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[asu.edu:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:dkim,asu.edu:email,asu.edu:mid]
X-Rspamd-Queue-Id: 46D38340275
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Regression tests for the shared-block NULL derefs fixed in the previous
two patches:
  - fw: attach an empty fw filter to a shared block and send traffic.
  - flow: create a flow filter on a shared block without a baseclass.

Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: Correct 3/3 selftest case

 .../tc-testing/tc-tests/infra/filter.json     | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json b/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json
index 8d10042b489b..b82a48ab9e79 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json
@@ -22,5 +22,51 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY root handle 1: htb default 1"
         ]
+    },
+    {
+        "id": "b7e3",
+        "name": "Empty fw filter on shared block - no NULL deref in fw_classify",
+        "category": [
+            "filter",
+            "fw"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set lo up",
+            "$TC qdisc add dev lo egress_block 1 clsact",
+            "$TC filter add block 1 protocol ip prio 1 fw"
+        ],
+        "cmdUnderTest": "python3 -c 'import socket; s=socket.socket(socket.AF_INET, socket.SOCK_DGRAM); s.setsockopt(socket.SOL_SOCKET, socket.SO_MARK, 0x10000); s.sendto(b\"A\", (\"127.0.0.1\", 9)); s.close()'",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev lo",
+        "matchPattern": "clsact",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev lo clsact"
+        ]
+    },
+    {
+        "id": "c8f4",
+        "name": "Flow filter on shared block without baseclass - no NULL deref in flow_change",
+        "category": [
+            "filter",
+            "flow"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 ingress_block 1 clsact"
+        ],
+        "cmdUnderTest": "$TC filter add block 1 protocol ip prio 1 handle 1 flow map key dst",
+        "expExitCode": "2",
+        "verifyCmd": "$TC filter show block 1",
+        "matchPattern": "flow",
+        "matchCount": "0",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact"
+        ]
     }
 ]
-- 
2.43.0


