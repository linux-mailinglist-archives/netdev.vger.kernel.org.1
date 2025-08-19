Return-Path: <netdev+bounces-215065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E655DB2CFC5
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 01:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15B41C46119
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 23:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6E927381E;
	Tue, 19 Aug 2025 23:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F9gbemjR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FD34C9D
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 23:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645338; cv=none; b=GUEYXIGR0lwFXhqIFNlTXHwOCGDkl4nKGMzHWaherqybwPb1WEOmcazxo2ux9SnHyzxa1hII4Exeab47IeFcNvr690Hkbla/+8HQ1RlsAAMf3uASU5yKXMAnRD1/ddtNxeAwmwq71FyG/uZAN0ayFT/sg6V6sdTi/1fntbSHN+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645338; c=relaxed/simple;
	bh=sohXUCFQM1ep0RPRBEGHKkF2hRO8RMxXBzkJBASZSyM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=seQDaaj8AQcMi7TcO4HhWRkYL6FH5MWzXrACeO4vEBtq+KtgUMFG6/HNJlctrrjGz/wDqd+ekqL8AR1S4mREWBB8vVC5BDk5uh2cot8kz3RCedJFzgnfYOvoU6teR183CHgrHILM6YasVdKlOWHp8pFzZv4GK+ic3JHbQ8+n8ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F9gbemjR; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b47174bdce2so4622971a12.2
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 16:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755645336; x=1756250136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mjhf0MX/qFWykSy6d4h/JnOiudhoPbgld0ljmqsw4SI=;
        b=F9gbemjRMnj16I4K0LtACn73LmzFSlR3Z+BbEOA2Am8Qw8Wl8ploNzC535cNSxPgI+
         OYBJa+ytSGCdOPC1q60EZs+zVlxnlszCEgaw4tar5ejJEsHmQUTrCf1p1enVUYjnzhxI
         fZsxfXb12DmrgloafaVz1+aV/O6E7LDQ7biMgf7/OWJGGMXEc+5KCnlOxX6agodKBUJf
         GMGRb4PIFzIrqSjdACaMG+kUMd1FAOJ+F6LFPDx2SZaHDevQel+FuxwLo5ZObnZQXIOQ
         zhTifCOiRtG02lNvm78wae2yZaXUZXR+SD2t7s2lmT4BGXED3O94E7OWEoVOxSSmL6ZH
         8FMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645336; x=1756250136;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mjhf0MX/qFWykSy6d4h/JnOiudhoPbgld0ljmqsw4SI=;
        b=wwZgm491rGih2eCakPKSY55cnt5zKW6BCEOgKWPJIAvP7BpPdvLotned4y0l4NYdHi
         3OmRdMLAXjf9xE/Yc+MfA3Gqt+1OWjNrq8Wl5Gi/B4JAl5B5faImPq/y139DKotk5fzv
         TRKpxTOb2ZcZ1dV9ztuLj1X4zNZRybuXrzaKfv45g19jNXrUW6QazALszRS/DDhe+x1A
         Ssh3R5439ZMFMArHtRD8SEz9xQCdlALxvjdnXV2MlpsNVltjKRSJPG8S79yqb1J4ebCN
         IS9qwbPFVbWFJTVzYzby9wxorP0iqIzhEp+zM3xz8TmdW27TwfYrGIdaLrHv+UJIkVj6
         sZOg==
X-Forwarded-Encrypted: i=1; AJvYcCUgm0t75ygAB0xICb+3j11mHt+X0XyT35VQOOD8UbQCBro2G797u3EOjmN6cSx5NV5CtTReQHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrQpuwuGe+Puhl+fADjOyYK2HZ8o+kfuQnXEZNj9yS8qEwX1Al
	ajnsx6jwVPfig7Y9xnD/iggWF/3XuA2gQtSisMOoCeBVMsKMBVaZWj8PrWTfeLmiQVl0Fv4lO4s
	n93Vl7g==
X-Google-Smtp-Source: AGHT+IGC73+nCYKcjA1K7BPCnr4BmsLmZNvusDaz/b0pIl1OqdXVTD/JubiTgqIC7KB0jm7kXT+GMtpATXE=
X-Received: from pjbqi3.prod.google.com ([2002:a17:90b:2743:b0:324:e309:fc22])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a47:b0:311:df4b:4b7a
 with SMTP id 98e67ed59e1d1-324e1448086mr1328690a91.29.1755645336659; Tue, 19
 Aug 2025 16:15:36 -0700 (PDT)
Date: Tue, 19 Aug 2025 23:14:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <20250819231527.1427361-1-kuniyu@google.com>
Subject: [PATCH v1 net-next] selftests/net: packetdrill: Support single
 protocol test.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, we cannot write IPv4 or IPv6 specific packetdrill tests
as ksft_runner.sh runs each .pkt file for both protocols.

Let's support single protocol test by checking --ip_version in the
.pkt file.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 .../selftests/net/packetdrill/ksft_runner.sh  | 47 +++++++++++--------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
index a7e790af38ff..0ae6eeeb1a8e 100755
--- a/tools/testing/selftests/net/packetdrill/ksft_runner.sh
+++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
@@ -3,21 +3,22 @@
 
 source "$(dirname $(realpath $0))/../../kselftest/ktap_helpers.sh"
 
-readonly ipv4_args=('--ip_version=ipv4 '
-		    '--local_ip=192.168.0.1 '
-		    '--gateway_ip=192.168.0.1 '
-		    '--netmask_ip=255.255.0.0 '
-		    '--remote_ip=192.0.2.1 '
-		    '-D CMSG_LEVEL_IP=SOL_IP '
-		    '-D CMSG_TYPE_RECVERR=IP_RECVERR ')
-
-readonly ipv6_args=('--ip_version=ipv6 '
-		    '--mtu=1520 '
-		    '--local_ip=fd3d:0a0b:17d6::1 '
-		    '--gateway_ip=fd3d:0a0b:17d6:8888::1 '
-		    '--remote_ip=fd3d:fa7b:d17d::1 '
-		    '-D CMSG_LEVEL_IP=SOL_IPV6 '
-		    '-D CMSG_TYPE_RECVERR=IPV6_RECVERR ')
+declare -A ip_args=(
+	[ipv4]="--ip_version=ipv4
+		--local_ip=192.168.0.1
+		--gateway_ip=192.168.0.1
+		--netmask_ip=255.255.0.0
+		--remote_ip=192.0.2.1
+		-D CMSG_LEVEL_IP=SOL_IP
+		-D CMSG_TYPE_RECVERR=IP_RECVERR"
+	[ipv6]="--ip_version=ipv6
+		--mtu=1520
+		--local_ip=fd3d:0a0b:17d6::1
+		--gateway_ip=fd3d:0a0b:17d6:8888::1
+		--remote_ip=fd3d:fa7b:d17d::1
+		-D CMSG_LEVEL_IP=SOL_IPV6
+		-D CMSG_TYPE_RECVERR=IPV6_RECVERR"
+)
 
 if [ $# -ne 1 ]; then
 	ktap_exit_fail_msg "usage: $0 <script>"
@@ -38,12 +39,20 @@ if [[ -n "${KSFT_MACHINE_SLOW}" ]]; then
 	failfunc=ktap_test_xfail
 fi
 
+ip_versions=$(grep -E '^--ip_version=' $script | cut -d '=' -f 2)
+if [[ -z $ip_versions ]]; then
+	ip_versions="ipv4 ipv6"
+elif [[ ! "$ip_versions" =~ ^ipv[46]$ ]]; then
+	ktap_exit_fail_msg "Too many or unsupported --ip_version: $ip_versions"
+	exit "$KSFT_FAIL"
+fi
+
 ktap_print_header
 ktap_set_plan 2
 
-unshare -n packetdrill ${ipv4_args[@]} ${optargs[@]} $script > /dev/null \
-	&& ktap_test_pass "ipv4" || $failfunc "ipv4"
-unshare -n packetdrill ${ipv6_args[@]} ${optargs[@]} $script > /dev/null \
-	&& ktap_test_pass "ipv6" || $failfunc "ipv6"
+for ip_version in $ip_versions; do
+	unshare -n packetdrill ${ip_args[$ip_version]} ${optargs[@]} $script > /dev/null \
+	    && ktap_test_pass $ip_version || $failfunc $ip_version
+done
 
 ktap_finished
-- 
2.51.0.rc1.167.g924127e9c0-goog


