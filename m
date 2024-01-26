Return-Path: <netdev+bounces-66069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E67783D206
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 02:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3EBDB21DEB
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 01:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FDC6FC5;
	Fri, 26 Jan 2024 01:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="tbikyoYp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD79E4687
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 01:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232247; cv=none; b=PEti12VESbYD5682ZSreKirzaUfImLYWWR7iwgmJeCxKQ6TvE+7/6x3+jagyLpZ0lslaTf3AFjbEyuDkvk5shpnE/Er20U5RzDwYvrXi8rrgpDcNzrLktFjsqDwl48par5MXTCC4ZevR+ySY4gGCtNesTQXa7qShZ1x4kMKm/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232247; c=relaxed/simple;
	bh=eCjWuhzdddCrMZiFX6ANjmJWjtgIDAgjsgKRZp3Q99E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hmVGpAnQWhI3oQo43ezreZbXX1MUBrpLcfK1gBfEoOmNlmqYoefgcgbH5f2OBy/gKlSOPmTIAeOWWGAiAD0TkpTvm9ztEmEE71twy+QmPHEp7Mur0XJpv5AP8u9K3xeg3dmShdS0W7CDxGBJoKSg0aAZ7hjRQNYdnKrleQz6Lys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=tbikyoYp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d893950211so5893385ad.0
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 17:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1706232244; x=1706837044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6CX8D0lpq6HiM0LfR6MAxAUUlJjyu7IdjFJ5kI3qyM=;
        b=tbikyoYpd2o6RlvvCEKU3iMhH54O35e2iV4SqCceGnf5KEtbcN0PLJ4gJAbMvTGCeK
         TIL3eEMpmYrljL76iuLaK4/xTSFQ9qvzLBmQmLES7ccFrRIWR6frSxLRpb+k6AThmFKp
         /dSKxyD2VhEKM6jKY80UGnypEvLHxOmIQ1bY/zveFB9cbJRULpobj7/SyNwLgVqrPlak
         xQxb9JgE3fikUblnAaJ0yX1QGA7b1vO316E7npZkTkcJDDwViItwtrnjXUknJHnGTy8B
         626jQ1+5MyiVKc0iozoT56/ia2cEWjcP4EPm75FCFGnQ0WG7eVBlcoAmCvvrh6ZF0Fzg
         /8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706232244; x=1706837044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6CX8D0lpq6HiM0LfR6MAxAUUlJjyu7IdjFJ5kI3qyM=;
        b=hrjfZSTzakiwnOMIxyzzaPAvEF02OiJoBArI7fKu9eNSYWugx0Rf6fXozMIN1YDTpa
         FOrRueV6+IgXxpRgN4Y996nyE15/P32nUDXzAppvsZ6IIPgo3ze3n/AnHL836NyOotg+
         JEnbXKqXYWdJ/zRUG0fyBGiY0t4CtqfTeEjECRt1SiLP1x7fy322iF3nhnj5TnQXZNtD
         6Ntr/82QeS8hvINqZWJBWk2HtQIKnYmBhD7KJlJhtdH7ILwS3IqThj77yWGmvmm93IU5
         KyFfEfMVsKT0/DCFR0SMZRrtVRNzOwZeS+/P8EaYIVK0Yh+z3XIFqbxykkz0UGoOwpev
         Ud+w==
X-Gm-Message-State: AOJu0Yz9WPXEmYXNLPjUjWgdpiwGowYgziVV1XDulF2FZxUIjBmGt0Sl
	R3ewy4YN3wc5QCh3Lg/Mb5uHOsw2rbsyZ08d6cpeCfpnVlvGte8A1QO3z1NGu5E=
X-Google-Smtp-Source: AGHT+IHbmlADsrnFRBINz+pLzcqL2xK6k8ZUNw6nlBqsHxIAUAD/tguq3pmhgL0FSgCQsL/xDdx9dw==
X-Received: by 2002:a17:902:e743:b0:1d5:c1c4:7f05 with SMTP id p3-20020a170902e74300b001d5c1c47f05mr670335plf.3.1706232244095;
        Thu, 25 Jan 2024 17:24:04 -0800 (PST)
Received: from localhost (fwdproxy-prn-119.fbsv.net. [2a03:2880:ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id v7-20020a170903238700b001d72817a62dsm114362plh.264.2024.01.25.17.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 17:24:03 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v6 4/4] netdevsim: add Makefile for selftests
Date: Thu, 25 Jan 2024 17:23:57 -0800
Message-Id: <20240126012357.535494-5-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240126012357.535494-1-dw@davidwei.uk>
References: <20240126012357.535494-1-dw@davidwei.uk>
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
index 8709c7cd3656..6b3608db5bda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15061,6 +15061,7 @@ NETDEVSIM
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


