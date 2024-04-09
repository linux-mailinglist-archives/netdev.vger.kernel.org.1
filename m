Return-Path: <netdev+bounces-86158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C595089DBC6
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 16:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2DA282B87
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 14:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C08712F596;
	Tue,  9 Apr 2024 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C41Es8d5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9900F12A144
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671758; cv=none; b=bS05pZSsXxZgZNYQRfNsDfvbht4hTrvQEztnfYAdR94EODOUurhPBvK7l/P6xMl49ehhs+1YnXldV4EBphTdhibDFf/1JLIlM0cKIPdjDj2fq2yQldx4LbbPpIrPrht3CktidiAkzJOpOauc7l3JE0A9U8nf548E7bARGMgNONQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671758; c=relaxed/simple;
	bh=rLJ7AUBvoE9N2FTnZtcPOjIENrFtiSS+TWCUgpeJ+gY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=C2xOVe5onVJKu4u0PQ7C0aPN94KESro3cMRhPSG4yZt9O8sKtrFxkwiM7dKb/0jITLjapYp5KsvN3dNtCbKgqPKHa/XYimObC8gb19AeWj2yiWmAf1HyKB36d+BF3zm0mqBuWsvoTtsnWh9kfrkaf7FUWuyMhhvzAHs+7nSQebU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C41Es8d5; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbfe1a42a4so9367626276.2
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 07:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712671755; x=1713276555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=izh0m/N2Vxkxb1/vSeUgPJ5g3NFGUOzcsP3CX+GQ5pI=;
        b=C41Es8d52Ps2Spis/GsXVeODTIiizfDLWYViej9egODW7zaj151PeJIa3rhKZMZ9HZ
         nWkldlrBpUOOEMwveT0uDjqg/lqTpXDIg4K5w6JI2TYWqjyJuud8fDDWWYxPxdtWGLMN
         NrXpTmIwmBeFwLkvHHcE9RUzFTsEiHV5tksfGn+Lv0Pxrzk7xxcnPCF/h4HoYYPORx4M
         4zJpwhZxSvUbjYwc8+RInXfavMYCbvDuoow2lEjKzq3ZJNpT6DXKtHugEhjmpJLC8QAA
         xHB03sYs8kRbXLOSOJSCA6fZHj0/x4serzonJ3IBWo0Ok1hAm6i6mco7Z5CBOcnINdEj
         nYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712671755; x=1713276555;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=izh0m/N2Vxkxb1/vSeUgPJ5g3NFGUOzcsP3CX+GQ5pI=;
        b=MCrh0b9Ye1hnRjDI/i/HRZVxkjtNiARqCjL/oRr19Ki9n9ZS4r6y7lkm/C9xWIhpYF
         EN9h1I14kVdQLnrGKDNX8UAS9sRMIKpmpkaYVRgz3i0Xei7lAzYylV2OX1FuRRx9GFfm
         WyMV3MZaP4NmhpBQNZLGQMCRPUFFW3chk3rq+ta6pNXKNT86RGgGENnB43J7PaBe5TXp
         44EB9i3hrGlqU8cT+wVOi/8dL/XupkgI7wRg2X9Wdi/Na0zbqNStouaCs4sNWCFCZV4V
         3YjmBVvjdhZaxqCFh9aEwRRL2SVo7S9s1g5xrbd4eTqs+XX/NS2+FjdrLcV9MRTmmTm1
         loxQ==
X-Gm-Message-State: AOJu0YznwgtqJrA8XauGxp078Ga7DXXWLPkpq4MO9wa9eB7RzbjjdSvE
	c4gt13eeeKsV66hEk1hjgqNRdxx6ADHKX2cc5jx5T1fC8iesTwhgFi2/Rywegi4OUZf1w5GJm8b
	FqikIGNNTlw==
X-Google-Smtp-Source: AGHT+IHI/JkGKRQ5QTCPFCG+H19NhFQNMjz9LKiUO58A4eyz5Et/WlUeKbUfVOBLiQdkBMVjJ7BcdAMBj6yZHg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1508:b0:dcc:e1a6:aca9 with SMTP
 id q8-20020a056902150800b00dcce1a6aca9mr3625810ybu.9.1712671755379; Tue, 09
 Apr 2024 07:09:15 -0700 (PDT)
Date: Tue,  9 Apr 2024 14:09:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240409140914.4105429-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: tweak tcp_sock_write_txrx size assertion
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, kernel test robot <lkp@intel.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"

I forgot 32bit arches might have 64bit alignment for u64
fields.

tcp_sock_write_txrx group does not contain pointers,
but two u64 fields. It is possible that on 32bit kernel,
a 32bit hole is before tp->tcp_clock_cache.

I will try to remember a group can be bigger on 32bit
kernels in the future.

With help from Vladimir Oltean.

Fixes: d2c3a7eb1afa ("tcp: more struct tcp_sock adjustments")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404082207.HCEdQhUO-lkp@intel.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/ipv4/tcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b07aa71b24ec147d2f1f148e288231b3a492fb5a..e1bf468e0d22aad01532dce6e226ca095d578b91 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4673,7 +4673,11 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92);
+
+	/* 32bit arches with 8byte alignment on u64 fields might need padding
+	 * before tcp_clock_cache.
+	 */
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
-- 
2.44.0.478.gd926399ef9-goog


