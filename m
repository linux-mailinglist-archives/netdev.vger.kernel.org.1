Return-Path: <netdev+bounces-225718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C61EB977D8
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 22:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B82F4A2A5B
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 20:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D375230BF4F;
	Tue, 23 Sep 2025 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="gfUl438g"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF7D30BBB2
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758659009; cv=none; b=jnnZuQlSgTe7/rX1GlR91Iuqvqka6Y/cUg/h5sL5G54mHlVy3+uoeBivhRH2HR3bsP83CGiPgYdpPAn2N3bfHr3OTQ4jyy7HbRN3d17oRmOZUWROADPIET0loJ2gervV+g9CF9MP/g5u1wI3y2Jephw5rsC3Gw47NB0WYVpjgE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758659009; c=relaxed/simple;
	bh=OSMUbX9bSPs8LSpsu1FOIupPXlp5+jSGnO82BlQGuYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KVZe0fCURNdHc4/0awgK1/w1+Sdzgy+2oAxiVugKTK3WUNwwECdqcOynTE2sEGnkeRo4aYJdtI6ad0bGam/5G49gHxCuvBg+mQvwugRk92XoWslda0hBtbIeRb7zc7aySv+0PFFYZWeGjsaH5GpLkLXvVAJ1pYmizvyEVsFAt5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gfUl438g; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NImYS9021417;
	Tue, 23 Sep 2025 13:23:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=Z
	x8wWMh9XKF0ByLn3vUuTzN65AIvwSeHHqX6iaEaM48=; b=gfUl438gWWYMFIReh
	VRJ0QwF4UG6P5I9svx8pd4hJuXAJixJB1XshBI0f9iNTJURdYvlg2U8Ylp+sPYzF
	aF8bGQHYwXUEZGRh+7F7sp7uR5isQkvFtAg/wBD2pY59Bu5oFEKbxbqzw/5sOU0c
	YqbwVgBPYB9E8zRE3icKE6vL7CugxpksAC+Sibyc3p1kszKosPPP26F9Jnh7BEtk
	+TUdkmh4H0t+6MVaTcebFibRy5Xwhi1r8TtRJF5cIyc+ugbAHiawLOrsM4rzUkcS
	iXcKPhlHWJAdD9IxEz0eig04U6XZqIDvQer98eWbw/gjuuUEjxmoVUDQJTO//t0L
	xqd2w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49bnagsvxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 13:23:16 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 23 Sep 2025 13:23:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 23 Sep 2025 13:23:23 -0700
Received: from 5810.caveonetworks.com (unknown [10.29.45.105])
	by maili.marvell.com (Postfix) with ESMTP id 07A7B3F7064;
	Tue, 23 Sep 2025 13:23:11 -0700 (PDT)
From: Kommula Shiva Shankar <kshankar@marvell.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
        <pabeni@redhat.com>, <xuanzhuo@linux.alibaba.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>, <jerinj@marvell.com>,
        <ndabilpuram@marvell.com>, <sburla@marvell.com>, <schalla@marvell.com>
Subject: [PATCH v1 net-next  3/3] vhost/net: enable outer nw header offset support.
Date: Wed, 24 Sep 2025 01:52:58 +0530
Message-ID: <20250923202258.2738717-4-kshankar@marvell.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250923202258.2738717-1-kshankar@marvell.com>
References: <20250923202258.2738717-1-kshankar@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=X6pSKHTe c=1 sm=1 tr=0 ts=68d301b5 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=bmR9eAtJbORf3SWsNlEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDA0NyBTYWx0ZWRfXyduOQLlnLqu0 JGf5ra/aYa4BMsuOgHM4mUigrhVXHpK1eomndYYIzbiZIQwVqaB8gxcaL/31OozGaRfuiyndRnv VimrtgjkDhHh3qDF5hhv0G5pTQCaFGQeJUxOE09mF2wutzA6AoD2zusOugSKMgyYLYYnpY9FdmV
 LGVblNsty+o5HUpDG3Nu3BCMCg4Nqqxr3YYnB+Sx0i5g0TdB0OiRQtDvw3E47rjZyefjCs+CNKH m+yTqmd426e+yeUOd50+RVw39r2OCg5bkXSHleiUFI6whUh3PByxKXzYWdPiuzbCyCwRljr434e exPyPcF6RsIHUDEDVvHDzNZ43qg922CrO9u9Us8dFFmSaTU74ZIvgUpWlacZRpWa0c0juxmlY1F UmBGp79B
X-Proofpoint-GUID: ScMM5zi8suCynCgJwvby05buTqbIaqh2
X-Proofpoint-ORIG-GUID: ScMM5zi8suCynCgJwvby05buTqbIaqh2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_05,2025-09-22_05,2025-03-28_01

apprise vhost net about the virtio net header size.

Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
---
 drivers/vhost/net.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index c6508fe0d5c8..a5c56af555f9 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -78,6 +78,7 @@ static const u64 vhost_net_features[VIRTIO_FEATURES_DWORDS] = {
 	(1ULL << VIRTIO_F_IN_ORDER),
 	VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
 	VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO),
+	VIRTIO_BIT(VIRTIO_NET_F_OUT_NET_HEADER),
 };
 
 enum {
@@ -1661,6 +1662,9 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
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


