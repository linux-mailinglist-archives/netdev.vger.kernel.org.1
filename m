Return-Path: <netdev+bounces-226788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE9ABA535B
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715593B50E1
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A308B2F83AC;
	Fri, 26 Sep 2025 21:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lH7M4nBM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2555D29ACF0
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 21:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922181; cv=none; b=ZIkGvjla2fQ/bOs3Udj6ANGwnfAO2yS79rLXzlXwLowDNJtl6X9bbzAcYVzQGBxdNTqCjLH6ZoS5GwIDsITKO+ic+U8nGMO2Jk0VAz0wQSJiLMSDJYYaa17OqBLJ0yRpTdvvRa0glFz+I1uFMt4eSOPPRiNOwWjPluJiGP0tKpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922181; c=relaxed/simple;
	bh=WuT+qRi+Ex0iBOL31kklZjv6dLvkQVGsevKdws5BnW8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AwH1ZALUaHHlJJqNLPbzQMq3qt08zmPd/Pq7Rv8DAM6pgB5Qs4eUlU1QDyLfngbNuCxv25kuLe2qxxbPr75yVlv85sdIPt2bszsyJ74+X//LYv3Od8O+dFk8jbcrrBF2KFgyrd/d6l6fOXpy5NElWhErQSzNHMIjN2G8KMvNJf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lH7M4nBM; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27eca7298d9so51701675ad.0
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 14:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758922179; x=1759526979; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1CnK8KoVmVVoLtbEmMga+uh2b5VfH1sRfwnxOZ7iHVs=;
        b=lH7M4nBM3s7nEjO/pwD6DrGySepd2gxrfGKqsVh/qZgsOkYy4+PD/R24+kQLkkt/KA
         EDdtLD0oe47JciMmu/KFTzMlm5oJbL5WeVyFeTDIA2B2Gwx/CrboMpFOsnm74sg9+QtU
         dFaGVwOzShQIhsdOvEiYhPjgyVfOPx+o1qy94phgg447raM4rCv15DlzmlHUqZLaE1G3
         GSkzYtkOsLvymXZg5W2obrf21O7NJnA4snfdtv1ZZRCIF6E5/rqQ2zbTA+i7RdW1Cz+h
         UpGQcg3Ha5CgnfjBfhU51SvjIorf689lTeqAS3ev0RxHswtO42JVdIACY6Miowvo5LuO
         2KQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758922179; x=1759526979;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CnK8KoVmVVoLtbEmMga+uh2b5VfH1sRfwnxOZ7iHVs=;
        b=r/4TuuI4D3nbptzUE9q5KQm+SzOmbhSLCtoS26n/DCQmNuqkSH0kGlQ6ww2XUh6LPB
         isqDmJKqHejsPRhIkVbXPm9suT2VlBUQ2IXfPxF0f08hndMjb2OVrnufFLh8TQKx0kye
         rYsEQu+Nf6PJXnutn3O8/pCspTys0ADTPfP59x/DBVKzxuGACp6QQZUXReG9XRlmYijX
         xyTKbUcYhvZ+dgGPFBAx6ne34OcpQOYZL9wJQ5Mm5IyDx+u0eBwwMJee2eNG4Y3tQ/UJ
         YCQBW9EGL4IoqmXGTxF210dMiNtKKi/VQf0kuVJCroTvwu89/ttw5fD9M11hI1rftx7g
         vHfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp+j6NOnBjFVMklv7ATUOZwhtdoVE3C/313Q39JMi9edXB3rbID6Yc8t20nOfLqJ71CyDsOvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnKq3V5KyrgjC4U9aRsa6WwnyP3ZLjfSbPq0lr9aPtfcoATBEQ
	vGCPG8BiLWOkI4IBJujduAlv/bLocIWLOQZji9It9Ta2lkir2VAn5ILjnG54FxOQ+L3IPxJ6hGX
	AH3mkuQ==
X-Google-Smtp-Source: AGHT+IFyyIJzCGoE/IE53GKSg9kv+2RH1cppsXE2P02WWMrkHbsJS2Lz9Xmqi0NcBwbwpBCwO75esSIciKU=
X-Received: from plpk18.prod.google.com ([2002:a17:903:3db2:b0:261:6462:787])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e54f:b0:267:9c2f:4655
 with SMTP id d9443c01a7336-27ed4a49254mr97929645ad.41.1758922179553; Fri, 26
 Sep 2025 14:29:39 -0700 (PDT)
Date: Fri, 26 Sep 2025 21:28:58 +0000
In-Reply-To: <20250926212929.1469257-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926212929.1469257-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926212929.1469257-5-kuniyu@google.com>
Subject: [PATCH v1 net-next 04/12] selftest: packetdrill: Add test for TFO_SERVER_WO_SOCKOPT1.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

TFO_SERVER_WO_SOCKOPT1 is no longer enabled by default, and
each server test requires setsockopt(TCP_FASTOPEN).

Let's add a basic test for TFO_SERVER_WO_SOCKOPT1.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 ...cp_fastopen_server_basic-no-setsockopt.pkt | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-no-setsockopt.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-no-setsockopt.pkt b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-no-setsockopt.pkt
new file mode 100644
index 000000000000..649997a58099
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_fastopen_server_basic-no-setsockopt.pkt
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Basic TFO server test
+//
+// Test TFO_SERVER_WO_SOCKOPT1 without setsockopt(TCP_FASTOPEN)
+
+`./defaults.sh
+ ./set_sysctls.py /proc/sys/net/ipv4/tcp_fastopen=0x402`
+
+    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < S 0:10(10) win 32792 <mss 1460,sackOK,nop,nop,FO TFO_COOKIE,nop,nop>
+   +0 > S. 0:0(0) ack 11 <mss 1460,nop,nop,sackOK>
+
+   +0 accept(3, ..., ...) = 4
+   +0 %{ assert (tcpi_options & TCPI_OPT_SYN_DATA) != 0, tcpi_options }%
+
+   +0 read(4, ..., 512) = 10
-- 
2.51.0.536.g15c5d4f767-goog


