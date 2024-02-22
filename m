Return-Path: <netdev+bounces-73909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6401685F3C6
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 10:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDCF81F23B51
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 09:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB820376F9;
	Thu, 22 Feb 2024 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eWY82szi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uFkiYa7a"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A7236B1B
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592483; cv=fail; b=UbDS/Gop+4PCsCUP1voNwTwlG3zjYX3l6Jg4XyxeLePV8xEgrL8rfj2nyrDChzaxBtzncWmSNNvRTw6cNLonHjQroqQSoHUH9XAfaAMynLETkGS6HH1JvB+MX8qm7J/cHT/anmQmYBUtGLo+txIjYPOLpVBfvyL22NJBxpSO514=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592483; c=relaxed/simple;
	bh=MyKYnaPWAhdTH3xcPWeiqXWoG5NEg2zxFCDb9DUrmAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RJv99Cybon0LQzimL3cR0/iRL+ZBViNrKLptbpEkVRp+FwD0KKiY/lh3PzgpxC4syKUi5jDpKdB4DZbJFfIvefvnlsgqKSXMWeYWEZWBqJOZzs3hFehqjORdomzldoujZrUUe6Sc3RnD0nO/6zVcfkkTc164xc/RMNu2srnJ9Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eWY82szi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uFkiYa7a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41M3Sq9x018116;
	Thu, 22 Feb 2024 09:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Fo9VoYAwNjMnYhyjn1fnD8+kNLEml85w9vspJCw1wRY=;
 b=eWY82szi8IHOYg3wDjLwJ/r/6A/tARfygE1+Pg7+pZkeKCAAAvVdRjbQcvzKq1J6utqB
 2wQll9OZgHqhYq2G9V1ib9F0ga577/DCP+miDY3nkNeGIMMB3TIvGYsg+eF9/ZZHWgY0
 j69gkMYFEWt2otf/UA/A8hFHAOwklD2n5TsI4ar7M9hkckRFvvdy49I0siGXUvsvop/K
 w5IKpAi0cXXEo6SXuWfYMyeknX7ICiVhyXTo1HIs5pQHcuIMIX/DP1wkHEAWbXZI2dbR
 WlVSU23F0bsokPmKROOiwhAgPVghbhMmqpFatHjeSHShTZy2QeQTfX97gPzbdyHRoGcJ Ow== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqcc2u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 09:01:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41M71h63013034;
	Thu, 22 Feb 2024 09:01:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8a9n83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Feb 2024 09:01:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAIUnNRJ6uewzoHdyTGMkOKwSE43zi/dJgiinmoFvkHM86sxYV5CGeML6sIp/+WfT8mVBPtF8aKiBUwL/JE7F+LJn2qabX2GyNazza8YV3y2B6fTVaDv8TvOswmVdMwu7K+Xh/FhPObRdYPLFjGHZA972+qAeHD0zz5CZaq2aOevfIeqV3Hf4e67n6O1GpC8LR3rbB40DelQdG0kPMrIXaq2Ci9rXZJW/Ovp9kC82J/Pc38CWnjjiky4OOIJDZ+VpYu73dMxO/KpsywNDpOSWvK/UTYg8drGa1jKfrGJga7eE+K+2zCIs8260yGGe9xcbiCwj7H69G+wjcuPZrHiFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fo9VoYAwNjMnYhyjn1fnD8+kNLEml85w9vspJCw1wRY=;
 b=IpcI0guMyPc1tBAMn0ZXbDEjvl2UinPrYyA+aEB8yN5l+KJYib9cHVCvlOm3R4cr2u2UxLHT09IdCKx7WB4W9dzo8AQKHg8CBIX0HMXn3ODSoJ+PZw8EiGL0yjtAa61UkRdh6W9aDiE6pNsk3nEnYVJE6Qrc5fbEddVVfUWVUouy78+TAd2EDAkCGYI5oS4+Kwr+jnj9mqabmLWOyzf+54zIqufXbwyBn1fNw5lFl0Jy7znswQRsCBYiXHKgs532ye6LfkHQONviaK4L1bezmjJ9Z/8bWH/0FZ9Xd94qVD2tVe9dWKv/6Ye+8q9+swKC35zDSRFtFd6gHmHSo+qkwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fo9VoYAwNjMnYhyjn1fnD8+kNLEml85w9vspJCw1wRY=;
 b=uFkiYa7aGeiYVZtGlexXNpvoVxagWneC87AMTk30ayC/SBhoDLSx1J35W0aM0Q4PCuAVTlsdUg+g+hcMreRCCxQVawre8WKz9O2lh11KDq2fNyrIH6lQUMUilF6h7Ehvd0ChnMaoUIdVuT28fwNMpgXUPVRJRXy1r1gQ+i+7VFg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7279.namprd10.prod.outlook.com (2603:10b6:8:e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 22 Feb
 2024 09:01:05 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 09:01:05 +0000
From: John Garry <john.g.garry@oracle.com>
To: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, gregkh@linuxfoundation.org
Cc: netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        masahiroy@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH net-next 1/3] rocker: Don't bother filling in ethtool driver version
Date: Thu, 22 Feb 2024 09:00:40 +0000
Message-Id: <20240222090042.12609-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240222090042.12609-1-john.g.garry@oracle.com>
References: <20240222090042.12609-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: f40603c4-f0b1-44da-37a0-08dc3384cd28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pfLOBxojs/SVhjTWu2TSOOYLLnt6AAzltLjKPK5ou+mdkp0net2LX/oDUQpD3fl9EwjJfDrbjX2j4PqFPDsuC6BxStEhIujrR9RTx2aXB+1j1BuEY6u6LSPpfxQscOAsWBQWK6ufCf8ZSbSRwFUMeRoxvXQxoZUNzENX5d1uqYup+H6wCY0brAZAusSwqnEUZW9iUwS6mBVivEXMBeQ3OegOtggBSYFyYxRzkZSHIbdm1NVFUnhJr56xwzzFSMfPcp3yFA++p5JflU1f1miFjaZmcfz+vY9v6sGn5awRvrI4XeYUYc8OpAq5Wd1/5MMMYg01BYS6aXifcbVKQgG+PCqj3GGjvZtrTnElAhIw2BfNwUfvTnkSkrGX78OOwIjws6c+1G1TCAqZ/yVBIKThTxlJIHyJuv+Few6U93fpjJbl5scoO0St6JofuQ0TPai37DE8MyZ2JtCqRbG86KKE3kWJ9Q1xTrge5nGatj2hbBmw14P8ivZUz3dfEPqNGX4WRdNdbvHg3OUakfFWFWi1kIOYd2ZwmvSpBHBniRnF9Ys=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EBLgMQmG2j+itjIcAPBh6Z6Z2zV6GgTJmV01JaNVWRN6JIGu2u8lpJo/3z3G?=
 =?us-ascii?Q?23y3Wjx7SZ649+Xw3yZGd6bsr+vrBgsqYNMx0wOkvK4Ii/TOq9RlDOvH2JiQ?=
 =?us-ascii?Q?XvTTpc+jv/r358/7pkUhpiQZjn97smE3ujiCCLGbeMtkWVdwxzLI8RvXoFzT?=
 =?us-ascii?Q?geQiA2yH/+4hStyuGUo8heQByGqXEfzPk/FF883lk5qggnENXxICs1NOvpm6?=
 =?us-ascii?Q?bfXF/1HvgD9sP71TQKp8M3Znoo38kofhV6BDTkMquxuquGbvzLHOW9SsjnwF?=
 =?us-ascii?Q?mKMjGcFuMyDO0bwcWCI35l7pEa8D2hWKApkvUx8CY1x+O3Fu7+XFqB7Q6ypS?=
 =?us-ascii?Q?vIlv1xkQGKCV7iInhOY8yw09PSGCdl3Dv8qD7SMPZL/Yr1KTJwLiIlSFnSa7?=
 =?us-ascii?Q?9+DFbQ0ut7btmW3SF0+q2zLY8MGowZl59tlc7rJZIotkL8lA2dwLu/JlCXZP?=
 =?us-ascii?Q?+tp6y+8IAlBKVJ+QqZxJFN0QpSWMT9OhfzJFSr0aTSk09mLe4yBiSyAGjr5b?=
 =?us-ascii?Q?krSSE6SPFZxcmh4mlrxVmubjguOj5gyf102zM/8sQrAkAY3Ps6nEZTNJskGu?=
 =?us-ascii?Q?aNzDjd8CPBgC4eoID2Qf6yMsU6kwkTZakELFOEv/+FBDygaqRXnveVelrEkE?=
 =?us-ascii?Q?yHhuOroPpgoVnGaht8OuOe4jLDqzjowCrrsCQHiTkBi4oPRgHH9MPmkFDJUG?=
 =?us-ascii?Q?dQLFLk2UxcLnyjUFX1gm3pZxPvBYrJ3HnVgb3Jqiw3lbPLIgC76PeDpWktJ5?=
 =?us-ascii?Q?dG40BQG4fEako2Bn+unwvQmeC4onfcLoCFDN25kgZrPzh3mwFVm4jKk7bhF4?=
 =?us-ascii?Q?/sL0Y0WlyGq2jFLkDmS2+gg2dGubdaZEz5Xd7ohUwZDnK0rtifVli37svBtH?=
 =?us-ascii?Q?tTBXSaziBBYY632tZOvfiVYqdcjtkPmeOcREY6QyS4MHP09rcY8S6tfvcO85?=
 =?us-ascii?Q?wTusg4v1dN3ntiMhvhmzK6NGYAXRatpylqe+gvNtu+NjgaGvOT9rjKsu9aBg?=
 =?us-ascii?Q?3ldCU3/wKVxHd7Gluw7dZAm0CqmaVVFKkXVb+ucwszsqcFak4Ngcqy2CEWT+?=
 =?us-ascii?Q?iB22sOqjWSgs6jIL0ZIR5Bv8rU5OqwmLnJMudmwYXGvC7eQ+kALt9pWBIELy?=
 =?us-ascii?Q?zUwDV9rp0KpTxShcZwCB6fOAU2pe8V29qM3Vfcls8OcDbNp5JIO8VO3sV4/F?=
 =?us-ascii?Q?ufu+0E9ibsa0ni5Ot2UyZp6wOfgJRmTBftnWa5BxQdtvK6tnddBbXfhXOI6G?=
 =?us-ascii?Q?eOY11m2uvNWt17mxSpBv/sp38dnqq3Xj/eiNWZo9pj0+AldAIBPRWBKhQTWC?=
 =?us-ascii?Q?ozavrdw8UdBbBq/DizaWC1Z48czYpQE8j0iGcW8O6zuaSTIit6NFcUp/FzVb?=
 =?us-ascii?Q?RcTWAUrqfa1X9M9GAkDqjuttDlgs2H+3YGYJlysjj7DABkoN/UBwvh9O4c7D?=
 =?us-ascii?Q?StKRynZBfTlWvsx5k85RuxyFZJoC5n0Z+Oj+2H0pEnDdRpn8BSdH5yhiDR9c?=
 =?us-ascii?Q?xlNg6GkaRpKGaLrVU+DvVNtaFC2wOBHhnTVj5YT0Sht4Rupo+sCCJtO63BeP?=
 =?us-ascii?Q?lc33kjbXqRI4fVkz0iDr4gldmknE0KQY8yT/RfV+f3h5KNo5joTNzyzpcKek?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QFaDd9QQEahzvqZc6taSS3Q70LYnWeYcMk+fAeTlWIGOENpV2MPBlShT7Z9Et46xMKBdImKNBj7Hp5cmbjI+y+ugh06yheqDxG5T1ABUxfnBH3PbeP50NKLAElVDFEln4v8Fqofq14yCRH3wIRapzRmN/HUwloI0jJpLQlAlWDkWayxQ3MHgLd0Zx6Q/9RIoV7s4sjRpT7V5eMvRJ54ekL/6A/bxtpzXCyJEEx86gKQJ0csCfRBsMulpaCb4aJTPtgURu6vqc1YpWaE1UioFfo2ePtJ17gAe7ce7JIRx8yD87WMAhMGq2JEGjj6vq4tBV0KvDhcUWDy6Kvei4bY8RSXi5XFWC4H1O3t9fIiltKWiNO4fJnmUzbAQ99MdXZ/A7hU8ZO2d2GKpaA68bLPycUQ3icBBwqjIIvr5Mxo5u4ZU/V9j2i6OxCfAmifnUuCrcLcqQQ0CAz8DShRbhFNXcsxc6NtbMJHAW9Kr58Gtks8Meo3Yj0mTxDsu/CwJcS8Q1DByILPS332U1ZTnQObsBRSvk+DDFVbPA/UYWDJcYpltiZ8XbbRO9i+mAwY5A1S6wN6t3SvxTmcnDmogo5NS8ddrxTsufkmrVn7diI8SPJQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f40603c4-f0b1-44da-37a0-08dc3384cd28
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 09:01:05.1114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EVe3wXwEuSPZxlwmJqcRFx8R0diZ0Du7+tn9zWSsSm52969mHwhiVG3hWaotdiOvqwG+VWJ5+5EPlNEZCfc59w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_06,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220071
X-Proofpoint-GUID: 2peuY8OiVjPUibd8E9U8eW4a6G3VREwh
X-Proofpoint-ORIG-GUID: 2peuY8OiVjPUibd8E9U8eW4a6G3VREwh

The version is same as the default, so don't bother filling it in.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 9e59669a93dd..755db89db909 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -32,7 +32,6 @@
 #include <net/fib_rules.h>
 #include <net/fib_notifier.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
-#include <generated/utsrelease.h>
 
 #include "rocker_hw.h"
 #include "rocker.h"
@@ -2227,7 +2226,6 @@ static void rocker_port_get_drvinfo(struct net_device *dev,
 				    struct ethtool_drvinfo *drvinfo)
 {
 	strscpy(drvinfo->driver, rocker_driver_name, sizeof(drvinfo->driver));
-	strscpy(drvinfo->version, UTS_RELEASE, sizeof(drvinfo->version));
 }
 
 static struct rocker_port_stats {
-- 
2.31.1


