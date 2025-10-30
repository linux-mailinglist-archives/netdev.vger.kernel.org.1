Return-Path: <netdev+bounces-234400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EFAC20152
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 13:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6DE9C34D183
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 12:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E203631062C;
	Thu, 30 Oct 2025 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYy0oVJR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DD934D93C
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828601; cv=none; b=RlDkf8qbX/I14AodLsHZ2QdSkCMbi2cNyT5eshLS5IfiMXBVwVDgpAPSwU/G9ArfRFHPmizUpsP7vc2c0HMJyVmhskKbQ8dQ2hDH/E9x1n5iFtBt4syGNzEVYS67eNXEPU0FPDB3y+45bvH75HvFWZbyyYzfbPwelObGiLg8Qdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828601; c=relaxed/simple;
	bh=dt55WpFBV5UxK0sxkMP8HWK7ldl8BF929rjZNtdvook=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KtUcbEdq4i8VHx9lJdcjEcwf14zu7dVajvIf7V/C7UuyrFVErANfHlYVuJWEuE3ER5qMsiQUkionXlgzdOGytws04Dii3x0/cFImhAa0MXpY8rC3nH6eBtmnVez0rJlMSGNL15b0vzpaLXlkYn3olkM0baoLU4iMa2cKQBhM4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYy0oVJR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29292eca5dbso12349985ad.0
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 05:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761828599; x=1762433399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS6Cz5sFcZlQoMyfcKzu9jrax3W9xaylmCamMrWFtlM=;
        b=aYy0oVJRC8bgt8V5YhF2s8j11R/nq7wA9cLqoR5HGKio7HZC32xR5fet9uRtKAPmgR
         eumdJ35fXTEmqWbH1atQCmqhKGVsuJBwo6bk4bD6IIcZUcYqoo8bQtGzQbOU77twpsb1
         YF7ycP3te/bKdaRC/2SFWQcwi41FlCt2VpGzqxQVN+K1RD/sRu21h2HuExGu1TvuRmiL
         epZP3Pvb0+es5yd4FKxBZ22/LNwqNGq5PWqPSzP+MmW6MLMobchktPXHwNt1O9RwgMFk
         I1jlggbiITDgIeIlELX/gsJVK2HZiEkd248HbhuFvDyrX24RQbgyFEJs1ByDOTlLguLw
         vcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761828599; x=1762433399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OS6Cz5sFcZlQoMyfcKzu9jrax3W9xaylmCamMrWFtlM=;
        b=Vd0DWJha2BQ8d/UilTApQHqHW9sevWwl7prVsfpPlRbD0E97jx1jCTUPKRTzL9H41m
         8Jjnxng/TlMT8BlInRiQ3jg1/slOUteEyhEwzAJF+J+/uSeiIS/7NCtYm65dDMKQ/h5o
         EzYVomFXQrzrLmfqRDCuUI0A3mSulyislYdsjBv2UF+5mylVheaNM+CK46nvLwUuDeX6
         vU/LSm6RHVD5KPsB3I7XTFzO5qeQnXoKQwvV0Ius8UHrqm7P4M89orI1RShDJ98W8N0X
         6dVtKkExDbMEsyyloCLRSt76+uiGHmp4VCygL/awLhb4Zfl/LTUeUYspsqnMo3JqveNK
         Vo7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGhhmYRiIub/vtpSZ5PGVPuYIfnbUmteVKaO3ISA5A1BEyWXXCWTLfQOvJJOGxBfo+G5gDqfo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzal3SlddkdfD5xkgrmBgQRNXyyagz6gHFJSwlXPK/zz+CjEPl9
	SVtpE7b59qOzIoZU3Ar3Qs6O/Ct6WNfO/tXUgoQSnilFKUIAchOrXCgA
X-Gm-Gg: ASbGncttUUhnGrM1hFH1xyG0DsCgqhePsTPm69DAq3A1HK94AfhxDUY1/Dp5HnqmL0M
	uFeuTF3YyancXtoHBNIBPIqaoZPF/iYLZxuluuF9sAaM9uJ+wEeFsTgGUn4S21ZItr7Ju15Nubu
	YRwhuj6gnJGyCqIfS3DSlhliIVxbzw6Q++i9rfUwKqtlGIcVh1OLRhP3E8m9YgrUux2KtspYSV2
	aczLgkIFH4e7y/aJX0whQ1V6A3sOR2zWh1oNAVuJPBfX6224G4jsyd+SJa4rmoeb9VYzmYwhb0u
	qml7PqfQ7Ay5mAp38Yoarrkjaem7QHJ+56J2np5MWmylazeG9OpLmR8OuK+7bInRifqaANoxmG5
	sooSzMxa/+SdJtU6EbFMPjuqIX0kp4sgrueJswGTmRya4QUYoMS1CZwpc0BELrhudJP3s5PXXWS
	iKIMnuRjF8/BYU
X-Google-Smtp-Source: AGHT+IG6hTxVI3+DO6LSdzXeMeydwi6lRwoviZ553goUTNLY4A7CJR1y+7vTP/C+iOn69/AQGpV76A==
X-Received: by 2002:a17:902:db09:b0:293:33b:a9b0 with SMTP id d9443c01a7336-294ee41d9a1mr32440235ad.32.1761828598978;
        Thu, 30 Oct 2025 05:49:58 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([123.124.147.27])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7127bf47a1sm16719123a12.10.2025.10.30.05.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:49:58 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: kory.maincent@bootlin.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	r772577952@gmail.com,
	sdf@fomichev.me,
	syzkaller@googlegroups.com,
	vladimir.oltean@nxp.com
Subject: [PATCH v3 1/1] net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()
Date: Thu, 30 Oct 2025 12:49:47 +0000
Message-Id: <20251030124947.34575-2-r772577952@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030124947.34575-1-r772577952@gmail.com>
References: <20251030111445.0fe0b313@kmaincent-XPS-13-7390>
 <20251030124947.34575-1-r772577952@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ethtool tsconfig Netlink path can trigger a null pointer
dereference. A call chain such as:

  tsconfig_prepare_data() ->
  dev_get_hwtstamp_phylib() ->
  vlan_hwtstamp_get() ->
  generic_hwtstamp_get_lower() ->
  generic_hwtstamp_ioctl_lower()

results in generic_hwtstamp_ioctl_lower() being called with
kernel_cfg->ifr as NULL.

The generic_hwtstamp_ioctl_lower() function does not expect a
NULL ifr and dereferences it, leading to a system crash.

Fix this by adding a NULL check for kernel_cfg->ifr in
generic_hwtstamp_get/set_lower(). If ifr is NULL, return
-EOPNOTSUPP to prevent the call to the legacy IOCTL helper.

Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
Closes: https://lore.kernel.org/lkml/cd6a7056-fa6d-43f8-b78a-f5e811247ba8@linux.dev/T/#mf5df538e21753e3045de98f25aa18d948be07df3
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
---
 net/core/dev_ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index ad54b12d4b4c..a32e1036f12a 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -474,6 +474,10 @@ int generic_hwtstamp_get_lower(struct net_device *dev,
 		return err;
 	}
 
+	/* Netlink path with unconverted lower driver */
+	if (!kernel_cfg->ifr)
+		return -EOPNOTSUPP;
+
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCGHWTSTAMP, kernel_cfg);
 }
@@ -498,6 +502,10 @@ int generic_hwtstamp_set_lower(struct net_device *dev,
 		return err;
 	}
 
+	/* Netlink path with unconverted lower driver */
+	if (!kernel_cfg->ifr)
+		return -EOPNOTSUPP;
+
 	/* Legacy path: unconverted lower driver */
 	return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cfg);
 }
-- 
2.34.1


