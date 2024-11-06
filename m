Return-Path: <netdev+bounces-142196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424D39BDBBE
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 03:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D3AAB2309E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BFD18E03D;
	Wed,  6 Nov 2024 02:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YiYLyWlV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52E815E8B
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 02:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858586; cv=fail; b=gkxC/kHKA3eNJGRkBmfshdQyiz+cUL5f7A4UAhvqSJBiidp9ygyJXxwTyFY32yX5iPwkORAEdMvIxC1iE/2EoErKxSvEFwFDs09eYH1hs1HrAZpKPg68AHeFr0FPY160ZEr4iHrs8nyoNSCytGdQznZu7xxY/UEMGBYo/Boz1b0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858586; c=relaxed/simple;
	bh=cdeBSuIVmiI3Ai+2u81Dp95Q35VBOtK/SXMtdtcJfIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=DyVgXc3eQm5ciHu5M86pt+HfpzyPfP70QmAYYqoJAi3DMs94xqcXZ0QkWF+IN2obMjhVVuJ2jm3IJ4iPDKa+mTTFokiefQTL92YEaEFWun/TEFOjedU+nr2yQ+Eou/DlQLl6d7lvAgdKzzlzUVL+1kL2uGZxkRJyZgBknT2xBVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YiYLyWlV; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ge5jsCp5vYaS4gzmm9WB9K87X03FZFM7tzM9xOqhWmSnG5PrrenEU/8jFqWSCAA5gRjqzWuD8YpGTamceNLw9zyQWx5IR9l4RWafRxfdRTtHtPpGMdJP6kTsZqom6HEWnalf19+IIo7y/FaA1Vp5hZ/ExgZaYzlkkVi71e99a0iKCRvm7V3mXzVCtkZZNURRU4M+il1zLIdckty7nvnqqLX/W4qP6vdjTSfYPSnreT0NazZjpvXf2vdJYKTvkCZDMJE+wFN/XDIzVjgi0Bst2ZtRhSZ0QYCKzzVrF49snpGhcxVq17IEyw1FGmFDREg18WFdX6i+KE0yL2Liizog6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6F27vNRgkYTa77BS8beVlbdcUN26zeqC/Wkbq6Xa8hg=;
 b=y1BHvSNDAMht49I9ovHqnAhl6cL3sT7oyIgOglle5Up0IP5ihg6GeFlGyOqalgJvw3z+n3+hmAPz7NTwShVjyFd1hdGNa9cRK8dfKw05b/wNuRediPYNJlgHmZ/qt1oc13xnDJWJcoWngYeIRog1oSQ2ke+Opx2vbqTthQbzXe2dTCSd00QARBDlkXxo841OdRNWMaekCrgbqmnzAjyFS+8SpUiLF2Th0kJfzGrl0CiYfZ6Cr14pI2ARaP6Ly7ms+7HhZudvLM1AI8eQoFSHNd5E67i+CsahF+grI/Au1YrWKPPyWxr4QCuFd3bSZLMxu7FsYQA3eScz7o8pJULUMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F27vNRgkYTa77BS8beVlbdcUN26zeqC/Wkbq6Xa8hg=;
 b=YiYLyWlVquX+7v8nFGisYrpkSW7xlQD871FfMP3VDV45KjnUdWc+M3haco6uELrdXIOIn4PJ5+3U2CICX6UGP9M7D73fXvT0xTd5VLjUdvGTmuJ/r/H1IO/3cysbcNgYpEt6L3bwlWQJwFvGKIEvVm56dAmt6QgPvqet+reCQDLdfqqW3+/lkEXG2SghwJnH6nvqDqyok+WlhN7XJXN15RGLS9eolwObPI0ZVeA3mje9kGJ4LI1unpr/8D3GpmqBjx7lrqcwoY69y13NDOuQZ/YbN7nMdjSwbvaTvHMyFVcIP3O9D9BD/XN1nMTbUo2BdbtSxGp+38b+7yaP+baMIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21)
 by DS0PR12MB7678.namprd12.prod.outlook.com (2603:10b6:8:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 02:03:02 +0000
Received: from IA0PR12MB7601.namprd12.prod.outlook.com
 ([fe80::ee63:9a89:580d:7f0b]) by IA0PR12MB7601.namprd12.prod.outlook.com
 ([fe80::ee63:9a89:580d:7f0b%5]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 02:03:01 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: Gal Pressman <gal@nvidia.com>,  Jakub Kicinski <kuba@kernel.org>,  David
 Miller <davem@davemloft.net>,  "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,  Eric Dumazet <edumazet@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Richard Cochran <richardcochran@gmail.com>,
  "Woodhouse, David" <dwmw@amazon.co.uk>,  "Machulsky, Zorik"
 <zorik@amazon.com>,  "Matushevsky, Alexander" <matua@amazon.com>,
  "Bshara, Saeed" <saeedb@amazon.com>,  "Wilson, Matt" <msw@amazon.com>,
  "Liguori, Anthony" <aliguori@amazon.com>,  "Bshara, Nafea"
 <nafea@amazon.com>,  "Schmeilin, Evgeny" <evgenys@amazon.com>,  "Belgazal,
 Netanel" <netanel@amazon.com>,  "Saidi, Ali" <alisaidi@amazon.com>,
  "Herrenschmidt, Benjamin" <benh@amazon.com>,  "Kiyanovski, Arthur"
 <akiyano@amazon.com>,  "Dagan, Noam" <ndagan@amazon.com>,  "Bernstein,
 Amit" <amitbern@amazon.com>,  "Agroskin, Shay" <shayagr@amazon.com>,
  "Abboud, Osama" <osamaabb@amazon.com>,  "Ostrovsky, Evgeny"
 <evostrov@amazon.com>,  "Tabachnik, Ofir" <ofirt@amazon.com>,
  "Machnikowski, Maciek" <maciek@machnikowski.net>
Subject: Re: [PATCH v3 net-next 3/3] net: ena: Add PHC documentation
In-Reply-To: <4ba02d13a8c14045b0df7deaee188f82@amazon.com> (David Arinzon's
	message of "Tue, 5 Nov 2024 16:52:11 +0000")
References: <20241103113140.275-1-darinzon@amazon.com>
	<20241103113140.275-4-darinzon@amazon.com>
	<20241104181722.4ee86665@kernel.org>
	<4ce957d04f6048f9bf607826e9e0be5b@amazon.com>
	<91932534-7309-4650-b4c8-1bfe61579b50@nvidia.com>
	<4ba02d13a8c14045b0df7deaee188f82@amazon.com>
Date: Tue, 05 Nov 2024 18:02:57 -0800
Message-ID: <875xp1azla.fsf@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:217::10) To IA0PR12MB7601.namprd12.prod.outlook.com
 (2603:10b6:208:43b::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7601:EE_|DS0PR12MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0cae11-659b-4499-058a-08dcfe0724b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUFTUEFQVjVwbCszcGFhaVJBemtmRGpFTU1ETThrUjI2aHhMclJXbUV0dlBa?=
 =?utf-8?B?c0NZQXhJb2d6THhpb2RabTU5Rldrem1melZiNkZCYk1JT0RGZk9zejRkY3R5?=
 =?utf-8?B?MlF6Z2FDWUE3NEFZcUVBbkIwa0VyaGRUZ1ZtZytqVlI5S2xsVDZQUjllalRS?=
 =?utf-8?B?ZmRqWnc0YThGMWd2ZTVpY0dVcWVOelVrMlcrYk5oSjNGWGxicmFxcllLKzBZ?=
 =?utf-8?B?U3JKV0dkbWdvM3JtUUhRQkxVU3dFYTdzcGdMMlljYkRuT2RZY0dLdFlLUVN1?=
 =?utf-8?B?OExrR2xGRmdXTW9OK2JLTDRZN1Z5a2RQR292czlrT2NiK0ZOT1hZVWhTWlJM?=
 =?utf-8?B?dThMYkZlWTdqRFZGWDJRYmVzOGNweElLOWxGelEwL3NYcmVmZ0NjNmMwYzhQ?=
 =?utf-8?B?cDNhK3ZiVmtVMlZJWk9ZbG5BN1NVWVFhaG5WSThBTk5mRFlzRVc0bEMydnoz?=
 =?utf-8?B?NGQwTmJva2dLVlNsdkdOVUxvc1BNM08rQjFFejhzL0FjbGRQbDEwK25vc3FO?=
 =?utf-8?B?RXU4UkxKWWlLZ3N5NjE3bzF5bXl1ZEJWWjkyaTdzMDh3M2N2ZzNrR2czM2FL?=
 =?utf-8?B?a3krdTZaQ2tXdGpsL0RBbGloc2R5QkE4SDZjSURodGxtbzJGTWM2eWtrQzdN?=
 =?utf-8?B?OVpQOU9JclE4ZWRodGE0NTlUYnRNbll5OXNFR0QxNSsrSXlFRFVORHlkK1dl?=
 =?utf-8?B?c0M4Y1FCbmFVd1JnaGhBbVZXQ0U3UFp5T0s4TFF1alVGN2Q2NTU3LzlaQlJR?=
 =?utf-8?B?WXVvZWhNNnNHRS95dU93cVRUdUtuc0M5SVRuUmc5RlYzY3ViMXBMdnFPRWg0?=
 =?utf-8?B?TTFYU3NPQS9iR2ZKWHZPamR1bkMwWlIzMC9JeFVuY1hGSXVzakR3MFByOU9x?=
 =?utf-8?B?eEx2VjJ3RzdVY2F2bDV2bE91ZlN5blFRWnJSeHZES0pyNUxDZXJNeGUraU5h?=
 =?utf-8?B?WG81RFcvenpLeHBZbG1KWmJOdHRPRWNGVWRKZWJnanhmSE4xTVNPb3BoS3BX?=
 =?utf-8?B?Wlo1MGJ6cUVHNjVsdVhVdkJ2cWhCVHNKd3l3aFpvcHlqVVhaYVVkQlR3UzNI?=
 =?utf-8?B?R2d4ak9LWnMyVnNNZWowdkhHbVB5MWtKUHV4aGZwN2FkR1dxYmU5QmcyVVZN?=
 =?utf-8?B?TmQ2YllMRHRjbFRrdmZER1dVSWp6YUp6RFZxd3dCM1h6VXQ2cms5WjNqemNI?=
 =?utf-8?B?V2V2aldRblFZTmxrYWJhS01iNStpYnQrWmFwOVFPMXlHTTZ6VkRIMDAvN0Jz?=
 =?utf-8?B?YlkvajJPalVZVGExeGZYU0R3TGYzQjNVeW1tdlJOcE1DZHJXaGo1RWs3dlpW?=
 =?utf-8?B?dnlyaHk0bEI0VTdlSklMSitDcDMwVHI5c1F6WDlCMzhOZER0aitwK20vYXdy?=
 =?utf-8?B?aGJxUkFNMGtJNzA3aDV0SDFrcThkenVIK1QrZVB4SWVOSFo1dTM3L3hvVXM1?=
 =?utf-8?B?ZHJ6V0ZhOGZObCtsVXB1Sm5TUklXSlVycG45WVBNb1ZlUlJwM1JMak9scTVK?=
 =?utf-8?B?M3NIV2M5VnNwanU5eTFPRzlybmcya2xjRjlUUnJxSnR4K2VYMU16OWdwdzRY?=
 =?utf-8?B?UEZYM0podUdUMVRTeW5ySi9HMUZoamErM1AxUm9OeGhFV2R2SlZqUnV3dkdC?=
 =?utf-8?B?YUNHaFpGUFdZalk0MjNkVU5PbjF0TGxYQVlVWXArWTJzR0xJRFFnUTg1YXE0?=
 =?utf-8?B?bkQ4TDJMTG5wUDUvN3ZOVE9XL0lwcWFia1d5S2lmTnF4ekZSUWRRYUh1NXd5?=
 =?utf-8?Q?AaTeB9mn1BO5s3+natBaBdhaHSodiFJ+h+kbJWh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUZpb1lrdXpvaUhQRzVtTWJ2bm5jc3hNdzdpQklSZ0RGR210UWd5em1XbGNV?=
 =?utf-8?B?QWptZDNiUWhUUWNiOVJ2dnprWS84SE8xbnVxemx4dXBDOEs4TFU4cUlyYzhr?=
 =?utf-8?B?TDRDUnpPNVFVN1lScGZ6c2hlay92TmlaNDgrbG1NMmsyaVZrbGlIRGpVVDRH?=
 =?utf-8?B?VjZaNXhDaUY2OS9kNG5FTkJ6akg5WHpUSHlYYTh2M3ZMUERGRUNKU1BlVldC?=
 =?utf-8?B?cVFYd1FkZmloKzQweGcvVnlaOENsUmJjakErY25COHYvb0NjeU5qZzhWdndj?=
 =?utf-8?B?NE1IUk1vRU92aXp2eTBKNDJDZmRBN2QrY1BqeE5RZnRQYXNwNXZHUC9xalpF?=
 =?utf-8?B?YUtDL0NEYmNnZmxFbGZib3pTWitoaEczMU5SZTF3eFAzSXFUZGF1N0F4Z3RJ?=
 =?utf-8?B?UlI5M0F5cGErRmZtd1RBaGtJUFUyVlBlaTI2dTllN1Qxa2RKMWxMSUg2M0kz?=
 =?utf-8?B?Ui9mYWtPWlVuWTl1eG5RbDNVVTNJc1l6NXEzeWk3MlVXdENtKy9FM2pJeCs5?=
 =?utf-8?B?Mi9kR0IvRlBvUm5UT1JWVm0wUThpcmpNaG16WTJuRkZ5d2tCM3ZodUpYSEtN?=
 =?utf-8?B?dmpkQ0pPTS9zNU5qZlhZeEtBYk5zUDJjN09SOG93ZWN6Ti9vUWVmOUdzWGFB?=
 =?utf-8?B?NWRNQWQ5ZEg4Z1oxaGhENjRzYlA1V0pYQUxHZHhFamdoMktrKzZFOGwvOU1M?=
 =?utf-8?B?cFk1bUNrOTRSeGl2YThPdTFmU0ZRTkNkUlFYVlZKcSs1S2ZULzdZWVd0aTcy?=
 =?utf-8?B?S2J1Z09yY2NwUkEzcEprMnZQVkYvVjZVVWJKaTNrNld3VFY1S1k3TzR1c2Y2?=
 =?utf-8?B?QmJmRlV0ZkdNS2szcDd1MkV1Z3F5akZyc3Q2bUtCbUtMUUVYZHVRNFc2ZG1s?=
 =?utf-8?B?UnNYYnFjQ2JNaE9wV1RRZ0l5YUNRbElpeE9aRWl6S21wNzU3b2p0QjZJTnZa?=
 =?utf-8?B?UnpxRldMb0U1dXRBTDlmdjJjTGdMdHJsam5uV243aDBHUlJDK1lWR05ldDQx?=
 =?utf-8?B?V3g3cEljSEJONHVDemozOUEyR2pKQWFJR25yYzRWS0x1bk5QZUR4UzZiRW1r?=
 =?utf-8?B?emVVK1RlYlZ1UmRkODJaa3dNYlZMMGo5Zmd6R2dGTVZ6MStkQmVxNThTSE92?=
 =?utf-8?B?a3pvb0VNUjc1ZUdkcHByU081cVJuTmp2MXpXeEluTG13eDBSVDVhb25aZGNG?=
 =?utf-8?B?U3A3Zm4venl1Qy94QVVXWDlBV2dQR2NiS1A1Z0R6SzdUVldSYkY3NXlVUVBq?=
 =?utf-8?B?V3dvKzl3VTJCRGhma0NkMGZ2Y0JoSkpTbmhjRzBVeXdqSDJpK284OEkwODRJ?=
 =?utf-8?B?VCtXeWhjRVo0RnB0SXN0dFFjRWJ6WFRsY0FjRTQ2QU1PVXpjcUUzeGZ5VWN6?=
 =?utf-8?B?WGhEUUNzTnlKU3NpeGR2N2xVQnIrcUdudTkxeGN6R2U3bjF6cEVDbHo3bkVW?=
 =?utf-8?B?Ly9oc0tJTk1IRjhZaDgzU3dZKzBDakJSZlZ2ekJ5WUtieG5aOEQwYklEMVZR?=
 =?utf-8?B?UjBUaUNyaDFiTVZ1RmFJaFIreFNDeEE2T1lxUC94eCtoajdmVTRmVlJpUm5u?=
 =?utf-8?B?SW5VdnVLdDZ3MWZadWhXVGFxK01KcWxaWGpIQUNNN1gyM0svS1QzK0RlWjNU?=
 =?utf-8?B?YzR5TXNKait3a0RiUXAyYkZISzVra3h2QTFONXNuOC83cHZ6WVF0cWxSd3hp?=
 =?utf-8?B?Y3FlNmFkRUJSbmJFT29DeCtiUVpsRjllTlhoYndNLzdBc25rcEtlVFRiTUZU?=
 =?utf-8?B?V0c0UlBlV1ZDb1p1Sk1uUTVXZkMxVDRLYXdtbTB2SnpHUWdnLzdhMmEyRDlT?=
 =?utf-8?B?dnFsZlgwU2pEM0FydlJqeThNMEpIOGVZS00vQy9uYTBicUJLOSs4a2VtY2gy?=
 =?utf-8?B?YzBtUFhsUVNsM2FSSk9iNUc4UjNkbGdKWnpxc2FtMFZ6WUEwRCtLTUZsZDBR?=
 =?utf-8?B?ZkRaOThNaWwrSHlhV0tzMmhWNExwNzBleXV2ZEFpRHh4enJ5S1FjUFhZaUxu?=
 =?utf-8?B?TXdqUk5GNXI4cklOVzE4OHhzRjJIektpNGxXZUsxeU5wQkQxc09Cb1RadDYw?=
 =?utf-8?B?N0dGL3ZyUU9xelZPUGZjRTVPMzI4UVZjRnVYZ2pPU01USTRIQThzTVVnZkFF?=
 =?utf-8?B?L043QnZzOWZXenBxWDQ4SGs1TlBrVC85blYxMEdHZzJSMXIvMFVMZVE3ZndT?=
 =?utf-8?B?cEE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0cae11-659b-4499-058a-08dcfe0724b2
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 02:03:01.6807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoeD43Pgx7WnkWzEAX0JcF/64JyXygw9S5E+sVUhU7RByoEh2YXQGIm4mypmXxmB0eUFwG+9lzS/POVEhXhxpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7678

On Tue, 05 Nov, 2024 16:52:11 +0000 "Arinzon, David" <darinzon@amazon.com> =
wrote:
>> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>> >>> +**phc_cnt**         Number of successful retrieved timestamps (belo=
w
>> >> expire timeout).
>> >>> +**phc_exp**         Number of expired retrieved timestamps (above
>> >> expire timeout).
>> >>> +**phc_skp**         Number of skipped get time attempts (during blo=
ck
>> >> period).
>> >>> +**phc_err**         Number of failed get time attempts (entering in=
to
>> block
>> >> state).
>> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>> >>
>> >> I seem to recall we had an unpleasant conversation about using
>> >> standard stats recently. Please tell me where you looked to check if
>> >> Linux has standard stats for packet timestamping. We need to add the
>> right info there.
>> >> --
>> >> pw-bot: cr
>> >
>> > Hi Jakub,
>> >
>> > Just wanted to clarify that this feature and the associated
>> > documentation are specifically intended for reading a HW timestamp, no=
t
>> for TX/RX packet timestamping.
>> > We reviewed similar drivers that support HW timestamping via
>> > `gettime64` and `gettimex64` APIs, and we couldn't identify any that
>> capture or report statistics related to reading a HW timestamp.
>> > Let us know if further details would be helpful.
>>=20
>> David, did you consider Rahul's recent timestamping stats API?
>> 0e9c127729be ("ethtool: add interface to read Tx hardware timestamping
>> statistics")
>
> Hi Gal,
>
> We've looked into the `get_ts_stats` ethtool hook, and it refers to TX HW=
 packet timestamping
> and not HW timestamp which is retrieved through `gettime64` and `gettimex=
64`.

Hi folks,

I think everyone might be on the same page now, but I wanted to provide
some clarifications just in case.

The use case that the TX HW timestamping statistics covers


    =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
    =E2=94=82                                     =E2=94=82
    =E2=94=82                                     =E2=94=82
    =E2=94=82                              =E2=94=8C=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
    =E2=94=82           NIC hw             =E2=94=82      =E2=94=82        =
     Packets out
    =E2=94=82                              =E2=94=82  PF  =E2=94=9C=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BA
    =E2=94=82                              =E2=94=82      =E2=94=82
    =E2=94=82                              =E2=94=94=E2=94=80=E2=94=80=E2=
=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=A4
    =E2=94=82                                  =E2=94=82  =E2=94=82
    =E2=94=82                                  =E2=94=82  =E2=94=82
    =E2=94=82                                  =E2=94=82  =E2=94=82
    =E2=94=82                             =E2=94=8C=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=98  =E2=94=82
    =E2=94=82                             =E2=94=82       =E2=94=82
    =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
                                  =E2=94=82Hw timestamp information per pac=
ket
    =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
    =E2=94=82                             =E2=94=82       =E2=94=82
    =E2=94=82                       =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=96=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90  =E2=
=94=82
    =E2=94=82                       =E2=94=82  cmsg    =E2=94=82  =E2=94=82
    =E2=94=82                       =E2=94=82          =E2=94=82  =E2=94=82
    =E2=94=82                       =E2=94=82  queue   =E2=94=82  =E2=94=82
    =E2=94=82                       =E2=94=82          =E2=94=82  =E2=94=82
    =E2=94=82                       =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98  =E2=
=94=82
    =E2=94=82                                     =E2=94=82
    =E2=94=82                                     =E2=94=82
    =E2=94=82         Linux Kernel Stack          =E2=94=82
    =E2=94=82                                     =E2=94=82
    =E2=94=82                                     =E2=94=82
    =E2=94=82                                     =E2=94=82
    =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98

We are collecting statistics on every packet being sent out the wire.
The use case being described here


    =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=90
    =E2=94=82                                  =E2=94=82
    =E2=94=82                                  =E2=94=82
    =E2=94=82                          =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
    =E2=94=82            NIC hw        =E2=94=82       =E2=94=82
    =E2=94=82                          =E2=94=82   PF  =E2=94=82
    =E2=94=82    =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90 =E2=94=82       =
=E2=94=82
    =E2=94=82    =E2=94=82                   =E2=94=82 =E2=94=94=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
    =E2=94=82    =E2=94=82        PHC        =E2=94=82         =E2=94=82
    =E2=94=82    =E2=94=82                   =E2=94=82         =E2=94=82
    =E2=94=82    =E2=94=82                   =E2=94=82         =E2=94=82
    =E2=94=82    =E2=94=82 (just a clock dev)=E2=94=82         =E2=94=82
    =E2=94=82    =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98         =E2=94=82
    =E2=94=82              =E2=94=82                   =E2=94=82
    =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=98
                   =E2=94=82 Query device's clock for current time
    =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=90      =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
    =E2=94=82              =E2=94=82                   =E2=94=82      =E2=
=94=82                                 =E2=94=82
    =E2=94=82              =E2=94=82                   =E2=94=82      =E2=
=94=82                                 =E2=94=82
    =E2=94=82   =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=90     =E2=94=82      =E2=94=82                   =
              =E2=94=82
    =E2=94=82   =E2=94=82          =E2=94=82             =E2=94=82     =E2=
=94=82      =E2=94=82    =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=90    =E2=94=82
    =E2=94=82   =E2=94=82          =E2=94=82             =E2=94=82     =E2=
=94=82      =E2=94=82    =E2=94=82                       =E2=94=82    =E2=
=94=82
    =E2=94=82   =E2=94=82          =E2=96=BC          =E2=94=80=E2=94=80=E2=
=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=96=BA            =E2=94=82   =
 =E2=94=82
    =E2=94=82   =E2=94=82                        =E2=94=82     =E2=94=82   =
   =E2=94=82    =E2=94=82                       =E2=94=82    =E2=94=82
    =E2=94=82   =E2=94=82 .gettimex64 callback   =E2=94=82     =E2=94=82   =
   =E2=94=82    =E2=94=82  clock_gettime syscall=E2=94=82    =E2=94=82
    =E2=94=82   =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=98     =E2=94=82      =E2=94=82    =E2=94=94=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98    =E2=94=82
    =E2=94=82                                  =E2=94=82      =E2=94=82    =
                             =E2=94=82
    =E2=94=82        Linux Kernel Stack        =E2=94=82      =E2=94=82    =
        Userspace            =E2=94=82
    =E2=94=82                                  =E2=94=82      =E2=94=82    =
                             =E2=94=82
    =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=98      =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98

The model above is about getting the time from the NIC hardware in the
userspace application (which has not involvement with TX/RX traffic).

I do think the phc-to-host related statistics are on the niche side of
things. The following drivers are error free in their gettimex64 paths.

* AMD pesando/ionic
* Broadcom Tigon3
* Intel ixgbe
* Intel igc
* NVIDIA mlxsw
* NVIDIA mlx5_core

The above drivers would definitely not benefit from having "phc
(nic)"-to-host related statistics being presented here. I am more in
favor of making these statistics specific to amazon's ENA driver since I
think most drivers do not have a complex . Also, what value is there in
the count of phc-to-host successful/failed operations versus just
keeping track of the errors in userspace for whoever is calling
clock_gettime. I am somewhat ok with these counters, but I honestly
cannot imagine any practical use to this especially since they are not
related to anything over-the-wire. So the errors in userspace would be
enough of an indicator of whether there is excessive utilization of the
requests and the counters seem redundant to that (at least to me). Feel
free to share how you feel these counters would be helpful beyond
handling the return codes through clock_gettime. I might just be missing
something.

Hope this helps.

--=20
Thanks,

Rahul Rameshbabu

