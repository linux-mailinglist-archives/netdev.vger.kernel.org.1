Return-Path: <netdev+bounces-107401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB6491AD4A
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657EE1F27157
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7704199E9E;
	Thu, 27 Jun 2024 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cS2Jwy95"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFAC199E95
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719507414; cv=none; b=EfgPLr15Xh0T1yuAyNM5Vs5kHN/N7I0sLOz8eAKpaFIygXiGAKm4fbTyfRoa4bHoBlJYpfD+a5Ih7IHmtL/Y9t3Xd5IP/VgWwyLAvykuceo73AlXW4xyTC8RJKY2EtGkYmf+wAqWFOkgWTqs5Dm1XEfcy2uYSOA0UKDZPv51f4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719507414; c=relaxed/simple;
	bh=H1/xi/3kcacmTzcFaEn8RPh40BEyt4XeoGuIN8j3jsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/6rrc/+3EbhSqW55tbYlRi+cncRNgdpAAzXhz1A3+FQTJ+9B/CqFK5e51bBKGHukWU0FuZBA1FpcCTBlgn9O484D8rDT2boXud/zAY/503gmWjs9u/+ZQgHaT/FZi+jqjc3TiKu/XCNChJR6M+tnyZafpe5oRRxMbtN4VRPRdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cS2Jwy95; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719507412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KXeo7p4qgBCuBqwNXMCvJzmzSNBLYhFLHPw9+1Ybpn0=;
	b=cS2Jwy95NXXMRnPaUrAXOfNFRk8k3Egv4nzzKP1P4rh+H1uLZSjkcpQgLoFecvVchFJOpT
	QwJOz4ayo0qHq8gyix1ZpUDp/2C3dIlP2UvEKWl/iNZXBEwdffbH5jpwUUPnprYRRPmzUE
	B7Bsvujl49JX5Wkh5k2eM3m9jcdNM+8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-GZlEzly4O82VEHs3c72Jqg-1; Thu,
 27 Jun 2024 12:56:48 -0400
X-MC-Unique: GZlEzly4O82VEHs3c72Jqg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 674711956087;
	Thu, 27 Jun 2024 16:56:47 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.186])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 03FD1300021A;
	Thu, 27 Jun 2024 16:56:43 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
Cc: David Ahern <dsahern@kernel.org>,
	aclaudi@redhat.com,
	Ilya Maximets <i.maximets@ovn.org>,
	echaudro@redhat.com,
	netdev@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [RFC iproute2-next] tc: f_flower:  add support for matching on tunnel metadata
Date: Thu, 27 Jun 2024 18:55:47 +0200
Message-ID: <897379f1850a50d8c320ca3facd06c5f03943bac.1719506876.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

extend TC flower for matching on tunnel metadata.
smoke test:

 # ip link add name myep type dummy
 # ip link set dev myep up
 # ip address add dev myep 192.0.2.1/24
 # ip neigh add dev myep 192.0.2.2 lladdr 00:c1:a0:c1:a0:00 nud permanent
 # ip link add name mytun type vxlan external
 # ip link set dev mytun up
 # tc qdisc add dev mytun clsact
 # tc filter add dev mytun egress protocol ip pref 1 handle 1 matchall action tunnel_key \
 >    set src_ip 192.0.2.1 dst_ip 192.0.2.2 id 42 csum nofrag continue index 1
 # tc filter add dev mytun egress protocol ip pref 2 handle 2 flower action continue index 30
 # tc filter add dev mytun egress protocol ip pref 3 handle 3 flower enc_src_ip 192.0.2.1 action continue index 30
 # tc filter add dev mytun egress protocol ip pref 4 handle 4 flower enc_flags tundf action pipe index 100
 # mausezahn mytun -c 1 -p 100 -a 00:aa:bb:cc:dd:ee -b 00:ee:dd:cc:bb:aa -t icmp -q
 # expect 2 packets below
 # tc -s action get action gact index 30
 # expect 1 packet below
 # tc -s action get action gact index 100

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 include/uapi/linux/pkt_cls.h |  8 +++++++
 tc/f_flower.c                | 42 ++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 229fc925ec3a..24795aad7651 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -554,6 +554,9 @@ enum {
 	TCA_FLOWER_KEY_SPI,		/* be32 */
 	TCA_FLOWER_KEY_SPI_MASK,	/* be32 */
 
+	TCA_FLOWER_KEY_ENC_FLAGS,	/* u32 */
+	TCA_FLOWER_KEY_ENC_FLAGS_MASK,	/* u32 */
+
 	__TCA_FLOWER_MAX,
 };
 
@@ -674,6 +677,11 @@ enum {
 enum {
 	TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT = (1 << 0),
 	TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST = (1 << 1),
+	/* FLOW_DIS_ENCAPSULATION (1 << 2) is not exposed to userspace */
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM = (1 << 3),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT = (1 << 4),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM = (1 << 5),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT = (1 << 6),
 };
 
 enum {
diff --git a/tc/f_flower.c b/tc/f_flower.c
index 08c1001af7b4..45fc31dc380f 100644
--- a/tc/f_flower.c
+++ b/tc/f_flower.c
@@ -17,6 +17,7 @@
 #include <linux/tc_act/tc_vlan.h>
 #include <linux/mpls.h>
 #include <linux/ppp_defs.h>
+#include <linux/if_tunnel.h>
 
 #include "utils.h"
 #include "tc_util.h"
@@ -28,6 +29,7 @@
 
 enum flower_matching_flags {
 	FLOWER_IP_FLAGS,
+	FLOWER_ENC_DST_FLAGS,
 };
 
 enum flower_endpoint {
@@ -92,6 +94,7 @@ static void explain(void)
 		"			erspan_opts MASKED-OPTIONS |\n"
 		"			gtp_opts MASKED-OPTIONS |\n"
 		"			pfcp_opts MASKED-OPTIONS |\n"
+		"			enc_flags  ENC-FLAGS |\n"
 		"			ip_flags IP-FLAGS |\n"
 		"			l2_miss L2_MISS |\n"
 		"			enc_dst_port [ port_number ] |\n"
@@ -205,6 +208,11 @@ struct flag_to_string {
 static struct flag_to_string flags_str[] = {
 	{ TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT, FLOWER_IP_FLAGS, "frag" },
 	{ TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST, FLOWER_IP_FLAGS, "firstfrag" },
+	{ TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM, FLOWER_ENC_DST_FLAGS, "csum" },
+	{ TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT, FLOWER_ENC_DST_FLAGS, "tundf" },
+	{ TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM, FLOWER_ENC_DST_FLAGS, "oam" },
+	{ TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT, FLOWER_ENC_DST_FLAGS, "crit" },
+
 };
 
 static int flower_parse_matching_flags(char *str,
@@ -1461,6 +1469,29 @@ static int flower_parse_enc_opts_pfcp(char *str, struct nlmsghdr *n)
 	return 0;
 }
 
+static int flower_parse_enc_dstflags(char *str, struct nlmsghdr *n)
+{
+
+	__u32 dst_flags, dst_flags_mask;
+	int err;
+
+	err = flower_parse_matching_flags(str,
+					  FLOWER_ENC_DST_FLAGS,
+					  &dst_flags,
+					  &dst_flags_mask);
+
+	if (err < 0 || !dst_flags_mask)
+		return -1;
+	err = addattr32(n, MAX_MSG, TCA_FLOWER_KEY_ENC_FLAGS, htonl(dst_flags));
+	if (err < 0)
+		return -1;
+	err = addattr32(n, MAX_MSG, TCA_FLOWER_KEY_ENC_FLAGS_MASK, htonl(dst_flags_mask));
+	if (err < 0)
+		return -1;
+
+	return 0;
+}
+
 static int flower_parse_mpls_lse(int *argc_p, char ***argv_p,
 				 struct nlmsghdr *nlh)
 {
@@ -2248,6 +2279,13 @@ static int flower_parse_opt(const struct filter_util *qu, char *handle,
 				fprintf(stderr, "Illegal \"pfcp_opts\"\n");
 				return -1;
 			}
+		} else if (matches(*argv, "enc_flags") == 0) {
+			NEXT_ARG();
+			ret = flower_parse_enc_dstflags(*argv, n);
+			if (ret < 0) {
+				fprintf(stderr, "Illegal \"enc_flags\"\n");
+				return -1;
+			}
 		} else if (matches(*argv, "action") == 0) {
 			NEXT_ARG();
 			ret = parse_action(&argc, &argv, TCA_FLOWER_ACT, n);
@@ -3262,6 +3300,10 @@ static int flower_print_opt(const struct filter_util *qu, FILE *f,
 				    tb[TCA_FLOWER_KEY_FLAGS],
 				    tb[TCA_FLOWER_KEY_FLAGS_MASK]);
 
+	flower_print_matching_flags("enc_flags", FLOWER_ENC_DST_FLAGS,
+				    tb[TCA_FLOWER_KEY_ENC_FLAGS],
+				    tb[TCA_FLOWER_KEY_ENC_FLAGS_MASK]);
+
 	if (tb[TCA_FLOWER_L2_MISS]) {
 		struct rtattr *attr = tb[TCA_FLOWER_L2_MISS];
 
-- 
2.45.1


