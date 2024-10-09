Return-Path: <netdev+bounces-133620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5857C9967F9
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87FF28B649
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 11:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC931917C9;
	Wed,  9 Oct 2024 11:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monogon-tech.20230601.gappssmtp.com header.i=@monogon-tech.20230601.gappssmtp.com header.b="u+t8q+YK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5751A18C35F
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 11:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728471868; cv=none; b=t8+cVYWS8smZR5/HpyGA4oXnXx3b0S5EBFH72ddJCj3kfc5Q/4yn1E5afmV3SA9llwv2juUdg39+gQE0tZ0EYrPz0kuZDIqJJms4k4P/tp2tVIgqRh++FBNoV6AwKiZ1C2J6wENy3JIQhngi4WpGUa5iIkZmQWz1gIb2z0tcUMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728471868; c=relaxed/simple;
	bh=Dla4E8Is21IGTGFswn/kaSTmohX8k9I1UVRn5uS1fhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XSIzGD3cKphN36jU+T4EJe9md+zCznZPshx/enXbesXb3hb0z3ErefPZrsdlNysOB3KqqABI/MdhHd4vUEumj4ho4KcP+mxYm1gQQ8jx6HxE5KsNhVeGLiR3U6PHfXZf1/yP8nZXfdlMTqnNSMDAxkVoQltadCGQrinqRQTR8v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=monogon.tech; spf=pass smtp.mailfrom=monogon.tech; dkim=pass (2048-bit key) header.d=monogon-tech.20230601.gappssmtp.com header.i=@monogon-tech.20230601.gappssmtp.com header.b=u+t8q+YK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=monogon.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monogon.tech
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d375ddfc0so879878f8f.2
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 04:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monogon-tech.20230601.gappssmtp.com; s=20230601; t=1728471864; x=1729076664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F0HzVzYREO0kj7Rj+vnq/jPWQKZs1T4yzmSnt22r46g=;
        b=u+t8q+YKTfOZU5Wupq+THxh9lLoPrI4uN80AYb4mhkHMAnhjAKUw4dxGbeRY+RIHmp
         3pY9STiNxkIv0oDMdGAOYszzV0QXcF87Frnhz42m63QMCoGdZWOSBFDzd+WXProovXfq
         ZZc3jzDjNVKNh1XV7FrlKeTEWnbD0effhWl2KIacSi354xS5rb9EAmT6m9zRbb+EdAjr
         Xh+am3mDBN8b4B/6eT49Q2ZWaLK1E5rchl3OKFJbuNXUv2ZQKj3ifJODY/1c+hWNT5GY
         Q1prLmrVe8qvDqdVByuyD3mNgzUHAeeTW77DIfVRarOGDnDiEx4QZ2zf7BjWRmbD9Gda
         z10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728471864; x=1729076664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0HzVzYREO0kj7Rj+vnq/jPWQKZs1T4yzmSnt22r46g=;
        b=DmF7pHS4N85tioaBaR5EONrrL9IeEGA9kZxMAKcu8CCcjMHrYscKqJ+/TJ2Nn7DXHI
         pl+red7Azvpz9TnbtryS2/2qp0PDSTGXThjO10NevmZXtMCENxGZo58kXA9rQ9ALDGAY
         hawXgAdKDWPDWopr7dqcLF+6fReN/KXleNcpCaaMzcls0F1cegnHR3PgD0T0Rqcr8Rit
         1gZbvyXqHM3dSgeO/XX/NQ3vtt2BEjmN6kV6FYqSCkhDwPosycHcUOHNRbe5wvrU7GNQ
         uLkmOBvSqmV+mQA4hYLhIxfcIxywqBm1Sk+dw767svJedEGgcpyvVK51dkLeKhF+31M1
         u6VA==
X-Gm-Message-State: AOJu0Yw8MMKxaFVBTycY7uB6wK2wUPErehIFJ7nnJlrEaTHgTMHTmWn9
	mkaOoQdtgOLSAVmSYfmePmFu+2WiNP0KxlV9DV/Tax5+gRl+A0kB646RK8aONzM=
X-Google-Smtp-Source: AGHT+IGmgqqX84W8yv6zX1VXkidZuQOjkulSHglaFq4Tl6PcujRGTMrah+ivKAgH+vZdKk4dkeh/og==
X-Received: by 2002:a5d:4112:0:b0:374:c621:62a6 with SMTP id ffacd0b85a97d-37d3aab5d6fmr1400374f8f.47.1728471864279;
        Wed, 09 Oct 2024 04:04:24 -0700 (PDT)
Received: from localhost ([2a02:168:4f87:c:154e:9e64:f4ec:cbd2])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-37d3e86a39dsm1008810f8f.75.2024.10.09.04.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 04:04:23 -0700 (PDT)
From: Lorenz Brun <lorenz@monogon.tech>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] net: add config option for tunnel fallback devs
Date: Wed,  9 Oct 2024 13:04:19 +0200
Message-ID: <20241009110421.41187-1-lorenz@monogon.tech>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a Kconfig option to set the default behavior regarding tunnel
fallback devices.
For setups where the initial namespace should also not have these, the
only preexisting option is to use a kernel command line option which
needs to be passed to every kernel invocation, which can be inconvenient
in certain setups.
If a kernel is built for a specific environment this knob allows
disabling the compatibility behavior outright, without requiring any
additional actions.

Signed-off-by: Lorenz Brun <lorenz@monogon.tech>
---
 net/Kconfig                | 33 +++++++++++++++++++++++++++++++++
 net/core/sysctl_net_core.c |  2 +-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/net/Kconfig b/net/Kconfig
index d27d0deac0bf..e4429a017e47 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -447,6 +447,39 @@ config LWTUNNEL_BPF
 	  Allows to run BPF programs as a nexthop action following a route
 	  lookup for incoming and outgoing packets.
 
+choice
+	prompt "Create fallback tunnel devices"
+	default FB_TUNNELS_DEFAULT_ALL
+	help
+	  Fallback tunnel devices predate the Netlink API for managing network
+	  devices in Linux and get created when the respective tunnel kernel module
+	  is loaded. With a modern userspace these are no longer used but for
+	  compatibility reasons the default is to keep them around as the kernel
+	  cannot know if a given userspace needs them.
+	  There is a sysctl (net.core.fb_tunnels_only_for_init_net) for changing
+	  this, but it cannot retroactively remove fallback tunnel devices created
+	  before it was changed.
+
+	  This knob provides the possibility to set this behavior in the kernel,
+	  making it work in all cases. Note that changing this value to anything
+	  other than the default will break compatibility with old userspace.
+
+	config FB_TUNNELS_DEFAULT_ALL
+		bool "In every namespace"
+
+	config FB_TUNNELS_DEFAULT_INITNS
+		bool "Only in the initial namespace"
+
+	config FB_TUNNELS_DEFAULT_NONE
+		bool "Never"
+endchoice
+
+config FB_TUNNELS_DEFAULT
+	int
+	default 0 if FB_TUNNELS_DEFAULT_ALL
+	default 1 if FB_TUNNELS_DEFAULT_INITNS
+	default 2 if FB_TUNNELS_DEFAULT_NONE
+
 config DST_CACHE
 	bool
 	default n
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 86a2476678c4..d9a0b13ceb4a 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -37,7 +37,7 @@ static int min_mem_pcpu_rsv = SK_MEMORY_PCPU_RESERVE;
 
 static int net_msg_warn;	/* Unused, but still a sysctl */
 
-int sysctl_fb_tunnels_only_for_init_net __read_mostly = 0;
+int sysctl_fb_tunnels_only_for_init_net __read_mostly = CONFIG_FB_TUNNELS_DEFAULT;
 EXPORT_SYMBOL(sysctl_fb_tunnels_only_for_init_net);
 
 /* 0 - Keep current behavior:
-- 
2.44.1


