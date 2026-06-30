Return-Path: <netdev+bounces-303333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HaHrK2wNRGrqngoAu9opvQ
	(envelope-from <netdev+bounces-303333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:39:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FBC6E73BA
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:39:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Iccfd43a;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303333-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303333-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4F31305F1AE
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334A93E0C42;
	Tue, 30 Jun 2026 18:37:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EC43DE430
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 18:37:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844670; cv=none; b=oU3yU7UArh/F8Efz4NyoECWhreucE9y40K4TdexUWbrvWaVKQH+z9eUGR1TwUZLcigBYNf1dclPBNznttNyDHWL9Ff7uvHuWyE8xEaIaqFM8Dv0PZOI1wqHK6OxlkIE0t2/dFud8NqNj09uLue9cyVSoQNs5qQgPUgrY/t6UYQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844670; c=relaxed/simple;
	bh=YEzjTaQBibg82naQrx8wYRELkM2GgBKDfMPzgkCv/68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5fQJ9REvhkeFl3DcDA21Oi//s6c9Xei1NbKsQ6lxXu3cTTmkjwXQny/mXabSiFOZb0g2UD4KR2UE3DrksAVYF1cZ4wlOkIMelyz7nrH0JZq5Www7z7Kqjor9bbsZvDvzVCLmebbkvqhWDF3RR57IE5XgpZ2m9OT6d2c343CqMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iccfd43a; arc=none smtp.client-ip=74.125.82.177
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30edbb0dc5fso3715176eec.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782844668; x=1783449468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ES4kCJ/i10bD1lFE1QxrqtkTCTeoqYvCpnKF0vygSpE=;
        b=Iccfd43a+CCH17kOjZG1phFkTveNCf/fMBYoula3s1GA245dsNSm9aeRgfQ+UiHTVe
         Em6aQINfEKzgk2ZG3e6UPIEIYQ2sPjc0GxWZZ+XRPsCN6i2Ttg/5ZeXcyzqKg8F6us3D
         8MPjbAYAGHkBaf5m8AiqhdwzyMIeEaZp07FVJzUgcnugdKrZKDJyj42n3lgml8UGaeU0
         2TBT52Ng1u2iH/du6MLYaRQJu4vhmVevGtj0huBQXP2sOaNya+7Ddb+CPFsOq2nW9QN1
         M/mgKuLWDQ2txVCPtio6bIGisFZRu6iZ6F8fPq5MGv38iMe6Rm0bU+8Sj2uZ4lUAqgMA
         ySaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844668; x=1783449468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ES4kCJ/i10bD1lFE1QxrqtkTCTeoqYvCpnKF0vygSpE=;
        b=NF18yQg7jkT9Nmf9gNgvm5sj+yi1ydJRsnBA9F9qqefDIYPT77ybL3JLfZ64hS3v3u
         Z3I5IAW9hc1SjHTR6NQO6Z1l46+iKn+QLh1T2fHbsAqvSmkc68OivpCp7picUfO4oetz
         uvdROyrpK+ce24cIVEACwcz+0HL5PqAB9cS6ExKaTzsoKfHLGE0Qd3Jto+5rA0AeY/gX
         ZtJAvgWz49Qn0gYFVtNeFSzGT2BbqoYJMPQdkZlZoiZilxRhdhDRQpYTwohBgohfNbUw
         9pEKeUh5hIVNb3lW4mQO1/3inL6hqtLDEX3GxrW+XjM5MhP0iGrNCX2DpIm4JigXs6jP
         6EoQ==
X-Gm-Message-State: AOJu0Yy6O+CQCzB4bAZ9VNLQKA8YlyKLu0z4DtErrrdUAFg21o3PigLq
	9zzjSIiqgfusnlZ4+gKVFXW61W8nACppnuNlmgiQhl0qZ4qJKy9cvuaWBflLewcE
X-Gm-Gg: AfdE7cmiMr1gOcaDNURVPTJ9HkilgqIrIKxREUldQWluWFMgk90a2T2RhFIpDnC1ciI
	SqSX7tAog0mYFUPsweRA+JQXb1UnHj2XsjzrAnFLqg+U7CMotMcXfxeJeeFD/gEC2Sia8enixqI
	DqvMT/cn9l9XZsMlwadsxUXcMig8utYk1ldlvTVVqe/L/VCl972zNoxQ4UJTHYDfl9HmbHUMR/p
	OVVNvJkDmCV3NFCx5RujUroSLmRaCifUYZUpPBBS4brVwwk56hGNhy8afHjn2r4CuQ8RMlE5pLD
	JgNsFT0emSOcuQ9WCWHT5iXD+Em8pNPlOIcZiIz/T+almFnAfMDXsM80jR7WOnRkn3qPWA9nrUk
	PuMAH7l/CkpR0aNREJCnvd2yGqHYWzToxIdz09UmPY4jrrUZVXcLv6bhDAiaFGCkVaBmOE8YHbR
	gG7vYzdhzsqZgiVq6bn6mkgEcW5yI=
X-Received: by 2002:a05:7300:509:b0:30c:38ed:46a5 with SMTP id 5a478bee46e88-30ee147e97emr3855167eec.30.1782844668077;
        Tue, 30 Jun 2026 11:37:48 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:b5a1:965b:86fd:756])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee3205993sm10888191eec.24.2026.06.30.11.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:37:47 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	jhs@mojatatu.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH net-next v3 2/2] selftests: tc-testing: add fq_pie per-flow class stats test
Date: Wed,  1 Jul 2026 00:07:02 +0530
Message-Id: <20260630183702.170798-3-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630183702.170798-1-hemendranaik@gmail.com>
References: <20260630183702.170798-1-hemendranaik@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,vger.kernel.org,gmail.com,nitk.edu.in];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-303333-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jiri@resnulli.us,m:jhs@mojatatu.com,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:vishy0777@gmail.com,m:tahiliani@nitk.edu.in,m:hemendranaik@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[hemendranaik@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hemendranaik@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nitk.edu.in:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55FBC6E73BA

Add a tc-testing entry (id: 83c0) to verify the fq_pie class ops
wired up in the previous patch do not crash and integrate cleanly
with the tc class show path.

The test creates an fq_pie root qdisc on a dummy interface and runs
'tc -s class show'.

Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
---

Changelog:

v3: 
 - No changes since v2.
 - Resending as the previous submission was deferred when the net-next tree closed during review.
 - Corresponding iproute2 patch updated in response to review comments; no changes required for this patch.

v2: 
 - No changes since v1. (https://lore.kernel.org/netdev/20260614125000.6058-3-hemendranaik@gmail.com/)

v1: 
 - https://lore.kernel.org/netdev/20260531125314.22492-3-hemendranaik@gmail.com/
---
 .../tc-testing/tc-tests/qdiscs/fq_pie.json    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json
index 229fe1bf4a90..88139f429430 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fq_pie.json
@@ -40,5 +40,27 @@
         "matchPattern": "qdisc fq_pie 1: root refcnt [0-9]+ limit 1p",
         "matchCount": "1",
         "teardown": ["$TC qdisc del dev $DEV1 handle 1: root"]
+    },
+    {
+        "id": "83c0",
+        "name": "FQ-PIE class stats accessible via tc class show",
+        "category": [
+            "qdisc",
+            "fq_pie"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY handle 1: root fq_pie"
+        ],
+        "cmdUnderTest": "$TC -s class show dev $DUMMY",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s class show dev $DUMMY",
+        "matchPattern": "class fq_pie",
+        "matchCount": "0",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
     }
 ]
-- 
2.34.1


