Return-Path: <netdev+bounces-59127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C29E2819683
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 02:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646D11F266D8
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 01:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719787472;
	Wed, 20 Dec 2023 01:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="1NBwCSJ0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195C3BE68
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-593faaa1afbso484037eaf.0
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 17:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1703036874; x=1703641674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWOr9qiisUkjpabZ4ff5uQEtv5SlwPvl6ptfPUH6+qE=;
        b=1NBwCSJ0R5wZO+TDS2xr5LsoLOzVRAJQFqlEqX8+X363Zk3NplTHe2jsc0P+8U6sa9
         tYuCuRyLRGw8M+/GfgK4WALyakncfFtGnXoPZIoK/iiL2JtbVGhB2NTFdUCqgKWXFzmh
         cDInygP8Xwfj5E+mmp+SQge/h7cM6Y/Dfzb1GtSONqUYAp3Nx+tonlMmrDbIJtAhk2jh
         0TW8SxF2nH2A39z1ivRLCpH8cgHxATgJ8ZRtV3PzkLsm7ZS++u3Ww6/s2ZQTM43ciRAi
         MDsuZ243hvywG3NH+KdM9iD6GjMzbkXMnR3tSdkroR1qEG/Bv/uS3CRq6kcq6DyNkh9x
         vimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703036874; x=1703641674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWOr9qiisUkjpabZ4ff5uQEtv5SlwPvl6ptfPUH6+qE=;
        b=Y8y0MGjivzvp5CYjycmZLdXYYiVhK4HXxmU+0q6t3x2T0X5G4dUJWUxr3SCD8H4TnW
         IfkKb8IVKkjeLEX/qXQYMdpJYSkGoPcgoL/NGUvYDxN1evMfFCEhJ6+RzBUxEhPWyQkO
         mA+tMLfqAzswCJo2DpFRDYGJsuyeej3hmwvUaWRJIADIwOwhA374E0r5nDC24hvjow4z
         r8fJ1PxPSfnrlaAYKLtTDb3HGiQG8BmBtqACE+DdId77ti5dUQa5b+81HOJfKMVBNzBv
         yNZpvaqgzsZ2ibXluOfjxVQSU0/yj+zPfrRupPAD7WzyRBkLL/ew1jmGnEg/OSCvd+FF
         0BHw==
X-Gm-Message-State: AOJu0YwY7KZF+8kAppZm3Lh4pDPu3hgkzd5wGhfCd2mgb7I2ASoLZon/
	tWiP07YbVlRH0UlODtjcu7/Ncw==
X-Google-Smtp-Source: AGHT+IEPc5q69adE+uwGOOznPo/LLRclOSONBC0SbD6eTPV3X8+frIOBkj/zDV2/bnyByoCGvD9hfA==
X-Received: by 2002:a05:6358:7255:b0:172:e226:c16f with SMTP id i21-20020a056358725500b00172e226c16fmr4467530rwa.4.1703036874054;
        Tue, 19 Dec 2023 17:47:54 -0800 (PST)
Received: from localhost (fwdproxy-prn-116.fbsv.net. [2a03:2880:ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id dw7-20020a17090b094700b00286f2b39a95sm2321150pjb.31.2023.12.19.17.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 17:47:53 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v4 5/5] netdevsim: add Makefile for selftests
Date: Tue, 19 Dec 2023 17:47:47 -0800
Message-Id: <20231220014747.1508581-6-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231220014747.1508581-1-dw@davidwei.uk>
References: <20231220014747.1508581-1-dw@davidwei.uk>
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
index dda78b4ce707..d086e49eac57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14853,6 +14853,7 @@ NETDEVSIM
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


