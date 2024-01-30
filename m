Return-Path: <netdev+bounces-67262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A80FB842840
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 16:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B8C3B20A5B
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 15:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB6B82D74;
	Tue, 30 Jan 2024 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIVLnUif"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFB281AB6
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629410; cv=none; b=MpyKXRkAT7VGado71QhHurNXV4F/OLXWYzsddQJ0Bj/tjKORJLVKtV7k6/UfWvbFrMQFweYWEX4VnjZhATuqd43qdHPBemY/K6arocK7FaNSujh88oF63J/j4cp3joL2zb1q2QcCcvaJb0egSQxLwycxSAIdD4qy5ZY2h6fmHCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629410; c=relaxed/simple;
	bh=4xFcOPfMmomLNjVCvtK5J2NALU55qfvn8LvVnICQp6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WB26CnGoWodcYvnVg9stprgYGGem6cm0LSLcdNhLT5OujwrvoImIiu5W4ERVyWLBe6k1O/EBNQixenJ5aBkDBJACsDsp/8m2bcF0K/skwfEOr/ucZF+BsUPALYoFub6gcv0gTvgCrKz5AEFRWznNEAhxnV0rd4XbdYCOsy1gY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIVLnUif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEB9C433C7;
	Tue, 30 Jan 2024 15:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706629409;
	bh=4xFcOPfMmomLNjVCvtK5J2NALU55qfvn8LvVnICQp6M=;
	h=From:To:Cc:Subject:Date:From;
	b=jIVLnUif39/37ysSP81YlFicONcDkACBPwgDhzLJOC1CQEzM349LMyAcF3hcTP8on
	 iukHt9ggHVoloX2HVdW+iIYpaWXS3NR2vmGwYJnAZhtMEUnMqC+jd4/LfajmghaEaN
	 ZQ/RH23hIDViM4NxaxToiZaLIlQccsQ+vrh5tKs3SoHgjnY/RZoLxxuMJeOtLEqd+s
	 xX665VGkP4SYDCk7EGtnuNqdP2C7c8tAmkc3BOZ/LyGE8v3agt67XyqClpQJ27i9At
	 39SvZjntCW8BABCM9OiB1WpZ6yBm7II+LNw9bRmHyqOaEFdthjX6rY2Pxjf8xr+CJK
	 DMVSlJMti/T2Q==
From: David Ahern <dsahern@kernel.org>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next] selftests: Declare local variable for pause in fcnal-test.sh
Date: Tue, 30 Jan 2024 08:43:27 -0700
Message-Id: <20240130154327.33848-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running fcnal-test.sh script with -P argument is causing test failures:

  $ ./fcnal-test.sh -t ping -P
  TEST: ping out - ns-B IP                                       [ OK ]

  hit enter to continue, 'q' to quit

  fcnal-test.sh: line 106: [: ping: integer expression expected
  TEST: out,                                                     [FAIL]
      expected rc ping; actual rc 0

  hit enter to continue, 'q' to quit

The test functions use local variable 'a' for addresses and
then log_test is also using 'a' without a local declaration.
Fix by declaring a local variable and using 'ans' (for answer)
in the read.

Signed-off-by: David Ahern <dsahern@kernel.org>
---
 tools/testing/selftests/net/fcnal-test.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index d7cfb7c2b427..386ebd829df5 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -100,6 +100,7 @@ log_test()
 	local rc=$1
 	local expected=$2
 	local msg="$3"
+	local ans
 
 	[ "${VERBOSE}" = "1" ] && echo
 
@@ -113,16 +114,16 @@ log_test()
 		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
 			echo
 			echo "hit enter to continue, 'q' to quit"
-			read a
-			[ "$a" = "q" ] && exit 1
+			read ans
+			[ "$ans" = "q" ] && exit 1
 		fi
 	fi
 
 	if [ "${PAUSE}" = "yes" ]; then
 		echo
 		echo "hit enter to continue, 'q' to quit"
-		read a
-		[ "$a" = "q" ] && exit 1
+		read ans
+		[ "$ans" = "q" ] && exit 1
 	fi
 
 	kill_procs
-- 
2.39.3 (Apple Git-145)


