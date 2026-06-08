Return-Path: <netdev+bounces-296547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 19ijASjAJmpBcQIAu9opvQ
	(envelope-from <netdev+bounces-296547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:14:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 620A36567DE
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:14:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jHsDWUle;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296547-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296547-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01C2F30347EE
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 13:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019F031B131;
	Mon,  8 Jun 2026 13:08:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B27F4071E3
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 13:08:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924134; cv=none; b=kqg5mSYkXN81KehJ/3J6gJNH4pRwaEpmHWfB/+ccgzqILfPhfScKdcD7CrGW9trZF48tNKoRWXpgY2Ebds+PY0CvUlT1GuWJwMMfovzEpje9s5u0yXEjO2/L/PMW5FaNf67DVOacdj8kygy4QKbUEZ32BqYq28nuLiwbcFqK2R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924134; c=relaxed/simple;
	bh=mW9iIeDA/ac2MAi/1aEwr+dm26EBjbwlnkaW0x3KJs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9wsqEMzH3gicAIhm4U6XAO0H1VMdON9bKLDupfW7GFrQ3Xw3XZkwHdVqIVhgzoFkAOzPYS1iWINLZE3zAdbrtkAz9eL590K1gp10sJPYkmrO+Rz4OctJr03DCwuj1LrSSOuXAQu4jfq1NKMYc7mipXUOnEKBdJcnZ7d4uQmjmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHsDWUle; arc=none smtp.client-ip=209.85.128.66
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-490a78fbd7bso5045795e9.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 06:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780924132; x=1781528932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znA4pd1321a2UcFVn4y31pkFipl05FPam1fYwq/eVp8=;
        b=jHsDWUleWh46s25gGS+3c2psSBjRKbC/yoFo806FyEGf8tZHnGmOVOre8Gw+0v1BJp
         +3zhPeHGOEUqJ6O1Y9SxuQe1uJXc9xIMhEC8ptzy/lEOENV1DMZLrHuoQ6HB50Lx3mmT
         KZoS7kvnxBGyiDQfjwrrRyBkGMCrfp+PjCjnaCr/FjvaYnTmDwno61vHLkqb8zsHyrCM
         rCJc6bu/fjuVrjaiFVsHZO5FfnslK+aVg2J526EbEws9QdAq4DMpLoH2hyJ3ASOks6Fi
         Nz/fnAszn55jidviV1ClX0Po+pdj2cQyWF0fpHuv9uIUSfiKLjU3J1fnZUBhLN6i0sT/
         80mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924132; x=1781528932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=znA4pd1321a2UcFVn4y31pkFipl05FPam1fYwq/eVp8=;
        b=ZK7LwFJ3mOUpXvk86rwiEginFRyg8zlnbEO6SZrSYvXYLn2RHseGgjgpQn6W96mwRq
         vQsEYsTI47fLq2LvShcyukARBu1YBdz4wZSwzPBMY6iKqFtq8vBnkmfsvSLgtieDVLeI
         uvFD/+ALjDxc8EzAG2c48voxt2SBTjJcWQB5gYR44srqMNEVWvR6TZeuzKOJ/ah4PGq+
         MCHxYGwa5BIBXq3LemQkXyj09HpWFdBTAUCTlMNL3VHvON2vHQfl40HEO7b46oOp+Qtz
         xfFp2ALLT2yszrsDj66Qb2Uk7jwYi4sfWLbj+7WTcigiwYOqbueYLOdvYLJX3j0vkUh2
         DC3Q==
X-Gm-Message-State: AOJu0YyTg8Li+TKc1jOVyMulZ9SPyyhz6ojb2+Ar4Zj0BcBvdEjYz+kc
	5sMvH8imjIjZN1q12VupZFs017JigYi55+mmEeq/g3/GejPruA9YXF8AC0PY0gWt
X-Gm-Gg: Acq92OHy4KMn6SGEicfW++qkwUK7uco2pwtfvurPpaEcKwoXZXtxetWHNCTZJGy1s4g
	epHHORkNiXIjgPug0pm40W8vfI+QeanR1I1YXBV8PUj5FYY6sMQm0dy6aSeAzZYH4rYLkLrlrmN
	tgEMJqHrjVuyeziVEb+ByjZmU2r5IReIihcANv3wIw57UynZ63zAmlbDU85Azhe/0I9SeJf4XX3
	DTtqe1shMBbf8Hcnh1zZYt0Bde3qhpiMxLY1Wei6OyrWT25JFGZ35+wa76CKi1iFGEQrtwej44q
	JYjhWGjf5nAZT0PyDqQ/9yw1C9H/LmGg52e1rreJ8SgabGgBCyiNddx4LgJf21aUmHRBcjdYdFi
	A7wML57jXSNlqyLTv8rH9u+dM8HaYGQcu9hyoXR0KA9Djv/pb0xYdk0/cco/PSpmWy8b+HBrhal
	JOhN1stb2STv4+1hw2oCvc83x7jR+xRy4=
X-Received: by 2002:a05:600c:4ec7:b0:490:b227:da9b with SMTP id 5b1f17b1804b1-490c2560197mr110961275e9.1.1780924131873;
        Mon, 08 Jun 2026 06:08:51 -0700 (PDT)
Received: from localhost ([104.28.193.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d37edbsm300135675e9.2.2026.06.08.06.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:08:51 -0700 (PDT)
From: Mariusz Klimek <maklimek97@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	ncardwell@google.com,
	shuah@kernel.org,
	kuniyu@google.com,
	alice@isovalent.com,
	Mariusz Klimek <maklimek97@gmail.com>
Subject: [PATCH net-next 02/10] ipv6: allow route exceptions with MTUs above 65535
Date: Mon,  8 Jun 2026 15:07:47 +0200
Message-ID: <20260608130755.5626-3-maklimek97@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608130755.5626-1-maklimek97@gmail.com>
References: <20260608130755.5626-1-maklimek97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296547-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:ncardwell@google.com,m:shuah@kernel.org,m:kuniyu@google.com,m:alice@isovalent.com,m:maklimek97@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,isovalent.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 620A36567DE

This patch allows route exceptions to specify an MTU above 65535 so that
PMTU discovery can settle on an PMTU above 65535 (if the MTUs along the
path allow for it).

IP6_MAX_JUMBOGRAM_MTU is set to INT_MAX rather than UINT_MAX because MTU
values and packet lengths are sometimes stored as signed integers.

Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
---
 include/linux/ipv6.h    | 6 ++++++
 include/net/ip6_route.h | 5 +++--
 net/ipv6/route.c        | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index a7421382a916..201c1615ac8e 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -196,6 +196,12 @@ static inline bool ipv6_l3mdev_skb(__u16 flags)
 #define IP6CB(skb)	((struct inet6_skb_parm*)((skb)->cb))
 #define IP6CBMTU(skb)	((struct ip6_mtuinfo *)((skb)->cb))
 
+/* IPv6 jumbogram payload length is stored into a 32bit field, but cap the max
+ * MTU to INT_MAX because MTUs and packet lengths are sometimes represented as
+ * signed ints.
+ */
+#define IP6_MAX_JUMBOGRAM_MTU INT_MAX
+
 static inline int inet6_iif(const struct sk_buff *skb)
 {
 	bool l3_slave = ipv6_l3mdev_skb(IP6CB(skb)->flags);
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 09ffe0f13ce7..9c9fbf881235 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -38,8 +38,9 @@ struct route_info {
 #define RT6_LOOKUP_F_IGNORE_LINKSTATE	0x00000040
 #define RT6_LOOKUP_F_DST_NOREF		0x00000080
 
-/* We do not (yet ?) support IPv6 jumbograms (RFC 2675)
- * Unlike IPv4, hdr->seg_len doesn't include the IPv6 header
+/* We do not (yet ?) fully support IPv6 jumbograms (RFC 2675) for all protocols.
+ * Where jumbograms are supported, IP6_MAX_JUMBOGRAM_MTU should be used instead.
+ * Unlike IPv4, hdr->seg_len doesn't include the IPv6 header.
  */
 #define IP6_MAX_MTU (0xFFFF + sizeof(struct ipv6hdr))
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 636f0120d7e3..ac38771c49cd 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1656,7 +1656,7 @@ static unsigned int fib6_mtu(const struct fib6_result *res)
 		rcu_read_unlock();
 	}
 
-	mtu = min_t(unsigned int, mtu, IP6_MAX_MTU);
+	mtu = min_t(unsigned int, mtu, IP6_MAX_JUMBOGRAM_MTU);
 
 	return mtu - lwtunnel_headroom(nh->fib_nh_lws, mtu);
 }
-- 
2.47.3


