Return-Path: <netdev+bounces-283941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENRLByjF+GlQ0gIAu9opvQ
	(envelope-from <netdev+bounces-283941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:11:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CCF4C1378
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF01F3020EAF
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A22B3E1209;
	Mon,  4 May 2026 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRzdWu9X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5013E277E
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911054; cv=none; b=RL48JZFyc1ki8MbKL0z5iNfitVZTPQ7knsejrrzjK8ldXW5gg9l0LYVudbknv3KxiuHQRW+NVgunOhFbuwREHlQer+2E7jmo/XWZS7N9GJxXmu5n8eQVj5smPnfRV8iJdg5NW1R5dIR2uC6atwGClCNvyViSD8dIUhOTR5aJ5/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911054; c=relaxed/simple;
	bh=N41eYelmek7FKVGJkZZhT9y4QWmD14OVoyv30Aoz3IU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJVL01+wD5anZ7I2q1VXeAhjCsj08+nhDT+9W6a8a+yUkob7keJptmYF5a+fSOeQYczlYL9f42ZVb3GIdFdIjO1dp0ZbR8n/VRw/9FXH8ZP3sMPaJTe1aV8BVcRKMwvkEir+DOqKE2w4b3l979xVS8rTC/0NV2mvolu3jLA8Yjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRzdWu9X; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ad617d5b80so25680575ad.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 09:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777911051; x=1778515851; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QotclV6Z297c9OfTnYSYlblAJCKdyExfYy4E/q/wmDs=;
        b=iRzdWu9Xfbwn8O2Th88xRfK16gwUKCe9rtUriVhNVFpOLIHo80g9Ga7W9Jhl9QLPe7
         WuAAa3OL4deaKH7DhRB0Nd5znVZQayazSPCeGkClgySqnLiTnAr7jNdnPyudwF333IC/
         UNMPv5Z6px0Bz1NQ4QHbAvtDXBryNo4/A84NIGGkiy1R/V2RbSRzfqhxW8SDqZJaszUy
         Dvo+r/qo8KpHZGglDJlqXDiARwdZ62GXN4IZz0gw2FxLmLSDwhL7YB2RhHldCB8SMtT4
         qBzRVLWobfP8QMMZ8qejRH1IZf57djUFo7pht7CKBS8dU8hfB5pJQ0J1XrFlVKX4PPDZ
         2PSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777911051; x=1778515851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QotclV6Z297c9OfTnYSYlblAJCKdyExfYy4E/q/wmDs=;
        b=Xxc117fYCPL2N5b+1QEO6T3EqtG2WMKNLrmNX/tkBt7yZpLFbx9V45+hFcwNSzvT7w
         2Vb4AB3/48YIcHJ2ZSPU50ZMV4xUo/HWveQqHyZs6GD7Ik0UUtiv528abR1oAajbjLAO
         O2/ieMp7UDbxpz3khztqivvRXSsdEs3sdrmqgTX+okG8nf9iDi+BGZ6j2j6HkIgHLu+1
         lMW788aDrELIkK823o/8xt9wCbXRVhPLbO1i8ymFJ/RYDrFvMZnDzqE2Boa4NpOzLTZH
         Lk1CPzX2rGLfbxUUlQ+iZM7enNd1cOONN7+L71G5aRjPGQQFp+qS+Xv39UpyqjHn1btQ
         kj0A==
X-Forwarded-Encrypted: i=1; AFNElJ8OeuwdxcBDnwsQALU6jthphrvPLalfZU8jcdzTNHrvUYqkA3ZNgUrbID3U+XdIRjKHky1ktHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYCbLuQ5n+AV0CMRzgIyH4Snt5rHXNKUPfXoA44CEu3bOF6ANB
	uyPbtmRNdAyLY+1+C5TPqLOoXpk50rdefqIeUc6BeTt50QjHLsQZjL6TeZnMgiTk
X-Gm-Gg: AeBDiet2eCUKD2AZYfXlE2Qi/zuNeYNEa5dSPjsCoc/yKjUv+M2aae7ksuSRo33AXMq
	XQyWT3r/Ukv7JFQ2RKLlEOMF8ZO0ySrvGhlwR1+ZI44tj364KNyG/82REx7+BvE44kFkKar71Od
	40ZmYZtve4g3E4k4Zf2KESkkUVWhuUur+cr1eTg5XgosWD1JTEEXnAnIgTXG937eaA4iJQzzBHz
	8S0mTjkt+fseWq0XCp/hnGFoqumYiavygruIxRjhcwHPNqDSkwNR0hlAptU7fGnvXlhGTR+oeoi
	n4b6P4sopQVMt2jXyyNau5D34q0ZHNj8B1OsIOxGfdb8mCaYrO6a+6UwCbOFIdliie4xJLX0ccW
	Tp81bkIlf2XCX5GbZWd4hWsbdfIOySnECYJ8Pc9WAtlc5YD68ef8I9t7fSU8k/aiEmU0TbAUzYv
	MUCRqp8ftmMLO1F7yCKyk/0soOLpUgArB3+1ti/fFBYgB6
X-Received: by 2002:a17:903:4292:b0:2b2:a6a2:c8ca with SMTP id d9443c01a7336-2b9f2596409mr65609385ad.13.1777911051244;
        Mon, 04 May 2026 09:10:51 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae58906sm107674015ad.74.2026.05.04.09.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:10:50 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Tue, 05 May 2026 01:10:42 +0900
Subject: [PATCH iproute2-next v2 2/6] seg6: add support for the
 End.M.GTP4.E behavior
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-seg6-mobile-v2-2-93291b7b0134@gmail.com>
References: <20260505-seg6-mobile-v2-0-93291b7b0134@gmail.com>
In-Reply-To: <20260505-seg6-mobile-v2-0-93291b7b0134@gmail.com>
To: dsahern@kernel.org
Cc: Yuya Kusakabe <yuya.kusakabe@gmail.com>, netdev@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9706;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=N41eYelmek7FKVGJkZZhT9y4QWmD14OVoyv30Aoz3IU=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBp+MUCVM12/rQx7H6+aDygVoKD9NUf/B5T8arvK
 d8vAZ5O04SJAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCafjFAgAKCRAq19F1Kl0b
 Te83EACA1zUjYd1dVN1cd+A2tpn1JqXv789fL0ctdpfuHzLewXk0nrggoYlU+ORWqIFd3il57kM
 KkLqDivPsyKpkt5f8wjVkQVnfhCE0ACwBrDjPqU2WrKLQm2/69RMeqn0Ihkl9Gf4SY6G0g5vFj9
 62ILQw8D4A1Q2AWeCxZRgQ20nl639FcAyC+Z3k12mqyliSMW9rtVCAFgWVebT1eCbuk4+P73AM2
 LIUo5+ll/V4Z5tvgvhVUiyZLTBrEm/P7WmgYuHTJBIm1Rzx9t+ibxNfapcr/mesHPi2lK9D1s7i
 2vMAof/M5wQu/nJVs1Z05RMh8LaiDvUWtWEGPBiA7m0t8DE+/43uyyFjSCiLDxvxdGBdJFwEQ7r
 6ECRNYpjr3LsSfy/fz3hDnkXFKAPWUC21ayPys7Fku4vg9HDUxLjCsFpuppivke57yJk/7bJTuq
 2hNWnHPVO1iQxfIlmwbvYHPAih6xGg50VpqnTe/xUOOs9eI2DstzsQxKDGmskV40tDcV5Jq13iz
 DtvXe3kccHxUg9UiEVMkYWo+2ORezZ2ZK7uCkXDSFr7tYN9G53Y54hpkxPNsM2IbOtxhnsB4aqY
 LiySyxuPB4qV4ZdzqFbntE2fiFlUGH48BWDJPN+Rq+nUNPs0vST8Qs0LZIq4Kyw1i2ZRIxe0JoO
 fnLjR7kGQ08UO8w==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D
X-Rspamd-Queue-Id: B9CCF4C1378
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283941-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ietf.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,end.am:url,end.bm:url,end.map:url,end.as:url]

Add support for the End.M.GTP4.E behavior, which translates SRv6
traffic into IPv4/GTP-U.  Four new keywords are introduced:

  src                  IPv6 source-address template
  v4_mask_len          IPv4 DA portion of the SID, in bits (1..32)
  v6_src_prefix_len    Source UPF Prefix length P in the IPv6 SA
                       template (1..127, defaults to 64); requires
                       P + v4_mask_len <= 128
  pdu_type             GTP-U PDU Session Container PDU Type
                       (downlink|dl|uplink|ul or 0..15)

Example:
ip -6 r a 2001:db8:1::/56 encap seg6local action End.M.GTP4.E \
    src 2001:db8::1 v4_mask_len 32 v6_src_prefix_len 64 \
    pdu_type ul dev sr0

Link: https://datatracker.ietf.org/doc/html/rfc9433

Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
 include/uapi/linux/seg6_local.h |   6 +++
 ip/iproute.c                    |   6 ++-
 ip/iproute_lwtunnel.c           | 103 ++++++++++++++++++++++++++++++++++++++++
 man/man8/ip-route.8.in          |  34 +++++++++++++
 4 files changed, 147 insertions(+), 2 deletions(-)

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
diff --git a/ip/iproute.c b/ip/iproute.c
index 61394847018f..f9ebba6541af 100644
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
diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index 3a25835662d1..49fe563d9b86 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -406,6 +406,7 @@ static const char *seg6_action_names[SEG6_LOCAL_ACTION_MAX + 1] = {
 	[SEG6_LOCAL_ACTION_END_BPF]		= "End.BPF",
 	[SEG6_LOCAL_ACTION_END_DT46]		= "End.DT46",
 	[SEG6_LOCAL_ACTION_END_MAP]		= "End.MAP",
+	[SEG6_LOCAL_ACTION_END_M_GTP4_E]	= "End.M.GTP4.E",
 };
 
 static const char *format_action_type(int action)
@@ -577,6 +578,41 @@ static void print_encap_seg6local(FILE *fp, struct rtattr *encap)
 
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
 
 static void print_encap_mpls(FILE *fp, struct rtattr *encap)
@@ -1451,6 +1487,8 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
 	int nh4_ok = 0, nh6_ok = 0, iif_ok = 0, oif_ok = 0, flavors_ok = 0;
 	int segs_ok = 0, hmac_ok = 0, table_ok = 0, vrftable_ok = 0;
 	int action_ok = 0, srh_ok = 0, bpf_ok = 0, counters_ok = 0;
+	int mobile_src_ok = 0, mobile_v4mask_ok = 0, mobile_pdusess_ok = 0;
+	int mobile_v6src_plen_ok = 0;
 	__u32 action = 0, table, vrftable, iif, oif;
 	struct ipv6_sr_hdr *srh;
 	char **argv = *argvp;
@@ -1458,6 +1496,7 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
 	char segbuf[1024];
 	inet_prefix addr;
 	__u32 hmac = 0;
+	__u8 v4_mask_len = 0, v6_src_prefix_len = 0;
 	int ret = 0;
 
 	while (argc > 0) {
@@ -1559,6 +1598,70 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
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
+			 * padding (128 - P - b)".  P is validated as 1..127
+			 * here; the kernel enforces P + b <= 128 via netlink
+			 * extack.
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
+				invarg("invalid \"pdu_type\" value (must be downlink|dl|uplink|ul or 0..15)\n", *argv);
+			}
+			ret = rta_addattr8(rta, len,
+					   SEG6_LOCAL_MOBILE_PDU_TYPE,
+					   psc_type);
 		} else {
 			break;
 		}
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


