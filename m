Return-Path: <netdev+bounces-101601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E2F8FF8B0
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 02:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6645D1F24DA8
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 00:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CDB6FC6;
	Fri,  7 Jun 2024 00:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZoNc7Mnx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pvmQqESg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D5CD27A
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 00:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717720606; cv=fail; b=O3ck1YWJePPhN2E15DuUwqGbe+up2X/DKb3eVMJo8L03EjNGB9d/IHeeEI0LDnKj7aFjIHPWcNaSbN42Kn/F3nkJLJPZqTsV5D5L82eZRl7tOv4KVTLCYUTgziKkPjquS3DDZ62+QyNDKbgc9LL2wzN8mjsl14vtxs4T4OObym0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717720606; c=relaxed/simple;
	bh=dP4ggcYyDfUWT4S2Y8WtaPYCI3JFn7di5jOSP0eaEh0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iCB68yQ8Wd1/8nXCeiP7yH5t1NjDOyShl1hJGA0+EIxWm9054UvxG567BMAGKkG7Q1pCf4kYgI6mxDuAjKYBj7uAji2TjMdkrZFFU/DjVupWSrQWx8WI/WKCKaVXlttrUydfOMULh1VeAAbXZxL5/JLRSN0ACqtYIuc14dSZ7Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZoNc7Mnx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pvmQqESg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456Hwhnw005586
	for <netdev@vger.kernel.org>; Fri, 7 Jun 2024 00:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=+YflOiLD52L5e1t28GP1oaN+5ir8UCwMa2Mp+7F+yaY=;
 b=ZoNc7MnxMOMfeD08U1oC3FHjTcbHJCfz2yIu/Co+XeIFYqGHpeFKIOQgeB48Vku40iBN
 J9RQ3Pq7wTKkpkt7K94pPYzLBjFSLAPSdTThzPcodc1NLlaHVz5hSoWPWLTKkn7VIsqO
 0cOrwBpjroK+Ko8YqZ+plRE2/SqAuSA52k6alt/U+USehpZyjwfWluzm+5Ud/KJSDDy/
 dYuEpa1p3kOrmbSJy9jqu/EWyc+FoD3aQoCJW08sP2FVe8BSyQ5TRZBSPYGi7xb4oTy+
 fGIgt9BNXPIEu5r4eMy7MI2Hmok0PG1AicIWEi7SvGNJ2wgD8qjMxUb7VM957mRavwIU ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbusvm6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 00:36:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456NmnWX005555
	for <netdev@vger.kernel.org>; Fri, 7 Jun 2024 00:36:42 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmh7wgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 00:36:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W74+OUL329ehucOoglgp99E/nm1b8mq6aA4dBnwlsr7INX1NerhMByvVouUsccpXMECNRrP5Hsl3PKNzebeAbXfDtc1V7Lpz3qJKX45v92vhLTjWkBdDkJBupvaWe+L6N0OZ4uZSfZ8avk3A1AXisHY9bl0TFIAqr/4vRUxlGjYE7BrBWTRosPxZau3jYSDV7K0lArcOdoIYgkfrDHcPpM4teBspeELgcJLTB0zJEVvlOGdm0cDaPDOUK4vtQCTzroJ+94lgT9znEzgzJNhQ4OeYXOtpuhbtErw3Rkr03tig3Tksp7cglusiWyjVKXYxSSV47YYyiF0CxBBl4Zd+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YflOiLD52L5e1t28GP1oaN+5ir8UCwMa2Mp+7F+yaY=;
 b=jz+KyeCBJJJKeJFYp0fKYTNQZys2ExFNtSH4XQUVAGLDUkwurxkO28tPU92R8FA0heHcSKWBuh3z1nNNo4CWVVwKDI/PqjfQfdekgkLPZGAk6VOmfKVF7tbjJ7ErVO8O1gtI3n/HxFAojv4UbFLK0Z6wKP76bnnsS9bxyw2iG1W7IuTQkKUgoR6MbYjE1b/psRz5EB3O3OqafT4/NH+P1Yvk4gZgQ82ROAEm4/lk9TQ8o4pqDWy5qwXaSCUMxd6JyGePSvyIstUkBsGc82qYejLaaOaZ5a/ov6X6rySrGnQMfjWvkIVTPVrccD9JkBbvtFFznKZwzMW/KPVMO/yt1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YflOiLD52L5e1t28GP1oaN+5ir8UCwMa2Mp+7F+yaY=;
 b=pvmQqESgZyWYTr8Z1wCvhtG/Kql5sHIgl95KEMhOLXGYk+r4x6eoq3CWpw4VdgugPP8FvqVF5l0YQIso/pokiaFRMWSkpQwqcURyiGdD2VocutU1YEJwXDFECXapjO6wAoL4uIDOTQj4UPKWJB+wvxslpVGY5Cxzvn5qS/xcKhA=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by BN0PR10MB4950.namprd10.prod.outlook.com (2603:10b6:408:12a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 00:36:39 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 00:36:39 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Subject: [RFC net-next 3/3] selftests: rds: add testing infrastructure
Date: Thu,  6 Jun 2024 17:36:31 -0700
Message-Id: <20240607003631.32484-4-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607003631.32484-1-allison.henderson@oracle.com>
References: <20240607003631.32484-1-allison.henderson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0096.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::37) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|BN0PR10MB4950:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4cd15e-73fe-4cad-e69f-08dc8689e523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?aCtTJWINlnbxMalt06A3X2Job2zlpw8e28oNcK0/bZK3C6SvBgpm1OK8AzhL?=
 =?us-ascii?Q?+T6ZuWQlb9rDCzAZ3jISEy3RQ44cpiEB+syii09BEuFEbzqLG0Cj2y0NNytI?=
 =?us-ascii?Q?C18iGnkfqisPAK5+Qk63ySuRrhYzj3BC/r3oq97MchVdQPHZpzH7wUpxJARj?=
 =?us-ascii?Q?aDtGTRSnhPNGAASjUalCgjUGIRHrYX0eU/frTuSklgLDdD9ak4E5K/yCU1xJ?=
 =?us-ascii?Q?XBvxnUJs7cQY2OUp5mhMwWqfQuuyPZccsTju8tyHW7cJIChcZUhYhtmOuMnV?=
 =?us-ascii?Q?EhA6Dim799nkCE80DW6Qr2ub8C3MtSlQwKmnNDBf5AQN+uh9wNytPJf3AyqP?=
 =?us-ascii?Q?MF9gNM9APVAB3By6JxgF7wkCkaWNwG6v6DCq77Pz8H1bLKgq9pP4G0aVqJtb?=
 =?us-ascii?Q?2G5BFNXC55i6xyfBpfIOCn3fXCDKAB/V15zOU5hXAwsYKhmPmdF7Ec6JlPXI?=
 =?us-ascii?Q?YewvVQqfQCUD5WS3FlcDUJUdZgc5e/bjItBUms6EIuq+ir0m+XOb6rr1XMEu?=
 =?us-ascii?Q?pXpB9VglFdYU+xGUXO7+/TdyfA5ercmI955LU75zdav022FGJxWFdFWf5cxY?=
 =?us-ascii?Q?qREDnU06BKAZEpgsduMO1W79bbMKPqx7wEJgV5X+EhRfhyQidxliruX53FTm?=
 =?us-ascii?Q?vuEc4LONH0oXgg/reykhddxToIl1PQpo9jFQj+6FsBKD3gBUzwAMmy8j1Ods?=
 =?us-ascii?Q?Ps4dmAN4P0t24lYux3QbNil7AGsUdHh5wKdSBr/EySEf6WYoFIQ9fMaBmWOO?=
 =?us-ascii?Q?GiJlifj9lQvc+y4n9h9OWFE7sDvK8T10WjE6r/J/dWjgf4CcQiDlKZbjDa33?=
 =?us-ascii?Q?tmrO0lhmeXll+gggRniAh0JRtx2ILZDNvneN5k90WLSMVeLf0oWVnFL03qn2?=
 =?us-ascii?Q?mM9CFOuU5p+P+Jz9Lw3Rc6wsObdZzBAA9KRmfyLN5CE0CuuTqXpiqRAPDxvs?=
 =?us-ascii?Q?TyiyWODrIuEX4LCQXkoXYGxqUaQjYFdGaHUrTkNO7ougb0kAQezShEyVayZG?=
 =?us-ascii?Q?9S/RC4Gqg4qfH+vFfInCIXTkuoDWneu6cythvU/GOj9LQ+IPTa4pq4lFPpdw?=
 =?us-ascii?Q?ltnPffaSNvo/q1zeHw5wTv9wtI8d27o+1g/om3qzRDLTIZD9ZHg68n2J7mAa?=
 =?us-ascii?Q?+abawj8w0AuIAHxckS0RhLm/+vuyfVTXeNCAEkNkcbwdNsQVvLCJZTV3lZ1S?=
 =?us-ascii?Q?Z7O+RWQvNpu4FeuC8xJOx7VirY4mUz9+tr/9ihC+/NzzzluGAF+DCQByAN1q?=
 =?us-ascii?Q?WQALH/EHutMeNeMKbUBvolCTpsfwdWiRAAsOrR1L5KM8JyPj1O+4G0NS6RLw?=
 =?us-ascii?Q?LzUhgtK25wkT3tSXlacIMbmQ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vPWaSockWnejf/AdyOZMs8b5Q+XnsSXgWyw5rChW3ewh6SumMmjAts/S3ZrQ?=
 =?us-ascii?Q?ncXCd8WAHfGEOGLvrhw5SxnAa8i7pbEaU9ow9hHqTjrRrVTT1kHLkpGNPbDl?=
 =?us-ascii?Q?ce4frlISOquOBcmGFMY4JqMs2x6ljhiqlVZlWUk2oQmLINiDg/v0H5cjC784?=
 =?us-ascii?Q?yD0TR/Bq9jFEsrpsiXPiaAPUnn14UbsBtDOVxuElzcWsJkAgXtfhRqilabBg?=
 =?us-ascii?Q?FjuGHSlmufH4u5Mp8hv9RaYzlA+2JkWXpU16X5BZaug9GQXozmBtlj3vor/Z?=
 =?us-ascii?Q?m23QDR6DaUCfn9va+pjVQNg0tykrYWWP82LYsGKovIK1JWekzJ/Fgwu8n0wj?=
 =?us-ascii?Q?xoYO2maeAuGWmO1cIpWKjGqrjQJi1gPOM+no1eUkq1nE1opUbZTbMT4XrHux?=
 =?us-ascii?Q?Ar21SHlTRg88SqPkuDQDl/VD/p/ouOetRVPE0RKMFQrQ6jKP2Y9lTaFi8F6i?=
 =?us-ascii?Q?mgHyjX8PvHNxk1uqmv8oXw/TEf5V8Xj0q+ZavMSehyAeOSEmz8iPWeX4Q9cd?=
 =?us-ascii?Q?oGCYSY8cztrPW10koN2ATIXo/lrhFPR4oOh2fr2pbmYic0jVSrvrNCB1xLTh?=
 =?us-ascii?Q?8TJxnIgbGWngYEmARdfST6QlYz+k7Ef+XIQG7Qopmyvzne2CpbhsahW2FzPU?=
 =?us-ascii?Q?RMcpfqiAd46e6bGzk4yefkjmomWYa0U0uCR07xYgNyGZgG5r26EQo7oUccmc?=
 =?us-ascii?Q?2l9VILORkohd9aDSRMy0kjS1Ejmijn/8rRXxuK0nLVL+KWBZObI0n4c+U9Hj?=
 =?us-ascii?Q?584yy3bb1AoFrMwfOl1i5GBzi8QGQ6St22Xus28zongBskIaJGydjjjxavjQ?=
 =?us-ascii?Q?EgbFoL5vNB5QApB+sA/J1VmQxNeygZ5aJZV1tYuL1AKxcxLxDa+QIEZIZBAS?=
 =?us-ascii?Q?3Ug7QJE5t6CPJdJA32IfmY64AKFxr3ycfGsDbOGiWGwDSDjfzfndjmjtgW6k?=
 =?us-ascii?Q?Zy9BPx7aVSopP2PqmtDpjS/55rN9cRlgodnTgOBguctBDFCQGGrs6bcLr3pa?=
 =?us-ascii?Q?ed+8uuTd69OplpksF8LCsxD/+xxLi+Luvl+OYowQrrwk8lw2vwZWVZXVWxlk?=
 =?us-ascii?Q?CIVHUSd5bbqrhP5Acy/cn+9QhWTtdwhW/vy8uMCO0iPC+jUHGczaM7NR/vSK?=
 =?us-ascii?Q?IzVtbbA22tQQLT3B1HPTSWoHHuUrLCJmf50DqXJXv4BB3x2595MrkvjiZiIp?=
 =?us-ascii?Q?EjkpE6FA5Bgwcl6b4XGYA8M/EhsvEJfUkgB9bPa/PxO1I5k4IWOUlwXFCHNi?=
 =?us-ascii?Q?91J+axSpLF0GhzGKo48Ug98oWXwdVQRFYW/oCo2+kB+iVNJRXmQJzYE1yHBi?=
 =?us-ascii?Q?ks90hIn1RS9aefDLeJgJ00lH/vExQ6aTokZ2lFh6CD8GhUJ7pgsGvd93OsPD?=
 =?us-ascii?Q?FvsZSd8G4ZWoYFErMKvNj3oCN8pHaaI8l+2X1frebW/WLywG9YKuK2VeKfIQ?=
 =?us-ascii?Q?8RMe3EtZILVaoxxX33pIauwzW2bihlfJZRmUDrI6VHib+ejlDMTWyTV03VAt?=
 =?us-ascii?Q?KM64nZo6Lny9rHccdvkBaLpdFi7Ks8ahwrnvuhipx4eIgCQVCbveZguEYn9/?=
 =?us-ascii?Q?OhJbihsrsBIhJ/5hqYj/3lPGVRm6iZYChZ2gobREktpr6o1iZnHPPJA2Ok3P?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	gpMCMVia0v/ziJ+1z0kWBtQ/mJAB9AK3ZKTe2Wagnw4x3YZ0f/P95n7KHJrd8WQPnRs+WpriYvGlpG53I/l9rYrSO9nMwy158rAmzjl4srs8tH5vAWqdrKx5dup85FDt0I4MQ6USIIWfoJMzJ72IV8FnuZ3QBqPR2x6TZWL4WxZnoPdHHQDQRzm5TZRWwhoh1huAFcKbl2C82n/wZkUZ/UEJhddmybvvv8nRV3h3My3v2xCgyuPB6IUGITUhL5qHhxv04W6fUAzU9qz2G1L1KsO0wtLKrc+8P5LutosyeIXvYoiqKi5Xn3TTsdayW01CNPgewFbQYRWrWt8RJQwyk1zTuZxHDAbnLOeu+ZjZjf35oHt2nUKMEDmpf8R+CaNtdlyc7ghA5Leaii2z8QjAmU2WeR7oa5trlrzKXalYvdK8HQWiZ+VWEx7RtLs/Uv0JCVkYAvQ0W0RD1C6B3ORy+eRG72yXTCf8Z1xjdX0uxExhc5CJCJilaM6WYDIL06btmZdsiN204LC4bnFn50z7S/8h5/oXbnF1F86Wjoq5GeblUS22Kpf60oSKDCNGW0JNS8zW6r/OcY4XwFGtQwx/QBJrjh0CLOzvx0PNCAUZsTc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4cd15e-73fe-4cad-e69f-08dc8689e523
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 00:36:39.4086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUoz7zlDGSKtVpNUMsKIPR0TIEWOcnzqQMsuONchZcrALiNyei/RK7l6z+ltT06WFhH+bTToSj8h23FSY6ve+2ZeCAIBOjIqCGHDYAcFHWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_20,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070003
X-Proofpoint-ORIG-GUID: eX5nxNCRDXExF9Dvfw1Tdfu0LdGxndY1
X-Proofpoint-GUID: eX5nxNCRDXExF9Dvfw1Tdfu0LdGxndY1

From: Vegard Nossum <vegard.nossum@oracle.com>

This adds some basic self-testing infrastructure for RDS.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 MAINTAINERS                                |   1 +
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/net/rds/Makefile   |  13 ++
 tools/testing/selftests/net/rds/README.txt |  15 ++
 tools/testing/selftests/net/rds/config.sh  |  33 +++
 tools/testing/selftests/net/rds/init.sh    |  49 +++++
 tools/testing/selftests/net/rds/run.sh     | 168 ++++++++++++++
 tools/testing/selftests/net/rds/test.py    | 244 +++++++++++++++++++++
 8 files changed, 524 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7538152be2f1..009766b77b7e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18851,6 +18851,7 @@ S:	Supported
 W:	https://oss.oracle.com/projects/rds/
 F:	Documentation/networking/rds.rst
 F:	net/rds/
+F:	tools/testing/selftests/net/rds/
 
 RDT - RESOURCE ALLOCATION
 M:	Fenghua Yu <fenghua.yu@intel.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 9039f3709aff..5b01fe3277e2 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -66,6 +66,7 @@ TARGETS += net/mptcp
 TARGETS += net/openvswitch
 TARGETS += net/tcp_ao
 TARGETS += net/netfilter
+TARGETS += net/rds
 TARGETS += nsfs
 TARGETS += perf_events
 TARGETS += pidfd
diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/selftests/net/rds/Makefile
new file mode 100644
index 000000000000..52fe54006eba
--- /dev/null
+++ b/tools/testing/selftests/net/rds/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+
+all:
+	@echo mk_build_dir="$(shell pwd)" > include.sh
+
+TEST_PROGS := run.sh \
+	include.sh \
+	test.py \
+	init.sh
+
+EXTRA_CLEAN := /tmp/rds_logs
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/net/rds/README.txt b/tools/testing/selftests/net/rds/README.txt
new file mode 100644
index 000000000000..e46f980adb3e
--- /dev/null
+++ b/tools/testing/selftests/net/rds/README.txt
@@ -0,0 +1,15 @@
+RDS self-tests
+==============
+
+Usage:
+
+    # create a suitable .config
+    tools/testing/selftests/net/rds/config.sh
+
+    # build the kernel
+    make -j128
+
+    # launch the tests in a VM
+    tools/testing/selftests/net/rds/run.sh
+
+An HTML coverage report will be output in /tmp/rds_logs/coverage/.
diff --git a/tools/testing/selftests/net/rds/config.sh b/tools/testing/selftests/net/rds/config.sh
new file mode 100755
index 000000000000..c2c36756ba1f
--- /dev/null
+++ b/tools/testing/selftests/net/rds/config.sh
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0
+#! /bin/bash
+
+set -e
+set -u
+set -x
+
+unset KBUILD_OUTPUT
+
+# start with a default config
+make defconfig
+
+# no modules
+scripts/config --disable CONFIG_MODULES
+
+# enable RDS
+scripts/config --enable CONFIG_RDS
+scripts/config --enable CONFIG_RDS_TCP
+
+# instrument RDS and only RDS
+scripts/config --enable CONFIG_GCOV_KERNEL
+scripts/config --disable GCOV_PROFILE_ALL
+scripts/config --enable GCOV_PROFILE_RDS
+
+# need network namespaces to run tests with veth network interfaces
+scripts/config --enable CONFIG_NET_NS
+scripts/config --enable CONFIG_VETH
+
+# simulate packet loss
+scripts/config --enable CONFIG_NET_SCH_NETEM
+
+# generate real .config without asking any questions
+make olddefconfig
diff --git a/tools/testing/selftests/net/rds/init.sh b/tools/testing/selftests/net/rds/init.sh
new file mode 100755
index 000000000000..a29e3de81ed5
--- /dev/null
+++ b/tools/testing/selftests/net/rds/init.sh
@@ -0,0 +1,49 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+set -u
+
+LOG_DIR=/tmp
+PY_CMD="/usr/bin/python3"
+while getopts "d:p:" opt; do
+  case ${opt} in
+    d)
+      LOG_DIR=${OPTARG}
+      ;;
+    p)
+      PY_CMD=${OPTARG}
+      ;;
+    :)
+      echo "USAGE: init.sh [-d logdir] [-p python_cmd]"
+      exit 1
+      ;;
+    ?)
+      echo "Invalid option: -${OPTARG}."
+      exit 1
+      ;;
+  esac
+done
+
+LOG_FILE=$LOG_DIR/rds-strace.txt
+
+mount -t proc none /proc
+mount -t sysfs none /sys
+mount -t tmpfs none /var/run
+mount -t debugfs none /sys/kernel/debug
+
+echo running RDS tests...
+echo Traces will be logged to $LOG_FILE
+rm -f $LOG_FILE
+strace -T -tt -o "$LOG_FILE" $PY_CMD $(dirname "$0")/test.py -d "$LOG_DIR" || true
+
+echo saving coverage data...
+(set +x; cd /sys/kernel/debug/gcov; find * -name '*.gcda' | \
+while read f
+do
+	cat < /sys/kernel/debug/gcov/$f > /$f
+done)
+
+dmesg > $LOG_DIR/dmesg.out
+
+/usr/sbin/poweroff --no-wtmp --force
diff --git a/tools/testing/selftests/net/rds/run.sh b/tools/testing/selftests/net/rds/run.sh
new file mode 100755
index 000000000000..d77ded7c8e98
--- /dev/null
+++ b/tools/testing/selftests/net/rds/run.sh
@@ -0,0 +1,168 @@
+# SPDX-License-Identifier: GPL-2.0
+#! /bin/bash
+
+set -e
+set -u
+
+unset KBUILD_OUTPUT
+
+current_dir="$(realpath "$(dirname "$0")")"
+build_dir=$current_dir
+
+build_include="$current_dir/include.sh"
+if test -f "$build_include"; then
+	# this include will define "$mk_build_dir" as the location the test was
+	# built.  We will need this if the tests are installed in a location
+	# other than the kernel source
+
+	source $build_include
+	build_dir=$mk_build_dir
+fi
+
+# This test requires kernel source and the *.gcda data therein
+# Locate the top level of the kernel source, and the net/rds
+# subfolder with the appropriate *.gcno object files
+ksrc_dir="$(realpath $build_dir/../../../../../)"
+kconfig="$ksrc_dir/.config"
+obj_dir="$ksrc_dir/net/rds"
+
+GCOV_CMD=gcov
+
+# This script currently only works for x86_64
+ARCH="$(uname -m)"
+case "${ARCH}" in
+x86_64)
+	QEMU_BINARY=qemu-system-x86_64
+	;;
+*)
+	echo "selftests: [SKIP] Unsupported architecture"
+	exit 4
+	;;
+esac
+
+# Kselftest framework requirement - SKIP code is 4.
+check_conf_enabled() {
+	if ! grep -x "$1=y" $kconfig > /dev/null 2>&1; then
+		echo selftests: [SKIP] This test requires $1 enabled
+		echo Please run tools/testing/selftests/net/rds/config.sh and rebuild the kernel
+		exit 4
+	fi
+}
+check_conf_disabled() {
+	if grep -x "$1=y" $kconfig > /dev/null 2>&1; then
+		echo selftests: [SKIP] This test requires $1 disabled
+		echo Please run tools/testing/selftests/net/rds/config.sh and rebuild the kernel
+		exit 4
+	fi
+}
+check_conf() {
+	check_conf_enabled CONFIG_NET_SCH_NETEM
+	check_conf_enabled CONFIG_VETH
+	check_conf_enabled CONFIG_NET_NS
+	check_conf_enabled CONFIG_GCOV_PROFILE_RDS
+	check_conf_enabled CONFIG_GCOV_KERNEL
+	check_conf_enabled CONFIG_RDS_TCP
+	check_conf_enabled CONFIG_RDS
+	check_conf_disabled CONFIG_MODULES
+	check_conf_disabled CONFIG_GCOV_PROFILE_ALL
+}
+
+check_env()
+{
+	if ! test -d $obj_dir; then
+		echo "selftests: [SKIP] This test requires a kernel source tree"
+		exit 4
+	fi
+	if ! test -e $kconfig; then
+		echo "selftests: [SKIP] This test requires a configured kernel source tree"
+		exit 4
+	fi
+	if ! which strace > /dev/null 2>&1; then
+		echo "selftests: [SKIP] Could not run test without strace"
+		exit 4
+	fi
+	if ! which tcpdump > /dev/null 2>&1; then
+		echo "selftests: [SKIP] Could not run test without tcpdump"
+		exit 4
+	fi
+	if ! which $GCOV_CMD > /dev/null 2>&1; then
+		echo "selftests: [SKIP] Could not run with out gcov. "
+		exit 4
+	fi
+
+	# the gcov version much match the gcc version
+	GCC_VER=`gcc -dumpfullversion`
+	GCOV_VER=`$GCOV_CMD -v | grep gcov | awk '{print $3}'| awk 'BEGIN {FS="-"}{print $1}'`
+	if [ "$GCOV_VER" != "$GCC_VER" ]; then
+		#attempt to find a matching gcov version
+		GCOV_CMD=gcov-`gcc -dumpversion`
+
+		if ! which $GCOV_CMD > /dev/null 2>&1; then
+			echo "selftests: [SKIP] gcov version must match gcc version"
+			exit 4
+		fi
+
+		#recheck version number of found gcov executable
+		GCOV_VER=`$GCOV_CMD -v | grep gcov | awk '{print $3}'| \
+			  awk 'BEGIN {FS="-"}{print $1}'`
+		if [ "$GCOV_VER" != "$GCC_VER" ]; then
+			echo "selftests: [SKIP] gcov version must match gcc version"
+			exit 4
+		fi
+	fi
+
+	if ! which gcovr > /dev/null 2>&1; then
+		echo "selftests: [SKIP] Could not run test without gcovr"
+		exit 4
+	fi
+
+	if ! which $QEMU_BINARY > /dev/null 2>&1; then
+		echo "selftests: [SKIP] Could not run test without qemu"
+		exit 4
+	fi
+
+	if ! which python3 > /dev/null 2>&1; then
+		echo "selftests: [SKIP] Could not run test without python3"
+		exit 4
+	fi
+
+	python_major=`python3 -c "import sys; print(sys.version_info[0])"`
+	python_minor=`python3 -c "import sys; print(sys.version_info[1])"`
+	if [[ python_major -lt 3 || ( python_major -eq 3 && python_minor -lt 9 ) ]] ; then
+		echo "selftests: [SKIP] Could not run test without at least python3.9"
+		python3 -V
+		exit 4
+	fi
+}
+
+check_env
+check_conf
+
+#if we are running in a python environment, we need to capture that
+#python bin so we can use the same python environment in the vm
+PY_CMD=`which python3`
+
+LOG_DIR=/tmp/rds_logs
+mkdir -p  $LOG_DIR
+
+# start a VM using a 9P root filesystem that maps to the host's /
+# we pass ./init.sh from the same directory as we are in as the
+# guest's init, which will run the tests and copy the coverage
+# data back to the host filesystem.
+$QEMU_BINARY \
+	-enable-kvm \
+	-cpu host \
+	-smp 4 \
+	-kernel ${ksrc_dir}/arch/x86/boot/bzImage \
+	-append "rootfstype=9p root=/dev/root rootflags=trans=virtio,version=9p2000.L rw \
+		console=ttyS0 init=${current_dir}/init.sh -d ${LOG_DIR} -p ${PY_CMD}" \
+	-display none \
+	-serial stdio \
+	-fsdev local,id=fsdev0,path=/,security_model=none,multidevs=remap \
+	-device virtio-9p-pci,fsdev=fsdev0,mount_tag=/dev/root \
+	-no-reboot
+
+# generate a nice HTML coverage report
+echo running gcovr...
+gcovr -v -s --html-details --gcov-executable $GCOV_CMD --gcov-ignore-parse-errors \
+	-o $LOG_DIR/coverage/ "${ksrc_dir}/net/rds/"
diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
new file mode 100644
index 000000000000..8a06e871e368
--- /dev/null
+++ b/tools/testing/selftests/net/rds/test.py
@@ -0,0 +1,244 @@
+# SPDX-License-Identifier: GPL-2.0
+#! /usr/bin/env python3
+
+import argparse
+import ctypes
+import errno
+import hashlib
+import os
+import select
+import signal
+import socket
+import subprocess
+import sys
+import atexit
+from pwd import getpwuid
+from os import stat
+
+libc = ctypes.cdll.LoadLibrary('libc.so.6')
+setns = libc.setns
+
+net0 = 'net0'
+net1 = 'net1'
+
+veth0 = 'veth0'
+veth1 = 'veth1'
+
+# Convenience wrapper function for calling the subsystem ip command.
+def ip(*args):
+    subprocess.check_call(['/usr/sbin/ip'] + list(args))
+
+# Helper function for creating a socket inside a network namespace.
+# We need this because otherwise RDS will detect that the two TCP
+# sockets are on the same interface and use the loop transport instead
+# of the TCP transport.
+def netns_socket(netns, *args):
+    u0, u1 = socket.socketpair(socket.AF_UNIX, socket.SOCK_SEQPACKET)
+
+    child = os.fork()
+    if child == 0:
+        # change network namespace
+        with open(f'/var/run/netns/{netns}') as f:
+            try:
+                ret = setns(f.fileno(), 0)
+            except IOError as e:
+                print(e.errno)
+                print(e)
+
+        # create socket in target namespace
+        s = socket.socket(*args)
+
+        # send resulting socket to parent
+        socket.send_fds(u0, [], [s.fileno()])
+
+        sys.exit(0)
+
+    # receive socket from child
+    _, s, _, _ = socket.recv_fds(u1, 0, 1)
+    os.waitpid(child, 0)
+    u0.close()
+    u1.close()
+    return socket.fromfd(s[0], *args)
+
+#Parse out command line arguments.  We take an optional
+# timeout parameter and an optional log output folder
+parser = argparse.ArgumentParser(description="init script args",
+                                 formatter_class=argparse.ArgumentDefaultsHelpFormatter)
+parser.add_argument("-d", "--logdir", action="store", help="directory to store logs", default="/tmp")
+parser.add_argument('--timeout', type=int, default=0)
+args = parser.parse_args()
+logdir=args.logdir
+
+ip('netns', 'add', net0)
+ip('netns', 'add', net1)
+ip('link', 'add', 'type', 'veth')
+
+addrs = [
+    # we technically don't need different port numbers, but this will
+    # help identify traffic in the network analyzer
+    ('10.0.0.1', 10000),
+    ('10.0.0.2', 20000),
+]
+
+# move interfaces to separate namespaces so they can no longer be
+# bound directly; this prevents rds from switching over from the tcp
+# transport to the loop transport.
+ip('link', 'set', veth0, 'netns', net0, 'up')
+ip('link', 'set', veth1, 'netns', net1, 'up')
+
+# add addresses
+ip('-n', net0, 'addr', 'add', addrs[0][0] + '/32', 'dev', veth0)
+ip('-n', net1, 'addr', 'add', addrs[1][0] + '/32', 'dev', veth1)
+
+# add routes
+ip('-n', net0, 'route', 'add', addrs[1][0] + '/32', 'dev', veth0)
+ip('-n', net1, 'route', 'add', addrs[0][0] + '/32', 'dev', veth1)
+
+# sanity check that our two interfaces/addresses are correctly set up
+# and communicating by doing a single ping
+ip('netns', 'exec', net0, 'ping', '-c', '1', addrs[1][0])
+
+# Start a packet capture on each network
+for net in [net0, net1]:
+    tcpdump_pid = os.fork()
+    if tcpdump_pid == 0:
+        pcap = logdir+'/'+net+'.pcap'
+        subprocess.check_call(['touch', pcap])
+        user = getpwuid(stat(pcap).st_uid).pw_name
+        ip('netns', 'exec', net, '/usr/sbin/tcpdump', '-Z', user, '-i', 'any', '-w', pcap)
+        sys.exit(0)
+
+# simulate packet loss, duplication and corruption
+for net, iface in [(net0, veth0), (net1, veth1)]:
+    ip('netns', 'exec', net,
+        '/usr/sbin/tc', 'qdisc', 'add', 'dev', iface, 'root', 'netem',
+        'corrupt', '5%',
+        'loss', '5%',
+        'duplicate', '5%',
+    )
+
+# add a timeout
+if args.timeout > 0:
+    signal.alarm(args.timeout)
+
+sockets = [
+    netns_socket(net0, socket.AF_RDS, socket.SOCK_SEQPACKET),
+    netns_socket(net1, socket.AF_RDS, socket.SOCK_SEQPACKET),
+]
+
+for s, addr in zip(sockets, addrs):
+    s.bind(addr)
+    s.setblocking(0)
+
+fileno_to_socket = {
+    s.fileno(): s for s in sockets
+}
+
+addr_to_socket = {
+    addr: s for addr, s in zip(addrs, sockets)
+}
+
+socket_to_addr = {
+    s: addr for addr, s in zip(addrs, sockets)
+}
+
+send_hashes = {}
+recv_hashes = {}
+
+ep = select.epoll()
+
+for s in sockets:
+    ep.register(s, select.EPOLLRDNORM)
+
+n = 50000
+nr_send = 0
+nr_recv = 0
+
+while nr_send < n:
+    # Send as much as we can without blocking
+    print("sending...", nr_send, nr_recv)
+    while nr_send < n:
+        send_data = hashlib.sha256(f'packet {nr_send}'.encode('utf-8')).hexdigest().encode('utf-8')
+
+        # pseudo-random send/receive pattern
+        sender = sockets[nr_send % 2]
+        receiver = sockets[1 - (nr_send % 3) % 2]
+
+        try:
+            sender.sendto(send_data, socket_to_addr[receiver])
+            send_hashes.setdefault((sender.fileno(), receiver.fileno()), hashlib.sha256()).update(f'<{send_data}>'.encode('utf-8'))
+            nr_send = nr_send + 1
+        except BlockingIOError as e:
+            break
+        except OSError as e:
+            if e.errno in [errno.ENOBUFS, errno.ECONNRESET, errno.EPIPE]:
+                break
+            raise
+
+    # Receive as much as we can without blocking
+    print("receiving...", nr_send, nr_recv)
+    while nr_recv < nr_send:
+        for fileno, eventmask in ep.poll():
+            receiver = fileno_to_socket[fileno]
+
+            if eventmask & select.EPOLLRDNORM:
+                while True:
+                    try:
+                        recv_data, address = receiver.recvfrom(1024)
+                        sender = addr_to_socket[address]
+                        recv_hashes.setdefault((sender.fileno(), receiver.fileno()), hashlib.sha256()).update(f'<{recv_data}>'.encode('utf-8'))
+                        nr_recv = nr_recv + 1
+                    except BlockingIOError as e:
+                        break
+
+    # exercise net/rds/tcp.c:rds_tcp_sysctl_reset()
+    for net in [net0, net1]:
+        ip('netns', 'exec', net, '/usr/sbin/sysctl', 'net.rds.tcp.rds_tcp_rcvbuf=10000')
+        ip('netns', 'exec', net, '/usr/sbin/sysctl', 'net.rds.tcp.rds_tcp_sndbuf=10000')
+
+print("done", nr_send, nr_recv)
+
+# the Python socket module doesn't know these
+RDS_INFO_FIRST = 10000
+RDS_INFO_LAST = 10017
+
+nr_success = 0
+nr_error = 0
+
+for s in sockets:
+    for optname in range(RDS_INFO_FIRST, RDS_INFO_LAST + 1):
+        # Sigh, the Python socket module doesn't allow us to pass
+        # buffer lengths greater than 1024 for some reason. RDS
+        # wants multiple pages.
+        try:
+            s.getsockopt(socket.SOL_RDS, optname, 1024)
+            nr_success = nr_success + 1
+        except OSError as e:
+            nr_error = nr_error + 1
+            if e.errno == errno.ENOSPC:
+                # ignore
+                pass
+
+print(f"getsockopt(): {nr_success}/{nr_error}")
+
+print("Stopping network packet captures")
+subprocess.check_call(['killall', '-q', 'tcpdump'])
+
+# We're done sending and receiving stuff, now let's check if what
+# we received is what we sent.
+for (sender, receiver), send_hash in send_hashes.items():
+    recv_hash = recv_hashes.get((sender, receiver))
+
+    if recv_hash is None:
+        print("FAIL: No data received")
+        sys.exit(1)
+
+    if send_hash.hexdigest() != recv_hash.hexdigest():
+        print("FAIL: Send/recv mismatch")
+        print("hash expected:", send_hash.hexdigest())
+        print("hash received:", recv_hash.hexdigest())
+        sys.exit(1)
+
+    print(f"{sender}/{receiver}: ok")
+
+print("Success")
-- 
2.25.1


