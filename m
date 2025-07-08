Return-Path: <netdev+bounces-204870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C91ADAFC54E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DEEA18951F1
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414842BCF46;
	Tue,  8 Jul 2025 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="dlxqq/fX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2139.outbound.protection.outlook.com [40.107.100.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5479C298261
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962882; cv=fail; b=GJfxjiM1ffEI1ulqKhAu3CiqJDL+kcltX2Uks6wbDfs7edLjFjPQJA0Wj0zFfIg4OK+1zA+XCMNf9vIYxtQqUqlpnze5gn2ZwHxJcYFddjpvigDq9J4SlWR9oAT4cL6cOmi7dFGkpIT7Dv9a3TPgTmZdnKpglP30PSve+P7LBaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962882; c=relaxed/simple;
	bh=xOcbMWNx1xn0dzrtVa7L6hc0s2cgBMD/qRshrSDwtv4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qSqgUMaIOoIaLegjcllmry1suhBf3h1fqS9ohE6/WOkGf1ruGgwSm8hVezcBirferuHVyOYgysfKxH0fGU4E389W+sC1LPdvVrfYBYHUVvIHv6fOXHMX4n9fJjTR1hVL7oORllMJCekuTU8SXQxUbIcLYtPSfh5UHDXh/QLAF1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=dlxqq/fX; arc=fail smtp.client-ip=40.107.100.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4ZASbzhH6fSFCmeWCDN5fwlYn2nlAniyuymyx45dGvf2ktJkXDqJMOMlXAEu3XMqIKn9T055c6ctCayuMNjqKsazBN+wLv0TnX/mJVhIQIvfhYMqzc66qesZiRhrQ9/88Yv18u/zqNN0JUs2baYAj1Zv13CGlIKv1q8LNMItLtRGwDmFXwORvEwtF8twy+AH8Kmr+DpjDA3rzNaufP6iO/rR/frRh2dYqstSLM5rWcUPhIaBLc1TaoV4yUG2b89YzkPThalwdvDWVTCVREibrLqFYklBmBgFdJcMzFUHRJrD8XtzziYg0kkV1/6JK63oEKRwaxCvFJTAVcqeJM9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vT4BRYunDANVs+G2HTewEPCB7RfdkWp9uarcp7AeUDM=;
 b=xhm1HFyr6sM8QVD0zmK9VRpoYH03Eel4ZxT6q9UKXz6+uMzwZDJolaL8TvtzSwRbYGBVFlnMqignUs2lS3Atzg0FZYq0bCnmTWrA9NmhF3KXRgz2CVLnoXqOkL++kATC1kdeFpOfkq8NxGgWIV4Ni1LEN7BPu/6uvQnmZx0KIq493O/C9+7oI4BLoQAGD27XCPUPTz1C6vBzWkfit1ERbBbwbzE05YxgYktwiRD95Bxrb1K6u5iY2lqRnFA6ql6505QULYTHXSF6y5n1Ek2dud9Dro78OKPUEBFdMB77vi8j1w07joF1XvbgwFzwetHrAimjmXsdc1wuOES/JZ2LuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT4BRYunDANVs+G2HTewEPCB7RfdkWp9uarcp7AeUDM=;
 b=dlxqq/fXE1TAGjE1JrPeFYMgU6b0LyxDHzbnlIYkoU6r+C5Q/vzrzUN1gScHJ+OFqRAODcebGG9cLcUtmXD3OmkEE6BHz6N6Wc+fSy+uSN3F8QzdbZQI4LmEkgcY08UAOpENUjonUMS8Vo+DYXxXaHyX/qtfEJlwAR5NFvATWMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from CH2PR13MB4409.namprd13.prod.outlook.com (2603:10b6:610:63::23)
 by CH3PR13MB7047.namprd13.prod.outlook.com (2603:10b6:610:20c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 08:21:16 +0000
Received: from CH2PR13MB4409.namprd13.prod.outlook.com
 ([fe80::1e5c:6101:5e22:e8b9]) by CH2PR13MB4409.namprd13.prod.outlook.com
 ([fe80::1e5c:6101:5e22:e8b9%4]) with mapi id 15.20.8857.026; Tue, 8 Jul 2025
 08:21:16 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [net-next v2] MAINTAINERS: remove myself as netronome maintainer
Date: Tue,  8 Jul 2025 10:20:51 +0200
Message-ID: <20250708082051.40535-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN3P275CA0148.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:ce::14)
 To CH2PR13MB4409.namprd13.prod.outlook.com (2603:10b6:610:63::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR13MB4409:EE_|CH3PR13MB7047:EE_
X-MS-Office365-Filtering-Correlation-Id: 02c93280-009b-4143-ddcb-08ddbdf86852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qIQQYhJVCVvQGlrZ8uPpxPeWvbTIoFa9Zn7FWWj8IsRApoBhIJZEZxNFkBjC?=
 =?us-ascii?Q?4ZQcO0GtpO6Y4ZH9wJ3BJiL6MYjPEUg0dl/53TMSH2/7yCTlA8/IEsHy2U/d?=
 =?us-ascii?Q?pUtScmPPMRJCMwdechrqMLG01uBjjGJYEMe76751xH5yNHxGsuqfP0xvUtw6?=
 =?us-ascii?Q?sCzEQ3fnRQcLiK38jrKcX7CbHw5BhR+MtG8YXBZhg5Aze9hre30RIF2lgszy?=
 =?us-ascii?Q?E7cKMheOgJpmxw+p7SqdxUPbxl/wWsSNt0iJ/yl3rDO5l/s8wNTIOFqudW/D?=
 =?us-ascii?Q?xrIcGCp/MAAefPpLkYgCN/XZ2D8EIdvoWi+G3kWyPrER3F98GEJgHd2TZ4xw?=
 =?us-ascii?Q?5J572GLWxZuk1sOisnuu4aQOw7Lm5pjYbltNszDEs2mRVMOmtqThDsrLGQKG?=
 =?us-ascii?Q?xxqzI9/Y4uNeBs551MLIzvDR2rG1pkvqP+GiuFVud3J9s3q+sHDpmKM76LHq?=
 =?us-ascii?Q?h8w9ez+30qkeyTKj5uDGKZk4rgtws9Yqvxvv3gvBU259C91aKRxgGOS0Yoiu?=
 =?us-ascii?Q?tXZ4XY0LWYDbzp3u3gaWRNyXzq68UY0jOCTjereoequ5DKoZq5owqSEZBlgN?=
 =?us-ascii?Q?4YBfM331d+ugjEudlUNnLJZJIgb/tG4cfN9hsTq3iFkY+ru550DkRlXdleT3?=
 =?us-ascii?Q?6ZsSY+sLH7ldVnYtvYrfMM+qkmvbWsS7T31K1+ngo/NFcXo1ZXrAq3tXmh71?=
 =?us-ascii?Q?4ns6JEAV6sXM0En/d9sAxnhRtcGFiqpB11r3/mEfjCla7UL7bJ+1jY+qZtpY?=
 =?us-ascii?Q?NlY/XTvQMhVIQr1CP0fhF4/RvyaOIooyr+zcFSdHMc3txASYHyV61xsojziA?=
 =?us-ascii?Q?WyGad2sEgse1OKFk4NV5fqFVqXtjBLphZ3eubjqMNbZpiqK+f4AL706OGt+j?=
 =?us-ascii?Q?ooziND9PFAFK5qNp2URJQAMBlbvfdozHXJnKnjMAqdop9IHjmVzfcqfWmA+t?=
 =?us-ascii?Q?GN0U0Cqtp9EvFGoHjy8Svb5aGSOJa+whVzuI4SrT2sqoMAVbB2o33pi63iFb?=
 =?us-ascii?Q?cfvm7H83StwCi5GAdvwJzcK6yIZr/2zguqPkrDPzmU8197WJvlc9LE4AtveN?=
 =?us-ascii?Q?88Qlak0V6LzSJOzORRRTqv8+hat+48MC+83npdpMua9bcwQ9OIw6IlpmGc07?=
 =?us-ascii?Q?V7bXXlBlInkcofcOGb5x2175L11KCumiLsgir1mJXjRxBSofd8v58Rwhd6R2?=
 =?us-ascii?Q?lgfUOJMp8XYWmvrIiscN7hRXpZZarT+YGtQ24N7cMt7sin931yJ57rs1/VI7?=
 =?us-ascii?Q?f4mCA2qLVc6FcsvzOI1sEFhim4owAprbzMfGKGvABT1z9EMwxWkIBibADxao?=
 =?us-ascii?Q?s6ty0gA0e664vtGezfa4PSC1VPXxsOUHMIIeumS9r4s46ET4NXaDCYuCI8V1?=
 =?us-ascii?Q?TIoTQy0ruTfIEe6adVi6kGtoUib4rVy0Xc5Q1gf65CYhx8LJlGq2Eo82JjEa?=
 =?us-ascii?Q?tPKyl17GrTI96c44XlBfRtro+9c4qBRv4Igz/MC+ABVbXIeFrgueFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB4409.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c67BJPxgecNLjvmq6vsj4BtEaSf4lf7I2GeyqlhOAKykqnRgcjKfrvFWBZhg?=
 =?us-ascii?Q?84UdY9Vxsf9pXG7qexwRz4HneWEsl4Tub7CpRyOvYjYVMmUya656KIsmIuuM?=
 =?us-ascii?Q?j59BkiNsXci9X0/FKMBe7/ecYboiNO2opip37rhg1C2vm6QwfRkr1YLXZYAM?=
 =?us-ascii?Q?Xma/0p/whqpMrmrPqtt7dmFWD/146xdze099MKBts8sB53DU5VcTDFUNg/qS?=
 =?us-ascii?Q?7vulpHhOgeCvWX0iKAGRncWxuwVpqZ3vYffFI9pPLW1dRVVT6MPR3emys2sr?=
 =?us-ascii?Q?ganL5RLXvLmxhkr4B1VZDgz10DdjW/Eoe6ob+NfYPPGyWG9Ue/xY5/8Uyf8G?=
 =?us-ascii?Q?JxNA1l8OOoJ21DI7280z9YKYJ6Vnu4HV3NJhJnsuVdiUEbQd9aZJ5WHY/lnG?=
 =?us-ascii?Q?kQ3V7L5mDfHdcUHcFN42f9ddiNz6ohbyydjZH8DCZhxCV2H4sFr0HyCsz7Z/?=
 =?us-ascii?Q?QU6nyGOhdrIOYlpG+VEInObsg3sjpfkwGWMgb3zIO1DEhvZXfBxCUlY1Ira5?=
 =?us-ascii?Q?8u6UPOtO+3/8cGYRP1CXeUgVg5UmrSGFBQZEHpCZBhxpx37hsJ3UNoOArk1T?=
 =?us-ascii?Q?iaZ3OJVbxmukOQDgMmtvkOwJOhlP9ImKQI+F8/Als9HkBqxsemmsoIiwzA1F?=
 =?us-ascii?Q?jebquXjXbr8FQZAxqjmS7vSGshKvhWld6iBcdgD+wfW4A8KTQdCMIUdrJ9i0?=
 =?us-ascii?Q?3P3nQfjvQT2eVty8rjaG640khazsdk6Xysgqp6VxyXs54i+ARfKiesaR0OMK?=
 =?us-ascii?Q?JUcN8lGIYlEHcb3LnxxUcn+ThyPqgqqKXGk2MZNw4g0p1F4LWJmsXwoCPfxh?=
 =?us-ascii?Q?aR1QnaA06owgeaP89IpIL7CU2tEHgXtgnGWG+LoF6jol1fXrRrpvQx1HeA1h?=
 =?us-ascii?Q?Qy0bS6qSgJJ5pZm0KiMun8or6jYRv+Sv7jbArDjd8N6AtNRd4ZCEje2PoHa0?=
 =?us-ascii?Q?O8TrdYOtE5WKh/TmqXEdFmOtYvA5g3YjVorrv9Q/CJN2vJARHspaqwGivCq/?=
 =?us-ascii?Q?32mWrj4UhpHO6VtCc/aisVgvpUhsYWadpsLOYiEEiEJKJJ9wjkmybx1sa59k?=
 =?us-ascii?Q?Bi/MCaX7ruq5/CsC8ex7zm/9I8R+f3k8n0WnV53h9Zxy4DmUJvvH1mcL1Qko?=
 =?us-ascii?Q?+ZoLs5n2JRD6ECcFoTllsEG4LLGybe9Idc0b+Yg5+YV2uF+m0kM5AcDNiKkW?=
 =?us-ascii?Q?KIwpP4Ei6mbDd3Yej5gmn8COO5TAlqm2VTeaADlli9LlygZuFiPsui+n/bhM?=
 =?us-ascii?Q?FDfmepYQBOPtmuSmAmg95ykegcWY4LxmAk2PRjUA71ZJKn8y5+QmsAbRMbg8?=
 =?us-ascii?Q?8BmEFVQywz+4KR9k9AOB6hb0MzJp+Mediv1xD5RD0U3jq07d44lwpVuNlDl8?=
 =?us-ascii?Q?dX2U8luDa8T5j+iJAbPtcqrsChbbByv2cxreodts0bw9XtPPcFRUmlTHl9aK?=
 =?us-ascii?Q?sYHXfsTnWgXJjoZXqhC/F9D5lqJ7W04KasHVQl41atwnvRorZyKsHZoT+Tux?=
 =?us-ascii?Q?vZCkoFBe6lKN65bUX4v9Zqzp42XKHeShHSsDYn1YqMeGNnFaQzynkrK1OmQ6?=
 =?us-ascii?Q?ctgK0+i2PdqFdx9edq9AHGaFLwAavplqs7EMRPE+iMDxnBfAbaBB7c4PFLAR?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c93280-009b-4143-ddcb-08ddbdf86852
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB4409.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 08:21:16.0224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lYkMq0az1atcGNnNEp1Bryz6819p3ZbC1Omxt8NulnJoalOh/M/x+D3xvNCVGDEaSXO6+c29fJemdyLKao9MlAqhgtghyx1NDsyNFDvA2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR13MB7047

I am moving on from Corigine to different things, for the moment
slightly removed from kernel development. Right now there is nobody I
can in good conscience recommend to take over the maintainer role, but
there are still people available for review, so put the driver state to
'Odd Fixes'.

Additionally add Simon Horman as reviewer - thanks Simon.

Signed-off-by: Louis Peens <louis.peens@corigine.com>
---
v2: Changed state from 'Oprhaned' to 'Odd fixes' after a quick offlist
    discussion with Jakub and Simon. Also added Simon as reviewer based on this
    discusson.
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1554f33d0ac..a137e31ccb13 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17233,10 +17233,10 @@ F:	drivers/rtc/rtc-ntxec.c
 F:	include/linux/mfd/ntxec.h
 
 NETRONOME ETHERNET DRIVERS
-M:	Louis Peens <louis.peens@corigine.com>
 R:	Jakub Kicinski <kuba@kernel.org>
+R:	Simon Horman <horms@kernel.org>
 L:	oss-drivers@corigine.com
-S:	Maintained
+S:	Odd Fixes
 F:	drivers/net/ethernet/netronome/
 
 NETWORK BLOCK DEVICE (NBD)
-- 
2.43.0


