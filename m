Return-Path: <netdev+bounces-278979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH6uBgql4GkEkgAAu9opvQ
	(envelope-from <netdev+bounces-278979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:59:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA10C40BEE5
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D53531C2565
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 08:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992A4396B6D;
	Thu, 16 Apr 2026 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="PLUF1LxV"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06327395D93;
	Thu, 16 Apr 2026 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776329724; cv=none; b=F90GlsYfjdUSDwwEjqNk45+b2DOS4KHienAIjOJpcTjAh879eEjLxX77LVl4NXzv3uOM2gPt5sRfmXT3cUMyz3yzAweqBTUdW+AgppxpF3yT61VAEebOZEpxv65LdYjR//ZDivCgdjpSyEMei9+B2Q2hb/WWREP/7v644tkrI+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776329724; c=relaxed/simple;
	bh=XFWP+yYv7Op8pTwYC7BBgS2sMG2E6wOzSttnqri0ltA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ow0WmlWz5ffFi7t+TwRAZ/TaV9FLl69iV+7G0SegGlYdt7mAwjuwCY629IHH35fY7QW1d03IVMFyuT/zvrTRqlRYAIQZWLm1LbeHL3TxuagWcmEmh+g7LTNFuM0k4uAFbZF2SwQrTEagHlMNtC8dgUwLtAUZWc1GNNaw/pQVZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=fail smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=PLUF1LxV; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G3ZGPw2829465;
	Thu, 16 Apr 2026 08:55:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=QXb7xAciK
	CGZeYHiKlYr17f4TzTjwyCF6FQFa6X5U9k=; b=PLUF1LxVDlXHGTg0hpawJZe/Z
	HcqN0Z6Aj6Ju/EqbAx1q/osWegnWlqZgGcF8HB6TLKSH0jKCD/YiArwEOju0w3Xz
	eqSSaJ9uQ75L3Htvx05jwkVqXkLVQ2wHZuhGmJ2isp+oEmiY20J709E/r4XaB+0s
	4QFLSz7Wr2tB3LQDokkH6D5CLR+0Ccy62YV1ir3DlNbYnxG9bQMNZcr807/pBxf1
	7Tns+pRXro6yEAI3IFOwwQ5BNGiCOWOoMiM4hsHyd7dh9catwPzWWMPWvPRRfRkz
	afUp3HsKGdZXXop8YZxPlLblomfj3LGUsrnqtATDrP9CvRgQX2oZe3Hv03TFQ==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4dfeh40r5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 08:55:19 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
	by prod-mail-ppoint2.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 63G7feul025213;
	Thu, 16 Apr 2026 03:55:19 -0400
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint2.akamai.com (PPS) with ESMTP id 4dj2v8e09n-1;
	Thu, 16 Apr 2026 03:55:19 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id 7AB928D;
	Thu, 16 Apr 2026 07:55:17 +0000 (UTC)
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
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 1/6] bpf: name the enum for BPF_FUNC_skb_adjust_room flags
Date: Thu, 16 Apr 2026 08:55:09 +0100
Message-Id: <20260416075514.927101-2-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416075514.927101-1-nhudson@akamai.com>
References: <20260416075514.927101-1-nhudson@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=724
 lowpriorityscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604070000 definitions=main-2604160071
X-Proofpoint-ORIG-GUID: CQ48Qe7-IQzfR44_BBvC_sbi20Iug-6G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA3MyBTYWx0ZWRfX39Ar2rlKfQ/H
 jcQPiPD6/UjeuzmYPCGTfV1WgasqY4xSnxuJLASFl2cCufV+XADZGIk7aXqDBFM5UPF/IQBz8Oz
 oVnkH/jyu02b4KGl1fv62OROPgvGxKVeNtjRULaoGFh/3N8WWFbM2+3+I2GUe4Fn4J/9L51qOuE
 XQ1jHzNuZBi1a91AOnWzGprrk9sPrnVCtLu1fBWOkxTNO1qWOyhDfB0rXh9wr04fmX/wv76QB1v
 vtQoHC2GPp9cM8gYuheNETM0xb/i7V0rzXY+9zEjYA1ITTUmIYY5cR5kWgDoTNzC5sMFWcIBdRj
 BS5eObfxFwxIegl2ELCPS6X79YhwLoGJ0HM4GJJfhUq+cb4BCdrFPpG7jffPfoBFQh7BZ2efITX
 Zd7Y/PMjglysCzZRchhmrUqzZEwtQ2n8Yg3FZ1AXbPiEibJ6x5lMuC2TTTTDUuN2PCWKhY6yMQY
 Pl5mnwkKuGFL3AEkBvA==
X-Authority-Analysis: v=2.4 cv=GfonWwXL c=1 sm=1 tr=0 ts=69e095e7 cx=c_pps
 a=BpD+HMUBsFIkYY1OQe22Yw==:117 a=BpD+HMUBsFIkYY1OQe22Yw==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=4xFXqd-_BHBjZVyr95gr:22 a=X7Ea-ya5AAAA:8 a=1XWaLZrsAAAA:8
 a=TMHggaePV_XZxh6C_gsA:9
X-Proofpoint-GUID: CQ48Qe7-IQzfR44_BBvC_sbi20Iug-6G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160073
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278979-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:email,akamai.com:dkim,akamai.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: CA10C40BEE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The existing anonymous enum for BPF_FUNC_skb_adjust_room flags is
named to enum bpf_adj_room_flags to enable CO-RE (Compile Once -
Run Everywhere) lookups in BPF programs.

Co-developed-by: Max Tottenham <mtottenh@akamai.com>
Signed-off-by: Max Tottenham <mtottenh@akamai.com>
Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
Signed-off-by: Nick Hudson <nhudson@akamai.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/uapi/linux/bpf.h       | 2 +-
 tools/include/uapi/linux/bpf.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 552bc5d9afbd..c021ed8d7b44 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6211,7 +6211,7 @@ enum {
 };
 
 /* BPF_FUNC_skb_adjust_room flags. */
-enum {
+enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_FIXED_GSO	= (1ULL << 0),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	= (1ULL << 1),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	= (1ULL << 2),
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 677be9a47347..ca35ed622ed5 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6211,7 +6211,7 @@ enum {
 };
 
 /* BPF_FUNC_skb_adjust_room flags. */
-enum {
+enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_FIXED_GSO	= (1ULL << 0),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	= (1ULL << 1),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	= (1ULL << 2),
-- 
2.34.1


