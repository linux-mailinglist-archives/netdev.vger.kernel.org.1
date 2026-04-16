Return-Path: <netdev+bounces-279114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJKoC8gw4WlGqQAAu9opvQ
	(envelope-from <netdev+bounces-279114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:56:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA97F413E66
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0F9A3065A79
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B05E346AD7;
	Thu, 16 Apr 2026 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezMrbCMA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ABF33FE15
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365726; cv=none; b=LDH9G0jIUfivs51w/hRaMsy4rb4Up/0TxrIt8dAAVfNtx7qn1o2u8dmjfAsbIFLTM+hzdhP8HgsqMiYJyWWfXS/8egcJPa9yjnp/xYNSwQVIZurvZwEI9aN5gbNW1PjRPrGlgSWo9QLOtC9dMttpT5fKyjyDduxXhJWmTX1HwNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365726; c=relaxed/simple;
	bh=/vtMgiw5QLUdNwiN05esofk6FTaIE2b9NYDtemrg3FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=setmaSPCcaBCNeBCJyatWElQVhw3umPyvmgh3IrNIwiJfha9y1LoMYl4kUREq0QM7Yk51udKdUrLLb8iXndlkSB/pbyINB40RYz6IQVcTxQ68SPTPaagUl2xJUQyenKHeiwpYtUnFkc8DcyHpurXPV5M0EkzPqL2ac1fMT4lVck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezMrbCMA; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-824c9da9928so5753021b3a.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776365724; x=1776970524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMiVlw5Dks3Rppi6Ek+IOA4onw9VFCFtvI5cTye7hR0=;
        b=ezMrbCMAn9gUtXcsz2oYGdr/JAixMjWdVqP755EZxTOuVd58AX4L53rmQQdOydiNAh
         nnVURwodITeEdSmcuSPVJ7ZUOlvhzo972GCr/r+NPpJqXw1R9DIA4AAF0vg66JIDEpcG
         67y2qRWhVxVbFdg93Nj/pS+J6MpCjHEwHXn+jYAm+7ESmk0y5ldXoMUhprzYbktatAKB
         tG9Z+kYd7jgduq6rBUXFzOw6T05wCFdhHbZbIWGi9RRKwLqhDMwStuxfFlCS0b+hKYIh
         Mn0BUx+vcQkAk0SGNBLFjPodxRDsVh9h9HfXTGNGWBGs2+g3JCc21EfSo/CzI/A85rCM
         uMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776365724; x=1776970524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JMiVlw5Dks3Rppi6Ek+IOA4onw9VFCFtvI5cTye7hR0=;
        b=LOUCHuU2i8ndlsHfzNsiAxgsw2vt/Ty9hSP7WIbWjEZSK7pkHT1MYP6d/cs+Zwyidm
         xQsywakrLJlDStdO5nuhkDmhwpxwrMp5LGiSUMhDX7lMykSyHdieImMnoosptXpp6mBy
         EBGf9Cra3esxg2lPPmWIAO/hOtMILqhfYENCBAgLsQHYst4gANQWuvuXXEslgXvhbz5I
         JLB1IXgw9FYT4Gv/+TfRB9/3T/8cDZNHpsfQJQJMPuPu8URL4dBf2akfmWe/10QnGuTb
         Pb1jrtctv9FHXsZ614WcJI6gajwaJXm2sbQ5vGjpofpx7Q3J4UhdDizLUTAYEPJ+G7kH
         3ang==
X-Forwarded-Encrypted: i=1; AFNElJ99shsiTixNnzW/SNJT8I2jhLj7mrudU4FqXTllf5CbXjeP6IFx0dMKcLdK3PFlcLzSfgoMxu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuYZF//X+RE/cLstSUbuy9892ok12F3BpCedPf1b/NhqxxFhm8
	tTfe0oBMsrsYCEe3e0xPbqgIgksDy8caEcoRWTjZkY6vFqM8W8HKORdc
X-Gm-Gg: AeBDieuzhlPtUPL9u+Yog7ep4m9umMrtVJjctf06NdxbA5dHX7agtrXLEBsV1z2UfTK
	2A87L8T1oEFi585rWYYgzZINQJ63YQLA5TqetExwEuR7LzU620ZhWCND6f2nODx/SZXSgJKwGQ8
	fn2JKkzMufw4mWhEib64f5+gfdlCMG8JgcNBGK436g+lpwehbQNM/m7649hEuE/OOr82PSg8tnL
	0WB4/2qgw38axOSf5CZX8aPYfSqJbQwLbIzALmGs/o4TIchU27toqa6EME9MFEpGXYu/3Ooy2IH
	05fP6wN//N0rfwhsOZ0uAM2hY8rXA/tAJR1tH4TRHNTfYhqr4F7GI9V8Lxh4RzAMDyZuL8/qpwh
	TwptUUfLo0ifUMPHhxqQFz8r6YSJEREXUndUbDfjapMsMoMFm+zqjObbj0w5p9PJ0sxIh8g36Ya
	NLXy0n+qyXlMsHomPaQdwNJj4ACgnbhD7gQca4rsmHsF5VA1CZxrQwpT34gFSVtbS7U08kRQPr1
	Ww4OD3AYbw1aBmQtu46FvZhlCGhxBcYog==
X-Received: by 2002:a05:6a00:1406:b0:827:3914:f130 with SMTP id d2e1a72fcca58-82f888c9963mr506028b3a.36.1776365724466;
        Thu, 16 Apr 2026 11:55:24 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6744b350sm5668181b3a.54.2026.04.16.11.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:55:23 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: jhs@mojatatu.com,
	vinicius.gomes@intel.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: horms@kernel.org,
	vladimir.oltean@nxp.com,
	xmei5@asu.edu,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v4 2/2] selftests/tc-testing: add taprio test for class dump after child delete
Date: Fri, 17 Apr 2026 02:55:02 +0800
Message-ID: <20260416185501.647884-4-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416185501.647884-2-bestswngs@gmail.com>
References: <20260416185501.647884-2-bestswngs@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,asu.edu,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279114-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[0.0.0.5:email,0.0.0.3:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,0.0.0.4:email,0.0.0.1:email,0.0.0.6:email,0.0.0.7:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,0.0.0.2:email]
X-Rspamd-Queue-Id: AA97F413E66
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


