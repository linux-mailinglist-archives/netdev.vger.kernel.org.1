Return-Path: <netdev+bounces-269621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HBwKiVEvGmAwAIAu9opvQ
	(envelope-from <netdev+bounces-269621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:44:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4950D2D1375
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E5DA30B3F72
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE06C30EF82;
	Thu, 19 Mar 2026 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/nfclmt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73387311956
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945700; cv=none; b=mUYWrtmxLnz1g6nJcaNhxVpZkdvI6B53cOuQo/nTQwn/fzLhVF481uzvUtGwR8yMaXJY/yKywHrfkaSjguI/CSb9AToWztl//+nwgjj/Xr1Fwl9k4JZDubibsTZksnZoX46UEEdYzCOZK4P7bRsP1m1etYy/fDn66yjcp2NMmlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945700; c=relaxed/simple;
	bh=Ao3nrL4vnuJBUr3wVDxoo0CX/bir2AmlarDD+CskkAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbIsdum/TVk99vP4ojAJ1dOW6cEi017RFZmwadGqt3e995t4f/cLzLbHAii/3/fvMEhGAOb2vDal7WAo/tjG6S9Te5oO1nyxj1zS+iDjgY+9gD7OkWLrB2YskoUBRxy4HuzVrYCMUZiMa7mbQJS7k+6PwYnr5qxdgaLxEujRTGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L/nfclmt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773945698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WAmNMsulHJkkodkRhNuStHL4cTZjaT//oN+2zMRHljs=;
	b=L/nfclmtyhhuWdL6Z6BBV9rvoqeIgKHG2LbWNY4E4YiK6FUnxl00oPljnxTVsshWqc6jB/
	ivkCTXx345NOD7TkPdmAKkgYf3W7xMr8qn3dYSiHwb3E8cot+HNXoBxuOaQgQkgRYYhGAo
	MWzKnf5LscZrvKHFl8E3CZMAJTLv9Ig=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-tMcsKJopOGK_-sWEx7a-AA-1; Thu,
 19 Mar 2026 14:41:35 -0400
X-MC-Unique: tMcsKJopOGK_-sWEx7a-AA-1
X-Mimecast-MFC-AGG-ID: tMcsKJopOGK_-sWEx7a-AA_1773945693
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B688519560A1;
	Thu, 19 Mar 2026 18:41:33 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.224.95])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 767FA1953944;
	Thu, 19 Mar 2026 18:41:30 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next v4 3/3] tc-testing: add a test case for ETS offload
Date: Thu, 19 Mar 2026 19:40:56 +0100
Message-ID: <39129c374cbd00147b8c5afc04db59db62b50acc.1773945414.git.dcaratti@redhat.com>
In-Reply-To: <cover.1773945414.git.dcaratti@redhat.com>
References: <cover.1773945414.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269621-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dcaratti@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.822];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email]
X-Rspamd-Queue-Id: 4950D2D1375
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

While reviewing the fix for unintentional u32 overflows in ets offload
code, Jamal said:

 [...]

 > otherwise a tdc test should cover it fine (when you get to the
 > netdevsim change perhaps)

Extend tdc to allow setting hw-tc-offload via ethtool, and
add a test case to reproduce the division by zero fixed in [1].

[1] https://lore.kernel.org/all/CAM0EoMm17wsYZmdFLshH3_-GrZtzd=i0xnoO2yiVB=-N4761mw@mail.gmail.com/

Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 .../tc-testing/tc-tests/qdiscs/ets.json       | 23 +++++++++++++++++++
 tools/testing/selftests/tc-testing/tdc.py     |  3 +++
 .../selftests/tc-testing/tdc_config.py        |  1 +
 3 files changed, 27 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
index a5d94cdec605..ee09e6d6fdf3 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
@@ -984,5 +984,28 @@
         "matchCount": "1",
         "teardown": [
         ]
+    },
+    {
+        "id": "41f5",
+        "name": "ETS offload where the sum of quanta wraps u32",
+        "category": [
+            "qdisc",
+            "ets"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 4\" > /sys/bus/netdevsim/new_device",
+            "$ETHTOOL -K $ETH hw-tc-offload on"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH root ets quanta 4294967294 1 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc ets .*bands 3 quanta 4294967294 1 1",
+        "matchCount": "1",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
index 4f255cec0c22..81b4ac3f050c 100755
--- a/tools/testing/selftests/tc-testing/tdc.py
+++ b/tools/testing/selftests/tc-testing/tdc.py
@@ -755,6 +755,9 @@ def check_default_settings(args, remaining, pm):
         NAMES['DEV2'] = args.device
     if 'TIMEOUT' not in NAMES:
         NAMES['TIMEOUT'] = None
+    if 'ETHTOOL' in NAMES and not os.path.isfile(NAMES['ETHTOOL']):
+        print(f"The specified ethtool path {NAMES['ETHTOOL']} does not exist.")
+        exit(1)
     if not os.path.isfile(NAMES['TC']):
         print("The specified tc path " + NAMES['TC'] + " does not exist.")
         exit(1)
diff --git a/tools/testing/selftests/tc-testing/tdc_config.py b/tools/testing/selftests/tc-testing/tdc_config.py
index ccb0f06ef9e3..9488b03cbc2c 100644
--- a/tools/testing/selftests/tc-testing/tdc_config.py
+++ b/tools/testing/selftests/tc-testing/tdc_config.py
@@ -17,6 +17,7 @@ NAMES = {
           'DEV1': 'v0p1',
           'DEV2': '',
           'DUMMY': 'dummy1',
+          'ETHTOOL': '/usr/sbin/ethtool',
 	  'ETH': 'eth0',
           'BATCH_FILE': './batch.txt',
           'BATCH_DIR': 'tmp',
-- 
2.52.0


