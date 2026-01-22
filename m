Return-Path: <netdev+bounces-252503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMRZHE5zcmlpkwAAu9opvQ
	(envelope-from <netdev+bounces-252503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:58:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6ACD6CCAF
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1DD330053D3
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A920A38884F;
	Thu, 22 Jan 2026 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icIJmxOZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5E2374736
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108089; cv=none; b=tQpwmN42fsjcc8gmWggf73ngArxIDK6q3ROkmppDQD/AUI4NYU2/5aSqrt4N0r25MENGLIgs+g04TBb4f/cwf2cONz0bVv8zgswfE3a0gqE0E6xqLZTAW0djZbXiIucmXV9egu+OqGZT3z4aOvcYl6/S3RCCzr0gGmvcNsVWokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108089; c=relaxed/simple;
	bh=99yqU+uOKfdvghLSyrp8Ex5B5iFEVimbkISuRbGqacg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rVSdeEijnnEdINvu2H4Qq9yZthWS13DAU8jBOKpUsct2V8AU50O+K2pN8413tYHzg2GlFSMkfG4ivQQoZwKtcs4wsHQ16eyyJHRZY+GvK1+5N5ozUAO7KEE9uzzet/idQQKtDDyVMAi5HOt95ZtRvr9GAq4EwrfctBbguuwPNgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icIJmxOZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-658072a4e56so2679866a12.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 10:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769108080; x=1769712880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nRWp0rtmJZTKy7gP8VUEPIou3M/cUalQjqQTAmYs/OU=;
        b=icIJmxOZ9txCBuxI2TTbp+wkPuTkaaCnA+JzM1zxbgywQpPo9w7Q/z+V01ilJvmohe
         Vi/z+WvzEvt8TEBc8DHFmG7rnPBffHyUYoUZYevrptCv52/zUmJbTzudB0P1K3pC3STa
         rZPcWrCj++os2u//szJ8TB+ivHynGXEdPlUqnyV+ng4mnRLs1+lsv/745G4ylx5lxlrY
         bbBX8z//u3HUTpa1EgsgrxMQbNlmWFvx68vWct768QAhcb+pfKs7VMFDbpyevm1CJu0a
         j+CgIoGFrvDNJhUrQcvQZE7s8BKDwHQ8aPmlcfZm8QPH+OUk47tIEqqsNZyjY6Anlok6
         CbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769108080; x=1769712880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRWp0rtmJZTKy7gP8VUEPIou3M/cUalQjqQTAmYs/OU=;
        b=Ni+wjbVEqOvlkB3Te74Y9MEYanwp/kwlq3N1HrGHTsWAz3LiVBGd9BmuFqvGRMjEMU
         pab+kUk4RzmHimdHvkJUJ0ExH+EWt8U1kqTD4cFk1y47n5fnvwZXbYsQZQlNdVdh0Sk+
         EimVPCe0mI8xLv0dLimSBwL9QN3nmVc2YQcrVYi6R3lrzcTrnN5mb9CxEvkyBPaOHZvO
         pcqbj87yNiSAgUym9bX/7PfUdgsxnFUGpWmohCRCrnl8WV3Ff71QOwXGH8+71RH91z12
         FBtfz3YuXLekyryDmA0mJjTuDqtZ6D3+tPxosyuLcyEwZ3xFHxhUNZwdnm77Yr7nm/VD
         R6Kw==
X-Gm-Message-State: AOJu0YxaIqq/GRV69lBug2879X/DIYzlWKPgIPivhX1cedlWsLoXC3LO
	RPLnzS+gelh+WNwCsbVPQO2ZJrX9x3Yg9mpoQg1PxtadjbJJkIhOoPxImjQxOwh1
X-Gm-Gg: AZuq6aIYDRo284Shus3UqitY+YAzqPyTSDffEbvAAim+TyzjE3Licg9tdXz3MeoXUz+
	K7UaTEKUUgTgMcPaJwwIUkTeMiis3k3K4XA4+j5dJLhHPvdyD2DrAytytQVgDfrl1FfjO6njBtH
	RKlXUYDcXfETQ8cQ1vTfkcmGwsczSAIpBq7A1jBR5Qmhm4Ah1bTuU0eKcW5ZgEI8rACujrRGXiP
	RG9A/0wZyusQ/h3LXk0sY2PerY3CZkYXbDI6b8jbV88eI7VAyGFQOOc3Y2AJ4H11aNFpqZyxL3A
	z08En7VVR+WzyDn+vWIEUoTOiOMDTpfanG6pAq3VO6rtVVEcXO9igotO5eTkNsjarFVEGbbOcmD
	WH/3yuCmZYNNsbLkkaBOnB9bp6kk5HdkRaEuMzhxLD+MDY6H3avQRNLkTF36E9i/FZOQ0KvpL52
	sCh78=
X-Received: by 2002:a17:907:3ea8:b0:b88:38e9:8f89 with SMTP id a640c23a62f3a-b885aa21fb9mr22376466b.0.1769108080124;
        Thu, 22 Jan 2026 10:54:40 -0800 (PST)
Received: from wdesk. ([192.142.54.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b7ba3f8sm5442166b.63.2026.01.22.10.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:54:39 -0800 (PST)
From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kshitiz.bartariya@zohomail.in,
	Mahdi Faramarzpour <mahdifrmx@gmail.com>
Subject: [PATCH net-next] udp: add drop count for packets in udp_prod_queue
Date: Thu, 22 Jan 2026 22:23:57 +0330
Message-Id: <20260122185357.50922-1-mahdifrmx@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,google.com,redhat.com,zohomail.in];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252503-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B6ACD6CCAF
X-Rspamd-Action: no action

This commit adds SNMP drop count increment for the packets in
per NUMA queues which were introduced in commit b650bf0977d3
("udp: remove busylock and add per NUMA queues"). note that SNMP
counters are incremented currently by the caller for skb. And
that these skbs on the intermediate queue cannot be counted
there so need similar logic in their error path.

Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
---
v5:
  - check if drop counts are non-zero before increasing countrers
v4: https://lore.kernel.org/netdev/20260108102950.49417-1-mahdifrmx@gmail.com/
  - move all changes to unlikely(to_drop) branch
v3: https://lore.kernel.org/netdev/20260105114732.140719-1-mahdifrmx@gmail.com/
  - remove the unreachable UDP_MIB_RCVBUFERRORS code
v2: https://lore.kernel.org/netdev/20260105071218.10785-1-mahdifrmx@gmail.com/
  - change ENOMEM to ENOBUFS
v1: https://lore.kernel.org/netdev/20260104105732.427691-1-mahdifrmx@gmail.com/
---
 net/ipv4/udp.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ffe074cb5..41cf8f7ab 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1793,14 +1793,31 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	}
 
 	if (unlikely(to_drop)) {
+		int err_ipv4 = 0;
+		int err_ipv6 = 0;
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


