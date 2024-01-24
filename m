Return-Path: <netdev+bounces-65573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9098C83B0DF
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 19:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759C31C22C78
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 18:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3DF12AAC4;
	Wed, 24 Jan 2024 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="A6uOWj6U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C099D12A17E
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120395; cv=none; b=WrLtH8iJ8SEP2XpXRVGObgqW6w2H5+PbUO4mwkk0FrRLlXMtMDbuq3TzUC7jj4wdZvDBaD2c3E1OPXDvVGAqomiB9iKwZLhQb86LDqV/N9j5tgQkiJ8y3Jm/QMsxaAuKI0zY7bpPv0YKlepWa0dSeeKzwgULp5q1cS4zNdyytiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120395; c=relaxed/simple;
	bh=hNio0nD1Jw8dvozmdpvI20LoAzPAeMst7QlmZwbRnt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZPWva+3QihfD+BoxroqkGKlxKpxHAOCrJcnHH+h+dm+xyb8Jwqd4oTl6yk2M7vJSzEnrMcRwrplGm3VbBCCNtowX2uaIQ+BWCgtnagt7Q7MblhdX3EIZLVJUwFOZTpIQj1iQhTtr/Ds4KdhBlaE1XgEeG91FKBfwBO6uwYEy6i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=A6uOWj6U; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d780a392fdso10140175ad.3
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 10:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1706120393; x=1706725193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0aWr6I4AG0v1dbSwbiagBcAQfQgpKpYJbEuHRWpjLo=;
        b=A6uOWj6U5i0UoGPJvTGMcPcmXCZI6zkYgsoKdbAHiuiTvzfajgBqeN+jR5JR3bAM3c
         1eRkxhjW7eYIPECldiIMdbIHuRCdYq8jifwXitoNyolPSZScqpbx7Kw6JF1bArNMM2Nh
         gblauNJbQVz+taZ2UMHLRSxOvZ7i29bJ7sjQwJhiW3yABALVVKGPaMkoYbG9KiQNklHy
         8B7S9qkhZCnZX5DhODs6sMPgCx+0y/K+yInIwVTFjE+0U9hZFdWvlIDYrLzjhJpp0D4f
         KFU2CSls28+iTC4CrLvXaaRqytnWyzqrhCcxoNYAEUYqv4WCb/vywAAGSh62/03MnFIF
         g7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706120393; x=1706725193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0aWr6I4AG0v1dbSwbiagBcAQfQgpKpYJbEuHRWpjLo=;
        b=AIZIqhbn6BaacAF9PEJCj+txI4x+UO17aLoGyQ76MK+/I6nf5b1Q6rvW8g+x7wGhtE
         FTjaT+aFbwd2LfIUWqeH3bRaVCvxMMxdwZdWAvSy2f5tRzMjOf60QQQ+kfZUnjpwjZvW
         q2i0WA3oEKSNzdh+c4YhvfqciPuOyGrKA0IY6nkjEo+oFUobUwgQKtXm8Tb7JZX/PZJk
         EBHlq5v5vthaRTct5oz8u9CNJLasXKCobqXRAfX2CoLdls5IWNdU6gNo8snUi+LWS7BT
         /MK1Odz7aD2/XTLZL82FKuEGtlwTShCO2UeCF48u7grfX6ui5CpJ8AMMmzq80tPvwHGN
         Asbw==
X-Gm-Message-State: AOJu0YwaJfy8HnBgSJ5DNICynxZ48nUBEhZbx8fVbmZiBGy2H7OUIR/H
	t/1FbuhR2bx5hJJdbCQdlK72QO+Wjv3zBMx+Ur8muk+va5bIaaAIJ29Qnt/U2UnVPWzSWhFhl8y
	E4A==
X-Google-Smtp-Source: AGHT+IGFJE4RbbGr5WYcVqee/dmkBr8WSFOLXJPlnoWSCitf6cV2tXPONn5YpfcnHAoHwd2vVHCnXQ==
X-Received: by 2002:a17:903:1c5:b0:1d5:e4d6:1e07 with SMTP id e5-20020a17090301c500b001d5e4d61e07mr1570669plh.33.1706120392870;
        Wed, 24 Jan 2024 10:19:52 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id kd4-20020a17090313c400b001d74ce2ae23sm5577084plb.290.2024.01.24.10.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:19:52 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	shuah@kernel.org,
	kuba@kernel.org,
	vladimir.oltean@nxp.com,
	dcaratti@redhat.com,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kselftest@vger.kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v2 1/5] selftests: tc-testing: add missing netfilter config
Date: Wed, 24 Jan 2024 15:19:29 -0300
Message-Id: <20240124181933.75724-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240124181933.75724-1-pctammela@mojatatu.com>
References: <20240124181933.75724-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a default config + tc-testing config build, tdc will miss
all the netfilter related tests because it's missing:
   CONFIG_NETFILTER=y

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
index c60acba951c2..db176fe7d0c3 100644
--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -8,6 +8,7 @@ CONFIG_VETH=y
 #
 # Core Netfilter Configuration
 #
+CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_MARK=y
-- 
2.40.1


