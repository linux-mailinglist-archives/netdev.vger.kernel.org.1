Return-Path: <netdev+bounces-280491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IlTAZX26Gl3SAIAu9opvQ
	(envelope-from <netdev+bounces-280491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:25:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D86B1448963
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 344EE303B799
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215573803F7;
	Wed, 22 Apr 2026 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6QGXN3V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F3537FF68
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874842; cv=none; b=C5uXI5ivybns9p7lMbTPffIPiRdQ4xxeaH0oymxFzRNPdMpxP4qmA3caHsMVyT7b093jscyv521f08aoWmAlbRL7RQXNgUFYPq3JKBJB+/f9BZjPaVs5tQgNnKYrY1/lhtOD6DUmEWknkLmuQsRJKtTvUbLqzUQ5KHXGYBVO//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874842; c=relaxed/simple;
	bh=/vtMgiw5QLUdNwiN05esofk6FTaIE2b9NYDtemrg3FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fl/oDA/hw8rdMWrqXGVHgBQaaTp/QD2vU+GqDTCMwqz2Yxps80/99t/7PQ43X7yC3AT/Yyd7lPj2gkz1fghGXUNSW5ANEepyk5b3SvnC6XYvGig0RCXxVnx1kr8xVkrYee8QVhmaMO439iXCDR6wh3WxAoq8k0VNiM0EQB2xfw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s6QGXN3V; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b788a98557so15604865ad.2
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776874840; x=1777479640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMiVlw5Dks3Rppi6Ek+IOA4onw9VFCFtvI5cTye7hR0=;
        b=s6QGXN3VRc0u5+EWnz5r4xL0kltPdSjqTXaY0g29fZQx07xX1dIEiQwZZJUgjtLrXl
         0ffcrWGH2xYo4lHkkg7QuM2EiuDY7p4N3qF+Y2P+i421AHyo0EAd69XTaGNEvRfePSJG
         aAI2g0yJw882MzGEWNh20KzAF4x+xkz+Cgub07FubP+nPCp8tW5pEflsOAbzAmkmHUTy
         AcvXKw0BAUpb+5l5YWNsz9TaKUDNVu9m/c2UPBMqjsMYD8mbpp+03RpTfwHxFHQkv8Nm
         29uEbATmfpbch/lAY0zybABRNMRCIn+Av9xJheGd1ODk8JJ/IMg8Pfss7yU+tFlNgatD
         4BfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776874840; x=1777479640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JMiVlw5Dks3Rppi6Ek+IOA4onw9VFCFtvI5cTye7hR0=;
        b=eASj3K+FanDG7D9wX1f69ZBVA00m5sA9KRHCzVQs82D/TbkdcoLfKYX0edwRO9jgvO
         Ew3S3QwAM8fbV5POgRF+CA0+SNm8e80CGGmq66swnNQeDyQ/8B1Bu2J+Z/VWbH4AyTrP
         5WDiGqu9Uohi8TYUMfCBTgy4vzSYXULsO1KNriAd+Y7mQR9F4kbAOvXYUIAXFaCcqKzM
         GoXGZN26NliM1iDv/HNp1PmsIB4VMGxrebGJSaE90m7VSYC+b6V8cm84jesWjld1vKOl
         wuUV41RSZ36b1uxTIx/uabfRGmb7oHg+zwW7U05inFCFQ5IRAT6qb1Zv9zZumGgDbuGb
         sLEA==
X-Forwarded-Encrypted: i=1; AFNElJ8UTvG+FGsH3pqUARp3Crlcr//gVp5RZdNs3BDN7JMM/0xIwykOZBoiqFlJObQ9qo0hXuQ1P0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI8IYl3ME6LtsB0QXtVInVEMHSK2EbTb47RA0Anpe3cETX90yx
	/K07Cui9IlWaSg0Qdb400Bxw7s7CS0yGqLA0Oc8OU9dkBeaLjywE4Sva
X-Gm-Gg: AeBDieuc5wzfHTpalXQRzxuE/gq8KNZfMKN4FWGDdejX4p8NcHY+hhSgJOzhIA3TstJ
	/Dv4+P+QpPvZJVMhA5TCJ4iWxtK+KmaoDhF/NlJUOMbBO4BpwUXn9tOym30C3N/fSlWAnA1O+3q
	EDvDEZFkcRDW47/GgmOWAbEQrjCavsae6QdDvo6wOu39KkZeYet3BB7i7tTcIerP/yj71i9axMW
	SGvecGA8X50ocPN/xE8+Cg0J+jYgRH8cJLH22+/zeyRr3cvhgn1IA8qgJVt73W+Az+CGzvJupMC
	EmiW6/yjsRzyVNfDsP6aqxracNsli6vkhgiqLaPH2xy6TYDSt9mkpO4NL4SZd5pAxEtCm+3nQTh
	ri89/ZQ/BqpWyEErglhpBhu6j+z++7QDBpcFwKRFQ1hitOpXW/CVsIeBKeVazW2WkX7ETcoy/o6
	ljZp41+IEnvTl7Tx1AK25li64+ky2eRkfhHih4Xxto0qMcxEQSB94ul2YM5bygOpdHOXFj/w+s8
	Pn0Qb8Ut2MTi05lJwD6XAI=
X-Received: by 2002:a17:902:a70a:b0:2b2:b117:1d5d with SMTP id d9443c01a7336-2b5f9f93101mr167276235ad.33.1776874840051;
        Wed, 22 Apr 2026 09:20:40 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cdd1sm170335445ad.38.2026.04.22.09.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:20:39 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: vinicius.gomes@intel.com,
	jhs@mojatatu.com,
	jiri@resnulli.us
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vladimir.oltean@nxp.com,
	shuah@kernel.org,
	xmei5@asu.edu,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v5 2/2] selftests/tc-testing: add taprio test for class dump after child delete
Date: Thu, 23 Apr 2026 00:19:59 +0800
Message-ID: <20260422161958.2517539-4-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422161958.2517539-2-bestswngs@gmail.com>
References: <20260422161958.2517539-2-bestswngs@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,nxp.com,asu.edu,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280491-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[0.0.0.1:email,0.0.0.5:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.2:email,0.0.0.7:email,0.0.0.0:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,0.0.0.6:email,0.0.0.4:email,0.0.0.3:email]
X-Rspamd-Queue-Id: D86B1448963
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a regression test for the NULL pointer dereference fixed in the
previous commit. Before the fix, taprio_graft() stored NULL into
q->qdiscs[cl - 1] when an explicitly grafted child qdisc was deleted
via RTM_DELQDISC; the next RTM_GETTCLASS dump then crashed the kernel
in taprio_dump_class() while reading child->handle.

The test installs a taprio root qdisc on a multi-queue netdevsim
device, grafts a pfifo child onto class 8001:1, deletes that child,
and then performs a class dump. On a fixed kernel the dump succeeds
and all eight taprio classes are listed; on an unpatched kernel the
class dump crashes, which surfaces as a test failure.

Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-6
---
 .../tc-testing/tc-tests/qdiscs/taprio.json    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
index 557fb074acf0c..cd19d05925e40 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
@@ -302,5 +302,31 @@
             "$TC qdisc del dev $ETH root",
             "echo \"1\" > /sys/bus/netdevsim/del_device"
         ]
+    },
+    {
+        "id": "c7e1",
+        "name": "Class dump after graft and delete of explicit child qdisc",
+        "category": [
+            "qdisc",
+            "taprio"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 8\" > /sys/bus/netdevsim/new_device",
+            "$TC qdisc replace dev $ETH handle 8001: parent root taprio num_tc 8 map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 base-time 0 sched-entry S ff 20000000 clockid CLOCK_TAI",
+            "$TC qdisc add dev $ETH parent 8001:1 handle 8002: pfifo",
+            "$TC qdisc del dev $ETH parent 8001:1 handle 8002:"
+        ],
+        "cmdUnderTest": "$TC class show dev $ETH",
+        "expExitCode": "0",
+        "verifyCmd": "$TC class show dev $ETH",
+        "matchPattern": "class taprio 8001:[0-9]+ root",
+        "matchCount": "8",
+        "teardown": [
+            "$TC qdisc del dev $ETH root",
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
     }
 ]
-- 
2.43.0


