Return-Path: <netdev+bounces-115956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D5E948973
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 08:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27FD28779E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 06:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A851BBBD2;
	Tue,  6 Aug 2024 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eM1EtLTI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9731C32;
	Tue,  6 Aug 2024 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722926143; cv=none; b=iYPxO+HN0NcpBl7tYSxcT5cx6kokUKfmzDj/3FdNISSZZKiFuAdXX8Smt2NNB7xZMWLDQA4uX6h30hTxYQkhn6SEHXcdK1Dx2qG0uBRbqiYIpMY5g0qVs9kzDEzFBS1VB2jNTQfzW/Xq+FFum8QPG+aYNgJNBElxD69SqfDWtxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722926143; c=relaxed/simple;
	bh=agtSU/5MoJvugKtuYx+V07ri8VyeHWabtADyR8kE1r0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=njPUwcmEeCrKqVh0J9k1YM7eQkHx8z0h+lfZEPqVOsUei+TsfTUHIxKrsAJw4N6bZnlWn491zeLWIgw3QvRRTmmcT4GFLzGBj0gChmS8wchsHa8ul2vg0uZQCSRqtb5Bl61FPvreej9tHsNgs/YhSlC0WP1ArgQp9mw2UDd7tLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eM1EtLTI; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-709346604a7so94667a34.1;
        Mon, 05 Aug 2024 23:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722926141; x=1723530941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HRCxXeI7vH3el/0uim4BCEJl1pPDLT+wIED0mk4DVv0=;
        b=eM1EtLTI16sqltY/yJzxUHQbw5t8rv1PpbU9CeC+aAzZqJ18lZsE0+4h2yl+F3xSRd
         biPCflXmb06t1L66dkmoEiTwOMpEr6hy2I/LJmCYet1tlJmwo7XNu+CqLqURfj86WJqk
         hhGBzyrS2GlcOlYrhaprwk58BFz0KmpyTj7RMfZDNzUC8iUEltrHAZaoN4hLGW9kOvNp
         ZoatQOxz4A0aV0thUUFOeGyP+O8+iUbNGhyDmJzGoRU+xragOWtpJdKU1OWcC29nE2se
         uNTuVp+4k0CwqAefWGkFhfaeaKot+Q+ADbh/h1jtSCV2Z49BRovEF8H9wTBSilG12FhN
         BwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722926141; x=1723530941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRCxXeI7vH3el/0uim4BCEJl1pPDLT+wIED0mk4DVv0=;
        b=wAY1R4jNfevwC6pzWQIy2FPE+HG2MzV9tVSeOhuSi7l7rEzOckahMU+9buJtDTbn5E
         ivIofYXlUGsRNDDTqmDAX42dUJHxipxHBf0fySIdjvDJOqpggUCv58K/C2x2pAFTDIY8
         2VIDcLw0BD5GcrHze/MZtnyHCicRJaYWm8c6X93lWr77OUvIxCkt3/K44E5wujbrYw4q
         oqaaM7MyRWfAM1SvHJDmUE68cXIgj6SEiQp7TqAUWz5uxhAf51Wwd54NJd+piMW582r4
         4dgtYQiP5rRmalxk6XylBP8UMkyQM81NSXT/xeOok5JGG5WDFVws15B4SriDbjlF6LZz
         xHdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi8/4SGYvU9r+6a/QGBlT+nXgXqfM2z3T0nzvj7d02g2ZhA17mJrkWu/EI4jGUCddlRBBUDjADypYj6JJq/XSYmFSgxhFAL1bWxTqXN3nZ0a+81wGZ6oDbiqkwTk1oDs+iUnjo
X-Gm-Message-State: AOJu0YyHRPjFbwwuilPTe05KySfD0P02BUMNrwPSFQxfVlIgKH/7WP8e
	yYMl2udkOiWP0Lsn8Rk8IICSBdBdny2YaulOGNJCppPC0zz44/LB
X-Google-Smtp-Source: AGHT+IHWvzs+rF7qmpBw5MplmloQXnF+aXC1rIEVo/PRB5JeP2wJRb64RA6Qg9UqJEwSaPJr/oUU3w==
X-Received: by 2002:a05:6830:390c:b0:709:33b1:fc38 with SMTP id 46e09a7af769-709b997136bmr19454349a34.29.1722926141103;
        Mon, 05 Aug 2024 23:35:41 -0700 (PDT)
Received: from localhost.localdomain ([159.196.197.79])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b762e9f5aasm6387963a12.6.2024.08.05.23.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 23:35:40 -0700 (PDT)
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Shigeru Yoshida <syoshida@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4] net-sysfs: check device is present when showing duplex
Date: Tue,  6 Aug 2024 16:35:27 +1000
Message-Id: <6c6b2fecaf381b25ec8d5ecc4e30ff2a186cad48.1722925756.git.jamie.bainbridge@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sysfs reader can race with a device reset or removal, attempting to
read device state when the device is not actually present.

This is the same sort of panic as observed in commit 4224cfd7fb65
("net-sysfs: add check for netdevice being present to speed_show"):

     [exception RIP: qed_get_current_link+17]
  #8 [ffffb9e4f2907c48] qede_get_link_ksettings at ffffffffc07a994a [qede]
  #9 [ffffb9e4f2907cd8] __rh_call_get_link_ksettings at ffffffff992b01a3
 #10 [ffffb9e4f2907d38] __ethtool_get_link_ksettings at ffffffff992b04e4
 #11 [ffffb9e4f2907d90] duplex_show at ffffffff99260300
 #12 [ffffb9e4f2907e38] dev_attr_show at ffffffff9905a01c
 #13 [ffffb9e4f2907e50] sysfs_kf_seq_show at ffffffff98e0145b
 #14 [ffffb9e4f2907e68] seq_read at ffffffff98d902e3
 #15 [ffffb9e4f2907ec8] vfs_read at ffffffff98d657d1
 #16 [ffffb9e4f2907f00] ksys_read at ffffffff98d65c3f
 #17 [ffffb9e4f2907f38] do_syscall_64 at ffffffff98a052fb

 crash> struct net_device.state ffff9a9d21336000
   state = 5,

state 5 is __LINK_STATE_START (0b1) and __LINK_STATE_NOCARRIER (0b100).
The device is not present, note lack of __LINK_STATE_PRESENT (0b10).

Resolve by adding the same netif_device_present() check to duplex_show.

Fixes: d519e17e2d01 ("net: export device speed and duplex via sysfs")
Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
---
v2: Restrict patch to just required path and describe problem in more
    detail as suggested by Johannes Berg. Improve commit message format
    as suggested by Shigeru Yoshida.
v3: Use earlier Fixes commit as suggested by Paolo Abeni.
v4: Typo as suggested by Simon Horman.
---
 net/core/net-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 0e2084ce7b7572bff458ed7e02358d9258c74628..22801d165d852a6578ca625b9674090519937be5 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -261,7 +261,7 @@ static ssize_t duplex_show(struct device *dev,
 	if (!rtnl_trylock())
 		return restart_syscall();
 
-	if (netif_running(netdev)) {
+	if (netif_running(netdev) && netif_device_present(netdev)) {
 		struct ethtool_link_ksettings cmd;
 
 		if (!__ethtool_get_link_ksettings(netdev, &cmd)) {
-- 
2.39.2


