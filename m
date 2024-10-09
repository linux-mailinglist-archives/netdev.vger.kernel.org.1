Return-Path: <netdev+bounces-133833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5464E9972CC
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4EAAB24A92
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08A91E1C02;
	Wed,  9 Oct 2024 17:13:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69C81E1A34
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493988; cv=none; b=Ibz8/nsVqUtP6lKvN/SfUgdDy8yeuEWVNeM7ZsE3vd4UsamAsCBVXxnZD30WngKGwLkXw7z/6fXAlajwBeyYYZ1qYvrwtIf+KYcSj7e2FWlZquuEo0fnV5S2KCh++q95uG4yy30MxMzddp7URDBiuSxSocD0gSn9YqJ8gvppD6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493988; c=relaxed/simple;
	bh=GO41+IUnSK9rCr/c3Dp+p71R2jCokjC9vwfeN3r9L6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+aFODTxGIgE7kcg49tShM32tD6by8fH3Ty/jXLDQD0gRIeGpnSH2jV4dQWkGpm0996iGYVw0vWaj8owVmhTQckD5QxIARxvI0KFqR+62GORIvlgAdQ0H8X3f3yM4oyfeD2iRMyWjDw4MZdZmLsh6WBDLuTV5sbKNKoxjQmhluY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e221a7e7baso78599a91.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 10:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728493986; x=1729098786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGqk/HCE3+RRutk9vLeoLePiyZrKtIG6x7VUeS+mmoA=;
        b=JamnRe69LvK2LwwtFpalJPlwqawXpAf1wB/j4zUfQMdQ0qgwHgfBkZ//rh+HOp8xKl
         vMbtfwoPvnsqNKmwjJ8qd2gXYaWAAMFoAWFrwSuBxwnNwvS2wqDmY19UHQeVpojakLMM
         AkCjmLk5ygylBU/tm3AhcxWB6Idj7ldZZdvySHdk9uNvGZBKSQKQS+3lFyZVotoYOI6Q
         DomeoKj7u+47PFzDvksrxxskQlPt+yYcxCbe4XJ6w5cxhyFac9XGKPpVbkSzXA6TwNOq
         2Z3BgppHP+25yXkcAvzJ486jTWB+AVFe0v4JrSpr6qRhYmu1/sbZ8DvO2+tHBFahonCd
         +IWw==
X-Gm-Message-State: AOJu0YxGPd1ZKpeyGCxHFfNUA8hFhhmlMWNsN8OC+SvkVo33V5f2OAk1
	ymNUxRCF/lEA7D8lz5rHQTdG/QqzyUw8fqLQVjD4xzSXaiz+rE5BrwWT
X-Google-Smtp-Source: AGHT+IFf94W2RvDDIxyh5y9A1320vYbrVEv4ktJn/5p3NmVa7t+az1gF2MbnhBeBuriWuxYpCHbAxQ==
X-Received: by 2002:a17:90a:bc92:b0:2e2:8d82:df13 with SMTP id 98e67ed59e1d1-2e2a21e6d03mr3544373a91.8.1728493985668;
        Wed, 09 Oct 2024 10:13:05 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2a5ca9db5sm1942726a91.47.2024.10.09.10.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 10:13:05 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v3 10/12] selftests: ncdevmem: Run selftest when none of the -s or -c has been provided
Date: Wed,  9 Oct 2024 10:12:50 -0700
Message-ID: <20241009171252.2328284-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241009171252.2328284-1-sdf@fomichev.me>
References: <20241009171252.2328284-1-sdf@fomichev.me>
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
 tools/testing/selftests/net/ncdevmem.c | 42 ++++++++++++++++++++------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 90aacfb3433f..3a456c058241 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -64,7 +64,7 @@ static char *client_ip;
 static char *port;
 static size_t do_validation;
 static int start_queue = -1;
-static int num_queues = 1;
+static int num_queues = -1;
 static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
@@ -706,19 +706,31 @@ int main(int argc, char *argv[])
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
 
-	if (start_queue < 0) {
-		start_queue = rxq_num(ifindex) - 1;
+	if (!server_ip && !client_ip) {
+		if (start_queue < 0 && num_queues < 0) {
+			num_queues = rxq_num(ifindex);
+			if (num_queues < 0)
+				error(1, 0, "couldn't detect number of queues\n");
+			/* make sure can bind to multiple queues */
+			start_queues = num_queues / 2;
+			num_queues /= 2;
+		}
+
+		if (start_queue < 0 || num_queues < 0)
+			error(1, 0, "Both -t and -q are requred\n");
+
+		run_devmem_tests();
+		return 0;
+	}
+
+	if (start_queue < 0 && num_queues < 0) {
+		num_queues = 1;
+		start_queue = rxq_num(ifindex) - num_queues;
 
 		if (start_queue < 0)
 			error(1, 0, "couldn't detect number of queues\n");
@@ -729,7 +741,17 @@ int main(int argc, char *argv[])
 	for (; optind < argc; optind++)
 		fprintf(stderr, "extra arguments: %s\n", argv[optind]);
 
-	run_devmem_tests();
+	if (start_queue < 0)
+		error(1, 0, "Missing -t argument\n");
+
+	if (num_queues < 0)
+		error(1, 0, "Missing -q argument\n");
+
+	if (!server_ip)
+		error(1, 0, "Missing -s argument\n");
+
+	if (!port)
+		error(1, 0, "Missing -p argument\n");
 
 	mem = provider->alloc(getpagesize() * NUM_PAGES);
 	ret = is_server ? do_server(mem) : 1;
-- 
2.47.0


