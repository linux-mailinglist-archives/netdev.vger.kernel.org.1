Return-Path: <netdev+bounces-240791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CE8C7A722
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2122386E4B
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 15:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C6A2D5C7A;
	Fri, 21 Nov 2025 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1agepvm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E394E2D0C68
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763737234; cv=none; b=n/qGIUrbCkLoP2aZShB/E1pb+DCz4/jFvImqa3WUssvPm9Q88ELblzbJIy8eKA/dZV6H2j6d64ZC7NbVDUqT9hDGzkiIo5yhx08c8Iif0I1u4zXIBnPZ+pSytu/6LbKb7MGIHFGwPnEyoqhcwYV4gtiCkGyJffgqJtBoCsv/21w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763737234; c=relaxed/simple;
	bh=tPo9szc/3/AwnPVWQuT0ceOIKU5O7fFK1Snwf0Sx4iw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ExvUESnE1hc+27wb4nWh7oz0F/lPivNENO4uf7H6tTrnLxb4G2Zv6iPj5By70lCadyN8VeF6b97+UZfTPSF5SaSOmIAxRLWVTudfhr2oGg/LU10T1QsvdVU0gqioXljhnKhurt/z92QMGv51BGVhfpiGbeaCRUvgRDo4dj0AyfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1agepvm; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-298287a26c3so23795465ad.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 07:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763737231; x=1764342031; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IS6KghpVM4CDdXoCAN6CR1CtFYv1L4PoQrnM0I3bBQs=;
        b=i1agepvmk3PM8U8oPig8KBExZSaKMAirWE/qgAP0lFLZFI7rE4jDUCY+o9c+vu7idG
         Fi5GDitqay3yXijL4OkzN0HyTI8bQ5jcTDRjPRvhdJGmJed71FObVlln2CSHvgIA7u4I
         EA84BqEx2fX9S4dA0sKugux/E3t6C4x7KpwW3OmdjvSeVux64GiVzdzp8pwmnjLC1JpT
         hI0m9pQwLgWqxsXV1jBaslPCm1JPvSWr4KPYI08BxKiT63pICDYvHJCeUyyJVZNTYLdB
         H924JXHSb60y8W+M/x2FqmGzVyCscV3/QHjBGnYTnuSjjp5DEEHotRNHrJS+jd6MJeZi
         H1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763737231; x=1764342031;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IS6KghpVM4CDdXoCAN6CR1CtFYv1L4PoQrnM0I3bBQs=;
        b=jjvbjX7hnqSPdyFzcUcstVV64eUmtdLekAzm0ECu+fuDa1MOhJ/pGlr2NDH9OE/d/d
         SF+IxRQx5iFZIF6R13/0P0A3MEJ0VeuznY07Ug/ejN+TSDCM7zgC9if1h9wIncqn6Lad
         8F0TedPLqBtLfq7PloNeoEVVtdEW7g6wGIqVQ5OZflBCPjxaBowtsYLKO7Pp2XdpKdqg
         Z1sxvQOoN5W3SqaipCwiGlzGzr0QnxGWtRRXUBCsGmlE9S3ikV1APx6DhRYqSXYUaeCq
         jd0Kfp7NSpFWLFVMd/4ttKrT8dcGqPb6QXjZAuO725jgMYWDlEWN1g2eLN/c0uUemR7T
         G0kg==
X-Gm-Message-State: AOJu0YyDX3B9chLn3XlSJcKiP0BCpy1g1Vs5Lmz9QhyH4RZ/C9v8kNfP
	9BqTz5P6K2T2hZaaJzZFXK85/6fO1++0/8lsEcyG6iVlwbQ3b7IrnpDK
X-Gm-Gg: ASbGncvTneKqJkufv6HuV9NPrz+GCL8ofpgB7+RG3izbNeGYPiUgrKyyCIWLkV8HLBb
	cu77+Ml5ylTfbs7/fbc3yxQg45t3I6CetsIZWl6ckM6EyVgXTUyW+WAixgyeX2SLFdiDwwR93Rh
	5KvF16LUjLDh3BixHnup0Qeq1tcbdFgsLOaq/wh70zis+F2TuwzX/WlrKyqTpEAD+oGbvFcFNJk
	zcMFEoaYaX1kZLpng1GM7oz9BwZvhNqjB0HcVL4ffW1jF7JKOLU1BNvqLq46gZoVLf++yTiLOrV
	FLc8au5UAz6Ot3Z3grvYHSlravDdE5s0jrA75n4Ipqkh4LjXMmzlfTPJdpxRNyQUIov45bOS+TW
	b+YHFL2VdczzaqtIHR829BeAjh53K4yiQfb7RTOR2YGkml9UFXU23SuMrX3moms72n/hGOX0d/H
	ayJiFMWC2J9DW1xmKVoFEsgwLPr6Y=
X-Google-Smtp-Source: AGHT+IHFoy7IDjjbCiy/0djx9IzAwERFFsu1k9IqHQ+Nlpu4NrdOTHvguxg46wR7xi1KxvSEsoITEQ==
X-Received: by 2002:a17:90b:5112:b0:340:f05a:3eca with SMTP id 98e67ed59e1d1-34733f0c7c6mr3239695a91.20.1763737230816;
        Fri, 21 Nov 2025 07:00:30 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:6e1:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b03971fcsm6374313a91.5.2025.11.21.07.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 07:00:30 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Fri, 21 Nov 2025 15:00:22 +0000
Subject: [PATCH net-next] selftests: netconsole: ensure required log level
 is set on netcons_basic
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-netcons-basic-loglevel-v1-1-577f8586159c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIV+IGkC/x3MQQrCQAxG4auUrA00gSr1KuKiHX9rYJiRSSmF0
 rsbXL7F9w5yNIPTvTuoYTO3WiLk0lH6TGUB2yuatNdBRIUL1lSL8zy5Jc51ydiQ+TpCbzIk6XW
 kwN+Gt+3/8YPChNtXep7nD7YZq/RyAAAA
X-Change-ID: 20251121-netcons-basic-loglevel-69e2715c1029
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763737225; l=1705;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=tPo9szc/3/AwnPVWQuT0ceOIKU5O7fFK1Snwf0Sx4iw=;
 b=bvKQgKgxt3dwuSkdVUbu+seE8vvStciTZ3t95zOTJvzdjcn8IqvTyZDj0UOsBHrSpDiyChj2w
 jkJnXfYCn2PDuzRlLsTM8MA9xaLVmrft76wQ/d8fG/aoXS05UtRyNNC
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This commit ensures that the required log level is set at the start of
the test iteration.

Part of the cleanup performed at the end of each test iteration resets
the log level (do_cleanup in lib_netcons.sh) to the values defined at the
time test script started. This may cause further test iterations to fail
if the default values are not sufficient.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 tools/testing/selftests/drivers/net/netcons_basic.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/netcons_basic.sh b/tools/testing/selftests/drivers/net/netcons_basic.sh
index a3446b569976..2022f3061738 100755
--- a/tools/testing/selftests/drivers/net/netcons_basic.sh
+++ b/tools/testing/selftests/drivers/net/netcons_basic.sh
@@ -28,8 +28,6 @@ OUTPUT_FILE="/tmp/${TARGET}"
 
 # Check for basic system dependency and exit if not found
 check_for_dependencies
-# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
-echo "6 5" > /proc/sys/kernel/printk
 # Remove the namespace, interfaces and netconsole target on exit
 trap cleanup EXIT
 
@@ -39,6 +37,9 @@ do
 	for IP_VERSION in "ipv6" "ipv4"
 	do
 		echo "Running with target mode: ${FORMAT} (${IP_VERSION})"
+		# Set current loglevel to KERN_INFO(6), and default to
+		# KERN_NOTICE(5)
+		echo "6 5" > /proc/sys/kernel/printk
 		# Create one namespace and two interfaces
 		set_network "${IP_VERSION}"
 		# Create a dynamic target for netconsole

---
base-commit: e2c20036a8879476c88002730d8a27f4e3c32d4b
change-id: 20251121-netcons-basic-loglevel-69e2715c1029

Best regards,
-- 
Andre Carvalho <asantostc@gmail.com>


