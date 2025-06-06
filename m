Return-Path: <netdev+bounces-195459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E35AD04B9
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 17:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C937164F18
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0870289804;
	Fri,  6 Jun 2025 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="eBaSOiDl";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="Cy4jIL9f"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0024c301.pphosted.com (mx0b-0024c301.pphosted.com [148.163.153.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3031DEFE0
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.153.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749222267; cv=fail; b=MsWxQH/srQKb4RzrXzpkhs8KvtuK6ebfqwUn4Zogo0OyfgRmAdfyaR+dHWTB/QZjTfr+RXuD4Ii+KA+nSo1dGBQdrZaCcvRkdDaPSTvMf3YUq19TDFYOkzCTNhpz+rAuywpqcRLuwC3ikDiKuac0Jew87Vop0SdAJO2lTHlA5aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749222267; c=relaxed/simple;
	bh=e2BlGpSExrHsZ5JFiACDxtwy6oC9/CbY7uMOoJUpCgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b6hjBx9PYLA203Dl9AA42pR6VV7f3mOVD9+zLIyShUUyIvRcME2g/MhFFN++e14AtF+H/KVYQs8GG5whs/NKaTrwugSfvQ0X0qnwfQ0+vBF0GZHa+YzeUcPLt0Skt3lnH8qT2D27CWk9iD97XL5zl/TqFVYki4eujaiB9nEYi5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=eBaSOiDl; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=Cy4jIL9f; arc=fail smtp.client-ip=148.163.153.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Received: from pps.filterd (m0101742.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556E9uO9029287;
	Fri, 6 Jun 2025 09:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps12202023;
	 bh=CQ3EsYmV6o1B5ANgpD/LIiu80uRYGOe2XRznaxMDoTI=; b=eBaSOiDloMeS
	h2czPiLy7ShTRBf9CIc8oqciLSe4RZ6/bL+xR0N6m3YQCdfXGQnLT1NPCNp3ZMQh
	HgmeUxqWOw/XZ6t80Og0+YURKARHqN+pwnm4PxBV5ng9SWbydRqp2o9TnBVqWRRG
	T8vndpfSqYByl0e7AONYnFhN+R8LfzXKrmqtjfMZFtqPFq1N8dxunfk3eld4zF+8
	GN6HwkmvutYHmPKXOfzcirDjabRiA8mZpa/JHy9MBdCQiOgzB+XLhW5eldNjaEqw
	xNo9GkyRNjEqd3G73pOvmSaX3ZjeQKFhyzOMEHQfghsI4OmpMpszXsoy/KsMNek9
	/zCqfgGDHQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2109.outbound.protection.outlook.com [40.107.94.109])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 4741uur27u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 09:42:49 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H38tJF+bOYXfrHJZbHRse6rd/JaZ/PVYREZyAEqxTvmxQdjXoqTmf4oozIAo6cSFV7QQyNysgAV2v4rcgQQqNW21g/YB6rBaFDxNNx45rGNiEHEBX9QvV0lQDZ2J9oYAu9yAlyOPz68jgZK4fUTufnQFaMOLR0uwYCOT0TboPmPLmti5kTgmNprPjfU/c3T8wEqiBM9/cTaOn0cgGRR3c/iUs7Y+XDOAz+EllrO4EN9ti+PdYfhJigaulj0rJYfbwJDgG622OCxbZl0badujT6p4tRwUhbTLM3AL7OU9pYH47tqLDwPcHRrz8wH9mtoC18rdscscsH49hjrk74fBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQ3EsYmV6o1B5ANgpD/LIiu80uRYGOe2XRznaxMDoTI=;
 b=VaDhuchdVKRZoPEcY1SzoqXhITb9sZdNCj42C6FWxuTd7qLTiHAMOY8qZ5YTX7lvfASw4qHgU6MzRem6aDrarzBLOFBY642HeOZHZk8Blnh7Ib/w2q/jr3Aw7U7DHr+SBgXsyIwzUqsiRVC3d8fAlFR83TX26zpivmf+Ww3e0JvU+jTedIA27qikRNYolW6F4dBkDgddyA9xCsEByXagYB2RuZo8i3QCKSfy/SJeiZoehvUxF2XgMIcWdlzIpY/Ml3bHcrEw34zndibCAoVTb6GinL9HoyYLAjHcheHzRYS0ItVm4mZfRvsp92CiqdRefLwijCWUAT9cOUtpgB/zyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ3EsYmV6o1B5ANgpD/LIiu80uRYGOe2XRznaxMDoTI=;
 b=Cy4jIL9fsje6r5LWTk3u5U/lFnh5LSMiZFRHLpazrXRmxI+QsXBJCqwvjgck6VwWj6mZWF4nnRs6Pf5lJuI3GADUOs9bpQN/POm+xhxoRPriO+KJ6l95+bYcqJPj3A0SRfWc24XziEC+A+xl0bYSuM9FR02Jr9PnKZUqrbQkLOA=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SA2PR11MB5081.namprd11.prod.outlook.com (2603:10b6:806:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Fri, 6 Jun
 2025 14:42:45 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%2]) with mapi id 15.20.8813.020; Fri, 6 Jun 2025
 14:42:45 +0000
From: =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To: Petko Manolov <petko.manolov@konsulko.com>
Cc: netdev@vger.kernel.org, David.Legoff@silabs.com
Subject: Re: wfx200 weird out-of-range power supply issue
Date: Fri, 06 Jun 2025 16:42:42 +0200
Message-ID: <3711319.R56niFO833@nb0018864>
Organization: Silicon Labs
In-Reply-To: <20250606140143.GA3800@carbon.k.g>
References:
 <20250605134034.GD1779@bender.k.g> <2328647.iZASKD2KPV@nb0018864>
 <20250606140143.GA3800@carbon.k.g>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: LO0P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::20) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|SA2PR11MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: db1a2966-7c3e-47cb-25b8-08dda5086676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?eKn15OjKVnCpYRyMgN7sZ9Z6tPjqLqWMWH0zMrkjPvsVTc+CijrxrZHcz6?=
 =?iso-8859-1?Q?6nE8TGOZMT7b4vjeVr9xxTaeSuvJQoUTmW0fFWPU/KGw3qv6kY3BoOsoD5?=
 =?iso-8859-1?Q?fHh3RSEo9Hxg+GaHpR/j2yyLWjiwxjLmMa7I7jWB7N3JcJpZRWIRZBD4m9?=
 =?iso-8859-1?Q?Wv7YZri95qIIk0vZx0JXSeHds8FunqIkfbPfD6gACpCvODC8yFri2MoPkQ?=
 =?iso-8859-1?Q?m/X4lksXlWPmfDToi4VNRX2D67/+psZa8zABcN8WUzH9JFZBN7s/IGdS2i?=
 =?iso-8859-1?Q?yIuIxrhCjlZSUu0tsIFv7BK1K1qsjlafyf5q6A5X3IJvfDFQqh62GX4qYI?=
 =?iso-8859-1?Q?DP+zlryjWHUckVqy9gj7nMxmS8BL47uRCJK/NfxwgaGifwmjH/68PHcctQ?=
 =?iso-8859-1?Q?25L/uHKJXIWDd4JzGFF54rGLoVv2evuy2liIJVHGqwwG4ZrV0rU1CB1PGk?=
 =?iso-8859-1?Q?RDip7kKn1BoqB3OnPK+ytXXFuY26VdLkuxUbUde7QUk4Z6sxdSMtohh5Ut?=
 =?iso-8859-1?Q?tHKgRPhCOCe03bvQ5I16a4sGKDvw/DhtrI/p6Eup5BqMeEDASMDBWK/xEH?=
 =?iso-8859-1?Q?8RyQn96P21dMyHMYMX2uck5hy9naRlw9NS0hJ7u9Tb/z1v2Qh+wfmTEw8q?=
 =?iso-8859-1?Q?qVfYjz2tX2e2UCzZabsGN7VxQIxTInb7WTJKtdYwKcBVIl+VMNQNilsKJy?=
 =?iso-8859-1?Q?V00urV+wk5o8WX2Fz88f+7aHLkYWbi+VRvQN1m63LUIjd56nPZVhVQTi99?=
 =?iso-8859-1?Q?xTPkwlgB3Q1tpEbfWSIg8xnwZCXc34nGm+G0g5LufBaOn3GmSbr7ERLcYH?=
 =?iso-8859-1?Q?kYaJrCfbqq+/g7S1Fv5uTM9dXhpid2ZH+eKBsW/szIyESkd3UlY7u8QV6a?=
 =?iso-8859-1?Q?t6W+dHnIl8oi5kbJVvyZUYju4rMfRLjE+MqvYAangH0gjC1RzComOoQf3W?=
 =?iso-8859-1?Q?xteazgd7mGPvNDYeGUywCcIMO7oUzLNJXJPFZNCd7aRERiwGK2mYupfOn3?=
 =?iso-8859-1?Q?8Rg3rgLf2syeQkxl/Fj3ps7c39g//W3wzAAHNr8fy+pIgLj/kwlwobPOhR?=
 =?iso-8859-1?Q?EB9xP0+OYaHXGvc9Pipk2IUfroafaUzs2KUF/uqAInxhcPZ2yFJyoxdnnF?=
 =?iso-8859-1?Q?AQB4vxeDHMbXBrzXxhBK1JFzCx4Ddix5TnkkGZOE6wKgXZqs6G/FDrr2Ak?=
 =?iso-8859-1?Q?oFSF9bvXB1a68KT8IXrh8bIu6T9Wx0qnxq9aZIo4silPy36467L67bAejB?=
 =?iso-8859-1?Q?ROljRFs8ZmcfaDH1z+49e0a5/Js8VenEAZmQf1rYJJxRBeCCYBnd+Roj6J?=
 =?iso-8859-1?Q?ik6NAy6O4mqVqfDnpH+J97b3W6DLcNmODtjHMbz5ZuKyJSacFO1v89JnnH?=
 =?iso-8859-1?Q?+n+akwMh6/s+RGbJ1dxrPkum7uA58DxvXrGliEfoH8y2A0RiejlQbwODAT?=
 =?iso-8859-1?Q?bGTSDSLwBq29lqBvKWrtu4+6L/G8kQlOuqem0AhD6i3VJy219oDwri8xO0?=
 =?iso-8859-1?Q?iCKYJ+468u3x/mtQZmAlxWCyEDAO5CeUsLQdr4/spSp8oXFSUsRXQh3453?=
 =?iso-8859-1?Q?yQbMenw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?3uSibxQZ8E+ArrQ8yqpAAFYCNtn/LQ5p7iTyiwBvw830iHY0GNeOUopf0R?=
 =?iso-8859-1?Q?fYZIazQ6suaLGlEjzG7w8jZshaFhi4GLkZ4Od6qFmx5P+PpSlbLGbcPrMC?=
 =?iso-8859-1?Q?zXV6iKsqgurxDmYABC9K2q7kf1a96Wh1nXBZEpMDgDK0P88jMBglWeRjaR?=
 =?iso-8859-1?Q?n2oP/GPYIVOg/+GWJ5b96rzdBuliYLfzdzeXYa7UHKJnN8Cs/np+9bF4dT?=
 =?iso-8859-1?Q?NZMbkAoP6l4EWTKAXfOsRz2GVBIRi1oMnrCTme30Rf456luIOVdnwTpG1M?=
 =?iso-8859-1?Q?KJnuXJTEWZzbqMU9SBot9kNmflpLpoZaUuJ+AFNb8EGgRq0tBRILbrm+EN?=
 =?iso-8859-1?Q?jt7ZoSD1TihsFCz+GqclX/f9maqTHHhZ/crEv5/lB85jUmxqJ5xF791VGY?=
 =?iso-8859-1?Q?H6TfH483gVe8YnXjtJkqYP/sKJb1KJM94ObphPWp6IgWPlVp//kX4fb2ZI?=
 =?iso-8859-1?Q?jr+wY2i83arLi9sIi7UnXJPl3uoPHCeRsiMtk+nSu5EJ8q/vKi6n9yC4+J?=
 =?iso-8859-1?Q?8XqBMAEo4/5t60u53MuFyHIVhC3i3AIFjoUUGu8vkpVA9zKauD+YMvSE/X?=
 =?iso-8859-1?Q?sO1mKi6zNmRUMc61clQ1frKkrSgmJMR5XC3kORgJytDqjiHyAdaWBGBCAs?=
 =?iso-8859-1?Q?UJAeF52eNFrRrnHjr90hp/Lg7Fdqbm11w5PP3V6Jmg50VE6ijc0pNMb/de?=
 =?iso-8859-1?Q?9U5kR7n9u03jUbCfm82qBtm0kCkheI02z1fVDK3I4ZVOmEJryEGi8A4x2r?=
 =?iso-8859-1?Q?8868LF5bmY7/SGDnwWk96/i/loeuRNbf487qI6C+K0ozUnI1osk/V+xizw?=
 =?iso-8859-1?Q?ibT0OdJ8ZjBm5xOy9OKJcW85XvCFsvFTKPXYrRT+1VoBAXsxN0JDPW2XmF?=
 =?iso-8859-1?Q?VwTpi3P27UjrZUsvou2Wbz0A4lhTRMIYf8tV7BwDjjncwEYAIPs2oj9hRD?=
 =?iso-8859-1?Q?UIE7ogq8srrfRDrZr2YOR5MFJeQ8ZdbSt6cTfob05opxRb9Exp0PSReJqk?=
 =?iso-8859-1?Q?M/kHBmJPWjkctkJ365qzcxnUtNmvCSuhdm4esIBSLFCcQoZcv9fH913hZU?=
 =?iso-8859-1?Q?/I2d6lsBO/1NbAHkbacijyfpPi8vn6e1k4HABr43DrSMg6SIkZUzaKTdiU?=
 =?iso-8859-1?Q?sZvZdTDGh2NNhRUtdE4hAz2QRvruTBZWSnsWj+HBaV3yQ+68xwP80gIBNP?=
 =?iso-8859-1?Q?/cidagrgyabluOvIsR7tUqE7TqZQBjAMXZouMiRp/JO9daYhHCbutZ14UT?=
 =?iso-8859-1?Q?gXE1oRiununZ0mJduYEjZx7gHy1zvEo3eY42KPCnJw2mSHs3ehL/zMuI3c?=
 =?iso-8859-1?Q?hR0q9T5dLW+cKVg/mczOLAQELft7vVHUb7ZHtKxMqRnnW0KCm06WMQK+aH?=
 =?iso-8859-1?Q?x4KvVezM1i4vbcNGnYpi0Q6i09N3ZbR+ghM286hYeeZY0nx8phuHvL2A2c?=
 =?iso-8859-1?Q?XEbiyjG3pFVquYcb0RRtYvCOXpQL2iEJ6VqgGPWWc0XjyBRtjbFEMHDCAl?=
 =?iso-8859-1?Q?cpysfX1JlFkrlsypooe9vsYDem0BU49dz3X1o9KsTVD1PNii621Qo8+J37?=
 =?iso-8859-1?Q?iV5RY1n0yd7cmTDm6emArKD0809vbrBbu+F/T9COoN4tQIyh9ei4if1xQV?=
 =?iso-8859-1?Q?iXdWkl9FHUKBIva5fuyrVKH0YMkAc0rxHq?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db1a2966-7c3e-47cb-25b8-08dda5086676
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 14:42:45.5762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R8lm1wmROKkHuxV3oHDwviOWEBqdK7dBjGHld3JOeGuJWEn2QW5ov3nRGjkf84npkiPVAE3c6Uv+a2jbJ/5Lig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5081
X-Authority-Analysis: v=2.4 cv=M+RNKzws c=1 sm=1 tr=0 ts=6842fe69 cx=c_pps a=Aw7NL8YgY1wPWxdbGT6CAQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=LLPZWm0_0O8A:10 a=i1IsUcr2s-wA:10 a=_l_WdRKfk06JTB67y80A:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: 1H6QaW4BWsXEFtPGMifZOyUuh6olk5BN
X-Proofpoint-ORIG-GUID: 1H6QaW4BWsXEFtPGMifZOyUuh6olk5BN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDEyOSBTYWx0ZWRfX/VkSZVUpcxk6 AI4k8EU0eRallQO5sChxZ8uct0HrAkMsTwXQKgAuPv+LBFWOliojM8JITJzq25bvwzrWGw9P3bJ 0PYSv5ge4jgspYfGMesrakWDlSqS0x3/825gEO+C27yY8wxwRAy2uHdXr80/5pFfB5SbvBNFN0h
 3J9lbe+Y+LNtBPYIw7DqqRSw0+cU1vVv82nwkHawbNrIh2GRfs8rHxfzUzVHAJJG7DyjPVqos0x 4n1nD2G0E/Pa+YSh4oNNco1StI5Esma51+AM3FENFihfZGLmu4eiozGhILIn9h5nyMOXiNFDa5b QMJwk1sdkYtFUUwf0Im9tEn2rf6s585UnX7ovzeaDOZ069pfm5Boo8A7PxZ+hAkiAeSpEYJX8FW
 AtPkLjtV93mFJ/QfYka4yOgcUi83QzKoOqrWgp+X61PcScaAUR2+nKAUaTqsivTj+HSL+/P5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2506060129

On Friday 6 June 2025 16:01:43 CEST Petko Manolov wrote:
> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open attachments unless you recognize the sender and know the=
 content is safe.
>=20
>=20
> On 25-06-06 14:13:18, J=E9r=F4me Pouiller wrote:
> > On Thursday 5 June 2025 15:40:34 CEST Petko Manolov wrote:
> > >         Hey guys,
> > >
> > > Apologies if this has been asked before, but i've searched and didn't=
 find
> > > anything related to this problem.  So here it goes: i'm upgrading the=
 kernel of
> > > a custom stm32mp15 board (from v5.4 to v6.6) and i've stumbled upon t=
his when
> > > wfx driver module get loaded:
> > >
> > > wfx-spi spi0.0: sending configuration file wfx/wf200.pds
> > > wfx-spi spi0.0: asynchronous error: out-of-range power supply voltage=
: -20
> > > ... a bunch of "hif: 00000000: bc 04 e4 15 04 00 00 00 ec 00 74 76 f7=
 b7 cd 09" like messages ...
> > > wfx-spi spi0.0: time out while polling control register
> > > wfx-spi spi0.0: chip is abnormally long to answer
> > > wfx-spi spi0.0: chip did not answer
> > > wfx-spi spi0.0: hardware request CONFIGURATION (0x09) on vif 2 return=
ed error -110
> > > wfx-spi spi0.0: PDS:4: chip didn't reply (corrupted file?)
> > > wfx-spi: probe of spi0.0 failed with error -110
> > >
> > > Needless to say that v5.4 kernel setup works fine.  The only differen=
ce with
> > > v6.6 is the wfx driver and kernel's DTB.  Now, i've verified that wf2=
00 is
> > > powered with 3.3V, in both cases, so that's not it.  I've also lowere=
d the SPI
> > > clock from 40000000 to 20000000 but it didn't make a difference.
> > >
> > > By looking at the driver i'm fairly certain the above error is actual=
ly coming
> > > from the wf200 firmware and the driver is just printing an error mess=
age so i
> > > don't see reasonable ways of debugging this thing.  In short, any sug=
gestion
> > > would be greatly appreciated.
> >
> > I believe you should have a trace with the firmware version (starting w=
ith
> > "started firmware x.x.x"). Could you provide the firmware versions?
>=20
> Here's what i get with the new firmware:
>=20
> wfx-spi spi0.0: started firmware 3.17.0 "WF200_ASIC_WFM_(Jenkins)_FW3.17.=
0" (API: 3.12, keyset: C0, caps: 0x00000000)
> wfx-spi spi0.0: sending configuration file wfx/wf200.pds
> wfx-spi spi0.0: asynchronous error: out-of-range power supply voltage: -2=
0
>=20
> This is with the old one:
>=20
> wfx-spi spi0.0: started firmware 3.12.2 "WF200_ASIC_WFM_(Jenkins)_FW3.12.=
2" (API: 3.7, keyset: C0, caps: 0x00000000)
> wfx-spi spi0.0: sending configuration file wfx/wf200.pds
> wfx-spi spi0.0: asynchronous error: out-of-range power supply voltage: -2=
1
>=20
> Apart from the error number the rest is pretty much the same.  Both dumps=
 from
> using wf200-v6.6.pds (attached) as the old .pds won't load on v6.6.
>=20
> > The issue appears when the driver load the wf200.pds. Can you provide
> > the wf200.pds you used with 5.4 and with 6.6? Normally, you can't use
> > the same file since the format has changed in v5.17.
>=20
> Attached you'll find both, old and new, versions of the PDS.  This is wha=
t i
> used to generate the v6.6 version:
>=20
> pds_compress -l BRD8023A_Rev_B01.pds.in wf200-v6.6.pds
>=20
> The old one used '-p' instead of '-l', but this is due to the format chan=
ge, as
> you mentioned above.

Things are going to start to become fun. Your wf200-v6.6.pds is exactly the
same (same md5sum) than the one I use for ages. So the issue is not on this
side.

For info, I have a setup with kernel 6.1 + firmware 3.16.0 + Raspberry Pi
here.

Do you think your power supply could be unstable with your new DT?=20

The voltage values reported by the driver (-21 and -20) are obviously not
correct. Maybe it would make sense to get the real value measured by the
chip. Do you have access to official Silabs support to make that request?




--=20
J=E9r=F4me Pouiller



