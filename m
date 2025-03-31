Return-Path: <netdev+bounces-178259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140EAA760BE
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 10:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B9803A4572
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 08:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2FC1BD01D;
	Mon, 31 Mar 2025 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Jeq8XinF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DA633F3
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 08:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408079; cv=fail; b=fxW7i1ivmhHz1thMJH+d9M4Otri1wIeUIqKm0tZd+TtYqX86s+G18PppPgZBtzXcu03XbIpnXXnAaMwBI2eBw0ilsRAuprNVXTqxYSQ55CDOkIggndh1EPfJCb8tRmM6PbY+vKbsg2ezSYWIQKk4dXPOFauMG1z9r+2DzzbKhPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408079; c=relaxed/simple;
	bh=wF9qtaZX1VwcSoENdrgrdhdFDApCnRFzO5Bcy+pWbak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oYiDMmZz1ObNBSYUFaCljD5N44S0Evch3XgFZ8dhxcLT5Q3O1POrnDlj9GJkz6Nj58NeL7yaYxsT86McAL6BxWFyJvVUsN9sdtP3SlcFi4OuRsHZCb7I82z7luDpF+ETbI71SqnElwDNiOE9Y5sFCGWLxCxKfOaFR/tEo+Jr3YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Jeq8XinF; arc=fail smtp.client-ip=40.107.100.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DeVHRBhYCwOQk8gtI0/09cZUhnWLj8gahQJIXCF8liyHFnfy9AME2v42HODYlBN9aCN6q3Psmh+BfJImxFbCHEgDeiKk6n0WF13YqHp3Lp/V6LD04H2JausshHqxVVfGPV4hQxW3KCMhp4rkSv4RoEdAHD4cB9m/TO7SQ02x30q+hMDjybcD1PwN/E0NH3W36vZEaSF3LFJYihMOCM13l77mi+bsKJXmZRIx5WaoniAqKHXg0TJHdtNFTvJr62owJv6bInoKPyEXKTASlO4v2aswI0XX+O3+dJ7DWqWAAnz8gLZIeDG9hiPZuaWDvqOSZMRKKLWvr6obHkKztDD8oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wF9qtaZX1VwcSoENdrgrdhdFDApCnRFzO5Bcy+pWbak=;
 b=g7JN391raAMCp/fb2Im75lDJZbWYlONEHj53xFf+HJDpBi6chdh9cGxPPFuYUUaNHic063xp2mUkLH/XtXghlVdr4OIB1abI0m2gk63bJKBChVnt05ttIyqwryHfbeq60K49wsFHDzltiEfZ89+YCscJXPnYpppQqDrjO6q/bzESLmhre60yNPSIc9Cq00I4JcPKxOUkKBZZQrW/JVHsoE67ZK77jwk+LwA2LnBlk1SXCJONVMn91emvV06NMkzf6XtGiw4JE/v4m5WjFw4DOyBSnEKQs1q0BDxTrcC+OvuNOTfEpZ7b+bWL8sSyHeQhJU7FWdG5ZJzye8LF7ZFl4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wF9qtaZX1VwcSoENdrgrdhdFDApCnRFzO5Bcy+pWbak=;
 b=Jeq8XinFeb35dM+oEgP8eofoADDKFqd00EPq5UVcP5X4Qc0wAgi+ek1Lc+32WpaYf9rPx9mzZav0R03dx4Awd/Hnv2aGoshwsCwsWcfHngwzoCNGhtaF6K783fsr+9O6TU94+/NUNMw3NxNl4G9g5EHes/DSKsuj1onEZ+gfUtTTnkjV9WEnu2e3x+aj2sgNRiZ5F2YflxY89YwKUurZR9gbPrwYCvwEX/Re98NwjmKEnCuDHCHel0AOIpQ8YWml3BgKluPi/np+yu4UMrL3NeKbkwlyYBxYFfsS8Ljy9W9L+ewhw1ha+uqmRuqVSEljTCH6L1NsP/w+H6RkSqLdKA==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Mon, 31 Mar 2025 08:01:14 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%2]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 08:01:14 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "stfomichev@gmail.com" <stfomichev@gmail.com>, "kuba@kernel.org"
	<kuba@kernel.org>
CC: "edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net v2 05/11] net/mlx5e: use netdev_lockdep_set_classes
Thread-Topic: [PATCH net v2 05/11] net/mlx5e: use netdev_lockdep_set_classes
Thread-Index: AQHbnyAkA9rwlxzsbUSN2JQZZythUrOHWPWAgAAgnwCABW5OAA==
Date: Mon, 31 Mar 2025 08:01:14 +0000
Message-ID: <ad51fbc8a578f9cae51dab7b551619d37d3385c4.camel@nvidia.com>
References: <20250327135659.2057487-1-sdf@fomichev.me>
	 <20250327135659.2057487-6-sdf@fomichev.me>
	 <20250327120821.1706c0e3@kernel.org> <Z-W9ghVoqyuHsVOH@mini-arch>
In-Reply-To: <Z-W9ghVoqyuHsVOH@mini-arch>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|IA1PR12MB6604:EE_
x-ms-office365-filtering-correlation-id: 0b193622-a348-4990-9dff-08dd702a3551
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dUF4NUFwR253RWE1RzVPUGtTYUUvYzZzbWJjWFh0eDh6ME1DQ1Z4eUhUSS80?=
 =?utf-8?B?eGdIby96U0IzT2JsMXQzUXgzZ2I3VVVXbS9iZHlYSVRWWlJDZ3pZUUJRd1BE?=
 =?utf-8?B?TTJoVlR0YVNOSXBydmdicmd3NnRHbjVIZmxnRTJvT2JubmhFbFlPbWI5ZS9E?=
 =?utf-8?B?eU1jc1p3dXpvQ1FYTHV6REFQMW1VcW5LQ215TjVlcjZ0MzVGK2JmTTRhRGd0?=
 =?utf-8?B?aWJZbDhKbDVzL3BHcGJlbHljYmpVQ0ViZkozRGZuQk5RRzVWdUJFYW92aVJv?=
 =?utf-8?B?OG11NHhRWUJ0Y1JjaU9pRno3UVJaa3puakpWcXUrYnFXZllDazNMMVdoMXpz?=
 =?utf-8?B?bExRU0pVY2ZMMHZqMnRFak9tRitvS3VRY1RFU2tuZkU4Tzd1TTNYTDZFWmJE?=
 =?utf-8?B?NFJmdHRrQVlxS2pJY05DUEQ1a3c2WVVTRGE5S3FOY0d3TzgzeEJteStxTXlq?=
 =?utf-8?B?c1FQdlcyODdaa2o1T1FWSVRNYTd1V2sza2lFdk9uYUNjeG1GbXpVak55R0xV?=
 =?utf-8?B?R1NNYXVqeFU1eG9JY1Ezb0xQVjFxeFBzb3U4eGFsdlRUUzQwNVB5Y1NGdUZk?=
 =?utf-8?B?aVZjSlE1Uld4Unk2WFoyNlJGYjFCV3Y2YzJDTjRCSUh4V3RjY2lhMjg4WXBP?=
 =?utf-8?B?MXlCK0FKVXowUmNvS3dLeWNXTEhGUGJhQjY3cHJpZGxOQ20xZHdobURwSXJa?=
 =?utf-8?B?K010cmFPZDVJV293T1ZHZENJaXlzN2l3dldKczZVanE0OVJYbWVMdkNkaElt?=
 =?utf-8?B?L3NkMFViWlFNYitJWWxQTi9vWktpb1Z4eDBnVjhMNVd5c2dzUnB3NklNMGdF?=
 =?utf-8?B?Y0tyVnBHbjlBYkN6U0c0eWFVUWE2ODhIem5iTUFNUHRXSUJ4TlRBT0FQQVZV?=
 =?utf-8?B?UzV0TEhsc3d3Q05mZjc5bTRVL1NCSjNTUHBRenc3ZHZPcEdnWUxmSVQzUnZQ?=
 =?utf-8?B?cnRmSkJaOXMyNDBwZFdzL0ZySVZQUnFQdnlxTm5Bc3dJa043T2FTeHpoMVdo?=
 =?utf-8?B?bkUxTSs4b3VvdVNXVkorbWd0NjhTM0luTmxDeDhNZUdsdmpIRjZFaVpMb0pE?=
 =?utf-8?B?RnZmSHhRUXJnQnQvMC9LajZCWTdSK1dRWWE4c05OK05hQjNZU0FHWHVHQVN3?=
 =?utf-8?B?TUxXaE1OOUpCdkZkbXp1MTBVNUVxVXpWQXozRW1ZMUxkSVdmaXhHYUo4Wjhm?=
 =?utf-8?B?MzdPZjFhdGlibGRxSXRnT2JlYjRnU25jVjlZSUtyK3JoaUZJTitGK2NTc3N1?=
 =?utf-8?B?d2hndjEwUDgzODVINHUxUU5Oc3RIREZzM3dFTFE4SnZ3eVBsenpBbTdFdmU0?=
 =?utf-8?B?ejNFSmlsSmtnbmpod1RkYUNCditGdzZTR2wvak1aRnBJT1Zaa0l5NWx4VlVF?=
 =?utf-8?B?WXlDMkpsL3ZZNldGVWtvam9TcVh1RkFtU1p6bWtqaWpkMVZjYTRyNWt1eU5k?=
 =?utf-8?B?NDYwR3J2dWFZWk01VmNWRjJQSmtHMXhPcmxuLzdvWXg4NVQ1SGxuVjBOZlBG?=
 =?utf-8?B?UEFGdGRTdVZjdjNvUnVsdWxvY0RNWmJXRmEvQ3h5MWdERGRhVmdld3N5WlpY?=
 =?utf-8?B?NXJPT2VWMlFheTNDb1NUYjRVajg5YnFLekJweDVlcC9VR2JlbllIbFRWYlpQ?=
 =?utf-8?B?VjBtUFhuek1BTG54dWI3eUNzK3YxZE1XQ1I2dU5sTkpFMVdILytxM2RQV001?=
 =?utf-8?B?c2s0WlliRGM4eDN3V0FpWjIzaGpOMmFUS1ArcTdQUWtmZkhsKytzWmtnK21S?=
 =?utf-8?B?MnpUeFgxWjJlL21Id0NRNGp2RzZlZGEvMXJ2ODdFV1pGV3Buam5ma09QbktF?=
 =?utf-8?B?YXFqUHk0ZW1xVkFOODJldWRUVHpOM1ErRkM4VVFiUmx4dFlqU0hHaTRjc3RC?=
 =?utf-8?B?WWRvNHNPb0dlQlpxaENYMjRGVURoT0Zna0wvKzdBODBXM1hEQ3ZzM1hoVHJi?=
 =?utf-8?Q?XQyHritnTBbbw4P1fAWePVssQtBn3zZg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0V5MU9VcmJBMFBJSmFYcG0vL1p2R3BZaDhIbVZzQUttOUtBOGVBNjYvRVJs?=
 =?utf-8?B?UjMwTEwwbXhKNGpSd1NPQzg2ZURlMFRlNDVyOGNmbVF5QnNhQW8ydWtPNWFB?=
 =?utf-8?B?eUZZZnRWRC83LzNzOG9saFprWkUyZGhkRHRhL3oyNlByRXcvZE1ZL05tWlpi?=
 =?utf-8?B?RFQxU0M0aFpDU2VORkVBL3l6SmJaamRtWlN1cjJuQjZuQ3o0a0JTejNuNGtv?=
 =?utf-8?B?U01Jb3VqMXlvdjk1N2hybGJRaVBmTys5Um5sYjRhL2JZWmlhaFV3VHdlRjBY?=
 =?utf-8?B?MzdFVU1sd0xMRkFlbUt2bUVPWGJwSWJpbUx1SFBVWlVTTXMxVE9Na1hrUHFY?=
 =?utf-8?B?dHNhYnc2S2hSN3JDaGtiMUxnRzFtL0tWVFA3a3VGK216NEc2UXVtR0ZuYzBh?=
 =?utf-8?B?MDAybTFxaDlYYVg2NExQb3dTVEpSalg5ZVl4MzJJYzhqcnZyUk5qOWhmS2Ra?=
 =?utf-8?B?V2tjeGw4cXB1bG5UdktKZWFiRXh4NzBjMlR2N0Jjdi9QcWh1cVVXd3B5YUhl?=
 =?utf-8?B?dzdPdUhDSm1lUXU1Y2o4ZTVNb3lFek9LU1NXaVd0OTNxNDJ6bllPdzREcnBm?=
 =?utf-8?B?RkdzSlBDUzlnaEg3em0xNTE1NVZqMFkvdDliVlAyMnliY2hoUG5zUzdhMDZx?=
 =?utf-8?B?VjFNcUZJM1pjb3dmQmJpNG94aUhSOThDNDg4WGpZR0dMb25uRC85UXJOd2VT?=
 =?utf-8?B?L0ZjbHZRV1Zyc0lpZnVoVFFVQmg5MjJMaUNBQThCSVFhVzJIM1NROHE5d3lx?=
 =?utf-8?B?RFp4WEx4T1BlM1c0dUtPeUl6NGg5bFljeHcwUkloeHNvSm9aM0wzaUl0ODJJ?=
 =?utf-8?B?Mk8rRVMvQlBUS3FGc0RQbzRIajQzU1d4a2YrVG5iN1U3WVFaWExaOEtqM1lP?=
 =?utf-8?B?ZlYxR2V3azBmS2ZPM0RTd2orelBGaEIzZFhLRGs0OXI3MmcyMmMwdjJBOHZX?=
 =?utf-8?B?NzV4L2QwbkE1bUozNlRxYkFwTDdlWDlJQTBDakJDSUxsNDVrSE9JQVE4ekNq?=
 =?utf-8?B?bVRGdXpoV2xsTU1CUnMrQkk3U2hGSjFiVVJOTjlFanE2d1hEVUxpUzA1ank2?=
 =?utf-8?B?S3hWNUFNVXNtMm9qUVJuNXVWQUwzWks2My9uaEdZdHlvYmhPRTZaZXBUOVQz?=
 =?utf-8?B?S0UvREJ2TXVWTFJmTmo3L0dPaDJrSXl4R25jbjZhNVUwd1c5TjZCRlZvYkZl?=
 =?utf-8?B?LzZZUytpcU83REJuTzZ1MnhtTmJSREFIUjBZdDluL0RzeXpNOUY4QnJXUEwv?=
 =?utf-8?B?am53b0x1RGRZMHhWRVEvTFFZSDF4U0RpUmhVV2VwNVhjdHZRL0RhTnBtUTh0?=
 =?utf-8?B?N2RzYkhNcUJKSUdLdWIzWjFOeVI5UTFDRmpaMjFsV1lYMmM1My9vNTFIUzR2?=
 =?utf-8?B?aHFENWRoblpCakR1bk9Fc3RrRWlMdUY4ZUtlM0t2OVlkN25STWZjeHhaRU5X?=
 =?utf-8?B?Wkw2OVl0UUptQ0Fqd2hpWS9oQmozS3UreFg3MWNJMXJpN2lNNkt4SHp3UTh5?=
 =?utf-8?B?cDhreFhYNDl5cS91MUJWa0h0b0xXVzZFckhtU0RrSE9NRGxxWWhKd24rT2lL?=
 =?utf-8?B?ekdLYUc2RDlBY2FhVk80QTFibCtzaDNnMTdxalNRNFlBUFFFa3U5a0dBNmlX?=
 =?utf-8?B?WHplbzBLV3E3eTZWNy91WFdjNXVUV3kvUktQdUNKSldSdGM0UkJkWHd0L0VD?=
 =?utf-8?B?RDVIclQvdkdsclpSdEppUm5LMUFxV0RGNGdBem5BU1FqY2swVTYwUnZMRDFM?=
 =?utf-8?B?cXExbDhQNDV0b0t4VklPNlE3UUZEKzJZMEhDN3ZrN0RaelVTWkJRNHkxc3pt?=
 =?utf-8?B?Q1U4Z3hKWUZTMnZ4TmJmQTY2aHhyeHZoVFRFNmQ4OG9CUGhCS2ZPNW1CWDFI?=
 =?utf-8?B?cHp4M21DemkrbEFPQVExZ1ZsVktVOGhibFVqQUtESWtzZ2tSc2JsenVBS0lC?=
 =?utf-8?B?Ykl4L2VSL0xmcHZFYS9ET2dxTkEraGpmWEhSZ2NrTk5OQWxmS2hrMW92UVhl?=
 =?utf-8?B?b3F5NEcwSS9JV0x5WFQ0UVlRS1laQVRha254ZjdyQWM3M0swQ3ozeUJ2dGxR?=
 =?utf-8?B?WmFEOFRYUU16OFNYemFxbTd2d0RJWm94bnhFN3JyWHZ3d3pJQzYrWm02SFRQ?=
 =?utf-8?Q?E4C+754FK+ivUSSACu4vv+mX3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95BB40FA51E51F4B95F855800BFA75BB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b193622-a348-4990-9dff-08dd702a3551
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 08:01:14.1873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FbnzfjE0/+z/4t0zsq/RVBtbssAY564iO5NzKPzpvkrcuaI2zGDsc1f8r0Dr2SASfINXyMzD97DlCTs6FlDwSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604

T24gVGh1LCAyMDI1LTAzLTI3IGF0IDE0OjA1IC0wNzAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+IE9uIDAzLzI3LCBKYWt1YiBLaWNpbnNraSB3cm90ZToNCj4gPiBPbiBUaHUsIDI3IE1h
ciAyMDI1IDA2OjU2OjUzIC0wNzAwIFN0YW5pc2xhdiBGb21pY2hldiB3cm90ZToNCj4gPiA+IENv
c21pbiByZXBvcnRzIGEgcG90ZW50aWFsIHJlY3Vyc2l2ZSBsb2NrIHdhcm5pbmcgaW4gWzBdLiBt
bHg1IGlzDQo+ID4gPiB1c2luZyByZWdpc3Rlcl9uZXRkZXZpY2Vfbm90aWZpZXJfZGV2X25ldCB3
aGljaCBtaWdodCByZXN1bHQgaW4NCj4gPiA+IGl0ZXJhdGlvbiBvdmVyIGVudGlyZSBuZXRucyB3
aGljaCB0cmlnZ2VycyBsb2NrIG9yZGVyaW5nIGlzc3Vlcy4NCj4gPiA+IFdlIGtub3cgdGhhdCBs
b3dlciBkZXZpY2VzIGFyZSBpbmRlcGVuZGVudCwgc28gaXQncyBzYXZlIHRvDQo+ID4gPiBzdXBw
cmVzcyB0aGUgbG9ja2RlcC4NCj4gPiANCj4gPiBCdXQgbWx4NSBkb2VzIG5vdCB1c2UgaW5zdGFu
Y2UgbG9ja2luZywgeWV0LCBzbyBsZXRzIGRlZmVyIHRoaXMNCj4gPiBvbmU/DQo+IA0KPiBTRyEg
TWF5YmUgdGhlIG1seCBmb2xrcyBjYW4gaGF2ZSBpdCBhcyBwYXJ0IG9mIHRoZWlyIHF1ZXVlIG1n
bXQgd29yaz8NCj4gQ29zbWluIGFyZSB5b3Ugb2sgd2l0aCBhZGRpbmcgdGhpcyB0byB5b3VyIHBh
dGNoIHNlcmllcz8NCg0KSSdsbCBhZGQgaXQgdG8gbXkgcGVuZGluZyBzZXJpZXMsIHRoYW5rcyEN
Cg0KQ29zbWluLg0K

