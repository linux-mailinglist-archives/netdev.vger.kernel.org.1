Return-Path: <netdev+bounces-239832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DB144C6CDD8
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E995C381325
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 06:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1793431354E;
	Wed, 19 Nov 2025 06:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qNQtTB1r"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010008.outbound.protection.outlook.com [52.101.85.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBEA1EEA49
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 06:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763532454; cv=fail; b=p0mPsdCupckMHoadMPttd2L8c8aFbMw1IP6xcrtwMflrN5El2ZcaSdbxwv/s89D2w9arc5+SetL+hkWksb5RHUgqNvktiY3r/lKrDexr5t1fEdcA6Fm/Rfumex0SJgh52T4fZ7NCL+caYAdx1WNY6ScN/3VbOBdG9RxgrKghsog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763532454; c=relaxed/simple;
	bh=JjlAWf4Q7j4lf0ePLhlbbPPQYrNEH9fdrtBmcmx6eK8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ONoUk15w4m7Wr39TvzP3jBMUoS21QXqDufA1+7NKmRNrnecCNO9UnuMcD+/IqE2ehAt5OKvvO6UGLzGRBuo3jWG0C9TA7Sb1U8DwpxOh0/2gO7Et804EaJHVyzGwewikDQ1ZNI3YN/DjlnRdzTcig826C+WF9xVSudpZGrV3uCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qNQtTB1r; arc=fail smtp.client-ip=52.101.85.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQcBKOZRzpps3WERQRa3C3cU9ifQPqxcLzA6B9BWtzUFG0n9KLeW+sX1z2TXcZD4CptDe7n/oJJ3tvUyrD8GqCNRa3XU+O4A3yvagy3AgGMttChpRlLmWKtnWH7FIFksGKfbPlECNmYyw3JXqTnxusYJw31SNPaGvor7WTRKTgK/gNfF+0xyqCQkgqT4tk3Gm131daeObo/o4PMZvNfsaBigT2rjk/xCG65z7pz15EOpwwo83haNuvE/BN0yTUvIWdOESFzk7i/dMFOxug7RCJHW2sEKEvNCFJcz10VFqcT71qBKcGB4SV5E5VctpVMtCCDXg3mXI9cs+GjFcVkZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QhNUeTBCdc0vv6m/TAqEbE6vsSixswQmkylAj/1fRo=;
 b=EL7g4Qlb8GvoImO+GkUZcuuHd9uJi6zzvKOAsZAtEZRuRRXEH+6/XeC6VcBWbOrk3ghzynIyV5mkTjQqWDLHDCsQYd94dQnIwd3yKb62m0aifq0AVdFzv7eBdzgd47Y6/E+9aefMVCQhfEYqm3W8ya8sgvWgwp6vk8Qo+siL5qSgHqD+2PolCrpdWUiqkBltlW4Ye6u2CVCaWt5hCjn7nwQtf0U7UOkBQdcKr2srX0GIuIjSMN7TIUzYUDXe5pm8WSVBc+cAGCrNkhj8JhGyyq/12uqVteLTRLwGQl9s9P0o37rEPIMiActlsUC2yXfMY2C22Lc2D7bfsqXq4Uq7mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QhNUeTBCdc0vv6m/TAqEbE6vsSixswQmkylAj/1fRo=;
 b=qNQtTB1r354h6gEmLZzSaB0WxzWR7f5jV4VkpYkequyE+VcLBcwRGUB+RX2Khouo+9rg6dc1M54rL8+SgdD2ON+t4p85IYVpTjU1Gt3cMVzpWaSlcFktJGuChRR1CtFsplFymO+QbAxgFQyvtRqPAsLkJq6RIYU+0+BACnUPVz4K4065AagtNmCirt7rFQ/7T89XAyEouS8KRfiMqP6ZTa/KkK/ojZRFwkGT7/jjcQ7zc10hHtGvn+Mn8GqCKNv4vuNgZ+dk52wvIFWMiP2MDzpiPCpZx5wVFwYyVhLVL3VEBqjwHiKuAzW6A/AOFdTdTYaNcRUNHAmPb5orI3t/Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17)
 by IA0PPF6483BC7EA.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 06:07:28 +0000
Received: from MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c]) by MW4PR12MB7309.namprd12.prod.outlook.com
 ([fe80::ea00:2082:ce2d:74c%5]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 06:07:26 +0000
Message-ID: <70584793-ff6e-44e9-b1b6-3c7105993fdf@nvidia.com>
Date: Wed, 19 Nov 2025 00:07:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-8-danielj@nvidia.com>
 <20251118135634-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20251118135634-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0091.namprd11.prod.outlook.com
 (2603:10b6:806:d1::6) To MW4PR12MB7309.namprd12.prod.outlook.com
 (2603:10b6:303:22f::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7309:EE_|IA0PPF6483BC7EA:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a16ac6-d76e-4f76-c0c8-08de2731e9ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUI4akhOTGFubnRCWmFaemc4S3RpeTZwZnYvRUJSeUFSZ0xkWlE5MkF0TjFE?=
 =?utf-8?B?RjZOd05kQmo1ZVpZa1hBR2dTNWZJendxK1hRTytheVpwdGJ0dFMrU3ErTjZ1?=
 =?utf-8?B?bTVjQTRiMktORnBPYWRpZVdkMDQrQThVNVdlTSthejdhbUlIbUR6dHVsQ0ty?=
 =?utf-8?B?L24yd2tTUGFiTENvWW12ZkNPU05UWTgwYS82Rnpyam0zei9UbkEybFRTMU9k?=
 =?utf-8?B?Q3o4bmc2ZnRGQ3k0dzNwdnR0NkNrQk92Z0V5b0Y2ZFRiRHpvd2VYejFleUJE?=
 =?utf-8?B?SzJEd1JRdXNHRkdjYzU1UGZFQ2RjWjBBTzVRdVpjNEx5cnYybS9vaEg1NFAw?=
 =?utf-8?B?Sml6Z3RCZWFocEZSSFpGVFRydjJjYUtIQUJ2YmUxQ2MxQ3UzTzhRRkYxYTNo?=
 =?utf-8?B?UHJMSWdqSDVQZ1lFbmhBLzk4NytwV0hIbTd0SjhsYnVaN0dkd0JCOVN5dW9q?=
 =?utf-8?B?Mys4bm5JcUZHU3hsUWlVdy9VUzNCNTdUaDBWU3hncDNTazl3UmtRUVlXSEJk?=
 =?utf-8?B?WW5HdVhkcDBORlJTMHF4LyswcjkzUndFbjlUVFlvRVRaNFlnendrMVk2V1pn?=
 =?utf-8?B?VHRtUWoyaFVSa2NwZEY2S0I1WkZqZWJkZm1XTEsyUzRibU5YN1pkRGNEcHor?=
 =?utf-8?B?UlVGNlpYaUtTa3E1MDgxRWdCOWRZTUFHM0dpY3RpeCtDT0xraGtSbU81ekVS?=
 =?utf-8?B?UG1OMlBZRGtDaWFPSkg4NDQ2REFZOEcyTFhCYVhkbFBBYzFMbXZYRE13TmFS?=
 =?utf-8?B?RUZmbWl1RlFJWVdmVTJ3ejQ5amVCZW0vNGxJZDV5RFZuallqY0t4cFgwR2xB?=
 =?utf-8?B?RFRRcXduWFM3b010VnBMUnRpSTgwR2NsbEFIa2lkT3FuVENFeEVGTmtMVWNp?=
 =?utf-8?B?OUFHV2xCYUdHZXU4WTM1UnBWMUFlYXgzREh2bkg0Q0VjVktTTG1DTkJPaklB?=
 =?utf-8?B?VkpFYjVsL3o0KzZrWjJSUVg4WTJ3cVRUN1Y1djJDWkdTOEI4R3krVXNIWXhz?=
 =?utf-8?B?cDhGVzltUjcvNm1mUkF5VmFvOWpmenF2L094UU9IeVUzbnVaNTlHaGlxUEtu?=
 =?utf-8?B?NllyMm5aU3ZnYUJtLzdsVXl3MEVsZmFSdmZhcTA2N3dXdEdqQTFmUWN3dVpP?=
 =?utf-8?B?cUp1SmR4MDJ5VGxvY2hnb0tpSE96NnBZU0tVVTc3NU44eEpiakJDQmhUa2FR?=
 =?utf-8?B?UkZGbndLcnk3VCtNaXBtSTQrQjhxSDB0d24vak5pSCt2OWJZYjJBU1FpWEwz?=
 =?utf-8?B?Qy9UR0RBSlF1c1lxb1BSaUdoMldKbUtvZkZZMVIxSitKZ2RYRUkwNC9WTmx5?=
 =?utf-8?B?RHhKY01iYTFlaXE3RW9OZjJWRHNMemJzWFZTbEV0MitNWU5JU09lZ1p6Y29r?=
 =?utf-8?B?S21XamZVRkI4eUJYWHYvekFvdGdWelpGNzZlVlhmaHJ5b3NJK3VmRWlFb3Bs?=
 =?utf-8?B?QjdjdUY2eDdrU0F6QmtibVhTMjBTbDF0eFVkbzRndGxXd3hHU1ltMGlnN0hi?=
 =?utf-8?B?d3FsY2J5bHFRN1pxeTBQWGZOOW9RZVQyQy92enN2eTNQNVpBT3d3b0NjdXg0?=
 =?utf-8?B?RWpRdW9UZjVtWUk5NkYwQ2FaT2syRVlSOW1BZ3hGV29zY2hDak0rcUE5ck91?=
 =?utf-8?B?UUpKTVNMY1F4UXFrRE9JeVVJY3lSY1JpbUNRVlkxWkNxTUpBcEtFZ1RQYUJY?=
 =?utf-8?B?SjUxN0hVZ21obGN2MzdWRXFXNEV2RVdvRGl4MU8yQUswOGFVektZczZmcVVr?=
 =?utf-8?B?SWV2SDI0T1U2R01qdTh3RDM1OEpDaHlMVk0zdHB0c0JMY0tOWWJaUmt5bEZy?=
 =?utf-8?B?WnVsbHJpQTNwbFY0RVp6QW1RTHRjd1VWNDVyeTFDRTFEczdxYkQ1b3IxaWlt?=
 =?utf-8?B?RFhkd2FQNTJQL2t1bDk3aDlJYmM5c1NxcWxZWTQ3NEpjc2N5K2JpWDZRTDRj?=
 =?utf-8?Q?VFaoyipD1Ymcg6LKZZuqCnjUiUjYyKGq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlFoMnB6L05BUTV0c3RCSlhxSXpENVF5aHFaR1dpNlp0K0ordXIyazc2VEFR?=
 =?utf-8?B?ajdVRTFraExMNFJjZGdOaUkvcGcxbTRqTkJXYjM1eUpnTkhxWGd5cFZlV2xr?=
 =?utf-8?B?TmpDYWZqZ2p1b1hwUWN5amxNZFlacUFWNEZHcmhsRWZaWUFmcFk3a1laZmt2?=
 =?utf-8?B?R2d3NW1POVE3RnNLYU00R3NDdnZqcFRHRStaV25hdStRajBxendBbXh2aVBB?=
 =?utf-8?B?Nk5pclZTbnRJaUdEV3B0WDhKTTE3R1NrTitlckxsblNjV1FDUUhVN0dGdzhW?=
 =?utf-8?B?YUh1dGFTNnFhVFVHK0k5Q0x2MzJ2dDdYY01KbHF2QVc2cmRzbi9XZnhvQ2c4?=
 =?utf-8?B?MFpPUVhWM1FkZTBlUzRreDc3em5Qc1lPZ2JtclZESzh0d3d2ZW5CWkg0ZVdz?=
 =?utf-8?B?ZXFad0pHMW93Smd0amkxMEcwYUFjemFCVU0rRkx2SDJwZXdjS2JWUnozd0ov?=
 =?utf-8?B?UVlWeXlHSjl5Yy80bDNjOVg3cFB4b2RsUHcxODFZZWd2Z1lmRnZuTWg5aVFh?=
 =?utf-8?B?L0JYcHhxWURxS1cwNkJIVW9JR1NFdW9nMFhZWTNKRlBhMG5KUWt2U3NneHI5?=
 =?utf-8?B?NWdaZXo4VjhraVBMMExFK3lkREtxdFlFdWxOR201QnloOVVQMzB0Ynk0MFFo?=
 =?utf-8?B?aUpCS0MwUTUxT250K2pnMXdUVFVtbHRUdGZ2RFBKTU10ZjNmT0xjS1ZWYTFM?=
 =?utf-8?B?ZFBtbzl1UVJuNWVyRlRSaXlHUHVNR0Q0MEt0bzNHdnJHV0N6SWpObTRTRTZs?=
 =?utf-8?B?K0cwakNLUlphRWpxOElXUU43YW05Yi9ZR1dLTmwyaGtFdjlsMnB0S2dnUVRY?=
 =?utf-8?B?UTZNQlh1RzRzUlAwL1FyZ3ZsRmR1cnZ6UDdCVWRDR3M5MHpiRlAxRlEvZDlx?=
 =?utf-8?B?Z3pYZ0p2OTNqbGJHYUF1L215dEs1Qm96aWJhK1ZXRWRiL3FtQmxrKzlEeUI4?=
 =?utf-8?B?aUxkRFQxVkFzTXhBTU5uV3YvQ3N2YWJ0Rm9keS80K2dWNWQwNmJIZmMwTzF1?=
 =?utf-8?B?elRuOEpvY0pHc2dTTi9tcmJvc0ZvOCtnckJjeE80eXBrNVk3SmZFVFBpWjU5?=
 =?utf-8?B?UEJnTURWaDVQYzdhUk1HNUYrbms5TWN3Vnp1dXVpNW1hVDYrS01ieWErZ2RO?=
 =?utf-8?B?OFN6RU1sOTJEWGl5Yyt3NEw4OXZPS1hkSG5yMnZvdGMwS0ltN2lCeXdHaE9r?=
 =?utf-8?B?TDRreEFtV2Z5NkxRTUlVd21qaVVGckdiNFZkMVdQa0pOMjZVbnkwY2FHdVZn?=
 =?utf-8?B?dWtVcmtRdCtEQThEMVhTUVplcWloMTIwVTNGZnlnQzJxRFhiVWo5YlRLUis2?=
 =?utf-8?B?aWJPMnJSdnRHb1RDRVZQcTA0dE9CRzhQQ3JMbVdCMFdIQ0VEMGF4S3Ribkd4?=
 =?utf-8?B?MlNBVXZhVW5sc2NpWHVxZlF1M3hMVHhLNWhEQUN4VFpQZXd0R3pvVEhxTXVw?=
 =?utf-8?B?bmRzMzdvZmpSdlFoRGNUNTBFQ295NElLKzdUY0FCRGFHcXNEdVpNazBPL29I?=
 =?utf-8?B?cEZXQ1FqMjM5SHczMldkQlRMdmpaeHM0NVBoWHFQRzAwSmd0QTJMOFBaUUVP?=
 =?utf-8?B?dUpqNllFTW45S1J4K2FXdGtvYms2OU1LazZUMFdaaitvWC92Wk1sOTc4T1p0?=
 =?utf-8?B?bXZ4QkZ4K1RubUNYczdPMU15cTRISGQzOTlXUDZjS0xEbGhQeUtIY0pwWTBW?=
 =?utf-8?B?RllQUDJ3MlNraTJkQ1pqUmdFWkhrWXlGUVhEWTVQT0x2U25vR3hSUEhsQ2hF?=
 =?utf-8?B?WTJoajNERXAxMGhuVERjWVBSMVRVK1RJTFBZSS9jcmVtSmE4RUhlbTkyVE5K?=
 =?utf-8?B?dEZXQ2FpZUxYYlg5NytiSS9TQ21lbXc1MENBU1QxSEJxS3kvZ0J4eFZRWHlM?=
 =?utf-8?B?TEhzRm5qbUx2dUt6VFdYMFhzNDNEdVlweFFLLzNOdytkNXJpZWl2ZThMdmhm?=
 =?utf-8?B?WWpiZ2l0cEMwS0phdEU0R21HeHNTbmdwSEdEUUVGblhvbEtKU2tScytTMlh4?=
 =?utf-8?B?U1RoUWZBd25xL0lidXljL2FVYXg5U3I3Zzd5cVlhK0F3bC9GTTBVOVZET2pU?=
 =?utf-8?B?cTRMdUF2L0s0c0p1QWFaNzc2eE9lTnh0YXRUUE4vK3E5Q21PSXpDaG5EYklz?=
 =?utf-8?Q?HPhtwUChg+JICxhC+XJ594jqK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a16ac6-d76e-4f76-c0c8-08de2731e9ff
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 06:07:26.7822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: deUNe19g2yYpEoemRFfAEi8BSkZeo0JPUYOvUAsNd5eZEWP7+ycCnmQl7ReCZiL2jAXkt6DkcuqpIHOIFWrzlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF6483BC7EA

On 11/18/25 1:01 PM, Michael S. Tsirkin wrote:
> On Tue, Nov 18, 2025 at 08:38:57AM -0600, Daniel Jurgens wrote:
>> Filtering a flow requires a classifier to match the packets, and a rule

>> +		       size_t key_size)
>> +	ff_rule->group_id = cpu_to_le32(VIRTNET_FF_ETHTOOL_GROUP_PRIORITY);
>> +	ff_rule->classifier_id = cpu_to_le32(classifier_id);
>> +	ff_rule->key_length = (u8)key_size;
> 
> I don't think you need this cast. 
> 
> BTW why do you insist on making all this math in size_t variables?
> 
> Just u8 should do, and in calculate_flow_sizes you can do a BUG_ON to check
> it does not overflow.
> 

Ok

