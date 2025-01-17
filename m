Return-Path: <netdev+bounces-159273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D649A14F64
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813B616513B
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C111FECA1;
	Fri, 17 Jan 2025 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avn3ujfB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E81C1FCFD9;
	Fri, 17 Jan 2025 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117730; cv=none; b=NqrVUb7XoN7n0wg7DrGnR/yy/qT+C8Cn2AM1ZDlB5XovHEG6YaL+XD6iw2ZdfkaVSwPT02YSAom17y7D4byR6sMZfNM183eqvNphcA0DRiTpUpgaLIJPyfMluIkKf7z+yPJ5R0n127UNSWQKWjgPKWmTUBRu12DNx6Ul3RvnHGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117730; c=relaxed/simple;
	bh=ZqCFhOu/tTTH9ZxDQOVzMJUyQyVuoJmi5QbJvs119ws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r3Vov+aRHiqcMo/nZjaSjb9X8QK9fN3SC7rNd4cYsb7NlPsQmDZ8chCtZTKm9dYwm7Da28Vb882A8t2P0B8DaoYQdH7lOHITUFSVVnfSj2ku69ewiWI8cqAWInekcqbCJO18qo56/Ao5EuxNtvZmpB9d2lkW4rlAhtUO3snwYt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avn3ujfB; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5401be44b58so2136062e87.0;
        Fri, 17 Jan 2025 04:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737117724; x=1737722524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d4guqXWrfGz1k4aqLiDd4/tIf3reeGhnY1IaXFSM40U=;
        b=avn3ujfBST22EviraIlVye8e7BBIUp5Ls5/ld+mofJKJQBzX31FA/qlyWOlC3V0b3g
         m3h2vUXEJDUF0ZsH2ffKX6KKTDJCFspDJ6NfXlzCgS+bZWnkplOWVyh8Rcl3BccUTg8L
         l1x5hSpH980Ree4z0Gyqptxgbd4dV+v3D3u/y2QZDItZ1jygERAGMD9MdWK1mQ0n2O3R
         MDtVOZocu3Rzs2U8SDWr0p+T/ew+QuYt/7WWUiEXSHRzaQpYbGc5/YG9YLs4AC5zmykn
         rr82RSG2siooH1Of/1riOydGgMMSZGB4EWE0DZqejXO9WSBlO6P5YqyZ4joOJJYOTkwK
         iJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737117724; x=1737722524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4guqXWrfGz1k4aqLiDd4/tIf3reeGhnY1IaXFSM40U=;
        b=wg2GIKd15b6fZvozuW3IcWJS16oMB8A4BtvJInlMQX00YCRIpwv9P7/DhSthtt4L16
         62W7iB/ffAausP8sP/fg0ydtf74UZm7O8fQuQF4TB03vRVtFg/gUrzeXuv/jRhk6iRaY
         UZ6XcsOgPwXrTZnBxGxWGM89A7g2ioXJU/e4Clgpxju1gM7DZzVMK4wB7UO9kfxRWGMa
         gbH9lq8mjevkfIEAdyxLJWuKXUehSV6yomUDGOXpwJnm0QQEefzAShsJyjZE1XsqHhJo
         PdiqTu06xyT2Zttjdim2dN+HGMqJzqRD7BM8KdSrsQm22PcYiyOzGJt7evF+tDcBVar6
         BvHA==
X-Forwarded-Encrypted: i=1; AJvYcCVhdWMkMffksbJSJxWuN8S6BFbGg9NxFvtbOIpa0aWQe7LniEoAqmCs0cA+MPP3wPbJ0GGItx/1d7PFTGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyysNYqY2z4m8DH4CYC1SDj4sHZpnZuJocQfLDpzRO5yUZ0ZMAi
	S5Eo8C5Yz13VhrqxYD/4pJ13IGfvNGbrGtfeVWY+w2Rn8WfSP62hoKKgNsTImx8aZw==
X-Gm-Gg: ASbGncvqGRhgEJbh9w3/7knovETmLSRFrD7JKGGLQFyNl5hFPn0Nw/qnCJNt+0XiO3H
	73rtLFsEa4bGlC3NhPZmWdIWwEfjV/UGZXl6FOPfVe+cDkpp5OiL5ip7qGbSXxlWpE0qxEse0wF
	IyOzrSQfGL3J9Ln/Lg+33O9rdailZIZkxmp4LLqndFalj1FxWFTfOZlkko6mCCXLe0EOYRNh+kI
	vRW+uKW2DD+7FrEEdqKvUpWuqsWZ+mdsyGWOT+XaieH6aicg9lP3vdF
X-Google-Smtp-Source: AGHT+IFkcVJfS6D5aV9blLvQNJct0VTykT6dLoEojkFRB8MuvkYkTr6rSZm2MkXIqxYN0sm9avGvUQ==
X-Received: by 2002:a05:651c:169c:b0:2ff:d7cf:a6cb with SMTP id 38308e7fff4ca-3072ca69268mr7441651fa.11.1737117724216;
        Fri, 17 Jan 2025 04:42:04 -0800 (PST)
Received: from X220-Tablet.. ([83.217.203.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3072a330cb8sm4148241fa.22.2025.01.17.04.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:42:02 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Denis Kirjanov <kirjanov@gmail.com>
Subject: [PATCH net-next] sysctl net: Remove macro checks for CONFIG_SYSCTL
Date: Fri, 17 Jan 2025 15:41:36 +0300
Message-ID: <20250117124136.16810-1-kirjanov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since dccp and llc makefiles already check sysctl code
compilation witn xxx-$(CONFIG_SYSCTL)
we can drop the checks

Signed-off-by: Denis Kirjanov <kirjanov@gmail.com>
---
 net/dccp/sysctl.c        | 4 ----
 net/llc/sysctl_net_llc.c | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/net/dccp/sysctl.c b/net/dccp/sysctl.c
index 3fc474d6e57d..b15845fd6300 100644
--- a/net/dccp/sysctl.c
+++ b/net/dccp/sysctl.c
@@ -11,10 +11,6 @@
 #include "dccp.h"
 #include "feat.h"
 
-#ifndef CONFIG_SYSCTL
-#error This file should not be compiled without CONFIG_SYSCTL defined
-#endif
-
 /* Boundary values */
 static int		u8_max   = 0xFF;
 static unsigned long	seqw_min = DCCPF_SEQ_WMIN,
diff --git a/net/llc/sysctl_net_llc.c b/net/llc/sysctl_net_llc.c
index 72e101135f8c..c8d88e2508fc 100644
--- a/net/llc/sysctl_net_llc.c
+++ b/net/llc/sysctl_net_llc.c
@@ -11,10 +11,6 @@
 #include <net/net_namespace.h>
 #include <net/llc.h>
 
-#ifndef CONFIG_SYSCTL
-#error This file should not be compiled without CONFIG_SYSCTL defined
-#endif
-
 static struct ctl_table llc2_timeout_table[] = {
 	{
 		.procname	= "ack",
-- 
2.43.0


