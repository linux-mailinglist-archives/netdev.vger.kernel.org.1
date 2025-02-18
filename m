Return-Path: <netdev+bounces-167423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17232A3A374
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606BB162BBE
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 16:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDC426F46B;
	Tue, 18 Feb 2025 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbSYuc8w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D90826F44E;
	Tue, 18 Feb 2025 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897975; cv=none; b=K4lMm5cZv3Xef+Ulp6vu210JsNzE9UGTV/6X3gg9B9m3KX5LVNPjD2ULvZj5sWne04t2/ycR4AugFvvIkLL/iJmmsE7+VDp0MAYyDzkjIO3gnLFJ5/9o367hzGlBRAePruBSaf4voKJAzxvxdUTxcnuRYEZEZy5ADQIUvZJVrwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897975; c=relaxed/simple;
	bh=3RFWOtHbuVv6Nc1ZE3k6eCKE8OuVH5G1a5Nyu4685aE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ITsJKBU4K97J8cVUgQuDVF5kLv5/S2pK/R8oK1tM1mfhCU6ZXeYWkwKHOdMmynSn/h+mkRIkyzTAyW3+uGutZ0Xh8J0GLZUItgaQKFbAOUAW51pAnhkWO3wM5K2j0eocHLApLSy4qw1lXZvA4kSfCs6mn+VJOJpFa9UShM8aAGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbSYuc8w; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2210d92292eso85139985ad.1;
        Tue, 18 Feb 2025 08:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739897973; x=1740502773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NQ0iczs/f01PaFvxLk0T+RHP0Y74cglMUGc/eTOXWT8=;
        b=bbSYuc8wG8T6STaAfv9CdK9SoUMFUSwR335XFYFmeuDdjP67c+bL466RaH8IPSofYB
         ZqU2JmWvtkCd9exgUmytbIbkWtmbrPlySH69ANaLexQel5NJEsdAtBeVPDduUBsjU4Zo
         rcI7vgIn/cS7UDLXXBH4tRuGzUxJ+fPynEaZhP6FC+DRs+WwXb2ZO4DDE8FFGt/c0jU9
         51WAGdt0xWOrs2qWflrHXp0oGCZUjtMLzwHz7mHBw9Dqed6AP+qrh4JHC+FxIT9rcU2u
         4ICyBZASpNgYS88loM/KTUbnUVsV+gtU4egxjToEdUN5q3cOJihc/V1e1oDMHqLWdS0N
         WUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739897973; x=1740502773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQ0iczs/f01PaFvxLk0T+RHP0Y74cglMUGc/eTOXWT8=;
        b=MA5NkI+eFf+F6uv2IN4MGIC64sV0ID685ab12HIclp79o7wpbZ0cZ1zpVY3G9+NsAV
         5gAbJdHEbZGkCkNE6vok5A60gm9PZVfKAoYebCvObGjQbdE742EIo05ROqnyV4AW77ju
         7OhkpiCaFELvVOpSy34bXWOsgSgXbXYnZ03F3YgcuQWi22LJ5aoPfgQC3Iuidf6JLJ3D
         dfHFeWy6oPIkBRDQQd0Y3mVOF5jjXU8OBQm9onVFOYmAmkVf0UXysawAeq0Fmi2C+S4D
         1qJLjFRM9wou3pKACROpHpEQmLQIMcPWnJ0jn9V/oaknnsZxiqn5pZDmULPEpNAQBj1L
         z1CA==
X-Forwarded-Encrypted: i=1; AJvYcCVDQKz4WJtw9P5WqrOryr+F+js9ZN6tAAymPCNgDhjd8WZPEaXOdG3NB57MO962RfdorAkhdNbPB2UITDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQLUAlYBct3NaiHZY47ptNXgvmovzQzFbDagmiIlC5JuVud7zA
	LCt9XlXOhIOP/sbhNvRvrDDkM+9pWE3IC2AwYlRalZE8qyKze7Ko77c7Tuwni7Y=
X-Gm-Gg: ASbGnctNKSWULRvD3fr52odc3YXypuA0XBX18Z6u2qvAflYXR60Y4cll8obLe1Q7+Qm
	DO/K23/nB0GoyOmTK+ngunzFuk3jkSMOwKqXZ3xvrMbekQTsHCyf3XdkpijH4sGFmskojsRREnE
	lBCr4AlhZdQj9iYCFafZrnafWwzp+THw7zBfJ1imHjfw1ZBef+kqnitLXzkhbLLCrA4kZgoKXSo
	UPMoVE2nErZXUEQOuXhWRcz6iwecZSDVirgk2pc/R/C6n2/I9CSsrRCS+Gkb57t1hwNbMu8ocC5
	2NKjK/w2x8Q5b4KYVBA03LJUzcsh3RJRr0KoQr/1DQ==
X-Google-Smtp-Source: AGHT+IF1JuWYJdCOgkh3XC0mHjU0ZlfP/j0jnRLaHEDrwR/uBAScx7ddu3oZrBXPR0lPCThpWj6pWg==
X-Received: by 2002:a05:6a21:6b05:b0:1e1:e2d9:7f0a with SMTP id adf61e73a8af0-1ee8cbbba0dmr29332802637.34.1739897973071;
        Tue, 18 Feb 2025 08:59:33 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:16eb:c16:eb93:d961:71b9:73fe])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73258dece33sm7916298b3a.37.2025.02.18.08.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 08:59:32 -0800 (PST)
From: Suchit K <suchitkarunakaran@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	horms@kernel.org,
	matttbe@kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Suchit <suchitkarunakaran@gmail.com>
Subject: [PATCH REPOST] selftests: net: Fix minor typos in MPTCP and psock tests
Date: Tue, 18 Feb 2025 22:29:23 +0530
Message-ID: <20250218165923.20740-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Suchit <suchitkarunakaran@gmail.com>

Fixes minor spelling errors:
- `simult_flows.sh`: "al testcases" -> "all testcases"
- `psock_tpacket.c`: "accross" -> "across"

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 2 +-
 tools/testing/selftests/net/psock_tpacket.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 9c2a41597..2329c2f85 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -28,7 +28,7 @@ size=0
 
 usage() {
 	echo "Usage: $0 [ -b ] [ -c ] [ -d ] [ -i]"
-	echo -e "\t-b: bail out after first error, otherwise runs al testcases"
+	echo -e "\t-b: bail out after first error, otherwise runs all testcases"
 	echo -e "\t-c: capture packets for each test using tcpdump (default: no capture)"
 	echo -e "\t-d: debug this script"
 	echo -e "\t-i: use 'ip mptcp' instead of 'pm_nl_ctl'"
diff --git a/tools/testing/selftests/net/psock_tpacket.c b/tools/testing/selftests/net/psock_tpacket.c
index 404a2ce75..221270cee 100644
--- a/tools/testing/selftests/net/psock_tpacket.c
+++ b/tools/testing/selftests/net/psock_tpacket.c
@@ -12,7 +12,7 @@
  *
  * Datapath:
  *   Open a pair of packet sockets and send resp. receive an a priori known
- *   packet pattern accross the sockets and check if it was received resp.
+ *   packet pattern across the sockets and check if it was received resp.
  *   sent correctly. Fanout in combination with RX_RING is currently not
  *   tested here.
  *
-- 
2.48.1


