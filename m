Return-Path: <netdev+bounces-57078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B0B8120D5
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3D71F219B9
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 21:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FEA7FBA1;
	Wed, 13 Dec 2023 21:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqCXTAVS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD8DCF
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 13:37:56 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d9e993d94dso4632306a34.0
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 13:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702503475; x=1703108275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3x1URCksmhBkrK5U60qDbBJnVveS2ETEubCGJBlhtQ=;
        b=OqCXTAVSaX5pFrTriu9Q5j0jZgswjIxrsiuNJjGdBf0FA6GL0piYFqmJFhOkw2KPo1
         Xhib2meA89HWsVIX7TuTc4SoF1DAB0K6eEXsOIUvmAItGNYZ/pb8S1UjwHf+yesRHNhi
         xgPzrjIBX5FVkXrqYECQt/+uFCuCjk7lTqcTYjh77mSVnagebR1Fq4t3bgvv5ISRg09V
         dZ+ypooCFhaK58sC2Rzc9yHEY9sPWjUWGmjg8BhWT2tZBkgJsNF4FIbFYHgg3VG62kgl
         tJaaV1kgzeEDaXd7fJEp4+keQhu7YY4/vJhbHymF3xlyD6utWAjADcDEdlLozq7htpne
         2xDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702503475; x=1703108275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3x1URCksmhBkrK5U60qDbBJnVveS2ETEubCGJBlhtQ=;
        b=BmDQBljQOZpYteXAjocSt67eExFFCCXk3fWALWikIvLeZ/yFn+sTm0Y6cyabnSHoiS
         7RxKHFyxlta7x9yDORYrMGzKiQk4SuamAkvTNJjUUlGAvLBLpb7HWNeeMOfJsNfKf/Wm
         vSWRacje8tsUGQjZtp1HZJpF6H4R4ACRJxZcINx1YuIre3AdEHBIOz44FhIpngOBE+QL
         RXYdyGj0H+lQkzKggVZ42lK8nCjsSLsk0jJY3DyYaIwJNwOV7NgjIFYevSdz6dOXLlKJ
         E5CopTplxynmID+LXthumFbVhZ+L+vf82pD0b+6xUz6F7u8ggL8em630RIe9nISsXI35
         Jkqg==
X-Gm-Message-State: AOJu0YzyOxptIF7Y2Z2IXzB9ynX4Bjb5MGI/9Kp9ZyDG0vMbkei6TvRT
	al1VDCNRSklXvPpeFnyV3ZkxDNVWDYr/GA==
X-Google-Smtp-Source: AGHT+IEYx9lBY2N8ZfXy17XuALIZ5Ul4OcFXwXSPjg7MKUew1FbpkLJrerX1pMDPdGuWZdPNGcTJxw==
X-Received: by 2002:a05:6830:1d7c:b0:6d9:d59d:6559 with SMTP id l28-20020a0568301d7c00b006d9d59d6559mr7651712oti.7.1702503475477;
        Wed, 13 Dec 2023 13:37:55 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:180e:8c9:1628:87e1])
        by smtp.gmail.com with ESMTPSA id t190-20020a0deac7000000b005e3175fc655sm496799ywe.55.2023.12.13.13.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 13:37:55 -0800 (PST)
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
	Kui-Feng Lee <thinker.li@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next v3 2/2] selftests: fib_tests: Add tests for toggling between w/ and w/o expires.
Date: Wed, 13 Dec 2023 13:37:35 -0800
Message-Id: <20231213213735.434249-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213213735.434249-1-thinker.li@gmail.com>
References: <20231213213735.434249-1-thinker.li@gmail.com>
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
Cc: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/fib_tests.sh | 82 +++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 66d0db7a2614..337d0febd796 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -785,6 +785,8 @@ fib6_gc_test()
 	    ret=0
 	fi
 
+	log_test $ret 0 "ipv6 route garbage collection"
+
 	# Permanent routes
 	for i in $(seq 1 5000); do
 	    $IP -6 route add 2001:30::$i \
@@ -806,9 +808,85 @@ fib6_gc_test()
 	    ret=0
 	fi
 
-	set +e
+	log_test $ret 0 "ipv6 route garbage collection (with permanent routes)"
 
-	log_test $ret 0 "ipv6 route garbage collection"
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
+	    ret=1
+	else
+	    ret=0
+	fi
+
+	if [ $ret -eq 0 ]; then
+	    sleep $(($EXPIRE * 2 + 1))
+	    N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
+	    if [ $N_EXP_SLEEP -ne 0 ]; then
+		echo "FAIL: expected 0 routes with expires," \
+		     "got $N_EXP_SLEEP"
+		ret=1
+	    else
+		ret=0
+	    fi
+	fi
+
+	if [ $ret -eq 0 ]; then
+	    PERM_BASE=$($IP -6 route list |grep -v expires|wc -l)
+	    # Temporary routes
+	    for i in $(seq 1 100); do
+		# Expire route after $EXPIRE seconds
+		$IP -6 route add 2001:20::$i \
+		    via 2001:10::2 dev dummy_10 expires $EXPIRE
+	    done
+	    # Replace with permanent routes
+	    for i in $(seq 1 100); do
+		# Expire route after $EXPIRE seconds
+		$IP -6 route replace 2001:20::$i \
+		    via 2001:10::2 dev dummy_10
+	    done
+	    N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
+	    if [ $N_EXP_SLEEP -ne 0 ]; then
+		echo "FAIL: expected 0 routes with expires," \
+		 "got $N_EXP_SLEEP"
+		ret=1
+	    else
+		ret=0
+	    fi
+	fi
+	if [ $ret -eq 0 ]; then
+	    sleep $(($EXPIRE * 2 + 1))
+	    N_EXP_PERM=$($IP -6 route list |grep -v expires|wc -l)
+	    N_EXP_PERM=$(($N_EXP_PERM - $PERM_BASE))
+	    if [ $N_EXP_PERM -ne 100 ]; then
+		echo "FAIL: expected 100 permanent routes," \
+		     "got $N_EXP_PERM"
+		ret=1
+	    else
+		ret=0
+	    fi
+	fi
+
+	log_test $ret 0 "ipv6 route garbage collection (replace with permanent)"
+
+	set +e
 
 	cleanup &> /dev/null
 }
-- 
2.34.1


