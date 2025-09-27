Return-Path: <netdev+bounces-226933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD633BA6394
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 23:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C5A18976FB
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 21:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBEB235354;
	Sat, 27 Sep 2025 21:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YLFUzQDB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B37A23ABB9
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759008639; cv=none; b=HXZ7EQ8DDOHC09R14lqsBr36hJH0I2p6jeJlyoiLVSslSX0sZfG34ZczFIWAaIRmwd42zFFjCE5pxDwI2wroWDPh3SGoV3ragShlwtktuSzxOgPqAhv5V6O1dBTnGS2QF9Tg/Uc9VgaeqAAEP786R4DjHfQo72ed0CENrKtRTAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759008639; c=relaxed/simple;
	bh=vz/PgI5w49MCopN3KOtw3ZFEK17C6yHrTp1cBX5pDoQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I6/0O/aQ7DB1SOBswR82XwdCMYX0NC9OroSuROXGe+SO7Q5f5qeP5NPK4gRc88xM9wT6vQQ7I0GsFZfEzoN8DmSYucPPkCULFoRSDFjLwlFyzfE3ktBS7IdaYPHMUp5MA6Tw93UfPgwAZVwtotDRxbdsVVltEJXx8/cXPUMR1NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YLFUzQDB; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-78106e63bc9so2618214b3a.0
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 14:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759008637; x=1759613437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gSLZLQ25E/S1prta1gmsKA06VGdZOiVzRWrULAfUNbc=;
        b=YLFUzQDBmQzgR9mch5HRlM36BII6WsbZDsaEVO/dk4Jxf9ih4l0OM0i6HvielwP9dI
         /PuyKCKxAkApluUfPWBtMcbqF9xRUyk4EKCcN8cLSd3h3tLaXBpO4R4G6g0j/cSFqM2+
         Y3DWlrPHvIjWlDfX5H1pSVnEH60Qs67a3FOq7Oud3wTg4caF6D/FK3rEGkHYGyEkfFq5
         GT5wBUG92NNIy9MWb8xkkHP2DL56zE7XoWdhIRii8hoWuu9BxZp4Gdy+CWMFP+aTDKGW
         jcoVkyu9ge/u0wyNgGfiSzk36qE0pvPO2vKPsJi9OhCMbevotNYHUlTS4ALuk2G/Bdbg
         VObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759008637; x=1759613437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gSLZLQ25E/S1prta1gmsKA06VGdZOiVzRWrULAfUNbc=;
        b=cGeCz3LYFOQDfDCIXDSCtitCFwXiBWCqE4ikwojBxFzp1bRe8YQwjCojBSpnk2K8CL
         bYGepOvABUuiW1NsqxkxlBE1moy9BoA9fVm4UajNFnVlbW00pPs+Yv0ZmBp/3lpAP25q
         32Q+mgMfw/Sfxo20HOxsTZI+6Y4FcbetSBVFeXixgROcKQlAgRDFRWiYjUnnbuSQLwXl
         +NXzPKi44FsI0uZaruUnRUtoAssON7D8dcxWVZTS8PG0Y/ODIxbqLfKxpG98TP83jj7k
         8EY07cJ3JYxhnUC15Gia828YMyIJTZfx8B8xcJcDlWq/cOm5ijvy2qhbfdb/rZqSyUbd
         Sz1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhd1WvnO14N/PZlgaO/6oCWaN25SOFvypZggruJQh5AVeunnElUtGPOHWgTE1IF+1ewFeSE5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxgQKwKTxZ8BP+/SxY4CHQyhhvvd+znE44AOtu8H5oqt1cWPcz
	6CUEGiYhln4GfCDPGX/OOQdfKkQNEx1RhkkKz68U/LO+D7oTStvrLEn173QC9knuauY/S5/cciI
	zOxkgDw==
X-Google-Smtp-Source: AGHT+IEkCOARCFYVAJfu0nc2Rm99FHujZ2FF1ahzCIojXSApA8CU4/NeKKXnvQ/UBmJG7OAFFfvYHYP1qt8=
X-Received: from pffj26.prod.google.com ([2002:a62:b61a:0:b0:77f:5d99:87b6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6daa:b0:2b6:3182:be1e
 with SMTP id adf61e73a8af0-2e7bfc1d57bmr13743376637.12.1759008637506; Sat, 27
 Sep 2025 14:30:37 -0700 (PDT)
Date: Sat, 27 Sep 2025 21:29:41 +0000
In-Reply-To: <20250927213022.1850048-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250927213022.1850048-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250927213022.1850048-4-kuniyu@google.com>
Subject: [PATCH v2 net-next 03/13] selftest: packetdrill: Define common TCP
 Fast Open cookie.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

TCP Fast Open cookie is generated in __tcp_fastopen_cookie_gen_cipher().

The cookie value is generated from src/dst IPs and a key configured by
setsockopt(TCP_FASTOPEN_KEY) or net.ipv4.tcp_fastopen_key.

The default.sh sets net.ipv4.tcp_fastopen_key, and the original packetdrill
defines the corresponding cookie as TFO_COOKIE in run_all.py. [0]

Then, each test does not need to care about the value, and we can easily
update TFO_COOKIE in case __tcp_fastopen_cookie_gen_cipher() changes the
algorithm.

However, some tests use the bare hex value for specific IPv4 addresses
and do not support IPv6.

Let's define the same TFO_COOKIE in ksft_runner.sh.

We will replace such bare hex values with TFO_COOKIE except for a single
test for setsockopt(TCP_FASTOPEN_KEY).

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/packetdrill/defaults.sh    | 1 +
 tools/testing/selftests/net/packetdrill/ksft_runner.sh | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/packetdrill/defaults.sh b/tools/testing/selftests/net/packetdrill/defaults.sh
index 34fcafefa344..37edd3dc3b07 100755
--- a/tools/testing/selftests/net/packetdrill/defaults.sh
+++ b/tools/testing/selftests/net/packetdrill/defaults.sh
@@ -52,6 +52,7 @@ sysctl -q net.ipv4.tcp_pacing_ca_ratio=120
 sysctl -q net.ipv4.tcp_notsent_lowat=4294967295 > /dev/null 2>&1
 
 sysctl -q net.ipv4.tcp_fastopen=0x3
+# Use TFO_COOKIE in ksft_runner.sh for this key.
 sysctl -q net.ipv4.tcp_fastopen_key=a1a1a1a1-b2b2b2b2-c3c3c3c3-d4d4d4d4
 
 sysctl -q net.ipv4.tcp_syncookies=1
diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
index 3fa7c7f66caf..cc672bf5f58a 100755
--- a/tools/testing/selftests/net/packetdrill/ksft_runner.sh
+++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
@@ -9,6 +9,7 @@ declare -A ip_args=(
 		--gateway_ip=192.168.0.1
 		--netmask_ip=255.255.0.0
 		--remote_ip=192.0.2.1
+		-D TFO_COOKIE=3021b9d889017eeb
 		-D CMSG_LEVEL_IP=SOL_IP
 		-D CMSG_TYPE_RECVERR=IP_RECVERR"
 	[ipv6]="--ip_version=ipv6
@@ -16,6 +17,7 @@ declare -A ip_args=(
 		--local_ip=fd3d:0a0b:17d6::1
 		--gateway_ip=fd3d:0a0b:17d6:8888::1
 		--remote_ip=fd3d:fa7b:d17d::1
+		-D TFO_COOKIE=c1d1e9742a47a9bc
 		-D CMSG_LEVEL_IP=SOL_IPV6
 		-D CMSG_TYPE_RECVERR=IPV6_RECVERR"
 )
-- 
2.51.0.536.g15c5d4f767-goog


