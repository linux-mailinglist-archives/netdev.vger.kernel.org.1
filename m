Return-Path: <netdev+bounces-283616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJG1Fjhq92mhhQIAu9opvQ
	(envelope-from <netdev+bounces-283616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:31:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A36934B6419
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 17:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67BAE3009159
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 15:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D1935F196;
	Sun,  3 May 2026 15:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1GRDYvR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5253735DA4F
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777822247; cv=none; b=sEGr05nRYfa2zulvVup7lM+e+0aakVhU2LXwWFyp+6ppQjMJSS6KoYHYnR3+WAjNEX8JWZdGBhb0ABG0kTpaZDh65/3X5XIFLXAn0E2c5iY5NbICu54HEdxuZqyJU7dDQfssqquNds9wod/M5Pnk+tR+BRzoqkHfs9M4D1PhCbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777822247; c=relaxed/simple;
	bh=k4jxQxLD2xl0CQly2wxnIY73IyO8oN74+RMgHoeNGnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DT8MJXopOQthPOOQwWuQpgc0tvWHR7oUk51G0ocPzvOoA32qj2ul94yOQggtfbNtJvkV4oVLj3zL695sGsuIMGsMEAAsq3fqtQEvVkp0TY8+0ahKRRwqcPAt/K7MgY/QxPlo+GMzy6ie1Yijx7G4OsfmUd2txXWCCRKgRGHFSo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1GRDYvR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-835399c11e0so282968b3a.0
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 08:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777822244; x=1778427044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WsTMkztAHM6bdWrN7lYb7Rsiz/ESd0Q2l0Mt9QjOwg=;
        b=h1GRDYvR4ueaFe8wQlPfvvRYTObzARS+1gUsHuZeoJ8cVBRCfG+kYiSc1bBiMLb151
         OwHj1+NsnHoYDW/O/ozmJHjEbTeSVjK6vgHRU70CyIf+uZ641+trHOjRYPsM3JTxeRmO
         Gk9PsBKqgDReYh6rqajgS8TuTFKELAF6QeBC7vULhI2LMaG2O5R2Fax5WPSmux26gy6Z
         nCoLddHYWkPlg+h5BrPSenO55KBd9E7neOhnN083MqcBzH9MORHBaHxUtk/ww6WWXij/
         tzP7pyIUjepMCfzdMXXpVlwzvUqUq8K4Mn906kn+hRpTH9dAOctfXzyBIv6eY+90O3LA
         KsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777822244; x=1778427044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2WsTMkztAHM6bdWrN7lYb7Rsiz/ESd0Q2l0Mt9QjOwg=;
        b=kE4Lh5E7W3YOfLItJiJAfi7nwoJBS17WcuCJSkvxV7E9FtXgfN1s0iKekRZdNRCHao
         zzk5vGHT8yrs+St/8uu4YLGKB+92/Q6fdWwOivO54aHe6Q1KG08RBLw3ZZSWzwv92yAn
         nZS3JjWL/vFbLFUuJ6t6YzoYqa/K0h3ZoeR7vuI9VVizvuXSyl3afNAbwBSgRjCJ54ZK
         qDRHkfR7/IU8xtWLDajYFJOID4wyw85Y9vSvWNekILcae5Aba7YbKzB+arFJ1sp3HHA2
         kQ6OelwP15Bmclmy3HkA0b4sQ+gR+Q9mUsXZFaYP/HsZzmvMPGnRSDkHM0jmVf7Pd2GO
         qVSw==
X-Gm-Message-State: AOJu0Yxzk0+jdjfBGUQ7aOREJw0aosMqg5FJjY9AgCKekuSzRiqleUS7
	1attSiD+48NKSEajHaElLWNf2v0fDR8LpZ3RJYNRCSwk3xPZhJECtdKc
X-Gm-Gg: AeBDiesA8MjZANB5bNc5TTF61B1vliFiqWJB3BYqAKxRkOaaakQ41/ELnJO/+nepzuZ
	NsGZ3kTvCL5Iw2BhJhVNMorRLmU+smzXcVW7nc6Yd9ln8xfX5gBjPJpJask19QlHJDZJaVmVJGC
	cq/U4waEsyV1qpZIpfMxfAwOgtnsC1IaaaGUcpRodkGwv7ScvBxIUaT2ywCJ+rDtEvPTeaeChk6
	B9uuiJi3nrM0+oDYsN3k25OLTnx+IuY6s5EVz58N+ifJ17/O49gL28HeyAhRb6lLMSnHy9hrUSL
	WI6VHF5JVo/R9eLPdxrKOWelglpTjXpZ9KFQKhaZ/6bdbSorQv8FW+Uaqy0DP1UNFzo8kFroHcQ
	XNkqJZrC/lSwxUr/KKu5YvoLnbaRK9T/VNWmUSvm0J2/eSS5C2kld0XoWyd22rJ+kRC5o1m39Ow
	/YJgQKXqk0K6I8omL3bXJ6iTcO67Q=
X-Received: by 2002:a05:6a00:1407:b0:82a:7046:86a2 with SMTP id d2e1a72fcca58-8352d03beecmr6065057b3a.10.1777822244382;
        Sun, 03 May 2026 08:30:44 -0700 (PDT)
Received: from dev ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8352bfe7a49sm5589667b3a.46.2026.05.03.08.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 08:30:43 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Google-Original-From: Yuya Kusakabe <y-kusakabe@bbsakura.net>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Yuya Kusakabe <yuya.kusakabe@gmail.com>
Subject: [PATCH iproute2-next 2/6] seg6: add support for the End.M.GTP4.E behavior
Date: Mon,  4 May 2026 00:30:02 +0900
Message-ID: <20260503153006.900533-3-y-kusakabe@bbsakura.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260503153006.900533-2-y-kusakabe@bbsakura.net>
References: <20260503153006.900533-1-y-kusakabe@bbsakura.net>
 <20260503153006.900533-2-y-kusakabe@bbsakura.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A36934B6419
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283616-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.985];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bbsakura.net:mid,end.am:url,end.map:url,ietf.org:url,end.bm:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,end.as:url]

From: Yuya Kusakabe <yuya.kusakabe@gmail.com>

Add support for the End.M.GTP4.E behavior, which translates SRv6
traffic into IPv4/GTP-U.  Four new keywords are introduced:

  src                  IPv6 source-address template
  v4_mask_len          IPv4 DA portion of the SID, in bits (1..32)
  v6_src_prefix_len    Source UPF Prefix length P in the IPv6 SA
                       template (1..127, defaults to 64); requires
                       P + v4_mask_len <= 128
  pdu_session_type     GTP-U PDU Session Type (downlink|dl|uplink|ul
                       or 0..15)

The route prefix length is propagated through lwt_parse_encap() so
that route_prefix_len + v4_mask_len + 40 <= 128 can be enforced at
parse time.

Example:
ip -6 r a 2001:db8:1::/56 encap seg6local action End.M.GTP4.E \
    src 2001:db8::1 v4_mask_len 32 v6_src_prefix_len 64 \
    pdu_session_type ul dev sr0

Link: https://datatracker.ietf.org/doc/html/rfc9433

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/uapi/linux/seg6_local.h |   6 ++
 ip/ip_common.h                  |   2 +-
 ip/ipnexthop.c                  |   2 +-
 ip/iproute.c                    |  11 ++-
 ip/iproute_lwtunnel.c           | 159 +++++++++++++++++++++++++++++++-
 man/man8/ip-route.8.in          |  34 +++++++
 6 files changed, 203 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
index 1678db71e8e7..8bb3cdc3a649 100644
--- a/include/uapi/linux/seg6_local.h
+++ b/include/uapi/linux/seg6_local.h
@@ -29,6 +29,10 @@ enum {
 	SEG6_LOCAL_VRFTABLE,
 	SEG6_LOCAL_COUNTERS,
 	SEG6_LOCAL_FLAVORS,
+	SEG6_LOCAL_MOBILE_SRC_ADDR,
+	SEG6_LOCAL_MOBILE_V4_MASK_LEN,
+	SEG6_LOCAL_MOBILE_PDU_TYPE,
+	SEG6_LOCAL_MOBILE_V6_SRC_PREFIX_LEN,
 	__SEG6_LOCAL_MAX,
 };
 #define SEG6_LOCAL_MAX (__SEG6_LOCAL_MAX - 1)
@@ -69,6 +73,8 @@ enum {
 	SEG6_LOCAL_ACTION_END_DT46	= 16,
 	/* swap DA with new SID, leave SRH untouched (RFC 9433 Section 6.2) */
 	SEG6_LOCAL_ACTION_END_MAP	= 17,
+	/* SRv6 to IPv4/GTP-U encap (RFC 9433 Section 6.6) */
+	SEG6_LOCAL_ACTION_END_M_GTP4_E	= 18,
 
 	__SEG6_LOCAL_ACTION_MAX,
 };
diff --git a/ip/ip_common.h b/ip/ip_common.h
index 3f55ea336b37..f9a8fd6e576c 100644
--- a/ip/ip_common.h
+++ b/ip/ip_common.h
@@ -153,7 +153,7 @@ extern const struct ipstats_stat_desc ipstats_stat_desc_xstats_slave_bond_group;
 
 /* iproute_lwtunnel.c */
 int lwt_parse_encap(struct rtattr *rta, size_t len, int *argcp, char ***argvp,
-		    int encap_attr, int encap_type_attr);
+		    int encap_attr, int encap_type_attr, __u8 dst_len);
 void lwt_print_encap(FILE *fp, struct rtattr *encap_type, struct rtattr *encap);
 
 /* iplink_xdp.c */
diff --git a/ip/ipnexthop.c b/ip/ipnexthop.c
index 14b525aa0d67..aaa75680b585 100644
--- a/ip/ipnexthop.c
+++ b/ip/ipnexthop.c
@@ -1100,7 +1100,7 @@ static int ipnh_modify(int cmd, unsigned int flags, int argc, char **argv)
 			rta->rta_len = RTA_LENGTH(0);
 
 			lwt_parse_encap(rta, sizeof(buf), &argc, &argv,
-					NHA_ENCAP, NHA_ENCAP_TYPE);
+					NHA_ENCAP, NHA_ENCAP_TYPE, 0);
 
 			if (rta->rta_len > RTA_LENGTH(0)) {
 				addraw_l(&req.n, 1024, RTA_DATA(rta),
diff --git a/ip/iproute.c b/ip/iproute.c
index 61394847018f..628bccc28074 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -106,10 +106,12 @@ static void usage(void)
 		"ACTION := { End | End.X | End.T | End.DX2 | End.DX6 | End.DX4 |\n"
 		"            End.DT6 | End.DT4 | End.DT46 | End.B6 | End.B6.Encaps |\n"
 		"            End.BM | End.S | End.AS | End.AM | End.BPF |\n"
-		"            End.MAP }\n"
+		"            End.MAP | End.M.GTP4.E }\n"
 		"OPTIONS := OPTION [ OPTIONS ]\n"
 		"OPTION := { flavors FLAVORS | srh SEG6HDR | nh4 ADDR | nh6 ADDR | iif DEV | oif DEV |\n"
-		"            table TABLEID | vrftable TABLEID | endpoint PROGNAME }\n"
+		"            table TABLEID | vrftable TABLEID | endpoint PROGNAME | MOBILE_OPTION }\n"
+		"MOBILE_OPTION := { src ADDR | v4_mask_len BITS | v6_src_prefix_len BITS |\n"
+		"                   pdu_type { downlink | dl | uplink | ul | 0..15 } }\n"
 		"FLAVORS := { FLAVOR[,FLAVOR] }\n"
 		"FLAVOR := { psp | usp | usd | next-csid }\n"
 		"IOAM6HDR := trace prealloc type IOAM6_TRACE_TYPE ns IOAM6_NAMESPACE size IOAM6_TRACE_SIZE\n"
@@ -1076,7 +1078,7 @@ static int parse_one_nh(struct nlmsghdr *n, struct rtmsg *r,
 			int old_len = rta->rta_len;
 
 			if (lwt_parse_encap(rta, len, &argc, &argv,
-					    RTA_ENCAP, RTA_ENCAP_TYPE))
+					    RTA_ENCAP, RTA_ENCAP_TYPE, 0))
 				return -1;
 			rtnh->rtnh_len += rta->rta_len - old_len;
 		} else if (strcmp(*argv, "as") == 0) {
@@ -1523,7 +1525,8 @@ static int iproute_modify(int cmd, unsigned int flags, int argc, char **argv)
 			rta->rta_len = RTA_LENGTH(0);
 
 			lwt_parse_encap(rta, sizeof(buf), &argc, &argv,
-					RTA_ENCAP, RTA_ENCAP_TYPE);
+					RTA_ENCAP, RTA_ENCAP_TYPE,
+					req.r.rtm_dst_len);
 
 			if (rta->rta_len > RTA_LENGTH(0))
 				addraw_l(&req.n, 1024
diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index 15c0077a4566..1a92b7d94e88 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -406,6 +406,7 @@ static const char *seg6_action_names[SEG6_LOCAL_ACTION_MAX + 1] = {
 	[SEG6_LOCAL_ACTION_END_BPF]		= "End.BPF",
 	[SEG6_LOCAL_ACTION_END_DT46]		= "End.DT46",
 	[SEG6_LOCAL_ACTION_END_MAP]		= "End.MAP",
+	[SEG6_LOCAL_ACTION_END_M_GTP4_E]	= "End.M.GTP4.E",
 };
 
 static const char *format_action_type(int action)
@@ -577,15 +578,92 @@ static void print_encap_seg6local(FILE *fp, struct rtattr *encap)
 
 	if (tb[SEG6_LOCAL_FLAVORS])
 		print_seg6_local_flavors(fp, tb[SEG6_LOCAL_FLAVORS]);
+
+	if (tb[SEG6_LOCAL_MOBILE_SRC_ADDR])
+		print_string(PRINT_ANY, "src", "src %s ",
+			     rt_addr_n2a_rta(AF_INET6,
+					     tb[SEG6_LOCAL_MOBILE_SRC_ADDR]));
+
+	if (tb[SEG6_LOCAL_MOBILE_V4_MASK_LEN])
+		print_uint(PRINT_ANY, "v4_mask_len", "v4_mask_len %u ",
+			   rta_getattr_u8(tb[SEG6_LOCAL_MOBILE_V4_MASK_LEN]));
+
+	if (tb[SEG6_LOCAL_MOBILE_V6_SRC_PREFIX_LEN])
+		print_uint(PRINT_ANY, "v6_src_prefix_len",
+			   "v6_src_prefix_len %u ",
+			   rta_getattr_u8(tb[SEG6_LOCAL_MOBILE_V6_SRC_PREFIX_LEN]));
+
+	if (tb[SEG6_LOCAL_MOBILE_PDU_TYPE]) {
+		__u8 t = rta_getattr_u8(tb[SEG6_LOCAL_MOBILE_PDU_TYPE]);
+		const char *name = NULL;
+
+		switch (t) {
+		case 0:
+			name = "downlink";
+			break;
+		case 1:
+			name = "uplink";
+			break;
+		}
+
+		if (name)
+			print_string(PRINT_ANY, "pdu_type",
+				     "pdu_type %s ", name);
+		else
+			print_uint(PRINT_ANY, "pdu_type",
+				   "pdu_type %u ", t);
+	}
 }
 
-static void seg6local_action_check_attrs(int action, int nh6_ok)
+static void seg6local_action_check_attrs(int action, int srh_ok, int nh6_ok,
+					 int mobile_src_ok,
+					 int mobile_v4mask_ok,
+					 int mobile_v6src_plen_ok,
+					 __u8 v4_mask_len,
+					 __u8 v6_src_prefix_len,
+					 __u8 dst_len)
 {
 	switch (action) {
 	case SEG6_LOCAL_ACTION_END_MAP:
 		if (!nh6_ok)
 			invarg("End.MAP requires \"nh6\"\n", "");
 		break;
+	case SEG6_LOCAL_ACTION_END_M_GTP4_E:
+		if (!mobile_src_ok || !mobile_v4mask_ok)
+			invarg("End.M.GTP4.E requires \"src\" and \"v4_mask_len\"\n",
+			       "");
+		if (srh_ok)
+			invarg("End.M.GTP4.E does not accept \"srh\"\n", "");
+		/*
+		 * The IPv6 source-address layout per RFC 9433 Section 6.6
+		 * Figure 10 packs the Source UPF Prefix (P bits) followed
+		 * by the IPv4 SA portion (v4_mask_len bits) and padding
+		 * inside the 128-bit IPv6 SA, so P + v4_mask_len <= 128.
+		 */
+		if (mobile_v6src_plen_ok &&
+		    (unsigned int)v6_src_prefix_len +
+		    (unsigned int)v4_mask_len > 128)
+			invarg("End.M.GTP4.E requires \"v6_src_prefix_len\" +"
+			       " \"v4_mask_len\" <= 128\n", "");
+		/*
+		 * The egress SID layout (Locator | IPv4 DA | Args.Mob.Session)
+		 * must fit in the 128-bit IPv6 destination address.  The
+		 * locator length here is the route prefix length the SID is
+		 * installed under.  dst_len == 0 means the caller did not
+		 * propagate the route prefix (e.g. nexthop encap), in which
+		 * case we leave the check to the kernel at install time.
+		 */
+		if (dst_len &&
+		    (unsigned int)dst_len + (unsigned int)v4_mask_len + 40 > 128)
+			invarg("End.M.GTP4.E requires route_prefix_len +"
+			       " \"v4_mask_len\" + 40 <= 128\n", "");
+		break;
+	default:
+		if (mobile_src_ok || mobile_v4mask_ok || mobile_v6src_plen_ok)
+			invarg("\"src\", \"v4_mask_len\", and"
+			       " \"v6_src_prefix_len\" are only valid for"
+			       " SRv6 Mobile User Plane actions\n", "");
+		break;
 	}
 }
 
@@ -1456,11 +1534,13 @@ static int seg6local_parse_flavors(struct rtattr *rta, size_t len,
 }
 
 static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
-				 char ***argvp)
+				 char ***argvp, __u8 dst_len)
 {
 	int nh4_ok = 0, nh6_ok = 0, iif_ok = 0, oif_ok = 0, flavors_ok = 0;
 	int segs_ok = 0, hmac_ok = 0, table_ok = 0, vrftable_ok = 0;
 	int action_ok = 0, srh_ok = 0, bpf_ok = 0, counters_ok = 0;
+	int mobile_src_ok = 0, mobile_v4mask_ok = 0, mobile_pdusess_ok = 0;
+	int mobile_v6src_plen_ok = 0;
 	__u32 action = 0, table, vrftable, iif, oif;
 	struct ipv6_sr_hdr *srh;
 	char **argv = *argvp;
@@ -1468,6 +1548,7 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
 	char segbuf[1024];
 	inet_prefix addr;
 	__u32 hmac = 0;
+	__u8 v4_mask_len = 0, v6_src_prefix_len = 0;
 	int ret = 0;
 
 	while (argc > 0) {
@@ -1569,6 +1650,72 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
 			if (lwt_parse_bpf(rta, len, &argc, &argv, SEG6_LOCAL_BPF,
 			    BPF_PROG_TYPE_LWT_SEG6LOCAL) < 0)
 				exit(-1);
+		} else if (strcmp(*argv, "src") == 0) {
+			/*
+			 * Mobile User Plane "src" template; scoped to the
+			 * seg6local block and unrelated to the top-level
+			 * "src" prefsrc keyword.
+			 */
+			NEXT_ARG();
+			if (mobile_src_ok++)
+				duparg2("src", *argv);
+			get_addr(&addr, *argv, AF_INET6);
+			ret = rta_addattr_l(rta, len, SEG6_LOCAL_MOBILE_SRC_ADDR,
+					    &addr.data, addr.bytelen);
+		} else if (strcmp(*argv, "v4_mask_len") == 0) {
+			NEXT_ARG();
+			if (mobile_v4mask_ok++)
+				duparg2("v4_mask_len", *argv);
+			if (get_u8(&v4_mask_len, *argv, 0) ||
+			    v4_mask_len == 0 || v4_mask_len > 32)
+				invarg("\"v4_mask_len\" must be in the range 1..32\n",
+				       *argv);
+			ret = rta_addattr8(rta, len, SEG6_LOCAL_MOBILE_V4_MASK_LEN,
+					   v4_mask_len);
+		} else if (strcmp(*argv, "v6_src_prefix_len") == 0) {
+			NEXT_ARG();
+			if (mobile_v6src_plen_ok++)
+				duparg2("v6_src_prefix_len", *argv);
+			/*
+			 * Per RFC 9433 Section 6.6 Figure 10, the IPv6 SA is
+			 * "Source UPF Prefix (P bits) | IPv4 SA (b bits) |
+			 * padding (128 - P - b)".  P must be a non-zero
+			 * multiple of 8 up to 128; the combined check
+			 * (P + v4_mask_len <= 128) is enforced per-action.
+			 */
+			if (get_u8(&v6_src_prefix_len, *argv, 0) ||
+			    v6_src_prefix_len == 0 ||
+			    v6_src_prefix_len > 127)
+				invarg("\"v6_src_prefix_len\" must be in the range 1..127\n",
+				       *argv);
+			ret = rta_addattr8(rta, len,
+					   SEG6_LOCAL_MOBILE_V6_SRC_PREFIX_LEN,
+					   v6_src_prefix_len);
+		} else if (strcmp(*argv, "pdu_type") == 0) {
+			__u8 psc_type;
+
+			NEXT_ARG();
+			if (mobile_pdusess_ok++)
+				duparg2("pdu_type", *argv);
+			/*
+			 * 3GPP TS 38.415 PDU Session Type is a 4-bit field; the
+			 * kernel mirrors that range (0..15).  0 = DL, 1 = UL.
+			 */
+			if (strcmp(*argv, "downlink") == 0 ||
+			    strcmp(*argv, "dl") == 0) {
+				psc_type = 0;
+			} else if (strcmp(*argv, "uplink") == 0 ||
+				   strcmp(*argv, "ul") == 0) {
+				psc_type = 1;
+			} else if (get_u8(&psc_type, *argv, 0) ||
+				   psc_type > 15) {
+				invarg("invalid \"pdu_type\" value"
+				       " (must be downlink|dl|uplink|ul"
+				       " or 0..15)\n", *argv);
+			}
+			ret = rta_addattr8(rta, len,
+					   SEG6_LOCAL_MOBILE_PDU_TYPE,
+					   psc_type);
 		} else {
 			break;
 		}
@@ -1582,7 +1729,9 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
 		exit(-1);
 	}
 
-	seg6local_action_check_attrs(action, nh6_ok);
+	seg6local_action_check_attrs(action, srh_ok, nh6_ok, mobile_src_ok,
+				     mobile_v4mask_ok, mobile_v6src_plen_ok,
+				     v4_mask_len, v6_src_prefix_len, dst_len);
 
 	if (srh_ok) {
 		int srhlen;
@@ -2289,7 +2438,7 @@ static int parse_encap_xfrm(struct rtattr *rta, size_t len,
 }
 
 int lwt_parse_encap(struct rtattr *rta, size_t len, int *argcp, char ***argvp,
-		    int encap_attr, int encap_type_attr)
+		    int encap_attr, int encap_type_attr, __u8 dst_len)
 {
 	struct rtattr *nest;
 	int argc = *argcp;
@@ -2328,7 +2477,7 @@ int lwt_parse_encap(struct rtattr *rta, size_t len, int *argcp, char ***argvp,
 		ret = parse_encap_seg6(rta, len, &argc, &argv);
 		break;
 	case LWTUNNEL_ENCAP_SEG6_LOCAL:
-		ret = parse_encap_seg6local(rta, len, &argc, &argv);
+		ret = parse_encap_seg6local(rta, len, &argc, &argv, dst_len);
 		break;
 	case LWTUNNEL_ENCAP_RPL:
 		ret = parse_encap_rpl(rta, len, &argc, &argv);
diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index c0b1e87ad022..a878d4375f03 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -1033,6 +1033,40 @@ with the configured next SID
 and forward via the IPv6 FIB. The Segment Routing Header is left
 untouched.
 
+.B End.M.GTP4.E src
+.IR ADDRESS
+.B v4_mask_len
+.IR BITS
+.RB [ "v6_src_prefix_len"
+.IR BITS ]
+.RB [ "pdu_type"
+.IR DIR ]
+- SRv6 Mobile User Plane End.M.GTP4.E behavior (RFC 9433 Section 6.6).
+At the SR egress gateway, the matching SRv6 packet is converted into
+an IPv4/UDP/GTP-U packet for delivery to a legacy IPv4-attached gNB or
+eNB.  The IPv6 destination address of the matching SID encodes
+.IR Locator " | " "IPv4 DA" " (\fBv4_mask_len\fR bits) | "
+.IR "Args.Mob.Session" " (40 bits, RFC 9433 Section 6.1)" ,
+and the IPv6 source address is built from
+.B src
+as
+.IR "Source UPF Prefix" " (\fBv6_src_prefix_len\fR bits) | "
+.IR "IPv4 SA" " (\fBv4_mask_len\fR bits) | padding" .
+.B v4_mask_len
+must be in 1..32 and
+.B v6_src_prefix_len
+in 1..127 (default 64); the route prefix length plus
+.BR v4_mask_len " + 40"
+and
+.BR v6_src_prefix_len " + " v4_mask_len
+must each fit in 128 bits.
+.B pdu_type
+.RB ( downlink | dl | uplink | ul " or " 0..15 )
+forces a GTP-U PDU Session Container (3GPP TS 38.415) with the given
+PDU Type; when omitted no Container is inserted, so 5G N3 deployments
+must set it explicitly.
+The action only accepts packets with Segments Left = 0 or no SRH.
+
 .B Flavors parameters
 
 The flavors represent additional operations that can modify or extend a
-- 
2.50.1


