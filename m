Return-Path: <netdev+bounces-275955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFxXES7o1GmeygcAu9opvQ
	(envelope-from <netdev+bounces-275955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:19:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7173AD987
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDD30300D77A
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 11:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5933ACA43;
	Tue,  7 Apr 2026 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="RkBl6XZ0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FE53AC0D2;
	Tue,  7 Apr 2026 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775560744; cv=none; b=eGf8w1b56TrvXxRZW2nZATujjJov80XgUF5xddMmtAwLeioJLnxirolhKvD+KNL2jeObn2pQePL2cGhPloDzTCU98BaPRg48rqpCLlY72fL+7iRyts2J6VCOEblyRSYt1vmej0yrHAy9vCiobFeRvKu6mqL916H+MUcRl5BoElI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775560744; c=relaxed/simple;
	bh=XFWP+yYv7Op8pTwYC7BBgS2sMG2E6wOzSttnqri0ltA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j30otG/77E8T35eEY3KP4mwtrc/QzMuaCVT9258OPxdeo/Sznrcb0YxD269CvROhwRx/hxRCew7/wOhNJ5dMnCivys+P7VHJM+UjRE2JVj3hVBSdq5as8snDJFetQynJHVu0vWIa+i07ROwUIKpdnREn/vXuMQo5dxEAdH73uQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=RkBl6XZ0; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409411.ppops.net [127.0.0.1])
	by m0409411.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 6377x9qJ1499203;
	Tue, 7 Apr 2026 11:50:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=QXb7xAciK
	CGZeYHiKlYr17f4TzTjwyCF6FQFa6X5U9k=; b=RkBl6XZ0JUGI7HhrbhFWDWRDg
	mWNWp/Z5OHtP5IcIAbyVtRPmxf8F1bm8XGUXU3WNmgenkExpzQnMtNSNbXomVjeX
	Ii97Zxm/kY1+zp619ktmE+dSSjLiP888CxfXuJYy7wNiqQuSUScQfj+uHwqKkXbE
	HigqvzXzl9gWT83WMGKY623kyh3L0y4jODrnchdnDN/Gsv42YHlNjE8VNIHHb60n
	JgOseqKuvqxljUy9L6cgfxd3b+ib+JXBWgav+Gk4JFRoqw7m/m7vQaGPNn0JhmJZ
	PO2+7z1TY161B+5dTqOWrd6VpDml6V5N6vNKChlPivtVZJk93cJDLUSdOdUUg==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
	by m0409411.ppops.net-00190b01. (PPS) with ESMTPS id 4dbbyyxjfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 11:50:12 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 637Anuxn001030;
	Tue, 7 Apr 2026 06:50:11 -0400
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 4dcmejac6p-1;
	Tue, 07 Apr 2026 06:50:11 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay01.akamai.com (Postfix) with ESMTP id E447184;
	Tue,  7 Apr 2026 10:50:09 +0000 (UTC)
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
Subject: [PATCH bpf-next v3 1/6] bpf: name the enum for BPF_FUNC_skb_adjust_room flags
Date: Tue,  7 Apr 2026 11:50:00 +0100
Message-Id: <20260407105005.1639815-2-nhudson@akamai.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=724
 lowpriorityscore=0 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604010000 definitions=main-2604070101
X-Authority-Analysis: v=2.4 cv=YrE/gYYX c=1 sm=1 tr=0 ts=69d4e164 cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=XKgOefoLEnF0tNwW78TB:22 a=X7Ea-ya5AAAA:8 a=1XWaLZrsAAAA:8
 a=TMHggaePV_XZxh6C_gsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5OSBTYWx0ZWRfX58OMZhxsscVK
 AedkSWof2myN+zA/Kuuj9IGM3xuE/x4zcAUaMyNmUsHDGKivAQRCZ1QBOKuh0nM2rh39NZ3eMvP
 z1RB7DrxYVjULVBS/EuTzgTGKqig8VB7/fza6/v8vTRNlqVEvfaxmSIGng/hDBluFo07gqwdPxw
 ZsRDxf56IdiGm96EPcBmOAjmXIltSVNe5bLBxM9wOvT2/3iTvSF4PZNfPLCrkMynXYMhrhdX6Yr
 BsXL3HBZauC4/u4thl71goYrXQrhgL04/yhO9PWtkcqCAdGUivM0lgfQv0HjKPFx2hevbc4z0Ee
 c3vzaXHZnPFFcrQDIPA5fJ73x3fp25Tj7D1HazcGT9LJiyFNA9SjOPwvyZhYvMRQWLOFL2ebv7z
 k+Jot0mmnY9M0l0tLxvMTUmouQFBT/K8Y0SOtv7awR4nxr4BhfjJ6p5IlYhXhjDahA0+trlXHF9
 LUpYmisIoIucu+QiuAQ==
X-Proofpoint-ORIG-GUID: zfAH1hgxxVRYzHRCKxp_M5yURcRkxZ40
X-Proofpoint-GUID: zfAH1hgxxVRYzHRCKxp_M5yURcRkxZ40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
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
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275955-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[akamai.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,akamai.com:dkim,akamai.com:email,akamai.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: DF7173AD987
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


