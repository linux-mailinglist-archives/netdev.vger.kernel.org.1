Return-Path: <netdev+bounces-272241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMiFC4WaxWnP/wQAu9opvQ
	(envelope-from <netdev+bounces-272241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:43:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A9633B821
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 007C3303C597
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9B33A6B9D;
	Thu, 26 Mar 2026 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="WRkcjcwd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC843A6EE0
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557819; cv=none; b=USfkAihG9TXuKT3ucLoDpaTawv/Wj2+5BDFH/ehppj7EakeVm9QmFDy8X+h7/Skaprvzxf/T1GzfDV9ks46uocGQeb3t+40glWN3r3TKBhW0nW5NCEswVi8ApdzWQb1uS9cLXVa+C+bX8H5HDIj+IRIjCcRNIG9QVVfwjUpHs0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557819; c=relaxed/simple;
	bh=k5llrkAoaYVz9QcVBMzrD6cLEDinPJ64CoTlXaWUdlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoNIPXeeGSr8Vvs4Dj3gy6cmpPGz9UE4qs/hbNoF1IP8s3YcuLpDVVYOZEUM8ZMpeWDd7eof7rUPY6+QVd93h/trP67WRrtNNIm40msDv0GKWBprHAR0JtJsPw6CEyiUhGeeoIlu64l2q9m5KxZgTuOGFPPSd+jtI3RdYKtmbB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=WRkcjcwd; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-128ebee22caso1465952c88.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 13:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774557816; x=1775162616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jeSZwnN7cn2IDTYl8pp8z52gI34LJsNrtlhQqTDiMs=;
        b=WRkcjcwdRi66bRkxwa1fKVAxXWhc8iEaIdje/pBpRx6bOcd2vj6HGXyNKVuohwf1Cr
         +vsAJ2Tv7UByIbT7EjJEtXBoo9Zz57RfVjAPAE0KB3rR4EkmoQ66v9HyumzgcM/JWN5n
         sfC9kpDdsQ/4ShFSusOAFhtPLCIquVzjBoDKRB4Y4iCK2Dxh9s8d2MhamzQG5pZ8vX1v
         Lc4QHmm8lazhQnfKI82JeEceJj9QSeo509CFPPJG3mUZsEcSXIbnMNWl9Xj98uAQBvo2
         qb3wNUf00Eel5Vu7h/T2V4FDA2buf2GOanrrq1rZIlMf9aqIUEw0PWk+DJctMPY6ReFP
         jLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774557816; x=1775162616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/jeSZwnN7cn2IDTYl8pp8z52gI34LJsNrtlhQqTDiMs=;
        b=lK951rSgSXsq8uSuJzRoZj/CvU6wX3zwJeLA9rm4/gGOsU1ToMywO24FZdEudCGtxX
         m7vb41sC0HExKjCMwTrFMJxghwlUhnb9kMLBY9v3x+6UtH9O12OH/O/UBM3O5A3Ep+fv
         Qmvyaw5+keh7v8FYV07kLVFRpk5btPEnFpCbnc7zVqH6J8suiJhnT0xufTmuTKqvry0x
         TZuaCHSb66Py+jK1lD49ymDDxtclzVQ5LsEM08ajcSWW49lgFSodX/oQhhXEXa1A+FP1
         0l0U5NwKitIy/rgDEnbbsQ/jpmFaZEskhKiJB4DXuCC8DyCQWaYewivU+6LwyBjZiVTC
         yQog==
X-Gm-Message-State: AOJu0YwCl3o27mepOzrb7gNwWbS7nAwbSPyd+LmTWd+lkdJWtW4djjyQ
	4CIRfuBZ9pGO/cCXkz5LdsC0uDwk56F2+lT+rmUKmRF12sMvHLepqitrVMMYvfRTZA==
X-Gm-Gg: ATEYQzy2BCI8xQawfeN3/pTsCFBAU/RV/beqKE6dAeA+bMGtvZ5s1IB3d4YiG943uzt
	wr3TOa0ruxXJeB1jU6Izqwp/8WB/K4/ujD8Suy0qa+SFu3UHKkbuItOlIHx9so7dltJr4FWyI8Z
	M/+qDU/W09nnheu31UXc6BgzAmsfEj83wu3ArksvPH9s9Ol4YqZ2STERewg74YR4Kq4temvWYJK
	Gda7VXCVLklzBwfptDzCIT59thTqyCHZVX0SfOtR1HD57ZwC4NqOxnWrmynfWglsuTw0uZCYbMD
	cm4Lv76MQfb4Xmix+H8UX4IIwYnrDTgs3xanpKcabVvvZtM7PeCQCzUYeUqNFizVyD/7MuNEyQ6
	A79KlO7KTleG+kLMUoxZCZwig9U/8f4fzURd1qwQrtNWUNosFM271d1Q7ZMOo9v8AUBJzlsG42w
	BGm7FlATZzFgZ5e1j/3y6hn/hXhmehYInSp7EsTiBBHJAnFb67n31v9A==
X-Received: by 2002:a05:7022:2385:b0:128:cedb:33c6 with SMTP id a92af1059eb24-12ab2888270mr6788c88.16.1774557816393;
        Thu, 26 Mar 2026 13:43:36 -0700 (PDT)
Received: from p1.scai.dhcp.asu.edu (209-147-138-15.nat.asu.edu. [209.147.138.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aa78462fesm5479974c88.15.2026.03.26.13.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 13:43:36 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v3 2/2] selftests/tc-testing: add test for HFSC divide-by-zero in rtsc_min()
Date: Thu, 26 Mar 2026 13:43:10 -0700
Message-ID: <20260326204310.1549327-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326204310.1549327-1-xmei5@asu.edu>
References: <20260326204310.1549327-1-xmei5@asu.edu>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272241-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org,gmail.com,asu.edu];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[asu.edu:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,asu.edu:dkim,asu.edu:email,asu.edu:mid]
X-Rspamd-Queue-Id: B1A9633B821
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a regression test for the divide-by-zero in rtsc_min() triggered
when m2sm() converts a large m1 value (e.g. 32gbit) to a u64 scaled
slope reaching 2^32. rtsc_min() stores the difference of two such u64
values (sm1 - sm2) in a u32 variable `dsm`, truncating 2^32 to zero
and causing a divide-by-zero oops in the concave-curve intersection
path. The test configures an HFSC class with m1=32gbit d=1ms m2=0bit,
sends a packet to activate the class, waits for it to drain and go
idle, then sends another packet to trigger reactivation through
rtsc_min().

Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v3: append selftest in 2/2

 .../tc-testing/tc-tests/infra/qdiscs.json     | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 6a39640aa2a8..1e5efb2a31eb 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -1111,5 +1111,30 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY root handle 1:"
         ]
+    },
+    {
+        "id": "a3d7",
+        "name": "HFSC with large m1 - no divide-by-zero on class reactivation",
+        "category": [
+            "qdisc",
+            "hfsc"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc replace dev $DUMMY root handle 1: hfsc default 1",
+            "$TC class replace dev $DUMMY parent 1: classid 1:1 hfsc rt m1 32gbit d 1ms m2 0bit ls m1 32gbit d 1ms m2 0bit",
+            "ping -I$DUMMY -f -c1 -s64 -W1 10.10.10.1 || true",
+            "sleep 1"
+        ],
+        "cmdUnderTest": "ping -I$DUMMY -f -c1 -s64 -W1 10.10.10.1 || true",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc hfsc 1: root",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
     }
 ]
-- 
2.43.0


