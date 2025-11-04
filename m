Return-Path: <netdev+bounces-235609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A417CC33455
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 23:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8338C4F178D
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 22:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C339733B6F1;
	Tue,  4 Nov 2025 22:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boJMujHm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7025C346FAB
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 22:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295958; cv=none; b=NBqlk233VTB8qCNl1Mf+eMTN80fxQ53zqqgVDvCy2u8yKeJ0MhJw79A6KWIriGCl0DaO9PRsiXIB+NR9BhaK63u6u3ChCBywXzKrfOSp8pGclxLxOdK11Q6vOEdrvO7EBWfxW1C9Akd02WcLPsyehkLcM4VCekfz0jRGEPfQNrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295958; c=relaxed/simple;
	bh=ZD+kE7Km9hitPWcu6/+QvjzHaUtwlQLzQuuF071Kneo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IIpeNp/bc8sAUiK8UflFZMpHe8AzFbHDBddbrN386n4tpjXdE0OkytCTdCb8Z7XvJl25lIEoJWrLhRNrDNUKDj7TQSYPpTOZM9f8VMH+jLAnKciutHZ+iHiTQ2JHpSzdukaLBgCSMDk6PQ6O+i8vR3Ij0f5j1YP72WPV1/ks76U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boJMujHm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2947d345949so54347405ad.3
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 14:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762295956; x=1762900756; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FdVSUjHTikcWcPgapXwx/mSIY+mfI9o+bTGGuyPCvg=;
        b=boJMujHmu6Bt3LKiTEKgcbvVBfY7HcPy5K9KmLyUNkJUwTk265Cmn7PMMtaPVPgvPT
         LvofcFT5lMfzwyGMvdGbYom+GUft2Z5DycWraiGGqDmDXqcsmeG00ItEEmsi0YygeyUX
         wO9z3lMt/h+5S9P4xdTX7fRrmGLeJq3KSS2UdwC2Q2nVx3PcWMrHE9ujSEF0SeLSrX9H
         CeOx97xEPD5sgQOcqL3l0LT8SdNkf2nXZQihKdQRyTHAV7J8oRF/PIm2pXsGMBGtQgbX
         pIQiE1cuoIOxaIdqLsePaij/BsvjVbNTYLUZKaybC2v2zEiMoFTTUJ1qcyXVq8C+REU8
         jW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762295956; x=1762900756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FdVSUjHTikcWcPgapXwx/mSIY+mfI9o+bTGGuyPCvg=;
        b=d5bV+U87PIA2tuzoBxhD5OcPmX5dSL3v4/+n/emkmo5cGv4a6zGVH6GgrbwxgRCmsE
         NWneGPWz2kcXZruJCc8Wd0QLqbKlgifl3+6q54DJhgDgfVaYMaLNUKm7pf/51DMnspvb
         ObmjLz7t24JHPcQ4ygpnngq+oV/UJBOIHLELzCDIP2HCnq792lawLKwlk8phH5eS0GKu
         elMn/d1CeWZzkS3h9+lQyFTw4dSOhN2I1lkIifTkAt2y5+ApAAV0gEC71N3PVbN3L7qT
         27GkHYhyiUoKjKbJVUZREPRiuoYT5hdC+lT7lkQglACUJE/6bUljERgQx9SUTy0MO0rK
         0QJg==
X-Forwarded-Encrypted: i=1; AJvYcCW7yfhhorFE8xHBTEglTeHYDTQ01+pqCZsJsJ8JRONvN/7sF7L+rKvPeziI0we9Snj5Lp3JkRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfDv8kYnl6YFY0/CPb5rVy7dn2JfqOlRQzU1Ls2eemWuhnfe45
	LVs6iYilPaaRyWgDkeGy59pm6CzvWBYUgvrw8DjL+CNDK+APm2zCuVt1
X-Gm-Gg: ASbGncuMYyxw7Go9LGrngTJtfWQBd7GMmm1T/MhSw7e7ZzyCxnmozHqPLTdJKLWSVPk
	0E16wpxe0YrFxQwG8dyo4u0BbySQ6o4z+Zey92V16pb5D81/JTDOuF7YuNOJjq826hSz/duSx5o
	zw6cTy6leJkTp3yfX1nnSYSiPkyU5tUf4OFNeN4NnlPCbxKSCa0EtLmzbzLBe88MaJIVx+eMpn4
	NpRhceltt+d8IaQRPxTTrqnUP9MpNmh6l6N0N7ecdPSJNxHt1ygxuXbRl3cPjAS5PwKjdozCE3j
	JmxKIV4vX6kTYZoL4/XJGY27RkFiLVo7Ygp6ddWrmTPzU1Io0E7H3UL3RXRFux2NtoSHnOxdYkx
	S4aaPtvZIEvSJL359nI02c+11wRZUwsYdlGn+aOLZhhchGVv7uq3UqEuCjSS2Du9Jr5jjcZTCgw
	==
X-Google-Smtp-Source: AGHT+IGE2AJdLQ3ih5rbl3nytu4JYVPoufSf2/AeWyCovMJpVIx4Pfkn2JQACMKcx394CGEglGnVnw==
X-Received: by 2002:a17:903:2447:b0:295:b490:94bb with SMTP id d9443c01a7336-2962ae75808mr13019465ad.50.1762295955674;
        Tue, 04 Nov 2025 14:39:15 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998893sm39091575ad.40.2025.11.04.14.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 14:39:15 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 04 Nov 2025 14:38:57 -0800
Subject: [PATCH net-next v2 07/12] selftests/vsock: add check_result() for
 pass/fail counting
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-vsock-selftests-fixes-and-improvements-v2-7-ca2070fd1601@meta.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
In-Reply-To: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add check_result() function to reuse logic for incrementing the
pass/fail counters. This function will get used by different callers as
we add different types of tests in future patches (namely, namespace and
non-namespace tests will be called at different places, and re-use this
function).

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 940e1260de28..4ce93cef32e9 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -78,6 +78,26 @@ die() {
 	exit "${KSFT_FAIL}"
 }
 
+check_result() {
+	local rc num
+
+	rc=$1
+	num=$(( cnt_total + 1 ))
+
+	if [[ ${rc} -eq $KSFT_PASS ]]; then
+		cnt_pass=$(( cnt_pass + 1 ))
+		echo "ok ${num} ${arg}"
+	elif [[ ${rc} -eq $KSFT_SKIP ]]; then
+		cnt_skip=$(( cnt_skip + 1 ))
+		echo "ok ${num} ${arg} # SKIP"
+	elif [[ ${rc} -eq $KSFT_FAIL ]]; then
+		cnt_fail=$(( cnt_fail + 1 ))
+		echo "not ok ${num} ${arg} # exit=$rc"
+	fi
+
+	cnt_total=$(( cnt_total + 1 ))
+}
+
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
@@ -510,17 +530,7 @@ cnt_total=0
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
+	check_result ${rc}
 done
 
 terminate_pidfiles "${pidfile}"

-- 
2.47.3


