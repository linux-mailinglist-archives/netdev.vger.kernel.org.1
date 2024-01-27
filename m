Return-Path: <netdev+bounces-66363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D2183EAD8
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 05:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 127CFB22932
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 04:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF90213AE3;
	Sat, 27 Jan 2024 04:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="YLf//VPx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2066C134BC
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 04:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706328251; cv=none; b=B6I3JvR4nbjkkfSW3T52O/il4zaG+7XW7L7zh9i5t0rI2MIA3LzDLhes8bVTaTMps9mvIgD5ZyjAuekpoK+THGblI54tlpz5qK7RuDNO+0wlE+zudbCGG2CdV9pRZ8cotfaOkZ170AIBkMjpOY3hGg+aaDHLdIVDQoUmXov5lKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706328251; c=relaxed/simple;
	bh=cLYPdbxUBtT+KaYS866D/Xt5LNCttNpkpzpgDQmmdw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mmMuMQfU1ILJ+zTE9HAwijde00Ax9t8jm2kS0u28gZ1yzGk735bgDtv3O+n6wvr3f+5Ew0eqGMLV4qFXeRC1zRLPms1bl6FmFPu2zak7PGTurpJfQJJTT3dcsIWCvoViMgAjcSm7ICjVUaNR0FE0niE6AHytiO0bQ9cEz/sZzK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=YLf//VPx; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-595d24ad466so781291eaf.0
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 20:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1706328249; x=1706933049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HipVj3jFa++EzsAXPaItSnaAVQdrvEwwkSfJxQxVOsU=;
        b=YLf//VPxZVFVBQn7YSiJKwhhfd2xSgLcy2454lAqryI7PWk4OJHpY5Mop3APlJRJBT
         IP/+fz3tKWfLdXKxevFa3l0OcOYvX1FlYQmj4yUN2fKekkgbUuMKsnpMDfMCTc3vTsIf
         EWL7zO54I2epv9hK7oq1tNHHtxdtaxOI3dN9xUMOoifxx3s4/b/k1AXyhz+uvJIEvAg7
         x7qZLmQHSA9+qIHQs+tFhVizKTyGUsEfoQ3AJu1fS7o5XZsa7+vP3EdNYaLOp7iGJdES
         rRiiSQy3X22zjfEkPrqmZbSRoXkAQjIkDf2ypqpwawRYrsrPIzTPNpH5cyFjaOa6eI2L
         alGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706328249; x=1706933049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HipVj3jFa++EzsAXPaItSnaAVQdrvEwwkSfJxQxVOsU=;
        b=B0x0TiYyg+1RoEjgXSzvKR0BYSv6IAQfwgtIVobNFSduhGpP8zrZtKhBPkCLPKa+5W
         rymzUWAZ2vWZGKw+uQGfKmJ3WyRqfvTtmY/c8zYamLwl8NKGC7SXc+l1qKFgRfsN9TZd
         YSNSzfql2YS7yK25Ha+v+k8154+SzWdjS5SCHgYytA19Vl5x+qX3ZbQ+zvdLHHzJsAmz
         gHRvleS5iG2Aqg7IkZg1nSrYGkI4gk+PEuec4ySgjOkuqBFkyF1whTcAfW/IQr6pOlps
         +rQFuNU2jCIz/sdJ1uGInYi64JO5dyrRuDOsA7kehVM4kuDFJfZR41rvvkQGY0Mj4ncj
         oHHQ==
X-Gm-Message-State: AOJu0YwqsCSYrWq+kEHMnUVXGH48hscjX4leKZu4MBf+yaWjGykRGPT5
	6QgNuQplITlx57yrCCL5arddVLKx0zSKbLtKIfFauASvGDtTvlZ+rAbkBYOkrMA=
X-Google-Smtp-Source: AGHT+IF0QkZg2HRZSsVSeTg1mul8uxrs1wHVdBvflw7nlya28zZ1+DwXxsvBDl6tZe1QXf/14bCz8g==
X-Received: by 2002:a05:6358:33a1:b0:174:edd3:b3e9 with SMTP id i33-20020a05635833a100b00174edd3b3e9mr1008373rwd.38.1706328249140;
        Fri, 26 Jan 2024 20:04:09 -0800 (PST)
Received: from localhost (fwdproxy-prn-002.fbsv.net. [2a03:2880:ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090adac300b0028b845f2890sm3910721pjx.33.2024.01.26.20.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 20:04:08 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v7 4/4] netdevsim: add Makefile for selftests
Date: Fri, 26 Jan 2024 20:03:54 -0800
Message-Id: <20240127040354.944744-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240127040354.944744-1-dw@davidwei.uk>
References: <20240127040354.944744-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Makefile for netdevsim selftests and add selftests path to
MAINTAINERS

Signed-off-by: David Wei <dw@davidwei.uk>
---
 MAINTAINERS                                    |  1 +
 .../selftests/drivers/net/netdevsim/Makefile   | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 92152ac346c8..562af3dfd2d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15082,6 +15082,7 @@ NETDEVSIM
 M:	Jakub Kicinski <kuba@kernel.org>
 S:	Maintained
 F:	drivers/net/netdevsim/*
+F:	tools/testing/selftests/drivers/net/netdevsim/*
 
 NETEM NETWORK EMULATOR
 M:	Stephen Hemminger <stephen@networkplumber.org>
diff --git a/tools/testing/selftests/drivers/net/netdevsim/Makefile b/tools/testing/selftests/drivers/net/netdevsim/Makefile
new file mode 100644
index 000000000000..5bace0b7fb57
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0+ OR MIT
+
+TEST_PROGS = devlink.sh \
+	devlink_in_netns.sh \
+	devlink_trap.sh \
+	ethtool-coalesce.sh \
+	ethtool-fec.sh \
+	ethtool-pause.sh \
+	ethtool-ring.sh \
+	fib.sh \
+	hw_stats_l3.sh \
+	nexthop.sh \
+	peer.sh \
+	psample.sh \
+	tc-mq-visibility.sh \
+	udp_tunnel_nic.sh \
+
+include ../../../lib.mk
-- 
2.39.3


