Return-Path: <netdev+bounces-283783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPsQBTJ0+Gk9vgIAu9opvQ
	(envelope-from <netdev+bounces-283783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:25:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6028A4BBB0C
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42A5D30C9433
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 10:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126DD3A1A5D;
	Mon,  4 May 2026 10:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="PUFnGnhv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D68239D6CE;
	Mon,  4 May 2026 10:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889949; cv=none; b=YxAuZRpSEtivktQGNH7dZpoMrVMagvRPbyoCrLy6aYn3e1aVoGXPCd3+HK5b+e7TU8RnrncHK2/JoZaMF8QNEj12B9hOsbPBGoLcnP329ZxnZ8ootrGNYEMqNMd5BnElwHeIM4kupbYlVvOQIe/l+Sq1ChZ3ph4eSKC0/fA4Kdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889949; c=relaxed/simple;
	bh=5cbZ6yd+ghwxxCIqly0Xu/MMZMhUMSS0a2sgHobk4r4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pzNkVrIdhVvRVgtYcg3T/UxX/ZvGg+ejAYcQCHBTzMh4ZRNxmrYchHWaNYD/1ytboUz6XzTT0HIs8/IKUGIe3uzqfPTHEBQeNFv4Wtu7mr66CYcijAsSlpvQNCkU0NZeTttjYCaKd+HCSia3U6yOTTpOls9Ek//OwOW4psRjPcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=PUFnGnhv; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409408.ppops.net [127.0.0.1])
	by m0409408.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 6445Qlhm2216742;
	Mon, 4 May 2026 11:18:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=4J1gaxcUl
	lBBVyXL52u/qWrIhhVf0uOHhY/OrjW1lIA=; b=PUFnGnhvnD10qy+Db9H/1N/Yz
	YEWLIjDhhQyXY5IAlb4QMNfezvJnOQ3WCUlHTYoSiq9w+sYDxwt2adhoYb9Xl/NI
	HC2Qmg18X8scF5TZ/sggpM9UEgrnAQlITGwYJfuPCanXTCg6vzq1tOf5w6ia6BIb
	cerL/Xzs4lyFj6rWGdzJTiauuRk7WJHsJL+ggOFQTwFSFcDttCzW0einaJnNmhtT
	zBKMrIO8BAGTP9FqqfQMzmuQT56MF+lKIpZjw9Mcf/CYFpyNnQQv6Qi+am7mCtjY
	U4+48rr4R0NQoWg6AAql65teHBrUxQNe9bvJBQa16uJr2xXSooPTs1/Yuxqhw==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
	by m0409408.ppops.net-00190b01. (PPS) with ESMTPS id 4dwv65px4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 11:18:11 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 644ACMPm005971;
	Mon, 4 May 2026 06:18:10 -0400
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4dwckwq08t-1;
	Mon, 04 May 2026 06:18:10 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay01.akamai.com (Postfix) with ESMTP id 8B43B87;
	Mon,  4 May 2026 10:18:08 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
        Anna Glasgall <aglasgal@akamai.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/6] bpf: allow new DECAP flags and add guard rails
Date: Mon,  4 May 2026 11:17:57 +0100
Message-Id: <20260504101759.3319427-5-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504101759.3319427-1-nhudson@akamai.com>
References: <20260504101759.3319427-1-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605040108
X-Proofpoint-ORIG-GUID: 7Et7Eu6p9nxIjcr4k4ckPpvsm3Tu5FQd
X-Authority-Analysis: v=2.4 cv=dovrzVg4 c=1 sm=1 tr=0 ts=69f87263 cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=BYUV7c42er6_Rx9bq0XK:22 a=X7Ea-ya5AAAA:8 a=1XWaLZrsAAAA:8
 a=Hfnf2daL9bryszF4jIsA:9
X-Proofpoint-GUID: 7Et7Eu6p9nxIjcr4k4ckPpvsm3Tu5FQd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEwOSBTYWx0ZWRfX3AP/ugI4CfUm
 87gX6Dj3D26R/cci69TEu0QvcR7eua/qWVZ1u6vvr8kza8sLE1TKCkx4RCVyrU4eefJE0kCkRHf
 Gr8wa7DO+qUsyaKGywZ9x6CN3coPd/L0etYH33g9AsXyoNto4GKfM0d7S0mozsl14R64sYiVonY
 cFqClwhKb3zlkDk31AWPXonxAQQ1Hm1LM7vvNTIN0y7XcvNmcS1aZxv/ODXO8ebmEMW8chta3tm
 n62/G/OMkzNtsO6vjFSY/FgmVdo9mJbZsPcijzTW/dqzopkd8uian1JsnXot5CjKjzl8JhFYgXV
 rrxp/o6BmAe4KLKpcwKjAyaWe0AaIhyaCO6QnjrFRq64xrE65J5RcGP3j9AyAzjKjo2HIyEVJeY
 rexPSrBwLnZ+j5M8gI25n7lZnM/pjlqZ+4Qq5OZGcaQL4KWawVJXJz4BqQC9PqVqp+v1vTg4wCZ
 FEj/MKMhF4kUyhcGfog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040109
X-Rspamd-Queue-Id: 6028A4BBB0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[akamai.com,iogearbox.net,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283783-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:email,akamai.com:dkim,akamai.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

Add checks to require shrink-only decap, reject conflicting decap flag
combinations, and verify removed length is sufficient for claimed header
decapsulation.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/core/filter.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 02d3947cca32..185a11f425fa 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -56,6 +56,7 @@
 #include <net/sock_reuseport.h>
 #include <net/busy_poll.h>
 #include <net/tcp.h>
+#include <net/gre.h>
 #include <net/xfrm.h>
 #include <net/udp.h>
 #include <linux/bpf_trace.h>
@@ -3484,6 +3485,12 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
 #define BPF_F_ADJ_ROOM_DECAP_L3_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_IPV4 | \
 					 BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
 
+#define BPF_F_ADJ_ROOM_DECAP_L4_MASK	(BPF_F_ADJ_ROOM_DECAP_L4_UDP | \
+					 BPF_F_ADJ_ROOM_DECAP_L4_GRE)
+
+#define BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK	(BPF_F_ADJ_ROOM_DECAP_IPXIP4 | \
+					 BPF_F_ADJ_ROOM_DECAP_IPXIP6)
+
 #define BPF_F_ADJ_ROOM_ENCAP_MASK	(BPF_F_ADJ_ROOM_ENCAP_L3_MASK | \
 					 BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
 					 BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
@@ -3491,7 +3498,9 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
 					 BPF_F_ADJ_ROOM_ENCAP_L2( \
 					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
 
-#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK)
+#define BPF_F_ADJ_ROOM_DECAP_MASK	(BPF_F_ADJ_ROOM_DECAP_L3_MASK | \
+					 BPF_F_ADJ_ROOM_DECAP_L4_MASK | \
+					 BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
 
 #define BPF_F_ADJ_ROOM_MASK		(BPF_F_ADJ_ROOM_FIXED_GSO | \
 					 BPF_F_ADJ_ROOM_ENCAP_MASK | \
@@ -3739,6 +3748,8 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
 	}
 
 	if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
+		u32 len_decap_min = 0;
+
 		if (!shrink)
 			return -EINVAL;
 
@@ -3747,6 +3758,37 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
 		    BPF_F_ADJ_ROOM_DECAP_L3_MASK)
 			return -EINVAL;
 
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) ==
+		    BPF_F_ADJ_ROOM_DECAP_L4_MASK)
+			return -EINVAL;
+
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK) ==
+		    BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
+			return -EINVAL;
+
+		/* Reject mutually exclusive decap tunnel type flags. */
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) &&
+		    (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
+			return -EINVAL;
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK)
+			len_decap_min += bpf_skb_net_base_len(skb);
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP)
+			len_decap_min += sizeof(struct udphdr);
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE)
+			len_decap_min += sizeof(struct gre_base_hdr);
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4)
+			len_decap_min += sizeof(struct iphdr);
+
+		if (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6)
+			len_decap_min += sizeof(struct ipv6hdr);
+
+		if (len_diff_abs < len_decap_min)
+			return -EINVAL;
+
 		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
 			len_min = sizeof(struct iphdr);
 
-- 
2.34.1


