Return-Path: <netdev+bounces-107429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778F391AF5C
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 20:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82FF1C21994
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D9519AA7C;
	Thu, 27 Jun 2024 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxLq4jLQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346F019AA55
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719514505; cv=none; b=AuRtb1i0WmyKrlAXlBxyINphiK+bALLIqrc0KHQlfqze0lR9INFhn9KyZdeGcQ0Yq35e8hLGNb38BN0X4bUox8pRUpyljJdSorhgFo80fZoSY0PrnMa07mAFKU4ZCqRnMKv2yin7QqxMpTI3psCHQz4JUlxtpWAVTFuejh4Aua4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719514505; c=relaxed/simple;
	bh=ofp6vPECFhYk8unKGEFQld5h2QRFyop6an+YJgJQ+Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndN5lAoONerPpGE8Qzm3fm1OfEpyrv5BgI/U2TfkrMEwv5jtyXK+1BPJqWHuu6ByTja0oZ35c/fc1p4VQtMwFL6DoSxNFaK+OBXJgB/iNI0/YZJyObDxGZuwfYUW2NI+XDAlRepor77zfBAMi43MPg7O9tp4zej5BXnYYP+XL1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxLq4jLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61FBC4AF09;
	Thu, 27 Jun 2024 18:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719514505;
	bh=ofp6vPECFhYk8unKGEFQld5h2QRFyop6an+YJgJQ+Cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oxLq4jLQmQubImoaR8Xw9I+KbsgmhMQv8BWRc+TF2/Zi56VDxZ79IJu6QjI0Hn6bj
	 0M3lDKaI1U2enV5e+nbawMaXnPHAqIustVjobCgyAfpOlM6bpwFHIVDpRXKQQkop6m
	 /XIwWIJH47GyjMStC0i4arf6qwv913DgBBVwr9gjDvfZ//mvNXBDyNepl3o06a8d/L
	 l0hjt9N8UE+Q1jOxJbiht3LuJhpuiQRkwqzrz68E/jfU4z47Ihl5knTWoxslhRSpJw
	 /jJcAF94HppH2WT14GJaNinXjbVCdCmEZol5gT7wstPG+JGTVXAoFF3vvELXCv0Nnh
	 LMPGS6D9u3lbQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	petrm@nvidia.com,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/3] selftests: net: ksft: avoid continue when handling results
Date: Thu, 27 Jun 2024 11:55:00 -0700
Message-ID: <20240627185502.3069139-2-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627185502.3069139-1-kuba@kernel.org>
References: <20240627185502.3069139-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exception handlers print the result and use continue
to skip the non-exception result printing. This makes
inserting common post-test code hard. Refactor to
avoid the continues and have only one ktap_result() call.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/ksft.py | 28 +++++++++++-----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index b6ce3f33d41e..789433262dc7 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -130,29 +130,29 @@ KSFT_RESULT_ALL = True
     for case in cases:
         KSFT_RESULT = True
         cnt += 1
+        comment = ""
+        cnt_key = ""
+
         try:
             case(*args)
         except KsftSkipEx as e:
-            ktap_result(True, cnt, case, comment="SKIP " + str(e))
-            totals['skip'] += 1
-            continue
+            comment = "SKIP " + str(e)
+            cnt_key = 'skip'
         except KsftXfailEx as e:
-            ktap_result(True, cnt, case, comment="XFAIL " + str(e))
-            totals['xfail'] += 1
-            continue
+            comment = "XFAIL " + str(e)
+            cnt_key = 'xfail'
         except Exception as e:
             tb = traceback.format_exc()
             for line in tb.strip().split('\n'):
                 ksft_pr("Exception|", line)
-            ktap_result(False, cnt, case)
-            totals['fail'] += 1
-            continue
+            KSFT_RESULT = False
+            cnt_key = 'fail'
 
-        ktap_result(KSFT_RESULT, cnt, case)
-        if KSFT_RESULT:
-            totals['pass'] += 1
-        else:
-            totals['fail'] += 1
+        if not cnt_key:
+            cnt_key = 'pass' if KSFT_RESULT else 'fail'
+
+        ktap_result(KSFT_RESULT, cnt, case, comment=comment)
+        totals[cnt_key] += 1
 
     print(
         f"# Totals: pass:{totals['pass']} fail:{totals['fail']} xfail:{totals['xfail']} xpass:0 skip:{totals['skip']} error:0"
-- 
2.45.2


