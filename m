Return-Path: <netdev+bounces-130495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A3C98AAF6
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9B128A900
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E993B19882F;
	Mon, 30 Sep 2024 17:18:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B65B197A98
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716692; cv=none; b=fJvJTLHPLPKofKsc+qSmquwWmDtLkOcyWyDARM2Eg1zBIuA6RsKkX5OvdJJB7gnKkYzREG5R/6m5544zWVczzCHL11gJkaXp3GZZy5SzlhG24Lj9OqPRxFrCFZkAFAc18tVAi5g90mG8oz5wqtFkf+VHyTGlovy+lvjqjCWkKYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716692; c=relaxed/simple;
	bh=Wi7OcMjqw1UdGhUi1KtWoiJD1zmWDZd3H1A91Bd+TwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CU0MmCBu9MzOfyFx440P+/YlIeWNBaGf9KmpQx0TxioELfWZ6vlx2tmMUq2Ow4C/TD/VxpJ9AAdgaAg/OlpyJErVn8Azp9riz12T3PxEgMCV+ovNflp1DJZf4PHall0DrNJYwCYKkUFvO+U7l2P7WjiKV+1KTFAaPXslTRVj8qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b93887decso9139295ad.3
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 10:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727716690; x=1728321490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TztfDobfhyf+myTs/dQ/tIdBGEBrp1wqtHoLxjzH6+M=;
        b=k0PuAHxZTty82JeG0/Clw4iXJV70Wa9938LYTVFhTEwlEGWS7CKEumwDwVC6vUaE/H
         m80EtVKWEAZGWqOztJyC0b0nphB8XwyQF61MUVoWgNFxHdcQyzrlA28xwINWsmYof3c3
         aVOunMzX7Vk8/fAXlHqTTbMY8LgwPEqLb1KCzCT2nvxawoIGxueltL4KLPAiw1xH4QGC
         aO9gzzDE6Y0xOUnEdKJBh0MfwqLRhbSyFa89B6ejrydE51iXzBlctppKiX1/RKOVO3Rq
         ubBXaodCB+3+HtVsBY1mVeryndhV1UtPGRCueCf2UdAB4xq7UEpZh2EjdRnKfy92TY9k
         XVig==
X-Gm-Message-State: AOJu0YzihNBoQ+Whtjkc23qqqr4MWqC1i+8++hXz5n087OyQkB7YPkIu
	4RWc09ONp4s8Fm1X3UHy7psWzgikzP7kHgEsw7NaUfcpiZj82wugsIkb
X-Google-Smtp-Source: AGHT+IGVGHG3YqfeFmm/NWzjeAeekPClNgfHoNy9x7TZNuTGpaSHa2inXKp3Vo3tawdW8BLFXtRxdA==
X-Received: by 2002:a17:903:2452:b0:20b:7210:5859 with SMTP id d9443c01a7336-20b72105b5emr92229585ad.38.1727716690427;
        Mon, 30 Sep 2024 10:18:10 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e4e627sm56807735ad.227.2024.09.30.10.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:18:10 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v2 10/12] selftests: ncdevmem: Run selftest when none of the -s or -c has been provided
Date: Mon, 30 Sep 2024 10:17:51 -0700
Message-ID: <20240930171753.2572922-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240930171753.2572922-1-sdf@fomichev.me>
References: <20240930171753.2572922-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be used as a 'probe' mode in the selftest to check whether
the device supports the devmem or not. Use hard-coded queue layout
(two last queues) and prevent user from passing custom -q and/or -t.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 27 +++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 900a661a61af..9b0a81b12eac 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -688,17 +688,26 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (!server_ip)
-		error(1, 0, "Missing -s argument\n");
-
-	if (!port)
-		error(1, 0, "Missing -p argument\n");
-
 	if (!ifname)
 		error(1, 0, "Missing -f argument\n");
 
 	ifindex = if_nametoindex(ifname);
 
+	if (!server_ip && !client_ip) {
+		if (start_queue != -1)
+			error(1, 0, "don't support custom start queue for probing\n");
+		if (num_queues != 1)
+			error(1, 0, "don't support custom number of queues for probing\n");
+
+		start_queue = rxq_num(ifindex) - 2;
+		if (start_queue < 0)
+			error(1, 0, "couldn't detect number of queues\n");
+		num_queues = 2; /* make sure can bind to multiple queues */
+
+		run_devmem_tests();
+		return 0;
+	}
+
 	if (start_queue < 0) {
 		start_queue = rxq_num(ifindex) - 1;
 
@@ -711,7 +720,11 @@ int main(int argc, char *argv[])
 	for (; optind < argc; optind++)
 		fprintf(stderr, "extra arguments: %s\n", argv[optind]);
 
-	run_devmem_tests();
+	if (!server_ip)
+		error(1, 0, "Missing -s argument\n");
+
+	if (!port)
+		error(1, 0, "Missing -p argument\n");
 
 	mem = provider->alloc(getpagesize() * NUM_PAGES);
 	ret = is_server ? do_server(mem) : 1;
-- 
2.46.0


