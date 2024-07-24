Return-Path: <netdev+bounces-112707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA3A93AAAA
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 03:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EF5AB22203
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 01:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC19C138;
	Wed, 24 Jul 2024 01:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtVlUxN5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E2FBE71;
	Wed, 24 Jul 2024 01:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721785632; cv=none; b=FPsLs1/1wHswQZlnD6GoiEPaTiDxbJaPTlz18/z0o7G77K6E+AecR+bKVfTlJmDnGeh8Trbh4+5vn2wWQ2BECXbsTV4OwaIWYPcNnnEQZVvA16EKp5DG9RxhG9BxibLetJp2QSYWjgkp2OD60+fyq46gqMYYDXGqzSRBAqMqJ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721785632; c=relaxed/simple;
	bh=jAi3voPlWolVP4YYB3fnxXWHT9iDk/r0DIOHX8TFBdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YQXMxHL4MhBIvrqwAczAIHtB6H2X9Ep9bTtLSF0P08UAor4FshqQLRnsNBCqOEqFeXipiYIEq8ie96ycw/EavWtXV/FRcYyj98C+D4zBB3x3JRUaoJxt5CGTW3SxsKq/cJzLGPJfLzE3uzlpy/LlBFBntNk73S/UUR+dE3An3dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtVlUxN5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d2b921c48so1971026b3a.1;
        Tue, 23 Jul 2024 18:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721785630; x=1722390430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHbtbS513JbptLsFw2uOg7AhwIYd2Buyfky5JBypwaI=;
        b=KtVlUxN5mMHskMkRtB256ECpxBrTNLedK3fEQ5pImFguhn3Rcsn7eueDy4mrcUiiaA
         RBNuN8IHrY52QBWAv2mggQpbuEfTBFB4sAwTI0cxxvQdmzBSd0AJGE3opV9SgYJgy/yg
         2sc4WWvBBvrzcRt+5dvzs+RsDILA2LDx1O+KHatc8nsS+cMKWMUo1+/RzXETHtHED0uB
         M2+1DesvdeciitJ8dE/LPQ8byDmNEWjTFd0RHq1il/tEFZ1wrHis/JT8k57QxGF0vSlL
         /QYZmhPHDz2QcwMOwBk4etF89E4W/njmu78pPWTFesAHZkz8Az8zKchRKa+2z9slmhqc
         /l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721785630; x=1722390430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHbtbS513JbptLsFw2uOg7AhwIYd2Buyfky5JBypwaI=;
        b=ng1s4LktkJH/6FBln6TemHyh0ssbBdNtDutP7QCNXMw5sIHk/pDnvkxlXtw3aZaDEq
         /bgAQRsu3D+dGAGo0Hr0gYIPcjQEOsWRC/+8DYBeDtzCVcebjzVN8sQ+W7k5BvqvYQBJ
         3pD9Tyf9Aykg/tE3HYnZidiEC2J1ZiVI/8fKK6BrXDLYMpEhd8iJaIrujg2iO6EwaOjn
         2wuAnwGCdEefyF0XXdy+ShzO1s3tKhWYh7rnelUGlayPIqlwcJSRCTDBuyYMh0ivzkWz
         DMZemWL/6o8MQ4ASjr506jMX0XvBBwi04jKl/ygLVYk9wAQnpBn0g5yRTYlWBgSHVwGh
         /MPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRPO12ugkpDUFieoMjil6YSvYsOGR91gAQl7L1dqoLipB8JOQNlqi5MVNWEgTCoo+Uz4CXG0eMfDj53darOxRvbk45y+/CydcPySwK
X-Gm-Message-State: AOJu0Yye41/j02LOycZTehm7M0uLhuXjyWGjnpNsXjXOasBtgqaevEZd
	LeEq+rlMLhGzHFOK7wC4JHTd8Bzbep5y3K3AyLUjaNYsdqGhX4zzvisyQspf
X-Google-Smtp-Source: AGHT+IG7cxyYe0Vou1ofkiw5iGJhZNQC7uqZLG8kBFIYJcdgDOwAl38ebUEeqwcIi+E+n24sO4Ar6g==
X-Received: by 2002:a05:6a20:6a2c:b0:1c4:214e:93fa with SMTP id adf61e73a8af0-1c4619e96a0mr1056935637.46.1721785629963;
        Tue, 23 Jul 2024 18:47:09 -0700 (PDT)
Received: from localhost.localdomain ([159.196.197.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73a5f5asm314564a91.8.2024.07.23.18.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 18:47:09 -0700 (PDT)
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/4] net-sysfs: check device is present when showing carrier
Date: Wed, 24 Jul 2024 11:46:50 +1000
Message-Id: <066463d84fa14d5f61247b95340fca12d4d3bf34.1721784184.git.jamie.bainbridge@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1721784184.git.jamie.bainbridge@gmail.com>
References: <cover.1721784184.git.jamie.bainbridge@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sysfs reader can race with a device reset or removal.

This was fixed for speed_show with commit 4224cfd7fb65 ("net-sysfs: add
check for netdevice being present to speed_show") so add the same check
to carrier_show.

Fixes: facd15dfd691 ("net: core: synchronize link-watch when carrier is queried")

Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
---
 net/core/net-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 0e2084ce7b7572bff458ed7e02358d9258c74628..7fabe5afa3012ecad6551e12f478b755952933b8 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -206,7 +206,7 @@ static ssize_t carrier_show(struct device *dev,
 	if (!rtnl_trylock())
 		return restart_syscall();
 
-	if (netif_running(netdev)) {
+	if (netif_running(netdev) && netif_device_present(netdev)) {
 		/* Synchronize carrier state with link watch,
 		 * see also rtnl_getlink().
 		 */
-- 
2.39.2


