Return-Path: <netdev+bounces-248780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 073FDD0E22D
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 08:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3469B300A1E8
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 07:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF52E309F18;
	Sun, 11 Jan 2026 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P28IRo/5"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012020.outbound.protection.outlook.com [40.107.200.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CAA3033FE
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 07:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768118189; cv=fail; b=NcyohmCysMyAcPdvKC99M1Xx3ZP0HfSpel/sL/KybnxUmuCpxMRU1UO6IbJIHysVigpUD/T2ipZ+wsiOoQDRlpDXyJij9JE9Fw20NGGQcNbkT6SUI7NSWtHzB4axXYcffH4GNnGn3NDoHkgwSmu9OAgiVwedCJe34yOAMndnIUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768118189; c=relaxed/simple;
	bh=L6fsiObp77vI93iNCE+wLSn8KpIsZmv5Uq8UHVT4doU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a/9vshIgUkYkIELgXjmt+ugP6JGzCPGowUwabbjKDV2L5IFCB+dXxnEIDRam/3an+OeoPh/FdT6erzeQhEyrmSCD3/tQP30DBl05wFeJaGcNknM9L4nb/bsn6P+FOwPNxmTUR8YSOPCnZEsp4QvVebk05uX3pVtDVsSYu+1vpw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P28IRo/5; arc=fail smtp.client-ip=40.107.200.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DOsS7+iODoh/7VHbWFps8WFZsEd6zz+HeMeLwrCfuj4tduVU9MdmMXRWLb/q+kGFtozOI/OSIvRVzA4R+FVYZq/+LuZ2YOLy236gHpqOH/DpYjkqG1o0bWaYUnah31g9itQWarranyiM4rfzXskfGJgm+AlzjMlC7wI4QoQQMdALUXTu+wZJJgeHHcOugdgbT17s+i9qB2ShHgKUsRLEDFAeLsu+RhgkHO7WbojYQ6zdDRbtDBfC8B1E3Ytx0078FWTnlSuRjJqYNkOZNRwS+2gom3w7AF91cfrBs9+413JwjQ2yt108JxVLpK+WZa0GtDf7YTOxwRNr3kiT5HnpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WUIFkqsZjJsEyKmAFeRaO4pc6dNhu1aQYyIuRs0c88=;
 b=at1o3UAuVSBtsZNkhveUDJb8YQ5T8LqL1XIuwfwER4CAMTi4LwHw5MF7h5cvILpvMyMbUyN/CwSDJ2imCJNGUGY00iTS9Ob7lYO8W3c6v/dl2u0pq2Q3qDn+D0deHbqVMJ/lPz88BWkYC9n5cwH6Ewqd299tnMxgjlr9yriaOjVFTJuP0OMmm/fMstpRg7cZw7n2KpaOtIxmUEWdTxCOBZk6TOCfb6TIO3U2co3jTm7uadCO8c5Wdr0A2ZxD/WYGMYSrgks0XbL0OvfsM+6qrqOiQywXGmmN3MAbz01uaJEahzQZQ/YZv4nGg9opu/d0AIDzcj43ZxxHsvroQtLJVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WUIFkqsZjJsEyKmAFeRaO4pc6dNhu1aQYyIuRs0c88=;
 b=P28IRo/5aORfQkVp2kZVqRMpOXsDHWe/p7+gKs8CTEc1L/dkst53sUfLF/4NMUuWe03sv3qRcPgIXRd8P6k33tjEErYWlzwTDxOFSuWpijJKlgRDD+/rPwnsFd5kiGsUjNQM4lQoDoBjU02ZtaovCMXREML/2uxaRvZ3eN6y+erWpRUNRSZse2ANfOhsR0VGRg/AcDXf1Dzc807rCPlfA80ViKO8W2Trd1HJQExABVi4b1FGdo00Qb1SOPERGVUNAr0RQf1ZFcA2E25uc9LYmb3VvWb6n9YUqCmqIKybKzZte/Jsg9oXbcY4JEwrhYCZ8/34vy/VSUU4omzeBRWClg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 by PH7PR12MB7939.namprd12.prod.outlook.com (2603:10b6:510:278::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sun, 11 Jan
 2026 07:56:23 +0000
Received: from SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b]) by SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b%4]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 07:56:22 +0000
Message-ID: <d4cde420-a577-45eb-9537-eb072a68c805@nvidia.com>
Date: Sun, 11 Jan 2026 09:56:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/7] tools: ynl: cli: improve the help and doc
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
 donald.hunter@gmail.com
References: <20260110233142.3921386-1-kuba@kernel.org>
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20260110233142.3921386-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To SA0PR12MB7003.namprd12.prod.outlook.com
 (2603:10b6:806:2c0::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7003:EE_|PH7PR12MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 56466f11-e80e-4c9d-2609-08de50e6e994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkI3SnhhaDlpVzAvVnEvNHFlS1B4S1NENCs4NVFZcmtzWXJxOExIWmdueTVx?=
 =?utf-8?B?dEhuVWJWUTN0MnkzRjdQSXk3UEMvU1V5UDZjWlRtbkJNZ1gvV0NSdlBwSDRv?=
 =?utf-8?B?QW1ma3M2b1crbG1oTmZqU0lyRmxsaEd5dFA2N01Kc0pwRHdyb3RJYlBtZ3Zu?=
 =?utf-8?B?ZExpQWx4R1JjQkR4dFplVUtUYTgxeXpJVXAzT0ZGSGQxczhqVkUvVTJFQVha?=
 =?utf-8?B?SUtkd3crcUFqSGR6eEVMMU9sLzVudjY3TGZYWVdsYW52SnMxb0sveWZaK3Ni?=
 =?utf-8?B?K0lyKzRJbzZRSzRzbjlNRUFBajEyZUZSczM3RFJyVWhjRFluL3BZc3RQUVF2?=
 =?utf-8?B?NzdETG5QM3UzQTgxRGJkUGptM3hFSjNIQndHbGV3TW5uOWRvQUtXMDRHcmli?=
 =?utf-8?B?dENudG5YaHk4WUNQR3dab1p0VXh2NmpFUU9WcW9EaXY4RkdtZ1pJS2l0TUVp?=
 =?utf-8?B?d09seVcydzZSdEQrcFkyUUNLd3laamQzZTJDYkRTYVFQWUpoUEZkckpDeVNS?=
 =?utf-8?B?ZUw1bzg3SXhoM0RLRXBlc3k1QllCMGxiaE9TU1dZdmxwRUljeVB5a3JxU3ZK?=
 =?utf-8?B?SyswcThwUS9DeG4rMUw4akZZaWNURWdLbkU0alcvdGJVUWJTZnozc0Q3dk9m?=
 =?utf-8?B?NXZENUxOYVJEUDdPVkF5dDh5OEhkM3lESkloT29VU2p4b1QwQjdjUmwxUWd2?=
 =?utf-8?B?ZkZMTXhSeUVXTXQyb3lBMS9oOW1EbytreEkzZjJwNGFyckdLN1YyVDZsanNR?=
 =?utf-8?B?MFJYT0F3UE53dkgrcDQrdUJNdVUyZFkwNTJLQUx1ekkveU82MGRST2dYSXQ0?=
 =?utf-8?B?SG9wR1NoV1hZbWkyUFZOdWpVL2NtTkJhSVFSMVB6U0JyT0ZqZ1lqdHJVbVMw?=
 =?utf-8?B?UlNXaFhqa2xIUlUyMENEMDV4aUZqeXRQRGZDYlBvYnk0Yzd6Sk9ZNnVXOWpB?=
 =?utf-8?B?L0ozbm5CWHpBQkxBTXNRUDROanY0RFlYS0tJVDNwTHJ1RjRXancxZ0NFdjN0?=
 =?utf-8?B?allac2p6Yy9NNVdlRkwzcWRXdnlwT1ZuaFl0T3VTUVEvMkVKSXNIcXQ3ZUZM?=
 =?utf-8?B?MGhldEs3R2s0RlFKRnUyeVF4SGdSNGpxa3lsU0R2ZE5VcTRtZTR6eWFHUFN3?=
 =?utf-8?B?N2dleHRzS2JqMWo0Nnl5MDUraVNQcEt3bTRDeW10SnVmM0dBZm1zdTA4MWRM?=
 =?utf-8?B?ejcvMU9TUUU1eW15M2diN3FIcWRmSVQ5WXdMQ3F2QTRSNjRlM0o2MEovcEpk?=
 =?utf-8?B?L25jWjA5UWhVSUFJYzArRmdyNGg0OUxTQTJtdkdmQjBaSlFHOWcvQ0hRQ1c5?=
 =?utf-8?B?QW1WbG9nck40L3BwV2hxUmJLSTJiYWJHaElDNlN4OEwrRUUxS1lVTFNSUWcy?=
 =?utf-8?B?V0hXZFN6VmVnMGVkYU85bU5oYjNkbmZiSk9NUnRaUHlTUDZSTmpHT2M0SnRB?=
 =?utf-8?B?SFMyWnN1QzRzZlhGeDh3SzJjQVhhWE81eURpS0lIT2JDajE0cDRlS3IrWG81?=
 =?utf-8?B?aEd3N0xpamMydEM3eHZURGNEOENBN0dWYnlZd1VpbS9tMk1IMFpUMll2eWZk?=
 =?utf-8?B?dkRvWHZzUXNnUWtybFMwcGFrWUlDbjdIZ3NqZnF3ZExCQllmTHhxRlNIT0FQ?=
 =?utf-8?B?dktzVGZyZ2NYaG42NkVMYlBacEQ3V3RtaGhGVkRsZDdteDV3LzIxTjFDemFD?=
 =?utf-8?B?L01nOE9nL2NnRTRydCtwNE5HU29wLys0VE02WjkyVWFNaUNBM090eCtSZmd6?=
 =?utf-8?B?NHZuY3h1Y0RvazFzNUZWZ1VTSUIzSFZBbW5ubnZoRGVJeGRzTW01QzZQaEpS?=
 =?utf-8?B?WDE1Vll2UW1PTk9nMjB5Z2FyeW9NTkdIRTBnVHNFa2FFWlI5WmpCVTNtNnJn?=
 =?utf-8?B?RitiYnZTM0kwT2ppVUh1VmdLTmtqZ2tnU3NCT1F6elJMeWYvOXYxTE1KWWhL?=
 =?utf-8?Q?iW/sQfXTHl80oJgOdzyYZZsWUh0eUmkg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7003.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3d1eHJzRDVUdW9JUEUxQ3NDZGh0VlVEWXl3NDJuSDdBTGIxbGdyVTVkbWhG?=
 =?utf-8?B?aFF4KzJoeTg2UklWMG4zTGY4UzB6bFdBZkFpU3JlWDRvMTNmRTJqSEJMRzVP?=
 =?utf-8?B?OHN3dVMxaU5QdTFzeFNqSG1PblVvOHB1clFyeWY0R09idWovNHdDU1FWN1dX?=
 =?utf-8?B?S2kyQUY2U2ZBOGdXL09XMUJDN2JHYSt4VnJ0cVRYTUd6M1lCenJwUlBHYkoz?=
 =?utf-8?B?ZVJBYkRDOVRrSmhzN0xhblZYYlBnSDMvdGg5OFowS2haNWVSM1FlYno5L1F4?=
 =?utf-8?B?OUJyeWprYzUycElnS2xBRkppSngwK2drT25CMmNkYmlYeGdsVktmMk93V1NT?=
 =?utf-8?B?QnNvb0QzdUVFUThidU9uZ1NmamlmT3V2a0I3b0RhQjBES0N6Q0x2bDVqMzIx?=
 =?utf-8?B?amlhM1JpLzR1QW93b1piRWEyRWx0M1czOG02MnNaa0dCa05WMGVRRXQvRkcy?=
 =?utf-8?B?bDlqSStwZUJPWWEwZU5RS214YmN1MGM2L3QyUkxPRFVPWms5U0t6ay9UbGlL?=
 =?utf-8?B?VUFkMXBOcVJPNml3dWNvSzZJREJXL3RvZHF3RC9tZElBOFhaYStreWJ5UXcx?=
 =?utf-8?B?N24zSFVHYUZkK01KSXl3dXI5NFU0aGNwZGxLR1I2R3RQNWYvaWNnVEFmTC9N?=
 =?utf-8?B?c1hzdGNMQVJoTWRaMWFYMUJiSE5GWSs2djFCdnR1REY4NUxmdFFaSkVPWTlw?=
 =?utf-8?B?UVNTYlJ6OFZORVdFV2t0L25JeVVNcmJqU0U1c0NtTXByRkYwR3FVdW15cTVH?=
 =?utf-8?B?SnpHNVdrYUhQNTMvK1hJWFhPWWw1Z2NEZ0prb3VRZjd3YzUwRzdWemllVE9l?=
 =?utf-8?B?ZUMvREllcG9GVzdaSjhCQXFSYzh6Z28rQW96V3NGdzFwQ2Z2NjQ3R2d4STh6?=
 =?utf-8?B?dWk3MkZ3bHJXWkpNUEhra1VjT1dqckxuZm5HSkh3bEV5NW92Ritvb2p6dHVk?=
 =?utf-8?B?QmlmYWRPdnlZQlFQclFMOU1vWVl3c2o0OHhVQzQwV2k1MTVSbFF5amUxaGUx?=
 =?utf-8?B?d0plR21LRjNGYzU2aFJvWFVpb2xxNzFnS2UrL0lhcjFUQThmemUwZFIzOTho?=
 =?utf-8?B?aWNPVGI1MVZTdDdzdW5sNFRhcGlIUDNaNGlxNWRUUFZKTnFhZDB4SFU4QlNi?=
 =?utf-8?B?RHJZSGdZaU9DSU52bmZWejRMMVpCQzF6SVU0eC96Ui95dHVWT1BWaTlsekM5?=
 =?utf-8?B?VVNJL0MvUFduTXE2bVB6SjVVbVhBTk1abkJKMEs0bkV5QmpyWkJaM01qNVUy?=
 =?utf-8?B?bEFPVlZIQlJtbk5PWE9sRFI2THFaZUhnMGNMemc2SS9qd3FKSkViUmplS212?=
 =?utf-8?B?Q2c3ZlA0UE5jWHE4QWdVQXFreTZtU0NiaTBhYk8rWHNhaytCYUU3NnpOSUVW?=
 =?utf-8?B?UXpHRkI1MWVjRGNxNlJPajVuSnhKMG1JRk42d3Z0VHI3Q3pzWGJwamRjeCs0?=
 =?utf-8?B?VGxFV0ljVm83NzZ2RWZ2LzlVZGE1MWNTcm43OTZIVCsraE90c2xmdXNyNWM1?=
 =?utf-8?B?TlJSY1huMzU0T2pyK3M1YWlUdUVWZmhZQStKRnFZTUk0TEtld2lWcDlhL2Zy?=
 =?utf-8?B?OU96T0JQWVVMUFM2UVhRczhrdnBGb1FibkRHNmkrTmZCU2Z4TURvQlI3MWMz?=
 =?utf-8?B?N1JTd2FMbGdmN3Q1Z0hwTUs2dmFJSU50eVFxUzdRQ3VBTlQxRnE2VDYrTWpt?=
 =?utf-8?B?ZFdoVHpERzJOeFJTeWZ2Zys0aGF2bGVLYmFOSDVxVUNTL1FNelY4UzlrVmxV?=
 =?utf-8?B?cGdySm13clVJT0hzdFVHWjNZM1FXSlh4azRzUXhEWnpzeUw1SGQ4RTJDeUpQ?=
 =?utf-8?B?NkNuS3N4b1BKTFY1V0k4MXBOZzZqVkw1N24reExDRTZwT3ZKVVpGU1A1a0xL?=
 =?utf-8?B?WFVFamFiM3ZJUTlpeWNnZlQxZEd1dStteC9UMG9SREMwcjRkbXQzd0dnS3VM?=
 =?utf-8?B?UFo4WEJTamJBNFFVMFNXc01JdzlUeTc5d2ZiOUREWUg0UC9EdjVYK1F4NTRQ?=
 =?utf-8?B?dTFIM0NEZjlrSTJZLzc0SzRWUXZtUlhjSDJmU1ZMOFV6bDFrQUJvRWpCa280?=
 =?utf-8?B?TUdMUzJMelMrVGhvNTQ5d0ltZE5qSWdiQWVYNkpBTXh4TzB3YUE5RW01YTJ2?=
 =?utf-8?B?VlBRZkszUnU2ZlV0ZTNCcXhvLy9ySnR5bmVaOFdnRVhFS2hzeitsdVhqMjVr?=
 =?utf-8?B?V2FjVGpCaXhyN0xYN05ob0UzNU1zb2V4Mm1hK0c2UzdJUUQvbFdLbVk1Y08z?=
 =?utf-8?B?Y05wMEw1MnBhSWdLQUc5Q2w4eGd5ZDBxNUw4M1p2bk1jRnZtdVRJVksrY3VM?=
 =?utf-8?Q?g78/h04QiJNey2slZ7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56466f11-e80e-4c9d-2609-08de50e6e994
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7003.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2026 07:56:22.7340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuyQg6wtcrnzrnwh6JVKNYSv5GD12DhmxJUJYBIO3Pc0yTnfnOq/w6y9BFQ5oW1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7939

On 11/01/2026 1:31, Jakub Kicinski wrote:
> I had some time on the plane to LPC, so here are improvements
> to the --help and --list-attrs handling of YNL CLI which seem
> in order given growing use of YNL as a real CLI tool.
> 
> v2:
>  - patch 2: remove unnecessary isatty() check
> v1: https://lore.kernel.org/20260109211756.3342477-1-kuba@kernel.org
> 
> Jakub Kicinski (7):
>   tools: ynl: cli: introduce formatting for attr names in --list-attrs
>   tools: ynl: cli: wrap the doc text if it's long
>   tools: ynl: cli: improve --help
>   tools: ynl: cli: add --doc as alias to --list-attrs
>   tools: ynl: cli: factor out --list-attrs / --doc handling
>   tools: ynl: cli: extract the event/notify handling in --list-attrs
>   tools: ynl: cli: print reply in combined format if possible
> 
>  tools/net/ynl/pyynl/cli.py | 207 ++++++++++++++++++++++++++-----------
>  1 file changed, 144 insertions(+), 63 deletions(-)
> 

Neat, productive flight!
Tested-by: Gal Pressman <gal@nvidia.com>

