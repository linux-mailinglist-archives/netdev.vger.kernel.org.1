Return-Path: <netdev+bounces-269016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IN7nFHCsumn9aQIAu9opvQ
	(envelope-from <netdev+bounces-269016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:45:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3052BC461
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 528173046E92
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3453D9024;
	Wed, 18 Mar 2026 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="Iwfhsx41"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC353BA22B;
	Wed, 18 Mar 2026 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773841395; cv=none; b=DvOJX+Pn2k3gzTWD+E28IDgz5N0J1vWtUD0+Y525HawJbNDpCNWwARijQg18LxGNIV9K+GxNs+fjRN7e0m/jjhFoVXlh9u9qg0SXGoPvO8B3Kvm4i1lWjaiO0HiuMc3R5KH2alSspo+t1NV53ylaymcw2jZcW0Xvmfw/KUvSWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773841395; c=relaxed/simple;
	bh=aQBT0CCxDMOXcpIo5nD/Fq4QKrdvjAhHbTzdjNLMm1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pRYt6XQMxjUJT8ez4nPer022H4I8qJicxNx3DkjKoVqvnHlYO8w3KjNpCB4c229oBdJ7q4fY7acvWk4KTGFyPWpxQ5QfBbn7abIVPmvDg5i8zhzSWbaK+BunNLPI2y9YuO/A6BZTrPOerKPu0DlUDBlV4LdeF/tMwgUEMbze1yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=Iwfhsx41; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409411.ppops.net [127.0.0.1])
	by m0409411.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 62IBIlVm4005139;
	Wed, 18 Mar 2026 13:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=jdZ3KkN9b
	JH1LNJaRWfghhJEw4rB20ARY9d4RT3FKdw=; b=Iwfhsx41qDih2TpYX5B293Fyw
	KAYDtMrA5RdWeeyWAR/DmPOjPZv0oei0bROnJ0CR/bkDCf4Wgy+daxdaEPPC2uNJ
	XJa6nVr6aHaLdjcj4QfHqkwk9Nlx7t2RrnzONwAxIptBefahwL6zVmj5uwGCy6lk
	Gb7XS2zWkPa2Qt5Juo47RSvhI1xeObv85hCjy0kVy5fCQ/bfCChTh2yUl8RObjHB
	+lg4VU0MbwqhwrCK04XCvfoAzQ0bfJfgZfZNojXNVW5u/o75XU7Z3V0hqzhDe8Tr
	V0xgI1kRyxW/7z2fGwe/wNOXsyhzcB3HexIL3LN++ef9mKluO2Nqa3NQZi+Rw==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
	by m0409411.ppops.net-00190b01. (PPS) with ESMTPS id 4cwhw64u2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 13:42:46 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
	by prod-mail-ppoint2.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 62IDYZqe011788;
	Wed, 18 Mar 2026 09:42:46 -0400
Received: from prod-mail-relay02.akamai.com ([172.27.118.35])
	by prod-mail-ppoint2.akamai.com (PPS) with ESMTP id 4cw30x86ef-1;
	Wed, 18 Mar 2026 09:42:46 -0400 (EDT)
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.0.147])
	by prod-mail-relay02.akamai.com (Postfix) with ESMTP id DE4DC9A;
	Wed, 18 Mar 2026 13:42:44 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Nick Hudson <nhudson@akamai.com>, Max Tottenham <mtottenh@akamai.com>,
        Anna Glasgall <aglasgal@akamai.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] bpf: name the enum for BPF_FUNC_skb_adjust_room flags
Date: Wed, 18 Mar 2026 13:42:38 +0000
Message-Id: <20260318134242.2725749-2-nhudson@akamai.com>
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
 lowpriorityscore=0 mlxlogscore=668 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2603050001 definitions=main-2603180115
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDExNiBTYWx0ZWRfXwEUVVKPRMCwY
 gjtjngU8oFVWzx2Ks9je3AdKc/i1WydOeYnl+PC6fQuWbRT4aLHKYH4W0QmMjYcnrmyN3KkCZyL
 2MNYLC+3lgKeOTEs9Lkq+Z0Ftd42sf31MyP6bw4XG731Lof7Emii9lIgFRRLnBgP0OJ8hbReYAk
 U8QPkYRfonJgDVoVwBztY2xDbZV+K+VXHDWn2e9WYd4sq2qAlcCqYv5HM1u2gvORGhqcRtkQvIS
 95tPGn+TpHdWPtfYGHWG9j3vMzEegpkc2LVmrjCL3xFC42UchpUNvX1nx8p9scWKtz8cvIE/Ldm
 CX8uZtokLAGNH1NVCNLFUSZylr+YSwPugzZEWeUmNAPq3a/mjB80yYctwGVagWxs5mdGscz5BHa
 T6/UC3fOjnolyosIVaexbIFprr4M8oIz9O68I/EYFMRKV7rSJ+o0R+lP3g76du4vLdM3AS5MFrs
 j49eNkzbt8Eqh1qBP/g==
X-Proofpoint-ORIG-GUID: 6VFJ33ioLIkqO1dn3_GPv_wkrFUPHx5s
X-Authority-Analysis: v=2.4 cv=LdwMLDfi c=1 sm=1 tr=0 ts=69baabd6 cx=c_pps
 a=BpD+HMUBsFIkYY1OQe22Yw==:117 a=BpD+HMUBsFIkYY1OQe22Yw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=XKgOefoLEnF0tNwW78TB:22 a=X7Ea-ya5AAAA:8 a=TMHggaePV_XZxh6C_gsA:9
X-Proofpoint-GUID: 6VFJ33ioLIkqO1dn3_GPv_wkrFUPHx5s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603130000 definitions=main-2603180116
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[akamai.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[akamai.com:s=jan2016.eng];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269016-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com,kernel.org,iogearbox.net,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:dkim,akamai.com:email,akamai.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[nhudson@akamai.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[akamai.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: AE3052BC461
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
---
 include/uapi/linux/bpf.h       | 2 +-
 tools/include/uapi/linux/bpf.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c8d400b7680a..bc4b25eb72ce 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6209,7 +6209,7 @@ enum {
 };
 
 /* BPF_FUNC_skb_adjust_room flags. */
-enum {
+enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_FIXED_GSO	= (1ULL << 0),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	= (1ULL << 1),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	= (1ULL << 2),
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 5e38b4887de6..db2c520d0e92 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6209,7 +6209,7 @@ enum {
 };
 
 /* BPF_FUNC_skb_adjust_room flags. */
-enum {
+enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_FIXED_GSO	= (1ULL << 0),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	= (1ULL << 1),
 	BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	= (1ULL << 2),
-- 
2.34.1


