Return-Path: <netdev+bounces-125071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2960096BD7D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01671F21171
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F8B26AED;
	Wed,  4 Sep 2024 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yhh1Np8C"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2B71EBFFA
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454866; cv=fail; b=YC7QYL2xZpZuQzcTYNukmAEUPdVwmyAbNFDvjcW1xxr8mUS9/d/fCQb0I+Fq+DXihQmTH8btfZ+PeNsJ4p0Ttfy05l6BvDca0LDtIEzKvmwdaPJwDw4R/xwrm4drSNs+tVIQYau4n14SGjiHmqEA9h2fJJ0/SfLwscQCqKNzYCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454866; c=relaxed/simple;
	bh=sit0xfcjnA2g551lL6Fe+TCFliAsgrPTjXe6xy8pf/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XG77hGsQniQyiAlFOQohQfdbEgAgpMSIwVsN59lazI3Uta04Wxt+NMdKEwGF8pAVplVklaJ5vWYsqqeC0mH0SoB4zpHpPJjBW1vTpmv6kSRKpU+3SAlGf08qX7F4p4KsGXcsUySYZWPgzlOAdxRQWa2/WK+rjg+cEzcWBvuSu6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yhh1Np8C; arc=fail smtp.client-ip=40.107.212.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cd2kvm6ny24QvVqla7qpRMYoqNleezOlFBRoFmHTEIVsbcnPP2FZcF27CYVISOXRhG9+mkzIQhRKEFUFcDp2q3JHDZ9K1KR2Svc/dNcqBFQsxZAZHG3PO1R7VVn3/zFAe8Zxdxbbg2eZUkGkLAE0oeOZvrQMgbfc6IFXcoqp70kYTJQVgBv8fn2nivLA7czBe8LXhlrWS062J7/JZDHqd19L86co8Qg0TelZnSRdrWzDiUJOclGZXoOgMOJrrpMupkSvWH0wyPOxrkJ7cTFAw2HvXptlXfm9Cm97eOvrmnn9EfUFMdNzaGD+4Ap8O/69YUQR/BPtF5mWPE/pqPL7Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SV+QUtAd9IHbZstIdv9jMF7k3oxIewJPODyse7vHnu0=;
 b=wZt/U3800ep7y/eQZkWyKKc/Xs1foXWAZRHCwLAU3FQbe4eCjTSzZQf8S6UWBlqWhRfqvyIlmjC3bqwn34hiGuYEzBgCMbMOKvbwwcKzWCof0pKkhTFe+xyAazdBfX0QiGk02la7Sch/9mvx6SQSzMXfMd0bol3FwJF0PWmpfSvglwqExMk01hLrWTZbo4jmKe23EqVEu6ALN72fm3D5IB3LfVuYYEDW7iOFaJ9D1D+wZVAEdCQJdHDPVN6pW+K4BLDrZhYjjGS6nsg/stul6nW6okDGdvstv8TeKv9ZkmjABB2cTXKZhc037nwZ6UWaCwB1KRidexlofifpUIPqPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SV+QUtAd9IHbZstIdv9jMF7k3oxIewJPODyse7vHnu0=;
 b=Yhh1Np8C+Dn57yrxlmTxH6clzW85N7blPcPZ6us90SgeAbUfo2BsefHyRDpaAIdReC/RlI5u/TJeYTzUj5VxIQgl3QKoLq9GCogbztDuthd8FA9ZXRukcFB4nlDib3FjgT9YoPNmpGJRufaEwjuTO0hnuJKwSacoezvJXz27amHWslXKXwilMZjF5NpfeWmG4YwQsrihM1khFAyAJH4Qd/poIFu1fQHoYnlv5XrE7JV12RHkPMtvVCznSzFyhVDTimLazrXqnUzlOnZycdGmXKobSEcUKWvLfQ9FGYSeuvQzRAg4xzusv3fjany9Rdyr/fR6jGwj7+3cq6MJlhW8TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2719.namprd12.prod.outlook.com (2603:10b6:805:6c::12)
 by IA1PR12MB8192.namprd12.prod.outlook.com (2603:10b6:208:3f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 13:00:50 +0000
Received: from SN6PR12MB2719.namprd12.prod.outlook.com
 ([fe80::1ab4:107a:ae30:2f95]) by SN6PR12MB2719.namprd12.prod.outlook.com
 ([fe80::1ab4:107a:ae30:2f95%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 13:00:50 +0000
Date: Wed, 4 Sep 2024 16:00:40 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>, gal@nvidia.com
Cc: Tariq Toukan <tariqt@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
	Michal Kubecek <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [mlx4] Mellanox ConnectX2 (MHQH29C aka 26428) and module
 diagnostic support (ethtool -m) issues
Message-ID: <ZthZ-GJkLVQZNdA3@shredder.mtl.com>
References: <a7904c43-01c7-4f9c-a1f9-e0a7ce2db532@ans.pl>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7904c43-01c7-4f9c-a1f9-e0a7ce2db532@ans.pl>
X-ClientProxiedBy: FR3P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::17) To SN6PR12MB2719.namprd12.prod.outlook.com
 (2603:10b6:805:6c::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2719:EE_|IA1PR12MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 5043f0e8-9771-49a1-dcc0-08dccce199fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1Zac05WcFkzMXgrdVdYODhFOGV5cWNsVkxIWVNsZzVvRlduSTNWS3A2KzVK?=
 =?utf-8?B?ZkMvcitWSnNIbEp2UGNMTVdoRFVnd2tKL1M5aTEyc0FLUklvQTMvKzdHdXp2?=
 =?utf-8?B?c01CQ0NSRUloeGhBeHl2SzFUUlVLc3Q3MWg3OFAwN1UvMXBPeVZRTW1pcmhF?=
 =?utf-8?B?WXJ0ZTMwT3Rla3kveXNINmRCQms0U0FXQWI4UVgyS3ROcFk1alZTUGZ1NTEr?=
 =?utf-8?B?NkpuODVZNUltN1hhK2h2aWJpQjRNTmRwRjhmU2pOV0pyd0EwUWhnMVNNNEps?=
 =?utf-8?B?OGpVUm5PWnROcTRyRkdxVE4xRGErbWQrSVZUVTVpN08wanlRRFhZM3pxc08z?=
 =?utf-8?B?by9RUG15V2pleUJJZUpKVkR3Y1BDSktOVUY5NTM1aWo1NmpUREJyTjdlUGxO?=
 =?utf-8?B?bGQ5bS9tMFhjTmQvYkpRbDNBR01RWFlvMkRGMUtQSTZaWHVRbXgvRFM2bGYz?=
 =?utf-8?B?Q2tvNGVHVVkzakwyRVNIR1dtNTZVKytRUGlyMm1BTEdyREhnTlJEOVlvbzM1?=
 =?utf-8?B?YVprS2Y1Tmw1Tms5a2dYQlcyTEEvY1E3MnhKNTRDbFJISVIxaG9YY2w1cHJs?=
 =?utf-8?B?RER4THpOd0F1cnBDcFlsRGs4cXN4eXJLaGNpU1B2Qno4S1JxTlpBWXlGZUdk?=
 =?utf-8?B?bkpIdmFYcmppN0ZuWitpbXBnVUNnT0JuTWVGT2NPb1VkSGNyMXpaMTJ2YjQz?=
 =?utf-8?B?NFJhZ0hGeFRwRjRRQmFxVk5nZHgzU0U1ZUhCNkpBeGhlNWpuNmpBaGxuQUFl?=
 =?utf-8?B?N3E3bDdPRE4vcXNMdjM4ZkJCejFtTVVPbDRQNnNZZWZtV3RuSXViY3Vud0NB?=
 =?utf-8?B?dDBIaUw0Nm5vSk1KMjhuUHhXRW1oM3VMRHdlcXBUU1hZRURXak0wNURhYjFR?=
 =?utf-8?B?bEU1RGNJSGpBNFJvV0xUekdBRkk1YjFSNjdxNW5EdUN6aElyVTZwM0VrTDEr?=
 =?utf-8?B?b3NhYmVyanJpWjdPWnJ6YzJmVlh4M0NHclh6ZnNlak1zMG40OFBxR21LbXNQ?=
 =?utf-8?B?aldSV0hTQW5MWVFpZlJBWEw5aFJxdnpsVVBnYWQwelYyMVFvbkgwS2NtWE52?=
 =?utf-8?B?YWhreUs3TndQUmFjV05lVjVxZlM0UWVVblB4YXowZEsvVGZsWStQZjA3MUxp?=
 =?utf-8?B?cGE4SFlIbTc0UDRjUzBpNzZvTkl0VVhYWmJpSi9VR0FySnlSWUFBNWtxNlV6?=
 =?utf-8?B?L1B3VjJlYlI3aTFRQ0dmWGl2RXFUSFppVkZDMHpKbStkVTlwRS9CeDhPSDZ3?=
 =?utf-8?B?K0Riay9nd2JaUVkrWXB4Q1JJV29xYk1KcHdBVlhnbjV4eTJOblVUQWNBSUh1?=
 =?utf-8?B?UFNoTFpDRWtDOWRnZjBsRVZSalduaU9TMVhDSGN4cEtIRjdldmpWd3FIak4v?=
 =?utf-8?B?V0dEdlprK3pjOFkvSlhKNExUM0dPTnkyNnRDOEhyZHJTcXNCS1hnRmtOdU8y?=
 =?utf-8?B?WVh2eHZ5MXQwWGdSb21IVzYvUG8rc29IWEFUbHE5blUwZnZkZzBmQ2lkMmNP?=
 =?utf-8?B?RUJ6Q2FOSmR5OTlPQzlBNldLTXJGSVpkNWRCWUNqNFJHYk1oSWxSUGhqRlFH?=
 =?utf-8?B?cGJqbzRLVmgyblU0UmlMSUFoZmY2ZG1NYmxua0s3MzkrUHdoMzRhZjY1cEpv?=
 =?utf-8?B?ejR4cXpPdENjZTEzQ0VHU3lhRW8ycG9tQ3V4c2ErVk9jVDBRRVdMc3JDNGZ2?=
 =?utf-8?B?Tll2dlRDazdESmU2cTVacDJVd1owY3Nhcy9tZVMrZkttMS9hMHAxR2VkbHhX?=
 =?utf-8?B?VkprOEg2b214enZKMVRnSUNnN2VtZmNqVUZNei9IczdlYTdHT1JDQ1ErUDV4?=
 =?utf-8?Q?AbiFnevHOVAtYkJPaTuQgIQqm3C0VLiRnKvew=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2719.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eklWZzJxdm44NS9vWlRBUkxnNHI2N2NMV1o4dGMzd1BkRlY5R2oyQXdyVDJL?=
 =?utf-8?B?dG10eGwxd1pielljNEtkWWJMOWxkTmRqMjNaaWw1VjRoV1ZDUGtBVEp5TGx3?=
 =?utf-8?B?VVVRM0cwZzRudUR5SFMyVUozZ2tuVkgwYkg0Smk5YkYyL0Z4UDFkMERjTlI3?=
 =?utf-8?B?SDlkRyt3UGk2ZE12UHhHU2dLZklud1E5Z2hxOTFVT0g5ZDBnYTZZMEdaVUly?=
 =?utf-8?B?aHNxUXU0YjBkRHJMaEtzYi81UEx0ajBhTDA3K1NwZ1JvazJuUXNLSXdwVk1K?=
 =?utf-8?B?bEcrbWQrTjNNaTAzd2xXeEQ5dkJHZmJkcTU1YWJyYWM3bGVuSTdDclBIaVZn?=
 =?utf-8?B?eFhub0VVS0pTQlJtUzllTmtQdlZYTnllUE9BYmhacCtxaUtHb0dxbk5oaUpG?=
 =?utf-8?B?T2NDQkN1aDZJZ2gyRVJIdE9VSUxxdlE2SXNsYitlenNvSEhReUlKQ1RadVNF?=
 =?utf-8?B?RjgycUM3TEQ3VzVad1UvcGtMWU5KMTZIUUFjMUU5Q2M3cGdRcW9RMUpJUHJ1?=
 =?utf-8?B?N1BHT3lJNE5GVEwvQ3FsUTR5WVo0RkR2QjJpTnZ2SWJSd2tvNW9hVWduQVlx?=
 =?utf-8?B?VFFRdnJJZTlHRG9PZ0FVanBhM1F3UHdUWXlpZ0JJdDRuN3lVK0RqVEhPWDlK?=
 =?utf-8?B?ak05bzdKa2xRK1F6NnRuVDVaTkYvTExaZ3NOaUhMVHU2ajBHV2I1ZWJUTzkr?=
 =?utf-8?B?b0x6QmNkZmV0RHBYU1BWRDV1YnN4Y3ozNnQwUW1VTzVoRVE2OHdJSHpma0h4?=
 =?utf-8?B?YjJ0VGswWWplNTJOMXdnTGNZUzBqNlJPSG00UDVHTWhCRDVlTnh3TmVxWUhj?=
 =?utf-8?B?a3cxOENteHFKaDJEQkorWVVFT1dDUk04SzdVOGE1NVN1MHRlYlBtczV1cVlI?=
 =?utf-8?B?S2RXYU02b2MxMU0yY2V4azB5RWRiNEFycndlSG5QdVp6RVpLU3hkalRzTmNn?=
 =?utf-8?B?VXd3OVduamdwYWIzd3B3ME4rOTFEcU5rbkxNVnA3TldiTFNmWTNRdEk1WEJ5?=
 =?utf-8?B?NmIrZHRrcEtoSS9BZUtZVDZLbjNuNURYVWF6ajNsUTRHOVlCc0FnNmk2VU1J?=
 =?utf-8?B?enNNbFluREVFcHh4V08wUXE4WUEvUGJEOHNWNE5nY24reks5NllrM0ZrOHYw?=
 =?utf-8?B?STFjcjdFR1lrQkIwMlZ3cENNak9Vd2tqYXVQN2VBU0laU0owRVBkODBFMFZu?=
 =?utf-8?B?YWtCRHROUUFkV2NXbzdYZEkrQklsWloyL2tkOEJEZlRVVzFidmpwTDRrMkVF?=
 =?utf-8?B?NmhvV1drNDE0L0ptcEtUakJRbzh0SkV0cHJMQmk1UlNpcjZ5eGp0cUNwTnE5?=
 =?utf-8?B?RE8yTTB5UmV4RWxramFGZmlxcGpRWSthVkxlOUN4eWJqTDRtWDBQbWRNVzE1?=
 =?utf-8?B?Y3Q1cFh5Z1FTazI4b2pwWnJrdXZJZnRzbTd6ODJCampXc1dsV2k3bU8raTF3?=
 =?utf-8?B?dDllYzZSMmVLa0JzVnBzMFZhZVB6OXd4ZzlZNEdUTWNrSTJES2MyUDZTZk4x?=
 =?utf-8?B?SHU1N2liZUhYbVlERW82OVdMRUpERWs2RmNrV3lzNDlxalpLV0tWTHF2SGc5?=
 =?utf-8?B?UVJWcEllNk53ZHlOb1BHRlFqYVp1c2loTnk0MkhXWmZNa1JjWDFDclAwQW9L?=
 =?utf-8?B?djVLQlBHQkszR2JMOXk3M3RLMkIzeEF4Mmw4cWlCbkpUTW0zMmhNYUZMWVdz?=
 =?utf-8?B?SHdEQk9mTTBDWkRwOHRqS2Fkb0lMQmNnVWtJR2xEaTNja0MzVWRHMlRQRkc2?=
 =?utf-8?B?d3BDN25aLzFOdGFvbHMzNDFKZmJEZzBBZ1lQZEhGbXdhWVdCYnJqeWc4Q043?=
 =?utf-8?B?eHFRUFk3VkhlU3FGNkhtZVlvSm9BNmtVR0pONzVlWEFMMmtERWhCYkRKQWUv?=
 =?utf-8?B?L0ozZkJRcFZUZ1dnZnhjeXF5UVJJdjJLVGYzbzFhM0tRb2F0MG0zTGNKK2o5?=
 =?utf-8?B?MEN5d0puczJLTkxIL1FEdm9zVUpFTXY5WUIwcWtMU3o4V1V1Ui9OaHVGNTc0?=
 =?utf-8?B?dUJzWXJqUnNXRHFkeHhWbE9nVGVtZnQ3VTUwL0JaUldleVZwaWZMWWdObVox?=
 =?utf-8?B?ME1yb01Da0FTK0U2b3dCZG9Pb0R2Yll4RW1lV0lPR21SSFN2MzVqMFAzNHhR?=
 =?utf-8?Q?BO63X0hMYZwkEKZt8UzRWdGGo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5043f0e8-9771-49a1-dcc0-08dccce199fd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2719.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 13:00:50.5324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpvRQbACB5+4E4wG9fM0ZA7fYJkB2iSxK0gKurONFmsT1Uzb/C6oESdZy9Ckm7Ocjtwh5uxFHoJ7qiae1O6ATA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8192

I see Tariq is OOO so I'm adding Gal who might be able to help with
CX2/mlx4 issues.

On Sat, Aug 31, 2024 at 11:28:03PM -0700, Krzysztof Olędzki wrote:
> Hi,
> 
> I noticed that module diagnostic on Mellanox ConnectX2 NIC (MHQH29Caka 26428 aka 15b3:673c, FW version 2.10.0720) behaves in somehow strange ways.
> 
> 1. For SFP modules the driver is able to read the first page but not the 2nd one:
> 
> [  318.082923] mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(1) i2c_addr(51) offset(0) size(48): Response Mad Status(71c) - invalid I2C slave address
> [  318.082936] mlx4_en: eth1: mlx4_get_module_info i(0) offset(256) bytes_to_read(128) - FAILED (0xfffff8e4)

I assume you are using a relatively recent ethtool with netlink support.
It should only try to read from I2C address 0x51 if the module indicated
support for diagnostics via bit 6 in byte 92.

A few things worth checking:

1. mlx4 does not implement the modern get_module_eeprom_by_page() ethtool
operation so what it gets invoked is the fallback path in
eeprom_fallback(). Can you try to rule out problems in this path by
compiling ethtool without netlink support (i.e., ./configure
--disable-netlink) and retesting? I don't think it will make a
difference, but worth trying.

2. Can you test this transceiver with a different NIC?

3. I'm wondering if this transceiver requires an "address change
sequence" before accessing I2C address 0x51 (see SFF-8472 Section 8.9
Addressing Modes). The generic SFP driver doesn't support it (see
sfp_module_parse_sff8472()) and other drivers probably don't support it
as well. Can you look at an hexdump of page 0 and see if this bit is
set? If so, maybe the correct thing to do would be to teach the SFF-8472
parser to look at both bit 2 and bit 6 before trying to access this I2C
address.

> 
> However, as the driver intentionally tries mask the problem [1], ethtool reports "Optical diagnostics support" being available and shows completely wrong information [2].
> 
> Removing the workaround allows ethtool to recognize the problem and handle everything correctly [3]:
> ---- cut here ----
> --- a/drivers/net/ethernet/mellanox/mlx4/port.c	2024-07-27 02:34:11.000000000 -0700
> +++ b/drivers/net/ethernet/mellanox/mlx4/port.c	2024-08-31 21:57:11.211612505 -0700
> @@ -2197,14 +2197,7 @@
>  			  0xFF60, port, i2c_addr, offset, size,
>  			  ret, cable_info_mad_err_str(ret));
>  
> -		if (i2c_addr == I2C_ADDR_HIGH &&
> -		    MAD_STATUS_2_CABLE_ERR(ret) == CABLE_INF_I2C_ADDR)
> -			/* Some SFP cables do not support i2c slave
> -			 * address 0x51 (high page), abort silently.
> -			 */
> -			ret = 0;
> -		else
> -			ret = -ret;
> +		ret = -ret;
>  		goto out;
>  	}
>  	cable_info = (struct mlx4_cable_info *)outm
> ---- cut here ----
> 
> However, we end up with a strange "netlink error: Unknown error 1820" error because mlx4_get_module_info returns -0x71c (0x71c is 1820 in decimal).
> 
> This can be fixed with returning -EIO instead of ret, either in mlx4_get_module_info() or perhaps better mlx4_en_get_module_eeprom() from en_ethtool.c:
> ---- cut here ----
> --- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c	2024-07-27 02:34:11.000000000 -0700
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c	2024-08-31 21:52:50.370553218 -0700
> @@ -2110,7 +2110,7 @@
>  			en_err(priv,
>  			       "mlx4_get_module_info i(%d) offset(%d) bytes_to_read(%d) - FAILED (0x%x)\n",
>  			       i, offset, ee->len - i, ret);
> -			return ret;
> +			return -EIO;
>  		}
>  
>  		i += ret;
> ---- cut here ----
> 
> BTW: it is also possible to augment the error reporting in ethtool/sfpid.c:
> ---- cut here ----
> -       if (ret)
> +       if (ret) {
> +               fprintf(stderr, "Failed to read Page A2h.\n");
>                 goto out;
> +       }
> ---- cut here ----
> With all the above changes, we now get:
> 
> ---- cut here ----
>         Identifier                                : 0x03 (SFP)
>         Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
> (...)
>         Date code                                 : <REDACTED>
> netlink error: Input/output error
> Failed to read Page A2h.
> ---- cut here ----
> 
> So, the first question is if above set of fixes makes sense, give that ethtool handles this correctly? If so, I'm happy to send the fixes.

I believe it makes sense for the driver to return an error rather than
mask the problem and return the wrong information (zeroes).

> 
> The second question is if not being able to read Page A2h and "invalid I2C slave address" is a due to a bug in the driver or a HW (firmware?) limitation and if something can be done to address this?

Let's see if it's related to the "address change sequence" I mentioned
above. Maybe that's why the error masking was put in mlx4 in the first
place.

> 
> 2. For a QSFP module (which works in CX3/CX3Pro), handling "ethtool -m" seems to be completely broken.

Given it works with CX3, then the problem is most likely with CX2 HW/FW.
Gal, can you or someone from the team look into it?

> 
> With QSFP module in port #2 (eth2), for the first attempt (ethtool -m eth2):
> mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(2) i2c_addr(50) offset(0) size(48): Response Mad Status(41c) - the connected cable has no EPROM (passive copper cable)
> mlx4_en: eth2: mlx4_get_module_info i(0) offset(0) bytes_to_read(128) - FAILED (0xfffffbe4)
> 
> However, if I first try run "ethtool -m eth1" with a SFP module installed in port #1, and then immediately "ethtool -m eth2", I end up getting the information for the SFP module:
> # ethtool -m eth2
>         Identifier                                : 0x03 (SFP)
>         Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
> (...)
> 
> I this case, I even get the same "invalid I2C slave address" error:
> mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(2) i2c_addr(51) offset(0) size(48): Response Mad Status(71c) - invalid I2C slave address
> 
> If I immediately run "ethtool -m eth1" I get:
> mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(1) i2c_addr(50) offset(224) size(32): Response Mad Status(61c) - invalid device_address or size (that is, size equals 0 or address+size is greater than 256)
> mlx4_en: eth1: mlx4_get_module_info i(96) offset(224) bytes_to_read(32) - FAILED (0xfffff9e4)
> 
> Alternatively, if I remove SFP module from port #1 and run "ethtool -m eth2", I get:
> [ 1071.945737] mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module ID attr(ff60) port(2) i2c_addr(50) offset(0) size(1): Response Mad Status(31c) - cable is not connected
> 
> At this point, running "ethtool -m eth1" produces one of:
> 
> *)
>  mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module ID attr(ff60) port(2) i2c_addr(50) offset(0) size(1): Response Mad Status(41c) - the connected cable has no EPROM (passive copper cable)
> 
> *)
>  mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(2) i2c_addr(50) offset(128) size(48): Response Mad Status(41c) - the connected cable has no EPROM (passive copper cable)
>  mlx4_en: eth2: mlx4_get_module_info i(0) offset(128) bytes_to_read(128) - FAILED (0xfffffbe4)
> 
> *)
>  mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module ID attr(ff60) port(2) i2c_addr(50) offset(0) size(1): Response Mad Status(41c) - the connected cable has no EPROM (passive copper cable)
> 
> *)
>  mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module info attr(ff60) port(2) i2c_addr(50) offset(0) size(48): Response Mad Status(41c) - the connected cable has no EPROM (passive copper cable)
>  mlx4_en: eth2: mlx4_get_module_info i(0) offset(0) bytes_to_read(128) - FAILED (0xfffffbe4)
> 
> *)
>  mlx4_core 0000:01:00.0: MLX4_CMD_MAD_IFC Get Module ID attr(ff60) port(2) i2c_addr(50) offset(0) size(1): Response Mad Status(41c) - the connected cable has no EPROM (passive copper cable)
> 
> I wonder if in this situation we are communicating with a wrong device or returning some stale data from kernel memory or the firmware?
> 
> Thanks,
>  Krzysztof
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mellanox/mlx4/port.c#n2200
> 
> 
> [2]
>         Identifier                                : 0x03 (SFP)
>         Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
> (...) 
>         Optical diagnostics support               : Yes
>         Laser bias current                        : 0.000 mA
>         Laser output power                        : 0.0000 mW / -inf dBm
>         Receiver signal average optical power     : 0.0000 mW / -inf dBm
>         Module temperature                        : 0.00 degrees C / 32.00 degrees F
>         Module voltage                            : 0.0000 V
>         Alarm/warning flags implemented           : Yes
>         Laser bias current high alarm             : Off
>         Laser bias current low alarm              : Off
>         Laser bias current high warning           : Off
>         Laser bias current low warning            : Off
>         Laser output power high alarm             : Off
>         Laser output power low alarm              : Off
>         Laser output power high warning           : Off
>         Laser output power low warning            : Off
>         Module temperature high alarm             : Off
>         Module temperature low alarm              : Off
>         Module temperature high warning           : Off
>         Module temperature low warning            : Off
>         Module voltage high alarm                 : Off
>         Module voltage low alarm                  : Off
>         Module voltage high warning               : Off
>         Module voltage low warning                : Off
>         Laser rx power high alarm                 : Off
>         Laser rx power low alarm                  : Off
>         Laser rx power high warning               : Off
>         Laser rx power low warning                : Off
>         Laser bias current high alarm threshold   : 0.000 mA
>         Laser bias current low alarm threshold    : 0.000 mA
>         Laser bias current high warning threshold : 0.000 mA
>         Laser bias current low warning threshold  : 0.000 mA
>         Laser output power high alarm threshold   : 0.0000 mW / -inf dBm
>         Laser output power low alarm threshold    : 0.0000 mW / -inf dBm
>         Laser output power high warning threshold : 0.0000 mW / -inf dBm
>         Laser output power low warning threshold  : 0.0000 mW / -inf dBm
>         Module temperature high alarm threshold   : 0.00 degrees C / 32.00 degrees F
>         Module temperature low alarm threshold    : 0.00 degrees C / 32.00 degrees F
>         Module temperature high warning threshold : 0.00 degrees C / 32.00 degrees F
>         Module temperature low warning threshold  : 0.00 degrees C / 32.00 degrees F
>         Module voltage high alarm threshold       : 0.0000 V
>         Module voltage low alarm threshold        : 0.0000 V
>         Module voltage high warning threshold     : 0.0000 V
>         Module voltage low warning threshold      : 0.0000 V
>         Laser rx power high alarm threshold       : 0.0000 mW / -inf dBm
>         Laser rx power low alarm threshold        : 0.0000 mW / -inf dBm
>         Laser rx power high warning threshold     : 0.0000 mW / -inf dBm
>         Laser rx power low warning threshold      : 0.0000 mW / -inf dBm
> 
> [3]
> # ethtool -m eth1
>         Identifier                                : 0x03 (SFP)
>         Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
>         Connector                                 : 0x07 (LC)
>         Transceiver codes                         : 0x10 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>         Transceiver type                          : 10G Ethernet: 10G Base-SR
>         Encoding                                  : 0x06 (64B/66B)
>         BR, Nominal                               : 10300MBd
>         Rate identifier                           : 0x00 (unspecified)
>         Length (SMF,km)                           : 0km
>         Length (SMF)                              : 0m
>         Length (50um)                             : 80m
>         Length (62.5um)                           : 30m
>         Length (Copper)                           : 0m
>         Length (OM3)                              : 300m
>         Laser wavelength                          : 850nm
>         Vendor name                               : IBM-Avago
>         Vendor OUI                                : <REDACTED>
>         Vendor PN                                 : <REDACTED>
>         Vendor rev                                : G2.3
>         Option values                             : 0x00 0x1a
>         Option                                    : RX_LOS implemented
>         Option                                    : TX_FAULT implemented
>         Option                                    : TX_DISABLE implemented
>         BR margin, max                            : 0%
>         BR margin, min                            : 0%
>         Vendor SN                                 : <REDACTED>
>         Date code                                 : <REDACTED>
> netlink error: Unknown error 1820
> 

