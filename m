Return-Path: <netdev+bounces-57667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63563813C8D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 22:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F2E281963
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 21:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D566ABA9;
	Thu, 14 Dec 2023 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="MhMpjkgZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FD96AB80
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 21:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ce939ecfc2so8180940b3a.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 13:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1702589097; x=1703193897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3V2M0TkGcjsOwvR9lkJ0gKcZe2oUBlp6oN2aOhqh2f8=;
        b=MhMpjkgZr86K7R1FRht0N1fb96QQSKyF4PlTrv07PsKN1mfo83fF27AqbHIfyegafV
         8sptKfBl2gh5dzPiJLP5U6OlELyKH45oIlrvofnbo29iw1nh3EyiNUpdSaVcw4C+t4B0
         mDyr1ed3opYL7yj2Opaq7fhBswxsGiOXxJhQJIcv+L19fyk1Cle0OAJBflyqzy2sxpY/
         /XvqQwNNCjV7BQ45INBhKo+61lbUeg2CC+AdF+ajSFKRX+mnkQhiIgf/UFpnwz2qMMxi
         8J+CqBQzL5+f6lLgZBKV+EhwpybpQKXYWY5FS1VsxtLrRR61VmOxumMEG2TtiRO43XL6
         A5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702589097; x=1703193897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3V2M0TkGcjsOwvR9lkJ0gKcZe2oUBlp6oN2aOhqh2f8=;
        b=Xkc61DHEOyg0xh+xaDkabldPNLXpEUyof4Bv4+DBDOnHw565e2AW7GLmWeU9rTx4Ca
         P4aOlXishd+DG50HvPnH7e/qxd5qLzS/DOOKDC9JDOBWW48ebkWEh13LpQItTN4rMDxa
         7qpL0ya/Pfu4UzK/swliGKdaEMajqoK5+lBZL3r9vdAVBvsow04Tg2JUXH0sridhbrGq
         BvfNcgUfl/L9ZI7Qm80F/B+iK9yGyfXqz1vA/YwbhPhctW+XewrcLxp76tAj2Q2pxW/4
         7kkloL1qzEaJdstv5nqnF7xmzhOs/BGjR/z00y5G4LWX1z+9N7Rx9Sot9Dpt7GCC307F
         pzkg==
X-Gm-Message-State: AOJu0YzHvmJ/V/qzbZHZvZ13zttvcFZ0MxsWMqe6XkkdAnjOnsLYsyxS
	EGJoiwUWni+eMqn2RE3AWJbGOA==
X-Google-Smtp-Source: AGHT+IEcb3NHJbQUK7LaZGs53Is/RasWpVu56PxuoxOCVIPhdO8SPh1F/zn0bpJcxt7osGhlahqdOg==
X-Received: by 2002:a05:6a00:14cb:b0:6d0:d864:219d with SMTP id w11-20020a056a0014cb00b006d0d864219dmr3605140pfu.3.1702589096709;
        Thu, 14 Dec 2023 13:24:56 -0800 (PST)
Received: from localhost (fwdproxy-prn-019.fbsv.net. [2a03:2880:ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id d4-20020a056a0010c400b006ce7344328asm12199901pfu.77.2023.12.14.13.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 13:24:56 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 4/4] netdevsim: add Makefile for selftests
Date: Thu, 14 Dec 2023 13:24:43 -0800
Message-Id: <20231214212443.3638210-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231214212443.3638210-1-dw@davidwei.uk>
References: <20231214212443.3638210-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Makefile for netdevsim selftests and add selftests path to
MAINTAINERS

# make run_tests
...
# timeout set to 45
# selftests: drivers/net/netdevsim: peer.sh
# modprobe: FATAL: Module netdevsim is builtin.
ok 11 selftests: drivers/net/netdevsim: peer.sh

Signed-off-by: David Wei <dw@davidwei.uk>
---
 MAINTAINERS                                    |  1 +
 .../selftests/drivers/net/netdevsim/Makefile   | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index a151988646fe..cfa0804772b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14899,6 +14899,7 @@ NETDEVSIM
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


