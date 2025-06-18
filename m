Return-Path: <netdev+bounces-199281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FA3ADFA0F
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 02:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA760189C85B
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 00:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF844171CD;
	Thu, 19 Jun 2025 00:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="nhF3BEGN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2647229A0
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 00:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750292354; cv=none; b=B50Jx5wQHyYgRYLN5zHMKEk9FGGsnqWrGRuFTBuXuh9djhC0zJJ3N3hb0iGj1wOJo2yfZefnS2Qf/suecDhCuGkFxX7O9GwETLK12ZqHu/OTAQE7atmBJ3NuA3q7zmjj/dsIXIyXzf858IhGKhGqPE6rdIhEcDYU5dXGyVIrD8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750292354; c=relaxed/simple;
	bh=1pdGs8PCp1UcfvBUEXk8lET8V2GQ20A0pL1erU9Fkss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G4mccpdLkDAc7//3rp87uF5mv6tUMpsN83QQ/+/i5FR61rEE+sCWfNNEyPHXedkOCFHd3BRx5vo8Vwq2BshuSSXMpAjTC7mIwB9IJ0expkKebssz+p1vpZYmZ5o0xJ9iggtTF1eJe/wjwezWz74ff3GMiWNNd84F1jEMjsKhgws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=nhF3BEGN; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
	by m0409409.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 55I0E1li028818;
	Thu, 19 Jun 2025 00:13:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=jan2016.eng; bh=lwO6or+sX6L6YwMfjpDLPwlZGQuXCpG7O
	et+pkopD1A=; b=nhF3BEGNACAm4kJ/uUGejZ3lJOX1bNRgTdnSSFyoSJ8VxBpJv
	BUFb9SF8i2bn1BXjGLXvZQ9UQ4Vbh98pzeAN+k+5CYDq8uuDfcnNGjeVAamXIoaJ
	qOJV55DDeToY+9KydggQxKaT+KH62eidxNxj1nPALdEcWGNS3mSUYx66iC4rbfWy
	ZwiRnWvcmKPSV4TIXX4WteGbDcFhBAesCwOMjIwiSr+cf3rWcEF6NsqnCs6FxMvl
	JmTYDwGiLbkvkRcSiP6ERcnvDLXwRgRNjwsoIlwkYfXv+FYeDu6/MQvbU0chagwe
	hfu+5D2P6KF/EAfQ1xB3m9PWh57grQqY8BCeQ==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
	by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 479jdxdx1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jun 2025 00:13:44 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 55IKZIiI028389;
	Wed, 18 Jun 2025 16:13:43 -0700
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 47bt2tuk1k-1;
	Wed, 18 Jun 2025 16:13:43 -0700
Received: from bos-lhv9ol.bos01.corp.akamai.com (bos-lhv9ol.bos01.corp.akamai.com [172.28.41.79])
	by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 34AAB33B2C;
	Wed, 18 Jun 2025 23:13:43 +0000 (GMT)
From: Jason Baron <jbaron@akamai.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com
Subject: [PATCH net-next v2 0/3] Fix netlink rcvbuf wraparound
Date: Wed, 18 Jun 2025 19:13:20 -0400
Message-Id: <cover.1750285100.git.jbaron@akamai.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_06,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=1 phishscore=0 mlxscore=1 malwarescore=0
 spamscore=1 mlxlogscore=216 adultscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506180198
X-Proofpoint-GUID: hNpsKI-HpgjiLIwDjYVmlNFiZqkqsWvB
X-Proofpoint-ORIG-GUID: hNpsKI-HpgjiLIwDjYVmlNFiZqkqsWvB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDE5OCBTYWx0ZWRfX7NpJZlIuDuJ8
 hCCH5q7RHAhN2KUD40lWVBwATDyYxr76sEW/b9rDWUhxhfEGkcGPFasKQeVh0613aOh+lIvwlSb
 fJ6Y9TEQQmyqsiwKo1ZWIlnQ4StIyyaYeNtyIJxq0qLvTZlMdz4xAx9c1fy34InzplyRlaQUgHq
 +qINLLiBdXFFlUbFwPtcDEHabxcidOg9vBAar7kXh9C+iwUWVOLrUbtVwHQ9gt74psUcXrvmlaj
 Rot3BHNa0LHNt/8we471Lp7U2cgBVPYaXbojJ1mW2FzJe5hLl3ohYBGsBDVshAq3spaUpEyzlLY
 SttWXYmGMWwLdQajTtjt5nfWCis7S7K9GDjfycwV/mrcWR/0aLiYnbLAlPumxFPU5/5wZOQSamB
 MmdpvjGA8Aq3fV8xLIMWiSVb2ngM6Do2SwUc+gR+eVBnmhoIBtnc2JzIBjbJdwgJ0YMTqyap
X-Authority-Analysis: v=2.4 cv=f8hIBPyM c=1 sm=1 tr=0 ts=68534828 cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=6IFa9wvqVegA:10 a=O-JOM7JplPKJ8x8Q_08A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_06,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=48 bulkscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 spamscore=48 impostorscore=0 clxscore=1015 mlxlogscore=4
 mlxscore=48 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180198

The sk->sk_rmem_alloc field of a netlink socket can wraparound as a
signed int when comparing to sk->sk_rcvbuf, when sk->sk_rcvbuf approaches
INT_MAX. This can be reproduced by forcing sk->sk_rcvbuf to INT_MAX and
this can exhaust all of memory.

I've added a sock_rcvbuf_has_space() helper function to generalize the
fix as a similar approach has already been implemented for udp sockets.

v2:
-add Fixes:
-add sock_rcvbuf_has_space() helper
-use helper functions for udp netlink
-remove excessive parentheses

Jason Baron (3):
  net: add sock_rcvbuf_has_space() helper
  udp: use __sock_rcvbuf_has_space() helper
  netlink: Fix wraparound of sk->sk_rmem_alloc

 include/net/sock.h       | 38 ++++++++++++++++++++++++++++++++++++++
 net/ipv4/udp.c           | 13 ++-----------
 net/netlink/af_netlink.c | 35 +++++++++++++++++++++--------------
 3 files changed, 61 insertions(+), 25 deletions(-)

-- 
2.25.1


