Return-Path: <netdev+bounces-226931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 973BDBA638E
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 23:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F6C3B1023
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 21:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C784C238C10;
	Sat, 27 Sep 2025 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OjasZhl1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539A6223DE8
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759008636; cv=none; b=iqijFmw2vInyusNKNntSTD6CWf9boBtIo9eQR9Hb908MxAKkK1ZRHstBd87LuckDxGsXgi5IuSHUlkNlfFdaEDxxTWZEMtPd3Jy8ONoJyZAYvBgdDEPFSpU+tGctIJAGnfUMxvIK3qBXOBnJWOFxPgl56IKdFomHfd7v6do0qnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759008636; c=relaxed/simple;
	bh=IHfLMvPIye+XUMncQyp/RntpjuU+hUIacAJapZKNWFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fvccz2FM3eCP9/LEMrZ4vejnFXt7DhtgvO4KYyd53qQvdQRPgdRGcdLdiI6KFg8vHJ6cZTnYi5nVV81cv1/fb7RTrFwUTYFltUTgNHlfCYjLP2Er9QY9HZw5hb4MQlm4kCMBDXBXWUwBVvSJIhbq316+wxlFoo48Qh2ww9irtqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OjasZhl1; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b59682541d5so1341486a12.0
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 14:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759008634; x=1759613434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gFrnFbH7ZTDl3V8aU1/VRzeqEcPfP4MQnyoc/PUFyqU=;
        b=OjasZhl17ULKhLw1MFGbAhbv57FVsqTSFqnYx9QEDO9KAIddf8r6hxG2/6/wvNwdBg
         G8/zr2O0aaBisvsS8hwXbx47fcX8uFWNe2j5pYKsm/fxjBroygsI6cu30AP/draEff0y
         PeB4zjFkMV2CJfOdwqYOk4C5VtPaTt9W+qs8Euc1Sl6NtYIeB4W5gQCZl82KuGPX0iXf
         bpoo5G9f9LkZKfPzDdclkaSHZGUiRx5vYO73PA4LW/2eK9XTny9r8GnNDiikLwINSAXN
         JlMJOysT0/1KTP8rkD6c5dz05UDE+P7NbrPsINCTee1h/B62T6skLu8NyymwxwCi+iv8
         updQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759008634; x=1759613434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFrnFbH7ZTDl3V8aU1/VRzeqEcPfP4MQnyoc/PUFyqU=;
        b=i0GqeL2JQbNpk+w4Z9/sVW6iaRuzokDR8Oy553hUrIpcNI1ynk0A6SVzcochUaavH4
         JxueaZ5uF4r5KBh6MRUB3hN300l2jlyk/i5NleHtMexFDNJw7gS667uvubqYCtinWqZY
         9nemkP+j3KeSawIg3ckCUIDU/pNwlzy8o3QbMGt2brQIJcM9EesPJ6SlaY51Wh3J+cOc
         M+4wHz9/trBxCJ+BFghC6gao+QKLzA3+/Om3XvZnIEdaYUJK8zi4K1o3eKBSnDRkLANE
         u5SjwSU0RCUXmf+qYkgSKeGESHpprCT7KYKTDnNTV4AUJ26rO92mBEiJ8lkmMVgbzLq4
         HAIw==
X-Forwarded-Encrypted: i=1; AJvYcCV6t8hnkxei29wYcGQ+2hplNxber6CMqnpHUQU9CQMmBanTxob08J1gLXR7tWnB3kdsxnBffns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu6tbyJOigl54c8fmm4EdjM/Ty/o1h+JbhWN0/nS/v15smfPUU
	b8i0oWMD3brpvKhPozSsOO/e885sFbZXRhFDTVg7tWqEqJSwjbnmyCyTbWbtV9viovCNMiqbxoZ
	BXg8wbg==
X-Google-Smtp-Source: AGHT+IGd1tIlcsiCZIfG0ebuWla4Ana407wRA8pe450999eu3ZGQMIhpVNIc2umyyEX3LBn6Zr1ifdrf6Xg=
X-Received: from pffj24.prod.google.com ([2002:a62:b618:0:b0:781:1ca9:e250])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4324:b0:2c6:85b9:1e0d
 with SMTP id adf61e73a8af0-2e7c95a4a47mr14969945637.21.1759008634565; Sat, 27
 Sep 2025 14:30:34 -0700 (PDT)
Date: Sat, 27 Sep 2025 21:29:39 +0000
In-Reply-To: <20250927213022.1850048-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250927213022.1850048-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250927213022.1850048-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 01/13] selftest: packetdrill: Set ktap_set_plan
 properly for single protocol test.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The cited commit forgot to update the ktap_set_plan call.

ktap_set_plan sets the number of tests (KSFT_NUM_TESTS), which must
match the number of executed tests (KTAP_CNT_PASS + KTAP_CNT_SKIP +
KTAP_CNT_XFAIL) in ktap_finished.

Otherwise, the selftest exit()s with 1.

Let's adjust KSFT_NUM_TESTS based on supported protocols.

While at it, misalignment is fixed up.

Fixes: a5c10aa3d1ba ("selftests/net: packetdrill: Support single protocol test.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/packetdrill/ksft_runner.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
index 0ae6eeeb1a8e..3fa7c7f66caf 100755
--- a/tools/testing/selftests/net/packetdrill/ksft_runner.sh
+++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
@@ -48,11 +48,11 @@ elif [[ ! "$ip_versions" =~ ^ipv[46]$ ]]; then
 fi
 
 ktap_print_header
-ktap_set_plan 2
+ktap_set_plan $(echo $ip_versions | wc -w)
 
 for ip_version in $ip_versions; do
 	unshare -n packetdrill ${ip_args[$ip_version]} ${optargs[@]} $script > /dev/null \
-	    && ktap_test_pass $ip_version || $failfunc $ip_version
+		&& ktap_test_pass $ip_version || $failfunc $ip_version
 done
 
 ktap_finished
-- 
2.51.0.536.g15c5d4f767-goog


