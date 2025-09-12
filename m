Return-Path: <netdev+bounces-222702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 977B0B5573E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 21:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC5E7C7688
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBBE35CEAD;
	Fri, 12 Sep 2025 19:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nfp89k+a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064162BF3CA
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706857; cv=none; b=qRqIFsNHGcXVOJ52xBOz7dBcO0Cq1MaTNeU9IlvkejRsGECEztQyfMxQwXzlYvIg3LNSaFQTRdXIRdXurqQNnK2+8+M+ViArQ4IlOn3DCMzy45QUgzXDPUIwohTX3cOxnbTkh2LRCVrv4G+XRnJdZpV8iQTjuo5uBBi2UzjCITg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706857; c=relaxed/simple;
	bh=icbkvjvQJUFVCkaCJXhVHTgOSqoKQBetWKx3gQY2/kQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lieINycM+ZKfiaUPaM9cmRQg38w9vk51Y1lAE1a2GqOg8p80vs2oOMC/nYIcUQtR+cZerw0VuNCSJYotY/1c/6AHjGa9yDvvjD/tl6NodFIuIjo73mOPIPC/+xgiAszUinqVNbRoUvD+EcOvS1RGoITwuA6yL53Ay46L56AFWx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nfp89k+a; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3dad6252eacso1016461f8f.1
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 12:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757706854; x=1758311654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fb9o+yLyjF+OaI0yOxAbCTZnd+38YkRAXuvGtFeqK84=;
        b=Nfp89k+az3mXppfv9w5wgN+4jCy1oi6QTALBueEqIjMUhJNjUrajkNJwFZ+uOyKGYi
         C4L0hSz4pPnDNyg/wqofjGGh1SdSEIOZFrgpjTtu2z0pMGliR0lWfb4zCNeKnFw/V+Mo
         PEGR7w+Q7zN54Iw498IuN8UHuY6Go1clnf2PshtIkWHZeUrb8SlXQhLIY2ON5+E6o1p6
         65V+NvUNgj78FCNpgtM2veRU3OKtgPKnSiEafjilUmakXuArzBf/G9Isc1C0T+mEUoLh
         h6FEcKTabTdiWAeVekhMJdzria00VWRuIY8nasVnLcfSdYp/Aw4qRjGKAiXkhkvWI/Lw
         Si+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757706854; x=1758311654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fb9o+yLyjF+OaI0yOxAbCTZnd+38YkRAXuvGtFeqK84=;
        b=bjaSFKu1hpKJ7lwReTjs+RNcJsS3Lfq/HAbVfxmOBWyzJoiXRwwFC/dgPdV4Ahl41P
         sMI8pJwDlKjpQUoMpciNpgGQhJb+DghfqqYM9eHtKh0Ws7wjE1Ocs0pGInyEfEdWSaHw
         LMSEuMuaoQYBywNuDwtZw3P2pCGd9PdBCWsLyU+njihxMKseZqa+6T42eLdfR3QYzf02
         IUx45Is0c7gSFqOThRvj9nZ1RPzt0NtbKTMzFOs9EyoX2llaOFJuOe/nWgjNItNWjgrE
         KRh9nUigmr1RsMjIAkfhyKV4w3hxu9lyfMY5mFM6KsvkKVMO2ZKHUUuyLlqh1fz+6WX7
         Gnrg==
X-Forwarded-Encrypted: i=1; AJvYcCV1pG12D7E4EjTOmEF44INw3FtnBjtBUOOa7xfDKVbE0wFNmgRazNbg8Nj86/KimD3zuo+nAjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyOg0JhDgBuXkl7wGakYdxN9rhv4Ygu7KK75+0WCTLPs/eUj9G
	ZZf7Ji9PP58TRarBaxN9cRcmVuYpR+ympld3W4Xfq6m+/bccX9cIL0sX
X-Gm-Gg: ASbGnct1+1oUA7I1FT3Heri1CEfnKs9Dze5F2GN004B4JDPkl7dAcywS+sbIoOEhqL5
	dQxKJ5FfcUtLk5nJ1+kAZHoEHjJna3d1oWPv5El2k8hz8E0uCOsYX8V5YCEqqSDFS5B2IMi+ly3
	qgBnYkbzR6njUx50nA2jfNI2Rc7ZvyVxNqtVuyxUcUOB9HXp4aFi1mlQSI1matcwSffAOZOuhR5
	2ueNivJj86934k/yFXB7YZwOyvmst3rODZbi47mT/pMyqSxaSgRS8J4j8SxIoIjvYUH3gYTKfBl
	WE9DAKbw328PA1ywCQE1bNbjXY16l5Dtd3xMGYe4sLcep2icz5Oy4yuProHoTSMl39ryqrXI3j9
	0fvNYtuG+FwnSmmMr9yXAcHZ/IavqJK2JKGyMXh0dTY4XowfMW5+Lqs0mhvC8bw==
X-Google-Smtp-Source: AGHT+IGDemjaEgtgOCoyvvb4Rw0Ry/Drus7N9V4sjIQEOXHnP0EXYeoSrzatSrGttoH5W/PqCe+s8g==
X-Received: by 2002:a05:6000:4023:b0:3c9:3f46:70eb with SMTP id ffacd0b85a97d-3e7659f3b84mr3972483f8f.52.1757706854322;
        Fri, 12 Sep 2025 12:54:14 -0700 (PDT)
Received: from yanesskka.. (node-188-187-35-212.domolink.tula.net. [212.35.187.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017bfd14sm74650375e9.21.2025.09.12.12.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 12:54:13 -0700 (PDT)
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
Subject: [PATCH 6.1 15/15] selftests: net: genetlink: fix expectation for large family resolution
Date: Fri, 12 Sep 2025 22:53:38 +0300
Message-Id: <20250912195339.20635-16-yana2bsh@gmail.com>
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

Correctly expect standard genl_ctrl_resolve() to fail for large families
with many multicast groups. While kernel handles large families correctly,
libnl's resolution fails due to message fragmentation:

- Responses exceed single message size (~32KB)
- Kernel fragments across multiple messages
- genl_ctrl_resolve() only processes first fragment
- Returns ENOMSG instead of family ID

Custom my_genl_ctrl_resolve() handles fragmentation correctly via dump
mechanism. Change EXPECT_TRUE(no_family_id > 0) to EXPECT_TRUE(no_family_id < 0)
to match actual behavior.

Signed-off-by: Yana Bashlykova <yana2bsh@gmail.com>
---
 tools/testing/selftests/net/genetlink.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/genetlink.c b/tools/testing/selftests/net/genetlink.c
index a166f2c474b4..8a394991fe32 100644
--- a/tools/testing/selftests/net/genetlink.c
+++ b/tools/testing/selftests/net/genetlink.c
@@ -437,6 +437,7 @@ int validate_cb_ctrl(struct nl_msg *msg, void *arg)
 		return NL_OK;
 
 	case CTRL_CMD_GETPOLICY:
+		;
 		struct ctrl_policy *exp =
 			&data_ctrl->expected_policy->policy[elem];
 		if (attrs[CTRL_ATTR_FAMILY_ID]) {
@@ -1485,7 +1486,7 @@ TEST(genl_ctrl_policy)
  *
  * Verification:
  * 1. Custom resolver returns valid ID (> 0)
- * 2. Standard resolver either fails or succeeds (platform-dependent)
+ * 2. Standard resolver fails
  */
 
 TEST(resolve_large_family_id)
@@ -1500,7 +1501,7 @@ TEST(resolve_large_family_id)
 	/* Test standard resolver (may fail) */
 	no_family_id = genl_ctrl_resolve(socket_alloc_and_conn(),
 					 LARGE_GENL_FAMILY_NAME);
-	EXPECT_TRUE(no_family_id > 0);
+	EXPECT_TRUE(no_family_id < 0);
 }
 
 /**
-- 
2.34.1


