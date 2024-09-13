Return-Path: <netdev+bounces-128082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA9B977E28
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C8D2838C0
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 11:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CB21D7E4B;
	Fri, 13 Sep 2024 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monogon-tech.20230601.gappssmtp.com header.i=@monogon-tech.20230601.gappssmtp.com header.b="xI/JGdGk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04643716D
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726225485; cv=none; b=EWH1Fh9SKJwBTOWlkap/yeFUQ3DocUq1Ahpt17Tqdr2L6IAv8qljzoTnOEiKQ7I6dDLjqgOgvUA7Luk/s4SjvAKZksF4QZ809unnXYFxaL5ZLdnlKEsYsktDuqkaObR08eJqmJyYwQVjaKHlv+SNFIIBMbnvrwjQV3+qDX09RRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726225485; c=relaxed/simple;
	bh=Dla4E8Is21IGTGFswn/kaSTmohX8k9I1UVRn5uS1fhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ia6gOEs/4NwHgYcazGY0OOxtflRwLlIMxvsAd5wYmTg6bHFTtwAqQzXDwYtBnFBr5QtqbdfftnMNBnTkPIhymsPE5cnnrD1m5eHgNEm9kaJRmVSCDTvvwy09BqEGLDtwFj+JBmoXWqWz7GCubGCmBdx74GHPWmnuQ+zz9eVjiPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=monogon.tech; spf=pass smtp.mailfrom=monogon.tech; dkim=pass (2048-bit key) header.d=monogon-tech.20230601.gappssmtp.com header.i=@monogon-tech.20230601.gappssmtp.com header.b=xI/JGdGk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=monogon.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monogon.tech
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cafda818aso19240825e9.2
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 04:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monogon-tech.20230601.gappssmtp.com; s=20230601; t=1726225481; x=1726830281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F0HzVzYREO0kj7Rj+vnq/jPWQKZs1T4yzmSnt22r46g=;
        b=xI/JGdGkMPK//eIqvbOzd1i+22Z5Jdlhqzf3g8MLaw4AmU1oWEtZqm5W7YmLMVdgxV
         e7W5963yYhkAfW70JNFWSdBgBsw+BWluxYJncKr1qPTZhdkJ2swyF4nIjKrPLV/x4xhe
         K0kiOoKwlJZqLs8IYMVdId/p/IqSXX4BesFYvnw7FJjFq2pTRpeMeqNoCEoQ/TRRbj6F
         dg28RlPpbOdrDaulq6PtzKY7fTaPQspHo8SPDWUIMm7qwXd3OATf2TBMag36b/qVpYzM
         m3E9CbKWQXp2giHBzC/AVibPTRVoRbbOnpEqlyYjul8mvE2LOHkxDBBeXSVigcP5jEkL
         xmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726225481; x=1726830281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0HzVzYREO0kj7Rj+vnq/jPWQKZs1T4yzmSnt22r46g=;
        b=rynWWdQW/6XtIkqMhA6xmkSzyrG7w8wUI2wniNT4+ISVtk6rUMkwaMNutBlYh9HvoT
         ebgm9GXEschPfpwu3WsBJp1HQeub5uXdL4xv2pKsQBI3GbAfJWhNK/p+xc6byhMhqo4V
         Q/KImSwyOWA/yb4R7q2Wwt7tLHnpbi0RZ48sZ+elFmEBhUcZFV5rp7mR8DouMnrFPOwl
         0Qi9iGV3f4kpImsYtnPKiCzvIuMpi6gcY2QCC10vQEyVOIrC6N6Vc/IgJ8TInxKANQ0X
         GPAJFXvqGnlYUfRPzRfVyF0IqAvaeh7cf0rmHhnktjJccdY0NrLVQlyRjfc/AmtfhyZC
         Go1g==
X-Forwarded-Encrypted: i=1; AJvYcCWKLcIyd+tMCcKP8oHuPf5wyGFL28zVb6jva1Qg8c1Ui9TNPOSDwpXkrD0e6T3QbfAMOrnAVKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1PA6SbIBzgajW5RwFy4hAkrFlYtQHjaFdRoWGODBRnmuJ0/m9
	HNkGmm/M3hR4JjYzsqcWQMVQRgES050Vl0GxUpon8JpDX0sG/8dgZdfPqaCCRB1m0ymvwYVH1xe
	Jdklosg==
X-Google-Smtp-Source: AGHT+IH/IoUi4n0Wx1+50RVpgaaT3O2mHm7hKyiEYp4ZpR1h3lQ95ZGqf7aBK8UgRza6xtKp+o4rCA==
X-Received: by 2002:a7b:c394:0:b0:42c:df54:18ec with SMTP id 5b1f17b1804b1-42cdf541c13mr46362525e9.28.1726225480129;
        Fri, 13 Sep 2024 04:04:40 -0700 (PDT)
Received: from localhost ([2a02:168:4f87:c:8067:8260:f878:e308])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-42d9b15aaa9sm20812525e9.14.2024.09.13.04.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 04:04:39 -0700 (PDT)
From: Lorenz Brun <lorenz@monogon.tech>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lorenz Brun <lorenz@monogon.tech>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: add config option for tunnel fallback devs
Date: Fri, 13 Sep 2024 13:02:33 +0200
Message-ID: <20240913110234.166707-1-lorenz@monogon.tech>
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


