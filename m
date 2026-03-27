Return-Path: <netdev+bounces-272381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ca+GP8fxmlbGwUAu9opvQ
	(envelope-from <netdev+bounces-272381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:13:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DFA33F695
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5365306B381
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 06:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700DE344D91;
	Fri, 27 Mar 2026 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="lTCcQx+3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1270534CFDA
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774591995; cv=none; b=mMjhrjb68b7FzKYYatKUxHzfoOKCAJIDwosK+sX5oMngBgrw3uX8sgFKL28+NMJo6/RWp7UXImTkGSRiCxu6qqXvtdcm1m3cppGI4Q9b0e3ngkrjjLxtuz4NcBPO7zCPDNZ44uVp8CECEmFu2AZWcdxBjqCFTQZYJQyJtkgOKCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774591995; c=relaxed/simple;
	bh=7IAVFQ22luLLoScxk2r4L1McIpblN+ISn1+oY7K9Gt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdr18FVAYydp+4G7sxRvI4Lbu12oufLnIYjcKgyAQaYL4TY0u/gY+blx6KVikU3lzlyYyGTno5f4d/WXnYqBErmvxeAYfme0AjUpL7JzPTrDkKdvdSm4gdPwqAAU4riYdiwYMdjJIsKsEdx0MFuyxESmlLzwVFB9cVuHoiSvXYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=lTCcQx+3; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so1563048eec.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 23:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774591993; x=1775196793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSxNOOdfdbQoEkwoyaF+9gJkfdj1EolLZPAX5NBWU7Q=;
        b=lTCcQx+31lGaTr0RKfyAU/H0YVcEhNuDQVtKxSr3q3sCpSurc5/dzT30LWhdBxUP6G
         EDKmxwf/KLcKw+S1GbyhQkOO2kyTX/3pVJUImHsIFUgKFsWyLkMQrY+Rh/5BfYimXHA+
         Sl0978FdOPfRZzoCobWzS/qhJuwDGZjT62gCBgS5Dx91PHpTeDlymYKXNd9JZkqnPrE+
         u5SJiASjaOY262lLv0tWjY3za+eIH8g7EnYxX5RhTGMyRTQ0+xJPEDKiyVQ2FSIkd0CF
         H0LMfW1BgStHRFvrI+7+BL8Wpm+U57A1Y4O564hx9Uh6QiGKeAMoNIo2txz021qxakO+
         kNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774591993; x=1775196793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TSxNOOdfdbQoEkwoyaF+9gJkfdj1EolLZPAX5NBWU7Q=;
        b=iyWTmYtmSdqSCDSY9ANAvB2Kq2qgmnQa+HShBEcOxmppoet1s+4T2I4DNK8wnCjXjj
         Zq2T7NQFEaA+E7p6j2vX4v2jfMUl+a8XwlmiPnYgzn6pgvEQInYnHXPaRTyfg8o6T02+
         MKz567Oq8Cd13rNKCNVOnSXPYJ+UAoWmVv9Ejnz+lSrAQSJdjVeTSr60jIO379jz6WtV
         /AnsuJv8JqrsvxQ+0gzf/6CJptlKNYTfRXlLKminDZD+plse+9CRbJSgdj9WjXoDzGX8
         Jmba55OJC25+FFTUsiCGA2W0hLwa/IYdN5YC0NGZhtY58sLks4Ta0fWpZJWVvuqD4XnP
         DmTQ==
X-Gm-Message-State: AOJu0YyUNqcTE2sF5AKHr8MLRwz82shRUUQfh7DGd7RCf1AsSzQv1KA5
	IjFzdoE1zTsA0FAcNX9X2o51j7KzTDbstmDQaYFpJaMNa/tvN+Ee2DhP5nNJmh6bn5ZZ6Bm1XPa
	rNj2S0Q==
X-Gm-Gg: ATEYQzyvrdrhKra7Png1PjQpdQlLUbdE6cHjqzG/86zmEuP0uNRojDhXTwljDzBCg46
	51RFK5pxGKz+gFPYNUg18udAqBwhVzcTyFFh4QVf2hWaYtaGa7LNI+h6OHcegQrePImGsOVGun3
	y5ZqMd9vHRHWsM/xOf9tx+gPqYHQp2TMPYVeW8Ue/yKm12DYZx155mFbppqXU17k0u+Zk8r1D7v
	krwMMaZO9GPsPLEKduavMiMXvRXhGZpBj75Rhq8DFMBXPR8UHxdakTK6DHeinfvnLsda1MRCxgL
	K2V96ZnhHcGKY9UGWr242npmJfJA5oS21uQl7Qw+a3s5pgDLIWmp3YXkpRGLm4lmRLC6tDvI5vb
	KtzYisIjjlpWBkDw1l6P0ypKRHVxglAxJnlBHsASlxgZcMCkgXSM1VtoEIgnXv7sBz1TyH0OoAT
	AxbMGZjbv/OsWVoQwjCSoTMi/9J8dTDMBCq4BFXBgsdjeg8RLo8Gl1kg==
X-Received: by 2002:a05:693c:23c5:b0:2c1:7fd3:4504 with SMTP id 5a478bee46e88-2c185d537bcmr720551eec.3.1774591993007;
        Thu, 26 Mar 2026 23:13:13 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ec26651sm4629441eec.2.2026.03.26.23.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 23:13:12 -0700 (PDT)
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
Subject: [PATCH net 3/3] selftests/tc-testing: add tests for cls_fw and cls_flow on shared blocks
Date: Thu, 26 Mar 2026 23:13:00 -0700
Message-ID: <20260327061300.3066844-3-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327061300.3066844-1-xmei5@asu.edu>
References: <20260327061300.3066844-1-xmei5@asu.edu>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272381-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20DFA33F695
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Regression tests for the shared-block NULL derefs fixed in the previous
two patches:
  - fw: attach an empty fw filter to a shared block and send traffic.
  - flow: create a flow filter on a shared block without a baseclass.

Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 .../tc-testing/tc-tests/infra/filter.json     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json b/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json
index 8d10042b489b..b749087d1691 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/filter.json
@@ -22,5 +22,50 @@
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
+            "$TC qdisc add dev $DEV1 ingress_block 1 clsact",
+            "$TC filter add block 1 protocol ip prio 1 fw"
+        ],
+        "cmdUnderTest": "$IP addr add 10.10.10.1/24 dev $DEV1 && ping -I$DEV1 -c1 -W1 10.10.10.1 || true",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DEV1",
+        "matchPattern": "clsact",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact"
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


