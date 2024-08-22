Return-Path: <netdev+bounces-120929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0727895B389
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38EF71C22C07
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A6F185935;
	Thu, 22 Aug 2024 11:11:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D015F184559;
	Thu, 22 Aug 2024 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724325069; cv=none; b=nz5PbEn59b73/GJZ0rBXk2pA8x5aOIDP2NuLlDvD1hG49kXw775h6f8FlEmRPa/d3IxnIkizdo/gHIdVWfdIYKduVyojcjddWCTN2kQEMUL/G7QFgQ8dg6XhOKmKMBbsi7m3zKuwMLP2YnsEJ+N5ny6ALgk/VaYbYIzFJt3I2iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724325069; c=relaxed/simple;
	bh=AK/RADRaNEcV+njaXGREya+0xoBG1DLSBupzD9CJ2gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRPS8cbD7Ex3yqTxQuAH8kfSxEl6XIzuFhLzW5rrtYMSqdBVk0S+Vk/W/RbiAtThcGAx9auaDN39cpqktCko7c0nf/2ruyf/L4HiyfaK6dEhRLXeQkMiv7lA0UErT2GrrprVgSe7PHY5RNE3rVXI3NFesOVGiHIvaWC94ehg0gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bf006f37daso1138829a12.1;
        Thu, 22 Aug 2024 04:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724325066; x=1724929866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aJgFwXL8yYu3Ta7WXwhw8U8Fneee8uRNrJ2/htuey8=;
        b=uOAjmGxjgifcsrcSZoba99gSJqAb9Wuvf88kq3sssTNbtPDaDUXVriorg4j9kL59/R
         ITK9JRSug06U3Avqz/5pSEZxUerqnUtwez/NFMaPj3saH6suPXkZXmiLOkMX6wN4boXF
         cqbyrujbWuHCGxxWydqVBN0i+GjQRyP1f1I0UDsrxQMc363wIzfa9yow+8nIs4H8/34O
         A/lq23FztzUheoX0FpcecpZy1bAcxUoWmsfiDrta411Dq9YaW/5BYsW24N7cS4J5BF1U
         cprfFmXdoDPPEuZT7vnC8uHHnvdYVk6VG+3ACwa6W7lwtLP346BlY9wqVqVnPDcpwRHw
         oinQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMCErgeUHSNAZpH5XnrnqUQhvHj5N2z8EB7tu/YL4JxvSTQ+3hXvSjQIPr0G8i8vjMgb7UfVHr44babWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMFhTIjg4LFDimFTVUjUZmECQswzRhLon3H3rKy+1hIx2khF25
	KMHL3+F8INTcCi/9qll3OHbeFbYSu5FEluVv4Jydg8LFAVlfsXa/
X-Google-Smtp-Source: AGHT+IEXvb1JKvKR6a2ucE1kEQX9BJckT6JZiCBzT+sMEzhhyy/GkakP9jv5P8Jbo4D7pmyJqyrlEg==
X-Received: by 2002:a05:6402:4305:b0:5be:c92d:b893 with SMTP id 4fb4d7f45d1cf-5bf2c04bc84mr2309949a12.15.1724325065411;
        Thu, 22 Aug 2024 04:11:05 -0700 (PDT)
Received: from localhost (fwdproxy-lla-011.fbsv.net. [2a03:2880:30ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3ca017sm822339a12.24.2024.08.22.04.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 04:11:04 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aijay Adams <aijay@meta.com>
Subject: [PATCH net-next v3 2/2] net: netconsole: Populate dynamic entry even if netpoll fails
Date: Thu, 22 Aug 2024 04:10:48 -0700
Message-ID: <20240822111051.179850-3-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240822111051.179850-1-leitao@debian.org>
References: <20240822111051.179850-1-leitao@debian.org>
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
 drivers/net/netconsole.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 72384c1ecc5c..01cf33fa7503 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1258,11 +1258,18 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 		goto fail;
 
 	err = netpoll_setup(&nt->np);
-	if (err)
-		goto fail;
-
+	if (err) {
+		pr_err("Not enabling netconsole for %s%d. Netpoll setup failed\n",
+		       NETCONSOLE_PARAM_TARGET_PREFIX, cmdline_count);
+		if (!IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC))
+			/* only fail if dynamic reconfiguration is set,
+			 * otherwise, keep the target in the list, but disabled.
+			 */
+			goto fail;
+	} else {
+		nt->enabled = true;
+	}
 	populate_configfs_item(nt, cmdline_count);
-	nt->enabled = true;
 
 	return nt;
 
-- 
2.43.5


