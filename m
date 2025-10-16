Return-Path: <netdev+bounces-230043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8983BE32F3
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0B174E7757
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EE43164C5;
	Thu, 16 Oct 2025 11:51:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED14306495
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615515; cv=none; b=C/40aLmWjcMQtVk6JUHKH4VwdLEORWMs5u83ze9p7btYjjNaCDxkVnfnsHql7xYx7SX5j1ntmioxbXTEiKp5wOpMUG+N0JuSB7fr3LBvjzW+DnBeSa4HJ8MAx/JYvr88sWCS45AnZht7WQ5ojsh9LWySIYcT5KUmuKuucino0MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615515; c=relaxed/simple;
	bh=RpOdPo0zzzPonXJPYxnQwLjgzHyk3LzqxKTFNTwjmsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LO5Lq/F/ZJS+s3iyDdbbOKqZEdfD82uefxy+YOogEB/OEVrKAKNJpO0UFjenCmGn5CiZylOOcEnzWpdM2OY26mVtaVb5GFEBqYDsaGV4SerwyHLtI6A6+E+CkRJcVkWuCl4H0DeTFpMzWKOIxFJ2wAXiolFxFRIEGzehoRQpmQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 8DB9560308; Thu, 16 Oct 2025 13:51:51 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	horms@kernel.org
Subject: [PATCH net-next] net: Kconfig: discourage drop_monitor enablement
Date: Thu, 16 Oct 2025 13:51:47 +0200
Message-ID: <20251016115147.18503-1-fw@strlen.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Quoting Eric Dumazet:
"I do not understand the fascination with net/core/drop_monitor.c [..]
misses all the features, flexibility, scalability  that 'perf',
eBPF tracing, bpftrace, .... have today."

Reword DROP_MONITOR kconfig help text to clearly state that its not
related to perf-based drop monitoring and that its safe to disable
this unless support for the older netlink-based tools is needed.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/Kconfig b/net/Kconfig
index 1d3f757d4b07..62266eaf0e95 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -400,15 +400,15 @@ config NET_PKTGEN
 	  module will be called pktgen.
 
 config NET_DROP_MONITOR
-	tristate "Network packet drop alerting service"
+	tristate "Legacy network packet drop alerting service"
 	depends on INET && TRACEPOINTS
 	help
 	  This feature provides an alerting service to userspace in the
 	  event that packets are discarded in the network stack.  Alerts
 	  are broadcast via netlink socket to any listening user space
-	  process.  If you don't need network drop alerts, or if you are ok
-	  just checking the various proc files and other utilities for
-	  drop statistics, say N here.
+	  process. This feature is NOT related to "perf" based drop monitoring.
+	  Say N here unless you need to support older userspace tools like
+	  "dropwatch".
 
 endmenu # Network testing
 
-- 
2.51.0


