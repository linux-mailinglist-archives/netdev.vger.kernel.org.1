Return-Path: <netdev+bounces-272199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHKSMEN7xWnw+QQAu9opvQ
	(envelope-from <netdev+bounces-272199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:30:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE5C33A19B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61AA4308AAED
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C2D401A02;
	Thu, 26 Mar 2026 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="dCGvOLEw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502313FADFF
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549082; cv=none; b=gFKj/9vRYN+dDs3sW2fGLjTHmeIVYswBMHfF51vtWcNk0p043pHjk1bD9Hth/5NTNF5of7XUm8eF/Uo0x/rbzaf5kDXgqqmXbC992mA2CRuXHer/AEP/fHBZjv0DraDuEgZY7Wm/ftSfCKYmbhWDswMPhZmopPV09wdvPvFMNQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549082; c=relaxed/simple;
	bh=GCYfgQJ+59s6QZFVgeGJlvrOyACTfG//g4qBJeIfHIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfRMAdPki42bOiI33SvITyJoxkBrNlv6ecNL6qi2Uln9Vr8RxXgUVbXqPqpm43PlHsxk0gUbqasxzJBJcL4E7A3n1MbVUcoBXX4t2AhCKiPpzXpjdWrmW/7xpldYB2m7DUOWzxYFU3nNdAvCn/3M+5CiZMcS1gToFzAvAGEkcAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=dCGvOLEw; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35c05d7e0e9so1168207a91.1
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 11:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774549076; x=1775153876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQeKesB8XmI+YcxNcyTca7ASuT0U5WU5ezBi6NR18GI=;
        b=dCGvOLEwFVLLFjCRaxq57DDU/TgH+4FRekEasLDpOop2CvtvFjTbJ/aTgAJj8b+CAb
         Ng6QulE7FCJ9MsnMiZ6GcQuyMAlQpyMDuwgxf5OzKh348HI6xMUvU5zTraCt0e3Hqb0D
         JqFKpLf0NW6VsbeTVPlVkMCRXYDVw1QzuGGgLrDgSEA6irHo9P9+2o/zVovKg9XYA0i8
         0Cd3aYIGlKY5CXEgQ64CltRY7xzf0tX/oE3Uv0tmx8a3qe30doJuMk1tnBYVx3z9Rez7
         GG1xTQhQPdn62UqX2XdxrUP8skjfTmkYxg3eTeYThgsxAG+/Zm16X8x25n73xCwNpjrO
         n0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549076; x=1775153876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JQeKesB8XmI+YcxNcyTca7ASuT0U5WU5ezBi6NR18GI=;
        b=r+joKPeaHrl6y9KDXczMhQKEIJlNlBAz4mCU9hGPMqLiKjKpoVGl6kavkzsSFfNqgQ
         9bDMLG2xv7cxuViyaCowGwzw+fdoLHNbbWGJkbR7ihMZhgaXvefAqtvekeMj7can7GtM
         zNFE6pZIjs/cSK8TcqDgLDqycf0FYgvklaLZP9D/9MwizE1ho8NGAyNhahPjoHADuer+
         HZ88cNMdQZImNT1HeI0lcOVUMHUL4M58ChZRlDwNo0aHyANb9riOtiMR0nslHSzbskcn
         AlHqL+VxKHjM2hCIVV8MENlJdVYdYYxSZcmmtHmlYGieKwAnv9/fL1OPG0BVPpSw00qQ
         oAoQ==
X-Gm-Message-State: AOJu0Ywd30MQop7q7RtYiT0M5tDYb2qiC1TpE5y0LacvGGdzccEMVmP+
	LRu3Yqb97yuVysdDZRBvCHnmE0Z4g30rf0EispsImmUWy9sYpBwcdv6qs/P13YypmQrrmKq6m2w
	8/J2J
X-Gm-Gg: ATEYQzyRt3qDpdvZEyH9VDWbVgBmljaD8rHMHSxUCBSZNyV5Onvh3zU6gSaxZOoypMq
	pRNOmxsp7yndGNEWPd/jI0z+Pjte8qoJO7+dlpO6hpWCxsLI3deAyK5XhNKlbefJ0QnLC+QVT09
	ONp/cet63oJUFvh7Bv9kdDZDSKZg6f4yqGtSBRPyPQqiJ+1PRVyGZvIqu3l0F+x89zy4/9kE7Dg
	jpFMYPIP8g82NkpnM4J8Kg16676FZOTdqXUm8YeS+FlyAs/H5ndYMiHIAVtBifnee5CzjjtumAb
	WQuT7zjGmDRsXsZDVMhu1C0p0x5BaUKbr3YSsuRJaL3WV6UlvySzRtl/hBHVH+Ub1ACOO/C2FG/
	sIkLdzYGc8XBLwg5R3JkiZLmVcysaj/6kL/8sk8ZzXMHnBQiXY/ozD7o0vetz6TUvHpH6f5c/z+
	V1QT7JsigveAUXTCEHUJps8oHgGgOxP3go
X-Received: by 2002:a17:903:1b23:b0:2b0:5903:140a with SMTP id d9443c01a7336-2b0b09a890fmr95428845ad.10.1774549075839;
        Thu, 26 Mar 2026 11:17:55 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8c4bd3sm38590245ad.63.2026.03.26.11.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:17:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Victor Nogueira <victor@mojatatu.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Shuah Khan <shuah@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 6/7] selftests/tc-testing: Add mirred test cases exercising loops
Date: Thu, 26 Mar 2026 11:01:05 -0700
Message-ID: <20260326181701.308275-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326181701.308275-1-stephen@networkplumber.org>
References: <20260326181701.308275-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272199-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,networkplumber-org.20230601.gappssmtp.com:dkim,networkplumber.org:email,networkplumber.org:mid,mojatatu.com:email]
X-Rspamd-Queue-Id: BDE5C33A19B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Victor Nogueira <victor@mojatatu.com>

Add mirred loop test cases to validate that those will be caught and other
test cases that were previously misinterpreted as loops by mirred.

This commit adds 12 test cases:

- Redirect multiport: dummy egress -> dev1 ingress -> dummy egress (Loop)
- Redirect singleport: dev1 ingress -> dev1 egress -> dev1 ingress (Loop)
- Redirect multiport: dev1 ingress -> dummy ingress -> dev1 egress (No Loop)
- Redirect multiport: dev1 ingress -> dummy ingress -> dev1 ingress (Loop)
- Redirect multiport: dev1 ingress -> dummy egress -> dev1 ingress (Loop)
- Redirect multiport: dummy egress -> dev1 ingress -> dummy egress, different prios (Loop)
- Redirect multiport: dev1 ingress -> dummy ingress -> dummy egress -> dev1 egress (No Loop)
- Redirect multiport: dev1 ingress -> dummy egress -> dev1 egress (No Loop)
- Redirect multiport: dev1 ingress -> dummy egress -> dummy ingress (No Loop)
- Redirect singleport: dev1 ingress -> dev1 ingress (Loop)
- Redirect singleport: dummy egress -> dummy ingress (No Loop)
- Redirect multiport: dev1 ingress -> dummy ingress -> dummy egress (No Loop)

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/actions/mirred.json   | 616 +++++++++++++++++-
 1 file changed, 615 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
index b056eb966871..d0cad6571691 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
@@ -1144,6 +1144,620 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY clsact"
         ]
+    },
+    {
+        "id": "531c",
+        "name": "Redirect multiport: dummy egress -> dev1 ingress -> dummy egress (Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY clsact",
+            "$TC filter add dev $DUMMY egress protocol ip prio 10 matchall action mirred ingress redirect dev $DEV1 index 1",
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred egress redirect dev $DUMMY index 2"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -I $DUMMY 10.10.10.1",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 3
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY clsact",
+            "$TC qdisc del dev $DEV1 clsact"
+        ]
+    },
+    {
+        "id": "b1d7",
+        "name": "Redirect singleport: dev1 ingress -> dev1 egress -> dev1 ingress (Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred egress redirect dev $DEV1 index 1"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 egress protocol ip prio 11 matchall action mirred ingress redirect dev $DEV1 index 2",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "egress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 3
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact"
+        ]
+    },
+    {
+        "id": "c66d",
+        "name": "Redirect multiport: dev1 ingress -> dummy ingress -> dev1 egress (No Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred ingress redirect dev $DUMMY index 1",
+            "$TC qdisc add dev $DUMMY clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY ingress protocol ip prio 11 matchall action mirred egress redirect dev $DEV1 index 2",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
+    },
+    {
+        "id": "aa99",
+        "name": "Redirect multiport: dev1 ingress -> dummy ingress -> dev1 ingress (Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred ingress redirect dev $DUMMY index 1",
+            "$TC qdisc add dev $DUMMY clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY ingress protocol ip prio 11 matchall action mirred ingress redirect dev $DEV1 index 2",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 2,
+                            "overlimits": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
+    },
+    {
+        "id": "37d7",
+        "name": "Redirect multiport: dev1 ingress -> dummy egress -> dev1 ingress (Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred egress redirect dev $DUMMY index 1",
+            "$TC qdisc add dev $DUMMY clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY egress protocol ip prio 11 matchall action mirred ingress redirect dev $DEV1 index 2",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "egress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 3
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
+    },
+    {
+        "id": "6d02",
+        "name": "Redirect multiport: dummy egress -> dev1 ingress -> dummy egress, different prios (Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY clsact",
+            "$TC filter add dev $DUMMY egress protocol ip prio 10 matchall action mirred ingress redirect dev $DEV1 index 1",
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 11 matchall action mirred egress redirect dev $DUMMY index 2"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -I $DUMMY 10.10.10.1",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 3
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY clsact",
+            "$TC qdisc del dev $DEV1 clsact"
+        ]
+    },
+    {
+        "id": "8115",
+        "name": "Redirect multiport: dev1 ingress -> dummy ingress -> dummy egress -> dev1 egress (No Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred ingress redirect dev $DUMMY index 1",
+            "$TC qdisc add dev $DUMMY clsact",
+            "$TC filter add dev $DUMMY ingress protocol ip prio 11 matchall action mirred egress redirect dev $DUMMY index 2"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY egress protocol ip prio 12 matchall action mirred egress redirect dev $DEV1 index 3",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
+    },
+    {
+        "id": "9eb3",
+        "name": "Redirect multiport: dev1 ingress -> dummy egress -> dev1 egress (No Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred egress redirect dev $DUMMY index 1",
+            "$TC qdisc add dev $DUMMY clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY egress protocol ip prio 11 matchall action mirred egress redirect dev $DEV1 index 2",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "egress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
+    },
+    {
+        "id": "d837",
+        "name": "Redirect multiport: dev1 ingress -> dummy egress -> dummy ingress (No Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred egress redirect dev $DUMMY index 1",
+            "$TC qdisc add dev $DUMMY clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY egress protocol ip prio 11 matchall action mirred ingress redirect dev $DUMMY index 2",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "egress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
+    },
+    {
+        "id": "2071",
+        "name": "Redirect singleport: dev1 ingress -> dev1 ingress (Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred ingress redirect dev $DEV1 index 1",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1,
+                            "overlimits": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact"
+        ]
+    },
+    {
+        "id": "0101",
+        "name": "Redirect singleport: dummy egress -> dummy ingress (No Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY clsact",
+            "$TC filter add dev $DUMMY egress protocol ip prio 11 matchall action mirred ingress redirect dev $DUMMY index 1"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -I $DUMMY 10.10.10.1",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
+    },
+    {
+        "id": "cf97",
+        "name": "Redirect multiport: dev1 ingress -> dummy ingress -> dummy egress (No Loop)",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin",
+                "scapyPlugin"
+            ]
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 ingress protocol ip prio 10 matchall action mirred ingress redirect dev $DUMMY index 1",
+            "$TC qdisc add dev $DUMMY clsact"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY ingress protocol ip prio 11 matchall action mirred egress redirect dev $DUMMY index 2",
+        "scapy": [
+            {
+                "iface": "$DEV0",
+                "count": 1,
+                "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+            }
+        ],
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "ingress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact",
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
     }
-
 ]
-- 
2.53.0


