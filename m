Return-Path: <netdev+bounces-131588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102E098EF5E
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41AC81C20D67
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A00A186E42;
	Thu,  3 Oct 2024 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SaZ1nLzs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7018D1865E9
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727959197; cv=none; b=pMhz9ga+QJvEf6iPP2HXYkleYfSKwGgjmeHfkBQVXGBQ0OF2wOWweWoisCJqtht0blBpoVc5yVSDMlYFRELWRgo5XhqrexUCEEXrij2BU1NMVRHSvsYdv5l0myZqnUxI0eoAUkn2mRv6pwQpNSRgCTkX1moN3l9K3SLKUtddFj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727959197; c=relaxed/simple;
	bh=FTmaLXhU+8Yufl6Iz+JDPaPu396pDBEfE8QmtNIgqbU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=spSDWMETi/m8/5LRfvKLpfrPIL85sK+AnG1uNDa1tlBOvl9U9N4F/YegcuoPY+eWuFIh4HkD9mYoJqPj9KiEFpBfCxlq8IFE3ODfm9MAVHNZ4q2XJVvcMy56KlVzTZEI81khDTfYjFtlic3s0FQw0dPj4Xb9BK8v/w4AbbmsfEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SaZ1nLzs; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4935dIrf001624;
	Thu, 3 Oct 2024 05:39:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=GJT
	jbv/pq4fyW8S+o6zE5hFncHsxmhoxJe5ZGo6Wyqs=; b=SaZ1nLzsyM7sSfPcbsh
	7lSlMi8rO3DMrQs9//8mcTZ/vzd2nCCDqDwcwOtCru/PCTqc71CxTbRijAYAX6DC
	OO8xmgbQEsLVN8plxF/3i06PX/cmbXz+IHnk8EXnfyCn7QWX+DXpsoLKLqVjtH4v
	olJ4/NUeFicUaGjEXx1Mxb/2Nb424MqVdlLBTYJTR+APFaRAIu2FvqmEcCpr2bVw
	OSAleQ2EkFulkkRmD9YRB3WhG6/msrwKEe6r3NJl8sf69yhP9/7tMzK1Tn+a4oMx
	a4kf1H9YboTQZxBf0+EE2vBxU2HuPB+VUHAkjqaJ1ctNqmWz1KOWeooOHJltqP+P
	J0g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 421cet4awu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 03 Oct 2024 05:39:41 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 3 Oct 2024 12:39:39 +0000
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
Subject: [PATCH net-next v3 0/5] eth: fbnic: add timestamping support
Date: Thu, 3 Oct 2024 05:39:28 -0700
Message-ID: <20241003123933.2589036-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Nepe22vfmE5bEvRrSv1KRmSOp4RnpeXO
X-Proofpoint-GUID: Nepe22vfmE5bEvRrSv1KRmSOp4RnpeXO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01

The series is to add timestamping support for Meta's NIC driver.

Changelog:
v2 -> v3:
- rebase on top of net-next
- add doc to describe retur value of fbnic_ts40_to_ns()
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
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 166 +++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |   3 +
 11 files changed, 728 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_time.c

-- 
2.43.5

