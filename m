Return-Path: <netdev+bounces-194644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 368AFACBB0B
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 20:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4445C18931D6
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 18:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A2A18DB0E;
	Mon,  2 Jun 2025 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QpC2bpX+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD39840849
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748888421; cv=none; b=aHjJgXGkI+rGmvCiHVSmGrNw7zsUjHgeqfs/bsf3cs1do9qDQFDXObsRwcFeu64NZ/li11aP4fr9Puo+qhJaBNyE81FXlohotspl1UEPDg1tR9CFgvgxzf1LF7WF6UWObiglQN2Du4oaw4nOlUVnvYGL9GItMXJ2td73V4zy6Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748888421; c=relaxed/simple;
	bh=Q7MFlsWy+P60YJLHYovaQF/VWozUxLgoeY0ly1++XxY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PEGSh5ZoaOLIeMkZKsvLNlYYpdSWAAVBm6HYbp2iE46CukqzbQM14DdsBDzh8G/a22pj4ftSw9MJUJA+ETRpQzKjQrbsTVJQm7k5heDAjjJnG8r37kBCrWzSLTHz5gE/HUDV9oaB8vJXDPiHz+Zjjx1AXKZ7J4k8hfhvj7YrLdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=QpC2bpX+; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552HKdUb015482;
	Mon, 2 Jun 2025 11:19:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=Q8/Abd4fpszTv7QkHO8mxgt
	fMj3PCJ9wi8kPRgl7wx4=; b=QpC2bpX+X7hyNXJW9wHbb3dmvH+wjD3WPA4eMb/
	7sv+Xf7/J+HaSKVd6W/YtaIm6BZEkcZRR908071QZegEKWDJSuGH81OvchHDEH9O
	DkUI9tV5NICT0LS7/0K0mbjZ85AGzpqBZx/FWWygMjZE9txL3hfDrlG5pss/n1Ye
	umqUBTxO6RzISsfcirDiKwAZircFIgpzELTSt/SOS+KhRsBakNOOo0B3qrfkEgXN
	hwd13/4OgEQ7hV9hmP0OUaBCHsIbULulYItg0HZiwDJ0dDASMZ8lrrVOlJEI/2GW
	dGT1ThvvlIX951YNtjS4EdHyi+qUj5+4znlrajqNZucRlAw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 471g96r45g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Jun 2025 11:19:56 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 2 Jun 2025 11:19:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 2 Jun 2025 11:19:55 -0700
Received: from cavium-System-i9-11 (unknown [10.28.35.33])
	by maili.marvell.com (Postfix) with ESMTP id F16CD3F7099;
	Mon,  2 Jun 2025 11:19:51 -0700 (PDT)
From: Aakash Kumar S <saakashkumar@marvell.com>
To: <netdev@vger.kernel.org>
CC: <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <saakashkumar@marvell.com>,
        <akamaluddin@marvell.com>
Subject: [PATCH] =?UTF-8?q?xfrm:=20Duplicate=20SPI=20Handling=20=E2=80=93?= =?UTF-8?q?=20IPsec-v3=20Compliance=20Concern?=
Date: Mon, 2 Jun 2025 23:49:48 +0530
Message-ID: <20250602181948.129956-1-saakashkumar@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Y/f4sgeN c=1 sm=1 tr=0 ts=683deb4c cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=5KLPUuaC_9wA:10 a=M5GUcnROAAAA:8 a=A4Ca0PLwPqcnYoRg0NEA:9 a=QEXdDO2ut3YA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: aJzPKWpABPsmr7ihyKos2crZFOOt5hrQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDE1MCBTYWx0ZWRfX0hle4lwrHjQU WaOBQtbbKJhg7z/KhEP+UOUEUIkT9nOs0Zwc/zp0Jlv1IpzoPQXWUIH3Azno+WOtWYj6Y58DFRi 2kWumUW78QGk8OPkuk13rSB/cZgqphm5dQeRMe4RUx3+Ogju5njs+klIVFTW5670c01ne1Nts3d
 M0z+O9ZK918IMfmsjwms8/ojB811BDe0T9vArkIsSILsf4v7cXJ8e94ZRi1s8RfumFFMseYqGD7 +lhpKnlW+PaAb1OYSpNHucyqO88eE1eBw1oKfI5pFYok2txTEMAoNJDNGr96jukE38hXH22yehR us5hvtcVKBfvFhEGkFwfqr28K0QS9U4YAJVj2xhz/SBrrypOY+SNrVnJsVr332VQNJDF36RaMga
 trBf8ZKbWrBvA9Zedhei0fXPQow1P0W9lu4ByB/WX3OWbgupAPltB/fooG3h2f7/BjGUiR7E
X-Proofpoint-GUID: aJzPKWpABPsmr7ihyKos2crZFOOt5hrQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_07,2025-06-02_01,2025-03-28_01

    The issue originates when Strongswan initiates an XFRM_MSG_ALLOCSPI
    Netlink message, which triggers the kernel function xfrm_alloc_spi().
    This function is expected to ensure uniqueness of the Security Parameter
    Index (SPI) for inbound Security Associations (SAs). However, it can
    return success even when the requested SPI is already in use, leading
    to duplicate SPIs assigned to multiple inbound SAs, differentiated
    only by their destination addresses.

    This behavior causes inconsistencies during SPI lookups for inbound packets.
    Since the lookup may return an arbitrary SA among those with the same SPI,
    packet processing can fail, resulting in packet drops.

    According to RFC 6071, in IPsec-v3, a unicast SA is uniquely identified
    by the SPI alone. Therefore, relying on additional fields
    (such as destination addresses, proto) to disambiguate SPIs contradicts
    the RFC and undermines protocol correctness.

    Current implementation:
    xfrm_spi_hash() lookup function computes hash using daddr, proto, and family.
    So if two SAs have the same SPI but different destination addresses or protocols,
    they will:
       a. Hash into different buckets
       b. Be stored in different linked lists (byspi + h)
       c. Not be seen in the same hlist_for_each_entry_rcu() iteration.
    As a result, the lookup will result in NULL and kernel allows that Duplicate SPI

    Proposed Change:
    xfrm_state_lookup_byspi() does a truly global search - across all states,
    regardless of hash bucket and matches SPI for a specified family

    Signed-off-by: Aakash Kumar S <saakashkumar@marvell.com>
---
 net/xfrm/xfrm_state.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 341d79ecb5c2..d0b221a4a625 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2550,7 +2550,6 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 	__be32 minspi = htonl(low);
 	__be32 maxspi = htonl(high);
 	__be32 newspi = 0;
-	u32 mark = x->mark.v & x->mark.m;
 
 	spin_lock_bh(&x->lock);
 	if (x->km.state == XFRM_STATE_DEAD) {
@@ -2565,7 +2564,7 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 	err = -ENOENT;
 
 	if (minspi == maxspi) {
-		x0 = xfrm_state_lookup(net, mark, &x->id.daddr, minspi, x->id.proto, x->props.family);
+		x0 = xfrm_state_lookup_byspi(net, minspi, x->props.family);
 		if (x0) {
 			NL_SET_ERR_MSG(extack, "Requested SPI is already in use");
 			xfrm_state_put(x0);
@@ -2576,7 +2575,7 @@ int xfrm_alloc_spi(struct xfrm_state *x, u32 low, u32 high,
 		u32 spi = 0;
 		for (h = 0; h < high-low+1; h++) {
 			spi = get_random_u32_inclusive(low, high);
-			x0 = xfrm_state_lookup(net, mark, &x->id.daddr, htonl(spi), x->id.proto, x->props.family);
+			x0 = xfrm_state_lookup_byspi(net, htonl(spi), x->props.family);
 			if (x0 == NULL) {
 				newspi = htonl(spi);
 				break;
-- 
2.48.1


