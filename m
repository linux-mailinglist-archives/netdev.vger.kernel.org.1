Return-Path: <netdev+bounces-294356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IUZlFQspH2ogiQAAu9opvQ
	(envelope-from <netdev+bounces-294356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:03:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0482631457
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:03:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=kIhXdUit;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294356-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294356-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CE47302DB46
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 18:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393453939C0;
	Tue,  2 Jun 2026 18:57:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6403624C8
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 18:57:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426637; cv=none; b=C7o+mivkm73giH7PpknjV+e3GQPDBzwlymx1ndfeAVcEtVlEIxsI9f10coopJDWeGnnuIZhfYsuwd3KRXN0EHZYrJT7y07xONuPPdwcpcoaXJk0ES5ABDSnp/5oIsdWGMGY9d8pDXw+9BjjpOcpH5ZIzEhi1tXIWjwVzikl2fdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426637; c=relaxed/simple;
	bh=spwt2LndfjkNmS5Zc4zIlPKZDk2gmpJfb6PloNaXPTU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=l9NpVnkDQ+W4QGAlq604fkFsJEXBgvh18h3iwZaZPNFoKHkV44osojE7uiS2kIJRzwq5mZy/IAt+OWsIO7yqKJyufY83UuFBCmAnp9/zyUmo0qaCbrHc6NsNLDw1LBy0vjL3zo0olhXCTv+FZiNNDEYvAMG0CXy4pXt9IyX9h9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kIhXdUit; arc=none smtp.client-ip=209.85.214.202
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0d0516ad7so30179775ad.0
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 11:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780426635; x=1781031435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MmKXi3uk3rqkLwkiiwJpSyZR4FDy7932+K+sNz017A8=;
        b=kIhXdUitWv7JGzk9VCGXC1qNLlHgGIjjCxHsOLx7NPcVPf2W46tdHHDQc78gkCBu2h
         rVIf+wGIxhbhMxLPySbsFRBGKqZi1wS6M5QfD82gD7NW9vXi0JebQerm9fJY6YdV90W4
         u9ZM2GZAt3XxDk+issR1TSZSV6etHba/BC6p+LDFISZF/0anZdyUgPsViBkCOPVT39dx
         /r9jbdCvHO9LXZahZbEHQQWUMkKGWJLImSpsYRFfso9smV59Zy2YxifHQ9wUInmGY6jX
         INKyBx8kfkKFL78ZLFOJqFWlO1yP02umv5INTig7N5zXPkpwJSM5VMTAj8DdaM7Q5+FY
         nw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780426635; x=1781031435;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MmKXi3uk3rqkLwkiiwJpSyZR4FDy7932+K+sNz017A8=;
        b=EXre5RQbAiGPVMOnL0ZVqEk6u6SA5aDGqK6VmHQXTyKX+gDFCO233JMpIid3eBgFmo
         ZSLPhCrO2uo0EIvuEJzz8Nhx+PaRNgBsxMHn3pzr0m/ZaA0rlG4RJAmoMJTOVaTONJQi
         +6mFsVAJ8JcxYzNBVuBSByjgOXGn2/wZzAAWYZOJl4V8xkrg7KlQnn3GwqM9pt8TGVQ8
         viHPNq7+fck4NdoRVFgpSbu1CIwiuKIKxj4XfVQEzvSVfWC8/s9/VlyPLw9XI4GUkNv2
         Cq+NBZYpKy8EE4PHDNRtv2DnU3H0V54MwTiOgvoX3hAF+SEHM/RgH5g13w/uyFjNSkc1
         H8OQ==
X-Forwarded-Encrypted: i=1; AFNElJ/fjvzxDHA6lZma5GaGu9j+rD4mVvgEXh3wqi021jcPTXXe/G1+plxD/iRLInhVV/e5oBBpG1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBfL6BNckAFa5or0CbG9pYbx5ud4akNJo/xClxd9JknZL54G4s
	HIOXP+J9gZ/u5YlCHDvhTOaBJhmM9ehq9xF2P1swM5Y3wzqgYepiUrOfLFfgrCT81kAboikSK+q
	L7umxFw==
X-Received: from plcj5.prod.google.com ([2002:a17:902:f245:b0:2bc:b04b:d29c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1786:b0:2c0:c38d:9d51
 with SMTP id d9443c01a7336-2c163d8c184mr338295ad.21.1780426634847; Tue, 02
 Jun 2026 11:57:14 -0700 (PDT)
Date: Tue,  2 Jun 2026 18:56:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602185711.129769-1-kuniyu@google.com>
Subject: [PATCH v2 iproute2-next] iplink_geneve: Support IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Stephen Hemminger <stephen@networkplumber.org>, David Ahern <dsahern@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294356-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:dsahern@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,daddr.family:url,saddr.family:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0482631457

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

Note that kernel dumps the wildcard address if the device created
with IFLA_GENEVE_COLLECT_METADATA is not dualstack.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
The corresponding kernel patch will be posted separately.

v2: Print LOCAL/LOCAL6 even if wildcard to match the kernel dump behaviour

v1: https://lore.kernel.org/netdev/20260523061102.2762452-1-kuniyu@google.com/
---
 include/uapi/linux/if_link.h |  2 ++
 ip/iplink_geneve.c           | 41 +++++++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

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
index 62c61bce138b..46a446b8b79b 100644
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
@@ -285,6 +303,27 @@ static void geneve_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		}
 	}
 
+	if (tb[IFLA_GENEVE_LOCAL]) {
+		__be32 addr = rta_getattr_u32(tb[IFLA_GENEVE_LOCAL]);
+
+		print_string(PRINT_ANY,
+			     "local",
+			     "local %s ",
+			     format_host(AF_INET, 4, &addr));
+	} else if (tb[IFLA_GENEVE_LOCAL6]) {
+		struct in6_addr addr;
+
+		memcpy(&addr, RTA_DATA(tb[IFLA_GENEVE_LOCAL6]), sizeof(struct in6_addr));
+		if (!IN6_IS_ADDR_UNSPECIFIED(&addr)) {
+			print_string(PRINT_ANY,
+				     "local6",
+				     "local %s ",
+				     format_host(AF_INET6,
+						 sizeof(struct in6_addr),
+						 &addr));
+		}
+	}
+
 	if (tb[IFLA_GENEVE_TTL_INHERIT] &&
 	    rta_getattr_u8(tb[IFLA_GENEVE_TTL_INHERIT])) {
 		print_string(PRINT_FP, NULL, "ttl %s ", "inherit");
-- 
2.54.0.1013.g208068f2d8-goog


