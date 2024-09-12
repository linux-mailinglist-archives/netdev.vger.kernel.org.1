Return-Path: <netdev+bounces-127892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54526976F5E
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065F21F24DF0
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 17:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D347D1C0DD1;
	Thu, 12 Sep 2024 17:13:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583BB1BF800
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161185; cv=none; b=lUNhveeOa6KZ4w5rU0d6L+FLrZHi8fkgb4SyCh4eGo5GyYFkpxWnSMqROZ1rVDk6jk4YzT76Lpz9nv2R461HycfH6wXLkaxUx7PZ6FH0I7/A/q7dIbsCty+4m4B+qfg2GhIJ+4oWe8avL6teCvcysXl3L4iwxsSAWYcLWsx0FN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161185; c=relaxed/simple;
	bh=g/fEul9GHQlgUz2TVCZwXjEba74PKMBgJz25HReQzrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PV3cms4a8uH62mUhlWnNhia65GR61MK/H4M3naw8GyL8sjZcfyD9hnMYwyJOx2wD16bSsYgCBcdXLQVMjfDjMGuKryxDe59aLDgxpuQnjHKxVeyTyQTHSPOMkdjY1mH6hhLmLpcjmxT0YWSGj0cp4Z7bxMyFPfxLGtLyABiMIVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-719232ade93so70337b3a.2
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726161183; x=1726765983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KazCW38vm/nFLvBuxWQxw+X70PR3pmlJGzWZIJ9gKhI=;
        b=lxHiAngVQU3qLwHqvpfLWF5nD4BSNf0kSMnJ2UZidwnZpJrsqEka5qzW+Y5BZ3/OAu
         V9fcME2SvIswdIOFczDgwhJ7O2TPY7KdYR3JV4mHjw8ZfhvwQIp1X9BCSG4U4umIlvZh
         UJidskjrfD1lPxvFC9CBGlVgJ/68aJodHmj0GHAqB0HWKv8dEKe4C7d+Msrpkn86ZsC3
         VbN1ClI2ht93hhUjVskqdfU0rvMsvQb4Gjgx+Wui4nCSKZS53FJI7ZDr3amon3y0iY4y
         +QWGKuvn/qE2c9WJlV5Gs6lEDb5+PB4lHGpCRITsBl2spe00/OuwNMeMVfJO7qqAOVny
         8z8A==
X-Gm-Message-State: AOJu0Yxzcgt4SHi0UGXcTlNkcGS6qtJIsSV44t8XUKRnThuhzBLHDxb3
	T3goI7rbY9qIzUdYUpELN9J/VtM8Z6t7Px4B4pgZWVQHl8KIZgrf3eRp
X-Google-Smtp-Source: AGHT+IFPcOMUPRabk7h0yAFp1VSutJ6xNk/UyTfpuZOscujZTm5f+wiWaTXxPOHCXL+/GkSBdgneaA==
X-Received: by 2002:a05:6a20:d81a:b0:1cf:21c7:2aff with SMTP id adf61e73a8af0-1cf75f1bfa2mr4776167637.23.1726161183534;
        Thu, 12 Sep 2024 10:13:03 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fddd1b6sm1996417a12.74.2024.09.12.10.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 10:13:03 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next 09/13] selftests: ncdevmem: Properly reset flow steering
Date: Thu, 12 Sep 2024 10:12:47 -0700
Message-ID: <20240912171251.937743-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912171251.937743-1-sdf@fomichev.me>
References: <20240912171251.937743-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntuple off/on might be not enough to do it on all NICs.
Add a bunch of shell crap to explicitly remove the rules.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index d82e550369c0..c5b4d9069a83 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -181,13 +181,12 @@ static void print_nonzero_bytes(void *ptr, size_t size)
 
 static int reset_flow_steering(void)
 {
-	int ret = 0;
-
-	ret = run_command("sudo ethtool -K %s ntuple off >&2", ifname);
-	if (ret)
-		return ret;
-
-	return run_command("sudo ethtool -K %s ntuple on >&2", ifname);
+	run_command("sudo ethtool -K %s ntuple off >&2", ifname);
+	run_command("sudo ethtool -K %s ntuple on >&2", ifname);
+	run_command(
+		"sudo ethtool -n %s | grep 'Filter:' | awk '{print $2}' | xargs -n1 ethtool -N %s delete >&2",
+		ifname, ifname);
+	return 0;
 }
 
 static int configure_headersplit(bool on)
-- 
2.46.0


