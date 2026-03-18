Return-Path: <netdev+bounces-269018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMWfNBmsumn9aQIAu9opvQ
	(envelope-from <netdev+bounces-269018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:43:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D85172BC415
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59D80301DA57
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A4F3D891C;
	Wed, 18 Mar 2026 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="bgePMAuZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997AD3D88FD;
	Wed, 18 Mar 2026 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841407; cv=none; b=b44W5Oh50yhFt4PaC2P/QYrNGGvIEiuHRhFj0b09OU/G6AHm46UFazssySySKcG2f66KG66A2h7LA7g3D9k+1UhYmYEZtwxkrLYRVQ4OGrD/mq/xNNwgEuIWqbUki+WYEWMiHUfENsRc2alTaSX+3LzJUuzSR6KbxhbRj8vrJZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841407; c=relaxed/simple;
	bh=cc5dRZBLNOCn4flOsbPH/dDSOeD/1qpchVpf+ldVrYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zu/L37VQxRG8x1RiOdIDYAd9zqK82Fo1Q3af94u3tcSxaaLS7Olnu09i2KCU+Oacj5JTpJnCOFahNBZ893PdhSzh+zy2t2f1y3JULA6OJ2Jahp4r4V8NUSW6N+nHt74gKfnuSVsbrD2wPFrtATBGq7mbdHY0G+wnb6xo69fkH1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=bgePMAuZ; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122332.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IACatS954673;
	Wed, 18 Mar 2026 13:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=kg+tpQfpe
	X+OyN2mJ/ZUcelyan+6nyXJDc/79vn9Y7Y=; b=bgePMAuZ3kD/m16lppb9ojxRp
	jy8OiMzjxukcAhtiV5KcOBW9HpUv03R6Et7XTS8dZjOn+Bf+OnM9ukTuDwIJPepV
	a4rofFX7o2sZH5+rD7pdI2nQFCIOjFqUqElbtW/NZDLhgFOLXxyJQ73l+xNadSvt
	KMsHhxcw5DdGN2bfveGxrV3PVVP9niAWSaBvH1UkDZ0h8v/hno3/YRVFxdAbisNa
	QW1hfPP0itq1ldPdU5rxRynCBh7H2oi+VYaWd4ll6WwcHk7efXTolwsAXiSp+gEg
	ZxLW+SsgPZ3X6cZRsYvLc6zM+laXNVMX/MqH/c7n//0NeeCBCa2+tA0/hGnyQ==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4cw0kmrkbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 13:42:54 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
	by prod-mail-ppoint2.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 62IDYWxR011768;
	Wed, 18 Mar 2026 09:42:53 -0400
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint2.akamai.com (PPS) with ESMTP id 4cw30x86ey-1;
	Wed, 18 Mar 2026 09:42:53 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 03E6B99;
	Wed, 18 Mar 2026 13:42:51 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Nick Hudson <nhudson@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
        Anna Glasgall <aglasgal@akamai.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] bpf: clear decap tunnel GSO state in skb_adjust_room
Date: Wed, 18 Mar 2026 13:42:42 +0000
Message-Id: <20260318134242.2725749-6-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318134242.2725749-1-nhudson@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=989 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2603050001 definitions=main-2603180115
X-Proofpoint-GUID: 1ivxs-3qdDFLrB1B9t2sw9szEELcSBWm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNiBTYWx0ZWRfX9fI/tp/7ieSa
 4ZcNsyXLM0sXCp1BXSdz12LoWoOu9Y8BhvRjNL4rYtu8ON9AblZq8qyT/j3cIvvmCq5uZhMTnGN
 PmMh9/d6QWiOI0Qbwft77sHbAOAL92InWVCCzh1/BLfTRSuuzhBJ4cRF3ajgZqeAihc+o2hMWCJ
 RB+ivu0Oq5LUoZw8KB4I6SwjMK2ZSyxevYgekUaZ3lgMUSB6ZmrCyKP3kcxO7eo0oxOBn43AK99
 YsMWa6FX6u8vx2k4PkI2X1jcBkQzl93YYKKMZUp0nIZHIWWMHCtMRxko/LONWasj68hVr6pqJjR
 gZaoOxEs8o5+pVVfY+FRSeJbEyY8lp/t6uNSz9tH+BXr7UXZBIkHsQKytqWH6d8uNKjtcWz794i
 dJKM8L3j72JKjHllg7IH11DE3c4Q1JKLFud1o5aKJYIbeas8fTjwl8Ld0kN9ELqbIwj3fO4Er8+
 APm7+xSItkSi/1/iTCg==
X-Proofpoint-ORIG-GUID: 1ivxs-3qdDFLrB1B9t2sw9szEELcSBWm
X-Authority-Analysis: v=2.4 cv=ZMznX37b c=1 sm=1 tr=0 ts=69baabdf cx=c_pps
 a=BpD+HMUBsFIkYY1OQe22Yw==:117 a=BpD+HMUBsFIkYY1OQe22Yw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=4OENtXgxWbduB0e82o7S:22 a=X7Ea-ya5AAAA:8 a=adxPj1HbavDh4lNgp2AA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603130000 definitions=main-2603180116
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com,linux.dev,iogearbox.net,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269018-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:dkim,akamai.com:email,akamai.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D85172BC415
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On shrink in bpf_skb_adjust_room(), clear tunnel-specific GSO flags
according to the decapsulation flags:

- BPF_F_ADJ_ROOM_DECAP_L4_UDP clears SKB_GSO_UDP_TUNNEL{,_CSUM}
- BPF_F_ADJ_ROOM_DECAP_L4_GRE clears SKB_GSO_GRE{,_CSUM}
- BPF_F_ADJ_ROOM_DECAP_IPXIP4 clears SKB_GSO_IPXIP4
- BPF_F_ADJ_ROOM_DECAP_IPXIP6 clears SKB_GSO_IPXIP6

When all tunnel-related GSO bits are cleared, also clear
skb->encapsulation.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
---
 net/core/filter.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 47aec44a9cd3..35af1199ab97 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3665,6 +3665,37 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
 			skb_increase_gso_size(shinfo, len_diff);
 
+		/* Selective GSO flag clearing based on decap type.
+		 * Only clear the flags for the tunnel layer being removed.
+		 */
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
+		    (shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
+					 SKB_GSO_UDP_TUNNEL_CSUM)))
+			shinfo->gso_type &= ~(SKB_GSO_UDP_TUNNEL |
+					      SKB_GSO_UDP_TUNNEL_CSUM);
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
+		    (shinfo->gso_type & (SKB_GSO_GRE | SKB_GSO_GRE_CSUM)))
+			shinfo->gso_type &= ~(SKB_GSO_GRE |
+					      SKB_GSO_GRE_CSUM);
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
+		    (shinfo->gso_type & SKB_GSO_IPXIP4))
+			shinfo->gso_type &= ~SKB_GSO_IPXIP4;
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
+		    (shinfo->gso_type & SKB_GSO_IPXIP6))
+			shinfo->gso_type &= ~SKB_GSO_IPXIP6;
+
+		/* Clear encapsulation flag only when no tunnel GSO flags remain */
+		if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
+			if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
+						  SKB_GSO_UDP_TUNNEL_CSUM |
+						  SKB_GSO_GRE |
+						  SKB_GSO_GRE_CSUM |
+						  SKB_GSO_IPXIP4 |
+						  SKB_GSO_IPXIP6)))
+				if (skb->encapsulation)
+					skb->encapsulation = 0;
+		}
+
 		/* Header must be checked, and gso_segs recomputed. */
 		shinfo->gso_type |= SKB_GSO_DODGY;
 		shinfo->gso_segs = 0;
-- 
2.34.1


