Return-Path: <netdev+bounces-273321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id G+pqKpjTymkOAgYAu9opvQ
	(envelope-from <netdev+bounces-273321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:48:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF6F3609EC
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE9473016AF0
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 19:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B700282F00;
	Mon, 30 Mar 2026 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AYJOf2Zm"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B0637EFE3;
	Mon, 30 Mar 2026 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774900117; cv=fail; b=S/3waQqI/T2BRSFtNqaLWtcSsYXHRjkTa1bIHRliwiF9D5FfFIL2JVpvgsTGrqtu1T61lC2DkQ0yzvlQ1Y2a7RL7WQ3b+P4WK5BVouhEmD3nODTovwAw3TgNY5ym8dMHhvVS/TV7EVftFcUKgirQz/RBZJS3z67Crtpb8BPpqxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774900117; c=relaxed/simple;
	bh=3dJB/HR80ud44I9pmWrpeXtkQpy9CkrjolmdSslBAzo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ed8j1+diobxfmDVbhHM5I2O44F3+rP77JZa+O1gqgg+TjzKnKqnDdlQpqt7Nomh5A2GX3YpNtlsr53jy1M6yscxSeeqCOSbjEJJIcYz83RGr0KRClSRne0NWfw8+QYOt8DwI5G1oGczacLz57ZSG9YjmdU1LRVnrrvA/ANxseOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AYJOf2Zm; arc=fail smtp.client-ip=52.101.57.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KL6Vgl9HV6uQT7Tg1mMVJc8bRreYmkqYxgvw/UvjBgoRhXnPSsBTllNH2xX3qAyp9KpjYaCk0BjVNKcyXAg/R1XRDSjRl3J4kfjXDv7zC2T26L+DjupjXvCKQBdCg/aD0iPrD6qH8OsbLgX6y3RlagyJZgCCAi1aPZinjeVQhClLOsVN2/5UJ0+BQaEunkmbp8nzH1xuCFA6XM3RWg/LzeMV8v9S71DcR4fmQteJvOelPfU37EGCZoTXPaoG8wxDDTS4sW6WdURkmlGzhmxmyXTIkj2HsuIC6KxgFASO1SlMH5fyOP0HepXMDSWRJfHJe2Lg16k7JfdGYGVktW9eWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fp5MFBemFUAw5D+oCXqJRv3dRb7YhzRDN/7lJg+J694=;
 b=hnC8mO4OaeQzddd0fR0q4SDXF3QuCm/FhKpFX39c/zgD0jB1yWzvyLfSNje+i8w+lMCS1EuP4TO3/RUjvw+EaN7NHAld2LmRgkOxgtjk+Iz5ZsFRVwy+NzYxBSMawm1FttCNBi3aoX0SPCs3tMXfu78eAcA4ps1UqfihzUQy7BzL6VGJxq+88VAFpQEsGsZsnbirCAxE3Yoq+HGq1vUO67tEOBiNdKuGj8IAB/NBcJ74jQKevJbw7vf86hkigN2ujPG18MCrGHoHXNh0QMYrhCRyx3flH8zX3XkpBQJnM25+0sSHI6qlG/ZLG4mU0r/Bbf5+bXcedqawyfqkyvPUDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fp5MFBemFUAw5D+oCXqJRv3dRb7YhzRDN/7lJg+J694=;
 b=AYJOf2ZmfPdpzxznQBmNaSosr/1PbxJvSI0brbMtmXcD6q2A5i0WfYgbsLHBrKGfwpe+JAwijnV9pyFueKfmNgblsv+8vmANOMc8xxFowUrJ7GoU4XLG74c4oF3zo6gXF5aZy3AFBBMYZfbpvnj6VY0qJ1hrt+udibK7+KW/X5N9I/gCcbbT9CAmtCAGiyQCI7/eDFMowd0+WQrZKWUv3XbqGNAkUL/K8eXSAuVKJ1GiTXVj5YcVT7UrC7FbeAceEI9s7oB49qKKjlpDKRD1qdRS18XyEWvaEww3oHoDbUekC5ZbFLRbZS87sQ0P50PWbuYJXi6dEEYL3g97vb+27Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 DS2PR12MB9664.namprd12.prod.outlook.com (2603:10b6:8:27b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Mon, 30 Mar 2026 19:48:27 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 19:48:27 +0000
Message-ID: <f83ad183-6e00-4c61-a364-6fd0bc0e50b8@nvidia.com>
Date: Mon, 30 Mar 2026 12:48:23 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/3] net: bridge: add stp_mode attribute for
 STP mode selection
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Petr Machata <petrm@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonas Gorski <jonas.gorski@gmail.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260330022107.670566-1-aroulin@nvidia.com>
Content-Language: en-US
From: Andy Roulin <aroulin@nvidia.com>
In-Reply-To: <20260330022107.670566-1-aroulin@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:a03:334::7) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|DS2PR12MB9664:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eeaf31d-44f9-4e5b-2aa6-08de8e954fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7Uw6JCEWCVchIpBusp/hfdvkrCEkhXVWVQV4fcgLhC0bzwTryDPxBbS2TKVptmlOy0zBf+stigf8aD0XI0SZhvC3MuHRXfPUvmUkDdFm8/KHxdRDN5xE3a05yq7Z5yFLjcKYo1mce18YyboPIA4aUMsvz0Lesu9s4Xq3w3RAAIpsVxGjLubZ/IWVkzl2yeu6KULrt57cEuGHB9ZywJNqR6HySyrga73fC5drxa/dxTXlkZICflRDvYRDNBQu/Q7381bUogO4GE3HQzk8k7boezVdDj2yPS9GTp5Dj/UuRS/K/S6rNPLYLH/icltT7eoyBHQd9W4kMSJRD9+mqee4cyqVs4BWffrCrSlO6LeHrQPUZ4t4/M5bU0GOe6p+KAjABxOg1eVmPk+HpeGOd4Rn/hVNWeXbFrHj8VOQ2jYQDdu7q350fuv4Escdhl9geg5BNJqn6LQXfGAHdLOeoM28JQQXHc+24YVo9W1bQRlyJLJq4zVkbTEuIEw0FIqPqs/jU6pOHlboQUOiqlRtNyg5Upl7gZuZ6vUCpexzD4TJwetCXrq21vaTIKZXaGvNcZU9iDIw2TX4AzZ+GwfsttnlhctrJRmALgFoDio697iSUQ5Q4CU38432JmFaTyfkzaKhcC2ltou1BGZcs2r7mN3GsOSQEU8nQWs3k/Rzf60k9UsHq2eSVaJznK58ui8kD5LRcYmBqATJtKbIfyEK+vwBtYrepQEUvHG3axFP+0fFth8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wjd3b1ZnVnMyRGFQV2hWY01nN3Z3Z0NvdXpTcU9ZUGNHeVdSbi9YakNzbU9X?=
 =?utf-8?B?cytscHBPSHl6eERWang2V2RzQ1VDbUQwNnJPTDkrbkVYRzkwVUgzZlZUYjhR?=
 =?utf-8?B?NDNnOU5ic1VVYkY1d0d1d3JtcWplc1JoeUVLSE1PbkJsQUwzWUhPcDFuQ1Qv?=
 =?utf-8?B?U0RpV1NoZGNKZXdsblFGbWN2UzF1ZHkyaHJwbmYyeFN3ZFBNNktZOUJSNGJF?=
 =?utf-8?B?TVpxSUdva0x3a1gxdGl1bTJIR1J4OHdsMGh2amd3QjMyRjMrOUIzS1FSeC9x?=
 =?utf-8?B?cjJkQVhOVVo5RVZYNGREelM1SFkyWWxrUUNLazJVaXRUNFlocTgyWFRDNXc4?=
 =?utf-8?B?NHBQYUxWMkJIRjgxR3BsNjFwUVp2UXFvNDJ1dmJydzdMd2dIRDA5bTNOUDl6?=
 =?utf-8?B?bEZ3eGp3dFlIWGY0c0doMi9Fcm1rbVlNbWk0VjcyWDFWYjdnQk9UMGZnMFhX?=
 =?utf-8?B?Q0gwaUR0Q0N6a3BVMGs3V2xzUGZzNEZxbHgxNGg5TlpaVEcyaWYvZGUxV044?=
 =?utf-8?B?eVBhbHNuNkwwV0JTa0JCendIbEtVenFqZkVaRVNHQm00QTNzdWZYT2cwSng5?=
 =?utf-8?B?Wll3REltQ1VrZG94WEVCNFZGL0YwZTdWb0pKZzMzbHdJdVI5Y0JGVkNLc3p4?=
 =?utf-8?B?TDRYV1ZkQWs4T09CZHM0NVVrTlN3MDlYZHk2UWVRTnFIQTI3elQwS0Z0ZlBw?=
 =?utf-8?B?TmRTMHlpdlBGTGxJYXU2Q0Ztd25GYnd1YWhYdk5wQjFLWnJvSkNVbTV6dkYz?=
 =?utf-8?B?eG1qYnJBamJEQ3BGREMwYTNYLytxWWpnWmNrWFFRZ01qUWlqeFZ3TCtDNUsy?=
 =?utf-8?B?djR0SVkrbDFCdGVxNmQrRDhQRGJqNDUrNmFZZHV5R1MvclhiSmZERUc3L0Nh?=
 =?utf-8?B?VVYvS3FkWC9kWCtJQW90WUtqaE1QaWt2ZVY2eSswNXRMNm1XQ0Y3aGNIbC94?=
 =?utf-8?B?YTBEeDhOVVpqaGtPQzhMY3F4WDRrY3RkMDZlejg4VU9IT0ozdDNJTTRrM09x?=
 =?utf-8?B?WFplaGQrVzhYMDNyMEh6L2dwUDZtZmVHVWF3b1N0TEI5SFhxaDVPMXpwa3Mr?=
 =?utf-8?B?aDlIRHkxbzVjS2RYVk5lUmEwMHcwK1BqSHRHSmhNRlppY0pJaE1FUXJWdkhJ?=
 =?utf-8?B?NzVBRFFRc1Y1M2U2YlN3aEN1b1RFdU8rZ0tHOUJnWlhOblNqMExSN2ovbVcr?=
 =?utf-8?B?MHZXRkwvcHQ1WE9oSEIxb3dHMm5VYURDa1hleU5QZUdGa3MrOHBuL3FaUmNX?=
 =?utf-8?B?U0NBZjZ4MTZjQVF2bVFOVjFQWGxzNERNdlRuS1B3NmNib3o1T1E0TXp1elhs?=
 =?utf-8?B?ZjYxdCtvOFY2MVpnelp2aTNpcGNSelptcnRUTm9QQVVWd2F5Um5MaHQ5cGZH?=
 =?utf-8?B?R1JESHNldlRkMnVVNjFNT00vM0xDaHMzTWZ3QUJiU2xQcU5nYUVYS09XUUV2?=
 =?utf-8?B?SWZQbjlSQXAvdkxjYVVUMm1iRWRZblZZckVWMmxOYzAyM2wzWm5pYWNyejdR?=
 =?utf-8?B?OXVkbzBOeXYzdFBNRDdZcE5XV1ZsV2ZwS3E3VG1CdXJ5Njgyc2ZaaGN1YjVE?=
 =?utf-8?B?OXJLNXpBb3dFMHJXeUEvVTlRTml4U0g0RXhGR1N3SytiS3NhVWFZSG5Gc0ky?=
 =?utf-8?B?MjFWWjRPd0YvcDNPMlIzTmJoWVc2M09nZzdmTk52Q2lDQ3hSdkdwSE9TQ3h6?=
 =?utf-8?B?MVFpUStiTTJuSVNObWRJY3dGVWNEZXkxck5BOHFWbmFsZy9UQWxIaGI2N1lI?=
 =?utf-8?B?Z2VKb2tCZ0ZseWtCSUdsM2xxWjM3MEVPYmwvYjdCbjJ6TzVDYkpsYUszUXJO?=
 =?utf-8?B?S04vaC9sUVVsSzBsb1dHcm5mS0FJMEhMYmt4Z2lqamRWR3pjT3o5eDRZOE00?=
 =?utf-8?B?NDQ4NVdudlNOY3FCVVlnU09UYm1USTIxMVlUZENva0pJSTdQWGtTTmhQdEpX?=
 =?utf-8?B?bzZsQ1JQQkNlR3ExN04zdy96ZlFVY3pOZ2t0Q1I5eUhzUlRET0o0RTh0S2tU?=
 =?utf-8?B?UGE5MGtJMHArWDFmWUdIY0dXcGo1OFBDbkE0RzRDakFpTlZyd0E4QlhvNkIz?=
 =?utf-8?B?SnFZdlAzSUdUbjJ5ZGhwdEFBaDFtSVFWNC81cndMdk9QajZ5WXhYWENjQ0hM?=
 =?utf-8?B?QUoyRFh4UmhjUm4rdGhkZXdaMC92OGh2MStKdStaejJ0ZTh2cm5BYTFoQ1FS?=
 =?utf-8?B?RS9UWnJMN2xXWERvZVJKMjR0SGhVKzc5OGlEUlU1MGpKSmxlL0MxSHJXRUtG?=
 =?utf-8?B?L1VLWjVpcWdhc0RHSlpPVXBHMmNtL2xVcUVKWDgrMm5TYnAvelE5NDlNRzhU?=
 =?utf-8?B?YWJxZ1BXR3RNYys5S2NXcHN2L0FCa2lTcDhqQkh6Y0FpeW9oVzA4dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eeaf31d-44f9-4e5b-2aa6-08de8e954fb3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 19:48:27.3804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nu5Ge1KzQq2En+zozu6DBJe1CrRgsUuzjJ2q4YbIfc9ST8faJx2JuKEO8c/RD12SF0rxH8do8Pj+SIDaTDUIRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9664
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273321-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,blackwall.org,nvidia.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sashiko.dev:url]
X-Rspamd-Queue-Id: 8CF6F3609EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/29/26 19:21, Andy Roulin wrote:
> 
> Patch 1 adds the kernel support. The mode can only be changed while
> STP is disabled and is processed before IFLA_BR_STP_STATE in
> br_changelink() so both can be set atomically in a single netlink
> message.

https://sashiko.dev/#/patchset/20260330022107.670566-1-aroulin%40nvidia.com

will fix the reported issue in v4.

