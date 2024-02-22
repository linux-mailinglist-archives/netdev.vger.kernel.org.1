Return-Path: <netdev+bounces-73908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C2585F3C5
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 10:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97EBC1F21CA9
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 09:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C31137157;
	Thu, 22 Feb 2024 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jZ9GVmcx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="INChlDgD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FDA36AED
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592483; cv=fail; b=LJeiy8q53X4SwqHXXVwQMRX6JS+vwsxwptQ/HGc6PxM5PgsSRBUcp8qCnXeWTDn6JJF/RfpRkuYhcqGUjoTwED/Pm60OONdOGzlWGKVKiNsX/2tNyY/ALYT7RouIICX+aagiUsc6lX239efMTFXh4UvvQpX7Qqr4bMfKkOSMKVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592483; c=relaxed/simple;
	bh=gwwIimYR6oq4Fu9qPmzqPH5YAzzd/M8d6POa8iJALQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l0CWuOZ86+Y5znM/nNleZWmdnUzpJZMKErPUdWwhEAFgnVMywjXtJhs35NFURGfqlj12jyDf8WaJyHbkBFL6tg9vi0RUp3wpgiX1R9FlLTpfjoNP4mDhNilqXnaN4cqDi+McHCtoVseOxC4Kk8wmZUZUT2+UGOwHNWBDYU5k4D0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jZ9GVmcx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=INChlDgD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41M3Sw6L030976;
	Thu, 22 Feb 2024 09:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=nvUI013lmNNImY1nHax5KabLQp5rJZX9n5A3aLeszGQ=;
 b=jZ9GVmcxuKf9JpFBqXpDA4vx2bx0Km2iq/RaJBTVx/rGT6DlKTRl03CkyBMCWdID49ti
 1sK9n+cX1JYoOApluJtL+Pbdg6e4yE13DSSxdLv4qKz1KwL44PNSQ1e9/jCYpeeeSWVi
 YFE2ot0hoxy4UFRVjz9pbuQ1NWTsV2zQv0zpb/+eUBUao2R9dZPAV+F9vrL8YhAX9zt3
 Dzbx7EN4DXOVGPiiuKW8rr/RLwaP7G4qoZmv2+m/rz+ym3mDjYCSO/QfPiTWaZv7z31C
 O+l1lALz8oB1ssl/gBwp103HtbCAKqgcLFWKqrYFptimGedYCQOsIkBHdJT1mOEw6ax0 sA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wanbvkx9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 09:01:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41M8X2DO013155;
	Thu, 22 Feb 2024 09:01:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8a9n99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 09:01:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C89PgledfuZMf5pFXxf7mQM3t8YhE/D+t2hrWHN3PeA0QxyAS6ZnfoXI/fjgmATyIDx8l2iMIAXKpqCb8cFb6dZUD87zrA41InHisrc9m71qsBOjSDFmfH1OrHHPt9qx5eZL37Ol9kTS/KuYMKkOdKylAWfO4yvsWxDufccEi6FMXe2F9Vz+W+1/xsPzAXOMqt67neL6TYoQQRZIkxrtv9dv7bW9lrjMPjrBOBdPzQ0ej8yZJwNcd7U0xhq4oGNZ1+adbHWR1rDhKsRSarM+6pH43I/GyP7pC3l6JBHXW1w78jUAu3rv8BEfkzXhxKbRuFIvAMZlw8S3ZxKPqjNVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvUI013lmNNImY1nHax5KabLQp5rJZX9n5A3aLeszGQ=;
 b=W5uoolPnanucNfQeDPL/WvkUwa/HGBOU/chim+YRjc+ZWwPn2fU9LHCxAXhuqDVok6Qhkag9FA2i0B6nVN4f0kKZIm5FofdZI3pjLarfKU6nxzOgg3FyjLHKzJlaEd00FXhb8jPj555c/cbw9+1PqusNM+ssZzWcDHyC0nMv2z00wtFwzUMj6jJVSV6mQ5xns3sEKuD24dJfTB9Dtfvt9igu7S2eRochH4DCTb4xEsR4qJw0rX3ny8LV4C43QVlwLs8dxv7hPWaUngkYmZ4t9tm1wdE54xoIvksVEyOR9fRP1XHbBRPtaNsTdYG8xxds/BzWfv9/NBYs35Y4kpx7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvUI013lmNNImY1nHax5KabLQp5rJZX9n5A3aLeszGQ=;
 b=INChlDgDpbaqp+iF9SM630GMewH5KzDqw9wcygHiOtZQkOKo7807K7lS9xVEh0lkq1+aLYAqLLvnfANnziKqShCSzOWq5LFjFQ3X8M/Ad535qVGQpu5ib4khCTJlB4Qq03qzB3fjB0YAIeNj/06lvNp0sHeQUzf8B1TZQx+WPqk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7279.namprd10.prod.outlook.com (2603:10b6:8:e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 22 Feb
 2024 09:01:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 09:01:07 +0000
From: John Garry <john.g.garry@oracle.com>
To: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, gregkh@linuxfoundation.org
Cc: netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        masahiroy@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH net-next 2/3] net: team: Don't bother filling in ethtool driver version
Date: Thu, 22 Feb 2024 09:00:41 +0000
Message-Id: <20240222090042.12609-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240222090042.12609-1-john.g.garry@oracle.com>
References: <20240222090042.12609-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: 4602db83-b3fc-4a44-fa28-08dc3384ce3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mcgDyag0WHwjbrw13kqO8/RoVGlhNm5s5Gg+GK1IGeeeXMszm6wcTILfvglKILcwiFD39i7NNbcqxxH8hE+tPLsQa0v2PO4XbOAGu/pi1Lfhy4/I2pd29h8PjOrGnhOw4FJyV7BuV4asKxU7pztVd1u7UkJNKWJneFf0q5TEohslIkasFTicm9IIcXVY6+vq3sqX561QPwtuQ3PKES5kMdzO++lv6Bsg5izu/iuM3mpMNuePrP90FqZudIXzRnH2wP0R+SRu0aQr+b29v8k2nGt6F0xKZu0+jND7tKvpnPNP4Bx1xx6iYAVhGSF9vQHtdcP57agw3a5y/S2L1yFdpz8B9BZSnVQHcAJjDacPNhGhCtJQ63CZ4LMHud1lFru+GtN8Pjq+BEclyb0B6vXguiRvceJ77AeoqBo24/dGds8YWUca6krKfypkoA1fRGbvsAFMSSNnWT6Mez0ZH+mzZgdaIAN8RWmIMtM8bm9ctJ4xlPqhg9M+ZSwtYCisVSpWta9jzKGU1N9Bk5tTYPAkr/mrCi6ERJIKDUUNYzOZpUY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QcO+3HX+PWa/+ifrlGZDy14VRsk4jlNFtmj/9jix4XCPwTbg1SeUXceTLmje?=
 =?us-ascii?Q?BnUQWLNtxnkClxvKZ5PRns+VmM8J20LXRS8Mxb91lae6VMgaQwVIwlLW7fuf?=
 =?us-ascii?Q?NiCfRWKS3mz6gnU2WVzDURdx7Waor8tJlwPuV0GPX2GWZpRnfoaXDREMHAvL?=
 =?us-ascii?Q?7FiN6zJXIBLNHKvDrtnqj6klaIm2aktnPegLPOc2eRyWv83wGt2f84sR778p?=
 =?us-ascii?Q?ppJ2FtfjooHsIbeG0MFPQThTBsKV7Vk6Xz2+RC+HywYeYB8q+GNbYc3ZTWeN?=
 =?us-ascii?Q?rdMQkw7rsM9c+BLAQ3nHMk/Pl/d48OL6pIHRN8sPMD13jexUoyUYpKJzBHkP?=
 =?us-ascii?Q?5bEmyeY8JoITjDjD5M1rdl0VRI/w+k6JdxSA94/qrFvK9SPq4WLuZLipDYe7?=
 =?us-ascii?Q?i2jys/Nz5EFQEDQCoQ54nCQi+pemc8EQNb18sBuo/1krNEsWxB/FrBMPTCCo?=
 =?us-ascii?Q?8Qfo/1CazeNjPk0AjLpsUCxtgUo3rVY1VAVjmL4XvykB5/f8RRlYfNNUCO3A?=
 =?us-ascii?Q?2ss0jTwH7ZMhfio4yQzRCtSErxaBfP896X2972p/GwlTn0CiQLb5fYYa1etK?=
 =?us-ascii?Q?dO0fu/EKH38cCg1B0y7owMC2g2mJfAlKi3dHlABp6q4yZHF8oC9cXJ/1Bgxi?=
 =?us-ascii?Q?Fd6iH3FcTytgFbUebU30JcJCZuJDDGVtWorb5TYyjGeqpLddJFXsIJd1eFoW?=
 =?us-ascii?Q?0zgnUfmxiwr+LAaUOsYl6nDGFHKgPrBWV99r8scTd5wziGLMLxmWAU1fUajz?=
 =?us-ascii?Q?kMsALQH28asJe6JZUk6A5dOYQNIVtmrefnHI96TKqyRW3jd0mVU+t0K9+Yo+?=
 =?us-ascii?Q?p6zEyK0nn0U1kAS8sjy/4B/9Lz0Ce69DMhN0vGhPC7NqCvb19lvqFncgMCy+?=
 =?us-ascii?Q?1YDI/fQQWghwVt9WZFdETqCdlbszy00+piX9AMSXCq7AnmRfmo38hd36dY0i?=
 =?us-ascii?Q?g8SJqGDe16mraAuvmmcpEgCqOuJQPZXd9P++B+DxIoaM4mYLLtNPDXDErvci?=
 =?us-ascii?Q?WL/pz3iedUxbuuiB9AGcU1yvkZPE6t+h+5/0Z0nSOrNC27k/HNQg3hffyNWL?=
 =?us-ascii?Q?p9qh8EpTlpBn+8RgJtvs53TQQotAUB9SQb/4yVhmsXGE+9cj0rVeaUilorTa?=
 =?us-ascii?Q?xAz2bW42rAacg1fhqn1NgCmcsgocAddCcwguQVVeURTyFjprDeDY3T3NWLa1?=
 =?us-ascii?Q?loVywnNXbc76iZlS47klOP5nYWEPziUWrvABDGzfcD2ROmlfff+h1/eEJMsD?=
 =?us-ascii?Q?G3o4BAUoLVqvP/Q3e7lzO8Jrm9dRXUyBOBnvHgcdTAMl07XfjNcjRD0NxQwa?=
 =?us-ascii?Q?M6Diu4TlzRR6+jIhdfMK4FrL9pp3fYKixSpLCmbXj4FoTnCts8GZR0ImoznD?=
 =?us-ascii?Q?dhtsn/Kq3qmLsGBWn/unxQAiz4oTbi0VpOBRhmlfkqZJV+ysA2Iqkepy97Xl?=
 =?us-ascii?Q?j+KiyfS59iht5XKmKsfxFFfJwP9KnmtnJvKyUinh0hY5fPifGL0PHDrLY7pi?=
 =?us-ascii?Q?xS3btzusAAl8tUhZ0/snWaGNu5gTmYQT1EJn251rudwN4OY704EHdzaFMN/s?=
 =?us-ascii?Q?b0Jbp3aHtLwaOo5nq4bThfCidyjacBMP2qltvLnQtb43Qs8fe7e/OLL41Bin?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WC6p+l/cBCtEbTvoc0zPcdrTXV4j49jAfsd8Psw/55cgyj6mejbwFaPciiwfKECEO+Ws7KulEnjhCNoK3DqrkzEmnNzYGcNNiCbz0hPIa1xDp5GlO4oACVdFmbwwKIDHLgU5Lm9mZ5Z2GapMTpJNwqlRas6IPgvVG1O9ti3tbnSnSx+DxBS/d83HQ6PP9VFphwCZICUsFsTaPAHp23TE/sXIUyRFvCcbT+we/OYFD4Of3Sgg4V2GKVMGRsfQ0UIQjoBOn/V3uJ/kaOPruya+/1QaUy6m1goHW9hNxfO05pB6xx4bRlm8y2QIuFFiX1vLNs6/24DSms5zWuhIy+e7H3+Ssp+t8FPD99h5aPzy9y/TBE3FUwJvAj20tBhTIpHzSzZnCPTzyWFy87fLLspM/WgY/Mw2L8wxl8pVY7R+D76+l17bCH42doXSuUxMLMCH+jreZ6nmDRbudCvRQlLouwhy3wGWPU5gC8yqoIcVHidYJ777vpnP3VXYvAlBbm71pI+f1YP6TIN4f5ZJ1fxp4plHfgMMpbbzewcgNZQucJekngqvJvOCPwr57UYWnTCS9dfjn/R02PqlRPwJrhYQPcOdDfrnAiO/rb8EOCPPA2Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4602db83-b3fc-4a44-fa28-08dc3384ce3f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 09:01:06.9616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFhs3A34OwHj58rDuCE7vPUMo6vsm8XzjCwERjl0wyUWNx5O9VihSkVq06KAdE2gObBDVE0FRyU+1qKgS4GQzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_06,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220071
X-Proofpoint-GUID: n2zUx3K9bJC84ukeyKF6l1t1qkQcftcy
X-Proofpoint-ORIG-GUID: n2zUx3K9bJC84ukeyKF6l1t1qkQcftcy

The version is same as the default, so don't bother filling it in.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/net/team/team.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index f575f225d417..0a44bbdcfb7b 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -25,7 +25,6 @@
 #include <net/genetlink.h>
 #include <net/netlink.h>
 #include <net/sch_generic.h>
-#include <generated/utsrelease.h>
 #include <linux/if_team.h>
 
 #define DRV_NAME "team"
@@ -2074,7 +2073,6 @@ static void team_ethtool_get_drvinfo(struct net_device *dev,
 				     struct ethtool_drvinfo *drvinfo)
 {
 	strscpy(drvinfo->driver, DRV_NAME, sizeof(drvinfo->driver));
-	strscpy(drvinfo->version, UTS_RELEASE, sizeof(drvinfo->version));
 }
 
 static int team_ethtool_get_link_ksettings(struct net_device *dev,
-- 
2.31.1


