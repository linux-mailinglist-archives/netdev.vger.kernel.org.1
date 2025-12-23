Return-Path: <netdev+bounces-245817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3D5CD87B6
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 09:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EA813011A65
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 08:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31CD42048;
	Tue, 23 Dec 2025 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="RYCImb7G"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3DA883F
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766479718; cv=fail; b=PvVEmtvty7XBkghgY9KNetwYPz7iYKikth4JtfuUVV2fgCLB9HR4/NBMhG4ivwOXH4CRMC4FlMWzkjZ7hFlsk2Dp6wfgLCkCZHMFqDhAH+LummGS4Y1fg/io7mz/yKJA2PhSKOSs1UKMXi0feACH03VPIBBIh3Dc2OLAuFo5230=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766479718; c=relaxed/simple;
	bh=xdK6p0rql4slPRVHp/bgnMaQtICkooCrSKAPaAth9BY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YBrNVFZ0eyBvNJ3k3RUsie1gI5E3QTS7BXqwKTJlL+fZ6OSleQT4Ouwysf8HfGto+mJH06RzUFy7gd3wlLyuu6JX22ZYR0FcxJggh0Wp1P0fpO+KfuEn6S2JSKqWEb7zmBuLhI5EFJwA0OeDo7PifFZVn8GVfqW71QhlZrn1UWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=RYCImb7G; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FvvyuEP5CgmWyVQ6myjyZyrbBWUTp40oaYK2f1Bno3DtBH33efR4qAlI6G42UGyBSx5aDV5WbYbVALg6w7wyxH7J20usuUniqIifN30ICaoEQe9fDlXwg2EYELsSZC2kLavg0ANV91J4OVYvfl58ozIsYAMUfXsdkzAzXzoBeRnuF6aEZ2oRjFUpRd5hpX9+bVlyB4/CzGWJpJ/8SQwMg5O+btuFFqxzAphBlBp+/eHBXfMXzt3WqUdRyR37q3j6YBwchZllAYcbYdN1kLLuDivhc7SQAXkxG+m31Uio4hsVJW0bZdT4cyu3hZ6e8RvMaAdZjJieB9GHvgrrlWqVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdK6p0rql4slPRVHp/bgnMaQtICkooCrSKAPaAth9BY=;
 b=P5F+3GrDBGNZ2IR3S8Zud2Q342UubadiMKU4O9m0iye9RhQXD4AqeMFFTdnltbmYvj/j7V/cKaK+Eoqooh2BvG9qmKqBmTbqXkU+ufah9/J1+JjGsBTkeJA3l06udlZivVfzzIGLI/1HXNITW08ye+/YQhgOcbNmOktEyvJDhQokhBajc6ivBvBsWVCH44CVYXQjtezHMk9LeRx/E5TJBp1XzSn3MYmQA9wOaLlAUE3A3eKKxlt/jPeUi4NGomYQTSrllHYWe4UT/JgbQbNSA8hHWAGPwWoXooU7akCeaVC/6FOgyRobZ2m1zsSbpnusBcpddZZbO+SGilxsuZA1zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdK6p0rql4slPRVHp/bgnMaQtICkooCrSKAPaAth9BY=;
 b=RYCImb7GXALYnw5kOfgGK5IyddWN/hjnju/e/d0Bs15CXzQMLUgUi6H9Uia2ywsf2euR/nD80utSsFR3+UD7dsmwjFHhCzE2drcLLXS8/LhtE5EPIBZ4sWtAc+jLjo+BR8xC33v+uCCAn3rQAiOnZt4e0P7wFjdi4wDpQIvQVyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU2PR10MB7908.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 08:48:28 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 08:48:28 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>
Subject: question on gswip_pce_table_entry_write() in lantiq_gswip_common.c
Date: Tue, 23 Dec 2025 09:48:26 +0100
Message-ID: <87sed1shwl.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0064.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::26) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU2PR10MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 568ac535-6baa-4cde-890a-08de42000afd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0JCouqK/K15qrVfPAtuioRxXDIYF+226KWj3Ti+axQaXhb4OqWbn9fmBPyWG?=
 =?us-ascii?Q?8mh1DU6ZkIe9RrSedLbKtyrTE+f7C3vM7OduWyXKEFeDcGeLbwBtLSYVyjLd?=
 =?us-ascii?Q?vTEenjwdVaeNXcjzwlQ9N6TYDrZCksMvwGNK0z8HuYU5VFwNk2aPGfDdsYPd?=
 =?us-ascii?Q?68ekDId143D+YhR0RXrTKow8zG7zerWgYaaANhhNxjRJd+d9+ZLV4SnPIewN?=
 =?us-ascii?Q?Lh6ODCiJY7GZN1xHe0WEKjD058No7UW8ioNQ8IIjDC/ykl85x1/FKOU6zDb2?=
 =?us-ascii?Q?JP7iTGeWOpNFM4buwxp9OO+vfjbw/4qwyAZWUqjnfBmWTuICI5gh9HLZ95fd?=
 =?us-ascii?Q?qbyrXc66wKCWgRD0zyNB27oZCHXyxYkZp3XhBpL3dV59kfYbq5G2YtfJGrfn?=
 =?us-ascii?Q?AoxwDOXQEVuD6i+8G6Yp5b6i7CL/z7k7NgqiGcP27hh76USl1tRGFG9uGZCC?=
 =?us-ascii?Q?72AnAAsqOEYaHvGCsvyBfirkOQz2VZcrx8ktE37yCw/B4Mscw2+NtOV0n2Xj?=
 =?us-ascii?Q?Q3rwCsYBnqM6Vrdx0maV0lqLxOBN6Hn1v3OrjcKwAUtv+TnUqDW28J24lc+v?=
 =?us-ascii?Q?czN6saFvrwCO54Vt5F95Y7K2efaQHo2LoLJbH+gEgtWPpAZT5SRuA2blLhn3?=
 =?us-ascii?Q?XZgR1ZzkbnbuXvW/pwG7ZOUO69rfZ5Aj32JuHDxVRzb+YP1sSVovb5B1WfIc?=
 =?us-ascii?Q?NwH7gdTIyUW2PMMdqfjolL6m/9idLF2KrZCqAbAQoec1fr29bBV1s8X90ZA0?=
 =?us-ascii?Q?UuY7fElEX3fadrgkCAc5D+0I2I2CLNtXu6QN60FK5JqJvBttBrm9WRKhVDQu?=
 =?us-ascii?Q?DlBtnV0oHWK1O6+p9inc72sF3co4+yMvZGMGh5DAKcbacKbgI2QW8hy1gkXZ?=
 =?us-ascii?Q?sTAT5TAqFb0TkQ+1cnJvMzaw+Q9BYkNP67m6pTXmIxE3gwmxNR1MRFb49AG0?=
 =?us-ascii?Q?wZUnjE2a1nYcwMSuuwU/C+iliFduCC+x4rhA5bFDOu/0t0gHcAHmEXtZ2R/x?=
 =?us-ascii?Q?JRU04yR/YB4sKhz/Ld7bQPW8XMAJyyGXkhIOlHFDS8OUkb3PlumdslO03euL?=
 =?us-ascii?Q?tMvQi+4yxMJUwt8Rjuwyq7OolkKz8Eu5B6tvCExgd2CmduP4jTrPoOcOf1gb?=
 =?us-ascii?Q?eRMckE1Iw8lcZvb7ifDMpzUp9DdH5jJImySkM4GbQIY2qm0Wx3jklJd9p8Cr?=
 =?us-ascii?Q?AoOGOp05BH3cKtPVyzeQhSvnqYm88OL4wOr/5cwRNsbxSk0+S79L0ILPNftz?=
 =?us-ascii?Q?Gc2tqesKSFUFap69h5F129ifPivDRELVWDqkhbrsijqIWA3sFnNlEotrGAT4?=
 =?us-ascii?Q?jSujbH1me3fVmsBBAqrblsRGvLgAOPGV7d/AuH7cfIRWwg9FXThHTpM0d0dG?=
 =?us-ascii?Q?a2DQIt3RME8lIYZHEbAz+xIRoXsCSWfx1iUePGdKurXpFYpP/gYNHYDvzkhS?=
 =?us-ascii?Q?kBBNlniFW+mCdKSODSbjZYNsgaycs4HymLRbU+PttueYoFVFCWMfhcy8/DAN?=
 =?us-ascii?Q?zupesDO4agx7s8SBVtKDLTHuO2H/CHQjVM8w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DaGqjXXZHyTygExcbIdKVWaHazXVUPvH1lfnLCMIo4swSBZqYSItAug6iqec?=
 =?us-ascii?Q?+iM2IUmXrZv4K8kcAKDSu2mBl4QbZ1wDDZ2kZ/l8Wwgy8Mg0EnhylzX1Axcv?=
 =?us-ascii?Q?rQLFYlkhVMx404dVGqwTfake/tzik9JSNygqbLUlJCetjGUoNRrgtCxNNUsT?=
 =?us-ascii?Q?Rc2knlb91HS71gvQbjRitSLRAcHj8NW8x1JJpEcN2entJhPD2t587fTjw1zC?=
 =?us-ascii?Q?O5DdZ/94cbujqUE6VQONqzUyOdhqp7TA+/ar6fSlu/pImn7JZkUYDBbJjhmy?=
 =?us-ascii?Q?sHfOqZCJSXMhPOJH7j5P1815FX/06Q9xRsqDH8zHcx9Gy1qiaGs1+HZlGHL7?=
 =?us-ascii?Q?8wPKeqXwC09LcrGUueH0vVqIh+8UfYfG2XvT+sNNnJV8oHZVKFdrox8yw+1L?=
 =?us-ascii?Q?0RlU74NbUJv1L/o/7+fHoxzNGEe3svwDntqUh5e5YzkNhv0mQjwvoNYsN/x8?=
 =?us-ascii?Q?Ac9ZjhN6FaSxcFFPWHXARm2xrcd8M0lJYJR37P8A+wboYXK/3doUNZ8OUr1O?=
 =?us-ascii?Q?AIFwHnmwLe+TUjF5oyHVYBeSOieRB5YtaeO7menL6nXrRbl6EEXwKN8TfywK?=
 =?us-ascii?Q?rxmEtZDxd+MZpOSbX93LuU1MHunYz/jOkfVwB3Kl1G2kzoTTEBA8N826Izkc?=
 =?us-ascii?Q?4wkSKcDGcDt6RDToBLzxHq8JxA0EX9yYzYacQHhYW+IdVWldCBY6CiKlWm9d?=
 =?us-ascii?Q?VceSoXQW5j7VCAicXNSUumg0+AcbCN8demInHv9x4zaPy9sXBwTC4d8SHCD4?=
 =?us-ascii?Q?Ue2Muwbknc4287sAfi+6/47IDhgTNijVfK+b96Tmh5AaXv93zDL6TgeWBHh1?=
 =?us-ascii?Q?hEqwEbeqIxJYzzfpgX+AZWVvROJxX16QzdQE9/tMZrm5C3qQIEdeGH7NRZFS?=
 =?us-ascii?Q?vOkwB5grwbIZTCB6qyy2qIHxKQMoXi7m6m9iOuKnWWx93jAtf4DsDkufBnDu?=
 =?us-ascii?Q?VTTCl7oiqIV+FvCKiNkPrS8RBn5DR3zVN58G7vWM5/jO3XHtWG3wA0RgHz1a?=
 =?us-ascii?Q?ak/caoqovopr4jfG0z7xGoUWh1V5dMk0KgDDQfBiwDzJ8giLLBqfvdkg5V0m?=
 =?us-ascii?Q?HvYtCQTu5bSJJcpark5ZByZebCuqzesKtMqlWoVR/XewsQSszpx8KR7kjEdh?=
 =?us-ascii?Q?lr3VX1z5KNhDhcR2Ca+iFopTQggXrNX/w4/u+W9XDUK98iuQe7aO0ceb131F?=
 =?us-ascii?Q?bm3JQXgjB/xxSyA2hlj4Jzr7STtkY/SmwNrPBwn/kRx9Gs/5vgpQIYmW8eJ3?=
 =?us-ascii?Q?GMVzcFw6kM+wcCncbVC51OrAjNp/ggrE3temEX2MoWZqSsbpYcJc+MgthTrW?=
 =?us-ascii?Q?Ml51hgs0uyFGUMakBfHeoj1qfEK55chu/WMeH3+7ACSKxQd2kItS95eX6vXZ?=
 =?us-ascii?Q?815pewLdOwCAFT4VhlhFWeSzXTABrxlxdDDI/Sl0bYJLaTqgaeAZOlzAn8gp?=
 =?us-ascii?Q?8u/JPgXdOF/RDZE5YMUmZtSiW5xEYytoKB10ArNfyH6RbTGIa8oMKFB5gZbF?=
 =?us-ascii?Q?wXy4mbTqfgxufrSkNxwDvqbZ5bxT3DAfkeJWYe6gGS70RCS05uONa7nG9GET?=
 =?us-ascii?Q?Y0018CDyFJ+tBORpNjVFI+POS+gJjIzq/wft813wHrd1ek1Gl88r7srs4plJ?=
 =?us-ascii?Q?S8pOge2NKwuDLMmvc68dkvES8NRY4vQh0ndbMosMGOTPq6clqvuKVNDtgsX5?=
 =?us-ascii?Q?Jg9Qom5nMOnjqrrb4C1+IesanY6qLN32aoIJkBAbX8iym639IkZniy8dnTRl?=
 =?us-ascii?Q?Y/HxeJfHA/0EAuUreZv2SgIBYkE5JbA=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 568ac535-6baa-4cde-890a-08de42000afd
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 08:48:28.6235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLhV/GTCGR4X+aODb/eHay0R25CKPZ+TqaG6CMufzPPs3y1em8Qnhu+DsBZ7AqQINzb33f2yiiTaviwKbuz2THVezUzLPsTeSkvev9rN9YE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7908

Hi

Reading gswip_pce_table_entry_write() in lantiq_gswip_common.c, I'm
wondering if it really has to do all that it does. In particular, it
seems to write the same value to (a subset of) the GSWIP_PCE_TBL_CTRL
reg twice, then it reads the reg value back, manually tweaks the
remaining bits appropriately and folds in the "start access bit", then
writes the whole value to the register.

Why couldn't that be done by reading the register, do all the masking
and bit setting, then doing a single write of the whole thing?

The data sheet doesn't say anything about this complicated scheme being
necessary.

Another thing: I'd really appreciate it if someone could point me to
documentation on the various tables, i.e. what does val[2] of an entry
in GSWIP_TABLE_VLAN_MAPPING actually mean? I can see that BIT(port) is
either set or cleared from it depending on 'untagged', so I can
sort-of-guess, but I'd prefer to have it documented so I don't have to
guess. AFAICT, none of the documents I can download from MaxLinear spell
this out in any way.

Rasmus

