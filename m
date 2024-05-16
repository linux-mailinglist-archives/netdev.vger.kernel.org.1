Return-Path: <netdev+bounces-96811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DAF8C7EEB
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 01:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8370B1F211F8
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 23:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA110273FC;
	Thu, 16 May 2024 23:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kM8WR5XA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YpN7N+aT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FDD3610A
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 23:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715901425; cv=fail; b=h9wmdtFUveZwI+PVN7VJ7wIDJ2tIkcovqzFz39iDwGCfHq8VNfCJ2j8+reqkaTejoQfRDb4zjK038ax39NQnmO9EeU5xWNeAo9I38zwOhQTE6I/oRaXGaKq6EKUvt9pr6SgYVIWVI0bu4Ij5EoWAyf71cFhrrnND3olbtA0jG1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715901425; c=relaxed/simple;
	bh=QDOlTO5guaQX0J6P6kN0Fk+zS1wlqA6irznciVy6FcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Tfn3Q1MRTMBsxUUHJiD1JYpiCDxAztyNskuSxdkMpHRqg8PqXyajtXDbrugXJNnOUxU5nbmGt+sCGKNlyScFdY3DPmK8t8mYlHyr1TB1NK7fxYX0grbNL6QFV6zFUo1bBXXzwkWNypSv4fvCdCboJERWW7hXkjaR8oy/tcL9GzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kM8WR5XA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YpN7N+aT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44GLv4vL000414;
	Thu, 16 May 2024 23:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=3PgJCVUdyvtlYiFRM9Twm7volYSzsOAHKMspNr/q79Y=;
 b=kM8WR5XATV3C52Q0HtE8DjpKAH+KzTSnfu/cTX8NBxMokwuGNzLYhs5JfdxaxJ3ytk4K
 i6RtHD4mz9Dm05Mw0XdFylteqMZuq+RmkTdpBJnUZv9/PFXXoU3t7LLmN2ESnsDZj3tp
 XZehR478pHFXMnAGgKofrWBDGK3QSat5Hf8MPIl57xbe/FNqyTmf2UlTrDweH3c69hh6
 K9XfIw/OWYZElv98MYWtXclZpGwauPD6iXKX7gmHflc5ONo6PIZaNFFVbrHdrsDybvIw
 xegMLOmDZxGJcsxTfmcnITMjCI/a84PZrZ1yumcCh0+O3S/6g4EoFitkVjg+K93NFc67 2w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3tx8pfyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 May 2024 23:16:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44GLi1gZ019278;
	Thu, 16 May 2024 23:16:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y3r88er37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 May 2024 23:16:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGM/u3JR6pRe/fK6a7+RspKKfHn1Sw11hT+SHaq1qYt7FFf63ACTHkilTf5FNiPZLLax3RKodIN/JxyVv8j41vBHznKcYxc3Ha0srR9k8ZNMHNcQatiVgn2XO8r1itlSvHOLgYiD5wKrWM073vfVPw3fqbY0VV8d1uGp1t/xke3bVcyN4g7jTfB915GAs7QaBHUG/jE1PhCLRX9fV0SNO9xtay/723NUL0bb1hIZXKD+cvSvsedp8bG8XpzIJv2hw+/A1k71eM30IchkYkJlzCXqXgmvE0xmAVczwUxvSv/9Am4bAoPSekcq32T6BZDC7wAb3msgjlgiTGkmEBuLRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PgJCVUdyvtlYiFRM9Twm7volYSzsOAHKMspNr/q79Y=;
 b=CWadQcps1c+UHJZ84wgcHobpSQBeqBAOI0s5j71T3tBaeCUHPrytSjTRNkU5IRnyT8yLz8HDJgmUraC/8V+FgzA8l0/K/q6V63lBkBQG7yuyCG+zi9Cp6OY/G3Rz1Yoi6Foooojqmob8F6eTm5LLeK1/tICnf/s/+RQKJrh+SjRtO+RPSHOLrvp2kHViOr8Vc9/vMOtncUJYgpPl2hJM2S4zis0PpOgQS+C1EJONQ080LQUB8c1Ocg4/sDQq8LetMZ0sMjXhmYexg2ZRgIO0M0YaNsm3b0l3q6zEHjm7X4BsklaugzfPF5Vk8PYg5iP0yh/qVMEzkjyDchLVhBiZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PgJCVUdyvtlYiFRM9Twm7volYSzsOAHKMspNr/q79Y=;
 b=YpN7N+aTcaIng1Kex1h+yqp2kYECWxz/+u++h7QJb6ausCHA3Z0myyOxSRg7Q6Qmk2fGLHv3z8ZshwP6XNJT7dXVCZduUsJiU0EQ3TQcja8DXgSxymqHPzpUvYAvVKMzmZ+WchOelgmhQsjSgZdm1sQ0ywaKXU2OyK95hMZbcYA=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by DM4PR10MB5989.namprd10.prod.outlook.com (2603:10b6:8:b3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.25; Thu, 16 May 2024 23:16:44 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%6]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 23:16:44 +0000
From: Rao Shoaib <Rao.Shoaib@oracle.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: kuniyu@amazon.com, netdev@vger.kernel.org,
        Rao Shoaib <Rao.Shoaib@oracle.com>
Subject: [PATCH v5] af_unix: Read with MSG_PEEK loops if the first unread byte is OOB
Date: Thu, 16 May 2024 16:16:22 -0700
Message-Id: <20240516231622.1545187-1-Rao.Shoaib@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0042.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::19) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|DM4PR10MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2d6c2c-81e4-4c75-5b43-08dc75fe4076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vlF35u7AbmGc+cxJsrGUyeZaHg9iEK/nXQR2Fa0HmFhan/q+zFklxS/RxXMH?=
 =?us-ascii?Q?cWKPg0ItU7vl4kPcVl0Hxh1n0UmGJlFDbjvuXXzbqGSm2de3wGsRfZoniNbu?=
 =?us-ascii?Q?pYW0Mkd/i+JHmfiTSb9deahpYDSmpeo+h0cKrC0jeoWWz2JjAqDFy31QmyfO?=
 =?us-ascii?Q?sGROfAqef8ofqWLL8AYj6mvsopbFI+mwjvtFS5iCBt+C/VJNEPaZDCQDRW32?=
 =?us-ascii?Q?M7SgezDVex+nbAV8RkBqpU4mHmwFbqBD9w18MpmPHjODdHoncYI1zv6u+FDx?=
 =?us-ascii?Q?vN2JXiTm9BDXYhSO7Pxc9OX9lRuzvc5GydDg/Ybgyjogi+G62xgpdz4nW58Q?=
 =?us-ascii?Q?G8gFyNbBKR/8tei04JEyM0SIAfje3cNhnIY0EFJJ6IkHSLPzSIvLdH0lbMQ4?=
 =?us-ascii?Q?bvETEOOneaT26aUKG8akC9EiqOThQ70lCxOGPtcnkI2x4M5mnHxf/u2nI39k?=
 =?us-ascii?Q?ihqf2H3RtV07j6SO+vWwu1OByoGd/fctTZOO6UYfb6Fe6ugLqZha37OFY0eh?=
 =?us-ascii?Q?BCSbOe8D/nHj7OvsHA4OA4TLHlbyefz1sRkAO4LXiNmNgOeCoe5SSFHy4/9l?=
 =?us-ascii?Q?Sjn4OdazRhBcKktLaLs8GMf0sE36EzS83+Q1w+ze8TeP8PAzmhS90ehS2XNJ?=
 =?us-ascii?Q?5ohN6cuHcLTtVTYRsBfpPGzg73IbNJX3ZmekitqfaJd4U9BI00n+haVFbUn2?=
 =?us-ascii?Q?P4cQwrU6Aut70TMdioravoj1jkn/GvbytGpOhlTXxt40isC3Wo+yUJzJI9/1?=
 =?us-ascii?Q?BmbW2PC+Y60sxgZL9kIfA2ShtHJzqvHwiTb2OkazcXFYgWD5ikwsiHl1MxbO?=
 =?us-ascii?Q?xMI2pug7apXBOxQlEpONw8WFskzbLrs8PpGMFpH+k+n20Oru9OPeJhSx2dzd?=
 =?us-ascii?Q?uXy0+DGP0qPB0jMvhcmCOwMJ2Ch3KJA4U22a48Cb22+BAwHiJIMjXFzlKbDo?=
 =?us-ascii?Q?8vracgBgoDcB6OER/g5XU7vATzesQfZVST11Rh3tlVj1Vxk0a9Dsj87uj3j2?=
 =?us-ascii?Q?jwAstvDLqGYNIjasY/vNo/Zs2000nuITLWQLQcn2PGfyZe7k0HrjK9YKWwWR?=
 =?us-ascii?Q?eSlYFHSjVVZdw0pWB1TC/cqnNaEYVJmjZrxoCFAL4p+eBfC9ttbE97qM7fGG?=
 =?us-ascii?Q?Sa20ulBtpv1FXujnk+ZHWifx5XsoIA7Cu46TG5DajmXk49nSYfLMf9IMwcvv?=
 =?us-ascii?Q?NoypRPyrPAzmnfitW9GGbJLP4aEowBOqOj/iR3wiDEChwMGu3TOJfmL3RTtU?=
 =?us-ascii?Q?F3RBf6uQm5yMIpDSbfbLRSp68CSefjuJDtywtacQ1w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ocsYeoG2/uv44oD+DcWkOwPwgE8VaAJTmtzBkApmr0FNTHtoGmYQLnorlFo+?=
 =?us-ascii?Q?n0pGgvMcRv0x1PCMC+AFjYuFwDj/ZQyhVbWnYMi5kjiV1mpPn5SuvjK1TRNd?=
 =?us-ascii?Q?o54MtZNSty7xmRgZizDoxulNCbXN1U8wTby8l75kw4169du8S8wvFlJKbF2C?=
 =?us-ascii?Q?b9yYCiaoQvupqSv2QurpCvMePrRzUAoQVAc9zbbyng7a+sIBG+cETRI8AWF0?=
 =?us-ascii?Q?4eCj20iXICGipxmnWjs52NUllNAShrCm4z4FimZj/uWvVdktbl9Zd5v3TrD3?=
 =?us-ascii?Q?Yo1t6zv/KmwjMaakA2GQjwyMb6ICgk4U9TgY4fgilNLSWHa3kpaYzXV4fvAL?=
 =?us-ascii?Q?tYT2VGqiIQspDtzkuhm0ccnqQ6unsQg6uh6KC0nCrlgycxNRCNch234xHQab?=
 =?us-ascii?Q?mP9RpEZ2sZx110XRSQwZ6UIKSZ8SW2sTuL0mlebaqnfrXuPMsVmhCNolzkFo?=
 =?us-ascii?Q?K1LZh4RYmwqSRIzrYWxPhEM3qugmHW9+zGuGDsRLGr+uR3USg2K3Z0ulB/dh?=
 =?us-ascii?Q?dnJSzCYwUPRVHEYar1gcwk4yawyPxqpIOySDlXAEHErLx7cmxcYk61kDaxx2?=
 =?us-ascii?Q?ez/ATmaG27+5Tz3Z5S6UdUA0HDFKTbSIvN0EGy/SAi4eJ8ORTAA8ORcsatpB?=
 =?us-ascii?Q?RV7BOUc7p78uVpqSex/0XKhtR4BSuehq3jGaglF8ruV/2VcWIrmqdq5JCKUQ?=
 =?us-ascii?Q?hrz1uvhgzlh1YR2NVsRGIEDy18xcdkfGinohoRMMP0NnWaUmv0uKoMPd0SVV?=
 =?us-ascii?Q?xYrtOVnvuIkvqUPK1LC4HB69XEIIJD1pFIj6GsaT1kzjWy5oFIr/v1B0hYsh?=
 =?us-ascii?Q?rV3rlIX4pCD6q58bJ1aAZzihvJgpPygguKuXcoJzzOxank4Cnajq+FySG9A7?=
 =?us-ascii?Q?6nRB11IoWnLomlf6fkEBngvZYsYpQrUWUrXXxL0cVJ3Hx6AEtOWXc86SPN1F?=
 =?us-ascii?Q?wx8Jk95gxKxktviMGJaToupI4z/pko4RM2W/AUjupRcuDZJ/hueV8BYCPToS?=
 =?us-ascii?Q?Jwt3h+eCXA3lR6YjEWo0tM1R83JFUrkCLzz9k22MYSE3VTxF2advByHhvmPU?=
 =?us-ascii?Q?5GObaEDK0qrzQv+DQT9PAhoFXUZSwThutc9hI9Te/Rvmz6PpY4iUZ7cl/GUz?=
 =?us-ascii?Q?s3Rv5Qedm5nnl9tYjj561k4GamMID+o4xBXyUGsxCbN9b3ufIDLJTkloe2ez?=
 =?us-ascii?Q?sJwuvfh7gqnELJpfkTvk500VZA6yWu7hD9NLmbY1na8QGkyzGcMayRkWStoj?=
 =?us-ascii?Q?u1qeVJXRFzbwFB+u8soFZU/8w4Z+3k9pbuItiwE0JrWvPSCSU+jcXJ4qPJ3H?=
 =?us-ascii?Q?fKeEBlwj1BsOtIJEYHSvMUzZ+l7jmOzaBNkvJQKQm1A65N2fQF58rfSZiWlZ?=
 =?us-ascii?Q?qjgvoALXub3h2Abkj8JHFMdElsVZyT9ez+qaKqtjQQHRRoMZvth/ikXLAcOP?=
 =?us-ascii?Q?U2HADqrV/ZTXjiJSujgAutnup1p3kPoYfEoI/RohoELSPrMJFvXN1afv/OGg?=
 =?us-ascii?Q?5afbehZGwbH8s9hCz7xZD0Z954A9FuIq3uU4KQdNSoBf/EnbdkZrpTtMYrMj?=
 =?us-ascii?Q?k9KfIg/CQmsZ2Cghf0jtKz47E1F7Sp3G8sD9XgrigmzZz4k21VIzr9ldvdIm?=
 =?us-ascii?Q?HvAUYbW1cnWPtdm3E9s3iKeQktndMuwaWrj83mEAoYhboMLLMhcgrRK3q7Yu?=
 =?us-ascii?Q?Aoc0qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	W9YhXQF7Z9pY6CCUIEnjkDZnHrXdPyky2vIgkxDJDVfnIFxmCBBaI7LPt1F3lytiOb2NX3+P63wrKtrbJg0RYnnm8oKoAUZ8+166pUMmqXzlc9mlYLPflOPItE9rSv9WeicrdeNfNtZVdd5rnHJCmkvuM1tEyPXXlw5W8pXhr+5M9XvxoqzVcpQY7/0YbrZAF5offFvvQzFbIeQIhU53HnObQi5UsPHtDaXqaXprzTbUlD6CYfDIR3nUU51n6iTrVBm+Ep1+uI+PBtzQn6rWeqpmopsG7lzOosdu6FI0d232O8nnFD7yVIjGieu6f0hxJP/vbqakk7vX57uxRt4ko5PcOjwwJrYb5x9rUoMXwBK6KRMXAeQ2pZtFWiAnxZm4Lf34byrwI58J4yWxsNC3ajbYXYT3g5ypec3cQYKCVWw0HUvSG6iZ0c854blYDKpx0iYXaMd6pWa59nnuDO1IBE1omrhDL7gIr1n8oHHIqA6H0OgNq0di8+M23PQxm1+UV9iBDWfyXtu6ESfV01THjzNirLARpg+vFMMI1PXNrh4R3nnrnVXNYtw3t822AryAPQL99SlyVcCpzojdkcRrQ33WT2rdKnt2ReCHWvJsBNY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2d6c2c-81e4-4c75-5b43-08dc75fe4076
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 23:16:44.4692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhSkgneSDvHa5SPoAi6xgUWWvF51T5oK3gFjDXNb5IkFSlUmzG27Qfm5TfgS98DRkuXxcg2Ox4Bo/QPU+eRWaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-16_07,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405160171
X-Proofpoint-GUID: 4z1sr533rIPl_mvqRGO2OM9xUv6Dvg5q
X-Proofpoint-ORIG-GUID: 4z1sr533rIPl_mvqRGO2OM9xUv6Dvg5q

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

>>> from socket import *
>>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
>>> c2.setsockopt(SOL_SOCKET, SO_OOBINLINE, 1)
>>> c1.send(b'a', MSG_OOB)
1
>>> c1.send(b'b')
1
>>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
b'a'
>>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
b'a'
>>> c2.recv(1, MSG_DONTWAIT)
b'a'
>>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
b'b'
>>>

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Signed-off-by: Rao Shoaib <Rao.Shoaib@oracle.com>
---
 net/unix/af_unix.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index fa906ec5e657..6e5ef44640ea 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2612,19 +2612,19 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
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
-- 
2.39.3


