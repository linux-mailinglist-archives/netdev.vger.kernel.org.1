Return-Path: <netdev+bounces-295048-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a11jKkkMIWqK+gAAu9opvQ
	(envelope-from <netdev+bounces-295048-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 07:25:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BC063CF38
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 07:25:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=IsRfF3pN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295048-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295048-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CC4B301A3A4
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 05:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226B63B9DBB;
	Thu,  4 Jun 2026 05:21:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B042E2DEA7B
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 05:21:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780550491; cv=none; b=fd/5mSpr962Ox2VZh/efSFzyO5Hvz9MdMRrHTsfxRSjNYLvWlZCMioLhIgZ5jE5QkL/BAaG/8qepiIY6KwXaNavwCkdNUeLr5o5SWOZO7MYsq6d7w/wu5bH5jgXgIuxz08nIJu5sjPAcgYD3wgGkErrIA0WEggEBov+BvH637a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780550491; c=relaxed/simple;
	bh=SfQJwA9Sb/MdhRB/9/DeCxcyrmWv/r149I3YH5xCQjI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RfLCs+E+tp6zR5vNQiq5oFoscUKhTHmIf33gncDS4SGze1FJhXEtDLu/dTMp7xSXXoCOunBj6U2k7zMD/3TggCZilBOpo6SPwgIWPifl1nPwwoSn4tvoY6QNrb38dAo49nCz9msnzMVie6w+sCVzH5x4slPVTha7aRTsJV3CoMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IsRfF3pN; arc=none smtp.client-ip=209.85.216.74
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d98b6f019so360646a91.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 22:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780550489; x=1781155289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+rjFgIsSmNRrQkWYUNOq0RuHcrrToad9G/QXv3/0/PA=;
        b=IsRfF3pNynZRO5Nz5wEE/xhBt1vRylAjiHuHfo3GnOn7mw8xM0N/qA/gs5D4J0Ra5u
         rGk8SfjQnPyJ5aPkVr5KXEdWtiJM8ZRTBMLPBM4kpO0N5FlmEDgmF7EoFTjLQwb5Kb28
         L2RV+idYb/ZN83BPaaPr25rrdb0h11P/ARCTYOx4u+2u5lydLSvVkDlTS6ne11p+DLQz
         VpE32C+7i59ATcClyw/t6UkS6XjU2e9yL113sRDkrYAjMGOUORu3VPVxAyT+rxpdwUb/
         269LflgZaSoBXDPWDNTv2nCHJGacdc9gxEuDq3NO0AYbFXib3qj356SktFxxApAmu5Ik
         Ws4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780550489; x=1781155289;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+rjFgIsSmNRrQkWYUNOq0RuHcrrToad9G/QXv3/0/PA=;
        b=WQqsFrnRmvyH3QlA7PnluxDvGrjrc9T4Ut6Z8npPtTtedGPKDPeOfqxkH1YbKLnDbv
         67KxkDMGMdSBOT1hfGXGTkDAjO68dYmzUn6AGxukbV/el56Abl8zfc9XJJNc0k/+DXRF
         fNM0mdeNBADJLwjYz+S8KTlOEkqe6IYrcGHmztoEIyJzxUibsJdpTf2ogPnhHB2vqKCz
         2jSoHDeVy0e7gt6ah5JqfDNL0wDHVJuXCfTu6MIKOeEy4UAeictiQQFJFwkdnjo9kSwC
         8vhMG2Df+okx6IQCWGHXfJZn35gCAdNhLd3GLxF/wnLaFNKlZJoxzVSMrUR8puik13XY
         Q8Lg==
X-Forwarded-Encrypted: i=1; AFNElJ8uvDfOTUodg6vQgvq5X9jGKbJzZyRcClUgYLHFSnR9G3Bx2kOw0Fh2vdNB1kTh3N++TMffP9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFexkA87VTd65OeUKFaJk3leki9v4klyxgKwqMADXK/nm1nLcM
	+SFS5xViOPbA8RWTAfz6YGOToW0456x9AmhUI5M5budH/YtZApmH4fVP2/q2hURmr1GWaga5D5t
	LkQD/9w==
X-Received: from pjbos13.prod.google.com ([2002:a17:90b:1ccd:b0:366:d37:7fce])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d2cb:b0:36d:a510:f8eb
 with SMTP id 98e67ed59e1d1-36e31ea179amr5747543a91.3.1780550488763; Wed, 03
 Jun 2026 22:21:28 -0700 (PDT)
Date: Thu,  4 Jun 2026 05:21:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604052127.2227300-1-kuniyu@google.com>
Subject: [PATCH v3 iproute2-next] iplink_geneve: Support IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.
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
	TAGGED_FROM(0.00)[bounces-295048-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00BC063CF38

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

v3:
  * Use strcmp() instead of match()
  * Use print_color_string()

v2: https://lore.kernel.org/netdev/20260602185711.129769-1-kuniyu@google.com/
  * Print LOCAL/LOCAL6 even if wildcard to match the kernel behaviour

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
-- 
2.54.0.1032.g2f8565e1d1-goog


