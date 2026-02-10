Return-Path: <netdev+bounces-258024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD/9NcilimnqMgAAu9opvQ
	(envelope-from <netdev+bounces-258024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 04:28:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B9A116BCC
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 04:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 217DC301A7DB
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 03:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55132D97B4;
	Tue, 10 Feb 2026 03:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm7f8SUl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFAE3A1C9
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 03:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770694084; cv=none; b=JA8Oq06QfPX3VrOWr9Ii6YPHxebctdWImbRbZbpEz0UWnYvLoCQo20ypeh9ryd7IWP59GJiXOqqNcwIEUQ+pbCuTIR/OgSDxYxHbygbUxIGTA10+OdwOGXu8OW2AqzJay73XdSftGtRY8r9DszUp+RcvwBc5pPU8bWyE1ed/Mtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770694084; c=relaxed/simple;
	bh=dPO4aBtz4/xd8+hzaGR5My3SJbmyPFjfOPpyUdvS30c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jq9v6OB4wCRe8Htem3itD10vzdm6dpBw4psxqurtuEy9TPWxH4YLqrSyN5GeyW50jMEuE5w5d5ghHn2FHpOOKqrM6awuvVy7iOtxqZ48PxzQx5Bp/6rdKudKml95cA0tCILJY5IEu1CuKrenLrXM1M0cwVBlsO5N24+3Ugmpo5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lm7f8SUl; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-823f9f81da5so2752333b3a.1
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 19:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770694083; x=1771298883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MQx792PntSG3k5/exKTLxbUGHMcY8/9ZdhX6r0T38D0=;
        b=Lm7f8SUl8e7jZFeoBNwHTGalPr6374NDILdwSpPp5OGevIVy29Tq33waXg6YF0fCI0
         jqSDto8ZUVM5bCJSxS0KulT/yu+fWC6ZtWUACKD8G7QfO2InwdcCePk2iMa2Kq1kMmUt
         2jHJku7mjXNMG+vM04M22Kx3pdJChZ7NOsWncyJ8IttkytOjOBQR4YdocMalB5F+EQZO
         nGrbNSaRc/C+dKg1ouPsj67au+DbeYVoa9KuWAlAeEY/gRMrQchxv4R+yJMHRfrXwvbO
         9rr4oQ2b7GeeQ6XsJ7svASXlUPZp2wMBzp0Wem5KkneI6LG8RauEtUrG0B+kNh34HZgg
         HYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770694083; x=1771298883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQx792PntSG3k5/exKTLxbUGHMcY8/9ZdhX6r0T38D0=;
        b=N8IltMwlshRYyCQf7GanrEbEK22/f+GXuFcF+ebUCU94uHxGwuWPuffcxIdB+FNseF
         yeWSxnqqZCQC1eCVWAQi16uWNX7tcy1DANRSX574+IuSOyxH8zEq6jts+3YdNVtK/Pbm
         7HQNWxjfJwg78Ksld3QH8+wvFyfHutYN7nsNnYZKsYoEL7PiS1JtBNSwshHzmVgKjY6O
         XwEtQVA0XQJaGHMmuDz+sw4AArav3B0JqSmhFekiyUsracVjqo8Za5xXr7zAyYCsrT7U
         pzRzwZ5nTS1syRa4v5zItUqsNqEXfzEvgHD++P/jpjqf+IymQeaDZyq4iXzb7gfnaJDe
         GMzA==
X-Gm-Message-State: AOJu0YxbjlaFJNmHdsLd1i4M/QIDZ/x1ZF/t2H64AJf8m3Ntb1+fRxpg
	G35yx2t9ISB9REjwn5UiJFYmYdLk5zBQi9rIk7mOmmlzdRiFOiAQEt4rFZiJT9pwQbLNoA==
X-Gm-Gg: AZuq6aL/oCFAFlf6jkOViHLlPefcdFTpsPiXouIzhu1Q5/6d0G1QbekrcwYkH/NYLIA
	Ojmf2KgEu05Po13HM4fxNe+Y3JFSpqX/ufiDIJPKjfcRuLeUufbkKcbUSQZ8eyzxEoitVC/s4mI
	FcODI7C3N6PzcjgCur6+UBF8iaVS9M4gstUK1YmhCfvDWsVbNgDGvkeKjoFjBTI0vosg6cX60tY
	6F2aT9bDQfBn+CfT+hbpzt5qPEhjlftQsKXb1rDFm2AVJb9HgsF/hCS9v7hZLWagw96F2UnOoNK
	dSRwUGYb+FyP2vejLcrlWKEIzYwlRoLf8rEI1eq2oTe85uijTjKeNY9LUCZjdu8Z0wcGtq+eyXP
	pYhC4Is7aUheMc/F1HEVLANOGiRgodruhaung1XytJ+OlBpDVNjzM09Iz+XzdtZ4WxvPwf4HiD+
	wx5aGomyr5pReZoGHSqfrduI4G
X-Received: by 2002:a05:6a20:918e:b0:393:e16d:516 with SMTP id adf61e73a8af0-39417844f0dmr706328637.9.1770694082830;
        Mon, 09 Feb 2026 19:28:02 -0800 (PST)
Received: from localhost.localdomain ([240e:3b5:d06c:3ed0::1001])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e8ba1bsm917243a91.9.2026.02.09.19.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 19:28:02 -0800 (PST)
From: Qanux <qjx1298677004@gmail.com>
To: netdev@vger.kernel.org
Cc: justin.iurman@uliege.be,
	kuba@kernel.org,
	dsahern@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net
Subject: [PATCH net] ipv6: ioam: fix heap buffer overflow in __ioam6_fill_trace_data()
Date: Tue, 10 Feb 2026 11:25:50 +0800
Message-Id: <20260210032550.20219-1-qjx1298677004@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258024-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[qjx1298677004@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 51B9A116BCC
X-Rspamd-Action: no action

The IPv6 IOAM Pre-allocated Trace receive path (ipv6_hop_ioam in
net/ipv6/exthdrs.c) does not validate that the nodelen field in the
trace header is consistent with the type bitmap.

When a crafted packet arrives with nodelen=0 but with type bits set,
__ioam6_fill_trace_data() computes the write pointer at the end of
the trace data buffer and then writes past it, overflowing into
adjacent memory (skb_shared_info). This corrupts critical SKB metadata,
leading to a kernel panic when the SKB is freed.

The send path properly validates the trace header via
ioam6_validate_trace_hdr() which recomputes nodelen from the type
bitmap. However, calling that function from the receive path would
break forward compatibility, as it rejects packets with undefined
type bits (bit 12-21) that the receive path intentionally accepts.

Fix by recomputing nodelen directly from the type bitmap inside
ioam6_fill_trace_data() before using it, preserving the receive
path's forward compatibility while preventing the overflow.

Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Trace")
Cc: stable@vger.kernel.org
Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>
---
 include/net/ioam6.h       |  4 ++++
 net/ipv6/ioam6.c          | 10 +++++++++-
 net/ipv6/ioam6_iptunnel.c |  3 ---
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/net/ioam6.h b/include/net/ioam6.h
index abfa518cd917..a3f2a1e4fd19 100644
--- a/include/net/ioam6.h
+++ b/include/net/ioam6.h
@@ -14,6 +14,10 @@
 #include <linux/ioam6_genl.h>
 #include <linux/rhashtable-types.h>
 
+#define IOAM6_MASK_SHORT_FIELDS 0xff100000
+#define IOAM6_MASK_WIDE_FIELDS  0x00e00000
+#define IOAM6_MASK_UNDEF_FIELDS 0x000ffc00
+
 struct ioam6_namespace {
 	struct rhash_head head;
 	struct rcu_head rcu;
diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
index 02aboriginal1..02bfixedcode 100644
--- a/net/ipv6/ioam6.c
+++ b/net/ipv6/ioam6.c
@@ -929,12 +929,20 @@ void ioam6_fill_trace_data(struct sk_buff *skb,
 			    bool is_input)
 {
 	struct ioam6_schema *sc;
+	u32 fields;
 	u8 sclen = 0;
 
 	/* Skip if Overflow flag is set
 	 */
 	if (trace->overflow)
 		return;
 
+	trace->nodelen = 0;
+	fields = be32_to_cpu(trace->type_be32);
+	trace->nodelen += hweight32(fields & IOAM6_MASK_SHORT_FIELDS)
+				* (sizeof(__be32) / 4);
+	trace->nodelen += hweight32(fields & IOAM6_MASK_WIDE_FIELDS)
+				* (sizeof(__be64) / 4);
+	trace->nodelen += hweight32(fields & IOAM6_MASK_UNDEF_FIELDS)
+				* (sizeof(__be32) / 4);
 
 	/* NodeLen does not include Opaque State Snapshot length. We need to
 	 * take it into account if the corresponding bit is set (bit 22) and
diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index 7abcdef12345..7abcfixedcode 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -23,9 +23,6 @@
 #include <net/ip6_route.h>
 #include <net/addrconf.h>
 
-#define IOAM6_MASK_SHORT_FIELDS 0xff100000
-#define IOAM6_MASK_WIDE_FIELDS  0x00e00000
-
 struct ioam6_lwt_encap {
 	struct ipv6_hopopt_hdr eh;
 	u8 pad[2];			/* 2-octet padding for 4n-alignment */
-- 
2.39.0

