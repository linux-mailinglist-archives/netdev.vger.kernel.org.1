Return-Path: <netdev+bounces-279705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CzJJJUG5mkIqgEAu9opvQ
	(envelope-from <netdev+bounces-279705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:57:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20131429A7C
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 12:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9784C300463A
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2070399368;
	Mon, 20 Apr 2026 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="BiLYxVBY"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6400F38A70B
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776682509; cv=none; b=f0NbsNagP99qrt0XGxSlahVNMZi5ZDD5Nux8lLK8nQcgXTOgLhUUz81qii9I/gsIBGsA43JjiFRC/a7P56rYMKVUEQffM4I0Euu7xULCO6MtO9BKEBbMKXZHgW04wC4OfK0WJ8qnrITqZAZOiu+6wZrap7axHP6Vrc/txWdhsI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776682509; c=relaxed/simple;
	bh=Ih75MiT1nxkV58aMIhTrWoWOIGCJAoBgD4qTv6PZrOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ISv994k7ZzVYdLbHMNckVv85Se+7um33ICvXWPKMcMKBoSzDqeus5kWpQ0qfPWgu/QQrQyEk2hjACkZVhfw/kgGk6i3VW4zYt32WasrcUlT/n0pr0rAWgXyLNfLC/GMmMDHr1Z98ctVMSekl3BaCfF6YS9hFeR9JkbPVxMWFPwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=BiLYxVBY; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (232.154.13.160.dy.iij4u.or.jp [160.13.154.232])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63KAsTEk075988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 20 Apr 2026 19:54:29 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=pYioUKZnt9VYwWs6DWfDt4Pc9NsWt3Uf7y1Z3Z+cTps=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1776682469; v=1;
        b=BiLYxVBYfTWboC+uMIy3jXTNSudIeQ+XHWkYkPzmfviXqvZqt1gvmuPfW8VMKTtt
         ukPLJSP5qB0hkeQafKtgmMKCIE8ESafRo9SpYCU/wltk2bxGPPcV1vw9deV4vNTJ
         ncTnwS5SLvlpCPLWQqipygikmGPv/IGSBsInUfFlWJCSIjMSBdQHJuI99MeIrzZ5
         sRdFapX3/CQAP/Su9y4XZE2cmjn6Je+1hd2D62oLG1V3ZT3zJ/OJg9Ur9FMkq85e
         z7Vua7ixIGAR775LFUIHmalvf8ZPuCseaXJQGkv+8K3Gn4bKvWImWfOfa9e7LgM6
         SrtN87bWG/Uz8TZp8soaeg==
From: Kohei Enju <kohei@enjuk.jp>
To: netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH net v1] net: validate skb->napi_id in RX tracepoints
Date: Mon, 20 Apr 2026 10:54:23 +0000
Message-ID: <20260420105427.162816-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279705-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 20131429A7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since commit 2bd82484bb4c ("xps: fix xps for stacked devices"),
skb->napi_id shares storage with sender_cpu. RX tracepoints using
net_dev_rx_verbose_template read skb->napi_id directly and can therefore
report sender_cpu values as if they were NAPI IDs.

For example, on the loopback path this can report 1 as napi_id, where 1
comes from raw_smp_processor_id() + 1 in the XPS path:

  # bpftrace -e 'tracepoint:net:netif_rx_entry{ print(args->napi_id); }'
  # taskset -c 0 ping -c 1 ::1

Report only valid NAPI IDs in these tracepoints and use 0 otherwise.

Fixes: 2bd82484bb4c ("xps: fix xps for stacked devices")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 include/trace/events/net.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/net.h b/include/trace/events/net.h
index fdd9ad474ce3..dbc2c5598e35 100644
--- a/include/trace/events/net.h
+++ b/include/trace/events/net.h
@@ -10,6 +10,7 @@
 #include <linux/if_vlan.h>
 #include <linux/ip.h>
 #include <linux/tracepoint.h>
+#include <net/busy_poll.h>
 
 TRACE_EVENT(net_dev_start_xmit,
 
@@ -208,7 +209,8 @@ DECLARE_EVENT_CLASS(net_dev_rx_verbose_template,
 	TP_fast_assign(
 		__assign_str(name);
 #ifdef CONFIG_NET_RX_BUSY_POLL
-		__entry->napi_id = skb->napi_id;
+		__entry->napi_id = napi_id_valid(skb->napi_id) ?
+				   skb->napi_id : 0;
 #else
 		__entry->napi_id = 0;
 #endif
-- 
2.51.0


