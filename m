Return-Path: <netdev+bounces-212255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4F0B1ED8A
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 19:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BBD561F8C
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 17:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D58182D3;
	Fri,  8 Aug 2025 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rB+/c7Z/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAE2DDAD;
	Fri,  8 Aug 2025 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754672504; cv=fail; b=ZTcbOSXcOqkpUK9Gwo2UHAuVNnUgonn159MiDCYBiByKt+a1BxYcxT9QQT2dq++Az1kljJfDUpio6ZwFsb0MsduSvmGcu2P0fS6iLKLw1hEYO2iEFn/otqYjDydLDyZr88o+Rzdru6AGX7XIFZRsAvwaOmOuFsbWC23GewLBv4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754672504; c=relaxed/simple;
	bh=Y4bXS8zSYzYVvB/mT95FBwDzhOiXTVFs9LNGRBgW2yA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OywpYOI/u4suClVY7+GYyi+J0ngvmB0eloRFKsbY2/G1UIaTC71RDoa1rXyJb3aF6iGmtUpG11cxKbVDN2inAXDrxOkTbiL6sHKMLqXKlfHpKlr7gjXuEcIC80MX3DIK9hpM7Vm5bG3pWwtx5sV2SW37T6EH+o6kNwllhV33N54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rB+/c7Z/; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAShwxHgqP43f2Be7kBfDCPomDbjOeZEdeCxHfC5AoWXg+PInMT+oOd76y24VVSzR3EsnzrzbQGG1UJ8pM8x18At9SPd6vnVciRfdZRxN9cran/pdiVcXbhaaI03hpISVgudJC4kcf0c29BydOjn++9XSLXKgZHfUDn4uJKzCIOzo/HIMLLRbNKooBV3DA33y64amKdehvb2MiSXO4CcOl16NekSwJZvQ35CEnrRnLMNflH2ucWw+TzEqs/fgwCxsYBu0YnwNecL/fDuBGjthZp03cKLUb86a29N2oTUaVHz/GbYykcXqAEWqwUMlErewf9Kf0dgjN44pgVtpSUPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RhWGxmOHHgYZRWiZcFr88vZhac7FL+s21nDWEQTIMU=;
 b=fCfwq87U4/B7BL7fIu/kDJGkwqhnZ0N+fp8eDsKovxSfc+4HuC7wcIFui59lh/M+HNDvk8xqSRKMQON8iMae96FkumUubJFRMm/tQXfqbYk9vqCRA+wlxPpk5njWqXhYtrFcjfOi7ZPC8MqmraHRanykAuCGIoy58SnICmtQho1u3P16csHGLqVc6eof8NOoR3BgoZFfJDy3ww3OpMX0UFHWOENP6UGfSsx8LUBgjnYoNeoRtWq2Q7GWQpap8BiHImL3Dm2ImUcbLuiNak1WBxAHuhkvyQAq+cyOgm6KghVyYiPrekpEYO5mhJnqmQbK4OzZsDOhVtYHE+N2EutZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RhWGxmOHHgYZRWiZcFr88vZhac7FL+s21nDWEQTIMU=;
 b=rB+/c7Z/emNdQ0Ot8rEQHAt9mmfoqz7mhWXhOdKxhsWYqjU/wLn2ijH+Ux9Sigme6h5k3mdGX/fIL0n7nXYxSl46z2gMpqkr78+H7Z0lQT89cBRysxQdw8rWjITo+d8zAt9PW6Uxv8uaUB8n4g8sWPuZcWnU+FyBju302nNqEsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB8220.namprd12.prod.outlook.com (2603:10b6:8:f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 17:01:39 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 17:01:39 +0000
Message-ID: <f07d378b-faf7-4a84-80d9-935755d8196b@amd.com>
Date: Fri, 8 Aug 2025 18:01:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 08/22] cxl: Prepare memdev creation for type2
Content-Language: en-US
To: dan.j.williams@intel.com, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Ben Cheatham <benjamin.cheatham@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-9-alejandro.lucero-palau@amd.com>
 <688429e658eba_134cc7100f9@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <688429e658eba_134cc7100f9@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::9) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: fa232d48-3754-4afc-18be-08ddd69d3dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTZnZHRORDA0K0JEYTFzQW1CS1praURzbUpMbmlHL0pHNFJycUtiYU9FdDNN?=
 =?utf-8?B?TDBnam1FVnlQeEFtS21US1lBY0s0RFlBT3JlSmpvTloyTXppK0o0aHorLzBJ?=
 =?utf-8?B?cnV5SDVtenI3aW9PY0lPMDlzK0x2aVdMc3YwYUFjQlhoazJsRW1neUNoNWRl?=
 =?utf-8?B?bFhXbmQwWldNODhiOGpvMGwvT3M4M3lvU0VxNW9LTHFXYTFMc3dlcHdLTEJj?=
 =?utf-8?B?b042aHNUNVVaK0orMkx2WGZQT05RWXhRUnRSWGZFRHQyeW5JNmg0OVJEZHN4?=
 =?utf-8?B?TGF5c3BQY0pKblB5VzZGWE50RkpZejdPc094bmNYNFN3c0xRM0ZQSk52Tkc3?=
 =?utf-8?B?MWE4TVJTVkpwYVFaOUZJMWE4aG5vMnp2WEVYSTdNMEFYWTQrNnVhcFZqVC9m?=
 =?utf-8?B?Si8xYW5BRXZ2VTV0R1VRem1BdUJhVGR2M1FMaDdabVhFMGY1R2dQY2dPWERD?=
 =?utf-8?B?STZ2MFVHaURxamNKT29PLzljSmx0bmlsQURnbGVzMzZXSjBsZWxUNGtnWnpQ?=
 =?utf-8?B?cXRUVjN5aDB3aTNEMHJDdkNZS29tbG0yUGdlSWZPTDJFcFZtUGtEbFY1RUFr?=
 =?utf-8?B?SzdWeWU5ejUxV3NITEp6T2ppSCtTb3VKN04xOGZDZ0tpMlFjZFVhUm5YSThH?=
 =?utf-8?B?eTJDTkMzYnhZdFVLN1lXWk1CZmV4TzdDVEVVNVhQNzY0MjlIZkpaT2I5bmJl?=
 =?utf-8?B?RXNjWEY4TVJnd1JwTWd6L1g4a25iVFkwMUlLN2FROXFuamI3NWh4Wk9NZVEw?=
 =?utf-8?B?SHQxUS9hZ2kyekxoWkpOV1dORmJsczBxNXI4V0gxU0NnWC85SnBwU0ZsNEhE?=
 =?utf-8?B?N0JuMnk1aVd3T3JoUDFIRzdUNUlBQ2FhbVRzbjM4RlR0OHVWWVNXZGRUQ2xu?=
 =?utf-8?B?YWtkY1NpTERWVExWd3F0eklKemJldVNPOUw1MHdrczdlUzZuWVFjcXdjR01u?=
 =?utf-8?B?eE9ReFNvUnhEZ013Y1dldHgwemM1VE1sbWFsa2ltSThGby9VTWRpRlZuVkdO?=
 =?utf-8?B?ZWkxYWNEMGVvOHRMUGF1NndKTWxxemU5VVoyR3lhbDN6WHZTeUZDaW1nSFRH?=
 =?utf-8?B?dmlVT1Z5aUcvV0lWSUl4SG9vaktLM1pTZkM0bjVXenZIZ1ovdVlwaVh4SXc1?=
 =?utf-8?B?U3NrNzB1TWNFcGpzNXMwQWdBclhpWnBPTmN0VWNqTHlHdTNzckhYcU1PdFFp?=
 =?utf-8?B?WnZ1QXpOblpGc2wrczlIV3lFb3MwM0J4NGp3VHhrZy9qbUt4SjVLOHlDbXkz?=
 =?utf-8?B?SEpHM0RrK2F4YzBkQ1dSallwVHMvMjVkQm02VUZaU1FGYVR0U2hnYUxtRzNo?=
 =?utf-8?B?RzZmMERhanY5T0RxQk5PWXY0YlQ4bW51c1ZXSlM2Z0lHR3l4bVBaRXkrSnVP?=
 =?utf-8?B?Nkw2R0RwYzRqSWNrTDBzMHBzRzRFNy9CNFlTYkpaelZlK2VqVldkZWplVGMw?=
 =?utf-8?B?bko1RjgzeFZjMWt4Zzg5OGFsZUNNZm5HbUtqYmgxODNZN0Q0U1JqWnhndjdO?=
 =?utf-8?B?NGxrM0FZQktZVEdzMUtJSk5UclpvK2FiejIveUpSMnFjWG9JZGFjeUhvdCs4?=
 =?utf-8?B?VlBWRXZ1WWZWR2dZTDhEOFF1c1B6NXE4MjZrRjRySENHR1hZNkdBSERCSmMw?=
 =?utf-8?B?UE5DWlVRMmRuSk9ZMnBGblZBRHBvWFduSlJXS2dvT1Q3UlVnbndjeldkUE55?=
 =?utf-8?B?OEdqTWVzSHQ3c0YxWldZcjBrN2N3U1VvTEh1cW9LUW13YXdBMDNuMkc2YVhG?=
 =?utf-8?B?cGlOOG5PNjhCaDNkcndFUUwyUFRyT29rVkJ3cHJrd2xVbU4vMXZnbmk0QWxW?=
 =?utf-8?B?eWpleHNOUklwQTBadGVNV0dqKzlSamVkSENkQ0lUaGtRS2NVWXlHOGZDTDBW?=
 =?utf-8?B?K3dDckZOYXV6RTdGc0E5NUN0Z1M2emZGWjJjYWE3T1p1NTNwVDRZRTFsNkky?=
 =?utf-8?B?ZndwVTNBNmZDR0RIVUdKK29DUXpMb1JFY0pOeHpJODhTODVYcnpMbVZEbDNE?=
 =?utf-8?B?aldjaFg2cVNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Snlod0pjZFkyYm1Jek8xVlJmWGJiTmxNZ0FldnpiaGtoQVpNd1JQK0JCWEJu?=
 =?utf-8?B?bzhKZ0p3UVBvWGNTUkhWdlJaZEZsQlpYaG55cUNxYk44WmFSSW5KVjEyWGRa?=
 =?utf-8?B?YitaUE1lbTRKN3hkTk9pK0FhV2R2Ymc4U3VBNHdvSzRYTjRXQlhLWnp5ZXp1?=
 =?utf-8?B?YWhtaUNDdm15VnpmdkV4SFp2ZkdROWJaVGZTbEt4aXlEaUlWaUwxNnFkUGhX?=
 =?utf-8?B?Q0dUblJhVlh0TmVjZDZBZUZ4RDBhNzdNVll0djdBVG4zVjhHK2JCQUcvY1pI?=
 =?utf-8?B?WWMyUTdvbVdlVnp0ZG1uQVBsMlN3aW1FcitTM25QRXRoRkkvbnBQRkVhVjRU?=
 =?utf-8?B?Wi9xQ3F3bGwyVXRXWmdreGZ2a1EvVnA1VDV3YVNKMzBJWUVKSnNjU2UxQ2JR?=
 =?utf-8?B?N0xtNG1mTVFKZGszNWV5VkxVNEhNVWRndXp5QU0wRDhyck8wWExsU0lZOW1M?=
 =?utf-8?B?QWk0cjBSVjJPNWExcGhqd2EwUVgyVzJMZDJQc2dNNXMrc2dLcWFtTnBRcTVV?=
 =?utf-8?B?K3BFbkt6d21kanllUU42RkdVNVpHU2RJM0EvZ0d1d1AwQWZuWGpMeWpqbUNE?=
 =?utf-8?B?TWdLS1lQcFkwai9xYTg1ZUkwOCtEUzRYY2lHV0FtSHpPYXpsS2o5OFdYKy9k?=
 =?utf-8?B?QXFNZ0txTG4yV3pybXgwSmIxQzRKMjhXZ3Vmd1JMRzMzWldTejVJbHk0WEhx?=
 =?utf-8?B?Y3BqV1JsbWRLeTN0SDlmKzdtck15T0xvVEw4UURLL21FYlVCazFJRHVsUkJ2?=
 =?utf-8?B?VXdXb1B4VzZYOVViOWFxZzhKZjdxU1NIaHBxVVhaZ0IvQXNGcEFtdUR0YnVk?=
 =?utf-8?B?ZVFEMVZmNWJtYTJJV1EwU0NkNys5bGcwRkZySXFqckZKZUo0TkQ0dmt0OXpa?=
 =?utf-8?B?cTgycFVCazFsc0RrL29qWXEvaFF5MnVrVmFWTjhhZDQ1cnBlMTg1ZExPVmQ2?=
 =?utf-8?B?N3o3Wmpsb1ZLM1N0Y2VneEVkZ013WE9LMDhNOEJxUnB4eW4rRWNaaVhGYTFx?=
 =?utf-8?B?ZXFjRUd2U09qSkYrL1JpOU9lQUdYdHEwQ2IzdG1pZTNGMFdtY2xDdkdwKzZz?=
 =?utf-8?B?TWlrWWtWc21nMyt6R1hvZVA1a2VjZzlTS1VkUzRRejlaajFPTzRCeDRmSkxC?=
 =?utf-8?B?NEFnTHFaRGlmYnFvVjdya1pUWkNteWhqTlBBYnI0ZVlDMnM4Y2VjWVBWR2Nv?=
 =?utf-8?B?NFJPNmJWbG9rcWNVZW53Q2N4TWZwQm5nK3pyelVxcWFCMDROTHV0N3RjaGN5?=
 =?utf-8?B?ZzgreFJ5ai9QUTEwaWdqZkVBZ2pRMGhmUWxGei9ZdlU1ai9ZNW9ySVo2aVFP?=
 =?utf-8?B?SU95SWduZWV5TysvVDljYkRyNmxubGcxaTI3eWJoV2wzU1Z0UGo2NjZ0dFN5?=
 =?utf-8?B?bWhzUGtHWXV6UHpKWElkNXQyMkhCblBJcDFBOStnY3ZobW41ckpEVzEvUk51?=
 =?utf-8?B?T2xkckphWUVwWUJTVmlQTUlmSFZoT1pYZGpxRXhrRFdXNkh4SHlUV2NoSmhu?=
 =?utf-8?B?VzdwaDY2ZzloU3YvR0NFeDJWRGVYajdIWU5yeXlvc0FGSWtXclo0bnRoNUdH?=
 =?utf-8?B?MUk1SE1zdUs1c2hsUDJtSnlkbmJkNGNmMm9acUsyWnNPU0dUYlNpV0J6TDNG?=
 =?utf-8?B?RnRwTW9HUVM0WERtMmFISHdMNkdMby96bmFhR2xzVGFMMjBlZkdBRVZUdFBG?=
 =?utf-8?B?QWFQRTJyOXFPUzAzczRzRWtyZS85WERLallaZ2VWUEJhbVhzbldYMW5OZi9v?=
 =?utf-8?B?SUNCb2tLb0RtMlpoa0g4dWhLdWRWUFpLNlBFWi91TFN6TVJKdTFSMk5MOEpX?=
 =?utf-8?B?bEtNVUJNckdYVFcvcjRzbThuMng3WncyV3ZyU3Q3eUN4MUZlVEo4cllWM004?=
 =?utf-8?B?RGc3RnNCaGltWTBNbVN2anc2NGcwU1VkcUYxL0x2T3hXb0t4a0VZT1VHeVhq?=
 =?utf-8?B?STFtSU1iL0hEWW5LOWtDYkNPZnpQMFNKd2tjNGNIZUdyOEdweHdGdnFXRFFJ?=
 =?utf-8?B?SmxKMnFIV1ZONlRJdFVSd2IzWFhJOFdJYXVFZHZhb0k2QllabXBMUUZ1WGdm?=
 =?utf-8?B?eFZRTmpXajQ3elJxTkR3THhPdzA0VSs4eU5FK1BzQmErM1ZuS0c0QWcvaHJ2?=
 =?utf-8?Q?qebrSoOM1JTqdoyUNmPSHiNTg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa232d48-3754-4afc-18be-08ddd69d3dd5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 17:01:39.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jijv9pwbbkE/KlBdc1+a9gdO8bLV+8rIpPNdtgelOsaWMYPDgW/6dOGvmx71Bglxka2RAbrb2IFGRUyRNvXVNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8220


On 7/26/25 02:05, dan.j.williams@intel.com wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
>> creating a memdev leading to problems when obtaining cxl_memdev_state
>> references from a CXL_DEVTYPE_DEVMEM type.
>>
>> Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
>> support.
>>
>> Make devm_cxl_add_memdev accessible from a accel driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/cxl/core/memdev.c | 15 +++++++++++++--
>>   drivers/cxl/cxlmem.h      |  2 --
>>   drivers/cxl/mem.c         | 25 +++++++++++++++++++------
>>   include/cxl/cxl.h         |  2 ++
>>   4 files changed, 34 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index c73582d24dd7..f43d2aa2928e 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/idr.h>
>>   #include <linux/pci.h>
>> +#include <cxl/cxl.h>
>>   #include <cxlmem.h>
>>   #include "trace.h"
>>   #include "core.h"
>> @@ -562,9 +563,16 @@ static const struct device_type cxl_memdev_type = {
>>   	.groups = cxl_memdev_attribute_groups,
>>   };
>>   
>> +static const struct device_type cxl_accel_memdev_type = {
>> +	.name = "cxl_accel_memdev",
>> +	.release = cxl_memdev_release,
>> +	.devnode = cxl_memdev_devnode,
>> +};
>> +
>>   bool is_cxl_memdev(const struct device *dev)
>>   {
>> -	return dev->type == &cxl_memdev_type;
>> +	return (dev->type == &cxl_memdev_type ||
>> +		dev->type == &cxl_accel_memdev_type);
>>   }
>>   EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
>>   
>> @@ -689,7 +697,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>   	dev->parent = cxlds->dev;
>>   	dev->bus = &cxl_bus_type;
>>   	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>> -	dev->type = &cxl_memdev_type;
>> +	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
>> +		dev->type = &cxl_accel_memdev_type;
>> +	else
>> +		dev->type = &cxl_memdev_type;
>>   	device_set_pm_not_required(dev);
>>   	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>>   
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 9cc4337cacfb..7be51f70902a 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -88,8 +88,6 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>>   	return is_cxl_memdev(port->uport_dev);
>>   }
>>   
>> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>> -				       struct cxl_dev_state *cxlds);
>>   int devm_cxl_sanitize_setup_notifier(struct device *host,
>>   				     struct cxl_memdev *cxlmd);
>>   struct cxl_memdev_state;
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 9675243bd05b..7f39790d9d98 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -130,12 +130,18 @@ static int cxl_mem_probe(struct device *dev)
>>   	dentry = cxl_debugfs_create_dir(dev_name(dev));
>>   	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>>   
>> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>> -				    &cxl_poison_inject_fops);
>> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>> -				    &cxl_poison_clear_fops);
>> +	/*
>> +	 * Avoid poison debugfs files for Type2 devices as they rely on
>> +	 * cxl_memdev_state.
>> +	 */
> I know this already has my Reviewed-by, but this comment is going to
> annoying long term. The CXL specification has already dropped "Type2" as
> a name and Linux has already called this DEVMEM, and the comment belongs
> on a helper.
>
> Just call a new cxl_memdev_poison_enable() helper unconditionally, put
> the mds NULL check inside of it and comment on that helper:
>
> /* For CLASSMEM memory expanders enable poison injection */
> cxl_memdev_poison_enable()


Sounds good.


>
>> +	if (mds) {
>> +		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>> +			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>> +					    &cxl_poison_inject_fops);
>> +		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>> +			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>> +					    &cxl_poison_clear_fops);
>> +	}
>>   
>>   	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>>   	if (rc)
>> @@ -219,6 +225,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>   
>> +	/*
>> +	 * Avoid poison sysfs files for Type2 devices as they rely on
>> +	 * cxl_memdev_state.
>> +	 */
>> +	if (!mds)
>> +		return 0;
>> +
>>   	if (a == &dev_attr_trigger_poison_list.attr)
>>   		if (!test_bit(CXL_POISON_ENABLED_LIST,
>>   			      mds->poison.enabled_cmds))
> Same here, do not sprinle an "if (!mds)" check add a:
>
> cxl_poison_attr_visible() helper and call it unconditionally in the "if
> (a == &dev_attr_trigger_poison_list.attr)" case.


I'll do so.


Thanks


