Return-Path: <netdev+bounces-190621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6680AB7D9F
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 08:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F031865A82
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 06:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFE9295D87;
	Thu, 15 May 2025 06:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tELITqEp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D952798EC;
	Thu, 15 May 2025 06:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747289675; cv=fail; b=khxfbpW8L7ix2c23hn/nG3HzAp3uRILUywm4kJo2Q300bkc5VUZ5WF4Q8Slw6KpnQM/+h+aCS3ltm8uuD+MZ3jVxP0QnU4e8GlxtmKMbeyYHB9a1SEBZy9NxVIqyGZ1gEKnNV56NyiR//CTaOsIWTO4F1mPUBaW94BjOQzUOeY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747289675; c=relaxed/simple;
	bh=gbTFwBHYJr+NuZSDAqDu0ZSKYsVOyw+wr66ejFsxUzo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C4mTioc6r9Efbdr8FzolTfJ6Uwdw2VRDpSgwMRh91ipTENLTRUQMInFLMtqU4KrB+BQk/hXBmdQBFtxQvsbUm6ao+Vao4GChdiB9A4TEXUatFw8CwvAafsQQgDhBSfGRJ/yJVSHXPozC6LUaWKmfizcorvLnwkg9ESlhng8g2Ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tELITqEp; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tV9ewEOd6rvZq+G4V0vj+1EIwnkUVvFlkdN7JS4FYMPU4CC9POWRr6uprGTi/MkD/Hv0CaatXGB7tzZpxQvFichpL7YvffsI/iKyjpp0pkXAj3PMzmZVZBeIvcbK6Pct3pdnqfr6wqo1uKSNgbXjWwhWhYdOOZSVX8Tfla5HLG/L1TDbSLidn+YjS7FdDl+0jIb1soXSv6pPf+IOJm4jSmueBwSyhsRMCink2jORTztO4Nw3DoMYfN2GNhmieQcL5zWAF3wAnLh7sl5f+Jbjnw1lwsrxjEdnxxl4Ml10C6NMlT9EsrTdxmmJD5RJ0J1N+KHFd5Z2pZI4zQo42D6+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zNSTWdc0Q5Y8vgsNx2LStzTLFHRq/hgLlly7+tQcW4=;
 b=lOtWk7sQoGaLUuFJS/PnSQQrLnkS6KRQOCKq8huIQGklRR9lFIoQz+EJw0FnP3dJT5YN4wFwBlcJIquysoElnt+5CX2UejD4qhJpcAJVdqoLFS5YqGLKeYK+OpU5WE0sOmD1benZ4vIYnD+yZSNQE9FzbLddSLirGw2sNIrMv7xEhAEJXBP81PnyqVo9H8XAJHmYZGogzq5s4DlcejU1bgjGINS0hazitYAFUSRlAz/5BXZPdA7CzuNJT4uO9cQL3Oj3WzxK2g8D4oGb6DQhC+X56yLl871wFo2uXs/0iu44/xkbhxdWLkF6C9sFYpJAGDo+eHP5YlSS4A3vEN+/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zNSTWdc0Q5Y8vgsNx2LStzTLFHRq/hgLlly7+tQcW4=;
 b=tELITqEpSzL9IYqo+0wBQg5doQWyI9XXDsN6bkRiENSodPwm64kmdar6N0OtposLYjnRZmYBcPPh2JuuVDjGEj5zU843F1hL5TMnDaCdxFvj+CxRVg8KH7iVQFxVAbocR6v863MPhCYUwrG4hRZzBNnZ1Bg68N8PGZmLTVBPSb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 by SA1PR12MB6918.namprd12.prod.outlook.com (2603:10b6:806:24d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 06:14:30 +0000
Received: from BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527]) by BL1PR12MB5946.namprd12.prod.outlook.com
 ([fe80::dd32:e9e3:564e:a527%4]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 06:14:29 +0000
Message-ID: <bdc5c3d3-a57e-4f80-92bb-3448e80a288f@amd.com>
Date: Thu, 15 May 2025 11:44:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 09/11] net: macb: Move most of mac_config to
 mac_prepare
To: sean.anderson@linux.dev, vineeth.karumanchi@amd.com,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk
Cc: upstream@airoha.com, horms@kernel.org, hkallweit1@gmail.com,
 kory.maincent@bootlin.com, linux-kernel@vger.kernel.org,
 ansuelsmth@gmail.com, claudiu.beznea@microchip.com,
 nicolas.ferre@microchip.com
References: <20250512161013.731955-1-sean.anderson@linux.dev>
 <20250512161416.732239-1-sean.anderson@linux.dev>
 <6a8f1a28-29c0-4a8b-b3c2-d746a3b57950@amd.com>
 <e545e5c2-daeb-4cd1-b9f8-e5d28e6250c8@linux.dev>
Content-Language: en-US
From: "Karumanchi, Vineeth" <vineeth@amd.com>
In-Reply-To: <e545e5c2-daeb-4cd1-b9f8-e5d28e6250c8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0127.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::7) To BL1PR12MB5946.namprd12.prod.outlook.com
 (2603:10b6:208:399::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5946:EE_|SA1PR12MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cdcd18d-7be0-49d6-479d-08dd9377bfe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHA5b1BVRDRJeXAvQUQ4UlpUVmdYMko5aE1GQzRJSzdBaUI1UCtvemdXamhC?=
 =?utf-8?B?bXpsY3FkV05JNm5jVEZXS0pyMWdSM2RtbHRwWjNEWjFrVFpZYnpnZVpLYjUr?=
 =?utf-8?B?VG1ycUJUQVNnVUFaZjBGQm0rOEcva1cxeFlRdEs0c2lPRGxORzZtdnRCaWtn?=
 =?utf-8?B?RDZ2SnlaSXN6RUd5bGt3VWthbDAydnBaWFNpdXl5VWJjR3RUOHdLblFrUGV6?=
 =?utf-8?B?WWMwWm1oRW5vNGZmYzhoS3FnWnI1andGNElkTDN4ajBDdzV6UmtVTzUwamVs?=
 =?utf-8?B?TGhBcmVvWHJVVHl5R1JiZFZ6Qk9jN3JxbWJxNG50RXRqT09QY3gvd08yZGh6?=
 =?utf-8?B?L0lMRUloNUNWcTRvZHNzczNyc0kxODhacytPUEhoUVpRS0tleUsweE5NWWxO?=
 =?utf-8?B?cDdtU256cDc4Z3Nmd0lzRDBLbXNWT0pSYzd0V3UrUkRWdTBtTU9YQjZ5bnNF?=
 =?utf-8?B?NXZjWVJ1MFFucUtaOWNPcGNRZEFxd0RDZmpJdHIzZ2wyY2VNNVh2ZGw4NU5m?=
 =?utf-8?B?ekRtMTlUOHd5dnZ4TzhxRmRVRDdnaXVSWFZRVDNPMUxVWkRNbUdUNVdLS01X?=
 =?utf-8?B?Qk1XYnFNTkFibGNuM2VLb3pweDh5VWhGOG1QR1ZJRzJwUzlNY0oxZDhkTGRn?=
 =?utf-8?B?Ky9TQUZNa2hzUWNydWoxRmxUYXNnc1JIWmVkazQ2MW9oN0c4U0hRUDVYM1g1?=
 =?utf-8?B?dTc3QjBjUGxpR294eWlKMzJmNHZVLzZHbXZ2aEY1Q3g1WlFYamhqZ0wzaEVF?=
 =?utf-8?B?SHh6bXVGMDh4WWhHT3lmYzRvMVJWQjJYV216bTAwQTdPK3Vpa3V5RlFUWTZy?=
 =?utf-8?B?YjJsTUVjRnNURlhtcmRSZXp5ZDV2THZQYmlnaVgzb2l1QjRrMEVVWnpaVCtU?=
 =?utf-8?B?cGlCaW1IR2VQclVra25YYktwOHNhSUh1TzY3VE1ILy83TGNwQWdEWm93aE1a?=
 =?utf-8?B?c255VytyM3JhN2g1SVBzMGd6RVFMbFV2Nk5UTStZUHBXU2hrOTJ5L0c0UDVX?=
 =?utf-8?B?WkVrbUxGbzVMcWw5SnFtdFpBa0tyRmpOVSt5Z3JxeU5FYTh3ZmxHSitENlVB?=
 =?utf-8?B?ZG5vWlZwSmtaVzcva0k2b0N3QmcrNFE2YnoxYzcyQW1kaTJQck91bmlucitO?=
 =?utf-8?B?M2lzTjN4YThjR2RMSmNaQk1Wek51dG8xYVdJUmpMc2JqN0hnVngvU1k5RFR5?=
 =?utf-8?B?czB4dTc5UlVDSTJUYkV1eE5NMmlyWWdYZjVDd3JWM3FHM3RHQlZ6N0tiWlFo?=
 =?utf-8?B?QzkzUnk4cUNpY1FrcldsMnhvWUtkSDhVMnVzV2pEZGVvbjRlK0hERWE0Z2Rz?=
 =?utf-8?B?NFFYOG4yMmIvRE10QU9PTnQ2bndrdEtTZ21xTm1tTE1udHp2ZEFEcE5GdFRQ?=
 =?utf-8?B?RTM1TzQ3dy9HTk9jcHdxNktPRUQyRkJNbThjUDkzbUE2ZzNYWE03eEJDREI1?=
 =?utf-8?B?WDkwcWlISm05cFpXVmZDMWZDUHd2Rjd4RjhuQmo4cGJtdWV3Uzl5TXRGZzEr?=
 =?utf-8?B?NHcwSnMxT0dlOVVoNllwbXpHdkNELzBHUmhKc3VpLzcyektjbDVWc1lqRFAv?=
 =?utf-8?B?VUpLNWNxdFN0WjBQRjBwM2QvWG02ajJuQ1ArVXBGaUJPdGNFSlEvM3dET1BQ?=
 =?utf-8?B?dlBMNm1valZkUWFjUGxKVURJbXcyNVpxOU1QYjg0VGRNQUZ5TjhaTzVmelhN?=
 =?utf-8?B?SnhGbkVWeEp5VmgyTHNoTjQ5SDVTMWVDTkdGTHIrTnlmOTZUNmhVclhXRU94?=
 =?utf-8?B?VFRjd1h6NmNRQUhTWFZFdG9BbHdHOFdyRGEwN2RWRlRIYy9rNFNsZTM5bUhY?=
 =?utf-8?B?QXJSVXM4cnYvVWJvTDNpbjV2TXRuQUE5dXlxb3QyQm0zdU1ZMDhXMkVLRjVn?=
 =?utf-8?B?U1FyQUpFMXpHSUZZem9QYkhEKzVmNlp1WGpIQjdMSStVdEpuNUloYTJDcUg5?=
 =?utf-8?Q?XcIvT0h9i9w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OS9GaWw4aUF3dlZ1ZWdvWmlrRFRvNEtnT0wzZ2dUTzlJNzNJTDlGVWE3dlhM?=
 =?utf-8?B?QUNPSnNGQTdMMGNhVzV2dVdKcS9xMWRyOHJHZlZFdUVFMUxRVzBiSkx4RDYw?=
 =?utf-8?B?eEZHbW5UemRBT1VGUjlacVRrZUhPbnJCbTZyUmlXRzlJRVJXbHQzeXV6MExn?=
 =?utf-8?B?UmdCcWdkNVRvNG4rOENkWDI2bmk4WlJwdE5nVE1mU245VHhvRGV2VlJsOHRE?=
 =?utf-8?B?Tk5aQ1NBaCsvQjNHQjRSdmM0RkxvTmVHWWd2dWZXSTdJWHpsRTZQTGsrZkxa?=
 =?utf-8?B?R0h0ZXJHazJhdFJFcGsraWk4czZrSmVGYUVhb0ZwdGxoOFdZYmtjWTZXRHZk?=
 =?utf-8?B?enRiSlAzOG5vZUdrRW12cnR0bG93NTRrU3VoZmE1cHJYemVmWUY4Ung1YnZp?=
 =?utf-8?B?ZUhGR2laREpobVQ0QXpzT2thTG4wWU5xZ0FwSW5FOERpelhXbWlTQ25xQTB6?=
 =?utf-8?B?TWgxT3lRVkU1TVZ1WkU1L2VGb3BzRzFDMloyRTV0TGhwT3BjZ2hjTkp6N3VU?=
 =?utf-8?B?d0l5ZjJzMXdwVlJEWHFHNllDc0IvcFlDWEJCQ2lCeFpMRXZPMDRrR3ZnT3JL?=
 =?utf-8?B?cWxqZ0ZuTVBzNy9aS2VoMVFDQm0ydjlHaG5BWm1sUUxJYXMzNjc3YkNwSHd0?=
 =?utf-8?B?eGkrWEZDa2NaNm1WR1FtQjlYcDBoQXJzK0xkaHhZVFRiVGQxZStlVDVqOCtP?=
 =?utf-8?B?UGd6WlV1ZjBUWEFEQml6K3JtN0J0dFVoczNMRWRWa2NDQ0hJczlGMnpXZnRh?=
 =?utf-8?B?cXRtNVhocGQxUjhaKzNHZXRXQU0raGJTUDhjRHJVWVN0aSttamFkZVlYOGFa?=
 =?utf-8?B?YldWY3BDT291YkRrTEU0SEx6NXFXMEgwbWNKWklobXlBRDV5Yk5jZUFZL2FI?=
 =?utf-8?B?UHI1T3F0M043RE5hYndGWkhpVTVUd1FveTluYk5EYmJiSG1SOVJmaGduTUFP?=
 =?utf-8?B?TzNGd0JXNFY1TWgrSi9Bak0rZ0JrYi9qT2huZmpFKzhJNnBBZUFYRFNoZmEr?=
 =?utf-8?B?VEtkRnVYTEs4SGcwYnEvdk5vV0FXSmlsb3JDVms1eFlXRjRENHJVNmovNWRl?=
 =?utf-8?B?UUorOUZmamp5YXN0a1ZkLzYxTm1FL1NQWGt3eWZTc2xnVGdNVW4yN0RtUFBT?=
 =?utf-8?B?RXZKVnJsS1FVeWNxVGZIUUJLY2dMdnpmMFZTZkY3cXA2VUZxcktOVUo2MWlh?=
 =?utf-8?B?b2NUbHJqZXg5OHl1WVpwa1pUeU9TTXRyVWRnWFpxbEkrWk9tWTJRNmVheThT?=
 =?utf-8?B?aEVnVS93a2xYOGdYelJWQlpNZ0tFc0xqcGx1bjJHaFpkZFEwbDdXakVyM0ZC?=
 =?utf-8?B?bGZMdjNud28xRXNObWxCWTJ0dTVvanlFUE1aMWM1aWQ1L1ZmNVBLYzdicFFM?=
 =?utf-8?B?WnNPUDNWbVQ4Rk9yM01tcDJIMWpwbUlmbE1GcFM1SVNhZGNNRUQ1cmo1RUdK?=
 =?utf-8?B?MzBhbWlHR0ZaUTlkNFpJMm5QTWNTQlVSeThidXhwSEpRVjV4MVFBRHFpdFJH?=
 =?utf-8?B?Ky9nc3BZb1YvTDgyMEtyb0ErRnFLc2JQS1ZIK20rcENKTDFiQ3BsaTkzNzBk?=
 =?utf-8?B?NHV4ZXFMN1YwOFdLaHVmYVhDelM0MHcyU3U2MXJ6ZDJ0Sk9GUkFqWUxsM3U3?=
 =?utf-8?B?QUd5L0ErSUxoWGxQTFYrRWw5VGE2OU1GTSs5VnpwNlNia1dUb1VBL3VVZ3Bh?=
 =?utf-8?B?UmhRWkdYMkc3UTRnNkRWTEdaU3RuQUFoVnowWHNBeGNBeVpGY2J3SmhhZXlr?=
 =?utf-8?B?QzlRTCtXY3djS3F1aytidGhUczlTWi9vbkhWYUFpZTh5b2VtWExCb09OdE9F?=
 =?utf-8?B?M3hvMWdUdS9ObFYwZkpIazQ0Wi84QXBKaEJKdFNXS0NLNGJCTGwrYWJOZnZa?=
 =?utf-8?B?WjdoMzJKeDF5djRDaXFaY1lrRm16RzVxcnpCSkR6NWk2VGE2VS9YamhXQTA1?=
 =?utf-8?B?OXZid0YzSytDU2RxNWdpNkdNQlBJRGRiY0tEaVdwUm5yMk9rR1BmRUFGSGZx?=
 =?utf-8?B?ZnFWUlRTTkdYTGFISnZ6TU11dEFSOEx1ejhwaW1EcXlCUjltZWE2eWR3dUxz?=
 =?utf-8?B?TUkxcS9oc3pVL3RQVk04aFN5ZVBOL094Y2hYS3FHOUc1WlNrdVdvL0pYNHl0?=
 =?utf-8?Q?MabBzcCFHWf4Sz1DXuwHO22ip?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cdcd18d-7be0-49d6-479d-08dd9377bfe6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 06:14:28.9601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dy83B0v2effQQp1M1dJwl2a89AqY1418y4otC8nA0mGQ9LTmo4iy8kza6FA5RAf1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6918

Hi Sean,

On 5/13/2025 9:19 PM, Sean Anderson wrote:
> On 5/13/25 11:29, Karumanchi, Vineeth wrote:
>> Hi Sean,

<..>

>>> +    spin_lock_irqsave(&bp->lock, flags);
>>> +    old = new = gem_readl(bp, NCFGR);
>>> +    new |= GEM_BIT(SGMIIEN);
>>
>> This bit represents the AN feature, can we make it conditional to facilitate IP's with AN disabled.
> 
> To clarify, this bit enables SGMII timings for AN (as opposed to
> 1000Base-X). If you don't have AN enabled at 1G, then this bit affects
> nothing.
> 
> 1000Base-X is not currently supported by the built-in PCS. Therefore,
> this bit should be set unconditionally at 1G speeds. This patch aims to
> avoid functional changes so I have not made it conditional. Making this
> bit conditional would be appropriate for a patch adding support for
> 1000Base-X using the internal PCS.
> 

Yes, agreed.

>>> +    if (old != new) {
>>> +        changed = true;
>>> +        gem_writel(bp, NCFGR, new);
>>> +    }
>>
>> <..>
>>
>>>      static void macb_usx_pcs_get_state(struct phylink_pcs *pcs,
>>> @@ -589,45 +661,60 @@ static int macb_usx_pcs_config(struct phylink_pcs *pcs,
>>>                       bool permit_pause_to_mac)
>>>    {
>>>        struct macb *bp = container_of(pcs, struct macb, phylink_usx_pcs);
>>> +    unsigned long flags;
>>> +    bool changed;
>>> +    u16 old, new;
>>>    -    gem_writel(bp, USX_CONTROL, gem_readl(bp, USX_CONTROL) |
>>> -           GEM_BIT(SIGNAL_OK));
>>> +    spin_lock_irqsave(&bp->lock, flags);
>>> +    if (macb_pcs_config_an(bp, neg_mode, interface, advertising))
>>> +        changed = true;
>>>    -    return 0;
>>> -}
>>> +    old = new = gem_readl(bp, USX_CONTROL);
>>> +    new |= GEM_BIT(SIGNAL_OK);
>>> +    if (old != new) {
>>> +        changed = true;
>>> +        gem_writel(bp, USX_CONTROL, new);
>>> +    }
>>>    -static void macb_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
>>> -                   struct phylink_link_state *state)
>>> -{
>>> -    state->link = 0;
>>> -}
>>> +    old = new = gem_readl(bp, USX_CONTROL);
>>> +    new = GEM_BFINS(SERDES_RATE, MACB_SERDES_RATE_10G, new);
>>> +    new = GEM_BFINS(USX_CTRL_SPEED, HS_SPEED_10000M, new);
>>> +    new &= ~(GEM_BIT(TX_SCR_BYPASS) | GEM_BIT(RX_SCR_BYPASS));
>>> +    new |= GEM_BIT(TX_EN);
>>> +    if (old != new) {
>>> +        changed = true;
>>> +        gem_writel(bp, USX_CONTROL, new);
>>> +    }
>>
>> The above speed/rate configuration was moved from macb_usx_pcs_link_up() where speed is an argument, which can be leveraged to configure multiple speeds.
>>
>> Can we achieve configuring for multiple speeds from macb_usx_pcs_config() in fixed-link and phy-mode ?
> 
> Form what I can tell, the USX PCS is only used for 10G interfaces. If
> you want to add support for using it at other link speeds, then yes some
> of these register writes should be moved to link_up. For the moment it
> doesn't matter where they happen.
> 
> --Sean

Ok, in the latest cadence IP, all speed configurations are mapped to USX 
registers for both internal PCS's (1000Base-X & 10GBase-R).

-- 
🙏 vineeth


