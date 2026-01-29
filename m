Return-Path: <netdev+bounces-254655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HwTG4wee2msBQIAu9opvQ
	(envelope-from <netdev+bounces-254655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:47:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC80ADB16
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 889A23019539
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C6C37C0F5;
	Thu, 29 Jan 2026 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7NIdfwU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C58379961
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769675921; cv=none; b=WSu/BAv6CB3FOZIQUOJguIhB5MEQ7e+xdUdxV0CR0xHDSERepelPSWDQF9ebnrTs6F7jo6qjPwWztIGlBrTC5YdTOXwADdQKY+4EYIqYhUgBOhgPteUIIepcryuYdx6qmQWQztvw01DzD/aiZ6QoWj19XQdJgTIKp7SLWf0opLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769675921; c=relaxed/simple;
	bh=Vtker4lyl2lvi38SnhE/UuR/KI2fAI/2XATb1tU9EE8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b4VvQDB4X2YUIg8RAmLnm526ShUFZvYT4SuewqUILRhcb4u2NvQaDl9s8ZD2XI7GTHGnqFKfRiUoco37NIwK4e2rSSFUfhkPvtsGr3w1u+Da4q96ttGr+MoJOuGRAnNIBVFYn/V8lJtj2bhVBxI4H/GsyNQrLOTMy1O09vCKtIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7NIdfwU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48069a48629so7124305e9.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 00:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769675916; x=1770280716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H3fGmsw/yPXYFbykpa/JGZYx8vq9SSYs4JmuZVSCkbk=;
        b=E7NIdfwUzZzlCI8ZobHUuUgw3FD5J3th1gG7FDG3BHJwX6WXzfgJFFJpsXWHyVBbPW
         bwsVs95/AFl/e8oQBsn7H11akke2QxyhTd6+Bw6nXKNX8mtY8MO4SqYpSlJfrr8OI2ee
         8OtIRhQcwvfcuhVkqzVkILKmuMR1xTpt8+jiHTm15HYJUyk6KHw6sSTj15CvyMsy9LQl
         ebnpDK8k6BXvpcZHeBgnlDeEcQddWGaKSP3w8xC862YOoRhe6n/hidVh+QTV5ACR8aSV
         Z5zrSUT2oqRMGgM/QqcY7+yrjbW7avG8H6GmhSFJ6rCCJf4sYMo6PjSSZTTquTlIUcQc
         GLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769675916; x=1770280716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3fGmsw/yPXYFbykpa/JGZYx8vq9SSYs4JmuZVSCkbk=;
        b=EAMXRByUltTNiIwWnYDpeNcT4lIYcxQo1QwZFfNiFXAUP0kW5o5me1y17IyCb9mBKH
         iOB4tEDTdwXmcHsfyPa/zYAgjEjmZAOlAX+9/G5u1TddUwzWNhgSIQ0s78nXcR4gn8TY
         mwiqjPr5qd9cxjr2PkzWrOhr/mfGPVbsSJldX/5DPD4ihe/b1oCKpx5RpXWcltS90pSR
         JQARY91csdCYi09fbM041uabDoNhAxzkDVpYFlqq2tQW2ysYr5FC3sMxbbCRrhOGzlNc
         swnqUrbtRcgMWKS24E34F+oMIyAw559RB+wN+EMfvrnplZ6ZN8Haj/yJ29KROwgDyh3z
         jBIg==
X-Gm-Message-State: AOJu0YxthrVJiBPUCij4vSYNLBwzorVNmbZhtth7K+qhyFPw+K8P9vpm
	4rhiCQaarkR2AZNxSdeYwesbVw26BAJGWOFoX5wY0CTLNKdQBSDu6Ti40XoDFxDn
X-Gm-Gg: AZuq6aKof2MekLYg5WM5Vg6QnpWjNAkV9LUptRJSIYe+ne3u6/KdwDeiDFoBxNsi0aU
	kfk0i/WiLrLvWspe6TzwZ+IKWnOZJgyHPAUTMa1MzNR1AAlwk46IvXjiyRezaxLjlk4zhG6sHue
	gLYwtAwdZXk3+h5I4i7IFpxGpyPeRmLrBYFBuUaufoTvNFso/t3KeW9vwV8HOjgoGjCAfkGMeS2
	ffIAlCOgV5EobETnwzb/jzT/cjhOokBpvX5X+Qg0vpYru6sEci+ghwN4cKcYkXc7Wqq/UUz2tEq
	my3mGi6OfO9cJ1LYny8sLEjSCmzWcFUqieuFsNU693cPyMBQ0pd7qbXHROgNO6CLuPhCpR8HwKk
	xlscqRus4fsB0GfrSunmPBqFCGBjdw9lCCwWgTQBi/qWfrZ0Yyj4FG3OpHhDH9aLqQguG8L9pGT
	qj/DL9
X-Received: by 2002:a05:600c:b8a:b0:480:3b4e:41b8 with SMTP id 5b1f17b1804b1-48069c7586amr102407485e9.33.1769675915793;
        Thu, 29 Jan 2026 00:38:35 -0800 (PST)
Received: from wdesk. ([164.215.131.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066c40e04sm180260415e9.13.2026.01.29.00.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:38:35 -0800 (PST)
From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	kshitiz.bartariya@zohomail.in,
	Mahdi Faramarzpour <mahdifrmx@gmail.com>
Subject: [PATCH net-next] udp: add drop count for packets in udp_prod_queue
Date: Thu, 29 Jan 2026 12:08:06 +0330
Message-Id: <20260129083806.204752-1-mahdifrmx@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org,zohomail.in];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254655-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahdifrmx@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CCC80ADB16
X-Rspamd-Action: no action

This commit adds SNMP drop count increment for the packets in
per NUMA queues which were introduced in commit b650bf0977d3
("udp: remove busylock and add per NUMA queues"). note that SNMP
counters are incremented currently by the caller for skb. And
that these skbs on the intermediate queue cannot be counted
there so need similar logic in their error path.

Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
---
v7:
  - revert the last change and fix style
v6: https://lore.kernel.org/netdev/20260128070311.48892-1-mahdifrmx@gmail.com/
  - increasing a single counter based on socket family
v5: https://lore.kernel.org/netdev/20260122185357.50922-1-mahdifrmx@gmail.com/
  - check if drop counts are non-zero before increasing countrers
v4: https://lore.kernel.org/netdev/20260108102950.49417-1-mahdifrmx@gmail.com/
  - move all changes to unlikely(to_drop) branch
v3: https://lore.kernel.org/netdev/20260105114732.140719-1-mahdifrmx@gmail.com/
  - remove the unreachable UDP_MIB_RCVBUFERRORS code
v2: https://lore.kernel.org/netdev/20260105071218.10785-1-mahdifrmx@gmail.com/
  - change ENOMEM to ENOBUFS
v1: https://lore.kernel.org/netdev/20260104105732.427691-1-mahdifrmx@gmail.com/
---
 net/ipv4/udp.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ffe074cb5..6ad7296db 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1793,14 +1793,32 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (unlikely(to_drop)) {
+		int err_ipv4 = 0;
+		int err_ipv6 = 0;
+
 		for (nb = 0; to_drop != NULL; nb++) {
 			skb = to_drop;
+			if (skb->protocol == htons(ETH_P_IP))
+				err_ipv4++;
+			else
+				err_ipv6++;
 			to_drop = skb->next;
 			skb_mark_not_on_list(skb);
-			/* TODO: update SNMP values. */
 			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO_MEM);
 		}
 		numa_drop_add(&udp_sk(sk)->drop_counters, nb);
+		if (err_ipv4 > 0) {
+			SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_MEMERRORS,
+				       err_ipv4);
+			SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_INERRORS,
+				       err_ipv4);
+		}
+		if (err_ipv6 > 0) {
+			SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_MEMERRORS,
+				       err_ipv6);
+			SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_INERRORS,
+				       err_ipv6);
+		}
 	}
 
 	atomic_sub(total_size, &udp_prod_queue->rmem_alloc);
-- 
2.34.1


