Return-Path: <netdev+bounces-117245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE1894D484
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 18:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B55D281FA0
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 16:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9E31990C7;
	Fri,  9 Aug 2024 16:20:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395F81990AD;
	Fri,  9 Aug 2024 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723220439; cv=none; b=AI56W1VPvDoXVziC85RxkH5kLktQ2f0rIIk1p+bbETRrAHZQFSk0e+CCdQHZN1fX1RvZ+L8hkb5BqcuVwGwZ2T13MspTT9gDxbNb3LuJcSyBiqd11BYNJo76vUmYXf/opHOu8Fxs3U3AAIo/YnspRgIKmriSoFji61oUhmi6TjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723220439; c=relaxed/simple;
	bh=OGoeUYjpEw64DR44DAgucxsJpW7HAfIIurJziUbEFic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMgMRiclFq0lVppucTFBWpzOaAnFXr83JjgbXwXuB4uGejSbqWnDqnwxlNKyAKZWPV2mZI1s7IDSY6kQStyZU4QJetczCJlaGwhzNluGMRdUm3s6TaDJrHMz+PrwTEwPJioM+SCO+NcESla//x6P+bPmQbf/dLglhI1wOzk3Itw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa63so2496151a12.0;
        Fri, 09 Aug 2024 09:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723220435; x=1723825235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9vCCDvz+Mfg5UhCzo9mkGnpNPDGEv6vhkWTt2JAVA0=;
        b=VYOA5+zLYLWQeYfevS5cVL/MGDtdLeokBZpN2ZoTV7vy0b3nmDX1peDA688qm6OC/5
         qm4FQbbi49ZwXvYLHt92//N63OduyblWKF/czkZtntCXx/A3EiC+rkqRhbYH4SdW/ifo
         oiId9H5cAlu5yhYLFon/8MOsn0UPLWm/1W56d9NrGYKj/60RQC8HR8os0OJxMGsZ71ej
         gS4VlN9UPmbBcfysfB+5AA6JKYYAl+p3R7nzYHW1QGtzIaHQOaVNAHGEKNymSCkSc5kP
         dYEermM9jrnWmGOYg/NRtTOebdJEKQqo5KZPT0fpJ2z3q5W9UwobAm8JbNPYvgEdAiUh
         J6OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr24EpD2g8Z0bn8FDBnfKh5Hr0eMprYw0oxhlQr90Kz+y9fz2d84aEWWZCwATbWINMBB2yoSmSJuRanCSrj5ID7rM9OkzaNSZUIklXFnlQqqgFoLCTrVjLDaMkgVC4KRJvQmKA
X-Gm-Message-State: AOJu0YwssaQ1b2E93XcD17UWJoSlBz7tJhKDwk/1pFZhNok85nCF8LH4
	wEU6cDZN7h074NodwwjVVfPb+ZIX0R0oaht8+S5wZPR3kEPqRAkS
X-Google-Smtp-Source: AGHT+IFUKmbFLDgAP8L8vasHziH7Q+3Yk7kei1zBDPrxJxWPEdnu9/uxzYSxdQ5E2S9aFKGrGqF4/Q==
X-Received: by 2002:a05:6402:11d2:b0:578:60a6:7c69 with SMTP id 4fb4d7f45d1cf-5bd0a69364emr1259842a12.30.1723220435108;
        Fri, 09 Aug 2024 09:20:35 -0700 (PDT)
Received: from localhost (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2e5e6f6sm1631543a12.89.2024.08.09.09.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:20:34 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aijay Adams <aijay@meta.com>
Subject: [PATCH net-next] net: netconsole: Populate dynamic entry even if netpoll fails
Date: Fri,  9 Aug 2024 09:19:33 -0700
Message-ID: <20240809161935.3129104-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, netconsole discards targets that fail during initialization,
causing two issues:

1) Inconsistency between target list and configfs entries
  * user pass cmdline0, cmdline1. If cmdline0 fails, then cmdline1
    becomes cmdline0 in configfs.

2) Inability to manage failed targets from userspace
  * If user pass a target that fails with netpoll (interface not loaded at
    netcons initialization time, such as interface is a module), then
    the target will not exist in the configfs, so, user cannot re-enable
    or modify it from userspace.

Failed targets are now added to the target list and configfs, but
remain disabled until manually enabled or reconfigured. This change does
not change the behaviour if CONFIG_NETCONSOLE_DYNAMIC is not set.

CC: Aijay Adams <aijay@meta.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 43c29b15adbf..41a61fa88c32 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1258,11 +1258,15 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 		goto fail;
 
 	err = netpoll_setup(&nt->np);
-	if (err)
+	if (!err)
+		nt->enabled = true;
+	else if (!IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC))
+		/* only fail if dynamic reconfiguration is set,
+		 * otherwise, keep the target in the list, but disabled.
+		 */
 		goto fail;
 
 	populate_configfs_item(nt, cmdline_count);
-	nt->enabled = true;
 
 	return nt;
 
@@ -1304,8 +1308,6 @@ static int __init init_netconsole(void)
 		while ((target_config = strsep(&input, ";"))) {
 			nt = alloc_param_target(target_config, count);
 			if (IS_ERR(nt)) {
-				if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC))
-					continue;
 				err = PTR_ERR(nt);
 				goto fail;
 			}
-- 
2.43.5


