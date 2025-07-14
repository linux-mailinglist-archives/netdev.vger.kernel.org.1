Return-Path: <netdev+bounces-206699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD69B041EE
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 16:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB17E1A648A8
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 14:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E9625B1F4;
	Mon, 14 Jul 2025 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="PYFU7lx8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5648E25A65A
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503845; cv=none; b=bhIOquDy2d9cRAlnoo6k3UNx6KPmlYMxUkXnzNX7KGwRVcgRwniZfTWYbCXRLTEaiCz1w32qLbpZpKAOlc9LXFs8cEwmsou+T9cO3rF3ZNGZ4k/JiLOefe/2X1Vw1c8zNrLTjo8Sh08M12GnvugBlh+ZKZAdlsyxt+n8nlamZTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503845; c=relaxed/simple;
	bh=4OXFyfWeor5kuQw3lnpwP7NJJ4DK9wVmfOf8j9iAyMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+db8TAecJIFJDkfaQ0+QLviswIGvg5wWBsftVt5q01BdwFAFmFti699cu9eQHnSORDUXOCGfyzU/Y/CgZIhs41NrQlk+VfrlJpFbe2W4dq8qQhMqVwA9hCvPxYsLojdMd2hWFxBl/vBMoRUCRM5BKqxdjuFe9pY/GPH7W9zPdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=PYFU7lx8; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1752503828; x=1753108628; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=1qjKv3KcKXjGF3KGNsJynah+pMd4mE4RxUeeJAFVOQ0=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Transfer-Encoding:In-Reply-To:References;
   b=PYFU7lx8EBTxvh7EtdYATgXtN4/OMZp60c2K9aNLzDX1AnCol6GgPFm9e7y/5ziy7waxDhWG03pQwDqNvUjGc66BHsF1gbsiwjUB3GTOxnxarQYr8VC9zdumU6OKPnEicAlahMgNSSuF4uV454O903N5HuNnuTwPN9wnntbrkYc=
Received: from osgiliath.superhosting.cz ([95.168.203.222])
        by mail.sh.cz (14.1.0 build 16 ) with ASMTP (SSL) id 202507141637071517;
        Mon, 14 Jul 2025 16:37:07 +0200
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	linux-mm@kvack.org,
	netdev@vger.kernel.org
Cc: Matyas Hurtik <matyas.hurtik@cdn77.com>,
	Daniel Sedlak <danie.sedlak@cdn77.com>
Subject: [PATCH v2 net-next 2/2] mm/vmpressure: add tracepoint for socket pressure detection
Date: Mon, 14 Jul 2025 16:36:13 +0200
Message-ID: <20250714143613.42184-3-daniel.sedlak@cdn77.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250714143613.42184-1-daniel.sedlak@cdn77.com>
References: <20250714143613.42184-1-daniel.sedlak@cdn77.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A006396.68751625.001A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

From: Matyas Hurtik <matyas.hurtik@cdn77.com>

When the vmpressure function marks all sockets within a particular
cgroup as under pressure, it can silently reduce network throughput
significantly. This socket pressure is not currently signaled in any way
to the users, and it is difficult to detect which cgroup is under socket
pressure.

This patch adds a new tracepoint that is called when a cgroup is under
socket pressure.

Signed-off-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
Co-developed-by: Daniel Sedlak <danie.sedlak@cdn77.com>
Signed-off-by: Daniel Sedlak <danie.sedlak@cdn77.com>
---
 include/trace/events/memcg.h | 25 +++++++++++++++++++++++++
 mm/vmpressure.c              |  3 +++
 2 files changed, 28 insertions(+)

diff --git a/include/trace/events/memcg.h b/include/trace/events/memcg.h
index dfe2f51019b4..19a51db73913 100644
--- a/include/trace/events/memcg.h
+++ b/include/trace/events/memcg.h
@@ -100,6 +100,31 @@ TRACE_EVENT(memcg_flush_stats,
 		__entry->force, __entry->needs_flush)
 );
 
+TRACE_EVENT(memcg_socket_under_pressure,
+
+	TP_PROTO(const struct mem_cgroup *memcg, unsigned long scanned,
+		unsigned long reclaimed),
+
+	TP_ARGS(memcg, scanned, reclaimed),
+
+	TP_STRUCT__entry(
+		__field(u64, id)
+		__field(unsigned long, scanned)
+		__field(unsigned long, reclaimed)
+	),
+
+	TP_fast_assign(
+		__entry->id = cgroup_id(memcg->css.cgroup);
+		__entry->scanned = scanned;
+		__entry->reclaimed = reclaimed;
+	),
+
+	TP_printk("memcg_id=%llu scanned=%lu reclaimed=%lu",
+		__entry->id,
+		__entry->scanned,
+		__entry->reclaimed)
+);
+
 #endif /* _TRACE_MEMCG_H */
 
 /* This part must be outside protection */
diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index bd5183dfd879..aa9583066731 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -21,6 +21,8 @@
 #include <linux/printk.h>
 #include <linux/vmpressure.h>
 
+#include <trace/events/memcg.h>
+
 /*
  * The window size (vmpressure_win) is the number of scanned pages before
  * we try to analyze scanned/reclaimed ratio. So the window is used as a
@@ -317,6 +319,7 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 			 * pressure events can occur.
 			 */
 			WRITE_ONCE(memcg->socket_pressure, jiffies + HZ);
+			trace_memcg_socket_under_pressure(memcg, scanned, reclaimed);
 		}
 	}
 }
-- 
2.39.5


