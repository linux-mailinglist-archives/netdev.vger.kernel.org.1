Return-Path: <netdev+bounces-296356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BzlGLDY0JmqhTQIAu9opvQ
	(envelope-from <netdev+bounces-296356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 05:17:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD08565268E
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 05:17:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=fKS23N6b;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296356-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296356-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1A583001584
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 03:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C332D346AC2;
	Mon,  8 Jun 2026 03:17:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDFC318EEE
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 03:17:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780888625; cv=none; b=KJVfxwkSIZ0NMQxI6hxVSsVge9c+wUbvKcDKYHhkxN0Dy6zYOekMpbzUTTk4NYxEethV3LmcrM3y0ZERS4oLuZ6+oPmoyzlZyGzbf154FzSNsw9gopJxix4GrCpWqcEtS6zEn6TX9KANPMSpmVyc9AL1gWvZRLaud8fMwopAaeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780888625; c=relaxed/simple;
	bh=TQRGiAVGmCz7vo36yYg63oLaBaag42j1KI/5NraW3lo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ECUEFDC7bgS4j5f467F6wOEyju1VpYWZ89kAeJhJRbMKj9avhFxeIlT95AJn7pkWsSMsgHekE9QPkj+jeObKwvVkPUZbSUyrGDQMROu4BbNAusVG/e7tO7kGi4ZsxtnP85VJOsmTDdsM2BXEfGKkFpuW+JmT5Soz6mtUlUGe7oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fKS23N6b; arc=none smtp.client-ip=209.85.216.73
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d97415004so7305920a91.2
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 20:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780888624; x=1781493424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RKuSG+SuO9LxtkxFr+o6+DtKIpoug+nBZG4hd4crKJk=;
        b=fKS23N6bJiocysu1hzr+yvVFJCDwkqsSQkNWW4iDfvLIrmxmReGYDdpqt1jKXedeo6
         1y4IUq8xbsGRnf7WOjqtkHwDm/njXZDxEowDjdjfKn65sG1AZDY1PQzKRjbK8/zO9t0X
         1qVvG4d0ydGr7wwd8GIg8/vka6DnxFxQo0V/qMwLxylQdXTTp0Zbjl6IeycVjbwaB9Iw
         IghQJiNfv7T1LjoAfB+zs0JvB1X1LOreeZfCBsLjFstKN13pvLgNTt6bHDjib0La5m1C
         +HmOh2EDfvmkNgp6OEOjJGVnNsrhBk23MiJOUatJ0T+hlULn3UJJqqy7qcehCrXw7JTa
         FO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780888624; x=1781493424;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKuSG+SuO9LxtkxFr+o6+DtKIpoug+nBZG4hd4crKJk=;
        b=c0xbpVtxyyhfIGeXfs/Cbj7B2WQfkcHiInb8w6zlHtfP1cRR8WLppDadO+k5WOJp5A
         enmyRPMWedkY2LhpeQ/x7jyaq5FkkF+tJNlt5zemve+2B2dZ5FDWUnXTAzTFxXbNiejj
         1O4AK/zaNwWOAcLYCxCV298vUgqPzVdC3pO+TNZcAruYxyB15wt3QrmWbfWurPtnv88w
         ZZimnUGAqyBzL6whYhfV1LBTYxVdvPEe3BSgU8KONUH+7aWvfBzAS15yOjmL4b2vrhJg
         ix59cO/Y90rlyHQzLQ92CDDnalxLR9a4WmvlU4PnFeOee8r5iGVVblnC3wl9kOie/r9O
         NTFg==
X-Forwarded-Encrypted: i=1; AFNElJ9ssErbal9ALh5hJZEtEAbmBNjUJMCOHsyeaNFL722Wp6tzPudfd2+JwLgdPOwK2smBFeWFVMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN0n/0GkMWdl58L0/LxVu5Z+FD7HmYNjQViaxKdNFxXXkWsA9F
	ICVgjq8LicaxDdXQ5z8XHWRK7y82z+iCAeDey6QuAhw0SwNc+xGGnx//DbiqqqU0wRg5HTD3/9w
	YZFP2Fg==
X-Received: from pjboh6.prod.google.com ([2002:a17:90b:3a46:b0:36a:fcf5:b57f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3852:b0:369:73a:326a
 with SMTP id 98e67ed59e1d1-370f096a635mr14364227a91.13.1780888623439; Sun, 07
 Jun 2026 20:17:03 -0700 (PDT)
Date: Mon,  8 Jun 2026 03:16:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260608031701.3485103-1-kuniyu@google.com>
Subject: [PATCH v4 iproute2-next] iplink_geneve: Support IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296356-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD08565268E

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
The corresponding kernel commit is afabbb56a726 ("geneve: Introduce
IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.").

v4:
  * Drop uAPI change
  * Update man

v3:
  * Use strcmp() instead of match()
  * Use print_color_string()

v2: https://lore.kernel.org/netdev/20260602185711.129769-1-kuniyu@google.com/
  * Print LOCAL/LOCAL6 even if wildcard to match the kernel behaviour

v1: https://lore.kernel.org/netdev/20260523061102.2762452-1-kuniyu@google.com/
---
 ip/iplink_geneve.c    | 41 ++++++++++++++++++++++++++++++++++++++++-
 man/man8/ip-link.8.in |  6 ++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/ip/iplink_geneve.c b/ip/iplink_geneve.c
index 62c61bce138b..a096feccbba1 100644
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
+		} else if (!strcmp(*argv, "local")) {
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
+		print_color_string(PRINT_ANY, COLOR_INET,
+				   "local",
+				   "local %s ",
+				   format_host(AF_INET, 4, &addr));
+	} else if (tb[IFLA_GENEVE_LOCAL6]) {
+		struct in6_addr addr;
+
+		memcpy(&addr, RTA_DATA(tb[IFLA_GENEVE_LOCAL6]), sizeof(struct in6_addr));
+		if (!IN6_IS_ADDR_UNSPECIFIED(&addr)) {
+			print_color_string(PRINT_ANY, COLOR_INET6,
+					   "local6",
+					   "local %s ",
+					   format_host(AF_INET6,
+						       sizeof(struct in6_addr),
+						       &addr));
+		}
+	}
+
 	if (tb[IFLA_GENEVE_TTL_INHERIT] &&
 	    rta_getattr_u8(tb[IFLA_GENEVE_TTL_INHERIT])) {
 		print_string(PRINT_FP, NULL, "ttl %s ", "inherit");
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index ef45fe08699e..be7d76524724 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -1398,6 +1398,8 @@ the following additional arguments are supported:
 .BI "ip link add " DEVICE
 .BI type " geneve " id " VNI " remote " IPADDR"
 [
+.BI local " IPADDR "
+] [
 .BI ttl " TTL "
 ] [
 .BI tos " TOS "
@@ -1428,6 +1430,10 @@ the following additional arguments are supported:
 .BI remote " IPADDR"
 - specifies the unicast destination IP address to use in outgoing packets.
 
+.sp
+.BI local " IPADDR"
+- specifies the source IP address to listen on.
+
 .sp
 .BI ttl " TTL"
 - specifies the TTL value to use in outgoing packets. "0" or "auto" means
-- 
2.54.0.1032.g2f8565e1d1-goog


