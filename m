Return-Path: <netdev+bounces-291314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHwIG25AFGo3LQcAu9opvQ
	(envelope-from <netdev+bounces-291314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:28:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D20465CA7CC
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B17E73030D36
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A382382363;
	Mon, 25 May 2026 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="rxiM9Zh6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA9B382F00
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711985; cv=none; b=OY3M8YWZ9aBiT0C60LF2d8aUJLtLqTSHoHQ9P8tktBXWwcBivY7RHsy7hBvI0ajKUL+uERi7Yy4/xdz21smynD9UUyob/GDcwmw2aQsuKkMdWujW2ZE+E2g5IQaOfRK/fxYjxKkDklPAISoPHQsMws+OPo5QLVpXW7PC6g2eC6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711985; c=relaxed/simple;
	bh=ZgtB7LAHAxj9FHw0TGkmkNURDxz60V/+azm97TnXA6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hpcGq56+vu2XLjABfG1zkGREVkXkgllr4pd8b1T7QIEVbWwvDwAm0dpwqL5FkgyteLdHV8zdf4S7TKJu6hCXNs0aPN1Z1DJHPA0UDYFVf4VUkJK2MTxCpkcVncx75Gp9aFlojCb7hp8di2DZqyhAdMFyd18DS4SoepqqGd3ZsGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=rxiM9Zh6; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e63771eb0so96057821cf.3
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 05:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779711982; x=1780316782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYr/crUDdg9thVsoWkyUkY6ZBG96D+uVm5Zef+dcktg=;
        b=rxiM9Zh6A6404xB4gq9LcA+ZrW4WjI8n4xlNbCmRqoBLi0GfVsCfch+qoNl5LKiLU6
         m5rCo2ktC7VMsTBvkPn6AGJkfMswrU5A3CExoBmxu0KS37v/47NdSziLMSrAxaH7/ala
         u75ynhTEfiL6E+nJGlW2v+j0nvQxSLwm1A34ch6iDBdDUEU+enIEGOmWOv87Ke/uK7wQ
         fzxt4wA/LozhQctcZquEKBFvZO805WFDBJmnB81k2rxc3z4X23nDUnx90kf9j0iVRnoA
         uTNPct7W+4fp9IcfaMqBJVdGH4l9ccImtI7BKslWLixbgV+81G3KEPpV0efiIm/Jw/NP
         DZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779711982; x=1780316782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YYr/crUDdg9thVsoWkyUkY6ZBG96D+uVm5Zef+dcktg=;
        b=X5RX7cMQ79KCZk2L5ZT0apanXFBLm18WR2940f+kR00Ru3DTcuEPWOzdyWTsOndaai
         zimPBvdXKoTsu9faATPT7LYuF9sBxSV7wyh3ZDX+e+xS1wTVGvwPhTVGmmWUucJZhoKO
         Tm/R0e6dOfkXA9lzXiiKyEG767r64dwEpaJuUmQ8BF4ov7VNJB5dcgEiH/cOp0IFVirr
         OQYyPWUOGR7seGQ6/jiBkMEmkY+XTtqpqmj3FjWWzsqd8VvnNuR5O4mPwUepYClgLKcE
         VvPMTod2mgEsivyOs5PxWsR4Ka8Y8V21iZ0+UeC6tvukmICaemL+vsdlM10tn0EeufO2
         HzDg==
X-Gm-Message-State: AOJu0YyNANl+zAKYcjV6rOyjmdsX0DPGz6nUt/U8xBwiGbY16khjfJ0t
	au50BAwfz/o1O/1x484J/HJBlKw/wGnVwvnrX7IA954tipNZqpVRmj8fkCg9zvybX+lGZSEhDZ0
	KIATwnw==
X-Gm-Gg: Acq92OElMl4pBed+3Ce+rwoZzXN8t86TR8ZrKsCIv9RWZfrxtBISwwnpS+QeOHUB6vB
	uhlZFNpJs9KcN0YUMOZXPDVnljPYIJxEZwfIC3vV9WTUGIPjZeXUzC4VMnRkgEBMv7jlKxFvv7Q
	WIn3ieSot1RQYLd3s89WBixhnN2OcjMTeoNVXoGS4QNQNjqal1pXWfAOVeSG2oZ47lRLDUEhnEy
	KIKC2vw2pdx1Mun20K1/QK7oi85eGzb2ujVhDEQnQSwzL3dhquIthLuPNV39HxDsEd+SRUHFuXq
	4mTG+PiaS4tyfvlaZebYy9MDOAcW87+oSE8fxfUGfABtpIgJ//1p0/hZoiWqmj9U6wUNgtVybpr
	/dIKwhzETweSi+NafLHNY9Glol21o2cQBCyHNIxcw9ljhIN7+xx00KN7vyRgR43EydHlTWrzsBI
	aohXVCRGzA9zFr9kvJ3Fy9A0cTiO8=
X-Received: by 2002:a05:622a:5a0f:b0:516:ea66:707d with SMTP id d75a77b69052e-516ea667577mr98963841cf.38.1779711982078;
        Mon, 25 May 2026 05:26:22 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8cba4easm91351761cf.24.2026.05.25.05.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:26:21 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	will@willsroot.io,
	hxzene@gmail.com,
	victor@mojatatu.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v6 8/9] selftests/tc-testing: Add mirred test cases exercising loops
Date: Mon, 25 May 2026 08:25:55 -0400
Message-Id: <20260525122556.973584-9-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525122556.973584-1-jhs@mojatatu.com>
References: <20260525122556.973584-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291314-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,willsroot.io,gmail.com,mojatatu.com];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mojatatu.com:mid,mojatatu.com:email,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D20465CA7CC
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
2.54.0


