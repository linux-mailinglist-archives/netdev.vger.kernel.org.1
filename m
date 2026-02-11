Return-Path: <netdev+bounces-258183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zC6fJ9n/i2lDegAAu9opvQ
	(envelope-from <netdev+bounces-258183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:04:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECBA1211D5
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 05:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3E5730138B4
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 04:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AB6352C54;
	Wed, 11 Feb 2026 04:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4oZuvbX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC68C1B81D3
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 04:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770782676; cv=none; b=KSKvQrhnABdY78tqy+hWu4dtXnZ9XPbDP7suz7/uc+dNHdyL8Z+nA4w5DiEoju4MSC2PGBDsgFdmMer9neMtkTOKpaPI3grpepN6h+V0TMDlPQ9OysIJpNOjA4expx/UYu+wKkygdOUZ+RzyA/C45aMWEdY3w3b8dPhFdM2w6Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770782676; c=relaxed/simple;
	bh=vInIhH2qUu+MiCpO+ovUKuYOhUF587f8Sg4/aiEREsw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DTCwFfMZlF5AYbA+umQKIArJqbk9jXl7cJf39vRgnYF6sM5GZADqAnot5Vi9Ed6yBGOdNu6RlKk7mmrnh+car5f6iDSrDVQwRCA3hE+AYImjrsShCmjkWx7SiFYXyN5B/N6WbFKbNHsH41gkFH0flUrOtah/gj/Jso9ZmmDrMmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4oZuvbX; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8230f2140beso195039b3a.1
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 20:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770782675; x=1771387475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=diZKL0fO83WwA8uTysAbSPqJhpbzZYbjR9OPediVPWo=;
        b=K4oZuvbXBUeA639KpfD6prvzBGGDnOYDjbGqqcC4FI7SctsS7x9VF5J2nNNN9PCjO3
         emW16CCqkbat5nnAtphT1rtzRV5IJmusiX1rgCdu+QfDY67kQapj5cApR8gHUACDKOT2
         AiHlWGkzPrkxnogD8jSpq82Fegg2hhUrA9I+1zRsgG+GnBHaevsv//XM8W2cp/oidAS0
         a5uWoLhBsTdaDnj9clpnK4Hdn4D0GmqFFWykkizt/AJ6ypbLSd0o4G9EJrjX1zOVGNZj
         z/j8lv5AnKqSXesiwfgjTzg5edH1gWx4fOskaUJ39kbU+YQFlcz01GK6xm+QbPL9VJFY
         2AnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770782675; x=1771387475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diZKL0fO83WwA8uTysAbSPqJhpbzZYbjR9OPediVPWo=;
        b=V3QCltrriOqiGj1jXz8JS3d5aRK5ACwWPZNCjUT8V7AXzc+t9zMIv1aIkZSLuMIjei
         50pAAuVKa+VrlOnxTNeXl7GatedlYPp2ePCKu3kAZmOSb7IG92KGJgmYGTwRQ7SuqS2F
         JOpprc8x09mHMrhjsvmlQvep0aKG3gWRUdsvPs7b3kyk/czxzy5uGA8u1agql1jc7NN1
         +g3vdK/Rjf+8m0Hp42KjUdMLccwFtAIT49gtfHK6C2UBz8hZ+FxaXaQV5lAXmXI+l9fZ
         F7kj8RGpeUWp24PeOlY7P1jMaIfJHQS9/MXR64uDKQ93BzVAZWLBGlf/N1tW0QMd1gP3
         JE8A==
X-Gm-Message-State: AOJu0YwHqcnBgbrR/UqOlzvpt2VW4YEprynJC+HGFPkeneO+O2SLi62v
	5821c7hBcdmkGuJ8/DtpgakOtF5yC6RO9H9/SZhAZFIx1NGz4GaIMhSbkghoX/Yr+5o=
X-Gm-Gg: AZuq6aJIHyzBZiOG0HTGMKq+lcs+6hS24ouQhXq1Z+FN3vtm/x5Qz+UvWl+zVjEHJF6
	Aa5xt5NvO+PdeRdkHXMm0gyBAEARvr89FE5WKXmF0DmeXd5PcWvIrrdK73RCsF2PxMNrvteceLh
	zdoL6CE9WGe85Xym0qMwEBbXSWD1k1Hs7d4xHMz43l4qLY/4uUo7ToWCBoutAIz4RjFuWZgXeg/
	ChZsEOSMM+5AfUVeeNfD8UE3ZKidvRfkJ5s4gtzAz9j2TyfdSqBoFlvmSghdY/sP3ynQGjYxzpG
	9S5XYpNbWp2ecBcddaoyZFNOeLvG1E1+AzU5dmeOQcHQ5C8MleAzdEYe8V4QhFYKtlRKQJruawA
	il0qn7YuP1XggQSA8qY19Dd4/tLF7nhbd+p+sNgeSofjtBJDBfaw29gLmVfkXUUbehhrvdJ9IV+
	QTfFpWKKNc2gbPC5g3LqSV3nVb107LkZE6lHkIzftXDfXmosswHj1Pfg==
X-Received: by 2002:a05:6a21:820e:b0:38e:92f6:9ab1 with SMTP id adf61e73a8af0-39415c46d39mr4165383637.22.1770782674832;
        Tue, 10 Feb 2026 20:04:34 -0800 (PST)
Received: from localhost.localdomain ([240e:3b5:d070:3800:7835:e89e:360a:7254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567af7d392sm482540a91.2.2026.02.10.20.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 20:04:34 -0800 (PST)
From: Qanux <qjx1298677004@gmail.com>
To: netdev@vger.kernel.org
Cc: justin.iurman@uliege.be,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org
Subject: [PATCH net v2] ipv6: ioam: fix heap buffer overflow in __ioam6_fill_trace_data()
Date: Wed, 11 Feb 2026 12:04:12 +0800
Message-Id: <20260211040412.86195-1-qjx1298677004@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-258183-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qjx1298677004@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0ECBA1211D5
X-Rspamd-Action: no action

On the receive path, __ioam6_fill_trace_data() uses trace->nodelen
to decide how much data to write for each node. It trusts this field
as-is from the incoming packet, with no consistency check against
trace->type (the 24-bit field that tells which data items are
present). A crafted packet can set nodelen=0 while setting type bits
0-21, causing the function to write ~100 bytes past the allocated
region (into skb_shared_info), which corrupts adjacent heap memory
and leads to a kernel panic.

Add a shared helper ioam6_trace_compute_nodelen() in ioam6.c to
derive the expected nodelen from the type field, and use it:

  - in ioam6_iptunnel.c (send path, existing validation) to replace
    the open-coded computation;
  - in exthdrs.c (receive path, ipv6_hop_ioam) to drop packets whose
    nodelen is inconsistent with the type field, before any data is
    written.

Per RFC 9197, bits 12-21 are each short (4-octet) fields, so they
are included in IOAM6_MASK_SHORT_FIELDS (changed from 0xff100000 to
0xff1ffc00).

Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Trace")
Cc: stable@vger.kernel.org
Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>
---
v1 -> v2:
  - Don't recompute nodelen in the data plane; instead, validate
    nodelen consistency in ipv6_hop_ioam() on the receive path and
    drop inconsistent packets.
  - Add shared helper ioam6_trace_compute_nodelen() in ioam6.c,
    reuse it in both ioam6_iptunnel.c (send) and exthdrs.c (receive).
  - Per RFC 9197, include bits 12-21 in IOAM6_MASK_SHORT_FIELDS
    (0xff100000 -> 0xff1ffc00) instead of a separate UNDEF mask.

Thanks to Justin Iurman for the detailed review and suggestions.

The patch has been tested with the PoC that previously triggered the
heap overflow. After applying this fix, the crafted packet is now
correctly dropped at the receive path, and the kernel no longer panics.
The patched kernel compiles and boots successfully.
---
 include/net/ioam6.h       |  2 ++
 net/ipv6/exthdrs.c        |  5 +++++
 net/ipv6/ioam6.c          | 14 ++++++++++++++
 net/ipv6/ioam6_iptunnel.c | 10 +---------
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/net/ioam6.h b/include/net/ioam6.h
index 2cbbee6e8..a75912fe2 100644
--- a/include/net/ioam6.h
+++ b/include/net/ioam6.h
@@ -60,6 +60,8 @@ void ioam6_fill_trace_data(struct sk_buff *skb,
 			   struct ioam6_trace_hdr *trace,
 			   bool is_input);
 
+u8 ioam6_trace_compute_nodelen(u32 trace_type);
+
 int ioam6_init(void);
 void ioam6_exit(void);
 
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index a23eb8734..50062f98d 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -930,6 +930,11 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 		if (hdr->opt_len < 2 + sizeof(*trace) + trace->remlen * 4)
 			goto drop;
 
+		/* Inconsistent Pre-allocated Trace header */
+		if (trace->nodelen !=
+		    ioam6_trace_compute_nodelen(be32_to_cpu(trace->type_be32)))
+			goto drop;
+
 		/* Ignore if the IOAM namespace is unknown */
 		ns = ioam6_namespace(dev_net(skb->dev), trace->namespace_id);
 		if (!ns)
diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
index 9553a3200..08b7ac8c9 100644
--- a/net/ipv6/ioam6.c
+++ b/net/ipv6/ioam6.c
@@ -690,6 +690,20 @@ struct ioam6_namespace *ioam6_namespace(struct net *net, __be16 id)
 	return rhashtable_lookup_fast(&nsdata->namespaces, &id, rht_ns_params);
 }
 
+#define IOAM6_MASK_SHORT_FIELDS 0xff1ffc00
+#define IOAM6_MASK_WIDE_FIELDS  0x00e00000
+
+u8 ioam6_trace_compute_nodelen(u32 trace_type)
+{
+	u8 nodelen = hweight32(trace_type & IOAM6_MASK_SHORT_FIELDS)
+				* (sizeof(__be32) / 4);
+
+	nodelen += hweight32(trace_type & IOAM6_MASK_WIDE_FIELDS)
+				* (sizeof(__be64) / 4);
+
+	return nodelen;
+}
+
 static void __ioam6_fill_trace_data(struct sk_buff *skb,
 				    struct ioam6_namespace *ns,
 				    struct ioam6_trace_hdr *trace,
diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index 1fe7894f1..b9f6d892a 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -22,9 +22,6 @@
 #include <net/ip6_route.h>
 #include <net/addrconf.h>
 
-#define IOAM6_MASK_SHORT_FIELDS 0xff100000
-#define IOAM6_MASK_WIDE_FIELDS 0xe00000
-
 struct ioam6_lwt_encap {
 	struct ipv6_hopopt_hdr eh;
 	u8 pad[2];			/* 2-octet padding for 4n-alignment */
@@ -93,13 +90,8 @@ static bool ioam6_validate_trace_hdr(struct ioam6_trace_hdr *trace)
 	    trace->type.bit21 | trace->type.bit23)
 		return false;
 
-	trace->nodelen = 0;
 	fields = be32_to_cpu(trace->type_be32);
-
-	trace->nodelen += hweight32(fields & IOAM6_MASK_SHORT_FIELDS)
-				* (sizeof(__be32) / 4);
-	trace->nodelen += hweight32(fields & IOAM6_MASK_WIDE_FIELDS)
-				* (sizeof(__be64) / 4);
+	trace->nodelen = ioam6_trace_compute_nodelen(fields);
 
 	return true;
 }
-- 
2.34.1

