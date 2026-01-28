Return-Path: <netdev+bounces-254414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMo1G7tbemm35QEAu9opvQ
	(envelope-from <netdev+bounces-254414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:55:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6829A7F35
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E29A83013867
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6186436F427;
	Wed, 28 Jan 2026 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C1dR8ubk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E562C28AAEE
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626551; cv=none; b=Le4oXmDWVQQEJGHqAIIi4nU23DGCQLzmHmfn62n9zAU2i2cJtZJzIC+ZSx7ykyoiSMbIexWmhsj64QL3oQ6+AnDSYIZDoaaGcHQGJYvkOqSaiC2q6l9Y3Ctx+y+McPFQswaDkPUN4hcKGKH1hHuUhoChwfoxl/BlcjTzYsU/zwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626551; c=relaxed/simple;
	bh=4sEz2VoxMP+LI4h0ZsT1LkK74861Mx7cpOxVUdrnGOs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZnKbQMbKHsmSfI5Rw7kOreCx57SdYbnVTrPcIO7sLLUcAsqFFu6spmILcZ/ZYlX4gWxa6oaU33v37wjlPjYRZ3PWRA/hg6OmKOTLQC/hLwgoG6WENpkd04KUhyf4Tyup9ql3lGyNud/U1psLvckcM8T/KyPpQbfWH0q8S8Ka7U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C1dR8ubk; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c277fe676eso56660485a.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769626549; x=1770231349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ghh46kZJNoiWH745I0ybK4zRgokPEdXhpdKREegy6yE=;
        b=C1dR8ubkLJnZLNCaoDHkr1KBbCDDrUit1fm4yKSwMC1bKh/Fx/k/34rbU83+IPHdQO
         VKOX4f7uX1poVACMIbIL2T8lR7wQej2KlsVYbu4xy0mui6frS6WRmyDINJi45CAEKZXM
         Rc57fWoJtRLBAXhed5z7zvcx8jAhnt8Gas0gSLBY1bLfF2e2f50LvsUQCwDkEcYZji2i
         LGv1/1GDSOXt3ss6LZRFsrWcF0ejcqUPHmzi4bU3mHn/tW5lxi6u27igALrai32q/Fep
         N0GnIe8xN0ZAhKOuDrZOMn/2QS1m3l1TxWuwz7LxAQbqint08IsiMSch06W3nrbprPmB
         x+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769626549; x=1770231349;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ghh46kZJNoiWH745I0ybK4zRgokPEdXhpdKREegy6yE=;
        b=Q7YjGHr+oDn9xkwobLpxD0bMaxMCwAxojxf50J/lCNZr5BlTIV409SDwBgY8nEgTIi
         6RmA8hfg1y9Q81vjBqP67Od6H3KjVSSjNaJD7njm8Omir6n/m38FNvdpRNfx/+6cuTev
         b0mRzpl5v4aBXNwMIos7amgxhAMqRUamk1Xd7M7LnQlqvDiet4Oxq45ZwMp6vavIcWCT
         qtyx65vv9uvml5XlSWOFpbXp95lO6dwOzs/1/KuTOR31jCiTKiiS+sbGP0IJ2bMRKCiZ
         9fM3RnAGAQ1BKxnm8c0BWH8zJ/B+UA9jE0Mu8leRSPYsmQVoUWVGhKFZ/JbC0RfqtkcS
         4rPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdhQgRFSfPGPTKfO1ceDYRo0P2kr/ZYjG9IFgxhMKTvm1W2mPz1/uYmcU8f1IpiJDoAeIU+4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYMjz93M7WiNRpRLiL+RIfeY4vR0N7oZClno3ZTCJEiRheKGwi
	opwY2GuE5DfobbPwp9qu76ZuZTcMvcmKHaa8n7XFtKXyB+5UYDh6GSocSscYMTkf09cAqLmMXBz
	vlS8w1JKU5T6H2w==
X-Received: from qkla23.prod.google.com ([2002:a05:620a:1257:b0:8c2:3ee9:f2c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a95:b0:8c5:25dc:29c4 with SMTP id af79cd13be357-8c70b873f83mr790622985a.35.1769626548875;
 Wed, 28 Jan 2026 10:55:48 -0800 (PST)
Date: Wed, 28 Jan 2026 18:55:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.217.geba53bf80e-goog
Message-ID: <20260128185548.3738781-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: optimize fl6_update_dst()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254414-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6829A7F35
X-Rspamd-Action: no action

fl6_update_dst() is called for every TCP (and others) transmit,
and is a nop for common cases.

Split it in two parts :

1) fl6_update_dst() inline helper, small and fast.

2) __fl6_update_dst() for the exception, out of line.

Small size increase to get better TX performance.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 2/2 grow/shrink: 8/0 up/down: 296/-125 (171)
Function                                     old     new   delta
__fl6_update_dst                               -     104    +104
rawv6_sendmsg                               2244    2284     +40
udpv6_sendmsg                               3013    3043     +30
tcp_v6_connect                              1514    1534     +20
cookie_v6_check                             1501    1519     +18
ip6_datagram_dst_update                      673     690     +17
inet6_sk_rebuild_header                      499     516     +17
inet6_csk_route_socket                       507     524     +17
inet6_csk_route_req                          343     360     +17
__pfx___fl6_update_dst                         -      16     +16
__pfx_fl6_update_dst                          16       -     -16
fl6_update_dst                               109       -    -109
Total: Before=22570304, After=22570475, chg +0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ipv6.h | 16 +++++++++++++---
 net/ipv6/exthdrs.c | 14 +++++++-------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index c7f597da01cd92293b9ffbd9e692dea75fd581b8..cf2203ff2bfd2b42381aba196578cd2668796c8b 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1174,9 +1174,19 @@ int ipv6_find_hdr(const struct sk_buff *skb, unsigned int *offset, int target,
 
 int ipv6_find_tlv(const struct sk_buff *skb, int offset, int type);
 
-struct in6_addr *fl6_update_dst(struct flowi6 *fl6,
-				const struct ipv6_txoptions *opt,
-				struct in6_addr *orig);
+struct in6_addr *__fl6_update_dst(struct flowi6 *fl6,
+				  const struct ipv6_txoptions *opt,
+				  struct in6_addr *orig);
+
+static inline struct in6_addr *
+fl6_update_dst(struct flowi6 *fl6, const struct ipv6_txoptions *opt,
+	       struct in6_addr *orig)
+{
+	if (likely(!opt))
+		return NULL;
+
+	return __fl6_update_dst(fl6, opt, orig);
+}
 
 /*
  *	socket options (ipv6_sockglue.c)
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 54088fa0c09d068d35779e3cafd721cd24e00ea8..ae173abdca9965fb4be2a0565c81d1e24c5535c7 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -1336,21 +1336,21 @@ struct ipv6_txoptions *__ipv6_fixup_options(struct ipv6_txoptions *opt_space,
 EXPORT_SYMBOL_GPL(__ipv6_fixup_options);
 
 /**
- * fl6_update_dst - update flowi destination address with info given
+ * __fl6_update_dst - update flowi destination address with info given
  *                  by srcrt option, if any.
  *
  * @fl6: flowi6 for which daddr is to be updated
  * @opt: struct ipv6_txoptions in which to look for srcrt opt
  * @orig: copy of original daddr address if modified
  *
- * Returns NULL if no txoptions or no srcrt, otherwise returns orig
+ * Returns NULL if no srcrt or invalid srcrt type, otherwise returns orig
  * and initial value of fl6->daddr set in orig
  */
-struct in6_addr *fl6_update_dst(struct flowi6 *fl6,
-				const struct ipv6_txoptions *opt,
-				struct in6_addr *orig)
+struct in6_addr *__fl6_update_dst(struct flowi6 *fl6,
+				  const struct ipv6_txoptions *opt,
+				  struct in6_addr *orig)
 {
-	if (!opt || !opt->srcrt)
+	if (!opt->srcrt)
 		return NULL;
 
 	*orig = fl6->daddr;
@@ -1374,4 +1374,4 @@ struct in6_addr *fl6_update_dst(struct flowi6 *fl6,
 
 	return orig;
 }
-EXPORT_SYMBOL_GPL(fl6_update_dst);
+EXPORT_SYMBOL_GPL(__fl6_update_dst);
-- 
2.53.0.rc1.217.geba53bf80e-goog


