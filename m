Return-Path: <netdev+bounces-177107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F265A6DEDE
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0497F3AB368
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A622E261394;
	Mon, 24 Mar 2025 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fckgvRDz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11F526138C
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830480; cv=fail; b=ma41kYqfBUdkFVLW6yJ2l8dOwhmwLdhvXEWIZ/Ltq6bQfr/8xUIsJuqWizh5eyqL7C36mFoXc9CfyzzfATldXRqCHuTXoKY8a3zZsXDQbb+E3Jw2tx0aM4m7vt+Ckel2O8sIkNKVgbFmf8jFOOiff3w/K9ymcpSnGO8N6wbHh5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830480; c=relaxed/simple;
	bh=s1EpXN2zQb8VMgUY+/kb+2WbNSiWFtiSMxBGOzX3Bj4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FUryJQql3du4r7xU0iLcAIodE7Ng+tLIAsYCsoA9soqW+nVBjW1VANAWwKiRd2NGQPZ4EfjZONPuiIeSxQ5cSO/e1VbRe/pf18R8jQyiBVx/Py1ztvirtc2a2BUofsz3ESN/9fxE0ym6gIE/NuVyLVeb+PLVK2box1R9vlqu3Yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fckgvRDz; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YiBEeZ5os0MD+l4BMtREIkSfVllZpz/GT6O6gSn2gvzHb05+16CxpttlYIgOx3nhcDWdUB3EzRdNqGexRXIlJ/zKGmPRwRVcleSLl+roeFnhTIJAoI0VGd7tOQDC2N74a4kgF6TB1BcVjm+8Qw/KPhZrYdxjBqIWewOzVpGdNzFe0uQIDBWTnjyOYInyvLGAi+ALxOFpp/M36OMYeuNdZJb6jtzcpUg309RHxQ5SDYuSxHfY68rJ2wWVWwA/kfD+OsRGxkc9AwMLrHbRklRhV0QisKROt6XZ4r+FFv+w2M9C2+kj+Z7BVHg1GIotGXJYx+Qiv4Ph6SGNiUfLeXTn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1EpXN2zQb8VMgUY+/kb+2WbNSiWFtiSMxBGOzX3Bj4=;
 b=gBiWFzIn2F/qCBHdjd8gzR7WK4f8YtI3qE7ML+IwQ8rPBvJVuZwh2CMyORlCnaOAi26JWge9duEjwqhmmg74dEL1a2onTZRis3rBAqzGfUVEKYyPH+3tYUHaikDN/mhwlGxuUfmc3YrLu/GQlzIgCJg4K5+UKYM+eLWnT6Wri/gKZOGXK9jHDzNK7mRUqNu+7QEquXUQwBM01g1B29c5QzzH39QT1k/cwr2JOP9kQwJy3G2TrD4jPiSL7ZDlnCBt6peBKWx6YE455FP2O+WPADBX+yDA6LG/0gvEAtFFCqYYdeXxzllZdkoLM75i/6VDzThzdzGkZjkUvZ3jUOO5xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1EpXN2zQb8VMgUY+/kb+2WbNSiWFtiSMxBGOzX3Bj4=;
 b=fckgvRDzKWPjm/gSzIIOPH+NT95nR8HYeGvZWUfNoeEmvpSSyUwfbNMuRf/hdIDSFIu0Y3WTSFKnoHpSlEmfZy9mUmsjDvw7GM4OwmC0+ZWTErsnvE6p+qrtRkUICMSp+unsa+APVYS8ETqXgUTOnABYdYKrvEQwK+d3ioc5vHo594+pE2dyrSFk0Iw3ebqi4IzCNqWPzUxHJooof9wzqkyYpKFvArRliO58Ne+pAvQ/0MjU4/GIbu8JMH68J3BdlBEl6HTYMN0K5tVy5pEAVJE07y/BkRArIc3XuyJ8BrjvaMMtUAZEu5gBC85wJWevom0uV4Vk00FvTQMZDjs7ZQ==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Mon, 24 Mar 2025 15:34:36 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%2]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 15:34:35 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sdf@fomichev.me"
	<sdf@fomichev.me>
CC: "saeed@kernel.org" <saeed@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v10 08/14] net: hold netdev instance lock during
 sysfs operations
Thread-Topic: [PATCH net-next v10 08/14] net: hold netdev instance lock during
 sysfs operations
Thread-Index: AQHbje0W2l3ubLQ/uUepzvoMt3824rOCiKAA
Date: Mon, 24 Mar 2025 15:34:35 +0000
Message-ID: <700fa36b94cbd57cfea2622029b087643c80cbc9.camel@nvidia.com>
References: <20250305163732.2766420-1-sdf@fomichev.me>
	 <20250305163732.2766420-9-sdf@fomichev.me>
In-Reply-To: <20250305163732.2766420-9-sdf@fomichev.me>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|DM6PR12MB4171:EE_
x-ms-office365-filtering-correlation-id: 44e3cdb9-d994-429b-7765-08dd6ae961eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TGVKMUNiNXlla0NzN2s1eWQwSTgwZThoMHFlZHFHeDdNZ21MMGRNelVNckh0?=
 =?utf-8?B?U09Gb3laQzhEYlZ1YUowRmpPSnA4OU43bHBscjVmcW8rWUtYbkNZL0FiN1NF?=
 =?utf-8?B?VnRiWjNMQktNRFZaTDduRjJBeGhLMVNYUmpzd2FtOWxoN0NvNkRYV251ZkpH?=
 =?utf-8?B?SXU2dTNUWUxCYkoyMDlQWEFUcFVVVUpGSEJtclMwcW5qMEVaUFNVQVBQVDNY?=
 =?utf-8?B?K3lSTU5JZWU1ZzZMN2pOZUhEalVsTjBweUd0T2RDT0VSOHpNWWtPMnFVYzdt?=
 =?utf-8?B?R2NFRTNkNGhkMzl6dU1Hb25TMkVEMHdGUlJxMGd6QjIzenpjUWRUTXZvajZv?=
 =?utf-8?B?UzE1blZWYUtWTElucGdFV3pDVHkxSE1MU05naXZkbGNFcERQWEJDMDk1cWFW?=
 =?utf-8?B?cS9tUk1KMmxvZ1o1RHF5bFhqZXluRXVBRnpocU5ZeHRjSnVnVHhZZXozakJh?=
 =?utf-8?B?Y3RiamRua0NrNEptWGEyRTMwODZ1L0FsZHQ5Yk42eFBHQTRQOG1PYXpvY0ZG?=
 =?utf-8?B?M1dNSEVEbkptQ2gxN2g5TzcyTHFXajJ2djc2c3lPWHNQNFNHSU9JdndPODQ3?=
 =?utf-8?B?VUxPMWtKY1I0N3A0b0l1OHlUbVN0eFRpa3AwM1dlY2l4OE0wRWgraFZRYjNv?=
 =?utf-8?B?NHZwUGJOTGQ0TUliMUNFYzFpbTFlYVcxbFhNdlE4ckR3VE5xSXgxMTFKd0Ur?=
 =?utf-8?B?bE84WllMQlJRZXNkT3UvVlpBci9kVEJBUEZRQndtZGtieDNUS3Fua3NSTlJF?=
 =?utf-8?B?QUlaancxNG9zdS9ISG9LZTBsODErdHEyNWhZeGg0SFNLYTdObUdRZEJUbjV3?=
 =?utf-8?B?N0w2TlNQZDhVL0liaG40Smd2bmxQM3FGZ0xtYXVwTFU0Y2tRZlo5TUswWGJo?=
 =?utf-8?B?dGxzOXhlaUJLQ2ttbm0xZXZiS2hzbHBwbDg3SVpRYVE0dTBGb2paMGVkUHZE?=
 =?utf-8?B?eU5IblZZbFUzT3B1cmxsODBuNzNYRDhVOWx3dmhTTmh4T2JucEgyZU9RYWta?=
 =?utf-8?B?SzZqTjJ4Sm9HK3RIbUF6V1UycW13L2N6TXEvWE4xdmZUVmtvZ2pjZWEwRitk?=
 =?utf-8?B?WjcrWGthcUlGc3hJODNsQldaS0tJTkM3UlYwK0F1THBqTkdMUi9iRFZUR1lp?=
 =?utf-8?B?SDJGL2xLeUhWaXYzNkJYK2k3WUt5eWxtZkRxL2RBYzcxUXIyTHVzblhCVVlC?=
 =?utf-8?B?cVNrTHdxRGhndFZjRGw5MTg1QUJ5V0tKNnd0YU9SbkxRbHAwU0orSFdFMVFo?=
 =?utf-8?B?M1d1MHJ5YjlET3RUZGZQWkZ5UFpKd3VEY1RTYk5RL0FsSUg2TURQNHhicnk5?=
 =?utf-8?B?dWgrci94WDBSQWlUMXBXenRMYWVNZUx5TStWbTV4SHh5VlNLaTU4Tnh1ZGwz?=
 =?utf-8?B?S0k4RlR3K0tmNjR1SGJxYU94TllObGEwM01PbGRtRmhEZVlaS0x1cG43RVo3?=
 =?utf-8?B?cVM0d2g2Q3BwdkFFS3R6MDlNbG5nYWJrWjV2MC9SaXFmR2VmYlE2WjYwL1ZF?=
 =?utf-8?B?MzdLTVlRWVpPTHROd3lmMW1JSEk5c0UzUmZPNHBJNkN1MWNPdXBWN0c2Qm8w?=
 =?utf-8?B?M05LRUQ5RkNMU3N0b1Zodlp1a2xreDRaTmptdHVtb3V0UXNQWHRORlo1S2tn?=
 =?utf-8?B?MXNIL01KTktXYnBCbjdXS2VlRDI4UExoNVdrOUg1K3ZwaTJZVUNtemRpNHkw?=
 =?utf-8?B?eUlQa1hkejRrREUvekYwS1JHMXY2c0t6VGFEc3M5cjNKalBKb2RGbjVlcGlX?=
 =?utf-8?B?OWp5UXk3NnRiUTNubTh4Rkh2NUpKaC91YW4vWWZsQlcrOGpncmpOdlpMR3pG?=
 =?utf-8?B?ZDBlZXc1a3pyMHRoWVlaeC9rWUhqT2tiWkZwTVJja3NXVkM4Zng5TzRWRHY3?=
 =?utf-8?B?eHVpbDQwZFhnN0tRMEhkempMRktnb2VmUkI1NXVWemVnM2kvaHZmRlduRlhi?=
 =?utf-8?Q?n925LhWoUS5ECtNLcT4jXU/N1Q6zzG27?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2l6U3VpaGtBaE95d1V1Y0NlQk9PMW1CVDU5SFUyUGxVOTE5TVJYYllpSUEz?=
 =?utf-8?B?cS9ySSsyeXl2YlkrTEZ2a21nczZMVDhzUnZrNHNLZVkrSHdEclRUMzVhSnB2?=
 =?utf-8?B?cDJObGozcGt2Y0s3RGlpbHVoYjdBd3JmZzc2L2p2anY5OHJlanIyeGpkNzRH?=
 =?utf-8?B?OHhLWnN1Mm8vaktqTUV1R2g4SWlOejYzRFBBc2t6dVRSVDdOOTRuS2twQTNx?=
 =?utf-8?B?dEJKQlZFamxrU3YvY0xXWXJVZDRYMWZPcktNZUVVcWs0S2YxdEc1NmkxUVNN?=
 =?utf-8?B?ckdHTE53YmhLNTF6TnZHdmdjNWVpcTRnWm1EWFVLWjd4dEpSNTlWZEdxT1ZI?=
 =?utf-8?B?d1d3R1RUYnpRcitOQ0twcU54SHBsdUZ3YnNJZ3dIbkdGQS9lcEtKbGlRQmZn?=
 =?utf-8?B?SStPQllPam1hN2pqbkJDYW9sZmk5KzlmUXpSMGRJb3lWTUJJZXF0MmJmUWJG?=
 =?utf-8?B?V2JaNzhuMzdZMEN4eUxJUS9XRHJPbGZpdWxFUTh2MW1wRG5YVVp3ZllaUkk0?=
 =?utf-8?B?Q3lVdnQzYWZmdXZ5aFp5RWdLaTRiWjkxSFBVYkVjRGlFWHRjU3lyYUpTSUx4?=
 =?utf-8?B?emJ6cDU4bFZpNTNSd3FNRldoUjZoV3NGQXc1OG9iQ1YzSERqcEhCN0E5ZFRz?=
 =?utf-8?B?SllXbG9hTkRjSXZNSTZJQXY1WjJINHM0bFVsS1ZSU2MyTmptaEt0SUJCbmEx?=
 =?utf-8?B?RTZadHcyeHRYMEFkZDBpbUNkZWJaTEtuUkxNRjZjSFY4enlhV0JhNzVGeWR4?=
 =?utf-8?B?QnR4YlZCOFpJdENlNmtMekFZWlBqNjBQeWtXMkl2Z09DbUhyUGJwd3BST1dn?=
 =?utf-8?B?V3U1RGVZYmMzMzBvMWZqcGVMdXdtVEVrSnlJSW5Lc2ZGRWI1bk14NkMxeWNT?=
 =?utf-8?B?bEticnVub2dEU1p2SXN3VzhJbzBrVnhXelNwZVhaeDdGV05XK0lUZnllVjBr?=
 =?utf-8?B?eWxubFovSHhQbUpiaXpZdy9xOXRNM3JRU0RTcVk1WkZweUFrbFkvRHhxY3hG?=
 =?utf-8?B?U3NxaS9ZZFBGTVY1bEpGUFpRblQ4eG50WmJnSHVGTC9hbEZET2swSlFTVHdo?=
 =?utf-8?B?MkFBUUpSanZYMzREVWltZUFXNmNDa1dIdE50ZHhIYXgxaGpyZVlOV0hleXdt?=
 =?utf-8?B?ejZyODhiZWgyUEpoZEpzU1VZeE1OS2RQUXd1RXRRalFxVTBUU2FuaDVBdkNR?=
 =?utf-8?B?Uy9jKytjRlZLMGpkOHlvbFZKL0ZqWDZxL2c0a2lSR2tCNzkvK0l3a1NuNk1I?=
 =?utf-8?B?aHZ6T25zUUU0RWJCc0dzdExQUmEwdzRYR1dvVzZaWTd0RTAxNkVuVXdJcjU2?=
 =?utf-8?B?aFhhTFpnblRJUjZFSjNxWjBXR0JqNTdGSTdxUDcvRDZVbkxtWnpieHZEUTBT?=
 =?utf-8?B?enp2OFFEUUVwcXVSanVJQTE3b0ZjQzFBRFFIMTZXK0ZrTUZTMUJhZkRIdkcz?=
 =?utf-8?B?Z2E0eGJZVEk1bGhnUjFNcFJoZEh5R2wwcVhwQ3had3Y3dEN0bTBaeEdEajN3?=
 =?utf-8?B?a3M4bDFERE53aVpoeUQzdU1tYTZKNmJtVzRYR0pndHQ5Qnk4a2JSQW5lanVk?=
 =?utf-8?B?VlR0WDZIL1N5US9kOXdJY2k5M0x3MUFsYk96TG8xYXU2a3NIWThhYTA4bmlJ?=
 =?utf-8?B?Ri9VL1ZFSDJ2YXo0cXhHOHc5OUI2ZE5QWm1kUE90TlZ4WnErQzk1S2RDc3hl?=
 =?utf-8?B?QldNTElMZXA4c2E5RUl3ZVVwZWJuR21lN3lTazdrb3NydVpCdjl4bUh4RlJi?=
 =?utf-8?B?T1A4VjhXRUN2T0dWUHZvc2R5NnhidDlNbm9QZU1WTW4vZm12aUROY1lzS0lI?=
 =?utf-8?B?bWxTbko4dnJDajV6eWhocjI3dUxNRERNMFJiaGZHY3QzSkxKQSsybE95VlN3?=
 =?utf-8?B?M2xZbXF5a3FCR2JPNWpGM2R5Ny9SVTlZaEp4eFJicngxbzlBVHhXenozb2dV?=
 =?utf-8?B?eEVSVG1BaERiNGZKSTdnQW92NjJITjAybVpWM1daenNDZGo4YkYxSzhPMEEr?=
 =?utf-8?B?MFdhamdJZXBoOG5POTRHT1Nkc2RTNDhEdHFtUmhsNHUxUjdOOVBVUHRucGZw?=
 =?utf-8?B?cUFWS1lxcnFLaTR4WHYwdFBuK2FnTGQyTGVYcktWb0FsM1JRN1VqT1RZZXdu?=
 =?utf-8?Q?JdVk8EOa6nUe3P0VKyJ91zQbq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4A83639EC0ECC49AB28E742E58D8A39@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e3cdb9-d994-429b-7765-08dd6ae961eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 15:34:35.8790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hDlowAmeqOMKzAgfEq2HH7TdLMITS6kVXyDrzhqjaTGtJE9tnR7r/58ZMk38zn/6J8y/M3MZ/gWWoAJfDXspcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171

T24gV2VkLCAyMDI1LTAzLTA1IGF0IDA4OjM3IC0wODAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+IGRpZmYgLS1naXQgYS9uZXQvY29yZS9kZXZfYXBpLmMgYi9uZXQvY29yZS9kZXZfYXBp
LmMNCj4gaW5kZXggMDU5NDEzZDllZjlkLi43YmQ2NjdiMzRiODAgMTAwNjQ0DQo+IC0tLSBhL25l
dC9jb3JlL2Rldl9hcGkuYw0KPiArKysgYi9uZXQvY29yZS9kZXZfYXBpLmMNCj4gKw0KPiArLyoq
DQo+ICsgKiBkZXZfZGlzYWJsZV9scm8oKSAtIGRpc2FibGUgTGFyZ2UgUmVjZWl2ZSBPZmZsb2Fk
IG9uIGEgZGV2aWNlDQo+ICsgKiBAZGV2OiBkZXZpY2UNCj4gKyAqDQo+ICsgKiBEaXNhYmxlIExh
cmdlIFJlY2VpdmUgT2ZmbG9hZCAoTFJPKSBvbiBhIG5ldCBkZXZpY2UuwqAgTXVzdCBiZQ0KPiAr
ICogY2FsbGVkIHVuZGVyIFJUTkwuwqAgVGhpcyBpcyBuZWVkZWQgaWYgcmVjZWl2ZWQgcGFja2V0
cyBtYXkgYmUNCj4gKyAqIGZvcndhcmRlZCB0byBhbm90aGVyIGludGVyZmFjZS4NCj4gKyAqLw0K
PiArdm9pZCBkZXZfZGlzYWJsZV9scm8oc3RydWN0IG5ldF9kZXZpY2UgKmRldikNCj4gK3sNCj4g
KwluZXRkZXZfbG9ja19vcHMoZGV2KTsNCj4gKwluZXRpZl9kaXNhYmxlX2xybyhkZXYpOw0KPiAr
CW5ldGRldl91bmxvY2tfb3BzKGRldik7DQo+ICt9DQoNCkl0IHNlZW1zIHRoaXMgcGFydCBwbHVz
IHRoZSBmb2xsb3dpbmcgcGFydCBmcm9tIHBhdGNoIDYgb2YgdGhpcyBzZXJpZXMNCnJlc3VsdCBp
biBhIHJlY3Vyc2l2ZSBkZWFkbG9jayB3aGVuIGluZXQgZm9yd2FyZGluZyBpcyBub3QgZW5hYmxl
ZDoNCg0KPiBAQCAtMzAxMyw2ICszMDIxLDggQEAgc3RhdGljIGludCBkb19zZXRsaW5rKGNvbnN0
IHN0cnVjdCBza19idWZmDQo+ICpza2IsIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsDQo+ICAJY2hh
ciBpZm5hbWVbSUZOQU1TSVpdOw0KPiAgCWludCBlcnI7DQo+ICANCj4gKwluZXRkZXZfbG9ja19v
cHMoZGV2KTsNCj4gKw0KPiAgCWVyciA9IHZhbGlkYXRlX2xpbmttc2coZGV2LCB0YiwgZXh0YWNr
KTsNCj4gIAlpZiAoZXJyIDwgMCkNCj4gIAkJZ290byBlcnJvdXQ7DQo+IA0KDQpDYWxsIFRyYWNl
Og0KZHVtcF9zdGFja19sdmwrMHg2Mi8weDkwDQpwcmludF9kZWFkbG9ja19idWcrMHgyNzQvMHgz
YjANCl9fbG9ja19hY3F1aXJlKzB4MTIyOS8weDI0NzANCmxvY2tfYWNxdWlyZSsweGI3LzB4MmIw
DQpfX211dGV4X2xvY2srMHhhNi8weGQyMA0KZGV2X2Rpc2FibGVfbHJvKzB4MjAvMHg4MA0KaW5l
dGRldl9pbml0KzB4MTJmLzB4MWYwDQppbmV0ZGV2X2V2ZW50KzB4NDhiLzB4ODcwDQpub3RpZmll
cl9jYWxsX2NoYWluKzB4MzgvMHhmMA0KbmV0aWZfY2hhbmdlX25ldF9uYW1lc3BhY2UrMHg3MmUv
MHg5ZjANCmRvX3NldGxpbmsuaXNyYS4wKzB4ZDUvMHgxMjIwDQpydG5sX25ld2xpbmsrMHg3ZWEv
MHhiNTANCnJ0bmV0bGlua19yY3ZfbXNnKzB4NDU5LzB4NWUwDQpuZXRsaW5rX3Jjdl9za2IrMHg1
NC8weDEwMA0KbmV0bGlua191bmljYXN0KzB4MTkzLzB4MjcwDQpuZXRsaW5rX3NlbmRtc2crMHgy
MDQvMHg0NTANCg0KaW5ldGRldl9pbml0IGNvbmRpdGlvbmFsbHkgZGlzYWJsZXMgTFJPIGlmIGZv
cndhcmRpbmcgaXMgb246DQogICAgICAgIGlmIChJUFY0X0RFVkNPTkYoaW5fZGV2LT5jbmYsIEZP
UldBUkRJTkcpKSANCiAgICAgICAgICAgICAgICBkZXZfZGlzYWJsZV9scm8oZGV2KTsNCg0KV2hh
dCB0byBkbyBpbiB0aGlzIGNhc2UgKGJlc2lkZXMgdGhlIHNpbGx5IHdvcmthcm91bmQgdG8gZGlz
YWJsZQ0KZm9yd2FyZGluZyk/DQoNCkNvc21pbi4NCg==

