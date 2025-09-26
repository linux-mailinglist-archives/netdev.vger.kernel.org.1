Return-Path: <netdev+bounces-226785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7631BA5352
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19EF51C04431
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B3B28D8F4;
	Fri, 26 Sep 2025 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0W2kDFxL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195227F01B
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922177; cv=none; b=XMBbyqhKOAklaK9FDZA/SWKHCED9/ulXM5rnntLocKye+YRBohLf8A4TBer5IdIGjFqbqDIwSwTaUT+5Mg3w4J/yyGoUdB4dEO19tG3guCwujTYmG3BNY0dULJcUoAZthMVXFk/hMSN4YW16iiD4mGk5Ui/97JwzdusSPDuFj+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922177; c=relaxed/simple;
	bh=7DNt7UCSIDDmDEmC5GnfnFEZ4h8JlU2j10utJ4iq3Qg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bCSNbNCoQfESBhEiqRWO4uufE41Q+s2m40GnIGtHRJmV320DDrGkmV2TNcPLJzshpvUyclmZL8cKSPziEtufcH79XZCzimKOdf8sj9UpmL0EMNuInys1G+Fdjzetyw6XpU29uDbRhe2iKz/zoNn+LCjjntVKu/XMZKl/DVEwWmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0W2kDFxL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7811e063dceso730596b3a.2
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 14:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758922175; x=1759526975; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g3Q6Bi+as3wgWaddwCvTVlfrAPBFNAmHVfTNCc+N05E=;
        b=0W2kDFxLwI9/Lu7hQEoxguV20RFHrN9vUx5qFrQFY2qiF5v/Ze0ABDi8oFq3A1dC0l
         rvSbO1Utg74YvQdRMiGQDqLN7r99fqBBovGaRues+JVANs7dl40LmpuMHLjsMIAVOAO8
         rq1RXLVlbIzfHOWiwfisC5+5f3UPrB+Dc23FnGJ109q1fytNyzjDTWa0zsaviKUSpznC
         ZxzwEhL16ZbpfkDhH8cxSl5S9MXcEqc+wI3auIiC2U4MLqSW3OraUVmQDNa7zYI0/Dg7
         RCp/Zer8Ul1iycL33cFytR2QHcr+t7aNV0c1SUNaqMjqm0PZ+qFlwuCJI44NtHuaB9EG
         cWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758922175; x=1759526975;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3Q6Bi+as3wgWaddwCvTVlfrAPBFNAmHVfTNCc+N05E=;
        b=vzrPeXsi5g2aNeiicErro9XnjMC98O8fY1AeXuM1Ygzgsc4KsqlU4v4/gtXByksuw9
         WRdFMwwcV6osREvJLFz5O5abruw016wtD0f3F6dFh1QggpjCL7xE0k6OymNvWhITkfGW
         Feqi6hl4gChIMn6H+qI6fhrEZ/IimTVhyfnUVjzmMLI9w95MQy2ymPryFfscDPtkU7hM
         yjD6XANR938nz0ycoMfi/UwxaEPHOnT0AeMYngt65FQeSnxwmD43Ds8vOzCbaK4TIxM7
         KVEaaT1zgSH9v0GAXAg/88HhZvfiMrFl9Gg/x/1dKUQEFjUahY4Jxec8H9YmytOpHbb3
         oiIg==
X-Forwarded-Encrypted: i=1; AJvYcCWEj+Om4i3sG7YWOtuhgJyiUgbS3LclZ47XCaZ0W+Y+8yu2VeqG6/DlHxhYX4d97hfKY692/pM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmJGjF/z5Ys3UH6/NNGNm2BDaaGIvNnIQA72Ilvx4dd9I1xhgv
	EWn4CI3xz1O9ZjO2Sf0j7H/mdJHqmOdkNQm57B/U+KPmk9/3jeJzSf6qDAgPkYTUCnkI91MzHRv
	2WVbE4Q==
X-Google-Smtp-Source: AGHT+IFcBm8VZe/IuONrPH8PhyvZ2gCMfpdIvi+ey/5OfKyVAVQtvNz2pxBYiCGsP9oSWpmj6VAf/7RzZCs=
X-Received: from pgde1.prod.google.com ([2002:a05:6a02:301:b0:b54:928e:2e3e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a26:b0:2e0:9b1a:6425
 with SMTP id adf61e73a8af0-2e7d37f2c7cmr11492204637.52.1758922174981; Fri, 26
 Sep 2025 14:29:34 -0700 (PDT)
Date: Fri, 26 Sep 2025 21:28:55 +0000
In-Reply-To: <20250926212929.1469257-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926212929.1469257-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926212929.1469257-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 01/12] selftest: packetdrill: Require explicit setsockopt(TCP_FASTOPEN).
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To enable TCP Fast Open on a server, net.ipv4.tcp_fastopen must
have 0x2 (TFO_SERVER_ENABLE), and we need to do either

  1. Call setsockopt(TCP_FASTOPEN) for the socket
  2. Set 0x400 (TFO_SERVER_WO_SOCKOPT1) additionally to net.ipv4.tcp_fastopen

The default.sh sets 0x70403 so that each test does not need setsockopt().
(0x1 is TFO_CLIENT_ENABLE, and 0x70000 is ...???)

However, some tests overwrite net.ipv4.tcp_fastopen without
TFO_SERVER_WO_SOCKOPT1 and forgot setsockopt(TCP_FASTOPEN).

For example, pure-syn-data.pkt [0] tests non-TFO servers unintentionally,
except in the first scenario.

To prevent such an accident, let's require explicit setsockopt().

TFO_CLIENT_ENABLE will be restored when client tests are added.

Link: https://github.com/google/packetdrill/blob/bfc96251310f/gtests/net/tcp/fastopen/server/opt34/pure-syn-data.pkt #[0]
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/packetdrill/defaults.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/packetdrill/defaults.sh b/tools/testing/selftests/net/packetdrill/defaults.sh
index 1095a7b22f44..6b0ca8e738a2 100755
--- a/tools/testing/selftests/net/packetdrill/defaults.sh
+++ b/tools/testing/selftests/net/packetdrill/defaults.sh
@@ -51,7 +51,7 @@ sysctl -q net.ipv4.tcp_pacing_ss_ratio=200
 sysctl -q net.ipv4.tcp_pacing_ca_ratio=120
 sysctl -q net.ipv4.tcp_notsent_lowat=4294967295 > /dev/null 2>&1
 
-sysctl -q net.ipv4.tcp_fastopen=0x70403
+sysctl -q net.ipv4.tcp_fastopen=0x2
 sysctl -q net.ipv4.tcp_fastopen_key=a1a1a1a1-b2b2b2b2-c3c3c3c3-d4d4d4d4
 
 sysctl -q net.ipv4.tcp_syncookies=1
-- 
2.51.0.536.g15c5d4f767-goog


