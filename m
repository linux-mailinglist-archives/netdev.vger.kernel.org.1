Return-Path: <netdev+bounces-90031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87AF8AC8D5
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C25BB2094B
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1BF537F1;
	Mon, 22 Apr 2024 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aFT7CMt6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I1eleJ8U"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2971A4CB55
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777920; cv=fail; b=qk4MWIqW8ChNymdnHl0hZ30Psrnic1/RYZWkYlDQb/Jx2GeROHZroCcwR0ii/PPgrE2gglWLSjLv56hYbM9RIf2p9zJIQZAtd0YEovkOip65ylFi2KK5Bm772utNkwCY8IQxag24ZfYdupma3foS2DQxZx3V/qVrlcnsc8/M0Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777920; c=relaxed/simple;
	bh=fqk6nznsJ30uU6CulbfOU7I8vMmvnM4GE9s+AO3/stw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EuMsttRVXzcgdXq/Qaax1IkPmc9B03G+B7TNN83Yn7zO7YpyyZW6RCfXmZOYiNB+kus4K4Is8NmiMoaZh3wWCZorXWUqvhfG16jjVLRkqAhFhuteqdwbvshxxLql78p255aLfMv2he4wnChJZLVNpd4t+1EgJK1iaMPC6zw/umY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aFT7CMt6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I1eleJ8U; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43M8AUwk009688;
	Mon, 22 Apr 2024 09:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=PaZOnVWchFQMlVS/D3PmBOqVkOGf5l+BW56QIJn5fz8=;
 b=aFT7CMt6mxDNXEtG6qnyOpX+gXPAS/GHfwvMQw3BlENHirSeTBozp+vfxbOA7k2Pqaj7
 lA8DrQVOpDwJJsabH0s1mvT8fItHaQkcuBQXs44IsLDGu62a/BoVjvjpdZFhujPCdmOx
 IR94vxOfLGIKqwdq4RlZM6Z4jhovmDimwB0BHuX18IfgeXZWL6+SAMHqTmJjvB36jnhS
 p4tDdA12+W4ESyeZ9umIiGQroUSC+dzXsGP8KtcykLAXZ7qqY+7DaY8UyEcqHM/IwFLK
 NLMiw4r6LfwgiL48yP63I/CClywPbADuD9eHw1NALX/DAcYIcSIzKzppGhPRGx93CrYx JQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm4a2a8qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 09:25:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43M8MfMD010913;
	Mon, 22 Apr 2024 09:25:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm455pbte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 09:25:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aepF+6dvI8uPSUH7bhJLH3Y+CWOILteFVIV3vjmx43Hxid2uS7hXyKJwGwstKiHkznZDspXlj20GGJhsa151qo+PFQ6l7t5RvWaGnXEwTByro7uJE8whPdMnZLnG9dR2g7UqSUZ0vFoKfqE+je+u0eFmat5NAbNvnepi0Ym0Uhbnbjy/Lk9HQ2haGkcnZk9FIdfk3Tzbd0lS6iW9UgsIuJl1NF8MealIUPVLhy1Zmgo1A49l4GO6niMMKKkklk0789adShVDkk1W2TDDinapK6hglwv1oFq6DJe1VR2drRhZLHWenGiUbzcmLzoXS6TKy7kckk36NzfelNsdmuv8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaZOnVWchFQMlVS/D3PmBOqVkOGf5l+BW56QIJn5fz8=;
 b=YN1uwKkNW9fj6gF8DV9T7r6hX8+Bn6u+ersIHW0Xkm4fevFgvMpB9CctCAdjbW+vFdRZ1+UKGIrikqxZ2BwQuaDQl8rIZ8NJQ5UGYo2CmvyHFRgbu6Bag2zcEoBZUKJ3wdEZkEYgyn7PVO1QzbSHEXZmANpK8FbDdZ5QmZjQdOswv7d+WnRuazghmUYDjo4gH1jR4B8o/Jwj14sSm+q1ifz8MnL1ggU0GNXVWUeHqjZBICowz22CoQcgQKU0HRG87eehJ7ZXHHizj3/GbMTmm+VHF5EO6kHRSnTfFfkJki5dkspYcZdvq7zwTjeHA7O/pG3qXOTQq8vJzenICpqF0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaZOnVWchFQMlVS/D3PmBOqVkOGf5l+BW56QIJn5fz8=;
 b=I1eleJ8UfpZs9rSfBXwYOTj8V0tpQo02pfeSQWT4YaTraT34nIj/c+OLU6BlElshvib+KUqF3molSYzRePzYGXRz4rbGA/KOBTBgUx2ldOtyFvD6Kylg+Syw5V8kN9YS51FN4qvFPFuxIpEfknTM6vFs2pGEiS4iVrLmeU9W4Lk=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by CY5PR10MB6071.namprd10.prod.outlook.com (2603:10b6:930:39::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 09:25:08 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 09:25:08 +0000
From: Rao Shoaib <Rao.Shoaib@oracle.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: kuniyu@amazon.com, netdev@vger.kernel.org,
        Rao Shoaib <Rao.Shoaib@oracle.com>
Subject: [PATCH net v3] af_unix: Read with MSG_PEEK loops if the first unread byte is OOB
Date: Mon, 22 Apr 2024 02:25:03 -0700
Message-Id: <20240422092503.1014699-1-Rao.Shoaib@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::16) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|CY5PR10MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: e813cc57-7044-4144-4c3b-08dc62ae1a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?5K23cCzdXs7GpmyUUOKDRjdNtKg6c+0Zmh7v6FKeCiYdVCSh53XggOx89Qf+?=
 =?us-ascii?Q?a/mGZ1KkmzO9qsBnpErBJHE8nCm+hdZbtzW6nBK9oqIQVrtgioXuoykP0Dcd?=
 =?us-ascii?Q?T3Ea9Svm0RpBplEUnL9b5mje1DihxvYnyDMuodlMhFKWF4U0rsc07OPiGKEB?=
 =?us-ascii?Q?TV/9muwrJ5cRZxmSSC2yGIGfd8stT2JZ0/1kolHrbWjgEHHCoPCK8bT3S57F?=
 =?us-ascii?Q?oy5CtRVTZm5crHbidMcTDJ67CmmQWS0BQ830DfFNyfZLeMgZM+IsqvFli7oj?=
 =?us-ascii?Q?xs/+3lsq57JAdaZ9A24Iu5v+z41+efTFeBLb5V/eu9xIPNMXRnebWaR5Kiyz?=
 =?us-ascii?Q?4ulJymdvfSigDBEOVfSZlw/oQ0+SFmAKj/d+1qkHEKwz2dijjNicV3DJ7Lng?=
 =?us-ascii?Q?X7j+RoVVXk6V+qdspvXduRP/q6L4qfx01vJ34bnsQ1sivGwPlY36Vksc8nyB?=
 =?us-ascii?Q?7NdYIQZkhucO3nIA3DIUoS+QQV8tj0Rz/wdMqDM6xcKGGGxWFY8VaGeK8RJn?=
 =?us-ascii?Q?CdhqdQzYp2vGYR1be4naPKxQUQYFZSnK7C6P0cy8CeT48MtMsk34/5xgbCd4?=
 =?us-ascii?Q?W/3AKdwpzbj6p++69nbkQd/Y18RchSGg6rzmsAPnf6IRUf6Dq5v1N6c/0ZzX?=
 =?us-ascii?Q?cU1OWg7RmwxpGgwPfR+RidJHyUrPuN8UoBrTSDvLNFLRD/BWDqIf8bmttdwC?=
 =?us-ascii?Q?bgss9WGNEnBWQ6BwNwBYoMTN7PZwTtqRy7ahKEEMTdNwBbRxeWxVFSxwYmaV?=
 =?us-ascii?Q?u4rwzKxRXtBAINeBreRaJxCnusATiWSvf5SWxoDatci+LanmItkJ7Z6P3+Yj?=
 =?us-ascii?Q?qo1XN+6A3uxFR3JaDazY0lDZ3tPnRkvhvlAH/379AfX/XUFX26TsUC/8Zo9Q?=
 =?us-ascii?Q?zsbsSbhjvoNsJajfD/yQAH1tEjNaaXO/UrNRRW3PakfQLdrFbeFrOf5BmHT7?=
 =?us-ascii?Q?+Yl/odVKDGDvOvNARM0CP9j8DtMiQtgArd+ipMEMHoXnKu6CfrC9yuHzBeTz?=
 =?us-ascii?Q?iDocESqn0Yc0tVehrB9BhiQdAtJcVZWqI8VDr/TFIKGAbb9aOVb2djdhOsTP?=
 =?us-ascii?Q?+T7eGxRlPHxTKzJtI6o7a6FVyymaQyBsguplpWQ2Aq0rwg35A7aWIgCAlNrJ?=
 =?us-ascii?Q?Bo9w/a4fFdO+p4BcMJWrgTR7KXlZDJo3F6W22u3Y6IYibbEzlgX3w+3QGOYW?=
 =?us-ascii?Q?hD0wp7YS/I8MlLFXS43bg3xzEUJY1CDdQdXxJdRjvxjMijQFANGE3/fZ34VZ?=
 =?us-ascii?Q?2zsNKpUB5arWra83xB/BvB8zUrAK3miRof5c0AFsKA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YPwpo80Mv5uswoEdx/8WO3WCEcWNFxE7HHVb8JzGwfrE9Of8DHJWuee4s3g2?=
 =?us-ascii?Q?E/b5TvVx/bSgxvH436bahi8j40OpyWONPiVWEBkY2NBaL1MRKh7FynKlvlsq?=
 =?us-ascii?Q?oanu8r7qOSYWJySXpvhMhLaQmyU8Hz9COI+nt+e3ukTq3FH/TeejKAdUuErX?=
 =?us-ascii?Q?JpFKDBTs+XWcycyJr9c48AdbaXfLJRKEk19tOs//LSf6B0Aemf7UueTsssa4?=
 =?us-ascii?Q?kG2unWNt8VlulkMuQkhwmCOqI8QPl1j1Y5//225E/4YhKCVyhTR4RRrpPITB?=
 =?us-ascii?Q?gFGVVzuDsajopA3Jb/NGzN1XqdwAxpxEOzf2ZYUMiSLmcaFnklcsB4zZiNk0?=
 =?us-ascii?Q?z2Fddo71ARz5Tk6rQqQBefnmlkN96+07FmGe65e/VqRM+ziNX4UkFxzM34Q9?=
 =?us-ascii?Q?gbpWpaNCef00lKqO3yY39QhdChaCKBxpa6vF+uf1fCJ0DB9OvOTi/jpNOie6?=
 =?us-ascii?Q?MU+iQNliQAdjMDZZuUvKTDoox8mXUICfEgfB6x3bb7d2qrESojLXJy8GdZno?=
 =?us-ascii?Q?YhU8G/FgiIY+bOjk5zbadNcDbmNFNnfyfbZxoohcWlaJAjsf4PXAHBrRs7wz?=
 =?us-ascii?Q?P0XNCQk4RSs42CLwGpJJrLRcuDwtjpDos0p6Wsco8AriU8sjEAt/CYPOo9PM?=
 =?us-ascii?Q?95xdIZSx5BHFVF3Z27xsP0eJUcP/Yhk6KE26gUkGr5umUCSIo0BNCga6Vkdb?=
 =?us-ascii?Q?JHnQDRdWhJYSLSsG8hR14G3Y0lLrWSNwKILDyACLl96lb1W7nq+AoUtARpWk?=
 =?us-ascii?Q?gaifC6zFq8BJHmSp9cp3aEbEeyRmY2Wqd2Tj7HXFIbtoUuzBiFYIEFeWpUKC?=
 =?us-ascii?Q?kZp2u24neFxTYh/eQpMJ3fe9RWbmKvJIZlAdsUaiOVj7mXZZtf1JvivPSBsk?=
 =?us-ascii?Q?gK4R7MP4b134Lr+VGzw9yzQ53uEhao4Iqc5J6YhLmgZw0nUPfPWIR+ikiHxR?=
 =?us-ascii?Q?+aB3hRbsf3R3ODhUDgpFwZ3SQNwy+kFBa0js/9sriQp6fta5pv2B3wPqV5zJ?=
 =?us-ascii?Q?Hbn1HUj4UM6vkkU/DKSMtCStak32J8uxtwByHQIOG4a1B3Bpi5O6j56FG5VD?=
 =?us-ascii?Q?DJ5ZpqhFShZVy26TktU3ZVnIC5j6vUEVJfMi9ybZEiXcRwwPJ4nZ6gjoccGV?=
 =?us-ascii?Q?h+zyKk5ZpxLu8aH40akhRabo9D57M/sUyuOW3/oNHW/4IOZ72RpXoQH2SL2f?=
 =?us-ascii?Q?F0z74ERHPifVPC3p1WyH8122f/jmcW16TVOZ2LaI4C5syHTXAv1Rwhz70s+6?=
 =?us-ascii?Q?dp78GQqfy9bunh6J+si5/SLbvZSVIFwsOJornHxtm5kwHO3xh3iQ3syR7ZfE?=
 =?us-ascii?Q?WzSwHDom5m5WrYWyrwdu6BOrZK7/Z2K+uC9Y4ouGMZxXzrFGw2oQjY+0auni?=
 =?us-ascii?Q?e3RKLIvHlAQo+A6D+kj8IjJnOb/Rk+lspcJ7VdzQMpX72BVLCveg5OjrnAiG?=
 =?us-ascii?Q?jzPcPDY1jextcEtOr552kxGeWwOewfnwYXciThIXlMP4GNN32YEDdrCRtl1P?=
 =?us-ascii?Q?OfGJRzX6/p5OD+X1pKoqkkIfn5V6awFhjlC+ID/shtBej3VnPOeooo6a8nBf?=
 =?us-ascii?Q?3kpJp5kbecCUE+7CkVEKAjFJKg1BNOzCEKupBWTn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VS8cYn+BEnTXGrQPDdpZXcbnwSeucBQl7ULpneDfcKtpmiuVlXOerH98PvwVXAhSF2iQuyz3Sy3t6hwkOABkF1/jGGFfq+SCmvu6c0pymlHSaAUeg/UldvdQvo4X0Q7Nja39NAaSA/bonRSo5EPVm3kOHywL05SOCIwNh4lMho/d5zZgGxRsgSgkWyBfHzF3d3iknT/pZQx42PIZtnPhNKyyQsI87/jy0j6RNtvDt1SppvuxhuEY8qFJA9ZdpLp+1T+w8rX/Kn7kjarH4SrckXbPXP6LwhlF23mLC/EK33ywVC/J6Cqvve/6gfSWjhtGBWkOYZYG7qcHYHk8kPNmkCOCBx8JRSiVVJ0E8Bqcdg6/gOlUzOCMrYAJWdIivez9InjNAYjZoMcxaYxqhey7uMgjaxFPoijGVgTP2qHIa+urLv0Tw4QZk5tCgiXnm7dhPEh03rrgnr9w9Vz8OUnejbuGP+fRlLhfDw4zwdx2WgMOo8j1PbZ1aTHl9J8VSmksJoBN8xwF5EozhPWYc8/BABxJlQHlW7dEmFx7BqcMlyK6PakPRxKc92yUSeI6lFU4BPk0dmcMIuAI8dv0zVsOBqVpSpYHW0e5Nx4Sif8XdpM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e813cc57-7044-4144-4c3b-08dc62ae1a41
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 09:25:08.5431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AWFJB8UWNopKP1k46pXYC+4Vs3XXpxHDIr7DmgQxpq3uXewny45gQMABdCtn7ftNPotoJHCoMHkOSSTxiX2bwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6071
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_05,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220038
X-Proofpoint-GUID: SSQPVr37asVU4uKQvDVcsldGCFUx7fIb
X-Proofpoint-ORIG-GUID: SSQPVr37asVU4uKQvDVcsldGCFUx7fIb

Read with MSG_PEEK flag loops if the first byte to read is an OOB byte.
commit 22dd70eb2c3d ("af_unix: Don't peek OOB data without MSG_OOB.")
addresses the loop issue but does not address the issue that no data
beyond OOB byte can be read.

>>> from socket import *
>>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
>>> c1.send(b'a', MSG_OOB)
1
>>> c1.send(b'b')
1
>>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
b'b'

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
---
 net/unix/af_unix.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 9a6ad5974dff..ed5f70735435 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2658,19 +2658,19 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 		if (skb == u->oob_skb) {
 			if (copied) {
 				skb = NULL;
-			} else if (sock_flag(sk, SOCK_URGINLINE)) {
-				if (!(flags & MSG_PEEK)) {
+			} else if (!(flags & MSG_PEEK)) {
+				if (sock_flag(sk, SOCK_URGINLINE)) {
 					WRITE_ONCE(u->oob_skb, NULL);
 					consume_skb(skb);
+				} else {
+					skb_unlink(skb, &sk->sk_receive_queue);
+					WRITE_ONCE(u->oob_skb, NULL);
+					if (!WARN_ON_ONCE(skb_unref(skb)))
+						kfree_skb(skb);
+					skb = skb_peek(&sk->sk_receive_queue);
 				}
-			} else if (flags & MSG_PEEK) {
-				skb = NULL;
-			} else {
-				skb_unlink(skb, &sk->sk_receive_queue);
-				WRITE_ONCE(u->oob_skb, NULL);
-				if (!WARN_ON_ONCE(skb_unref(skb)))
-					kfree_skb(skb);
-				skb = skb_peek(&sk->sk_receive_queue);
+			} else if (!sock_flag(sk, SOCK_URGINLINE)) {
+				skb = skb_peek_next(skb, &sk->sk_receive_queue);
 			}
 		}
 	}
@@ -2747,9 +2747,11 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 		if (skb) {
 			skb = manage_oob(skb, sk, flags, copied);
-			if (!skb && copied) {
+			if (!skb) {
 				unix_state_unlock(sk);
-				break;
+				if (copied || (flags & MSG_PEEK))
+					break;
+				goto redo;
 			}
 		}
 #endif
-- 
2.39.3


