Return-Path: <netdev+bounces-275949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEBdMajh1GnbyQcAu9opvQ
	(envelope-from <netdev+bounces-275949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 12:51:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 782273AD3E0
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 12:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8D0E300DEE7
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 10:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADD53AC0D6;
	Tue,  7 Apr 2026 10:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="ECeX9tSt"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5553AB278;
	Tue,  7 Apr 2026 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775559049; cv=none; b=qZRE7Rb/CP0dJiTBYsEkm8NuHoXIJ4zp4OgSfOYIpZvxljwWMN7D9S4337IYku+D7xKxYDHxFOvV3lZVANsbUxH/qhG5FemO3ihY3vC8mcECmuqERkJDuU4wWZEoo5zxZniJ0r0TjpcDygCM4ceQF8tLAFdk7tN3UJAcxatuJPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775559049; c=relaxed/simple;
	bh=QDRIa4NV1Fntq4FEnCCZZBoTP5I6cDRz5WX1vGjPkzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kn9kdApL1bEHxHH48W3UdqVqfk4sXf/lMnFEemO0ZAHCLe5Pq+iqBYlhePSXRBPqf1F0WwmkCUAGCw4dCtMJXbdj5t1IWjyFoyOMNOnLJMGxpYavycn5YgnwZsGDl6Bw9fhitaUFWc4NIhlrWjDwZD8XkT0MphFkmz2FHhy61GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=ECeX9tSt; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
	by m0409409.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 6379gbrT1495411;
	Tue, 7 Apr 2026 11:50:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=+JfSUUAam
	ixAKMx8rprxOv9r7DXKIHcwyfCboANxFUY=; b=ECeX9tStd47KAfTzD3nmmUq9z
	vIx24b85oPXk3U6VtCLaAO7Zj64521+2Gu8B4O0cs+LP4ElOKRtXnHKc8+5ryMS3
	4GXWFBXoM4P2mKGr0p70b4qiTWDbCGOOL2xU1Ij9Zy1CBd6rzZP+YQ/ACiPK8OnP
	lO1wp/rA2ZxSjPRslSX1n0hafrLvNEhMRFgFRZSAoqSeME8+3uhZTuQE1EaZ6P0t
	2vInaaeFqjN2xnjuSglxrvBBbPpFwQolvVb7x+WOQKoGI3Nl5odoAIhzAHXiSvqd
	rPHs+miLH319WQbVFgXx5/kzlhwMKu/BkNAdWSIfC58I8Tg8+mlNt//8aOrUQ==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
	by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 4dbbymrgg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 11:50:21 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
	by prod-mail-ppoint2.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 637AnvTI002322;
	Tue, 7 Apr 2026 06:50:20 -0400
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
	by prod-mail-ppoint2.akamai.com (PPS) with ESMTP id 4dcmejabh2-1;
	Tue, 07 Apr 2026 06:50:19 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay01.akamai.com (Postfix) with ESMTP id 036D180;
	Tue,  7 Apr 2026 10:50:17 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nick Hudson <nhudson@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
        Anna Glasgall <aglasgal@akamai.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 5/6] bpf: clear decap tunnel GSO state in skb_adjust_room
Date: Tue,  7 Apr 2026 11:50:04 +0100
Message-Id: <20260407105005.1639815-6-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260407105005.1639815-1-nhudson@akamai.com>
References: <20260407105005.1639815-1-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604010000 definitions=main-2604070101
X-Authority-Analysis: v=2.4 cv=K+sS2SWI c=1 sm=1 tr=0 ts=69d4e16d cx=c_pps
 a=BpD+HMUBsFIkYY1OQe22Yw==:117 a=BpD+HMUBsFIkYY1OQe22Yw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=TTBIr9FR-UdC54aaq7Eb:22 a=X7Ea-ya5AAAA:8 a=KTWMYobbTIzsJsqZ07IA:9
X-Proofpoint-ORIG-GUID: aa2Loe4wzLKBDemvNcJpCZlX54LSpiGm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5OSBTYWx0ZWRfXwhJoI1PyOO8g
 6TyB5GtpX3IcfmZ01/q6EAf4sWw4jjk/otz8TAaS1zWxorbUS2B/YwdtW8FAl6KWaYXHmDWQpgC
 oQcSaZpB1n5G2DQua24Boy9661pyJBQfmcM2Li/7u2dRQqskDOI7Ti0BIziyD9T3vcYNNeYEHx9
 BU8EKMmtjoI0dkvk5jk5OAvP7SytPweFCkaiARvAuYvhXeQb2MdWilUHsbijL3t5DIK8AjbAazu
 qWeHtdQpApI9YiSHzREXU2BbOeh6cKntp9Kyg8DkjEYGIarKfPWnxG8xfpByC98B3Y3q7yF6h8Z
 1trDtatYChINrJioiKWSLxn2oMyejPZfbV3x8nJQM/oMBi39LpVFRFt/8aj7uSxuonaOsOvpnC8
 70RtiAbq+c9stzbwRjTALaeLNIznCD6xjp5UcuDBJsPLwfJgUST0sTnqw5ZMdkYiTME8O3b22bD
 EfA6tD+vRlmh0giFzLA==
X-Proofpoint-GUID: aa2Loe4wzLKBDemvNcJpCZlX54LSpiGm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070099
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275949-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:dkim,akamai.com:email,akamai.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 782273AD3E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On shrink in bpf_skb_adjust_room(), clear tunnel-specific GSO flags
according to the decapsulation flags:

- BPF_F_ADJ_ROOM_DECAP_L4_UDP clears SKB_GSO_UDP_TUNNEL{,_CSUM}, and
                                     SKB_GSO_TUNNEL_REMCSUM
- BPF_F_ADJ_ROOM_DECAP_L4_GRE clears SKB_GSO_GRE{,_CSUM}
- BPF_F_ADJ_ROOM_DECAP_IPXIP4 clears SKB_GSO_IPXIP4
- BPF_F_ADJ_ROOM_DECAP_IPXIP6 clears SKB_GSO_IPXIP6

When all tunnel-related GSO bits are cleared, also clear
skb->encapsulation.

Handle the ESP inside a UDP tunnel case where encapsulation should remain
set.

If UDP decap is performed and GSO state removed then reset encap_hdr_csum, and
remcsum_offload.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
---
 net/core/filter.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 7f8d43420afb..04059d07d368 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3667,6 +3667,46 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
 			skb_increase_gso_size(shinfo, len_diff);
 
+		/* Selective GSO flag clearing based on decap type.
+		 * Only clear the flags for the tunnel layer being removed.
+		 */
+		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
+		    (shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
+					 SKB_GSO_UDP_TUNNEL_CSUM |
+					 SKB_GSO_TUNNEL_REMCSUM)))
+			shinfo->gso_type &= ~(SKB_GSO_UDP_TUNNEL |
+					      SKB_GSO_UDP_TUNNEL_CSUM |
+					      SKB_GSO_TUNNEL_REMCSUM);
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
+		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
+			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
+			if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
+						  SKB_GSO_UDP_TUNNEL_CSUM |
+						  SKB_GSO_GRE |
+						  SKB_GSO_GRE_CSUM |
+						  SKB_GSO_IPXIP4 |
+						  SKB_GSO_IPXIP6 |
+						  SKB_GSO_ESP)))
+				if (skb->encapsulation)
+					skb->encapsulation = 0;
+
+			if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) {
+				skb->encap_hdr_csum = !!(shinfo->gso_type & SKB_GSO_UDP_TUNNEL_CSUM);
+				skb->remcsum_offload = !!(shinfo->gso_type & SKB_GSO_TUNNEL_REMCSUM);
+			}
+		}
+
 		/* Header must be checked, and gso_segs recomputed. */
 		shinfo->gso_type |= SKB_GSO_DODGY;
 		shinfo->gso_segs = 0;
-- 
2.34.1


