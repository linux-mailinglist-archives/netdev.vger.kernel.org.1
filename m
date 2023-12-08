Return-Path: <netdev+bounces-55431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8DA80AD51
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00E11C20A29
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2556C54FBC;
	Fri,  8 Dec 2023 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zmf1imP0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F47F1732
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 11:45:33 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5cece20f006so23716997b3.3
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 11:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702064732; x=1702669532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eX24kVgo4RQNwTPLtooK8WJEzqUA20ppamV/syct6Pw=;
        b=Zmf1imP0Qvhtl3Z6obaVziCpfXfsf2BIlMBDR2pyb9Zsy0Y/4eI226g6aqScWxBOLV
         4Z8dPBJFVmvcS5gdK3CeL81Qe9494agrY3C1crCq5EbqWIxWO8gPl/+k6L7BtMXFCvSO
         BEf0/zUYnZp8KYMIhXvTsmZIdCbwyanqqfvwKbMwhth1h8reM+jssYGiIVUNXawaeQiK
         iIgyilueLo0o/QXOmkUoQJSZnt1mBmZzo8OBRaMj8Tx7u2WkBM9iQZAOIGIyE/Vf2GjE
         0QGM0gqKFmAPg39QvB0zxtArst6PDnWw4fhaiWd82EOQj9/GmRGxID3bV8gm4UTzcxej
         MxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702064732; x=1702669532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eX24kVgo4RQNwTPLtooK8WJEzqUA20ppamV/syct6Pw=;
        b=XWEBut1Njd/12KYqo+WVpJGV1kxgpiP3MuwULPaesOU5+zzmmPjzq3uYIeO8Q1Nz/1
         rHKuLUbcoOjy4LN+NHR9QZOLCcq7tzDy1k5UmuaiZMzinHcFO/WeDLumZXo3aCSA/Tn5
         /jWN1y1Uzz/83Yo2TPF2jBkzFSi6iP4SECMSA3/Y7ksoY3yoH8Qxjrn0SmKJy5U5LT3l
         H31dvxHyK1sQZWHMqgOt1E4tIuGCG3EjCBIfBNsBd3mbJSuqA4oirlS60KB2p0Rj9piJ
         UxbAfk7+Sq68DiSr+x9eZiaoHtOpPUk+CQ3IdJL0sp7ckLdD6MKxtqOuaIaSL9e4RvRs
         akaA==
X-Gm-Message-State: AOJu0YwWX/dSdX2J9yxsvOzFe4HJ2lZTJdvJiBAznuKytaKR0PRjnR7/
	rsjOyhUvO++XtpRJeGK5WsuI+Usucio=
X-Google-Smtp-Source: AGHT+IF+pQ3xX8Nc10f7dQpTno39Jvtd+0V59NuwH9Ie6qWyp6E3Uqz+5e2R4Q7p7Z8fVnc0CQO+Cg==
X-Received: by 2002:a81:7708:0:b0:5d8:67b8:6d13 with SMTP id s8-20020a817708000000b005d867b86d13mr401460ywc.76.1702064731998;
        Fri, 08 Dec 2023 11:45:31 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:65fe:fe26:c15:a05c])
        by smtp.gmail.com with ESMTPSA id w5-20020a0dd405000000b005d23b8a7e1bsm887414ywd.91.2023.12.08.11.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 11:45:31 -0800 (PST)
From: thinker.li@gmail.com
To: netdev@vger.kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	edumazet@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH net-next v2 2/2] selftests: fib_tests: Add tests for toggling between w/ and w/o expires.
Date: Fri,  8 Dec 2023 11:45:23 -0800
Message-Id: <20231208194523.312416-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208194523.312416-1-thinker.li@gmail.com>
References: <20231208194523.312416-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Make sure that toggling routes between w/ expires and w/o expires works
properly with GC list.

When a route with expires is replaced by a permanent route, the entry
should be removed from the gc list. When a permanent routes is replaced by
a temporary route, the new entry should be added to the gc list. The new
tests check if these basic operators work properly.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/testing/selftests/net/fib_tests.sh | 69 +++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 66d0db7a2614..a8b4628fd7d2 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -806,10 +806,75 @@ fib6_gc_test()
 	    ret=0
 	fi
 
-	set +e
-
 	log_test $ret 0 "ipv6 route garbage collection"
 
+	# Delete permanent routes
+	for i in $(seq 1 5000); do
+	    $IP -6 route del 2001:30::$i \
+		via 2001:10::2 dev dummy_10
+	done
+
+	# Permanent routes
+	for i in $(seq 1 100); do
+	    # Expire route after $EXPIRE seconds
+	    $IP -6 route add 2001:20::$i \
+		via 2001:10::2 dev dummy_10
+	done
+	# Replace with temporary routes
+	for i in $(seq 1 100); do
+	    # Expire route after $EXPIRE seconds
+	    $IP -6 route replace 2001:20::$i \
+		via 2001:10::2 dev dummy_10 expires $EXPIRE
+	done
+	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
+	if [ $N_EXP_SLEEP -ne 100 ]; then
+	    echo "FAIL: expected 100 routes with expires, got $N_EXP_SLEEP"
+	fi
+	sleep $(($EXPIRE * 2 + 1))
+	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
+	if [ $N_EXP_SLEEP -ne 0 ]; then
+	    echo "FAIL: expected 0 routes with expires," \
+		 "got $N_EXP_SLEEP"
+	    ret=1
+	else
+	    ret=0
+	fi
+
+	log_test $ret 0 "ipv6 route garbage collection (replace with expires)"
+
+	PERM_BASE=$($IP -6 route list |grep -v expires|wc -l)
+	# Temporary routes
+	for i in $(seq 1 100); do
+	    # Expire route after $EXPIRE seconds
+	    $IP -6 route add 2001:20::$i \
+		via 2001:10::2 dev dummy_10 expires $EXPIRE
+	done
+	# Replace with permanent routes
+	for i in $(seq 1 100); do
+	    # Expire route after $EXPIRE seconds
+	    $IP -6 route replace 2001:20::$i \
+		via 2001:10::2 dev dummy_10
+	done
+	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
+	if [ $N_EXP_SLEEP -ne 0 ]; then
+	    echo "FAIL: expected 0 routes with expires," \
+		 "got $N_EXP_SLEEP"
+	fi
+	sleep $(($EXPIRE * 2 + 1))
+	N_EXP_PERM=$($IP -6 route list |grep -v expires|wc -l)
+	N_EXP_PERM=$(($N_EXP_PERM - $PERM_BASE))
+	if [ $N_EXP_PERM -ne 100 ]; then
+	    echo "FAIL: expected 100 permanent routes," \
+		 "got $N_EXP_PERM"
+	    ret=1
+	else
+	    ret=0
+	fi
+
+	log_test $ret 0 "ipv6 route garbage collection (replace with permanent)"
+
+	set +e
+
 	cleanup &> /dev/null
 }
 
-- 
2.34.1


