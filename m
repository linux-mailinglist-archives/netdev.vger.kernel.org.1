Return-Path: <netdev+bounces-181736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EB2A8652D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E328C7BF4
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7986B258CD8;
	Fri, 11 Apr 2025 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OAUV5bOA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WutzEGdg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F3E23E34D
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744394539; cv=fail; b=GQv1O1JwO3/1oX+oZf+pCtdDEqC8m7cjxNi6DNA7G75fgsp8P0ulkyBhhY4LTZTa7rx/duUVTdiso96mZGQuaodYVM+XhhXdSFDNkiDc9PRNDoYWXtNPHWvwpLZ9BfDYOCU/DUWI0m1POP59wQi0YPjIwFyRFqBAqGQdGANS6uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744394539; c=relaxed/simple;
	bh=yYjvhnVWAG8YLJoXrmT1p3LPq8gXJsnDxdcNVWaOzDc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K2okCcwXVYvXS6a5rtifgOmm2IYfxCRioE7ZqQJx6BkFZdKBsZX0sQDkv6r+ZLCfQdAqn+Zxo++83U8NZ/UKdiNO4X5Q6XJG+WUSdDuY2yxsvnKYO/sTNFMF1SalsseZfXRtOihopwF/PF3781ixPKTaeZpABn9UsHOrSa8g0pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OAUV5bOA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WutzEGdg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BHs8aS006994
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1JcEXP4AHhgfa4L9fLLki1fv6l1M5hIHy+5jUiL7+oI=; b=
	OAUV5bOAYofByiqBNhiWSckGcmkzYx8M/A0ASUfGU5ZwW6yUhBE6PCjWN3CfiICD
	C2O77TtrOatfgwAfEX+G6uqD7HoSobCMOhS6yXgjS0PXJ0pilxpUEWNHZF69ahQj
	63a8dVQ9VfH584PYAs9nu1gkfTN/mOlh5Nt8mfZuY8/BHwOzHVOfP5SJdp1Dgzhb
	Go/YvP8HudHKCnJ6COQNT1UkrEYe8pgWhrfT/kRDcvnRl2TjYwlysARHiuPYx89j
	/MD4vciqKg5O3fmYgzulBouf/cmro8+zUC3fG9DgXMiyEWdfjce/KL6EaI5WnprR
	OV451EmLj/MwK/jAjBri8Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45y7vd00dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53BH0CLC016775
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:14 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010006.outbound.protection.outlook.com [40.93.10.6])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttydyn9v-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 18:02:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmD6feUcsZasSWBXkdAZkjzDLJRfqZnzMLUYvvnLZhDGL2vmZJ8IS5X9BlnJQE27UUQ7ESqxysnb5CXUkcXqcGKRV6wYIETF0P+OECXaDZNExlHuVaL//ehz/9KLx3/jQztcjC+e52xL5NT3z6e2RKvjmVSqNr33gz98iDgeXlLbVvx1i1dIkmEXpK9HHhlc8AZippDhGGrYWYeAcZppqxw1G9UpsCu8jNgCqVcyhO/XFL2ifOSqRkr19nIsIdDgWdZOGB/M9ru7PvD2U7DzPboc/tWd9KfCtYS5To6u7M/n9iHz9kxZIkOpV8wwy4PfGordjFODYwINPnJl/XStew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JcEXP4AHhgfa4L9fLLki1fv6l1M5hIHy+5jUiL7+oI=;
 b=Xw+Yd4Vsk2vWHSngeQg/jrKYt/KuuNRq1DFwW3DNdmZbMEkqpQ08a5exrl5mFqGXIpga5uP6ZhjB3wvrttrS87059SE0g9vFIJgtLa9ul84EgMPYC14P5Je+8vPQwz50Mof/pcnZC8nBDzVB/U6eS/YWVEn1OT3XLOdENi1VPg2rmpdPrY2r1GkiiZhui6DbYTMftLm6czIy1NLeDKXx9g6pKUZDRga0ruHxHv7+pM38Z61bVi9oA9xB2M9MoWSrcGjpA5E0qAQMemrOvNMzo5getvIM2cMcOAF2veLYB5UAXDOhN2JHLDXBQLhMWEOCx3ANIPFZaWYev0RjSNUzHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JcEXP4AHhgfa4L9fLLki1fv6l1M5hIHy+5jUiL7+oI=;
 b=WutzEGdgEh43zGw46tLuFltHjrA6zRbWcyE2O2WZhqfvStOylNm9Cq+1qEYQ5wIzuwo7HXXM/ZFNzcn5C6KOnMzeRqQmhUjlwc1+LdTQe9uDPtMMEzFk0eJUQiEQnUade9G0HSUu8iJ5NUHhMu/4TjUsnsctkqFZ1B28eZTgP9E=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SA2PR10MB4636.namprd10.prod.outlook.com (2603:10b6:806:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Fri, 11 Apr
 2025 18:02:12 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%5]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 18:02:12 +0000
From: allison.henderson@oracle.com
To: netdev@vger.kernel.org
Subject: [PATCH v2 1/8] net/rds: Add per cp work queue
Date: Fri, 11 Apr 2025 11:02:00 -0700
Message-ID: <20250411180207.450312-2-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411180207.450312-1-allison.henderson@oracle.com>
References: <20250411180207.450312-1-allison.henderson@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:a03:331::20) To BY5PR10MB4306.namprd10.prod.outlook.com
 (2603:10b6:a03:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4306:EE_|SA2PR10MB4636:EE_
X-MS-Office365-Filtering-Correlation-Id: 8486c33a-4631-4067-f5b1-08dd7922fbbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6VoEMTViF6DUF6vXZwFsKgONUaU3Grup15mEQoU6bDc3vMhbaaH+7oyLfMnK?=
 =?us-ascii?Q?ItFQELBcA81xS0J1X1Cr9WJh7lsDCgkIv5BaL2PAnJbeKCAzkFQhqvX8W/Ro?=
 =?us-ascii?Q?wbloGEk9OUCGwUPhzLPvO2hnGc7tFCbX2tZICSoSS7EuWLZMfn0zMZiPMJVt?=
 =?us-ascii?Q?pbYKy9AKIrPzr2vK3QqbM4om7uacCMrvehE6uWNKQCZ0FsYaZOzPu6eGHLfx?=
 =?us-ascii?Q?gWqrpYBFO4b6hE6iwQZ6y64IdxJKgIMBiAQ50Nxwi+C4B8rxeqpEq2ignMFr?=
 =?us-ascii?Q?HSLTWRf0N+f2cNw6Ivj8O/zDAjs2m6IUbZL+DR+QShiUPvegM/o3D4b/QgdU?=
 =?us-ascii?Q?V5FW/BCwtkaKDJSxuQuLi1vf0eYJwfVtc869PlZJwLNke4KEUKxTK5JAqhbM?=
 =?us-ascii?Q?FmBjM/GLBvgPxQ54RXGYT4L9LkNxlzhmdkIXPmp8uHBpFiL2xq7VB4nTXF3b?=
 =?us-ascii?Q?ByzrpcbuklKk8CTcWKLyUXdYwGuI11z39TeGIYfF6ifMW2321xETwHAb+6Th?=
 =?us-ascii?Q?VZZnnHB13hg7Rpj9ypvFhnuNGZ6YfKOZeuakSKOEnHpf/xKbJSDeh4OTzxgA?=
 =?us-ascii?Q?qo/fO7dIGVzGRIiGeJgQwBipkmvPVmd8ir37ezPc0XQ7HoksbufB/DPnHDCF?=
 =?us-ascii?Q?FyVyYFa+Klm+KaEnoYmr4KQT9gMDR6ppYC6vK3dBeXT+WEzK10Q4nnWimQwF?=
 =?us-ascii?Q?tc8C2w6D48CvqzQqKlkfTO+5PIo71wdO7VPSBBQUhWlActwLuIkcfdV4JAzd?=
 =?us-ascii?Q?3wItZXta9vYlqa7ak3Ap+z9bPcbcUPULFXiaLdBAYssnB5aWJbcsQ7irC/PP?=
 =?us-ascii?Q?pFejn4zU+e7g4GSQvAb4z2eoJ3Eh7pufQTMhybIraYt9WGBcov2RxWTWkoc/?=
 =?us-ascii?Q?DHnCA10uf03oxfhBmo3POhSHTKFEWwA+i/Ye2eqDslCNICt+YyomPwdH3Rom?=
 =?us-ascii?Q?5fk+Q7UldX/1FMeIBLB1hrAaqV/jjmp/Mmm0p9rkbcXrng4qegpAIB6VmDNn?=
 =?us-ascii?Q?UWc8pII7hVqCXRZUFRSWoPqTLjuOzzltREtWgBBS4TcHJcIKbxbPSHZ6J1Wq?=
 =?us-ascii?Q?36hx1rcpu13EyMTueI/XZpkJ3kUz2vhkbgLkORZjZXtSLWFkRWsC+Nch5EY7?=
 =?us-ascii?Q?zi4iEe5oTv/T5VdTd6gHcMvWrSPc5XtJ4VPZ/07T4DBSthxBGDjtGE+zVK8B?=
 =?us-ascii?Q?8WZUV1y/Y5OH3E3UpiGXLf5Tuvi+zEsaOsYUodob4xlJ69XRoMI8bb3oXZ5a?=
 =?us-ascii?Q?TdgfF1JbKvRZRgJvKQpATB35xrkpwcVMYl6uLtU+n6lY27t7Jc1UnEoprGqH?=
 =?us-ascii?Q?7rwIYSAFzuFKzD05RiuH19Xdxmr3oLUaenLW4VIR46MNBkN9fvLtc7rt4XOG?=
 =?us-ascii?Q?EHFXtxI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7tT9uauhg6y4TXgpmtcsAo0JSPOqsiyj3tvmmHBdppxEobxGksnhv3lY8EUH?=
 =?us-ascii?Q?wS3BZsI99gCMhzqCQpsyjr2VqDwXr8hdmbbFv0gDF8Y1hCWfImt7irGpu3li?=
 =?us-ascii?Q?97c0rvEtNEKvBKueaeTWYmXZsjv+tIhnZkBeIwx5exkISE2lo9Xwo4k2HRxj?=
 =?us-ascii?Q?xT8Nw1VU32QV68Y1i5S/jpH0H7Am1XXh4ElMm4RT2F0sgm32iWzZTeb0rkXw?=
 =?us-ascii?Q?O6SwK7OVHKPsz7xqlI43Mp6+zEYCChkB6rrr79aeaiQ1Q+Jpc2hFKVxcvwKa?=
 =?us-ascii?Q?k7gGm2PAj3z8iWIqhl9G3P5ILPTL4563CufF5W/CaZYhZxjCJeK3f0xLVIBo?=
 =?us-ascii?Q?7ZrliNi8Yh8/9jOO/gtPlnoqyqXqPnr2QZNR/DPkzIze+F0GeaSdJzba9EBk?=
 =?us-ascii?Q?jg5O3ZBTDebAyI+H7w5hUNNZiwEdRNMejrDcCgjW8I7GjeIx7+H+OCL1cyTU?=
 =?us-ascii?Q?YI9KwcWrIZ0EebRg97RhutiyI6JBb8BllKxZTaOho46lot5Q5vPVppiXyR2t?=
 =?us-ascii?Q?zMEpOSuMxzOchlb9+H7/KVPW3wahZOFRDwyM1TTXGPee4CtOR3gDM9Gvdq2P?=
 =?us-ascii?Q?tzoMGYoGda6CTUzbV1FVmm1RSc/zyLqd3kQ27/IumeYjUSUa+NRjk1D2BaqX?=
 =?us-ascii?Q?mCOFR1JuYiyyfud10w7uPXsKJY4x1xYb3+Mosm4qcJbutHBrVCW9IhwPuO+J?=
 =?us-ascii?Q?OnBNqH3GZkr5givp/Ol9A79Ba3mgkdccgPd3Gg/SXcXqua5ggPsCxDWdcoCX?=
 =?us-ascii?Q?IrFvwVRIc63UihywhteZm3qzJSadXACsUMbeNbbaRdy7yEssFrpK8bJ5q2gt?=
 =?us-ascii?Q?964qX7jc15Wttatz4on/1XNx8oxIN36h00/QfNfO6MRHY5qEw5BYj9UOzk/h?=
 =?us-ascii?Q?9A11QCGcJhb2qXPSMl2cP82hXDbB9G5pHxklYSVzfntRjMGYpu7XvwkhKJxD?=
 =?us-ascii?Q?9d9qVPIOPqwxJIVNt3P2vgzGToFPfKJwz4FsWQHtIYql3zdn15SrQn3Xm+2O?=
 =?us-ascii?Q?aiq/e/+GMxUtxswCq17BSa6RDzIOCv3rtTCMZG/RdeRgR+vQzYAFAcVD18gV?=
 =?us-ascii?Q?rdZ77b4CiWrRnd7OF2q8+KFGFcgffkuRej56v2RwvIPpYrkTaDLkCwg2wpNP?=
 =?us-ascii?Q?gr51JmOY5I1AwGBziLvKHDbL+AgCn+OfzaJ2GiXs8ojPagWVcxtIzB/TFgij?=
 =?us-ascii?Q?20Ik8By+D5jUfCEj/tVmQBujVWFP+WXWNUEjBW3mxDfcJZ/2GG5keeb0XF0o?=
 =?us-ascii?Q?s3QslDmj5J7wkxYTvX1GpzX2CLxP+iGTR7CrwG/ULOl4oG9Mik6ihuaanh83?=
 =?us-ascii?Q?Sb3PKaEVVFMozaXlVN4F8pEsAS2YNC9wDopYY1lh2JtAwrmUOqK5i2GtLCCL?=
 =?us-ascii?Q?6PeOGHjhtSddYx0u8C3CkOohtNWdP2CFYaV6K/3t/0AGe9yqiVswdExFGpgR?=
 =?us-ascii?Q?3TFnVFsEvzl3SXW82QftsVfSlEHvaVgDRp4aGFdRFZd3/6ypFb6nnBhKu/PG?=
 =?us-ascii?Q?gHyDPiYqyKYf3sDEGCC0H3HrRiFux6FCTODt8hoMI/QurLxXDmt/Tw8hrVLb?=
 =?us-ascii?Q?q5JnXMpR6VjX33psR+nLZqb2rnVhlkSdNZNpTmU4Kk+yw1VCgzL2CfCxclRp?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vX7sGQLlA4ygoYvRx5UJxs992yJfnAuZfYGBorAO7KsN6ilgdezW6X9CIzY8L/0UBXnghSOjyJdCwL+zfY6kv7fsdEX2rXjOcqhUCu1ciFaed2VguRQjyfi91eFzKHx6AKomDJiUZ9OueCkBBc1XAQmgcFqZ5duEm7qdhv4ROizIniX27pe24VQ8rvAcrNVhKg38n4RDSiX3oXL9UENB+4uecopKTzlWL6l9AoAGo+50A4I+NQq6aOBSMX7Kjg94TQ4qsfBeaJx7G38WYTkngamS4x8NHFeBdXXHjyTKfGubh0gz5bpk46f8F/jx3Ip03mq/25eAoqQ8QujZ2sLC5QULpISc2tLb379YpnPBItJvUYi7h1sRVYW+5ujnCn9S+x5rHRcTEKjgX3CWSjUePE5GgCJXDFq0Mh3uRixgudbFRqCtQvcUeGF/2KkagPqR9EJd9GVGT986s+su6ITTyUzhAzJtStHlIli2IKP8D8QzqYrvqtNRcGH80fhnbG7aBqpI1BCJfEbGuRVefw6heJHuiaZvEAJ5Xj3D+53ArQAzJtsfMQ81R6Thh4nRAFQBy0G8LeqAfFpIJSeoM8VYXmETy8BrTkr7tC8QQb/Vshs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8486c33a-4631-4067-f5b1-08dd7922fbbe
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:02:11.7702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGOzK1E18I94M5cBFv4ulukTOHFUIJURn1HVHYfHzG2I4iyfY6s5VpiOiEK/dVr4AjVfGiuQsT4Lmc+CVi+uNQ9cQCP/XfB67MU+qmlJdWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504110114
X-Proofpoint-ORIG-GUID: O-hlUGqB6jueJHQNJWoX7K7CIEsAQlyH
X-Proofpoint-GUID: O-hlUGqB6jueJHQNJWoX7K7CIEsAQlyH

From: Allison Henderson <allison.henderson@oracle.com>

This patch adds a per connection path queue which can be initialized
and used independently of the globally shared rds_wq.

This patch is the first in a series that aims to address multiple bugs
including following the appropriate shutdown sequnce described in
rfc793 (pg 23) https://www.ietf.org/rfc/rfc793.txt

This initial refactoring lays the ground work needed to alleviate
queue congestion during heavy reads and writes.  The independently
managed queues will allow shutdowns and reconnects respond more quickly
before the peer times out waiting for the proper acks.

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/connection.c |  5 +++--
 net/rds/ib_recv.c    |  2 +-
 net/rds/ib_send.c    |  2 +-
 net/rds/rds.h        |  1 +
 net/rds/send.c       |  8 ++++----
 net/rds/tcp_recv.c   |  2 +-
 net/rds/tcp_send.c   |  2 +-
 net/rds/threads.c    | 16 ++++++++--------
 8 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index c749c5525b40..372542d67fdb 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -268,6 +268,7 @@ static struct rds_connection *__rds_conn_create(struct net *net,
 		__rds_conn_path_init(conn, &conn->c_path[i],
 				     is_outgoing);
 		conn->c_path[i].cp_index = i;
+		conn->c_path[i].cp_wq = rds_wq;
 	}
 	rcu_read_lock();
 	if (rds_destroy_pending(conn))
@@ -885,7 +886,7 @@ void rds_conn_path_drop(struct rds_conn_path *cp, bool destroy)
 		rcu_read_unlock();
 		return;
 	}
-	queue_work(rds_wq, &cp->cp_down_w);
+	queue_work(cp->cp_wq, &cp->cp_down_w);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(rds_conn_path_drop);
@@ -910,7 +911,7 @@ void rds_conn_path_connect_if_down(struct rds_conn_path *cp)
 	}
 	if (rds_conn_path_state(cp) == RDS_CONN_DOWN &&
 	    !test_and_set_bit(RDS_RECONNECT_PENDING, &cp->cp_flags))
-		queue_delayed_work(rds_wq, &cp->cp_conn_w, 0);
+		queue_delayed_work(cp->cp_wq, &cp->cp_conn_w, 0);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(rds_conn_path_connect_if_down);
diff --git a/net/rds/ib_recv.c b/net/rds/ib_recv.c
index e53b7f266bd7..add0018da8f3 100644
--- a/net/rds/ib_recv.c
+++ b/net/rds/ib_recv.c
@@ -457,7 +457,7 @@ void rds_ib_recv_refill(struct rds_connection *conn, int prefill, gfp_t gfp)
 	    (must_wake ||
 	    (can_wait && rds_ib_ring_low(&ic->i_recv_ring)) ||
 	    rds_ib_ring_empty(&ic->i_recv_ring))) {
-		queue_delayed_work(rds_wq, &conn->c_recv_w, 1);
+		queue_delayed_work(conn->c_path->cp_wq, &conn->c_recv_w, 1);
 	}
 	if (can_wait)
 		cond_resched();
diff --git a/net/rds/ib_send.c b/net/rds/ib_send.c
index 4190b90ff3b1..e35bbb6ffb68 100644
--- a/net/rds/ib_send.c
+++ b/net/rds/ib_send.c
@@ -419,7 +419,7 @@ void rds_ib_send_add_credits(struct rds_connection *conn, unsigned int credits)
 
 	atomic_add(IB_SET_SEND_CREDITS(credits), &ic->i_credits);
 	if (test_and_clear_bit(RDS_LL_SEND_FULL, &conn->c_flags))
-		queue_delayed_work(rds_wq, &conn->c_send_w, 0);
+		queue_delayed_work(conn->c_path->cp_wq, &conn->c_send_w, 0);
 
 	WARN_ON(IB_GET_SEND_CREDITS(credits) >= 16384);
 
diff --git a/net/rds/rds.h b/net/rds/rds.h
index dc360252c515..1c51f3f6ed15 100644
--- a/net/rds/rds.h
+++ b/net/rds/rds.h
@@ -118,6 +118,7 @@ struct rds_conn_path {
 
 	void			*cp_transport_data;
 
+	struct workqueue_struct	*cp_wq;
 	atomic_t		cp_state;
 	unsigned long		cp_send_gen;
 	unsigned long		cp_flags;
diff --git a/net/rds/send.c b/net/rds/send.c
index 09a280110654..44a89d6c27a0 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -458,7 +458,7 @@ int rds_send_xmit(struct rds_conn_path *cp)
 			if (rds_destroy_pending(cp->cp_conn))
 				ret = -ENETUNREACH;
 			else
-				queue_delayed_work(rds_wq, &cp->cp_send_w, 1);
+				queue_delayed_work(cp->cp_wq, &cp->cp_send_w, 1);
 			rcu_read_unlock();
 		} else if (raced) {
 			rds_stats_inc(s_send_lock_queue_raced);
@@ -1380,7 +1380,7 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 		if (rds_destroy_pending(cpath->cp_conn))
 			ret = -ENETUNREACH;
 		else
-			queue_delayed_work(rds_wq, &cpath->cp_send_w, 1);
+			queue_delayed_work(cpath->cp_wq, &cpath->cp_send_w, 1);
 		rcu_read_unlock();
 	}
 	if (ret)
@@ -1470,10 +1470,10 @@ rds_send_probe(struct rds_conn_path *cp, __be16 sport,
 	rds_stats_inc(s_send_queued);
 	rds_stats_inc(s_send_pong);
 
-	/* schedule the send work on rds_wq */
+	/* schedule the send work on cp_wq */
 	rcu_read_lock();
 	if (!rds_destroy_pending(cp->cp_conn))
-		queue_delayed_work(rds_wq, &cp->cp_send_w, 1);
+		queue_delayed_work(cp->cp_wq, &cp->cp_send_w, 1);
 	rcu_read_unlock();
 
 	rds_message_put(rm);
diff --git a/net/rds/tcp_recv.c b/net/rds/tcp_recv.c
index 7997a19d1da3..b7cf7f451430 100644
--- a/net/rds/tcp_recv.c
+++ b/net/rds/tcp_recv.c
@@ -327,7 +327,7 @@ void rds_tcp_data_ready(struct sock *sk)
 	if (rds_tcp_read_sock(cp, GFP_ATOMIC) == -ENOMEM) {
 		rcu_read_lock();
 		if (!rds_destroy_pending(cp->cp_conn))
-			queue_delayed_work(rds_wq, &cp->cp_recv_w, 0);
+			queue_delayed_work(cp->cp_wq, &cp->cp_recv_w, 0);
 		rcu_read_unlock();
 	}
 out:
diff --git a/net/rds/tcp_send.c b/net/rds/tcp_send.c
index 7d284ac7e81a..4e82c9644aa6 100644
--- a/net/rds/tcp_send.c
+++ b/net/rds/tcp_send.c
@@ -201,7 +201,7 @@ void rds_tcp_write_space(struct sock *sk)
 	rcu_read_lock();
 	if ((refcount_read(&sk->sk_wmem_alloc) << 1) <= sk->sk_sndbuf &&
 	    !rds_destroy_pending(cp->cp_conn))
-		queue_delayed_work(rds_wq, &cp->cp_send_w, 0);
+		queue_delayed_work(cp->cp_wq, &cp->cp_send_w, 0);
 	rcu_read_unlock();
 
 out:
diff --git a/net/rds/threads.c b/net/rds/threads.c
index 1f424cbfcbb4..639302bab51e 100644
--- a/net/rds/threads.c
+++ b/net/rds/threads.c
@@ -89,8 +89,8 @@ void rds_connect_path_complete(struct rds_conn_path *cp, int curr)
 	set_bit(0, &cp->cp_conn->c_map_queued);
 	rcu_read_lock();
 	if (!rds_destroy_pending(cp->cp_conn)) {
-		queue_delayed_work(rds_wq, &cp->cp_send_w, 0);
-		queue_delayed_work(rds_wq, &cp->cp_recv_w, 0);
+		queue_delayed_work(cp->cp_wq, &cp->cp_send_w, 0);
+		queue_delayed_work(cp->cp_wq, &cp->cp_recv_w, 0);
 	}
 	rcu_read_unlock();
 	cp->cp_conn->c_proposed_version = RDS_PROTOCOL_VERSION;
@@ -140,7 +140,7 @@ void rds_queue_reconnect(struct rds_conn_path *cp)
 		cp->cp_reconnect_jiffies = rds_sysctl_reconnect_min_jiffies;
 		rcu_read_lock();
 		if (!rds_destroy_pending(cp->cp_conn))
-			queue_delayed_work(rds_wq, &cp->cp_conn_w, 0);
+			queue_delayed_work(cp->cp_wq, &cp->cp_conn_w, 0);
 		rcu_read_unlock();
 		return;
 	}
@@ -151,7 +151,7 @@ void rds_queue_reconnect(struct rds_conn_path *cp)
 		 conn, &conn->c_laddr, &conn->c_faddr);
 	rcu_read_lock();
 	if (!rds_destroy_pending(cp->cp_conn))
-		queue_delayed_work(rds_wq, &cp->cp_conn_w,
+		queue_delayed_work(cp->cp_wq, &cp->cp_conn_w,
 				   rand % cp->cp_reconnect_jiffies);
 	rcu_read_unlock();
 
@@ -203,11 +203,11 @@ void rds_send_worker(struct work_struct *work)
 		switch (ret) {
 		case -EAGAIN:
 			rds_stats_inc(s_send_immediate_retry);
-			queue_delayed_work(rds_wq, &cp->cp_send_w, 0);
+			queue_delayed_work(cp->cp_wq, &cp->cp_send_w, 0);
 			break;
 		case -ENOMEM:
 			rds_stats_inc(s_send_delayed_retry);
-			queue_delayed_work(rds_wq, &cp->cp_send_w, 2);
+			queue_delayed_work(cp->cp_wq, &cp->cp_send_w, 2);
 			break;
 		default:
 			break;
@@ -228,11 +228,11 @@ void rds_recv_worker(struct work_struct *work)
 		switch (ret) {
 		case -EAGAIN:
 			rds_stats_inc(s_recv_immediate_retry);
-			queue_delayed_work(rds_wq, &cp->cp_recv_w, 0);
+			queue_delayed_work(cp->cp_wq, &cp->cp_recv_w, 0);
 			break;
 		case -ENOMEM:
 			rds_stats_inc(s_recv_delayed_retry);
-			queue_delayed_work(rds_wq, &cp->cp_recv_w, 2);
+			queue_delayed_work(cp->cp_wq, &cp->cp_recv_w, 2);
 			break;
 		default:
 			break;
-- 
2.43.0


