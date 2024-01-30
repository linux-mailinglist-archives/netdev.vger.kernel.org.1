Return-Path: <netdev+bounces-67353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FD6842EC7
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 22:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C400F1F2180C
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 21:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F303678B63;
	Tue, 30 Jan 2024 21:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="snZA+9ML"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AC87993B
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651189; cv=none; b=Fzgp6NXLZpuxsn3VTywoqTWC9WAfbTYfJGkmCKiFmf7m8rNbhJbdP6oH4dw+YOui5wCW3MAoGgFgqJtoDOFr/NiFt5w4dq31B9sgpl8vjGLJnR2kP7vPxfmHq1nJ7YbGJ/m/Q6AOh0x6cwxO9ZKwWxVbfasEh/HqoSWht4V7Gq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651189; c=relaxed/simple;
	bh=cLYPdbxUBtT+KaYS866D/Xt5LNCttNpkpzpgDQmmdw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KSn0iAvAVKcMCg5ydI/PzMQZrl773Xze4LzqXi6v/sO3k/lxsZEsoqbUSwUc01/cNOktm8FifUZIdCOUEAnH24zS1PAb790Pylw7s7nNdVCLvHHQBzKpBGaFOD86xctCRtZrScp7hdmI2Vzh6l8qQqoSCCK6eDCxPcEqhYR7JcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=snZA+9ML; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6df60be4a1dso709141b3a.3
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 13:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1706651186; x=1707255986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HipVj3jFa++EzsAXPaItSnaAVQdrvEwwkSfJxQxVOsU=;
        b=snZA+9ML1C2kyDq3fahN6ZHUBLjueI+TenkBeh8FCqleP7evHloKyUI50aZQipA2h1
         /PBjdJJpozpLUrzq4ohJ/M06vtELJSlxoORU6QT8x83esAMnbySb/pTtCL6VL534Sd1B
         SX58eo/Oyndw51cRpRKRgK5+97AROfVkp5BsV2KIHcfmPZYmUVAQUoqIm0/pCVoDZNEE
         k3uggtDsNnvQuwBldcmDee+5FfqKTZyM0EBbmRSg+qPNRIk+3iL5zLSpoOoAMgj9wvU7
         +mhcZX7uPI8/n6DSDCIysrq/ynH0V3wOF8jx2hXVe4DgLgnatDtU43nfzugA+DkXex7Z
         vXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651186; x=1707255986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HipVj3jFa++EzsAXPaItSnaAVQdrvEwwkSfJxQxVOsU=;
        b=MdWXegSZgkqZaEftXIsDwjMvZrHXWxVflaQKNgCcsW1wmXD0XOE/HAzcQ+2WJIzEwB
         6JaMsEP9UG0roBG5nOUVvcQCWudRyrmh6PjP4iYe+An5YSIiqAQ6GGziPMFcRcnzQ1zw
         PSHF7KjFdj0hkSJgg3wpoht3BWXtaV+mq7uSdGvcsqaUeyMrEbtiaxjYS2e3IN2hniDz
         sZZbYvaEESkSz2Pc8cJ2e66X+VnfKEFUlyGYq4/M33AryyiCgf4nSk7W9HBBQTwvbPnK
         iXSdpwpxclkw2vEY9vPqBOYf2a/XfgWUinEqHouOT/wTyXclq8RKtWSAFOBf9QXEdlRp
         ncGA==
X-Gm-Message-State: AOJu0YxVL3mQtNzkPMap2rdZp3X+Y1bGoqb7ARlL7RM4XSJAKhoAgGki
	FZnN4T9bPqP05azd1bTzgnG7sB/PyGVZLc/yDvNklcKUjKakgCxWCFIBDxXH5Qg=
X-Google-Smtp-Source: AGHT+IH/gFJ3PxYb9SCiVLexn2uUO20IXnX5UZVjj09Z+NoLqllBibFeoy7zdNw/8CbnqqI0mKJ93A==
X-Received: by 2002:a05:6a00:1c85:b0:6de:25e6:f6ca with SMTP id y5-20020a056a001c8500b006de25e6f6camr6502899pfw.11.1706651186247;
        Tue, 30 Jan 2024 13:46:26 -0800 (PST)
Received: from localhost (fwdproxy-prn-000.fbsv.net. [2a03:2880:ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id p51-20020a056a0026f300b006dde10a12b6sm8268231pfw.211.2024.01.30.13.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:46:25 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v8 4/4] netdevsim: add Makefile for selftests
Date: Tue, 30 Jan 2024 13:46:20 -0800
Message-Id: <20240130214620.3722189-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240130214620.3722189-1-dw@davidwei.uk>
References: <20240130214620.3722189-1-dw@davidwei.uk>
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


