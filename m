Return-Path: <netdev+bounces-289239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DsrKHu9C2rBLwUAu9opvQ
	(envelope-from <netdev+bounces-289239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:31:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC67E576160
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 03:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF4433021993
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7F025A2A4;
	Tue, 19 May 2026 01:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="ZY8DfArb"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3774E1E260C;
	Tue, 19 May 2026 01:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779154295; cv=none; b=cKw9t4/r/6wSz3hl/Q05UWd8ZJhzGmQwdrdMTAg03X+aYfyHwmHVnsT5OgJI/m78dGbCWIc6PPgh82LRoqXoUJg3YR1lBTyAr9FeCKxN4iVoSa2Y63pQusezvaA1L5MmUadv2JmdqlqF/2AOQnYlHTUW2n2OVqVpiRbz3UNXW/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779154295; c=relaxed/simple;
	bh=uQBDNkbgFoYYysbs6DAsfASINflNg7FzUPNs+ggaxMk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KaFmoUGvqjSKoYbLiJeSuoThaY3YjS8PnsTTAYkDB0ePTiLPbeSQiwPJ03svUYR0nFgpeNPFvqwlPkJGvYCeZdK0n2ShkVvqU0fyhyAxenL8dFQI7Z6RIpSUXGToOF3s41+m3G3Y5jE3M94sr5VKOL4IEGO7KiLgjgjG7kqB/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ZY8DfArb; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J1CGqq2586966;
	Tue, 19 May 2026 01:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=kLyCJk399
	5xnxSjLpmutqpMh2EPrSJEbSZDKpOBhZhA=; b=ZY8DfArbdWTNkLqWqWqUpBfMF
	ZH77ehyuaGWKZ5/r2idL03jJgVpjNCTSX1ADVAE8db7uhR2RWP4RCuv+h/5kZoC+
	K0DxvgcRTc6Zisu8IajL027x1YzPToFXtYCeIncrbIiPQ92EVGbBIhmgqcQw7XAi
	kabhwG5kcTTw5o1Wb5sxqtGAEeM54hTQF8OlJ6E2RrkP0rbfdBPJS9pVm1qVqPgb
	PQWAqsROdSXskDNTkWAjdyc7NCWaqRb42jA7UMf4raUaQgvbOGEUdMksYlEUjYM5
	IOx0Se6kntC2tWFwUaX1wUtA0CfWUf5apViwRbzofCYTEriH0tHS7ap4rJnfA==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e6fj3tvnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 19 May 2026 01:30:47 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 18 May 2026 18:30:46 -0700
Received: from pek-yzhou-d3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 18 May 2026 18:30:43 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <david+nfc@ixit.cz>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <bongsu.jeon@samsung.com>, <oe-linux-nfc@lists.linux.dev>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] nfc: nci: fix use of uninitialized memory in CORE_INIT_RSP parsing
Date: Tue, 19 May 2026 09:30:42 +0800
Message-ID: <20260519013042.3459906-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: hpWTxKU7caZqhx2N8ETpHHtAUS9w6Adp
X-Proofpoint-ORIG-GUID: hpWTxKU7caZqhx2N8ETpHHtAUS9w6Adp
X-Authority-Analysis: v=2.4 cv=VssTxe2n c=1 sm=1 tr=0 ts=6a0bbd47 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=lDSW3XYVVtuoAbsBu0EA:9 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDAxMiBTYWx0ZWRfX3MDqxp5dUTVV
 FQTeT8OZGC6TacvCqP4Ge8rMTa1Y9/nZeXEw4Tm+F0Shq0GJjWWVVCtE6y3p009xMYYoMJcEzjo
 wkQFwntzF9lntBudx3GfCuOynX5K1zhaoe7bg4GldJG0n757Q5WYSmgJr2UESGTawQlJNVdMRlz
 0YsPjw19MGqIZHJ1vBFlM2tj7fIxSTdUmUx4/wpeyq09tsRwEBLoezoy0gnC+XVvf792RKFUoc7
 Zq+9aVDVTqz+3h8RZ4WyPVnHlwFgwLySPkUdP7gCztkn0raq72lkx2FiQeb35b9QDRmbCx1dHmj
 pQZGLXo1wqVAwbWmD4q1VVlsvQXb35M1+8xXkn58sOiRNzvN2HZoCEZ9+1qNyDHfw0HCAOEIMTu
 CI9NcCyIm7yMuwlHo7nILJcNfttyerrtQkLngvSWJoc0qfeUFekVaC1p/8zygbgI7ZfTiFilPlK
 Bcvwrha1R7j7ll28Okw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190012
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-289239-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[windriver.com:+];
	TAGGED_RCPT(0.00)[netdev,nfc];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,windriver.com:email,windriver.com:mid,windriver.com:dkim]
X-Rspamd-Queue-Id: DC67E576160
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nci_core_init_rsp_packet_v1() and nci_core_init_rsp_packet_v2() parse
the CORE_INIT_RSP packet without validating that the skb contains
enough data. A malformed response (e.g. injected via virtual_ncidev)
can declare a large num_supported_rf_interfaces while providing
insufficient data, causing reads of uninitialized slab memory. This
is later used in nci_init_complete_req(), triggering a KMSAN
uninit-value warning.

Add skb length checks before accessing packet fields:
- Validate the skb can hold the fixed-size header before parsing.
- In v2, bounds-check each variable-length rf_interface entry and its
  extension parameters within the parsing loop.
- In v1, verify the skb is large enough for both the variable-length
  rf_interfaces array and the trailing rsp_2 structure.

Reported-by: syzbot+46ca2592193f2fb3debc@syzkaller.appspotmail.com
Fixes: bcd684aace34 ("net/nfc/nci: Support NCI 2.x initial sequence")
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 net/nfc/nci/rsp.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index 9eeb862825c5..36e49fb7d894 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -50,6 +50,9 @@ static u8 nci_core_init_rsp_packet_v1(struct nci_dev *ndev,
 	const struct nci_core_init_rsp_1 *rsp_1 = (void *)skb->data;
 	const struct nci_core_init_rsp_2 *rsp_2;
 
+	if (skb->len < sizeof(*rsp_1))
+		return NCI_STATUS_SYNTAX_ERROR;
+
 	pr_debug("status 0x%x\n", rsp_1->status);
 
 	if (rsp_1->status != NCI_STATUS_OK)
@@ -62,6 +65,10 @@ static u8 nci_core_init_rsp_packet_v1(struct nci_dev *ndev,
 		min((int)ndev->num_supported_rf_interfaces,
 		    NCI_MAX_SUPPORTED_RF_INTERFACES);
 
+	if (skb->len < sizeof(*rsp_1) + rsp_1->num_supported_rf_interfaces +
+		       sizeof(*rsp_2))
+		return NCI_STATUS_SYNTAX_ERROR;
+
 	memcpy(ndev->supported_rf_interfaces,
 	       rsp_1->supported_rf_interfaces,
 	       ndev->num_supported_rf_interfaces);
@@ -87,15 +94,21 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
 				      const struct sk_buff *skb)
 {
 	const struct nci_core_init_rsp_nci_ver2 *rsp = (void *)skb->data;
-	const u8 *supported_rf_interface = rsp->supported_rf_interfaces;
+	const u8 *supported_rf_interface;
+	const u8 *skb_end = skb->data + skb->len;
 	u8 rf_interface_idx = 0;
 	u8 rf_extension_cnt = 0;
 
+	if (skb->len < sizeof(*rsp))
+		return NCI_STATUS_SYNTAX_ERROR;
+
 	pr_debug("status %x\n", rsp->status);
 
 	if (rsp->status != NCI_STATUS_OK)
 		return rsp->status;
 
+	supported_rf_interface = rsp->supported_rf_interfaces;
+
 	ndev->nfcc_features = __le32_to_cpu(rsp->nfcc_features);
 	ndev->num_supported_rf_interfaces = rsp->num_supported_rf_interfaces;
 
@@ -104,13 +117,23 @@ static u8 nci_core_init_rsp_packet_v2(struct nci_dev *ndev,
 		    NCI_MAX_SUPPORTED_RF_INTERFACES);
 
 	while (rf_interface_idx < ndev->num_supported_rf_interfaces) {
-		ndev->supported_rf_interfaces[rf_interface_idx++] = *supported_rf_interface++;
+		/* Each entry: [rf_interface_type (1B)] [ext_count (1B)] [ext...] */
+		if (supported_rf_interface + 2 > skb_end)
+			break;
+		ndev->supported_rf_interfaces[rf_interface_idx] = *supported_rf_interface++;
 
 		/* skip rf extension parameters */
 		rf_extension_cnt = *supported_rf_interface++;
+		if (supported_rf_interface + rf_extension_cnt > skb_end)
+			break;
+
+		/* Only count the entry after full validation */
+		rf_interface_idx++;
 		supported_rf_interface += rf_extension_cnt;
 	}
 
+	ndev->num_supported_rf_interfaces = rf_interface_idx;
+
 	ndev->max_logical_connections = rsp->max_logical_connections;
 	ndev->max_routing_table_size =
 			__le16_to_cpu(rsp->max_routing_table_size);
-- 
2.43.0


