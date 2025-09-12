Return-Path: <netdev+bounces-222701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 179D3B5573A
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A481894F62
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C7B35335C;
	Fri, 12 Sep 2025 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mv8bvXwn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF951350D4B
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706854; cv=none; b=J1uJZuQDe3yw44dSJWkt2N6yKihCMOGsfVmI9A2ywxt93b/AhRJMNQ7CuiNBsDnauMr6HVqBh4v82zMovBWKENlAMASrpABpr+EHWTG4s3BPuH1GSxLwrjelXiO+2MIuJ/645ytMl3tdj+ow68czgExgR3d6Z5eDDYcKAlxF98w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706854; c=relaxed/simple;
	bh=wyOfA9Z4qZjfSNCnN1Zoeu2Ob0/D/ATgwmgGwmRhB+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nwnGzbaMdiIOC7bFaYDtTIXEAXuDP9ySaxDYmf/eRTKKiKUtXy/z0CkcMOG/f4uX6vJBnzGSYVsTqyadZVJFtYtLA53zNkJpv5Jek0O1GzK20oue8PEF79szjkDIJ/eSKHojnsmlJ0IsYdsZAkK1c35gcaxKaOB57i3kNyUrJXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mv8bvXwn; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so27438135e9.1
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706851; x=1758311651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FL67JfuuY9SGdztk1CnmGmCEi73VTYHhsmgmXTv98L4=;
        b=mv8bvXwnZbyDXMRxWeCJ6EOm6yfmLYsAFxTw1/nSFFIJJOoMOt8QL01FLf0lkQCp/1
         bocDdq1cWziNX3nbLYu8uF41JaasPlg28rnnxI/cT8whJg/dG7RUmheUjpf1XWCXo0+R
         Mwny2WT6MHWWf3hKVbCKj3xpgSpmrKMPuTrYYqEA8BNQKbeIP8KXL5ECZ2k7k9z2PtpM
         BollAa46Kx4aUnkbrJ8Q1l8YNtI0Kwe6xyBmsx7AZrvjmiicXERzpkevFZnhcrXogfYF
         y7mn+7eJxgo2P+71/VkIlW5kZ8TgLHP+ycAKNo6qpAtopJDuVazvReGXQO8xgX4h7Q3E
         e5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706851; x=1758311651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FL67JfuuY9SGdztk1CnmGmCEi73VTYHhsmgmXTv98L4=;
        b=ni2U+47S7KHtq9muCDoDoh3QvDQxB2g+vwNXsunfD5V9KpedeTlCUgQDore2VcRYW9
         LKpyXfnnxfTMc+yhxY9/uc/9BWzDIGVjSXzgJbAjAZhQMJSmQF7m82DPsS7baa6Ea/Hx
         i+KTO3A5/J6Qn8dtk36dRd+LZb9neveFAn7YfP7+aTAvhJ9EZ68jDCZmRN1yICgbBdHr
         xyXkIyYnkN5WcrqIGTmuI0eW85FIRcM20tNPO1EAlZc/W/1QhTYKMd6x+BAUp+9jMhyQ
         oTNjYZ5zdG62faFR7GrAaY1xNZbEHTt5kJGCWSVGDigYchd7XqDFj4uozA/64iXxSKK0
         1mgA==
X-Forwarded-Encrypted: i=1; AJvYcCW6DgEjaPSlHLqBBxCF6bmbKHCwpM8HMWs9aV+ruNYVidG4ovv5tgAJw8CXfLQEXBq21wPuQPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+i+EJ307+0BIffJTWnXrvKfNdh/J3cNgzF9nmiXAyhwDgW5Sp
	n/W9YorD/x6LTY8ekWzHJHYmKqkhCO6q/40mbl3YePAOZlbxhMz04zaw
X-Gm-Gg: ASbGncu6oa2Q+nKMQq3734T1UwLE9e7ZJe8B1sQiy15SkSzidFQywN8t44SbID7sfa5
	AZDXK+FlPnvNgKAxMJY8sA3NyrTbJ3G8LZHDCM6Wt3lhbNRdQgy3tR/bU2Y+/SOBvRuft9W+T46
	2gnPUoAzpmYH5Gjl3b2L2eLG9hWqxQqFB2uoxwl5xiS0C4e5Ek1CDDrmcOVXGntCPH4GdmwcTzN
	z/Dg4xATekia2ZwlUiGaHraRF+MfP9DNt81nbQX8OfErqlu3Dao9IRVXfHN288AJD/54cMkPGYX
	DH03e11/P480Qwo41zfQL3WOD5E+PFfYHYt6Kvji2MNz11//BAXPZRsJgUoAdd9ZM6//lk39fK0
	7BpHnAxLPZTD9JuwqD0sQIWwokmDyGlyWKf0SL17DB4yDVNW+HPqMCbyo9ltZn1F44Pw8bf+a
X-Google-Smtp-Source: AGHT+IHnxAVngHZQRsePAFq7iynBLmIa8Fg7O2Z7VTvuVafjtGYamzNuY+ON6/+Ls16YAqNHgZJRXg==
X-Received: by 2002:a05:600c:350d:b0:45b:9912:9f1e with SMTP id 5b1f17b1804b1-45f211c9c3bmr39664915e9.3.1757706851085;
        Fri, 12 Sep 2025 12:54:11 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:54:10 -0700 (PDT)
From: Yana Bashlykova <yana2bsh@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Yana Bashlykova <yana2bsh@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 13/15] selftests: net: genetlink: add large family ID resolution test
Date: Fri, 12 Sep 2025 22:53:36 +0300
Message-Id: <20250912195339.20635-14-yana2bsh@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250912195339.20635-1-yana2bsh@gmail.com>
References: <20250912195339.20635-1-yana2bsh@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test case for resolving family IDs of large Generic Netlink families
(those with 199+ multicast groups):

1. Tests that standard genl_ctrl_resolve() may fail due to:
   - Response size exceeding single message limit
   - Implementation expecting single response

2. Verifies custom my_genl_ctrl_resolve() works by:
   - Using dump mechanism to collect all responses
   - Properly handling multi-message replies
   - Correctly identifying target family

The test validates that large families can be reliably resolved despite
kernel message size limitations.

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 tools/testing/selftests/net/genetlink.c | 37 +++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/net/genetlink.c b/tools/testing/selftests/net/genetlink.c
index 0a05402caa20..361840aae918 100644
--- a/tools/testing/selftests/net/genetlink.c
+++ b/tools/testing/selftests/net/genetlink.c
@@ -1142,6 +1142,43 @@ TEST(genl_ctrl_policy)
 	nl_socket_free(ctrl_sock);
 }
 
+/**
+ * TEST(resolve_large_family_id) - Tests resolution of family ID for
+ * LARGE_GENL Generic Netlink family
+ *
+ * Validates special handling required for families with many multicast groups (199+):
+ * 1. Standard genl_ctrl_resolve() fails due to message size limitations
+ * 2. Custom my_genl_ctrl_resolve() succeeds by using dump mechanism
+ *
+ * Background:
+ * - Kernel successfully registers large families
+ * - Standard resolution fails because:
+ *   * Response doesn't fit in single message
+ *   * genl_ctrl_resolve() expects single response
+ * - Custom solution works by:
+ *   * Using dump request to get all messages
+ *   * Searching for target family in callback
+ *
+ * Verification:
+ * 1. Custom resolver returns valid ID (> 0)
+ * 2. Standard resolver either fails or succeeds (platform-dependent)
+ */
+
+TEST(resolve_large_family_id)
+{
+	int family_id;
+	int no_family_id;
+
+	/* Test custom resolver */
+	family_id = my_genl_ctrl_resolve(LARGE_GENL_FAMILY_NAME);
+	EXPECT_TRUE(family_id > 0);
+
+	/* Test standard resolver (may fail) */
+	no_family_id = genl_ctrl_resolve(socket_alloc_and_conn(),
+					 LARGE_GENL_FAMILY_NAME);
+	EXPECT_TRUE(no_family_id > 0);
+}
+
 /**
  * TEST(capture_end) - Terminates Netlink traffic monitoring session
  *
-- 
2.34.1


