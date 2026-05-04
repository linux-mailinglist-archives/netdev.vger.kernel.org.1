Return-Path: <netdev+bounces-283784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB8DMER0+Gk9vgIAu9opvQ
	(envelope-from <netdev+bounces-283784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:26:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6F44BBB28
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8BBB3021E52
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 10:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA37439B48A;
	Mon,  4 May 2026 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="dbWSLy+a"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FD83976A0;
	Mon,  4 May 2026 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889957; cv=none; b=hY6xu299OQO5MquGlGihPXnzcOWK4waUtB3Ps/fLuO68vSjpIv9dSk0W+XD6GZlWXvCA3JobvGg/G6GPChdSQljeIELshN3X1cAsMqJppiqPlP0mrBLCbO1BCgDcfaXh9BKp8IPk6s7RODlFN9Fz+IQTBSv/mZnFUyKDmWm3Tyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889957; c=relaxed/simple;
	bh=B9PztazuqRQ5Q8WBiRRSkloZBGk5uN5tNczsCGdRr80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ng9Gmmh4eN+s8FbTSDfRqapBKkk+hvokYAN4kT3HHT2MmShxZ93TD9pEuY81v/mlN/+CRo8YRG1ZdlxyBCjH8qetJaXvPk6/SEo04gX+KuGALG8S/qwPQuFZc4lqH3GrlQ4F+tWze8CBEYw2i1J1Fg30YnNzIuCbDDTlrEq0QYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=dbWSLy+a; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
	by m0050093.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 6441f1Ax2352384;
	Mon, 4 May 2026 11:18:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=fjsfqYchq
	3DjEAG8b/CETK61SPAP70Nmy/r/vD5tnVg=; b=dbWSLy+aO2g1cUZ1vOQ2x0Zvr
	gnT0QtHsPhqTG34WWufko9ZMBVg3+wEQggwHwBK1YgyJrK0f6idUq2Ga1i4rRX2H
	N5GechDQMPFZNU/vUiGdvrxv4CbbBVmpYHw2/Fmvp3hA7v1B/AWTr19FyXGwj0lK
	tI5ea3JAkujT4UBhRRo8dX3WVC7fbfS1iELu2hkPXZHUt2umb9rabNeHSNQ/jxHT
	WG/gFVZMz8HLXp0CVl0jBEiWcSjEUxmioL+3MWRZw36mrByPyU6Icz00qx75k65/
	J12OaPOkCHptZYazBQAYD0XsFWlCSfjrTzYZxAV8yzW68Tgt2tHIqfzbrCs+A==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
	by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 4dw8hp8vdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 11:18:13 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 644ACGaI005922;
	Mon, 4 May 2026 06:18:12 -0400
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4dwckwq08u-1;
	Mon, 04 May 2026 06:18:12 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay01.akamai.com (Postfix) with ESMTP id BB92284;
	Mon,  4 May 2026 10:18:10 +0000 (UTC)
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
Subject: [PATCH v6 5/6] bpf: clear decap state on skb_adjust_room shrink path
Date: Mon,  4 May 2026 11:17:58 +0100
Message-Id: <20260504101759.3319427-6-nhudson@akamai.com>
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
X-Authority-Analysis: v=2.4 cv=Z8fc2nRA c=1 sm=1 tr=0 ts=69f87266 cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=d4nn1RXdvEacMIURMw2s:22 a=X7Ea-ya5AAAA:8 a=cwecSWJ0lc1IdipTo1IA:9
X-Proofpoint-ORIG-GUID: W2qgSKo2dGQBrqp-aY1PbFNDgv8VsgTG
X-Proofpoint-GUID: W2qgSKo2dGQBrqp-aY1PbFNDgv8VsgTG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEwOSBTYWx0ZWRfX+7C7TCAvpm14
 29rdzmtSDcoiJ/8b648FAYkoKEXQxPpWy54taiunF0PJLwP0TY/Un06nRTGqPzckaTOk21UqXBh
 6pidY4ahsikqV3bYUGIL0z/8XEt9w7quxIoZU0O16F1DZcxQSXVZOyLrWk0qEonlonEwbwzKv+J
 G90Qx2aFnTFwXG9WP+hkvi83I96mVJu70Omt223M4s2SebRIuJENFCVgrbuLNQ+uLHVqIcfRMGW
 XfRtIrExiufMePJudfM4SxIH6xRxajnHEkBmcVuAPQScsC3gsIkYMMWCpfIYyb8HCICPIfLgc1q
 7r3107aoTUcUbf5f66I7489N9O2N3cWoHxOo29ikN1MR6e8+2JMO7LPnQx+ShxCb0RBftM1PLhZ
 RhrIvTVZd5Yy3oWhIFY5Dh3WbV4Plut5fKYbq34lEDCSsylKvr2+u88MNUX4u0jK+VSkQaLWC+V
 IvrtQqkZsIZ9X1nz/ZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040109
X-Rspamd-Queue-Id: 2C6F44BBB28
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
	TAGGED_FROM(0.00)[bounces-283784-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:email,akamai.com:dkim,akamai.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

On shrink in bpf_skb_adjust_room(), apply decapsulation state updates
according to BPF_F_ADJ_ROOM_DECAP_* flags.

For GSO skbs, clear only the tunnel gso_type bits that correspond to the
requested decap layer:
- DECAP_L4_UDP: SKB_GSO_UDP_TUNNEL{,_CSUM}
- DECAP_L4_GRE: SKB_GSO_GRE{,_CSUM}
- DECAP_IPXIP4: SKB_GSO_IPXIP4
- DECAP_IPXIP6: SKB_GSO_IPXIP6

Then clear skb->encapsulation only if no tunnel GSO bits remain, keeping
encapsulation set for cases such as ESP-in-UDP where tunnel state remains.

For non-GSO skbs, there are no tunnel GSO bits to consult, so clear
skb->encapsulation directly when DECAP_L4_* or DECAP_IPXIP_* flags are set.

This keeps decap state handling consistent between GSO and non-GSO packets.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
---
 net/core/filter.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 185a11f425fa..3213732dff84 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3666,9 +3666,48 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
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
+		}
+
 		/* Header must be checked, and gso_segs recomputed. */
 		shinfo->gso_type |= SKB_GSO_DODGY;
 		shinfo->gso_segs = 0;
+	} else {
+		/* For non-GSO packets, clear encapsulation if decap flags are set */
+		if ((flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
+			      BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) &&
+		    skb->encapsulation)
+			skb->encapsulation = 0;
 	}
 
 	return 0;
-- 
2.34.1


