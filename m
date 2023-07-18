Return-Path: <netdev+bounces-18694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1807584E0
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 20:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24B651C204F0
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8369E168B9;
	Tue, 18 Jul 2023 18:33:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77236168A7
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 18:33:59 +0000 (UTC)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEE09D
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:33:58 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-577637de4beso61593367b3.0
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689705237; x=1692297237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kjW4qFXphPcJ9bYD5PankezvrfSw22Y9GSmpsJ/4tY=;
        b=fs7ldUBuyMlqbBny8PQKd8/lbSxYDOZhen1QzAf0NZkbqW3rd998rBNyBdJcJ1iydN
         z/wUbPNw0puUBBajjEnkN7cCecboGRAlPTQDUWCUWYSiU3aKQF5c6a8ofjt2vDR4nmZg
         jlIhomHHnnZHoAbP2TwM265HokYQJYbakNuHgR6CDoainC+aMJUsgEbrEDiwrs87HI5T
         kKtAa8njCjBmzYE2/P/XlbEBD30+YmoOdzNvfavfoPDkxTPvl5HYRUhpML9IqBVyeuOW
         bKog7bQlyAwZR9F3VRWyhohIM3Dhvsr3RMDv6rAV3AIlTSMfGyFCPf3FVFtrMrTSgxDj
         05JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689705237; x=1692297237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kjW4qFXphPcJ9bYD5PankezvrfSw22Y9GSmpsJ/4tY=;
        b=gf03jZu+GyazsMcGOsJ678u/4xVa+YhpuhOO65/8GbyiYywW/ZCMTKYyJdXMufxFOX
         VkcevUZC2yhFJ29SQTd3c6T2YFS2rc+MvxGDlVQuFuk7ikgRXZZxp3k7tS1bhACZKL1C
         lU/AtlIYvi6pxjvcfZpgXUvRhmeDvHeKuxXi9VaKdL/07G/XuIvS57zuX5HnPDRRfDAF
         9cE/23KvBSvDzZct/hD8gsKUPckpBSAuE3DFgRNsswlIbjUKSDfAkU5rG5nemKDVYXdd
         nyuHX2Bh8/0n+zJFYdX+RFkFyJpEpAycDO52cpM0lR4zN7kbLoBgaH53nDqptVaKPNbB
         4tgg==
X-Gm-Message-State: ABy/qLbMulwQEKTLXmjbUTU9sd2yQFRoHU8yXDNbzxqd473eWk1sQvSc
	sgC2stLfqGlI88G50l28ma0=
X-Google-Smtp-Source: APBJJlE3RNrLKnltKu/ffMfg9VWsUjMyurcLXx8GOmwvnRVLWj/C6s7yi1yQVoImomWwPQtRRDLPRA==
X-Received: by 2002:a0d:cc87:0:b0:56d:28b:8042 with SMTP id o129-20020a0dcc87000000b0056d028b8042mr474993ywd.40.1689705237611;
        Tue, 18 Jul 2023 11:33:57 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:770d:e789:cf56:fb43])
        by smtp.gmail.com with ESMTPSA id r66-20020a0dcf45000000b0057069c60799sm607227ywd.53.2023.07.18.11.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:33:57 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	yhs@meta.com
Cc: Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH net-next v3 2/2] selftests: fib_tests: Add a test case for IPv6 garbage collection
Date: Tue, 18 Jul 2023 11:33:51 -0700
Message-Id: <20230718183351.297506-3-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718183351.297506-1-kuifeng@meta.com>
References: <20230718183351.297506-1-kuifeng@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add 10 IPv6 routes with expiration time.  Wait for a few seconds
to make sure they are removed correctly.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 tools/testing/selftests/net/fib_tests.sh | 46 +++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 35d89dfa6f11..87c871cae8c3 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -9,7 +9,7 @@ ret=0
 ksft_skip=4
 
 # all tests in this script. Can be overridden with -t option
-TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh"
+TESTS="unregister down carrier nexthop suppress ipv6_notify ipv4_notify ipv6_rt ipv4_rt ipv6_addr_metric ipv4_addr_metric ipv6_route_metrics ipv4_route_metrics ipv4_route_v6_gw rp_filter ipv4_del_addr ipv4_mangle ipv6_mangle ipv4_bcast_neigh fib6_gc_test"
 
 VERBOSE=0
 PAUSE_ON_FAIL=no
@@ -747,6 +747,49 @@ fib_notify_test()
 	cleanup &> /dev/null
 }
 
+fib6_gc_test()
+{
+	setup
+
+	echo
+	echo "Fib6 garbage collection test"
+	set -e
+
+	# Check expiration of routes every 3 seconds (GC)
+	$NS_EXEC sysctl -wq net.ipv6.route.gc_interval=3
+
+	$IP link add dummy_10 type dummy
+	$IP link set dev dummy_10 up
+	$IP -6 address add 2001:10::1/64 dev dummy_10
+
+	for i in 0 1 2 3 4 5 6 7 8 9; do
+	    # Expire route after 2 seconds
+	    $IP -6 route add 2001:20::1$i \
+		via 2001:10::2 dev dummy_10 expires 2
+	done
+	N_EXP=$($IP -6 route list |grep expires|wc -l)
+	if [ $N_EXP -ne 10 ]; then
+		echo "FAIL: expected 10 routes with expires, got $N_EXP"
+		ret=1
+	else
+	    sleep 4
+	    N_EXP_s20=$($IP -6 route list |grep expires|wc -l)
+
+	    if [ $N_EXP_s20 -ne 0 ]; then
+		echo "FAIL: expected 0 routes with expires, got $N_EXP_s20"
+		ret=1
+	    else
+		ret=0
+	    fi
+	fi
+
+	set +e
+
+	log_test $ret 0 "ipv6 route garbage collection"
+
+	cleanup &> /dev/null
+}
+
 fib_suppress_test()
 {
 	echo
@@ -2217,6 +2260,7 @@ do
 	ipv4_mangle)			ipv4_mangle_test;;
 	ipv6_mangle)			ipv6_mangle_test;;
 	ipv4_bcast_neigh)		ipv4_bcast_neigh_test;;
+	fib6_gc_test|ipv6_gc)		fib6_gc_test;;
 
 	help) echo "Test names: $TESTS"; exit 0;;
 	esac
-- 
2.34.1


