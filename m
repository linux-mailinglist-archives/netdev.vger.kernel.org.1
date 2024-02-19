Return-Path: <netdev+bounces-72959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DF285A63C
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 15:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D106B22FC2
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8B81E891;
	Mon, 19 Feb 2024 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="Xqi3ij4P"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991B53770B
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.133.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353729; cv=fail; b=KV4QXNk2wRMSyuvQViIAc1glN4Ob8ROZZnqnVVS+EqLTYeNOHQBZsHTK11XyZI0UK7x8UjJPhibvEgISmtgJ+YI4jVTZOGbUVYS3ylUeUqsGsluJEzU2dSiLmLu8BYT2mW43RyxdMjZ278+TNMGRExWY/w9/BHueeh4mtIgZrak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353729; c=relaxed/simple;
	bh=1oNS2kctdDuv6rwZWqNWKHfH17E9L1+XiQX+q8cFAaw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=R4vV0Q5QwRcXW7QVtHFXLcFQiEy+D3vFJLuKR/t+rpDiVFfFH3vKaRtDLMYi6UJ6xfkLkBJbxRoAi3bYIcVn9IWxDW56XwAY/xwHDYULjxs36CypK8BsihmjtL9Nr2SqG7khgbX6EITmXba/oOPTr5yBxLczIlKmhAMO9FU5X30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=Xqi3ij4P; arc=fail smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JB2kel018495;
	Mon, 19 Feb 2024 09:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=fQjwfWsSF59sdezHbSbHeMhFJivYX9FKhvofAUSF0Ts=;
 b=Xqi3ij4PNAJrv3DVZo/115++tw8IAMEFBa4mtKHJaIS3uhB/X6iBFj6nAP/6BKxoUHWh
 v6TYTrRskDVJ3NMVtEe0i1NFoWLB6UVh+s5S1/whB/S3V24qKhJhN5GLYvGLs2F472aF
 iVB7EvVLDKW8Y7+xFseUo7Rg+CrMvIvEMK5D/hiZFCD7+cvLKODgMQizLl5KrhSI+gAk
 5TMAp6BMlXvtPgMHcyp8gAZK6NJ0UuvDQqWZ37sJvbQNvGc0mZ1GWqfJ3AwUQyBRZHwt
 roAnmkSg4hLKuW52N5TKsP/G8IGOA1FCeg4Da4frCtwPzNLjulb7J7txVrfG+sVNhxDI LA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3was0r79eh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 09:41:57 -0500
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JDrjE3027692;
	Mon, 19 Feb 2024 09:41:56 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3wc89291c2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 09:41:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfotSeQF9e3xbKsjvBu/KJ6e1UjDzLxU+/RYSXIfKfrN5l+CZWQLLeqHKLHIyUULMjWLWK21Eh53OOHzGg1SVtDfki5p1meiIAotmUXx5xocdryGI5HAduOkhjEj2ijnsP61NtExq4XhAscPp/bAH3fMM2KuQgZChCzqhkuzyJ+AQxbTLBM91N5eFwB6ezQDCP7XJPBnYB0I1Bi4lSEfrqXQYaWpNU4o7ezKzqZPRKZlkpy/Nh+WJ65TZ4OAVZYH8uttdZ+Hd6c6y+g5G4eoq/2ZADks7DYgT78dtKMu9NFor3RHGMvMH41qTnWpWT75vYlN+4azL7jZZnFFB/UmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQjwfWsSF59sdezHbSbHeMhFJivYX9FKhvofAUSF0Ts=;
 b=OX/jtJ0vE26dPAIAHuGYxhyeOFRV2l3diZqOBApFM5bKjz+qnXugSdU6MZcr2eXCVuMQ2MXqDKMDxeuG3IzIlZ3gyKC2RXd6XRJAQJxfOB7badDtCyx1D56c3OqVPuH2v8jowH9wcLHRiVCfr9oswA9Bd8F7Qz0ZI6MkwKTD0j5KW6KHPUvBg6gj/DYFPsdLOfcGO/YQZs9UZpkwm5jMko0VPYUYUNnZ9zEnJhoVBnYEyshQ8Ki2Oh24dUYgns5/BvgilDfL4oMTiZkpqm/pOasYj5vtHq0cZgzCKd42zk35iuwniFViqE1aL8Mdxl0h/OBPNkwLdk8cJf9T9foPZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4415.namprd19.prod.outlook.com (2603:10b6:a03:286::17)
 by MN2PR19MB4111.namprd19.prod.outlook.com (2603:10b6:208:1e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Mon, 19 Feb
 2024 14:41:52 +0000
Received: from SJ0PR19MB4415.namprd19.prod.outlook.com
 ([fe80::5707:d1a7:932a:1f45]) by SJ0PR19MB4415.namprd19.prod.outlook.com
 ([fe80::5707:d1a7:932a:1f45%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 14:41:52 +0000
From: "Ramaiah, DharmaBhushan" <Dharma.Ramaiah@dell.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Jeremy Kerr
	<jk@codeconstruct.com.au>,
        "matt@codeconstruct.com.au"
	<matt@codeconstruct.com.au>
Subject: MCTP - Socket Queue Behavior
Thread-Topic: MCTP - Socket Queue Behavior
Thread-Index: AdpjPln1K8p7U6IuQcSvYKsg8BomjQ==
Date: Mon, 19 Feb 2024 14:41:52 +0000
Message-ID: 
 <SJ0PR19MB4415F935BD23A6D96794ABE687512@SJ0PR19MB4415.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=4e3f51b7-16e7-41dc-8c40-8e77f1bc6d80;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-02-19T14:17:05Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4415:EE_|MN2PR19MB4111:EE_
x-ms-office365-filtering-correlation-id: 532334e9-8cfe-4d72-5080-08dc3158e9b7
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 LhJVmQJzx5zJ0UcIeAGeOKKM1ztVN2uPUK/1qpbgG4x7UufIVu4/BXc8JIX+FQJ6YSKs4oWToAoHuujRN6icNWL3xrh1VjaQIa8S5gG4lILMLOP62hx13/p5djI6ajCXKbPdltgYm+9ldExONDImRfP6mY4gKBpAEWunbuGtH5N7McEYiECmlf2ycJj46VhGS8ocplz71ma7wb+ciQweaC0gntyBV52D4cTYNIe4c93MXKg84/jeMSrbfGU+HEbvBP+3aIBq1rRWYATAFIIpTwImfqYidYuXojhAvx7RhOHXBMEnxK/B1pnu5W4tye47LwHiWBzsNT09Ugvs8bmMOZfr0vlcQIikpHLbbxyLkVTreGWXMRmSBYJFJ58vRjFITnk/ZaFIN9TUIu5xfubG/NcXLzMSZzQ9NaP2dX5zQVfaIdU7k16iufJYLAhDejeZM6iFPgKgI1MLJ/2Vx7og15mQ+WbX+YEgjSRvusbPdAJCLApllqpPxw1NluyNGVZ3SWvne9msHNNfEaerbXVxvpZ2LmPR3aInA4C8l7RpDa2vADAFd4oFynWWYPSkkLufjjY7QbF8fuLDjrvnv8aY/puabJXaye2Uj7rn4mje2DVLYiL+eAgFlA33XACwCMST
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4415.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Pn/n2b1TbXXvRJZ8YGxsrTF4rd6spsaE8zqLKpWwpeYD8XxA+r//zSstCLWk?=
 =?us-ascii?Q?j+IiWeqvy59pV8GtEf6lgp2QwL8uhcmR/v3U85JagzoWx1d1JeB44gHYwcNc?=
 =?us-ascii?Q?lDJf3YGgaHeUeV/ugrXMKVbq3RJx6VQ1YVMiRunb+KJxrPGcWrzK2BjfKVNu?=
 =?us-ascii?Q?SqoRv9M/IXdDZgVMbXTJ7XFAnyTFaa8W00Le3aXKingZiNDq9XJAWdXrKgHm?=
 =?us-ascii?Q?pdesBFnjqGwcclStqV+JDVSL0j4EtteEPhjtmESrhjgtfJHrb4GCc9v9y15J?=
 =?us-ascii?Q?8H7ZOWbmBT8Pv7VasWIn/W69utfsHCM9ww4QDkr3AbtXcrdBSmypVXlQ57qd?=
 =?us-ascii?Q?4JpGywJIZxldkjAoLq0rLRqhHuaZxfgZpTpZNZS/LN/gSzPPGAvRC6+crEgP?=
 =?us-ascii?Q?5lha+ytSZ3adTBzJys7o8wHbzevDcCsBhzjutn0OO43LSvQ4dD0eS32LCxe/?=
 =?us-ascii?Q?BRFiP2bdO4VXKfGqbIqwR1glv0FtP4laeGwyEkXO5yZ/gE1/aAfr7iJPDK12?=
 =?us-ascii?Q?ms1DOksHRe3UaV514Ab0C0o7s3zWb1bvXHFRHiJIthwMTX4YJNLv9bGkU3VX?=
 =?us-ascii?Q?KZXcrLp1/yuoG9IEApZg1hcqZufbG89ev2xz2D0JnpVjGmBHc68wxyVn0S7D?=
 =?us-ascii?Q?sZVhjnJRryxXJETx13rMMqwwwfbkUpn7x8NoomMcGvG31iT6Q07k9m+ubpGb?=
 =?us-ascii?Q?CzP6bQa7jTC4fjV58bVnjrDptd/RewwGMr0JgPZNqsnJS27cLLHiVkQtHxEj?=
 =?us-ascii?Q?J3qP6nHqikU1PRPvTnGNHIoUICTBI+Lww1KGCt1Q36+OVJYC2oEar6Yd1jnB?=
 =?us-ascii?Q?Yo21D/ojSKLxQV1+Ae7nqWru04Ivqyh4PaaEbms9A45Hp+u3bYpthC94yh+1?=
 =?us-ascii?Q?7Pw6zTB5GR62bB4bzh1lkV3hDVj7J2XlyfnlB4lhiEZsE3op/p9Zp5socgNV?=
 =?us-ascii?Q?/bfm6MNJrE0udNfL6q9gye6vv/ENSREOqVHy5whe/KIUQorpS3v8vkIjAqVM?=
 =?us-ascii?Q?9O7FsmHdhI5AlZBfAG79+gS0E862wxTo1XqjCjKzSqzN0h9SDW/lxBPCTOoW?=
 =?us-ascii?Q?/E3Osr3QR8vC7TUaPGLSFs1RjDihIA/9KHrIrqItjfUdMQSsBIRXA3ctdKmx?=
 =?us-ascii?Q?TDcuKK6dJHObEiQFs2sGy0WxfZ3glfWxDUaO35JTnWA8sB/Gf2+NcvnkXCMl?=
 =?us-ascii?Q?eg3kxUDHq0TtxPRJlg21n45tJxGwL6YckI80LWzv1uTtCkSV517dTFz6LFdj?=
 =?us-ascii?Q?yFzZnmwPijFsZ/hi8FLFGNB0dpwa/uZ8JpoPjdZIMcASDPgSQN/zKLzI3zg2?=
 =?us-ascii?Q?Yioy9FE+77YGMK8OsKGfRZptuOqjY4Cr9pdIzCiAB6ZOil6jndrPus8Az+tR?=
 =?us-ascii?Q?yNpH+30r+HLPj8phLPR7L8JBxJw952OZ/7YaUHk3jK4bqOqaJSCg2LvE38yK?=
 =?us-ascii?Q?91RYV/kivZ3hm9pGldMYxfjfAxaieIJnXrGuDs9Po8uuR4sDCxMy7PBiU4i7?=
 =?us-ascii?Q?0dodMwfyUvmwZRyPYLG+rjPN24GRskOERn0jZEX9gfJ3HVFRLCShAhAjIrtU?=
 =?us-ascii?Q?mIB3LE7DAjd8/R6/3lTt59+//G8i3mxaibSN5lOO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4415.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532334e9-8cfe-4d72-5080-08dc3158e9b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 14:41:52.7739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1wHx+jOOOuXtuE3zmIefPwDyKWWFBD8/hBGgXQpjUmruXta5IY68pdHkTkJSAnkSfmdpjfagWWYbO35+DzjpNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB4111
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_10,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 adultscore=0 mlxlogscore=679 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190109
X-Proofpoint-ORIG-GUID: z7_m9nLlqtEohOSSdd-8RO7t20xnu7px
X-Proofpoint-GUID: z7_m9nLlqtEohOSSdd-8RO7t20xnu7px
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=719
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190110

Hello,

Linux implementation of MCTP uses socket for communication with MCTP capabl=
e EP's. Socket calls can be made ASYNC by using fcntl. I have a query based=
 on ASYNC properties of the MCTP socket.

1. Does kernel internally maintain queue, for the ASYNC requests?
        a. If so, what is the queue depth (can one send multiple requests w=
ithout waiting for the response and expect reply in order of requests)?
               b. Does the Kernel maintain queue per socket connection?

2. Is FASYNC a mechanism for handling asynchronous events associated with a=
 file descriptor and it doesn't provide parallelism for multiple send opera=
tion?

Thanks in advance for response.

Regards,
Dharma

Internal Use - Confidential

