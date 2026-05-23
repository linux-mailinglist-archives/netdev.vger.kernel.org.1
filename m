Return-Path: <netdev+bounces-291043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UkR5DQBFEWpfjQYAu9opvQ
	(envelope-from <netdev+bounces-291043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:11:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 950365BD662
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D76E300F157
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 06:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214FF23D28C;
	Sat, 23 May 2026 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZ3EJvlV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889AF2032D
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 06:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779516668; cv=none; b=oI3qCwMP45SdoWfwGOIApmkb7SzKJ8eA7FEUi9wPQJJUQsY5tbaPjM5/a+WiwGF8zKL219R5iDF4TbhvTmy3ysfn6DBmNHD0rC8ltbhAC5M+SX8jMgJUvz2kESm4HnO4carpr15Iqc6Dp+EmAakxGXv4oHLtnm13R5CoaRVHXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779516668; c=relaxed/simple;
	bh=vqnWN2ioluozPyX1eyS1YK2taR8Iu8K5F9NrXyGVE8I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=g4kjKDW1648LPGYWJ5jN2tz7mgUqKiGa1AvXnrejb2ha59tCnMehR1YNK9ANV5Cnwcevk9FqGIllah1dq7w9ai1Jj2937pWW02Ib4VIVknqkUQ2r7VS7JVxu4J+fLUCijPxoCXD4ZGXfKsZFfoMGqCJUbaPFBfWsiyOHdwy+rJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IZ3EJvlV; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2babc42244aso187206355ad.3
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779516666; x=1780121466; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r7QlYiuvrP6p778+lt+iroZIc3lCFiuMK40pLLMk8fY=;
        b=IZ3EJvlVNfQtSFLTXXUZ8331Cv7bspP14xoG1OnkyZJ9tPXhCRq/bo92aoumB5ivcu
         /0qj4W5aEpyx0HAOBfIZ8zQjOs+NHxyDOhZchQLj/wv+nAJZccS7JlUUfeIEbkJGlnuW
         87oK9T7FkJonwzkDQC+D69FoFv3oBAQw9c1ZNfFEFRFqJFqKI3g4x16/4kBEAr63sXhu
         6SfsLpm5fWbbVv0duBrgqfFMy56xcNDOFp0+IDSWd2VjY17nuyGMnDDFaBuOlIYqawcl
         vZ/drkCHk+a37BIrVDw88U9W/Azu7YgZYvKU+tv7W8fBK/BOD/yArugZs8lU0xvgUPsw
         CxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779516666; x=1780121466;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7QlYiuvrP6p778+lt+iroZIc3lCFiuMK40pLLMk8fY=;
        b=Qwq29/S7HkTynWUThvhSkSLshobaPzzh+JKLOKEcAED8xJRw8sXe6ych38cOoJsuak
         mBvLZp06paCM502f+ojGaj56TsDgrf2xbBARnopj69NbNZSA2QlzupNhG7/GFatD17eu
         gQZfGPPylLeiuLZ8y2QLZVP76a81jkLfHsS+BY7s09bP7vNq2lXGQmJ5te5OD8pnM6ln
         RCBfNfxROtdTjPwJqNQCs6oMWNhdrj+RmIEjLpBzEgYT04e+u8CN47bTB9DMufb42Hfp
         wUQnFUTws5fe5XrE+qvcW7OacKZFsUf6S9yiJGQSZUb0RFxRlaax74Ulo3LcYVdlgrSS
         J8sg==
X-Forwarded-Encrypted: i=1; AFNElJ8HKGF/rWzBZl9KAcVOj7Xzv3Un3v252oBUC1Dg2ObALhYM2qI0hZd3CW6HNlCbPtEt37ZmRSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFjnY6+jE3XJDWVaTpJcSnVCeviIblLjwP9xrzEL/ROVkMZdXl
	w1SdS272lVAX0SIxOC/lABTlDpRv8CZta5G2a4Fod3CnWWCGmNRUIUG0oUzRMy8/XnYrFbEtzoc
	yGvSZ0A==
X-Received: from pgmk13.prod.google.com ([2002:a63:5a4d:0:b0:c79:39f0:12f2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:594:b0:3aa:f5a5:1c37
 with SMTP id adf61e73a8af0-3b328cb9665mr6548867637.11.1779516665423; Fri, 22
 May 2026 23:11:05 -0700 (PDT)
Date: Sat, 23 May 2026 06:10:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523061102.2762452-1-kuniyu@google.com>
Subject: [PATCH v1 iproute2-next] iplink_geneve: Support IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Stephen Hemminger <stephen@networkplumber.org>, David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291043-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,saddr.family:url]
X-Rspamd-Queue-Id: 950365BD662
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6 allow specifying a local
IPv4/IPv6 address for the backend UDP socket of a GENEVE devcie.

Let's support the attributes with the "local" keyword.

  # for i in $(seq 1 2);
  do
          ip link add geneve4_${i} type geneve local 192.168.0.${i} external
          ip addr add 192.168.0.${i}/24 dev geneve4_${i}
          ip link set geneve4_${i} up

          ip link add geneve6_${i} type geneve local 2001:9292::${i} external
          ip addr add 2001:9292::${i}/64 dev geneve6_${i} nodad
          ip link set geneve6_${i} up
  done

  # ip -d l | grep geneve
  9: geneve4_1: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
      geneve external id 0 local 192.168.0.1 ...
  10: geneve6_1: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
      geneve external id 0 local 2001:9292::1 ...
  11: geneve4_2: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
      geneve external id 0 local 192.168.0.2 ...
  12: geneve6_2: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
      geneve external id 0 local 2001:9292::2 ...

  # ss -ua | grep geneve
  UNCONN 0      0         192.168.0.2:geneve      0.0.0.0:*
  UNCONN 0      0         192.168.0.1:geneve      0.0.0.0:*
  UNCONN 0      0      [2001:9292::2]:geneve            *:*
  UNCONN 0      0      [2001:9292::1]:geneve            *:*

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
The corresponding kernel patch will be posted separately.
---
 include/uapi/linux/if_link.h |  2 ++
 ip/iplink_geneve.c           | 43 +++++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index a8c64be26f2c..d692d466da6b 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1487,6 +1487,8 @@ enum {
 	IFLA_GENEVE_INNER_PROTO_INHERIT,
 	IFLA_GENEVE_PORT_RANGE,
 	IFLA_GENEVE_GRO_HINT,
+	IFLA_GENEVE_LOCAL,
+	IFLA_GENEVE_LOCAL6,
 	__IFLA_GENEVE_MAX
 };
 #define IFLA_GENEVE_MAX	(__IFLA_GENEVE_MAX - 1)
diff --git a/ip/iplink_geneve.c b/ip/iplink_geneve.c
index 62c61bce138b..8d21722b598c 100644
--- a/ip/iplink_geneve.c
+++ b/ip/iplink_geneve.c
@@ -18,6 +18,7 @@ static void print_explain(FILE *f)
 	fprintf(f,
 		"Usage: ... geneve id VNI\n"
 		"		remote ADDR\n"
+		"		[ local ADDR ]\n"
 		"		[ ttl TTL ]\n"
 		"		[ tos TOS ]\n"
 		"		[ df DF ]\n"
@@ -56,7 +57,7 @@ static void check_duparg(__u64 *attrs, int type, const char *key,
 static int geneve_parse_opt(struct link_util *lu, int argc, char **argv,
 			  struct nlmsghdr *n)
 {
-	inet_prefix daddr;
+	inet_prefix daddr, saddr;
 	__u32 vni = 0;
 	__u32 label = 0;
 	__u8 ttl = 0;
@@ -72,6 +73,7 @@ static int geneve_parse_opt(struct link_util *lu, int argc, char **argv,
 	bool inner_proto_inherit = false;
 
 	inet_prefix_reset(&daddr);
+	inet_prefix_reset(&saddr);
 
 	while (argc > 0) {
 		if (!matches(*argv, "id") ||
@@ -88,6 +90,13 @@ static int geneve_parse_opt(struct link_util *lu, int argc, char **argv,
 			get_addr(&daddr, *argv, AF_UNSPEC);
 			if (!is_addrtype_inet_not_multi(&daddr))
 				invarg("invalid remote address", *argv);
+		} else if (!matches(*argv, "local")) {
+			NEXT_ARG();
+			check_duparg(&attrs, IFLA_GENEVE_LOCAL, "local",
+				     *argv);
+			get_addr(&saddr, *argv, AF_UNSPEC);
+			if (!is_addrtype_inet_not_multi(&saddr))
+				invarg("invalid local address", *argv);
 		} else if (!matches(*argv, "ttl") ||
 			   !matches(*argv, "hoplimit")) {
 			unsigned int uval;
@@ -221,8 +230,17 @@ static int geneve_parse_opt(struct link_util *lu, int argc, char **argv,
 	if (is_addrtype_inet(&daddr)) {
 		int type = (daddr.family == AF_INET) ? IFLA_GENEVE_REMOTE :
 						       IFLA_GENEVE_REMOTE6;
+
 		addattr_l(n, 1024, type, daddr.data, daddr.bytelen);
 	}
+
+	if (is_addrtype_inet(&saddr)) {
+		int type = (saddr.family == AF_INET) ? IFLA_GENEVE_LOCAL :
+						       IFLA_GENEVE_LOCAL6;
+
+		addattr_l(n, 1024, type, saddr.data, saddr.bytelen);
+	}
+
 	if (!set_op || GENEVE_ATTRSET(attrs, IFLA_GENEVE_LABEL))
 		addattr32(n, 1024, IFLA_GENEVE_LABEL, label);
 	if (!set_op || GENEVE_ATTRSET(attrs, IFLA_GENEVE_TTL))
@@ -285,6 +303,29 @@ static void geneve_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		}
 	}
 
+	if (tb[IFLA_GENEVE_LOCAL]) {
+		__be32 addr = rta_getattr_u32(tb[IFLA_GENEVE_LOCAL]);
+
+		if (addr)
+			print_string(PRINT_ANY,
+				     "local",
+				     "local %s ",
+				     format_host(AF_INET, 4, &addr));
+	} else if (tb[IFLA_GENEVE_LOCAL6]) {
+		struct in6_addr addr;
+
+		memcpy(&addr, RTA_DATA(tb[IFLA_GENEVE_LOCAL6]), sizeof(struct in6_addr));
+		if (!IN6_IS_ADDR_UNSPECIFIED(&addr)) {
+			if (!IN6_IS_ADDR_MULTICAST(&addr))
+				print_string(PRINT_ANY,
+					     "local6",
+					     "local %s ",
+					     format_host(AF_INET6,
+							 sizeof(struct in6_addr),
+							 &addr));
+		}
+	}
+
 	if (tb[IFLA_GENEVE_TTL_INHERIT] &&
 	    rta_getattr_u8(tb[IFLA_GENEVE_TTL_INHERIT])) {
 		print_string(PRINT_FP, NULL, "ttl %s ", "inherit");
-- 
2.54.0.746.g67dd491aae-goog


