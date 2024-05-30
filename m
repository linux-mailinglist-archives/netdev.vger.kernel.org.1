Return-Path: <netdev+bounces-99283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C7F8D4470
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 06:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D3E1C20E8C
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 04:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9247142E77;
	Thu, 30 May 2024 04:08:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EE541C93
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 04:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717042126; cv=none; b=pa/kzAVpo/AErHWawr+OS3EB43MC4lSIrveU0Y9V2V4nHRPiQDRqZHoVGMk1PANHxQvruE6SifjBogApssnj2iNbXFrTg+bwS9mMjTzX1WCDaEDfuo0ZvXpU7BFaVNvegzMXuKs2BWvZij7ZMOU6U4542N6wW4O4HBKT/R7j05c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717042126; c=relaxed/simple;
	bh=mGHJkLqPTunZvtG0brlA2e03YrUEf9+p5xpd81ZPbk0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AJQEBR3f3caNs0MNV6GbYk+WwI1NIQfA2RPI/GErGUhstzRUi+aLBm+ejQTcDB7JzxzEUzOc3enp3OfEw9oNA6Xts280x44qj75KKQtmiPQXhe+7hsM+dBKVFHYBqS2PLJA3cnGy8qV1L79ABbAZ3V82zmwwFYtR1BC+Tg3X7fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U1MBLH028524;
	Wed, 29 May 2024 21:08:30 -0700
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Dmeta.com;_h=3Dc?=
 =?UTF-8?Q?c:content-transfer-encoding:content-type:date:from:message-id:m?=
 =?UTF-8?Q?ime-version:subject:to;_s=3Ds2048-2021-q4;_bh=3Dn57uN2azQyajk8t?=
 =?UTF-8?Q?HAR9gBFCXBYfYXkRIniVK5OyT5sk=3D;_b=3DmEhKjbzxbNyCGqqYpGIaR3GIr7?=
 =?UTF-8?Q?lwqjz8w77jvsTLF9QTVi1sEzQKDzKXtJ2zIwRf8ReY_35zxRyicioaUszCf/7kA?=
 =?UTF-8?Q?/QpqsMTT2U718gMDhLbSHEZkGXc9Ebpva2c++ZavbeyMvFnV_xMfyEgd/wpzadi?=
 =?UTF-8?Q?ICQGBBhEg4TF+qeR0lplN+JkNmwTig1V6BQlf+XkaIsiaUWKsx5mPz_Sjgy3nUK?=
 =?UTF-8?Q?DZFMk58Lt/jytkoqMQb1gj6oCG8CeAsUV8qhyipezOe4FQgY7yM53w94BU3d_wU?=
 =?UTF-8?Q?CYl0HNP6/PtyCLcup2szyZcN6/eVxAtE2fnH3BZ7/qtpGo2wTuw/itGpPe4c4vW?=
 =?UTF-8?Q?eSD_5w=3D=3D_?=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ydkfgtp70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 29 May 2024 21:08:29 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 30 May 2024 04:08:27 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        "Jiri
 Pirko" <jiri@resnulli.us>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>
CC: <netdev@vger.kernel.org>, Vadim Fedorenko <vadfed@meta.com>
Subject: [PATCH net] ethtool: init tsinfo stats if requested
Date: Wed, 29 May 2024 21:08:14 -0700
Message-ID: <20240530040814.1014446-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: q5VMYWMMAQUGrsQnqtLiYZzyCEde0O2w
X-Proofpoint-ORIG-GUID: q5VMYWMMAQUGrsQnqtLiYZzyCEde0O2w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_16,2024-05-28_01,2024-05-17_01

Statistic values should be set to ETHTOOL_STAT_NOT_SET even if the
device doesn't support statistics. Otherwise zeros will be returned as
if they are proper values:

host# ethtool -I -T lo
Time stamping parameters for lo:
Capabilities:
	software-transmit
	software-receive
	software-system-clock
PTP Hardware Clock: none
Hardware Transmit Timestamp Modes: none
Hardware Receive Filter Modes: none
Statistics:
  tx_pkts: 0
  tx_lost: 0
  tx_err: 0

Fixes: 0e9c127729be ("ethtool: add interface to read Tx hardware timestamping statistics")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
---
 net/ethtool/tsinfo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index be2755c8d8fd..57d496287e52 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -38,11 +38,11 @@ static int tsinfo_prepare_data(const struct ethnl_req_info *req_base,
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
-	if (req_base->flags & ETHTOOL_FLAG_STATS &&
-	    dev->ethtool_ops->get_ts_stats) {
+	if (req_base->flags & ETHTOOL_FLAG_STATS) {
 		ethtool_stats_init((u64 *)&data->stats,
 				   sizeof(data->stats) / sizeof(u64));
-		dev->ethtool_ops->get_ts_stats(dev, &data->stats);
+		if (dev->ethtool_ops->get_ts_stats)
+			dev->ethtool_ops->get_ts_stats(dev, &data->stats);
 	}
 	ret = __ethtool_get_ts_info(dev, &data->ts_info);
 	ethnl_ops_complete(dev);
-- 
2.43.0


