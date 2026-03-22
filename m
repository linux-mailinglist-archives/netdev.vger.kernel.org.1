Return-Path: <netdev+bounces-270284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Bm2Mvw8v2nwzgMAu9opvQ
	(envelope-from <netdev+bounces-270284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 01:51:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC522E7CC6
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 01:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E68AE3006B6E
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 00:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5A036607D;
	Sun, 22 Mar 2026 00:51:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4B62D8370
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 00:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774140666; cv=none; b=MDmfPrHV2FZpxbqAGbaqCLaZbedHEOAOUTAgnAfDnD8qyMxdh0wwZ2rb5i7sZk6iHvRrAvmwzPPuSHNAfeeBDPOkgtQy22327hDXfTtCgfwFvDjw05A1KQ7b2OFj8te+eZvSxCXjKAx3PviOjc0YBnVdorGEl1BRnzWDud+u0mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774140666; c=relaxed/simple;
	bh=dDDdFvxXLDxIxyIQdWXy+RDdJlwywhwGDqa5HicMWRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qMRvzoa9LbjERUQZkG+exgVNgqkNq3t1RqxW9ksx1qBAeosWrWXBUW8leU0iSffmsQeUjvhUFhji3GOI5xA4uBtSTg18Y5NrByEkTfLkkV12rnxJKKA4a70QSZ/eBu4/vIKy0nzhoKi6DRvAKKZQD7Sep7RQSeKG0no1Sjf9I+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62M0oi8C021661;
	Sun, 22 Mar 2026 01:50:50 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels@cisco.com>,
        Justin Iurman <justin.iurman@6wind.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [RFC PATCH iproute2-next 1/4] seg6: add support for SRv6 End.DT2U behavior
Date: Sun, 22 Mar 2026 01:50:18 +0100
Message-Id: <20260322005021.12770-2-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260322005021.12770-1-andrea.mayer@uniroma2.it>
References: <20260322005021.12770-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[uniroma2.it : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270284-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniroma2.it:email,uniroma2.it:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,encap.red:url,l2encap.red:url,end.am:url]
X-Rspamd-Queue-Id: 7AC522E7CC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add parsing and printing for the End.DT2U seg6local action with
its l2dev attribute, and update the usage help text.

Usage:

  ip -6 route add fc00::100/128 encap seg6local action End.DT2U \
      l2dev veth0 dev dum0

  where veth0 is a bridge port.

Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 include/uapi/linux/seg6_local.h |  3 +++
 ip/iproute.c                    |  7 ++++---
 ip/iproute_lwtunnel.c           | 20 +++++++++++++++++++-
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
index 6e71d97f..c0717510 100644
--- a/include/uapi/linux/seg6_local.h
+++ b/include/uapi/linux/seg6_local.h
@@ -29,6 +29,7 @@ enum {
 	SEG6_LOCAL_VRFTABLE,
 	SEG6_LOCAL_COUNTERS,
 	SEG6_LOCAL_FLAVORS,
+	SEG6_LOCAL_L2DEV,
 	__SEG6_LOCAL_MAX,
 };
 #define SEG6_LOCAL_MAX (__SEG6_LOCAL_MAX - 1)
@@ -67,6 +68,8 @@ enum {
 	SEG6_LOCAL_ACTION_END_BPF	= 15,
 	/* decap and lookup of DA in v4 or v6 table */
 	SEG6_LOCAL_ACTION_END_DT46	= 16,
+	/* decap and unicast MAC L2 table lookup */
+	SEG6_LOCAL_ACTION_END_DT2U	= 17,
 
 	__SEG6_LOCAL_ACTION_MAX,
 };
diff --git a/ip/iproute.c b/ip/iproute.c
index c2538894..89d8ec1e 100644
--- a/ip/iproute.c
+++ b/ip/iproute.c
@@ -104,11 +104,12 @@ static void usage(void)
 		"SEGMODE := [ encap | encap.red | inline | l2encap | l2encap.red ]\n"
 		"SEG6LOCAL := action ACTION [ OPTIONS ] [ count ]\n"
 		"ACTION := { End | End.X | End.T | End.DX2 | End.DX6 | End.DX4 |\n"
-		"            End.DT6 | End.DT4 | End.DT46 | End.B6 | End.B6.Encaps |\n"
+		"            End.DT6 | End.DT4 | End.DT46 | End.DT2U | End.B6 | End.B6.Encaps |\n"
 		"            End.BM | End.S | End.AS | End.AM | End.BPF }\n"
 		"OPTIONS := OPTION [ OPTIONS ]\n"
-		"OPTION := { flavors FLAVORS | srh SEG6HDR | nh4 ADDR | nh6 ADDR | iif DEV | oif DEV |\n"
-		"            table TABLEID | vrftable TABLEID | endpoint PROGNAME }\n"
+		"OPTION := { flavors FLAVORS | srh SEG6HDR | nh4 ADDR | nh6 ADDR |\n"
+		"            iif DEV | oif DEV | l2dev DEV | table TABLEID |\n"
+		"            vrftable TABLEID | endpoint PROGNAME }\n"
 		"FLAVORS := { FLAVOR[,FLAVOR] }\n"
 		"FLAVOR := { psp | usp | usd | next-csid }\n"
 		"IOAM6HDR := trace prealloc type IOAM6_TRACE_TYPE ns IOAM6_NAMESPACE size IOAM6_TRACE_SIZE\n"
diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index a7885dba..40e9bbd2 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -398,6 +398,7 @@ static const char *seg6_action_names[SEG6_LOCAL_ACTION_MAX + 1] = {
 	[SEG6_LOCAL_ACTION_END_AM]		= "End.AM",
 	[SEG6_LOCAL_ACTION_END_BPF]		= "End.BPF",
 	[SEG6_LOCAL_ACTION_END_DT46]		= "End.DT46",
+	[SEG6_LOCAL_ACTION_END_DT2U]		= "End.DT2U",
 };
 
 static const char *format_action_type(int action)
@@ -561,6 +562,13 @@ static void print_encap_seg6local(FILE *fp, struct rtattr *encap)
 			     "oif %s ", ll_index_to_name(oif));
 	}
 
+	if (tb[SEG6_LOCAL_L2DEV]) {
+		int l2dev = rta_getattr_u32(tb[SEG6_LOCAL_L2DEV]);
+
+		print_string(PRINT_ANY, "l2dev",
+			     "l2dev %s ", ll_index_to_name(l2dev));
+	}
+
 	if (tb[SEG6_LOCAL_BPF])
 		print_encap_bpf_prog(fp, tb[SEG6_LOCAL_BPF], "endpoint");
 
@@ -1419,12 +1427,13 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
 	int nh4_ok = 0, nh6_ok = 0, iif_ok = 0, oif_ok = 0, flavors_ok = 0;
 	int segs_ok = 0, hmac_ok = 0, table_ok = 0, vrftable_ok = 0;
 	int action_ok = 0, srh_ok = 0, bpf_ok = 0, counters_ok = 0;
-	__u32 action = 0, table, vrftable, iif, oif;
+	__u32 action = 0, table, vrftable, iif, oif, l2dev;
 	struct ipv6_sr_hdr *srh;
 	char **argv = *argvp;
 	int argc = *argcp;
 	char segbuf[1024];
 	inet_prefix addr;
+	int l2dev_ok = 0;
 	__u32 hmac = 0;
 	int ret = 0;
 
@@ -1483,6 +1492,15 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
 			if (!oif)
 				exit(nodev(*argv));
 			ret = rta_addattr32(rta, len, SEG6_LOCAL_OIF, oif);
+		} else if (strcmp(*argv, "l2dev") == 0) {
+			NEXT_ARG();
+			if (l2dev_ok++)
+				duparg2("l2dev", *argv);
+			l2dev = ll_name_to_index(*argv);
+			if (!l2dev)
+				exit(nodev(*argv));
+			ret = rta_addattr32(rta, len, SEG6_LOCAL_L2DEV,
+					    l2dev);
 		} else if (strcmp(*argv, "count") == 0) {
 			if (counters_ok++)
 				duparg2("count", *argv);
-- 
2.20.1


