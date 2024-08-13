Return-Path: <netdev+bounces-117904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4090494FC0B
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 04:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6522F1C211F0
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 02:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293DA18028;
	Tue, 13 Aug 2024 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DPOeMylN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9367B14A96
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 02:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723517897; cv=fail; b=tA2eKylJnyUI22lS9BslrZvFkK97pZ/ZCxZd9E6gq33TIG5BiFVE5kBjCs1s4OzsBTSrrQZdYlVNy8AuBHvcyE6vTGNkWb9G+szP3n5J3hiCt51ZlyfbSROORzZbtuZ2OS2qyTJ3+QG59CwWSdugTttMFNwacQazu02H0CliBwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723517897; c=relaxed/simple;
	bh=drqvnMAVf9syFRiU+DcnWZ2bI2A/xpbzGXebL8gq4xQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SFKdgQVLDVZ3zPBP1fexQDvdgFa87nmCUYAxsHN9RUodEuqvNz4o8dt5i5EjumjpGIeRPXH3EUvyjqx9PMW//botvmY0qwe+hWGOXcrHGCp2ZqkdfAbrgq7nQfuwITsF6IyvsVUN1biTUziuhgL5Kby8w6Af/ZSLfWBOMGZN3DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DPOeMylN; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FG3wTNk13vm0B+CdkDwz0Ku1R+rbgJaWxbLRc4CsQ541we3Ea5nn3sse0I/NRdoXTBjNicG0EBBBssDO+z7l+l5NVVpYFhci63wtmEc38ZinaAKcX8KwbMq7dJXBmxK9aD0DoJChQMm6VrJx7oys6bJNBY6ZyyA4aSZamyl/Lgv7zrroE9X1IfCnzymGanxbZmCoQrtI1rxrI1jggSFKxXwgPLh9/QAtdPnABfA0npny5xtMil3M12JwY92Lk7nNcsIGgwkntcP0yWAcRIQ9gQoZNSQS6CKkKdcaV/lq9IEyrGPRjs47YnOCXxxoN9jNwKeyzI+zPMyTmt8WAPGTfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drqvnMAVf9syFRiU+DcnWZ2bI2A/xpbzGXebL8gq4xQ=;
 b=yY5U5R/8vO+x9KJOPsUDziMmbK02xI7RPDX6o2ovWX6ptnWunmeGdN0XGSVojWk39SSe4RsT+OP6HAyk5RemuXVuFHMrBNgx0jJbFkknMhWktdRmEsCtEKZMZNWSVlyZiqWpr7Dczd9vbWG/lPURwxdQ4Dfn1gute4920xzDkC9Wn3lxXMIKJLZ7MDSonUfcjblBOa/IRn1i2CDjRUJ7rbkAC5tIR/Er/QNV8DmgoE8BDRMmXyBBqsbYd0QXOCZdKzRi7Gf9ENmgYjiTvOyVzqpLUHrBi1TcecN1G1Cno4AXOWFj3U8xprinAb4FwyJpHEiLg8FIzoWLK8/cvCrUNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drqvnMAVf9syFRiU+DcnWZ2bI2A/xpbzGXebL8gq4xQ=;
 b=DPOeMylN81KttzU0El6V0sJfSom1XK1NNXwHmXuxaDNzX63IZyIU81qarXkjS0uLEA8zM+mr7Zfm04XwYvYco0jMdSqd7rGdMzUi2a0AhPEcnzpph25Yg3b59kMzbvDUSIifLWQ3Shx9wRA/C+AL1Dz362HBJvdPCyAFdJBq0sJv3nQxw5aKrgjRsjruvWiijOMgMWbj3PjYLrvlDgt/mVrlpckILyKSizzJIR+o7D2jukQgGJm2HgdL/RXcauTfZkMCJOhdz/suxpwzjSq9SneeUS8zNq4oGCTmoDrZKom/YUjTFwFN2g6vyJZe+PdHeZ01DE/gPIkE+UGrXDjpCg==
Received: from IA1PR12MB8554.namprd12.prod.outlook.com (2603:10b6:208:450::8)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 02:58:12 +0000
Received: from IA1PR12MB8554.namprd12.prod.outlook.com
 ([fe80::f8d:a30:6e41:546d]) by IA1PR12MB8554.namprd12.prod.outlook.com
 ([fe80::f8d:a30:6e41:546d%4]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 02:58:12 +0000
From: Jianbo Liu <jianbol@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: "liuhangbin@gmail.com" <liuhangbin@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "andy@greyhouse.net" <andy@greyhouse.net>, Gal
 Pressman <gal@nvidia.com>, "jv@jvosburgh.net" <jv@jvosburgh.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net V3 1/3] bonding: implement xdo_dev_state_free and call
 it after deletion
Thread-Topic: [PATCH net V3 1/3] bonding: implement xdo_dev_state_free and
 call it after deletion
Thread-Index: AQHa5vUrWi/gseXBCEqaGlxcFyce2bIkZyIAgAAkNgA=
Date: Tue, 13 Aug 2024 02:58:12 +0000
Message-ID: <14564f4a8e00ecfa149ef1712d06950802e72605.camel@nvidia.com>
References: <20240805050357.2004888-1-tariqt@nvidia.com>
	 <20240805050357.2004888-2-tariqt@nvidia.com>
	 <20240812174834.4bcba98d@kernel.org>
In-Reply-To: <20240812174834.4bcba98d@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.40.0-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB8554:EE_|MW6PR12MB9020:EE_
x-ms-office365-filtering-correlation-id: 7809cf8e-f81d-4510-808c-08dcbb43c542
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d3ExbVFHYXBCVHlSdmxudGJzazBsODZzRmpjbXV6b0dWWHNhYVloNVdaK3BR?=
 =?utf-8?B?UEwxbHB4OVJIZVJzVGhEWlNBMUF5d3VvenJlcytLUlhTQ1NraVZWczExSlB5?=
 =?utf-8?B?dDF0N3hmUGdoMnFzWnl5U3RNTVFKRHcyMDZMaWJ1NTRZZTdES3U5dEN0bE9S?=
 =?utf-8?B?aFlZOVpWWUFtU3pJSWlXd3hUMWZNYTB1YkF4Z1RiUnpTcG44bUlqbWI5K25V?=
 =?utf-8?B?MWdvcjBqRHYyUWVyaS96ODQxYnY3aWU3RTBYQ0l6cUFGbkRaTnA5MGdycnpp?=
 =?utf-8?B?bG5CcDUyOFMxNko1N210YnYyN0FQL1NOU1ZZSlBPOHlvMUNMckVuTHhNM2Fh?=
 =?utf-8?B?d05wYW0zWFIydHlRR09lUUdVODZBTTQvK1UwejJLendpbzYzTVNvQmV1WWVo?=
 =?utf-8?B?NGdiSlFQNmpJM3N0czBhR3FPL1lmR0tTS0YrUVlOQUFlSi8wS1NFa0Z6WXhy?=
 =?utf-8?B?ME55UnZuQ1FURnlJc2VaNFZhSjZsMm1Fajg3bFhkUkFCczM2NmVaVHMvOGk4?=
 =?utf-8?B?Q3NvOFI2VUw2eTR6blZFYnY0WUZ6aFVyME9CTWtMK0w3TDVwMXhTYzU0UXNC?=
 =?utf-8?B?dVNRSlV2clB1dUI5SG1wcGJycWZxMVR2dEk0MjZ6ZmtDbUFCZ2dJMjVJazZU?=
 =?utf-8?B?ZVcwUG9SRmxZeVhYMS9PeENHZ0ZNM1NqdlJaTmNaSDZweVZuVStxdzJ0ekty?=
 =?utf-8?B?WldHditnT0VnUHBOM3k0dkpqc0prR1V1RVk2VlVwVEFCUDdkelVkNGhXSG5V?=
 =?utf-8?B?bkl1Sy91bXVuYmE3dmZvdEVpVnRxNlN5dlF0WUZwNWlvN2tzblpHTjd3R2k0?=
 =?utf-8?B?YUlLTTE0enlYM09FU1hXa1VmR0NNdHZqTjAzQmJvOUxQanVKZ2NaRUR0bm01?=
 =?utf-8?B?TDF6cGNzdGI1VkRyMlpIZVlON3pVQWhuTTNPNFcrMGUrai9iTFBzRTNpL2FJ?=
 =?utf-8?B?V00xWUtBaWdPdVp4UjZyMEI5dXVnQVcvMVp1QThnbUVNekJkQTZXTmhXY3Vm?=
 =?utf-8?B?UWlCQU0rTHdKS3A2ODBUZWVubnBCODhyemdzTFJOVHB6RUp3Yk5hTjhaNkFH?=
 =?utf-8?B?UERzSDZ3aDQ1bkdVVFhadnRQblJLUUtOUXRpSzdaUVZvbjRFRWtLejdSUm5h?=
 =?utf-8?B?K3pJcS9mU053RnJQU2ozOFkwK3pQdnhzNDhOODZVWGpGRHhWNDFkUi8vd1pR?=
 =?utf-8?B?Y043c2dZLzhrc1Z0cEJuSlJnbnZINkVYZjFqZXJvOGgwQlZiM1V2THBwbU05?=
 =?utf-8?B?OFFMYjdZTVpPZXRvcGFlQUQ3eFhubDhsR1ZsNk9EWjRJakZZZnlLTU54dE14?=
 =?utf-8?B?ZGptWmd6cm9BNjEwY2RaMXZya0R5V0xPUkx2YnpTdUtPa3BqbENRWVU1dHVV?=
 =?utf-8?B?K2s2c05BVkgwSDRKQ09HclRoQWE2MkhteGRUNEJUWHJTeFhucU1ZUE1wWUYv?=
 =?utf-8?B?ai95a3VOL0N6SnJKc2psa3R5cmtTekFrL0RpeDZKemlyN3p1cHNZQ0tDaCts?=
 =?utf-8?B?WHVNbk50K2RGODZhK1hpVEc4NkJTd3UzTE5zZFVlZExWRkFOSzBZY1AzbS9k?=
 =?utf-8?B?WmIzdEJxU2tpS1RMajNramcya3NuUUVkdnAzbmVoUjloQzZsVGgxS0FYbTVN?=
 =?utf-8?B?Tko4RUVMYlNFY3NzbDUzRUxXVEdzVng1b1N3blRtRnNObjFEQzNNcUQ0dkRO?=
 =?utf-8?B?RHkrcU5EaHNma3hTOEx3TUh2aWNlSnpBR0toTm1RZW81TVRvZS9pV2ZDSlZT?=
 =?utf-8?B?RWdLMXc1OWs1Q0N2Yk95K2hOKzl4UjJsdnlSVVNMNVVETVlCaFRFOEF3Mi9s?=
 =?utf-8?B?Q2EzeEVCR3FFR2dZMUxLc2pucU05ak9oWFFFLzVDbWljL3U0MEY0WWhyenY0?=
 =?utf-8?B?YlNOYUNPeVBJZW5OczQzb3NpQWNwMmNHemFZc05pYlpXZkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB8554.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UCs3YVNGczVRSnJXanJKbVloTUFPczB5d3M2RWFIUjFrbDlQd1NSY2tBazBV?=
 =?utf-8?B?ODFqVEZjQW5RTS9haHVrckRZWDhqeVM5Qm5WQmF5TWRwRGp0NWM1YmN2bVlL?=
 =?utf-8?B?b25IelFRQzlYSjNMWWVkTUN2UXJMUGErRFFkaWFJWlQ2REtyVVdac1czV0hV?=
 =?utf-8?B?Wk1RaWFubk9PUFpCMFB5K2k4d2pxWDdVZFZRRFFaTHBLZnRiZ1FBbHVoQ0Iz?=
 =?utf-8?B?ak1Zc3RNQjd3aWJRdCsxTkVHVjhMNlgwZ0RzcVJRWlNvam9pRkxPNlZ5dGk4?=
 =?utf-8?B?eUxpUER5VUhqaVhVRityNHo1TXZWekNtdXBMTUtOS3pHSmM3NndLOTB5Wmcy?=
 =?utf-8?B?V1Byc1ZmU2t6aVBLb3AxcVM4OU1DbUJjU21MbjR4NU9vWWtpTWNVTXg4Tkw0?=
 =?utf-8?B?d3NvenY0R3FJM2FLYTBtSXB6S2NZVXNPNC9TZnhyOG1Oc1phM3FsaGtnNk5n?=
 =?utf-8?B?QVdaNmZOMzhRMTV1VmpMbUc0b0gza2FDZVQ0eVNraXlXSURaUUlSeFBCbExV?=
 =?utf-8?B?QjJvR0hxUUNTMHFDaUFRV1hzVUxWNlNpY2tLMTFJNXFBRk43UFF5Y29aNElG?=
 =?utf-8?B?byt6cHFwVnExanJuMm43OE1HaXc5WEpicUV1czQ0NDJEK1BKQmRwYUZVRzUy?=
 =?utf-8?B?ajlOaGl6eHlRRGg3RUNkbHdlbk1TcW03TjBHbzExT0g2QndkWVg0STBnK3FR?=
 =?utf-8?B?dkNGaXdBZ3d1T3AwSUI1RlU4VWpEY0dvZytCREo4UmRoU3h6RldaT25zSWpJ?=
 =?utf-8?B?ZENUcHcyK0hselVNd0tNL3g0SCtrQ2tMOGpvOUljNXVFSGVqbFIxamtTdE0x?=
 =?utf-8?B?OUZBWnhQdTM0UVFyN2lPdEVmcUNoZUtUWDUwVTI0NFpDYW5POGdHcy82Smtm?=
 =?utf-8?B?U1NsU00xSS9MNSs1emFFYWU0R1BKVDNpZy9qeFd0Tjd5a2FxVThremthL01o?=
 =?utf-8?B?MTAzK2Fzd1FPb1ZlUlRyejY1UlNlUmgxM1R0S3UycTFhcjcwUmgweW1wMnQz?=
 =?utf-8?B?dXhTL1NlNU1BaXRVZEhyS0hWQ0NCU3ZNSlp6d3ZseGN4aUxkS0krZFIvTFVj?=
 =?utf-8?B?Y1NYdnVMUFZ2WWJTQldJQlJ1WUgybTBRVUx4akFteWtYMTF0SjB2NVpPYkdv?=
 =?utf-8?B?UTRFMnJzN0NSaSszUlNSQkJJejNib29XLzBPcHhCMitvR2tDNm1IWTBZUkxw?=
 =?utf-8?B?U1Q1U1cvSzMyUWtRdjA5SFdUeStvaUZWZ2JNdWJXampDWEFVSElnRE9nRlhu?=
 =?utf-8?B?RGtyK085Z1FhdGJCMUJWWVZkbFhzRCsvNnl4S3ZidUJVcy9Wd1o5WVJNdVc3?=
 =?utf-8?B?MkRoSFZYY0U3MVFOTFRCYStPYmw0UWQzRWVtWVc5ZHNYSHRLYittVEhBQXdN?=
 =?utf-8?B?ZFd1eTZEWUluVGV0MnFObnNrUndiWWpMaVJ3Y2RDUnhvMkx2WlNXZlViYzZ1?=
 =?utf-8?B?RGRTVHV3ekVZVUcwVkEySW0xVm5oT2FXRlkyMWtKQm8zKzJ4ZWt5b0lJSVB6?=
 =?utf-8?B?c3ZRcW90NHRWSUR4RXdCUkhoZ284bFQzQk5iaWwwd04yZjc3WGdyZnM5anpa?=
 =?utf-8?B?Qm45YjlrcGJIZjRobDIwQnhWbWxrWmliemNZNUVIbnFRa202Q2Z5alJTYVRH?=
 =?utf-8?B?YUJrV0hIZ2U3azlDclRER1Z3MVloU1BsRjNsMlJPblFNQnFyU1Z0bGo3L0pn?=
 =?utf-8?B?MitYekcxL2puRWFaMmQzdzJoeU1uVXZvRGdzbHNYcStsTStNYkMwb2tpTmNX?=
 =?utf-8?B?RGx3RzNNQTJZRDhnTTVnTkRmaXgrOS8rYTdWQ0RtRGcrK05XQU1NbGQzQnUr?=
 =?utf-8?B?Ukx3NmJuYyt4K3FwZW52ajQzcXpjTlp4SGZKNGQzQmtRcUFPWDdwKytNL1lI?=
 =?utf-8?B?d2oxRHpIU2ZNa1I2ajNpOFYxb1VUNUcrNzFIQkl0Y0R6UVFPdk04eTJRTGg3?=
 =?utf-8?B?RTJRbFdlZ0NKcHJWbEFaMDA0bW9IQU4vcUMrd2xrek5HeHpkVmNCR1pCdGZ5?=
 =?utf-8?B?cmdtSTE1dmpnaE55WUJZOFIwQlBmWTF2RXhQZzZOUnpVVnA0b1JnTk1GckNp?=
 =?utf-8?B?SFMxWGgwa2FvSkMxM295dDlzR3lhdC8wR24vK3g1cWNIaHNaOVUxb3h3UFlz?=
 =?utf-8?Q?WebicHlvRC/igkd4DvcJG06it?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0ECDC64EA275F04995FA949469C4128F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7809cf8e-f81d-4510-808c-08dcbb43c542
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 02:58:12.6148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f8ipDX2Qm6J/sAGO+cedXuyUVGunoxI2TEeEPWC95KoKHYvoD2JvsI0S1sLzwoLSC51GF8qLljKDjVU01ahqvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020

T24gTW9uLCAyMDI0LTA4LTEyIGF0IDE3OjQ4IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gTW9uLCA1IEF1ZyAyMDI0IDA4OjAzOjU1ICswMzAwIFRhcmlxIFRvdWthbiB3cm90ZToN
Cj4gPiArc3RhdGljIHZvaWQgYm9uZF9pcHNlY19mcmVlX3NhKHN0cnVjdCB4ZnJtX3N0YXRlICp4
cykNCj4gPiArew0KPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBuZXRfZGV2aWNlICpib25kX2Rl
diA9IHhzLT54c28uZGV2Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBuZXRfZGV2aWNlICpy
ZWFsX2RldjsNCj4gPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgYm9uZGluZyAqYm9uZDsNCj4gPiAr
wqDCoMKgwqDCoMKgwqBzdHJ1Y3Qgc2xhdmUgKnNsYXZlOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDC
oMKgwqBpZiAoIWJvbmRfZGV2KQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBy
ZXR1cm47DQo+IA0KPiBjYW4geHMtPnhzby5kZXYgYmUgTlVMTCBkdXJpbmcgdGhlIGRldl9mcmVl
X3N0YXRlIGNhbGxiYWNrPw0KDQpTaG91bGRuJ3QgYmUgTlVMTCBiZWNhdXNlIGJvbmRfaXBzZWNf
ZGVsX3NhIGlzIGNhbGxlZCBiZWZvcmUgYW5kIHhzIGlzDQpyZW1vdmVkIGZyb20gYm9uZC0+aXBz
ZWNfbGlzdCwgc28geHMtPnhzby5kZXYgaXMga2VwdCB1bmxlc3MgaXQncw0KY2xlYXJlZCBpbiBk
ZXYncyB4ZG9fZGV2X3N0YXRlX2RlbGV0ZSBjYWxsYmFjay4NCg0KPiANCj4gPiArwqDCoMKgwqDC
oMKgwqByY3VfcmVhZF9sb2NrKCk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgYm9uZCA9IG5ldGRldl9w
cml2KGJvbmRfZGV2KTsNCj4gPiArwqDCoMKgwqDCoMKgwqBzbGF2ZSA9IHJjdV9kZXJlZmVyZW5j
ZShib25kLT5jdXJyX2FjdGl2ZV9zbGF2ZSk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgcmVhbF9kZXYg
PSBzbGF2ZSA/IHNsYXZlLT5kZXYgOiBOVUxMOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHJjdV9yZWFk
X3VubG9jaygpOw0KPiANCj4gV2hhdCdzIGhvbGRpbmcgb250byByZWFsX2RldiBvbmNlIHlvdSBk
cm9wIHRoZSByY3UgbG9jayBoZXJlPw0KDQpJIHRoaW5rIGl0IHNob3VsZCBiZSB4ZnJtIHN0YXRl
IChhbmQgYm9uZCBkZXZpY2UpLg0KDQpUaGFua3MhDQpKaWFuYm8NCg0K

