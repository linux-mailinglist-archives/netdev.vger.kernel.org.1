Return-Path: <netdev+bounces-127348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A5C9752BF
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6521C20C47
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 12:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7621B187FFF;
	Wed, 11 Sep 2024 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JKwbGfeQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD561184527
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726058733; cv=none; b=APtLzQZAN7SRhFIIBwEC2nh+IQ1K7Tv4f8wgmeMaWLrdV2HGOzxPbrH6ERAMGxW4v2nPKE7m8RdlZM5kX2NRolOhVOReaR3vMaflW95roDoLv9DTNm3kwbPblqgygeqDwujZpwCxG1kVekWIkQMwTmEChPkYzv2aDuLiMYU3xJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726058733; c=relaxed/simple;
	bh=oanEVp1QpQx+QKjiDE9/pLK2Zy4yaqtNS5716Fz11Tw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d7dS/qANjlPxBUe34Er3TR/XJ2U4G7lk6QPJMPaU2rYzsoVFnNF2W7oBwH8ZMly5raEyGgdjkH5g4fiyITtjGYEGt8GQnVEN0A60MmmG2jvlC/pbXLOSulayTnkuIogBy35fPVI7ldLFCYSJH1YtkeOZd0vZheVA6lsmVcGXz84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JKwbGfeQ; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BCCF8c009245;
	Wed, 11 Sep 2024 05:45:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=MLc
	OzsaG94RgrsfhrkfSzhTdd3czfmSS9sf8Zy9noBI=; b=JKwbGfeQuI7BwDGye+K
	yUj/0t0huFP89mMTKDCkAhvCZpCrD/XBlcKCUoMpFk3eWAGwJwdO/JzS2FtXKpdn
	BzxZEUFxwJ35sxKUV3231RN1jLh04xS0I/9Gpv7qL/BD4nlX89r5KWdwtktj2QJg
	3OjjJyzd2cLdVXJqZSsfiEoMwo7PScBEyc1wuCQoXGxueOZsXjY5m76uFxMMtLMJ
	QX9nwmmfHD/KxA9IeymkubrA4EcO9fAOMk2W7CZJ6x+VMEDUB9durQkSitsKH0dA
	56BaELAk+IHOOv/sc+espQ49n+b4RrNYloO5OIe9qnopUYLEs4dXkH6aUtJaZgh/
	soA==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41jh2eh7vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 11 Sep 2024 05:45:23 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server id
 15.2.1544.11; Wed, 11 Sep 2024 12:45:21 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Duyck
	<alexanderduyck@fb.com>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 0/5] eth: fbnic: add timestamping support
Date: Wed, 11 Sep 2024 05:45:08 -0700
Message-ID: <20240911124513.2691688-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: TzldE7p1fe4PgKTiY24-KYlDSJV33jh4
X-Proofpoint-ORIG-GUID: TzldE7p1fe4PgKTiY24-KYlDSJV33jh4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01

The series is to add timestamping support for Meta's NIC driver.

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
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  91 +++++-
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  18 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   9 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |  31 ++
 drivers/net/ethernet/meta/fbnic/fbnic_time.c  | 309 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 165 +++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |   3 +
 11 files changed, 725 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_time.c

-- 
2.43.5


