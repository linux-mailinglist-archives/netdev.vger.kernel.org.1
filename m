Return-Path: <netdev+bounces-240716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B95AFC785B2
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 11:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3E304ED1F0
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 10:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B118E34252A;
	Fri, 21 Nov 2025 09:59:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B5134214C
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719177; cv=none; b=rDMn44yYPqwbgsSWfFPKTLJgeN39vbqH1kN7pEpFnYarAYQTW+uCz8A2kXfWHRdMexI59cwsx3v2OhxT8mYeOKLcXBkKT3PqKuxzIs691CVY9i+D53EuECic51n84oRaEyHzzoqHzBD3mPQuzWxTHAdkAfKSJ6Yy0+bhkeLJUPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719177; c=relaxed/simple;
	bh=HHsmzhVeoof90NmVVOS0Bqgw+YdMs88RomC1IZl58xg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hC2UbiXgkoDS/By423vTMGVRmNThoJBeJ3pUzQGjKFA7cEyz7MdxgAMNkT/a5wF+w7ko2wagvvJjQbTgaWbn9xdplfMeEx6xiqG0FhHGu4p5LzZ+PSMwempTqkcKzWMSxo63zhk7AFknWA1PYXJ0RULuOXeQWYWm7yka4he5gGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3ec96ee3dabso1511498fac.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 01:59:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763719173; x=1764323973;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dojRujs9be/TnMeUOsyrcOSTjffwfchyaxGWH58nf/c=;
        b=Pm9h+UM2IX1kCZRJK8uYs5C/gtrhWXc4SO40xtXX284MNDvFpfX4VArPvgq0pbT4od
         5k88ASJqUWeW0Gua7z/S/qGij97bpzvmf4ROz2UAVXxhMndn4HLUligseu9r9+x8UbIk
         07BDUwA2AC8JlvczqQL7bGncLJ2pgt8ilZBROFdK8V4yPdSfxeB7wokIaXMF1D5yRr3w
         pThgOpVSToRxgR/07rwq72HbzMwzP+0jEKdc1zGJ8s4grQWhnqUEpb7uacevVcsYcuDz
         yJbKUqD3OqA7M2+UUSYjd4h4e4XQuhg4jeJObR1ZUHg4iKVc6fMcWLrMD4CuXSHhg48R
         eKog==
X-Forwarded-Encrypted: i=1; AJvYcCUy30Jf9McyxUJKeXUK/PprkhwUCRLRFAUfvQRVHMyNWB9gtUaW0CvY+qYdEPw3KZg+4qAuULk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjycMF0wtuMRZnZu/U1WuhOiIyK1JFURHJghnozLmDLpumtwjP
	WjJjYjF3ya11pDIpGADlozsrHNF92ep1BEercQJCSwWBwkfcKNKrrzPX
X-Gm-Gg: ASbGncvcpgn3Nze3HyORj3C6pCPmT22WoFKUydV7uGqyiDVq857kV079jBJFzahbosS
	jsKuDw+iC9zmbee8aT5hZLoIluegdGwKOlz80Ikx7uPvjHSb66tYtohoaVZuliVzoJXJf4uzOQi
	4aByyGzh0gmTrbksjIdOEP8kevAm1lQHrm0nh4KpCiY5s8LO+oR9OnUPuNV52KdLBi+l9Y3df1h
	lsRZKkaswVWY1BOaxbx9TY14xjZjEUoDiTpmtdTI5PuqI2FcMZSH0Mlymf/WmLrfXjnPt0U14Me
	TYtKT7rmnbu/Db0kYLUQ2cLC2tcYaTTJLNa6GMmOZzGclRUNykkutKoLrxGzZxzfZy748Y0LAV5
	vyrK2uUJ6hpDRQDQRQi77duZzwVUSXCSWZqEKfgMwE0c+qS1JkVxDuh3sjA2azwm+qOAnd8L2p5
	CeKjtfjwoDvb5z
X-Google-Smtp-Source: AGHT+IEmWMTd52wJm2+vR5LfqIEecZ5Mvv0Pw3l06fpbNbHelh8zWphqjwBuZeLN8JQFniDGSROkwg==
X-Received: by 2002:a05:6808:c165:b0:450:794a:6d08 with SMTP id 5614622812f47-45115b870f2mr486336b6e.49.1763719173494;
        Fri, 21 Nov 2025 01:59:33 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-450ffe2d3d1sm1481532b6e.3.2025.11.21.01.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 01:59:32 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 21 Nov 2025 01:59:23 -0800
Subject: [PATCH net-next] net: hyperv: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-hyperv_gxrings-v1-1-31293104953b@debian.org>
X-B4-Tracking: v=1; b=H4sIAPo3IGkC/x3MUQqDMAwG4KuE/9mCKRNLrzLGkBlrXqKkIh3i3
 Qf7DvBdqOIqFZkuuJxadTNk4o7wWScrEnRGJsQ+Dsycwvrdxc93aa5WauCYBknLND76ER1hd1m
 0/cMnTI5g0g687vsHJ6MOM2oAAAA=
X-Change-ID: 20251118-hyperv_gxrings-1285e8fa7407
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1971; i=leitao@debian.org;
 h=from:subject:message-id; bh=HHsmzhVeoof90NmVVOS0Bqgw+YdMs88RomC1IZl58xg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpIDgEo4LlMreBH8CqW3R+2WqEOzseEV2nvmqFo
 6LSHROv9uCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSA4BAAKCRA1o5Of/Hh3
 bQVCD/9f2TC3N8TYHjj7vhJb5Ow1BeNu3UI3KrvY7hD0vgMGQo09py6TMUCGy6wSdenlDn4n3Nn
 IDuifBybnQyrS9HLd3LtbHwAHis2jpTQpIjcuPYt4TbXJN7qiyHuXWjzAi+Ioy26FCH6xNuR8n+
 IDlIgDeX+SZxl8qAKPIFzJT05w+deSLWvnjKVnI9vy6WdI8fZVKPY/5+lGqttpuLvioDZjPqPpK
 u4eYBCQZqocKud1djMpV44matf4KeKzYPo4Na470GyXwyRQj0LjbtJCIjf3AU/iqtEEs3yjXtcc
 s7zDfmd2LRTsVzCG1dUOCf0kW/jNDnHyiTlv8s0vjSI9WQMpezvhekE9Kz20b6Yayn0rdW9EIMe
 PsMrsPAUlWS1zVkJza/sH8YX2PL5C8DlovOD1PfwtydU9d7x/CRE/o4smikSWoxAETm9+c6TaKe
 LByaNR4rl66OI7WMRSjzi0GVQrQUL/szcmIyeNcMPXzspDJimiGQAaNj/S0e65ptuMWRXrT197r
 Z7RxrkDyg8RENCYm9fSNE9eY+E3hUwzCu2BrcJ3Em6vduWmqkDex8MUrojHtezbJRfkUk91D56v
 5mFMgO8kdOwwSURLop9TaZhrf2UQs72ggmjMTNGI+9Crp76hL/UUCUe0zW2WTmUw8uRlTlGkRbF
 H0EpRaWg0NttieA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Convert the hyperv netvsc driver to use the new .get_rx_ring_count
ethtool operation instead of implementing .get_rxnfc solely for handling
ETHTOOL_GRXRINGS command. This simplifies the code by replacing the
switch statement with a direct return of the queue count.

The new callback provides the same functionality in a more direct way,
following the ongoing ethtool API modernization.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Note: This was compile-tested only.
---
 drivers/net/hyperv/netvsc_drv.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 39c892e46cb0..3d47d749ef9f 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1624,22 +1624,15 @@ netvsc_get_rxfh_fields(struct net_device *ndev,
 	return 0;
 }
 
-static int
-netvsc_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *info,
-		 u32 *rules)
+static u32 netvsc_get_rx_ring_count(struct net_device *dev)
 {
 	struct net_device_context *ndc = netdev_priv(dev);
 	struct netvsc_device *nvdev = rtnl_dereference(ndc->nvdev);
 
 	if (!nvdev)
-		return -ENODEV;
-
-	switch (info->cmd) {
-	case ETHTOOL_GRXRINGS:
-		info->data = nvdev->num_chn;
 		return 0;
-	}
-	return -EOPNOTSUPP;
+
+	return nvdev->num_chn;
 }
 
 static int
@@ -1969,7 +1962,7 @@ static const struct ethtool_ops ethtool_ops = {
 	.get_channels   = netvsc_get_channels,
 	.set_channels   = netvsc_set_channels,
 	.get_ts_info	= ethtool_op_get_ts_info,
-	.get_rxnfc	= netvsc_get_rxnfc,
+	.get_rx_ring_count = netvsc_get_rx_ring_count,
 	.get_rxfh_key_size = netvsc_get_rxfh_key_size,
 	.get_rxfh_indir_size = netvsc_rss_indir_size,
 	.get_rxfh	= netvsc_get_rxfh,

---
base-commit: e2c20036a8879476c88002730d8a27f4e3c32d4b
change-id: 20251118-hyperv_gxrings-1285e8fa7407

Best regards,
--  
Breno Leitao <leitao@debian.org>


