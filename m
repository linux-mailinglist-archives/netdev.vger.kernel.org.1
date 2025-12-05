Return-Path: <netdev+bounces-243838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BBFCA867F
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 17:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C21263028D8E
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 16:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142F8340281;
	Fri,  5 Dec 2025 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEoTrk5M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E711433F398
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764952387; cv=none; b=CXKo3j1/GvY+OStN6TM0sQcrE/iEckChJo2hHLNJinX43DYhxFVljFjSbt3KjkUuepPaPHhSjCizem+fyAvjiQq5ZttuW1ftIvSSCaezc91SyhL7FOjNGesn2erzJwJ2+TiNFK9UxvN51+MBoxrb9FajuAJHUx/KeD32LpG53MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764952387; c=relaxed/simple;
	bh=eV3T/Q2J9myl0Knz5MJT/6uNc3o5E5HtielhDfYo9h0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KQjWaADqI3x1FiM9uPCSm5Jz4gE5xbqNowavxWvwQHG2lmRvu6DO5nfKmFhnAaZeERBwCsGlHEDnEEv3ldWsPdckR7Tl1hlBr2jI7I60cEPJGGQD+QGB42xKfRRZTDwrQ8aV8Bo32dYHqFoL7TYOgMxEXGxDuDztX1dWyFndOzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEoTrk5M; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-295548467c7so28431245ad.2
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 08:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764952378; x=1765557178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sYkMGvBxjwu2a5BBmmqN8avtwEussKPMSW7WaC678gg=;
        b=kEoTrk5MMenybMI1Y48oRpdjS+peUj1gH4xKuRVl8ye6R3nt8AvsOeq0+W3FBSRx0Y
         bcVzB35PYG901NK/bL9TFsk0kSZYUZPMnHIMkzMQamOhwQ6+0lK/+zbKXI7ZGIr5wiZE
         JNdczhQsTuwpkoO/nTw2FbT89GyjERPZWLTykk7Y4o7vRF15Owns4M6zwbDqq+dMOF2P
         b9ZVNHSCPKkZF9wAjuMYiNBh8RHWK9UTFLU7tOYlPTAjdhOHBVs7xSejO07SjmdIpK8j
         AyDn2OWbfvWTLOW01vEdrP6GqFXNE1PAIzaaFUPEZvKDLuZJLsviuynmbkTHnHS0o4cg
         C4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764952378; x=1765557178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYkMGvBxjwu2a5BBmmqN8avtwEussKPMSW7WaC678gg=;
        b=Lyjxm+QgndRNFtVvpwjFwQE4+luJqeCRfzP9sD+XXPubWP9VkObxtJCuHT++jK1okQ
         5m5gstt6M3q7vHUWSHa4smWMdc3QtqPxz/dwrSttDsypwshmlfooSlcrHl+EBnbzZoBD
         Z6Bc3ab4UI8Fa4tDUlNXpCgP+QR81iIn7hBhKRiKCDojq/NAYu2jeW3x0t8ElHVc16XL
         CZx4t1Kol8i/lu07F/Xgn4JUSR19oGn1XX8+0yyGq8QMNYYZtx1B/cP5/cN5lJ/LpC8r
         MmELCnLlXtBeABdStcvkMtjS8F9gc7KShfRgsZQhssss0vgOjp/SJSNHApEaD67cwD/B
         CTtA==
X-Forwarded-Encrypted: i=1; AJvYcCWG3y6RghRwoWS8RfZcoDDOc5A5VdyFez4cLcTTeFYV3PIwCbkcc0CauCJzYpvpU4YC5u/X9jY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ujvjtyxkG31otVdxqbaaQRkYbzo8hk6RlNXtRWcD2BjZkEx1
	hOauKIeTJ1kx5mN5YgCSGIvXcLT6cdFCGQCtwhirYJJGQscS0m1ChU3i
X-Gm-Gg: ASbGnctsnoAd4RWZvvs0O1pN4EdV+a4cT4shS4eV0gS6N80CQugr0dEdFl3rHU/AdgY
	4weJAThCnVI1ihY2pUdzUyqw1VR73W61KES10qqy+Zx+2ehsoenonJ3e3jsjULg56r82ZGyhf3g
	8VYI2JwinB/mGHI3ueWOBwsmNDZIHd+0n2T6Aqmphqv8EFLsZwH3jMEc/v7z1hx4rBaKoX+xAhK
	H1xnaiDDBeCmTVRZYbazys3TC0IZMMQstTcfgrkT+P/Ur5yMGCZrqAzsJA8wAp2B3J9T4W6bf2X
	hvBIFWLdRiiClZNbInW5ZFtzfLtMmS7grebAlV1FgSVNQXn7W6Ht3Jm8gVCrFI4UoT4YhxpDGGC
	+NrH3/bI1kmWrj2eaGR2zFn5LJxrK8yTiFUew9CPRCW+keMW+4lr7MUH3ca0545+p3ukT91M2W4
	/IJmBPLb3I5RS1f3gAaE56PbAufkG/7w==
X-Google-Smtp-Source: AGHT+IEJYajNpUZxFYn1PlaVbgGbaj56SMZuY1jHWuulkMOz8mEKtbb2jN+kTWCixJQMXWW/VhXsIA==
X-Received: by 2002:a17:902:d585:b0:297:c0f0:42a1 with SMTP id d9443c01a7336-29d6844f1d3mr110049625ad.44.1764952377960;
        Fri, 05 Dec 2025 08:32:57 -0800 (PST)
Received: from fedora ([117.205.73.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49c358sm53120755ad.5.2025.12.05.08.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 08:32:57 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>
Cc: Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH net-next v2] selftests: tls: fix warning of uninitialized variable
Date: Fri,  5 Dec 2025 22:02:42 +0530
Message-ID: <20251205163242.14615-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'poll_partial_rec_async' a uninitialized char variable 'token' with
is used for write/read instruction to synchronize between threads
via a pipe.

tls.c:2833:26: warning: variable 'token' is uninitialized
      		   when passed as a const pointer argument

Initialize 'token' to '\0' to silence compiler warning.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
compiler used: clang version 21.1.5 (Fedora 21.1.5-1.fc43).

changelog:
v2:
- update patch name and msg

v1: https://lore.kernel.org/all/20251129063726.31210-1-ankitkhushwaha.linux@gmail.com/
---
 tools/testing/selftests/net/tls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index a3ef4b57eb5f..a4d16a460fbe 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -2786,10 +2786,10 @@ TEST_F(tls_err, epoll_partial_rec)
 TEST_F(tls_err, poll_partial_rec_async)
 {
 	struct pollfd pfd = { };
+	char token = '\0';
 	ssize_t rec_len;
 	char rec[256];
 	char buf[128];
-	char token;
 	int p[2];
 	int ret;

--
2.52.0


