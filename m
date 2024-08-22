Return-Path: <netdev+bounces-121165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F4095C015
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 23:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3901F247E0
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 21:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83FB1D0DE2;
	Thu, 22 Aug 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBhfFNMJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007BAA933;
	Thu, 22 Aug 2024 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724361032; cv=none; b=GSMEKRUMlQrDgdQYmPjLGVyYs6wt3AcBmNH4zFlWIPjqJ5my8Z/AGzM3XQgPkzJBOeQoQzx6hr8+Wu8bLmISbNosSwquwAQCPpY290taV1uvpMY9JTMQ7xXbOzLDHFT1h264OoCsi5HEHeA8kNtVgXeHrApUWDfmSGMBTkb8oK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724361032; c=relaxed/simple;
	bh=r06AXZGbjR2lnzyRwYDix3F99b52eEoIvUYsvtXMWyA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Sq4qVXg4oRL7iPjD8kHYiSSiB1ubrskSP9Kq9x/sT4iuyT7c2SEbq373v78fbsHg5I2ECnbZ/J5lNXH9EYQjgWEMpmTIR/DXCCQmdHAXC/S/vimW2RBYtJQD7HU2Zqo+BPHsoSyQYV/AQyw2hY7Nr5ueBBij5aTeD/NTWGRbDnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBhfFNMJ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5becd359800so1620434a12.0;
        Thu, 22 Aug 2024 14:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724361029; x=1724965829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UKG7y3+TWKlqo/GtL3gWRJVbZ7YjZ1zLepbMo7yV13c=;
        b=nBhfFNMJYtUhwlfOFr9noo/0wFgNJvrIoJ1DIULbnzWPhsDO47oGuigrxHAN+IkFWw
         nQc8y6sbciTyd0iLhGN4Hyn/Ellddw2r6MFIEY5jKaNhvs14LzvR0r6X2Vn3+kRMmt4t
         4jFGoxox6V+5mauuXrPg7GDg2u10yzPEIS3vB2XNL+GTpI8onr+hllRz2y1F4z0wVy+2
         1VUau5MjmJRn9tonxTbOe+Vw3o10Iv+SkqcRZmzDob13Btxc1Hbx8WrHGfsxf0TX+ywi
         Vt5jmarVpEuPc7xwYoXSsh9ViFm64H4km3BvX9i3q6gRRD2hJZUo/bN3AfFhfq/WiUQ4
         +AWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724361029; x=1724965829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKG7y3+TWKlqo/GtL3gWRJVbZ7YjZ1zLepbMo7yV13c=;
        b=cqCMG58i6MX+4f+x3sM0nJhJHcnJrbjG95GE1AFLrPRKmtanpVoOoVwFpdAyQfa/qh
         rDsY5+BTClyIYnxEpMOEoyVkuqxqXoW39Ef8unhJP1ZrHDyL2AV2FVsLoIKs3ZCAxXFp
         wJna3y3Utek7FQowhwjTIT65Hl9IH5b0hH+m6QhNbI0m+zKbm3QoJiqSm3Qd15NJJnS4
         L2BA/34IA1K+Xg0BtfQ6stbucxUcmzTGYRUot+SBJfV2aerVRKraZngvDDdsDHwY7zGz
         3vZziEPLFl71cQznXccd6CnJOdsBX3CtPt85lBQHWN4BKfr0SNwYChrUptviF0dIlgSj
         hVvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3v6qNUFxZqvBk3kMtaoeNqYh+nMA/UcivHJ9AcQws67I3iKlYie5x3REgGE8ueH62sHDvgsGS57cRvDw=@vger.kernel.org, AJvYcCU9G8xczT/2HDklNq9Qos6FoHnXsJSbPca7btwHxDKxFqkHrZayovIEYjNvhs171SsTl4APp4/Y@vger.kernel.org
X-Gm-Message-State: AOJu0YySuUFk+BtgsKJpKGjzyKWCCJHelHjUVWdnfqZq/6mFKV+zqwoY
	GwAuOv77JriBQHkf5sBWiwu7px4Yd8Cixpwjce64keSK+SNcgqZe
X-Google-Smtp-Source: AGHT+IHijaSPCIR3E01r3fs5QqT+uN0jaBThFV5yQt4sEVQEbdSz1/CzkAL9ZUKOwnH3W16tuN6taw==
X-Received: by 2002:a17:907:9488:b0:a86:7a23:1284 with SMTP id a640c23a62f3a-a867a23272emr499241166b.48.1724361029166;
        Thu, 22 Aug 2024 14:10:29 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f484e05sm164262266b.167.2024.08.22.14.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 14:10:28 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Shahed Shaikh <shshaikh@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] qlcnic: make read-only const array key static
Date: Thu, 22 Aug 2024 22:10:28 +0100
Message-Id: <20240822211028.643682-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the const read-only array key on the stack at
run time, instead make it static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
index bcef8ab715bf..5a91e9f9c408 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
@@ -2045,9 +2045,11 @@ int qlcnic_83xx_config_rss(struct qlcnic_adapter *adapter, int enable)
 	int err;
 	u32 word;
 	struct qlcnic_cmd_args cmd;
-	const u64 key[] = { 0xbeac01fa6a42b73bULL, 0x8030f20c77cb2da3ULL,
-			    0xae7b30b4d0ca2bcbULL, 0x43a38fb04167253dULL,
-			    0x255b0ec26d5a56daULL };
+	static const u64 key[] = {
+		0xbeac01fa6a42b73bULL, 0x8030f20c77cb2da3ULL,
+		0xae7b30b4d0ca2bcbULL, 0x43a38fb04167253dULL,
+		0x255b0ec26d5a56daULL
+	};
 
 	err = qlcnic_alloc_mbx_args(&cmd, adapter, QLCNIC_CMD_CONFIGURE_RSS);
 	if (err)
-- 
2.39.2


