Return-Path: <netdev+bounces-228202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AB3BC47D7
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 13:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2063B0488
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 11:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2563B2F5A20;
	Wed,  8 Oct 2025 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="PZV8eIyj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A7646BF
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921236; cv=none; b=IPna+iA4eSX437RFz2p4B6ifxUJmgk4Gt/JMQsMeSY+KHdKfrRlkW1pwLztWpZ46EcKvmmq7jyu9bvo9CkU4WcMjMBsv0OK8SZ050DoGxqmu/Vtzz2E6QJkQr76aIyb/KXL0GydA1MKC7Ydvg6pXZdhMdJ9EC/F0hClkTeIUU+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921236; c=relaxed/simple;
	bh=bL4pHV5sWg/0IPAgkWhjOpUzJF4Mj4x7MxChBtYMMhY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A+TFBIohLwHJroNkmsEPpZvIG4qDT3nrADSrpFZYu8DaU/6XFCzAlGFTuIgpvQ3caPyCjlKvOt8gTprg0r3BHDYNHGoMKFU2Lsl5YtFI1TqOsfhT0s4+Fl1O+gmTLhcT3BJfvBwql/SwUyqqpxZ5qYeh0TwU2JB+gPCplpCZrIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=PZV8eIyj; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5985v7mP030918;
	Wed, 8 Oct 2025 04:00:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=h
	LJPsErZWjsMGvKYfUfzRvclGniVuKB8qZv/niPHE58=; b=PZV8eIyjkhvnqrJ6u
	Nss2qaZkQbLsgyCPMltsEiFDydNaipgWL2jJM1y8fFApiIviJFAYoipLEPRjf7kk
	vz1RuZa19q7Sklb1/vGa6ABPczsMtjz1GpMSBa8i4uYn9DwtOeaO5WlxJYrLFyja
	a83ZvXFslgBHairzOBkk+uw/fJewlxpR76FPHx83fqv8TIQoVZrbYzAd3ngG7ViD
	ouYXdMo78329PPqH63Ddo/RUVwmcQnwOk4FZOUWPOX7cG00+RShbQxdJXYjFVLUj
	MqCCLLLXyzgMEtfZ64f9+XgFgXCCHvtU/wj/x80j/v9UX4SZzDRh4l9/5HTEkDl4
	LdWJg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 49nj8t0fwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 04:00:23 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 8 Oct 2025 04:00:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 8 Oct 2025 04:00:21 -0700
Received: from 5810.caveonetworks.com (unknown [10.29.45.105])
	by maili.marvell.com (Postfix) with ESMTP id 598925B693F;
	Wed,  8 Oct 2025 04:00:18 -0700 (PDT)
From: Kommula Shiva Shankar <kshankar@marvell.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
        <pabeni@redhat.com>, <xuanzhuo@linux.alibaba.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>, <jerinj@marvell.com>,
        <ndabilpuram@marvell.com>, <sburla@marvell.com>, <schalla@marvell.com>
Subject: [PATCH v2 net-next  3/3] vhost/net: enable outer nw header offset support
Date: Wed, 8 Oct 2025 16:30:04 +0530
Message-ID: <20251008110004.2933101-4-kshankar@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251008110004.2933101-1-kshankar@marvell.com>
References: <20251008110004.2933101-1-kshankar@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDAzNyBTYWx0ZWRfX2jwrncnHwuR7
 wmIyE+smIfr4Nw06+TtutM0EFWM/lyOyqyXrK+FoVn3+T6ugu06Sp/IOzpvgOYjTrZ9HGXFk4AP
 1uhSc9yOiiFICpDkDZ9oTnHsMrRzd3d99DoA+OP2cM1+E9oIxJ4JuYIOnGF4vdyFTv9aL7PWW+z
 TGRt4cP64gGKRbT4QxsS4BB12t1Og1a21WxJEJPPwtj69saYva5NLiKvw3Z3pKovIadsLoEtwIi
 EfjMvYrNy4Y9aI8M4mgpzKribTRBa7PuTPKvxWLgMYEGIHT3dek9NxVxT3c5n5JbYTNsWcokEi1
 IE8+o+Ov7TaXzf4xzzE19jpboqFsi7YcjetLcFGei+F0mNUBZbG//TIqCgUda9+PGgjcYN2kJRk
 R3Ppnf4Ju01TuraCUkEQqJTQHHPFVg==
X-Proofpoint-ORIG-GUID: l8ZhSlcMfk-abxHpxTU-6StOA3zJVYTk
X-Proofpoint-GUID: l8ZhSlcMfk-abxHpxTU-6StOA3zJVYTk
X-Authority-Analysis: v=2.4 cv=fuHRpV4f c=1 sm=1 tr=0 ts=68e64447 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=x6icFKpwvdMA:10 a=M5GUcnROAAAA:8 a=bmR9eAtJbORf3SWsNlEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01

apprise vhost net about the virtio net header size.

Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
---
 drivers/vhost/net.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 35ded4330431..8d055405746d 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -78,6 +78,7 @@ static const u64 vhost_net_features[VIRTIO_FEATURES_DWORDS] = {
 	(1ULL << VIRTIO_F_IN_ORDER),
 	VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
 	VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO),
+	VIRTIO_BIT(VIRTIO_NET_F_OUT_NET_HEADER),
 };
 
 enum {
@@ -1655,6 +1656,9 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 		  sizeof(struct virtio_net_hdr_mrg_rxbuf) :
 		  sizeof(struct virtio_net_hdr);
 
+	if (virtio_features_test_bit(features,
+				     VIRTIO_NET_F_OUT_NET_HEADER))
+		hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel_out_net_hdr);
 	if (virtio_features_test_bit(features,
 				     VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO) ||
 	    virtio_features_test_bit(features,
-- 
2.48.1


