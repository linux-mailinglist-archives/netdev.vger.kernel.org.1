Return-Path: <netdev+bounces-184986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EADF7A97FD4
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 08:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D37189D1E9
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 06:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761F626E168;
	Wed, 23 Apr 2025 06:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nj25Dd4+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27537269CEB
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745391051; cv=fail; b=ZYAc4J4g2j1OAeJ7JOrtoFEFY24Hodoam1R1q8U87ajdzPAxI0zifgDDuJ0oJ28Ky3B52h7Knkbk0sQC3jNo7Uq3JKzRcRurUOfCpPimeZ9YfgmcDHAWO30H7KT85Gmze/8DmN+U3bsD/tBLbUsbLRObJ/+Q4TW64MdQHrIwe40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745391051; c=relaxed/simple;
	bh=1Z8S16+o8AUZvUd2rH2+gfCQ2s47WpplhcIPdsDFkoU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bQIr95NuAMx3iVDzJjrBZwQnM1w3I16gd6N1+og8yXw4KauKbaO8FSpc70LhVTtgWEYw3bTyZWkAH9PykVRQoq09f2LieMRRKx2lE18R08MzPu78fvHAyNfugf76kDMfpxjJTbtTG9f2I7R7kOPiVFdqrgkKXWR0o2yQm7TEBic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nj25Dd4+; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtG1EN9CuYIurKBPp2tByBrDcac6V/jjRdei2uL76pzSTIL+/Jlc85vAzPLjh6AChq32AO4vltp5DsqiaZqWt0mThttNoLDUyvxXXmhMqhlnSGPTEfvpK16+1rPkDqKwZ5lz8W6FA/A94uM65ZzKivwdiSTAPA0nZdgfrwAa3OcSbyqiafhaFUKLJpZ2jQ0dIG54A6Ii9N788xJxxrqiFF3UI7Iq6YgiLTIgZCehW7/vW5ZKGGnzLBes7EnZNsJMfbyk3P0yQ8cVdFQFkc3pIpVy43JPCgw08wWjPTLa24XsKlMFBY4k/nHWUFmC46Rli0O3lQ7U8Oul4dl1DgI2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5eITiWhp/HlzZU6FFhJJgig6EPjNNrT9v8U6PGnS8c=;
 b=TMSR0TIizq+W4KWxrBoX5QVRqgCjhsXdkcUOoYYBvRo2tVAMmXcdEzstf+iz6Bag/buLGLlsc0RAwZaG7frz4Fr1QIMRFNSKBbrGFc0lVXYid0xJb+LKuxMQUhqTyWqbFbNBzLxhjOUbPleeknuEl3AKy9qG3CC97S+ZHdandFgZJETCPj+ddzdHo6+niv+u7BadD2ukOuaECdexBAEffDyXt+q/kqakNcSc3QHfVde+x/OiendcIi04eVyMSC6pss8lkkbCG1OXM+tIKCTyBbyxznBh4CRv9lfCCk7DdfWL0gF2hflSmxGTDP9FbC7Bo8+5fT9wQTsz1VGivHP2Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5eITiWhp/HlzZU6FFhJJgig6EPjNNrT9v8U6PGnS8c=;
 b=Nj25Dd4+NCfXMUAstVZoWjuZw4zshjfQw9RlbFOTnuUFE8QKnInOAJvIROud8C986avzGuX+1xIiMEWnlHggjDekX2054QzuzROH+aig8dungCDuGHLsK5Xf9An9gIZLiwwatdwjgDCeD2NFz+jdwur5CDXWWVe8AqZhGsdYuCKvpCnl+iZc0ao+4bnlRvG4Hu8DzOqAKm8Y6/OQbwRPyAeraGOt7TM/wKLweMTbJZETwS/UIgiki8HA1m8o7oyP+9OnF4oy6PlvAc9pWtZDE0ZkMY3zExnMeNkpKPsTx3mWc6e3INQSfEboqA7SJIJzI0Twmoxim3hN69/FYvoEfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 06:50:43 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%5]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 06:50:42 +0000
Message-ID: <a6beaa28-cd5d-4a8b-9df5-9f09b2632849@nvidia.com>
Date: Wed, 23 Apr 2025 09:50:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: net-shapers plan
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cosmin Ratiu <cratiu@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "horms@kernel.org" <horms@kernel.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "edumazet@google.com" <edumazet@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>
References: <d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com>
 <20250328051350.5055efe9@kernel.org>
 <a3e8c008-384f-413e-bfa0-6e4568770213@nvidia.com>
 <20250401075045.1fa012f5@kernel.org>
 <1fc5aaa2-1c3d-48cc-99a8-523ed82b4cf9@nvidia.com>
 <20250409150639.30a4c041@kernel.org>
 <2f747aac-767c-4631-b1db-436b11b83015@nvidia.com>
 <20250410161611.5321eb9f@kernel.org>
 <9768e1e0-3a76-47af-b0f5-17793721bb0a@nvidia.com>
 <20250414092700.5965984a@kernel.org>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20250414092700.5965984a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::18) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb1f483-75e2-484a-c10a-08dd82332a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFBwaUxaU1pJUGZwVENmU3BRYTl1cno0UjlQK0s0cEVJRlpKTXlWYUxObGZj?=
 =?utf-8?B?aTYzekhzQWlQejN3UEdrOGJ6TzhjczQ0OWxsRytLNXhCY1V6L3dQcEl5dzZJ?=
 =?utf-8?B?MWNNaVVNcE5kdUllRlBEb1hrMWMvVWt4TlVpNC9yaWl2MVNDdFllRE1aenN0?=
 =?utf-8?B?M2pLVnpQektXSkdUbCtvblVPUUpnSjAzZ2xMZWpFV0dYaWFId3hOcjZJdm1a?=
 =?utf-8?B?UHlLeHlZWDIwYVVTQ3JmYkprcHNicElHMzAycm1LOHNBSFhjSlNhSFlQTDgz?=
 =?utf-8?B?cXNOTVhPekpEWEFlQ2hxbWoxeXhrYzVtUnVBck5VNjVPdVcwRzg5Q0oyVzJM?=
 =?utf-8?B?YU9hYWhYUWtPUy9RMHhLRHlhRU9JNTZaanpsWFB6K2J3VldWQkFJTEs3djN4?=
 =?utf-8?B?ZitYS1BqNkl2c3VRU0lqVG5TVU9FbEdKTEVJdzBwam1TOTcrbkIxa05TcFFu?=
 =?utf-8?B?UXUzc1o4K0pFcG85SHE5TnJmWmN2bFpDWEVFaWo2dVB3OGx6VWZtdWFtRFZ0?=
 =?utf-8?B?ODNDc2h4YllMcHgxMnEyOXJDamZDeFdWeDEwTWIwaGJXYzJBcEp5N1BnUy9I?=
 =?utf-8?B?VjRuSHJrSVNJQit6NmZlQjM5bFdMOGJpQVltSC85cXZRMWlhZ1MxV1NLa3U3?=
 =?utf-8?B?M3N2R3krbjg0bXB6MzNUaERWWDNFZzdNR1NJWnU5MkdEajd6djl2UkovL1JR?=
 =?utf-8?B?dFhyNUNYejhNME9MVmxlcXJueHVLU3RnVHRqaDlFcGF5U3RueVhUeU1XQlVl?=
 =?utf-8?B?SFhWZEVSSFVYak0xRmg5eHJnY3pHV3BlSzhPVm4vMWl2Z2pVdW5neS9QV3Vt?=
 =?utf-8?B?ZGNWelMwY0JUYkZUNDVzNzg3VXh5NEpKMzI3QU5uR2taeWU3akZ0eE9yUm80?=
 =?utf-8?B?bVdLRHFrTVNkY0hxdklzZEhzRFdCQnFnTjlLTzJQUlpNTWlNVjVxZ1JYQ25M?=
 =?utf-8?B?cStob1piQmlrS2ZpZTBCTkY2Y1lJNFRRN2dWVWNKczNCVmtpd28yVFBjM3BX?=
 =?utf-8?B?OVlyYXhpR2hoaTRiejZTSmtHalJLQkJXQktUN1hINzVYR1JLZUNoZXZzZ2FQ?=
 =?utf-8?B?WGxuYWEzellXN05pbDdNZGVBUmVMTVJ0VGhWQm1xN0FmTWM2WDhld21VVmRy?=
 =?utf-8?B?dHU3MmNwS21BdHBacjJiM3F0Mzc1dXpFK1k3cjBWb0NIYzRMTlBtUElvaFV2?=
 =?utf-8?B?UGtTeTFndHFCRCtwNmZPdENVZXB3Y1NhNnNEKzlOR3J2eVlkZkF3Tk1vNVU5?=
 =?utf-8?B?dlgzRlJjd0xhV0RwSDEzMzlCY2JYSnlLNHdmaEVjck1aOUpSUm4rRktRRW80?=
 =?utf-8?B?L1ZjR0hPZ0YvRFRLc2dKOEJ5djBCeVF0TUViUFdmNjkxQ2VVTWJ5RzhZWnVu?=
 =?utf-8?B?L1ZkZUZoZnAxK09xcStrMWdIeThLbzBJaDlrOFBzeXZYT0cxTUk1RWFZeWlo?=
 =?utf-8?B?dVZsaWJtNEU4U29oK3lBbWU0YXdCNVJxS2RKTVp6ekNCaVhFdmNEWmJxaHA3?=
 =?utf-8?B?RWRYTTlmK3hoaUNaVDV3K1NLY3p6SERQcloyTUZ1MGlBOVdwRnIyUlluMlVU?=
 =?utf-8?B?Y1BiUlF3Y3p5bCt0TlFkcktDTTBDV0UyQVFWZ1E1MFFsMXRadldtTUZDVDBF?=
 =?utf-8?B?cUhvaEVKTytNZXV5ZVptUHRyWnJPZzJabUtIUktLSmJEVUpQS1pCU2R5MFU2?=
 =?utf-8?B?STVrM3MyQXFlbHE0RksrZDVubXk4MStyTjJRcCtOb0dxMmhlMWJQRHd2VmlI?=
 =?utf-8?B?YlR4VDZRNis0aTJsR3FxSHJJTGNHRy9jaEFNYVM1Z0hVVWlwOU8vT3BiSDZO?=
 =?utf-8?B?VUdzaUsxRnRKTGtyeTY4SVZhc0ZTS3hvWGxrZE93c3lLdVdlaVh5dHFFd3FR?=
 =?utf-8?B?NlRoYXFacUJMc3JsQ3RXNXF0MUV1dzlyWHJpV2xobHR6c2M5bjVtdURzc2Er?=
 =?utf-8?Q?CTK6+U4J3LM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXhjVjgzL1FOUWtERTlqdE1KTTk3UU5kVjBLSnJMWFFZdzlmcjd6Z3ZTeTc5?=
 =?utf-8?B?Q3FFajJsTEpxbVBhTnVSWng0MzlRSnY1YUhIUjdXY1pvYzRJSlZSK2IwUzhy?=
 =?utf-8?B?b00wNVJGeDBkTmVTOVh4QytNQ2pRSTIrOUJtR29sR1hjZVJKTExUaDFRdXNT?=
 =?utf-8?B?YitaWENDMUZNMHlYd0J5anNJdzFvV1lzMythQ1FBVVFkanJVNjc4MmhVTEtB?=
 =?utf-8?B?NnQ3MlJMbld2UDRUV0JqUW0vVTBBSjlzN0VQOXJYdm91VWVDV0RVWjVaaG9D?=
 =?utf-8?B?Q1BtcCtpNmRDZzVVVkFjWElWcDZqV1grZ0JFNnNCV2pkb2NvZ1EyYmhiUkxw?=
 =?utf-8?B?MnhGZUtHY1ptbnliSUgxWEpZYmprQ3h5VWNNeWlocFJscGRqRThRS1lNK1lC?=
 =?utf-8?B?QUVjV0x3VVFnQjFyY241NnVwR1FDWFpJZWYva1B4bHFVb05CTlVsaHZDRGNi?=
 =?utf-8?B?RDNlY3lHbFA1ckF3bWM0ZDlSYzFSd1pqZ2swbmJHdFo4T04yTEpJVmNKS0Ew?=
 =?utf-8?B?bm9xZ1RFellqOS9rcTFYdDBJdkJxUXFNajdzQzFJbmIyNGNCa3JlajBLUEVB?=
 =?utf-8?B?TXg0QVZQNmo1QThiQU9pZ3ZRQ0hnWTdjSmREOEY1OGo0RHlveUNPQm5LWFBi?=
 =?utf-8?B?cGNTUFJKNDdIRzdhNWcybmdBa3JTMUR4WDZhVDNhOWpXcHdiaTdQQWxHTGR6?=
 =?utf-8?B?QkVhdXpWV3RqS1BTa3E1MGNDNVBUcXBxUENkb1o5WEI1QTNPMGphZ21lY1o5?=
 =?utf-8?B?Wm5Ka0JFYjFPbGxyS2xuVW8xdDVpZk04VE44aVFPc09YTWVDLzdPd2d0bnls?=
 =?utf-8?B?dlBTcTA1WW5uTzZzSnltUExJU0VkM1ZXOFZqSGFDNk15VmR2Skt1Q2pMMTEz?=
 =?utf-8?B?MGttTVc1ZytsOFVyNCtYS1lvRVczMWFyVnB2dDZGMHRkNktWTGJzWTB0WE5Z?=
 =?utf-8?B?S2VUNGlZZWZaZlFvUmtTYmd1SnBLYU8xWFIwWW1rUWZGdUlYdGMyd2I5RXor?=
 =?utf-8?B?c2V4SkcrY3JoeXpDL1pBcXorRjJxM0V2TEdBYmlZV1pZUFh5ejQ4RTNFTjR5?=
 =?utf-8?B?QmlxajFlOTlpSEhFalRvZG4rcFYxTGgrQkt5a25UKzZBUEdabS92NEIzMVBR?=
 =?utf-8?B?cFNWVEdlbFBwWndKY3FvRmlXL0FYdnZRaW1FV0VkaHl6TjJJeVpFbTJpWVd1?=
 =?utf-8?B?OTJyNnh6OC9sUEt6T3o5WHZZVCtmc242bVd2V1NuUXg1L1lxZ0tUNWRod1I0?=
 =?utf-8?B?L0c3VXBTNEhRbnRxem5wZzJoZjZCalJIVUtJWTBvNXZocUtod3V1TEE3MlZN?=
 =?utf-8?B?SVd2clR1SFFFMHEyenVnQVNLci9EQW5iYXM5QXJMWjQ2UkQwWHY2Y2x5bTY3?=
 =?utf-8?B?SEpkcVU4dHVISVkydmtjUysrZlhwOVZaS3ZiODlkVXR1dzVZWmtpK1RySy83?=
 =?utf-8?B?WWhTNTF5QlEwUndKQTdxZVlpcHhFRGtWMU1TdjRvY2dSeFJpaU5LL3JHMjQv?=
 =?utf-8?B?aEV6Z0VPTHZyMm85cXU1K1ZldnZNN1NUVTkwWi9qN3hvOGlYR3RuSHZJczBq?=
 =?utf-8?B?bmNJOWhsWU9CdGJrQ3VxMzdhWlVtb29DMmJ1ZVNmaTIyTTMrTm1pRWg5anlw?=
 =?utf-8?B?UlhoMXNIWGx4VE5JN2ZPMVFzM3FnOGs1eHJ3bzRicGc1K0pFWW9TVlB2YVZG?=
 =?utf-8?B?U3A1ZDZMQ2U3R2VwcjZFTlRkaWxHMmE4TE52YjlJL1B5WFAzbWlYeHhSWWJn?=
 =?utf-8?B?UnUwM1ZMbTYrN28rTzJsUUo5TXg0QWo1MUpmYjRpOGNvMFk1ZTBEK2NwRW9C?=
 =?utf-8?B?Z09kS1d3cXgzekF3TkhSNlBMSnpwYVpwM1g2dkxNblBjVzhoRkxBV2YzV2dO?=
 =?utf-8?B?djJPMk0yN0dqUkJEemQyT3hTM1V0WWgvU1FDNjMvd2VSZG1hKzA5dGxzdUFK?=
 =?utf-8?B?a3ByUEtRV1VHbUJiVk9OekpqbXlIZXdPS0grUHJxUnQrVDI5bW03SnZTVUQw?=
 =?utf-8?B?YkpTV05KaEFiL1ZXZzhqTzJES0lQY2lsUmtCcVRMWEc2RndoVlI2clFXQ3NV?=
 =?utf-8?B?djlOUzloVUJQSUZ0TGtrMWxHbmRwcHcrb0VXV1MyVkR4V3lYelJ6UW44SURa?=
 =?utf-8?Q?GFfKTQW0VfNgWGo0eldr3Q4QH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb1f483-75e2-484a-c10a-08dd82332a85
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 06:50:42.8411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C15d67YhOwT32ki0ThZO9BicpukKUM87YPakLA8emtFljEhyVO8TyJcS/SgLHecVinBvo9zUNGC9sB4MTm3y2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522



On 14/04/2025 19:27, Jakub Kicinski wrote:
> On Mon, 14 Apr 2025 11:27:00 +0300 Carolina Jubran wrote:
>>> I hope you understand my concern, tho. Since you're providing the first
>>> implementation, if the users can grow dependent on such behavior we'd
>>> be in no position to explain later that it's just a quirk of mlx5 and
>>> not how the API is intended to operate.
>>
>> Thanks for bringing this up. I want to make it clear that traffic
>> classes must be properly matched to queues. We don’t rely on the
>> hardware fallback behavior in mlx5. If the driver or firmware isn’t
>> configured correctly, traffic class bandwidth control won’t work as
>> expected — the user will suffer from constant switching of the TX queue
>> between scheduling queues and head-of-line blocking. As a result, users
>> shouldn’t expect reliable performance or correct bandwidth allocation.
>> We don’t encourage configuring this without proper TX queue mapping, so
>> users won’t grow dependent on behavior that only happens to work without it.
>> We tried to highlight this in the plan section discussing queue
>> selection and head-of-line blocking: To make traffic class shaping work,
>> we must keep traffic classes separate for each transmit queue.
> 
> Right, my concern is more that there is no requirement for explicit
> configuration of the queues, as long as traffic arrives silo'ed WRT
> DSCP markings. As long as a VF sorts the traffic it does not have
> to explicitly say (or even know) that queue A will land in TC N.
> 

Even if the VF sends DSCP marked traffic, the packet's classification 
into a traffic class still depends on the prio-to-TC mapping set by the 
hypervisor. Without that mapping, the hardware can't reliably classify 
packets, and traffic may not land in the intended TC.

Overall, for traffic class separation and scheduling to work as 
intended, the VF and hypervisor need to be in sync. The VF provides the 
markings, but the hypervisor owns the classification logic.

The hypervisor sets up the classification mechanism; it’s up to the VFs 
to use it correctly, otherwise, packets will be misclassified. In a 
virtualized setup, VFs are untrusted and don’t control classification or 
shaping, they just select which queue to transmit on.

> BTW the classification is before all rewrites? IOW flower or any other
> forwarding rules cannot affect scheduling?

The classification happens after forwarding actions. So yes, if the user 
modifies DSCP or VLAN priority as part of a TC rule, that rewritten 
value is what we use for classification and scheduling. The 
classification reflects how the packet will look on the wire.


