Return-Path: <netdev+bounces-259053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEjeFYZ7lGkfFAIAu9opvQ
	(envelope-from <netdev+bounces-259053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:30:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A122A14D2A1
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C288D3010BB3
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6706836BCF6;
	Tue, 17 Feb 2026 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IrQV/KLP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2925212FB9
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338569; cv=none; b=EqpPZ9M4QnxZbyaQoqIqQiMD/JcZt36blYq+04THvwC41uEOcPlKCo84ZGcZUPWU8eEU5hX1jYIY5oyA3BUOK0G0TnzaL/BViodqNY/Vx9L9hgp+N+j25iZXEE2Va0850QO7tCJvPWDl3935sFCqMckby8u+J+0oC2UZGoU7fvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338569; c=relaxed/simple;
	bh=v7ZM1cQ875OwQRvqc3SXZ4bW1PqhzQbQ73jYVdxhtz8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mdlkd4XC9KtUCvW0M8pILZvBImDMBI1Kwf0Kk760UYLyzMkBFPR5ph4CfjxeJKrrhTxJ2bry8V3UQHwvnaNCW58rBPY78sT2w7jF6yZzbs8swiqHbnCDogS57EB0xczMP20QIqbiJYEINm4VBEBv6CH9daGSn7rDFj6u+Y2Vufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IrQV/KLP; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c71156fe09so2413049685a.0
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 06:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771338566; x=1771943366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oGCZk4xVbVnDRxkwvS8kE3hdf/M+wJivrUXUR0G4ttE=;
        b=IrQV/KLPfUimt9XnPnzd4XkL3pc/meNuVX1yOfQtU2lPMn6K+4GvVATi4s4NpUIYgN
         WkgsKZFaqQ0M5RZVsENgIVvceB++qTflB/14whWhFH9OuIu3xlxGa2aeySCKol4N6MU8
         4f9+lwlPt/sTCItsek9yy8v0kuvpPp8eZa3TX1qUk/B1hx6e77WFX++DVd3DHzqJVbBd
         H3Oz1Bi6MAyKDWCz5+BAivqbbUmStKxNG6UVs9P0lOSaPzxubHMjnbL/paDxTNbWE8cP
         MOdhkKMI4r9Gadv4Tf/gNW9xy8vKYW5RwDDpJnmaXsXPPYUmmuseJ/mlPmmTOz7zaWwU
         f5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771338566; x=1771943366;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGCZk4xVbVnDRxkwvS8kE3hdf/M+wJivrUXUR0G4ttE=;
        b=khqZuYmp62DaV7T3akjZiGPg0lf3KohHLvLFFrmwCp9CYsAD1bE8ZWNhII0hCLBpEy
         E5Dg56Of9oQ/42+sz+ZlEjzI74/NlV6lhtCrLTCdWDlmF43RLg6mDHIWXDK0dqrrSL2u
         U02DAZRCqzWbNMZFVq02xP2/5LxCHTRZ/MKeJAFbjfTzRG3V1DYNBeYkg38iesFxrzy+
         5s7q/JMxK4bo9Lih3YzUziWFoJrNCUFsaUgeaGM4yF+ppSavjlV4TF3RQFy2SR/aYHwq
         cEPka4Cs6KFzJk+Eg5P32CZ+QseF1iZRppmzFxdA4vt3H52IIPzd7ZDur/rP9btP3Fpr
         ZGBw==
X-Forwarded-Encrypted: i=1; AJvYcCVImGHDMbnRptfEpXNMLGtV080QhA2KqpGwBU5IDbe/D9fSQOdBRhTrRIebVZnr3zERHb3XUbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuan2Zwox1dw2ydezggGt0H2pGXwGaESnRBtLqnJ1AV1LPYgQt
	t0ZeMjVLY5dyrRs1MAsMc09m9bjCgEzrK0FRikZj/c2g+rMmoAXcZ3x8IXf0vxacOCqrz1d+6xT
	SWxz5ZZ6L8iHiMg==
X-Received: from qkbdy54.prod.google.com ([2002:a05:620a:60f6:b0:8cb:3d67:c696])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4541:b0:8c5:4e48:c908 with SMTP id af79cd13be357-8cb4bfa4df2mr1303221285a.27.1771338566335;
 Tue, 17 Feb 2026 06:29:26 -0800 (PST)
Date: Tue, 17 Feb 2026 14:29:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260217142924.1853498-1-edumazet@google.com>
Subject: [PATCH net] selftests/net: packetdrill: add ipv4-mapped-ipv6 tests
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259053-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ksft_runner.sh:url]
X-Rspamd-Queue-Id: A122A14D2A1
X-Rspamd-Action: no action

Add ipv4-mapped-ipv6 case to ksft_runner.sh before
an upcoming TCP fix in this area.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../testing/selftests/net/packetdrill/ksft_runner.sh  | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
index b34e5cf0112e38ede3edf8d36e266e39f999ca03..0a97d5ae34699a7c0638972e21243b71047a8554 100755
--- a/tools/testing/selftests/net/packetdrill/ksft_runner.sh
+++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
@@ -13,6 +13,15 @@ declare -A ip_args=(
 		-D TFO_COOKIE_ZERO=b7c12350a90dc8f5
 		-D CMSG_LEVEL_IP=SOL_IP
 		-D CMSG_TYPE_RECVERR=IP_RECVERR"
+	[ipv4-mapped-ipv6]="--ip_version=ipv4-mapped-ipv6
+		--local_ip=192.168.0.1
+		--gateway_ip=192.168.0.1
+		--netmask_ip=255.255.0.0
+		--remote_ip=192.0.2.1
+		-D TFO_COOKIE=3021b9d889017eeb
+		-D TFO_COOKIE_ZERO=b7c12350a90dc8f5
+		-D CMSG_LEVEL_IP=SOL_IPV6
+		-D CMSG_TYPE_RECVERR=IPV6_RECVERR"
 	[ipv6]="--ip_version=ipv6
 		--mtu=1520
 		--local_ip=fd3d:0a0b:17d6::1
@@ -45,7 +54,7 @@ fi
 
 ip_versions=$(grep -E '^--ip_version=' $script | cut -d '=' -f 2)
 if [[ -z $ip_versions ]]; then
-	ip_versions="ipv4 ipv6"
+	ip_versions="ipv4 ipv6 ipv4-mapped-ipv6"
 elif [[ ! "$ip_versions" =~ ^ipv[46]$ ]]; then
 	ktap_exit_fail_msg "Too many or unsupported --ip_version: $ip_versions"
 	exit "$KSFT_FAIL"
-- 
2.53.0.310.g728cabbaf7-goog


