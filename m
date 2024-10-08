Return-Path: <netdev+bounces-133245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423A699563F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2B41C25011
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A149E212D04;
	Tue,  8 Oct 2024 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ShAtrN8r"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0698421265F
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411304; cv=none; b=rWRWJSU9Eh8qPkLbNuxOz77IMvwvqU5onIhi5K9bgccXDf26fm8niC+SVxPshR9wrT3I1BSRwiYV5n0QiVYybnq+XPvlH59Lyup8Nr+dkQzfxcLuaNBN10F/Sci05GzAdUHaYynkQ345kdhNA2UdGf1T49j8NoTF7cst3ZRI6S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411304; c=relaxed/simple;
	bh=bO+vq25OOBvKnZpA1Wr8rYZOOzRIICKjqFLNNKL9hzQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SU63VJDmucyNV0oww3T3Ki71srX31tLq6k+WgLUEjYK3mi/hlu/caOZAKgajtS+n4nlcskmfZ5sl9zdpM5P5eh5QRPaMFaDVVQYj7z9ThvmzyIliEDHzQ6tZ9cg7cNkhRB/QU6EvbVgQ0z362jYBpucRpwQ016hAb0peQ0RB+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ShAtrN8r; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498GcGKD023195;
	Tue, 8 Oct 2024 11:14:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=i6O+0d+TNEX+OQoNYS
	NSYfNkm5kWK5R6AcdObz8mDCw=; b=ShAtrN8r2Hhkpw36h5IF4y8LikDxeNtoMR
	0+FNr2lfqLLItEU3oTOqWQNAtFzpzJtlGWeiSLSj9MAUi089hPQcgQxmGNnO+WYO
	cFsGV5ejyxRaYXZQNYKu6XmPLhS69D+GR+a9Pu6rGCs6kvodjGXGhrTFIKrAyO5E
	/6UkABTBLcZgbF3atbQ9OnB5gOiKzpd8zAnaEY1nUVH03+qKMK4WYRHFJPfkUT9t
	y7mcIrE6JsQvpqMhwSV3Yd+rFtKuNdplr9a9O4cRI8auBI974U57u34bKWiKcZrn
	qfHKa4mJutwPiCjQZGDF3xyk1l/kLPsmrPMlbYtafhL0sj9AIGyA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42339s2792-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 08 Oct 2024 11:14:46 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Tue, 8 Oct 2024 18:14:43 +0000
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
Subject: [PATCH net-next v4 0/5] eth: fbnic: add timestamping support
Date: Tue, 8 Oct 2024 11:14:31 -0700
Message-ID: <20241008181436.4120604-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: E-dJ97WRNfxidKG5YGKHdgkClMIYd9ID
X-Proofpoint-ORIG-GUID: E-dJ97WRNfxidKG5YGKHdgkClMIYd9ID
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

The series is to add timestamping support for Meta's NIC driver.

Changelog:
v3 -> v4:
- use adjust_by_scaled_ppm() instead of open coding it
- adjust cached value of high bits of timestamp to be sure it
  is older then incoming timestamps
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
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  54 ++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  91 +++++-
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  18 ++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   9 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |  31 ++
 drivers/net/ethernet/meta/fbnic/fbnic_time.c  | 303 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 168 +++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |   3 +
 11 files changed, 722 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_time.c

-- 
2.43.5

