Return-Path: <netdev+bounces-147668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8E59DAFD5
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 00:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96907281237
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 23:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432FB191F8E;
	Wed, 27 Nov 2024 23:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oO1A3bPP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E71189F20
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732750235; cv=fail; b=SLJFD2R1OaO6dGqpC+ao2zB4JdpoLtv4LMKTslYf9h8p4EEgPJR13BoYOIuz11BDHQBcApFFZxGgpTq+bV3IjF6bUA0IyNKnLyNlzbj3IYXMHY64rtudzScJWlwEJUkd/z0VjPSNG9smfacW79DHMfi4hp2mwt797C693slyaxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732750235; c=relaxed/simple;
	bh=6axf90GeIxYCIdkVVN7Rinl/HWeI9VBbSob1xkwkiC4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OV6qa6HZgACVq9AOENi30PWo/0gfdjKYbw/4oUGbr11BX/u7nD1xTKDXtTlXVYrE/NuzC65FUmrSmHIHDrXV0MAMMUtF4a7V+8EaNDuVXCwuY0wj2gmQoYYxDhU+a3YdXJBmKCtsszqUGarya+te5jYNgfJW3WmK5gOdYgc2vOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oO1A3bPP; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHld+4h8cXxFmPfncXVNZ1ysYb2RqsSqvhcX23OeWNtGEfiUjXPyQVbBva3CZWhDvPA/iz4Us7acYKphwHJJkjAmkC7kwjsXeZStq8dDM6jtGe5aZccUFgXjqkTEZpSADZ0fWHFsq6Bx2EYuN0IxSgnLttgiVauHmX1V+lNqZUyWkQAgmedhUcFec5/bZEXibqAoiXKKtJaYFcHdUE1bNtPdU5zbSOywjci3E1Nfs6Qc+OVsdnZChqeK5+PDJ7UFh5fUEszc3mU86WXhVtQS9/fKVvrqPtM1HHeYwgixXqLjQEo5LCZkVFUhxIiM9cq26r6QtRaiLGOSpgei+pi23g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6axf90GeIxYCIdkVVN7Rinl/HWeI9VBbSob1xkwkiC4=;
 b=ogQhIWBDjo1mvkY4l8MPHlCmw/W1EGTLtIYBmNx0cB5oB4aRCr4/pwhx/AqAV3Vzm4fVpFUBluD7DQsRNB2FZgqppWgt/WZ/jZ6JR3MHddddocq4+3A9k/YsdS6sXa7C5u3YtJt3QebsG5FQDZbe7Bt/dt82MMwwVU8i28kU//IzweJTJf+AeaKLbauYi3t88aL0W7UHj6BtN0DMjntsVRDpfnYdD7Cv4SScZxuMblU77cfhVXfH3g5TroluQV4q82TshXqIOPXnRSok/OWO+lA7ZgxmbMa2mg64RopQBU9BGR9F+9UavwYEV2hL6XEHsk8B7MqCRCCMtzqYiNkwog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6axf90GeIxYCIdkVVN7Rinl/HWeI9VBbSob1xkwkiC4=;
 b=oO1A3bPPlTy1ZBrl+6thhruOABnQiWgMp+EVFCoQpYi3vegJWQMLR481Ipx/oXLwrW/jLWK9K3KrNCZOaUhqGq2OEz0kOus3btqMQ09z0U93GHn0yQMgJaky0ViA9kZ/+VO12b7wyzGzXtcvWuelQZb6Yd5BtGLomIE8Pj68Q+lBvZZ8VdE6F9Q6KqLY0iNHPL+up6tJpfS0qcGk3CRL415qjJ6MepwDfVU9p+1b3KqGjvbJ3tXJlkLgdsith53HXEbfNcz5hEdf0Tg6LmjeWRsR348ZmVt1CpHctlRldky+G/5AGsGbjZsgeGGt3Te9P8gZcNZlLrHOIBEFXqfSIA==
Received: from CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7)
 by PH7PR12MB6977.namprd12.prod.outlook.com (2603:10b6:510:1b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 23:30:29 +0000
Received: from CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face]) by CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face%6]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 23:30:29 +0000
From: Yong Wang <yongwang@nvidia.com>
To: Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu
	<roopa@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Andy Roulin <aroulin@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Nikhil
 Dhar <ndhar@nvidia.com>
Subject: Re: [RFC net-next 1/2] net: bridge: multicast: re-implement port
 multicast enable/disable functions
Thread-Topic: [RFC net-next 1/2] net: bridge: multicast: re-implement port
 multicast enable/disable functions
Thread-Index: AQHbQErqMmqewIuJ+Eq7SqTza9T+trLLPqaAgAADVgA=
Date: Wed, 27 Nov 2024 23:30:29 +0000
Message-ID: <BC9DAE01-92F5-489C-BE0A-451192494B9C@nvidia.com>
References: <20241126213401.3211801-1-yongwang@nvidia.com>
 <20241126213401.3211801-2-yongwang@nvidia.com>
 <e1db249d-6b34-4bd6-beb8-e8754a773b71@blackwall.org>
In-Reply-To: <e1db249d-6b34-4bd6-beb8-e8754a773b71@blackwall.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4858:EE_|PH7PR12MB6977:EE_
x-ms-office365-filtering-correlation-id: 7b3917d7-7d21-4180-a01c-08dd0f3b7aa4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L2pmUEd2TVliTXFVVzRsZmN6UnN5L29vWUNYQzBxZG5hQ0IyZnZnVUZ3WEpn?=
 =?utf-8?B?VDFZSFN6eEg2a3Z0aGpqejNSWFJzWlZrL0J0endPNDAxSnVzME05ZlJEMW1B?=
 =?utf-8?B?cjFsQVhCVG9CYStKSXVJcXlSMlRqbUViMXNycHIrdS9MODR5QUc5WVlYMXV5?=
 =?utf-8?B?LzFOL0dIQ2RDSkYzMEROa0tYNkltbmZrZ09vb2dpVHp5Y1RMS0pJUW0xR0ow?=
 =?utf-8?B?Wmd5UlluS2xRM1pCK2ZFc1JvZGU3dStpSVJwTlVDWUZWeFB4QVV4UnlIRk1s?=
 =?utf-8?B?aGg0N2M0bHBNSUpYK0VHNVRjN1FuQ0FVemI4VkNEdm43YXByV3o3UldsRUNP?=
 =?utf-8?B?OWNqMFJnemtqdXIxS2NkMkV6ZWp4TVhDc1FKeFlTbm4rSWY3V1VWUC9JN1Y3?=
 =?utf-8?B?YXRUT3ZOdkh0Rk1JZlZDWS9Yek9NQTlHS1lLTm1yZlZ3dkhqQ2luakdKMnVi?=
 =?utf-8?B?cjl3MG5sb2ExeCtiZ0pSMnMxTWVWeFovTjRlUmNGYUFOclE5NjJMczI4Ulpw?=
 =?utf-8?B?QTIvM1hHazZuSTIwRDQzSFF5eTNJVXQ2MGNKbnBnRE9kSGxYQnBwUmlJUWs5?=
 =?utf-8?B?azV2Z05CRklzYXV3NGRRZjVEbEpteFFpSTl6azVvdFlZRW9KRmtzZ29jdjBJ?=
 =?utf-8?B?VXRzMmUvZzFnTTZ3OVd5bXE2WlB5Zm5ybnN0MmJCV2Q0ZHA1V3luOGFrWHc3?=
 =?utf-8?B?MnZQYjBXMDNpQXFoa1hCL3FsNUJheWQ5OWtMa2lwWGJzTUdzeUxhQTF6WTcz?=
 =?utf-8?B?MUZVaUdBZFNRdzk0Vjg4R2ptRXRBNllYVkdRWkwxbFd0MFd4UHNDQ2RWUXdS?=
 =?utf-8?B?d0J1UEszekd1a3NKOEF1OHBUREdJVzkzdWhoV0U3VG0zdFgvaDU2NHJ5VG40?=
 =?utf-8?B?aG5VT1JERkxQd2xDMDFVTmIwbzZIaXh2QlVJUXF6cXZVL0FJZXIwbjdkbUs1?=
 =?utf-8?B?alRQZ3Q5TDBiOHpndTQ2MjlYZ1JleE1VZ3NYejlQUmVzK0pkazVWU0tzTks5?=
 =?utf-8?B?SUJEeUJMbW9GWUJYRDh2OWN2MU1EV2R2MnJTUVJVbjNpbXFqcDJQTEdVU2xW?=
 =?utf-8?B?U3k3RFJXWE5pZkZ4WlV6R0R2R2ZaOEFRcUJwY1dVMC92a1l4NHhpclF5K1lv?=
 =?utf-8?B?WDBLRE9rTFBCT015dmUrL0RsN0Q0L0lqZU5kNUFPQVNkNFlBQVJ6YktTVFMx?=
 =?utf-8?B?MWlDUDd4T0xlYUpGRTRMejBNMjBiMXZhcm43TTBWczNSSnhCYVU5VVloTmYr?=
 =?utf-8?B?VXhuYk9HejUxa1AyckxlbFNYOTZyZWRzMXJDd3BNNmNzWXFsWCs1cjBUVzNt?=
 =?utf-8?B?MDBwWWhIemRTN1ZjZW94bUFkQ2hQV3NuRjNvMElZalRtNkhiZ2dEMVFUM09W?=
 =?utf-8?B?V1FuSGFXK0xQSWRJeHJDeXZQWjh6ZlBxWUp2dDBOWFc3ZkpxYzllNE5sMmhz?=
 =?utf-8?B?ZERsMVZPcGJ0Y3FrZ0d3amdleWh4UkJXSGJxY1pTR1BmdlR4NWVtWm50WTlT?=
 =?utf-8?B?VkpXKzZzYThRcUxKUVFoanJjY2trOHd3N2Ezd1lDdi9leHIvQjRDUzRncjY1?=
 =?utf-8?B?NXdwbjk4N2cxYUFPMElYRXgwU2NONHlIb3VyRE1UczZnYjZwUHBBRzYvWmhn?=
 =?utf-8?B?MEprSXpKZ29SbjhHYVNwb25kOW9aUEhpVmh6TUNoN1I3TzRJRVRkMHRMRzRM?=
 =?utf-8?B?bjZLeVhYWHduaEJYMERoVnJmZWhrVlRjbXJZSVQrMUpHRnBjUzRYZW40Qlhi?=
 =?utf-8?B?dlZ4NERpcDZ2NHlxalJwYkxCVVZNVHRNOTNZYUp1ZkFZZkcxK2FORE5SN1dI?=
 =?utf-8?B?L2tyekF5NENJQVJrR0ZUSzdQR0ZTT21XR2k3Q0dCODZpYnRNbVJ5SHZVSGl5?=
 =?utf-8?B?S0I3T2Q1enZZNFZoQ2lkbWdhZENuMTZlQnBwWXNWL3AwSUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4858.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QndwSzM0emJNUGpOS0xveGR6OVhvMmMydk5DTTRqS0NWQUpCTEZLNHUwbzlx?=
 =?utf-8?B?R0JJWmJCTFVnNFdBNzR1dlJTVm5va2J5NG9MUnpYbHdmODF1dUdXVFY5ZTBm?=
 =?utf-8?B?TUhwVTUrNWExWXRIMDkzTmZDMGw5ZG5TZUw1WWo2NHNkcTVUYzY5UkYwTUl2?=
 =?utf-8?B?b2pyRzlxVkY4V20wbkk0MHUxU3hUVndBNHlLUXlwaXptdDhNclkwcUwyYTZ3?=
 =?utf-8?B?ZzZnditDdXZMQmtubDJHR05MVlNnVGpLK1NhRy94cVBKVHNKRTFMVUR5blU3?=
 =?utf-8?B?bUdrN096REQ1V1pCVFFtVTNqUmxySHUwbGxpOG5rR0VwK3ZCbUI0c2FwQUg1?=
 =?utf-8?B?UzhOeS9sWklxY1lGT0s2NkNYWXhXVEM5ZFErLzBnU0RMTWtMQXVZNDk5YnJu?=
 =?utf-8?B?YURnUDNPQXN0RGdzaGRIRGl4cXpvUXhhUmhYQjZZano5eGlsak5ob2UrZEJK?=
 =?utf-8?B?NitkTlorM2VHTVExT0NHVjl3VnFyMVN5cThYd0d2dXNEVVBQZm5qVllpcUtV?=
 =?utf-8?B?VWNjYllNTmJEWGo5QWtYaGxVMFdxQm5haTZQajcyM0FIeFJwR2M4K0ZyNFhq?=
 =?utf-8?B?TDFPR3JUbGxSSDBKakViYk50bVQ3UGRWcFRTOWR3RWlOWVBiNStRekdQbzZI?=
 =?utf-8?B?UHZmM0ZwQzJmbUhCd3JYaS95emdRMG1NbUhVMjM3WVhqR0RScFMxSFJPd3Ar?=
 =?utf-8?B?ZlVqeTE0ekk0cjBaTTlQL0pPQjhCWHJDQnVRamtpTUZHaU1wWTlkSFhyTzYr?=
 =?utf-8?B?TnorbUhSWEZQRE5MdjhkUVdHTHJoTythRDBWTkF2R0pMSHVwcUdrYjB1Y24w?=
 =?utf-8?B?TURQbURvQnpDckJwWnF6ckhkdlJsTFowQnNRMVVIRytwOU5FL25pb1IrNE5n?=
 =?utf-8?B?M3VCWi81U1Y3R0x1YU5mK2xaUGRPbVM1bG9rYTZPNWpJZ3JtSnZVTlNsMVhD?=
 =?utf-8?B?QUZiSkxNdkNkOGloaUVYOElEandkNGFFRjJCRlpDaGZZWWliM0E4U3BsdDN2?=
 =?utf-8?B?cXhwS2U0OW9jbWVGemlKVHpLOXVhY0tuSVhxVXNIK3hod1QrQnZBLy83UStI?=
 =?utf-8?B?MWtDMm9MaUZBekt6NXpzdURtbHVnYUF0UWsxSHBaM3JHQ1JzRExSd2hlY3ZS?=
 =?utf-8?B?YzBKRUxWNEZGSnZjL1ptcE54SmxTMzhKbmsxeG1YV3ZzYkpkM1BuQmNsSXhw?=
 =?utf-8?B?RGtsZENIeWMyWmlrTUE5VFNNNExtclJuZGhUN2xHMms0TVQvTEZEQWd2WlNH?=
 =?utf-8?B?b2NucWVuWmxZcXBQK2lBRFpKWnMrWis1eDU4aVFUVFU5Qnptc0t5aDNNVXBD?=
 =?utf-8?B?S293eEJyanRHUnQzRzl0WTdNSG9VbXRXOGh4NG1KZ1NLM284Y3VSYVE1Z0Zi?=
 =?utf-8?B?Rmx1OThYZzBvdFZpUTROYndPS0M3UGxiZ09Ta1krRndONDZrQ3lNSnZvTU5k?=
 =?utf-8?B?OEF0cjErOWJGVnlhRzZhbkpoa1JIQ0F2U0hwdXVvWndkOWI2MjY2ZjdSMDcy?=
 =?utf-8?B?aWlJTFcvQm9pRzR3VWFTNEhvcjZ2RjA5WjlkZnRjdWdsR0lQRkhhc290UnZR?=
 =?utf-8?B?aUdVc1luM3RRUHJKMll0ZGNveWMzc3pyamVSRzNZcDlZaDkxL1VlUlgrai9j?=
 =?utf-8?B?UHhUVEZvNHBxbGp4di9OSHYrQ1EvUHBYR1EwM3NJYzlseGN1VDZtaHA5T1lX?=
 =?utf-8?B?V1VjVmllMXVwREJyNEYxbWZnQjZ3OEV6R1VYREJmZ3dsMitCaGZEdlF0L2lI?=
 =?utf-8?B?Vmk3c1UrNSt6WldVbnBLMHhoajdoQXFJUFBObnNjUEdsN2FOdGsrVWdxeldI?=
 =?utf-8?B?SFVHT0JXUEdPMWhHdEVmaWNMVWVCM0hyUVFXVmErSnBrQlA1SHBKNDZaUC92?=
 =?utf-8?B?dHZOUVpVUXhIaFFtK2RLNlZVZktJZlB6c0ROTHNtSkxXbm9JTVZNUzk4Nzc4?=
 =?utf-8?B?UWJxTmJ5N1QrRUJvSmtqOG02YkpLRjR5aHhBczA2N0dIUHluVHpDWXpmRkND?=
 =?utf-8?B?YzBhMzVCMnppdXl0bStVZ1BUNGN6d2RzRzNKcmE5NVptWllzZ2tKYjBtdVlj?=
 =?utf-8?B?S2RJcHNXb0dQemhrRzVKWWp2TlVpRkhlYUo3SC9Jckx3U0tjVFdHK1ZrOGx4?=
 =?utf-8?B?aE1HcTluOU1WSEN4Ym9yaS9LYTBNT1BhM0cyRkg4dU52WG4zekZ5STcwVnJu?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AC1C1A2F07DB34EAC5CDC771F328BDA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3917d7-7d21-4180-a01c-08dd0f3b7aa4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 23:30:29.1012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RBfDvJmFuUIOCkcny1LlqlFUH9LMs/WarZ2R0B1k0dyayIPal+Mr4XW7sf6UlFYO8y8ba+QPLukf9TQSUNvMUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6977

DQpPbiAxMS8yNy8yNCwgNzoxOCBBTSwgIk5pa29sYXkgQWxla3NhbmRyb3YiIDxyYXpvckBibGFj
a3dhbGwub3JnPiB3cm90ZToNCg0KDQo+T24gMjYvMTEvMjAyNCAyMzozNCwgWW9uZyBXYW5nIHdy
b3RlOg0KPj4gUmUtaW1wbGVtZW50IGJyX211bHRpY2FzdF9lbmFibGVfcG9ydCgpIC8gYnJfbXVs
dGljYXN0X2Rpc2FibGVfcG9ydCgpIHRvDQo+PiBzdXBwb3J0IHBlciB2bGFuIG11bHRpY2FzdCBj
b250ZXh0IGVuYWJsaW5nL2Rpc2FibGluZyBmb3IgYnJpZGdlIHBvcnRzLg0KPj4gVGhlIHBvcnQg
c3RhdGUgY291bGQgYmUgY2hhbmdlZCBieSBTVFAsIHRoYXQgaW1wYWN0cyBtdWx0aWNhc3QgYmVo
YXZpb3JzDQo+PiBsaWtlIGlnbXAgcXVlcnkuIFRoZSBjb3JyZXNwb25kaW5nIGNvbnRleHQgc2hv
dWxkIGJlIHVzZWQgZm9yIHBlciBwb3J0DQo+PiBjb250ZXh0IG9yIHBlciB2bGFuIGNvbnRleHQg
YWNjb3JkaW5nbHkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWW9uZyBXYW5nIDx5b25nd2FuZ0Bu
dmlkaWEuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IEFuZHkgUm91bGluIDxhcm91bGluQG52aWRpYS5j
b20+DQo+PiAtLS0NCj4+ICBuZXQvYnJpZGdlL2JyX211bHRpY2FzdC5jIHwgNzUgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDY3IGlu
c2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+Pg0KPg0KPkhpLA0KPkEgZmV3IGNvbW1lbnRz
IGJlbG93DQoNClRoYW5rIHlvdSBzbyBtdWNoIGZvciB0aGUgY29tbWVudHMhDQoNCj4NCj4+IGRp
ZmYgLS1naXQgYS9uZXQvYnJpZGdlL2JyX211bHRpY2FzdC5jIGIvbmV0L2JyaWRnZS9icl9tdWx0
aWNhc3QuYw0KPj4gaW5kZXggYjJhZTBkMjQzNGQyLi44YjIzYjBkYzYxMjkgMTAwNjQ0DQo+PiAt
LS0gYS9uZXQvYnJpZGdlL2JyX211bHRpY2FzdC5jDQo+PiArKysgYi9uZXQvYnJpZGdlL2JyX211
bHRpY2FzdC5jDQo+PiBAQCAtMjEwNSwxNSArMjEwNSw0NSBAQCBzdGF0aWMgdm9pZCBfX2JyX211
bHRpY2FzdF9lbmFibGVfcG9ydF9jdHgoc3RydWN0IG5ldF9icmlkZ2VfbWNhc3RfcG9ydCAqcG1j
dHgpDQo+PiAgICAgICB9DQo+PiAgfQ0KPj4NCj4+IC12b2lkIGJyX211bHRpY2FzdF9lbmFibGVf
cG9ydChzdHJ1Y3QgbmV0X2JyaWRnZV9wb3J0ICpwb3J0KQ0KPj4gK3N0YXRpYyB2b2lkIGJyX211
bHRpY2FzdF9lbmFibGVfcG9ydF9jdHgoc3RydWN0IG5ldF9icmlkZ2VfbWNhc3RfcG9ydCAqcG1j
dHgpDQo+PiAgew0KPj4gLSAgICAgc3RydWN0IG5ldF9icmlkZ2UgKmJyID0gcG9ydC0+YnI7DQo+
PiArICAgICBzdHJ1Y3QgbmV0X2JyaWRnZSAqYnIgPSBwbWN0eC0+cG9ydC0+YnI7DQo+Pg0KPj4g
ICAgICAgc3Bpbl9sb2NrX2JoKCZici0+bXVsdGljYXN0X2xvY2spOw0KPj4gLSAgICAgX19icl9t
dWx0aWNhc3RfZW5hYmxlX3BvcnRfY3R4KCZwb3J0LT5tdWx0aWNhc3RfY3R4KTsNCj4+ICsgICAg
IF9fYnJfbXVsdGljYXN0X2VuYWJsZV9wb3J0X2N0eChwbWN0eCk7DQo+PiAgICAgICBzcGluX3Vu
bG9ja19iaCgmYnItPm11bHRpY2FzdF9sb2NrKTsNCj4+ICB9DQo+Pg0KPj4gK3ZvaWQgYnJfbXVs
dGljYXN0X2VuYWJsZV9wb3J0KHN0cnVjdCBuZXRfYnJpZGdlX3BvcnQgKnBvcnQpDQo+PiArew0K
Pj4gKyAgICAgc3RydWN0IG5ldF9icmlkZ2UgKmJyID0gcG9ydC0+YnI7DQo+PiArDQo+PiArICAg
ICBpZiAoYnJfb3B0X2dldChiciwgQlJPUFRfTUNBU1RfVkxBTl9TTk9PUElOR19FTkFCTEVEKSkg
ew0KPj4gKyAgICAgICAgICAgICBzdHJ1Y3QgbmV0X2JyaWRnZV92bGFuX2dyb3VwICp2ZzsNCj4+
ICsgICAgICAgICAgICAgc3RydWN0IG5ldF9icmlkZ2VfdmxhbiAqdmxhbjsNCj4+ICsNCj4+ICsg
ICAgICAgICAgICAgcmN1X3JlYWRfbG9jaygpOw0KPj4gKyAgICAgICAgICAgICB2ZyA9IG5icF92
bGFuX2dyb3VwX3JjdShwb3J0KTsNCj4+ICsgICAgICAgICAgICAgaWYgKCF2Zykgew0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgIHJjdV9yZWFkX3VubG9jaygpOw0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgIHJldHVybjsNCj4+ICsgICAgICAgICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICAgICAg
ICAvKiBpdGVyYXRlIGVhY2ggdmxhbiBvZiB0aGUgcG9ydCwgZW5hYmxlIHBvcnRfbWNhc3RfY3R4
IHBlciB2bGFuDQo+PiArICAgICAgICAgICAgICAqIHdoZW4gdmxhbiBpcyBpbiBhbGxvd2VkIHN0
YXRlcy4NCj4+ICsgICAgICAgICAgICAgICovDQo+PiArICAgICAgICAgICAgIGxpc3RfZm9yX2Vh
Y2hfZW50cnlfcmN1KHZsYW4sICZ2Zy0+dmxhbl9saXN0LCB2bGlzdCkgew0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgIGlmICgodmxhbi0+cHJpdl9mbGFncyAmIEJSX1ZMRkxBR19NQ0FTVF9FTkFC
TEVEKSAmJg0KPg0KPlRoaXMgaXMgcmFjeSwgdGhlIGZsYWcgaXMgY2hhbmdlZCBvbmx5IHVuZGVy
IG11bHRpY2FzdF9sb2NrIGFuZCBzaG91bGQgYmUgdXNlZA0KPm9ubHkgd2l0aCB0aGUgbG9jayBo
ZWxkLiBJJ2Qgc3VnZ2VzdCBtb3ZpbmcgdGhpcyBjaGVjayBpbiBicl9tdWx0aWNhc3RfZW5hYmxl
X3BvcnRfY3R4KCkNCj5hZnRlciB0YWtpbmcgdGhlIGxvY2sgd2hlcmUgeW91IHNob3VsZCBjaGVj
ayBpZiB0aGUgY29udGV4dCBpcyBhIHZsYW4gb25lIG9yIG5vdC4NCg0KVGhhbmtzIGZvciBwb2lu
dGluZyBvdXQuIFN1Y2ggY2hhbmdlIGxvb2tzIHJlYXNvbmFibGUsIEkgd2lsbCB1cGRhdGUgYWNj
b3JkaW5nbHkuIA0KQWx0ZXJuYXRpdmVseSwgaGVyZSB3ZSBjYW4gY2FsbCBfX2JyX211bHRpY2Fz
dF9lbmFibGVfcG9ydF9jdHggaW5zdGVhZCBhZnRlcg0KY2hlY2tpbmcgdGhlIGZsYWcgdW5kZXIg
bXVsdGljYXN0X2xvY2suDQoNCj4NCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgYnJfdmxh
bl9zdGF0ZV9hbGxvd2VkKGJyX3ZsYW5fZ2V0X3N0YXRlKHZsYW4pLCB0cnVlKSkNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGJyX211bHRpY2FzdF9lbmFibGVfcG9ydF9jdHgoJnZs
YW4tPnBvcnRfbWNhc3RfY3R4KTsNCj4+ICsgICAgICAgICAgICAgfQ0KPj4gKyAgICAgICAgICAg
ICByY3VfcmVhZF91bmxvY2soKTsNCj4+ICsgICAgIH0gZWxzZSB7DQo+PiArICAgICAgICAgICAg
IC8qIHVzZSB0aGUgcG9ydCdzIG11bHRpY2FzdCBjb250ZXh0IHdoZW4gdmxhbiBzbm9vcGluZyBp
cyBkaXNhYmxlZCAqLw0KPj4gKyAgICAgICAgICAgICBicl9tdWx0aWNhc3RfZW5hYmxlX3BvcnRf
Y3R4KCZwb3J0LT5tdWx0aWNhc3RfY3R4KTsNCj4+ICsgICAgIH0NCj4+ICt9DQo+PiArDQo+PiAg
c3RhdGljIHZvaWQgX19icl9tdWx0aWNhc3RfZGlzYWJsZV9wb3J0X2N0eChzdHJ1Y3QgbmV0X2Jy
aWRnZV9tY2FzdF9wb3J0ICpwbWN0eCkNCj4+ICB7DQo+PiAgICAgICBzdHJ1Y3QgbmV0X2JyaWRn
ZV9wb3J0X2dyb3VwICpwZzsNCj4+IEBAIC0yMTM3LDExICsyMTY3LDQwIEBAIHN0YXRpYyB2b2lk
IF9fYnJfbXVsdGljYXN0X2Rpc2FibGVfcG9ydF9jdHgoc3RydWN0IG5ldF9icmlkZ2VfbWNhc3Rf
cG9ydCAqcG1jdHgpDQo+PiAgICAgICBicl9tdWx0aWNhc3RfcnBvcnRfZGVsX25vdGlmeShwbWN0
eCwgZGVsKTsNCj4+ICB9DQo+Pg0KPj4gK3N0YXRpYyB2b2lkIGJyX211bHRpY2FzdF9kaXNhYmxl
X3BvcnRfY3R4KHN0cnVjdCBuZXRfYnJpZGdlX21jYXN0X3BvcnQgKnBtY3R4KQ0KPj4gK3sNCj4+
ICsgICAgIHN0cnVjdCBuZXRfYnJpZGdlICpiciA9IHBtY3R4LT5wb3J0LT5icjsNCj4+ICsNCj4+
ICsgICAgIHNwaW5fbG9ja19iaCgmYnItPm11bHRpY2FzdF9sb2NrKTsNCj4+ICsgICAgIF9fYnJf
bXVsdGljYXN0X2Rpc2FibGVfcG9ydF9jdHgocG1jdHgpOw0KPj4gKyAgICAgc3Bpbl91bmxvY2tf
YmgoJmJyLT5tdWx0aWNhc3RfbG9jayk7DQo+PiArfQ0KPj4gKw0KPj4gIHZvaWQgYnJfbXVsdGlj
YXN0X2Rpc2FibGVfcG9ydChzdHJ1Y3QgbmV0X2JyaWRnZV9wb3J0ICpwb3J0KQ0KPj4gIHsNCj4+
IC0gICAgIHNwaW5fbG9ja19iaCgmcG9ydC0+YnItPm11bHRpY2FzdF9sb2NrKTsNCj4+IC0gICAg
IF9fYnJfbXVsdGljYXN0X2Rpc2FibGVfcG9ydF9jdHgoJnBvcnQtPm11bHRpY2FzdF9jdHgpOw0K
Pj4gLSAgICAgc3Bpbl91bmxvY2tfYmgoJnBvcnQtPmJyLT5tdWx0aWNhc3RfbG9jayk7DQo+PiAr
ICAgICBzdHJ1Y3QgbmV0X2JyaWRnZSAqYnIgPSBwb3J0LT5icjsNCj4+ICsNCj4+ICsgICAgIGlm
IChicl9vcHRfZ2V0KGJyLCBCUk9QVF9NQ0FTVF9WTEFOX1NOT09QSU5HX0VOQUJMRUQpKSB7DQo+
DQo+VGhlc2UgYmxvY2tzIGluIGVuYWJsZSBhbmQgZGlzYWJsZSBhcmUgYWxtb3N0IGlkZW50aWNh
bCwgbWF5YmUgbWFrZQ0KPmEgc2luZ2xlIGhlbHBlciBjYWxsZWQgX3RvZ2dsZSAoc2ltaWxhciB0
byB2bGFuIG1jYXN0IHNub29waW5nIHRvZ2dsZSkNCj53aXRoIGEgb24vb2ZmIGJvb2wgYXJndW1l
bnQgYW5kIGNhbGwgdGhlIGFwcHJvcHJpYXRlIGZ1bmN0aW9uIGJhc2VkIG9uIGl0Lg0KDQpTb3Vu
ZHMgZ29vZCwgZm9sbG93aW5nIHN1Y2ggY29udmVudGlvbiwgYnJfbXVsdGljYXN0X3RvZ2dsZV9w
b3J0IHNlZW1zIHRvIGJlIA0KYSBnb29kIGNhbmRpZGF0ZSBmb3IgdGhlIG5hbWUgb2YgdGhpcyBo
ZWxwZXIuDQoNCg0KPg0KPj4gKyAgICAgICAgICAgICBzdHJ1Y3QgbmV0X2JyaWRnZV92bGFuX2dy
b3VwICp2ZzsNCj4+ICsgICAgICAgICAgICAgc3RydWN0IG5ldF9icmlkZ2VfdmxhbiAqdmxhbjsN
Cj4+ICsNCj4+ICsgICAgICAgICAgICAgcmN1X3JlYWRfbG9jaygpOw0KPj4gKyAgICAgICAgICAg
ICB2ZyA9IG5icF92bGFuX2dyb3VwX3JjdShwb3J0KTsNCj4+ICsgICAgICAgICAgICAgaWYgKCF2
Zykgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgIHJjdV9yZWFkX3VubG9jaygpOw0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgIHJldHVybjsNCj4+ICsgICAgICAgICAgICAgfQ0KPj4gKw0KPj4g
KyAgICAgICAgICAgICAvKiBpdGVyYXRlIGVhY2ggdmxhbiBvZiB0aGUgcG9ydCwgZGlzYWJsZSBw
b3J0X21jYXN0X2N0eCBwZXIgdmxhbiAqLw0KPj4gKyAgICAgICAgICAgICBsaXN0X2Zvcl9lYWNo
X2VudHJ5KHZsYW4sICZ2Zy0+dmxhbl9saXN0LCB2bGlzdCkgew0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgIGlmICh2bGFuLT5wcml2X2ZsYWdzICYgQlJfVkxGTEFHX01DQVNUX0VOQUJMRUQpDQo+
DQo+U2FtZSBjb21tZW50IGFib3V0IHRoZSBmbGFnIGNoZWNrIGJlaW5nIHJhY3kuDQoNCkFDSy4N
Cg0KPg0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnJfbXVsdGljYXN0X2Rpc2Fi
bGVfcG9ydF9jdHgoJnZsYW4tPnBvcnRfbWNhc3RfY3R4KTsNCj4+ICsgICAgICAgICAgICAgfQ0K
Pj4gKyAgICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsNCj4+ICsgICAgIH0gZWxzZSB7DQo+
PiArICAgICAgICAgICAgIC8qIHVzZSB0aGUgcG9ydCdzIG11bHRpY2FzdCBjb250ZXh0IHdoZW4g
dmxhbiBzbm9vcGluZyBpcyBkaXNhYmxlZCAqLw0KPj4gKyAgICAgICAgICAgICBicl9tdWx0aWNh
c3RfZGlzYWJsZV9wb3J0X2N0eCgmcG9ydC0+bXVsdGljYXN0X2N0eCk7DQo+PiArICAgICB9DQo+
PiAgfQ0KPj4NCj4+ICBzdGF0aWMgaW50IF9fZ3JwX3NyY19kZWxldGVfbWFya2VkKHN0cnVjdCBu
ZXRfYnJpZGdlX3BvcnRfZ3JvdXAgKnBnKQ0KPj4gQEAgLTQzMDQsOSArNDM2Myw5IEBAIGludCBi
cl9tdWx0aWNhc3RfdG9nZ2xlX3ZsYW5fc25vb3Bpbmcoc3RydWN0IG5ldF9icmlkZ2UgKmJyLCBi
b29sIG9uLA0KPj4gICAgICAgICAgICAgICBfX2JyX211bHRpY2FzdF9vcGVuKCZici0+bXVsdGlj
YXN0X2N0eCk7DQo+PiAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHAsICZici0+cG9ydF9saXN0
LCBsaXN0KSB7DQo+PiAgICAgICAgICAgICAgIGlmIChvbikNCj4+IC0gICAgICAgICAgICAgICAg
ICAgICBicl9tdWx0aWNhc3RfZGlzYWJsZV9wb3J0KHApOw0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgIGJyX211bHRpY2FzdF9kaXNhYmxlX3BvcnRfY3R4KCZwLT5tdWx0aWNhc3RfY3R4KTsNCj4+
ICAgICAgICAgICAgICAgZWxzZQ0KPj4gLSAgICAgICAgICAgICAgICAgICAgIGJyX211bHRpY2Fz
dF9lbmFibGVfcG9ydChwKTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBicl9tdWx0aWNhc3Rf
ZW5hYmxlX3BvcnRfY3R4KCZwLT5tdWx0aWNhc3RfY3R4KTsNCj4+ICAgICAgIH0NCj4+DQo+PiAg
ICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHZsYW4sICZ2Zy0+dmxhbl9saXN0LCB2bGlzdCkNCg0K
DQo=

