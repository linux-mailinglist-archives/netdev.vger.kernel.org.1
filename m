Return-Path: <netdev+bounces-266283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPXqNghesGloigIAu9opvQ
	(envelope-from <netdev+bounces-266283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:08:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C29625627E
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 19:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 940B130054CB
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F873D1CAC;
	Tue, 10 Mar 2026 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzTdgDi7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2923C9452
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166051; cv=none; b=ljWh6BeuxcuG76nl3G/2JbXIDAiSZJ/epGe3yAYfMzW61rAtuaCF4R21tKDc7vaQ9QpM5oXXLqv0kIa2eHz2vRHQJkWbRocjaL7TpcQVg7+6Vvac0ModPeTeOEMGC8WCt6VSaa+93PBbiGJV00tJV8FJc/8J86pPHnS2P2ZYsUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166051; c=relaxed/simple;
	bh=TOIxCaaQZCslnPSzRbjtB1BfPHqcCBDUGx5tuEkjj40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kofztOts5A/1vziw4RIwIZr/RqdEZ5eItwT2/vT1z/jk0NRxIxJdGZlNKE/6MJ/xzF/z4CNXteXs6Z5WMUda5eKJdW8BX2gYIb5bM8gw5uzfA0xb5MjkG8X6xnG1WMEv3YFMiidZFZRphXqTi9/zTPeoHYHuJ9e/BABHqcF/zb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RzTdgDi7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773166049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SYgkPHSTrobEp5EvyP2HzxHmiohKuV8d8R9zRfNhISI=;
	b=RzTdgDi7an3kxumMGM0dYon1yUSJcPGW+6nHaTvVFPbMr1wkq24R287rWRjIvvF2bIiXUl
	Bai9lAO5vIbAMPpVfx0ofS4lBB2jRtSZbCGNpv9fWUddYJb00liSViiRYBbf8ACAiiDQuq
	nZC+iSw+Lr6fbL+KoKgLva3+YYT9feI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-nqTzg-LINHOqX0VQ1_h3sQ-1; Tue,
 10 Mar 2026 14:07:23 -0400
X-MC-Unique: nqTzg-LINHOqX0VQ1_h3sQ-1
X-Mimecast-MFC-AGG-ID: nqTzg-LINHOqX0VQ1_h3sQ_1773166040
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 258221956060;
	Tue, 10 Mar 2026 18:07:20 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.44.33.226])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4AEC41956095;
	Tue, 10 Mar 2026 18:07:17 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next 4/4] tc-testing: add a test case for ETS offload
Date: Tue, 10 Mar 2026 19:06:31 +0100
Message-ID: <43fde83da7dab5e2ffde37658a753195f145eece.1773165520.git.dcaratti@redhat.com>
In-Reply-To: <cover.1773165520.git.dcaratti@redhat.com>
References: <cover.1773165520.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 8C29625627E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266283-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dcaratti@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mojatatu.com:email]
X-Rspamd-Action: no action

While reviewing the fix for unintentional u32 overflows in ets offload
code, Jamal said:

 [...]

 > otherwise a tdc test should cover it fine (when you get to the
 > netdevsim change perhaps)

Add a test case to reproduce the division by zero fixed in [1].

[1] https://lore.kernel.org/all/CAM0EoMm17wsYZmdFLshH3_-GrZtzd=i0xnoO2yiVB=-N4761mw@mail.gmail.com/

Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 .../tc-testing/tc-tests/qdiscs/ets.json       | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
index a5d94cdec605..479b866031bb 100644
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
+            "ethtool -K $ETH hw-tc-offload on"
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
-- 
2.52.0


