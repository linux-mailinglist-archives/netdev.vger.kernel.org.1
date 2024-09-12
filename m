Return-Path: <netdev+bounces-127869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C28E976EBA
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C076B1F250A1
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8054186E3A;
	Thu, 12 Sep 2024 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RAmTp5Fn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E6013D531
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158719; cv=none; b=t68KTML9ldjp4L7iajRcRo36ZgVyI/mf19IhCB3xHEq7QFnwrfY/0Yh9XJauQmjrLazNTvA1t0KKSiDPplsKmNnm+hZOLn40Vp99KULsSQYrKzYqFBSuveRSdDisdhyt7uGvvoe0g8I5c283F7gZj17b86RZCymhqjw58RvvBZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158719; c=relaxed/simple;
	bh=Be6rnU7EIMQtORZeCVpBv719MGvI4wXLQuzfAoKWwks=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XffiSQ/YIRbx1cvGVh/rgv2BYqlofdnOyukbQlwdm5cMF1J0RltBJlrIP5ZGjAdNhqjlMz5MsTO0zDqoyMOw+Eq+IZyYO3pd/3DkzBnYQW2el80yJHphu5kffRr/3YlTJxMhWvc1LWYkgMwqUOAeGOW+4VLOQj0qtkAJLO2Gqj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RAmTp5Fn; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CFJPKw003510;
	Thu, 12 Sep 2024 09:31:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=tSX
	p95lETI+pI3Mle8ibJKLM/6soSjdDAOVHvhb2YL0=; b=RAmTp5FnaN0zDdjO1GO
	vr30sECXOpMu4gW1FIvXB5AhXc5hFUigTQBMHAcTxUoqtzQbHZIiYohGs8anbxD9
	SamYPor+wNEzS3m62wowJyV73l55R2e35scn1Vf9rSne1j9G1rsysS+KJpOm3zIo
	iPjt4ja+BDB6MZzSYi2cGcouWVugQk2WcIIM3EtfD1X3FyiuAwYYwb9vEcOs+sQ0
	li38rGpP68JwBa3Qa4u4P+952ohc59xaYE/vRoea3Iv7qsKWJXicUSry8Pex6j0k
	dVLmlWGXSbaip/dXJN5OWuTm++4mBGuy3XeL6ETyMJGPXggi0kAH4NAb8LzYjPFq
	FMg==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41kr50w16h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 12 Sep 2024 09:31:41 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 12 Sep 2024 16:31:39 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Duyck
	<alexanderduyck@fb.com>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>,
        "Richard
 Cochran" <richardcochran@gmail.com>
Subject: [PATCH net-next v2 0/5] eth: fbnic: add timestamping support
Date: Thu, 12 Sep 2024 09:31:18 -0700
Message-ID: <20240912163123.551882-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nXVirIA2hmo4XTa3onBNX34r7eDfXWV4
X-Proofpoint-ORIG-GUID: nXVirIA2hmo4XTa3onBNX34r7eDfXWV4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_05,2024-09-12_01,2024-09-02_01

The series is to add timestamping support for Meta's NIC driver.

Changelog:
v1 -> v2:
- adjust comment about using u64 stats locking primitive
- fix typo in the first patch
- Cc Richard

Vadim Fedorenko (5):
  eth: fbnic: add software TX timestamping support
  eth: fbnic: add initial PHC support
  eth: fbnic: add RX packets timestamping support
  eth: fbnic: add TX packets timestamping support
  eth: fbnic: add ethtool timestamping statistics

 drivers/net/ethernet/meta/fbnic/Makefile      |   3 +-
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  11 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  39 +++
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  54 +++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  91 ++++-
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  18 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   9 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |  31 ++
 drivers/net/ethernet/meta/fbnic/fbnic_time.c  | 311 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 165 +++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |   3 +
 11 files changed, 727 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_time.c

-- 
2.43.5


