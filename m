Return-Path: <netdev+bounces-226786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C59BA5355
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1A73AFFA9
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAF2299A90;
	Fri, 26 Sep 2025 21:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LjTCStT4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FDB262FE5
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922179; cv=none; b=BeOlGLc19/kTK9TWPyZkK5QeR4wfVb40ezlkXynULVAvacMthF+4RhayjzPzodxmTaWCpTq6chB5ilTCoIryQHsaWFiROVCKHIr3MkFu31vvsktnoIWk65+bX/9IrAZRc1TrG1ZYqlex5paLmONg0KYg6iUUUrBsdBwZ7SzzSSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922179; c=relaxed/simple;
	bh=2mkPzFLZobtZ22MXZLwC5Un1kb+5eX7fDl/I4F860Zc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fJjeBZ/vwGPmTZ31GT8sdS78Pmtwu1T32rhDPGCQhCWZmBp2p27+B+ndVNaczo4Z2N4s0p1R07Of3mgwHUriWrt8s7M03bcOjjwGlzJxIDJUuJichv8rUT5vyWIAMnVK3TlrvzpwavzSQqY2Qfw29iIkwqex8+4Dr/7IG1SD384=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LjTCStT4; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-78104c8c8ddso2076936b3a.2
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 14:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758922176; x=1759526976; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FFCnwT5ZcC0rte0Yzb8X4Oeeja1pvl7sSoLHR9A5Soc=;
        b=LjTCStT4EzL+6MsfP17quMBGxvsGkAEG6O6TjCzP+gBvd4fFjwv+gDy8JEMgEOWgtm
         L9pwg/eM98tBHxIeK6tXeNlRKvY3N8aLu2e6wVOAHWDI6axMEREzPBqzLaXSA98XvNeI
         H86I+aqgp/leT335VN/jp8NZbUcx1Rw9QTXSTEL6vyim+xDDQ/y0Rhet2TOlRkz4Z73w
         8EdpdFc3PAekeXy82axJDFXyUxL0x+B+StrMjt8PfQY31noRdIzbMr6OB8NciYKmP2aF
         1MpQa99cNJIZ5SC9sqqCdp0DefsDdJ9NE4XDva6fov4Mdtu8x+BTx+yUgdrD7G6pd+fO
         Fagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758922176; x=1759526976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FFCnwT5ZcC0rte0Yzb8X4Oeeja1pvl7sSoLHR9A5Soc=;
        b=jNKhEOgms3Qrm2AIV7LAui+sAcqRh7MxP2lef2nGP7/HLKz0PB6DDTrqwsrbh3DR2a
         nBhAyfHRs/PHWM7YxMofZHTWoRiZTve7r+25WG+aN3JyTECdpErJwUlDfEPAJvuoSEps
         vc9RqePOSGpT4q3KQVxd7HBUKt/7b7vHHBVFm1MRBQ3Ep9OlJsBSPV3h+q8Vh7UhtYNt
         mo3uZRZ2VRRX1tXtnO+IqCW6EGq21K8RdMAbBXe/Wenee43+lTA7nEruFxdC+MIFWuiO
         LiLujdgzyfH22Xgb1SxBi/757Dqtzh6hx4ere2GDCcA752yZmPZjGBj++Acg5D/qiV4M
         LVzA==
X-Forwarded-Encrypted: i=1; AJvYcCVvDd4bBQNKHfcksytXxsqcVLVaV/c7t9fUVUJ7YfhFd6f0BIUvZ2V1UCZoGAkNcGtskAZeSso=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfF82ZDj8VlbkEhVHSnFrLhQj1FjTFBULlQ2PfHeYRxn/FsUuo
	KPsUOcQm3WsgIPgElHk3HC2NxIdsT+ws6EVDFik78V+Qhjt7wRUjVj60kgOIC8q4GYKj5biWYlu
	pNtSdrQ==
X-Google-Smtp-Source: AGHT+IEIH1P8IpKt0aDN4sihRSqDJDrzUZJ++CUUttHQ7DlmHCoMYa929scoUKloQzsbyRKKhDU9O63cpEw=
X-Received: from pfbfp10.prod.google.com ([2002:a05:6a00:608a:b0:76b:651e:a69c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2288:b0:781:1f5e:8bb8
 with SMTP id d2e1a72fcca58-7811f5e8d95mr2773794b3a.15.1758922176552; Fri, 26
 Sep 2025 14:29:36 -0700 (PDT)
Date: Fri, 26 Sep 2025 21:28:56 +0000
In-Reply-To: <20250926212929.1469257-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926212929.1469257-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926212929.1469257-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 02/12] selftest: packetdrill: Define common TCP
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

While at it, misalignment in ksft_runner.sh is fixed up.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/packetdrill/defaults.sh    | 1 +
 tools/testing/selftests/net/packetdrill/ksft_runner.sh | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/packetdrill/defaults.sh b/tools/testing/selftests/net/packetdrill/defaults.sh
index 6b0ca8e738a2..b9d4c7d74577 100755
--- a/tools/testing/selftests/net/packetdrill/defaults.sh
+++ b/tools/testing/selftests/net/packetdrill/defaults.sh
@@ -51,6 +51,7 @@ sysctl -q net.ipv4.tcp_pacing_ss_ratio=200
 sysctl -q net.ipv4.tcp_pacing_ca_ratio=120
 sysctl -q net.ipv4.tcp_notsent_lowat=4294967295 > /dev/null 2>&1
 
+# Use TFO_COOKIE in ksft_runner.sh for this key.
 sysctl -q net.ipv4.tcp_fastopen=0x2
 sysctl -q net.ipv4.tcp_fastopen_key=a1a1a1a1-b2b2b2b2-c3c3c3c3-d4d4d4d4
 
diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
index 0ae6eeeb1a8e..04ba8fecbedb 100755
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
@@ -52,7 +54,7 @@ ktap_set_plan 2
 
 for ip_version in $ip_versions; do
 	unshare -n packetdrill ${ip_args[$ip_version]} ${optargs[@]} $script > /dev/null \
-	    && ktap_test_pass $ip_version || $failfunc $ip_version
+		&& ktap_test_pass $ip_version || $failfunc $ip_version
 done
 
 ktap_finished
-- 
2.51.0.536.g15c5d4f767-goog


