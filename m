Return-Path: <netdev+bounces-237000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE503C42F71
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 17:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162A23B4D96
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 16:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED86A253B4C;
	Sat,  8 Nov 2025 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3Pyj4cW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9027C23EAB2
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617720; cv=none; b=X9CF8DIFOMB2JzIUqnLbRVeMfmqZ9HzyHziROXqUpIxB4gTKDvLSxo1hzTtYR81OVCy2sjqEn+SrG50KSgOBaTUYEphYy/qfRR0Xvh/KUVFiWm7WwVHZ3J5WxTOYSePZ7fGMUo0rkOqKlF65XfqFdYb5/fGixSD7HUcLk3p+m88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617720; c=relaxed/simple;
	bh=kXti4VlF9If/Jhp5cw6M/i3Lzb+2XXWTFOdTl0a0yx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ouPF5491tgB0sHy3dHNqAap2O50+/IP2vrWwyVkikK8j5aoOzjjvrLe1ujCYPW9vzTlOucbv6AACEvS70RwtGEp975Jz8KMrD/BK9t9VDh6g6mOJN7/FNU9tXfQpHISm5CQ9w4zokl2M/5Xu1PC2Ls3MbvN9aVWsjrrYzOxhp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3Pyj4cW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29633fdb2bcso17536835ad.3
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 08:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617718; x=1763222518; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lu3g3vSYUjY7/DxTl1+mYZ9eGfURyr+RcPBMpaSL4zc=;
        b=J3Pyj4cWtJm9KrnVOSVNSUxcGuo8cAwmkNeIo5p+ersOUlhzTahndiwj8f/1UVxnLB
         U/yFgVt1woo6RnqAd0TRV9tcq9hrAc0DjPbgYwWz1E1V6HBekZ3D68Y4hIXrzF6vWxHJ
         TrCL8z8xj0VTWvzQfC9Nr1/uexwB7VP28lW/5MgpbiK8wOuiDXF8GSx+0IR3XMCTgBRc
         DP65PoZtKgQbbBqF5O2X/pcFRcqFEgQWXeZwQ/OTXlkXNoTmlqQcsJtD5BKetbHMupuc
         gfyJ65l8S4eobmO1twEvbXTR/XMzm876qCRVdxwoaOPcZe9rNWWHlrj2lNxFaOaXinSp
         2RNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617718; x=1763222518;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lu3g3vSYUjY7/DxTl1+mYZ9eGfURyr+RcPBMpaSL4zc=;
        b=JobpD/zqmCAj0WyxysG89qvB28HZDaz4daYxLtyVl5JBMoMfk7vYtB4M3Je3TvntqT
         fO5sf5+O9aOJKKGvp7O/1RxHYGCpbMyI+KMg1fXZZ4nGD9TcapT4wvf11IH70/1m7B8c
         9RLqL9B6RuWP8EzixJ89KOu91vtZ+d3Q8eyLnMVRUYVQ1QJC5275RIdHNJbq+/Niwwmz
         T4XYao9vqCQgjxtY2owVz8tjMSH8QPEtCerFu3yf9oVkoVwNrj1lAvyBrh8p+X2OBfhZ
         7r9upOGCsXdz9Sv8fvHM49kxsCvY2vLebp1gdSeRuVhusvlLHSaXFW7wHRnFIiAjQrT+
         mgdw==
X-Forwarded-Encrypted: i=1; AJvYcCVTzMHozobZmvNJEqaVYzA7t+Q0M3YLFZMP5cHzcoeYv7X2czb3TIVGrEWTRAQYoLixvTU4Yww=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKQcxMw2vCG5l50DXTdaW3HK72V2Q34lixcEOrZEeccoJvlSmO
	XyJlbMeZJfgfZmN0iS2ppzYKjb0iMelN1N9zgVKKmu1mJ9HvIKaT4QOA
X-Gm-Gg: ASbGncvMVAgovMA1H02YpSPPyiisyB8Ji0lx6gh8Qo2EjkZzyqwuzSqL080dt9IJ2f2
	Gf/8SOugVXCbFQJtrBjGvxi8ebLAFA9cNKkKiHhZTQBKHvE0odqwdPmhaCOAc3B6lnnTrMz4ggG
	Z3QB7SK2k5t8K6zaC1XxLhN+6o1hq3XWTuGOcw50LqSYoaLiQvykF3z+IdI+aej8dOU7WmY0UhI
	x4MYcIL776CSxp6QvUIpa5iodczKRZsjVmTktv6PV9oUGTwsQcxkM4k4XPImJxMHBU3nwHQMMs2
	J0tUmlGqxViDhu5DskBoAUp23g/HJJYvCEUHwC36zpn1snC/5eeHbo0CRwtp6IYosj6n16YCmKM
	ZWp95Zglj1870+A9NnFVdhV9XVnKZ3kTp9YezE0ThHwmriok+1STxfVVYW+12e2xBqcTfY9rgBK
	XbzdJ1Za+vC9gAQtX7kG8=
X-Google-Smtp-Source: AGHT+IHDIYzATzCHfhG57FblbDFeYnwOL/4oaPCyboie4iuVOegKtbCQgew0dvzNH4sWmPXvWF1Gyw==
X-Received: by 2002:a17:903:238e:b0:267:f7bc:673c with SMTP id d9443c01a7336-297e56d0401mr33795955ad.44.1762617717613;
        Sat, 08 Nov 2025 08:01:57 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651042c24sm93002675ad.50.2025.11.08.08.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:01:57 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Sat, 08 Nov 2025 08:00:58 -0800
Subject: [PATCH net-next v4 07/12] selftests/vsock: add check_result() for
 pass/fail counting
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-vsock-selftests-fixes-and-improvements-v4-7-d5e8d6c87289@meta.com>
References: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
In-Reply-To: <20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add check_result() function to reuse logic for incrementing the
pass/fail counters. This function will get used by different callers as
we add different types of tests in future patches (namely, namespace and
non-namespace tests will be called at different places, and re-use this
function).

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v4:
- fix botched rebase
- use more consistent ${VAR} style

Changes in v3:
- increment cnt_total directly (no intermediary var) (Stefano)
- pass arg to check_result() from caller, dont incidentally rely on
  global (Stefano)
- use new create_pidfile() introduce in v3 of earlier patch
- continue with more disciplined variable quoting style
---
 tools/testing/selftests/vsock/vmtest.sh | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index bd231467c66b..2dd9bbb8c4a9 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -79,6 +79,26 @@ die() {
 	exit "${KSFT_FAIL}"
 }
 
+check_result() {
+	local rc arg
+
+	rc=$1
+	arg=$2
+
+	cnt_total=$(( cnt_total + 1 ))
+
+	if [[ ${rc} -eq ${KSFT_PASS} ]]; then
+		cnt_pass=$(( cnt_pass + 1 ))
+		echo "ok ${cnt_total} ${arg}"
+	elif [[ ${rc} -eq ${KSFT_SKIP} ]]; then
+		cnt_skip=$(( cnt_skip + 1 ))
+		echo "ok ${cnt_total} ${arg} # SKIP"
+	elif [[ ${rc} -eq ${KSFT_FAIL} ]]; then
+		cnt_fail=$(( cnt_fail + 1 ))
+		echo "not ok ${cnt_total} ${arg} # exit=${rc}"
+	fi
+}
+
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
@@ -530,17 +550,7 @@ cnt_total=0
 for arg in "${ARGS[@]}"; do
 	run_test "${arg}"
 	rc=$?
-	if [[ ${rc} -eq $KSFT_PASS ]]; then
-		cnt_pass=$(( cnt_pass + 1 ))
-		echo "ok ${cnt_total} ${arg}"
-	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
-		cnt_skip=$(( cnt_skip + 1 ))
-		echo "ok ${cnt_total} ${arg} # SKIP"
-	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
-		cnt_fail=$(( cnt_fail + 1 ))
-		echo "not ok ${cnt_total} ${arg} # exit=$rc"
-	fi
-	cnt_total=$(( cnt_total + 1 ))
+	check_result "${rc}" "${arg}"
 done
 
 terminate_pidfiles "${pidfile}"

-- 
2.47.3


